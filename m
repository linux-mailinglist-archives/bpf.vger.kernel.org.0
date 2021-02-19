Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10631F4E1
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 06:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhBSFmQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 00:42:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52486 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBSFmP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 00:42:15 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11J5ZZpQ019599;
        Thu, 18 Feb 2021 21:41:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/+09DJA1UmzFH9NH/pnDyNwHhshSC+GvuqhAH9Hc0GM=;
 b=bCIHlLf4aHSHn0XJw9IQNDDkq6/zr5sLspd475EnX8bSbRLVqgTQRdULVHbah7cd8CZu
 zKAerEAn114cJ0TY2TPJarYjI+SiviLmgi1e9WM7SjhzeNkdAmKTd1Pd4114dvz7QG3Y
 LjljAAYL2m2Creq+wbBAk+iVXEmoyGlBQ/o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36t2h7h8jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Feb 2021 21:41:16 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 21:41:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGyBrRJHIbOwgFJjfzGN8cNunzq5hQ+/yJu1I7ZZy20HpD6/mZ62sa/8A29K8OOVeYuyYHnZocZPrh0AYwZOHowMRwxpqpb1iBUNOeEdDUVWBk5xPtoGBPkhqqfFyk449mo1mL05QAxGxvrUas+cUDrWhtEahyCLx+3OZwSmADlSQFhWO+TEg4cx2DcKzvrznYK6HlZFQMUQ1JVFWbmBGMZ4jRnoCPIifaq05dYMe21rUm9u0mUtyZUhM8LBtD17WSwmuDBN5FBVJYu8779xBmr6UKbRb54QSd3IWZW6z/4rfUsR6K9oF/ajNdptmBxqzuOL7lbnpOQrTZJHBxjcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+09DJA1UmzFH9NH/pnDyNwHhshSC+GvuqhAH9Hc0GM=;
 b=Dd+W6Vr59HS9P1HmtOIesAxwt++/xD6ywHs3RMjkQ7YqnVSxXVt1oMzy3SHIcL7z2u8zzrUh0n2aCxQb2wpW7+FXCX2tR3fAcok39TI+Gt/BuHRDO69ZT2pNnq70+uas1VW2yOziIzPuSbvOJFkQUABnjN60jt3439vD+hlye0hU8aeIU9Kbc9XFfR+8f5e3hMixZEmXo03TlQVAUj/WsT+ckvQBtbdNBfUwLU9/1GOipaC53AJZ8EVJmdOsLmoEBcZS4BWpfdKGuI8ea80LGrAgx1PGmGoCkDxQ8rNezw6NAAI7ALzH/mp+zeD/o9HO4oV1zSZXKnKS8W+NZwMkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4743.namprd15.prod.outlook.com (2603:10b6:a03:37c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 19 Feb
 2021 05:41:14 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 05:41:14 +0000
Subject: Re: [PATCH v2 bpf-next 6/6] bpf: Document BTF_KIND_FLOAT in btf.rst
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
 <20210219022543.20893-7-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8e1f764e-856d-4f20-96d5-49c83f692d72@fb.com>
Date:   Thu, 18 Feb 2021 21:41:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210219022543.20893-7-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:45c1]
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::110e] (2620:10d:c090:400::5:45c1) by MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Fri, 19 Feb 2021 05:41:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5da3def-cace-4361-436b-08d8d498f85d
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4743:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB474338FB5EFC1A6038A7587AD3849@SJ0PR15MB4743.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOgTrSvjKbEwyRGhGmKcuDl0Bj/AAVx/OdiqTYt6LSEGSD063BPa9GstLxiEgQvM6BXMVpxgMXyi9MynaL1aCUzhSxdvVi3lgk06gh2UMstpdOqCJuuj1kINATdVbs+HitUmL+bvdKVdOArrmqQsnlu6ZbSRoUDEZ8mGYu+Fm3OkE82csTAF1PFIBCqhLhJ0k7k6rl2V35OJNfM/pp1Or8tz5Gi5VKnqgZEugqXYBdbEQKzd84uQ3OfEak/B1HR7JavazgvTnvSBoB3oi+KLs1BFoqU6nnQKZCxVodeNwPVoSPpKRkNrJwPt35DpCV5yMhhV5Lz/MpGMdKJ9nzWzKOMQm8B8h+LHvtP1imDIHbYVoO8IDwv+EKJkEoKyacJiixJPA7vY3axOPp6LA/val0ojgirC9qLnT2LH63XIetnj674PAhyuE6jbKZiZMxzH+KM6e6Zog5ESR+DhbYPN/X9Um/sbWbI1k89q+nqlkrN/b857rbjCQcdoNbloKn7CWvy1DeFhulXRPVG/IZ+8zJA+GDMgHzadmC4raucud++wMTSO0DIxAB97Vwvn8KlXMpzdBqcID/O2pYX7xBhbc/i4QM5t10y35Kkezz6RNVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(136003)(366004)(31686004)(8936002)(2616005)(5660300002)(186003)(110136005)(66556008)(2906002)(8676002)(52116002)(66946007)(16526019)(36756003)(316002)(83380400001)(66476007)(478600001)(53546011)(31696002)(86362001)(4326008)(6486002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzhOTkMrZk5XSXN6NThxeVB0NUxtWTBubHVocUxya1FySjlFTVhNeVlKblRP?=
 =?utf-8?B?cytzb05PaU1TKytTYm0zcWZYQUV2QldqWVkwZEs0WUQ2YVVDMzVlZFA3Szl3?=
 =?utf-8?B?S1RvT09TejdlYXR3UER3ZjlyblZRRTgxbXMxRHVTWDM5WTcxMHo1SURuOUo4?=
 =?utf-8?B?d2QyMUU2QkFqVTZSN0YrRU14d2U5VGpMUDhhQXQ2MlBsSUpuNmp3T0dlUDln?=
 =?utf-8?B?VkxrYm1Fd3JsZ3BVeGtvT1hZNW90dDZxMmdkRldpNTJnVkdoWWNFSEtWOWFQ?=
 =?utf-8?B?N0FSeDNXZnpZcWc1c3pyNlZURDl1R0Zsc0dvZGNycVFrWkZSM0MvU092U3BZ?=
 =?utf-8?B?b21SUk8zZm53M2pGaW1yS01BODd4S3psbHhhcFVsLzA1V09ZcWJGSjBRa2FM?=
 =?utf-8?B?WUtMdXZsTnRYeEV0VjlSMzF2WGU5ekFSdTdzb2dzQ2hCMkt5R2U2cjBXb3lJ?=
 =?utf-8?B?RXdub1VhajFTWXh0dkdKNzU5OTlva1VDbzdKUUtGcytvYWJJM1lPSkcrRGRh?=
 =?utf-8?B?aFpKVVNMeXJETjUvcCtMM0d6THVPNUloNGFhT1FMNDJ1VkRDWW80ejVteHJM?=
 =?utf-8?B?WjZENS9vRWhQYmw5VEp2dFhxMXJOamhmaEtzWmsxQkJVSjhSRkx0cTl3UE5F?=
 =?utf-8?B?cXB5OG1vSUhYWnhPU0cxSWFxWkl1VjJyNHVlejZDZUJ0NkhNcnBjSnNWcjdz?=
 =?utf-8?B?TUhOaHhUMmhNVzZUK1JZcWZlSWpoQ3dwMGlObGhQSXM4NU9TaTFkTWVKZkl2?=
 =?utf-8?B?djdtdEhSQ0U4eVJkMUxTa1dlcVUwdEdPWHFlZkRIT1hlanAxY2ZFK1B5YmhZ?=
 =?utf-8?B?c0tWNE5mZXVGTXJsRDhOeTNRYjZZY3lQRGw3aFRjbGR1UjRmekZtYnR3UE5Y?=
 =?utf-8?B?YVlKbldYYWcxdFdhYkZHVG1MaXpEcTVYMmNhRjA5ZG9VYnRTRC9PRGNEaldz?=
 =?utf-8?B?MlZzdDZJUFUyWSt5amxSM1hHTzMzdXI4cUcwbVZkbkFIUHMxWlN6by9udW9B?=
 =?utf-8?B?R2kzSHNaZGV6WFdWME1uSlo5OVpyYUtPVk5RclR4akNuUDlUc3lnWCtZWjFl?=
 =?utf-8?B?NS9kaVdnSzdNRUZKOHNjS0lvWWw3WVREemxJYnVya3B2QWlsR1hqS0lwVW5S?=
 =?utf-8?B?a0VYZFVjd0pCK2VudHhWWWhGZW1hS1o5d2o5SkNtejNQR2ZSc2lUQmt1T010?=
 =?utf-8?B?Um5DZ2FGZVkyTnRUcEhuVC9rZWFpVm55b09HQnk4eTJmSzcxRG5UV0ovd2p0?=
 =?utf-8?B?OHFNRTdOVExiOTJOL2psVFhBRElZWUM2T3c2U0FvWWwxUk9SN2lVbm1UVEhh?=
 =?utf-8?B?VklTdENNK2hNRWd5VmFWTks3WmxTcWFhQ01XLy8zOGN3UFpiT01LUDhTcS9O?=
 =?utf-8?B?QTdlTGpwb0h0U05XMkZHcEZ3T0JhTWJiU2ZGckpJM1NJU0Q3RWFhRklmVC9j?=
 =?utf-8?B?WlJ4SVJSSDBmY1dNditULzc0bWtUSjFmd05oUHhNaW9GNXlhTkx6NTF6YnBp?=
 =?utf-8?B?YjlGYXVaMloram0zby9ITGM4YVBiZ01OZVZFL2VIUENZTGJCTlJwUHBuUjl3?=
 =?utf-8?B?aGtjVTB0VzFIYVo3MXRydEhZbUxiOVVCRHp6THZTTjVLTnl2M0NhV0QrM1g5?=
 =?utf-8?B?YXVqN2dhVVZ5WEw1TWdQakZaQ0hWS24vWisrRnlabjhNbnIycFY3eFJXSUpz?=
 =?utf-8?B?L25VTDN6NW5IK0NRcGxmNWJuUGROM3NsRWhLNVkwNjNWUC83OWRZWmJQWTZS?=
 =?utf-8?B?LzRJblhHbzdnTFZSYWp5bW13VU1zYmx4YytrVUZDNVpmR09zZWVHVStyQWhp?=
 =?utf-8?Q?kplOngx2sH2AezX++wthIh5I4DxSZ3yAE6GC0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5da3def-cace-4361-436b-08d8d498f85d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 05:41:14.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r//w/LeBnHtZCwakZvB9L8mC/MqzKjp6HpYVWn2etX3bFJQg71j7x3jHQgSeJTO5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4743
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_01:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190042
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/18/21 6:25 PM, Ilya Leoshkevich wrote:
> Also document the expansion of the kind bitfield.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   Documentation/bpf/btf.rst | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 44dc789de2b4..4f25c992d442 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -84,6 +84,7 @@ sequentially and type id is assigned to each recognized type starting from id
>       #define BTF_KIND_FUNC_PROTO     13      /* Function Proto       */
>       #define BTF_KIND_VAR            14      /* Variable     */
>       #define BTF_KIND_DATASEC        15      /* Section      */
> +    #define BTF_KIND_FLOAT          16      /* Floating point       */
>   
>   Note that the type section encodes debug info, not just pure types.
>   ``BTF_KIND_FUNC`` is not a type, and it represents a defined subprogram.
> @@ -95,8 +96,8 @@ Each type contains the following common data::
>           /* "info" bits arrangement
>            * bits  0-15: vlen (e.g. # of struct's members)
>            * bits 16-23: unused
> -         * bits 24-27: kind (e.g. int, ptr, array...etc)
> -         * bits 28-30: unused
> +         * bits 24-28: kind (e.g. int, ptr, array...etc)
> +         * bits 29-30: unused
>            * bit     31: kind_flag, currently used by
>            *             struct, union and fwd
>            */
> @@ -452,6 +453,18 @@ map definition.
>     * ``offset``: the in-section offset of the variable
>     * ``size``: the size of the variable in bytes
>   
> +2.2.16 BTF_KIND_FLOAT
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +``struct btf_type`` encoding requirement:
> + * ``name_off``: any valid offset
> + * ``info.kind_flag``: 0
> + * ``info.kind``: BTF_KIND_FLOAT
> + * ``info.vlen``: 0
> + * ``size``: the size of the float type in bytes.

I would be good to specify the allowed size in bytes 2, multiple of 4.
currently we do not have a maximum value, maybe 128. have a float type
something like 2^10 seems strange.

> +
> +No additional type data follow ``btf_type``.
> +
>   3. BTF Kernel API
>   *****************
>   
> 
