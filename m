Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523AD3111DE
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 21:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhBESWm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 13:22:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10368 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233445AbhBESVh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Feb 2021 13:21:37 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115K0rG7028899;
        Fri, 5 Feb 2021 12:03:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bN1FDlIl1Ruv1dZQF8AnKwQPbbQPvEJDDdD9A6jrFuI=;
 b=S55JuyllC1nq0vrwn6jI24zDAw6r2Wac9nYYN0hQ9tbMcp0VOZFTQsSBmb7ri/mHIjGz
 M2ioEHHKrpyHSQucbP7f/TCIlMWsb0MdfGlQAbzjVqHBHvB0eUjGLy6rM79sey+1K9IA
 ZLb4oeUS+IGKjyKw7HVqK3eVqohBQHZA3/E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36h2wb31cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 12:03:10 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 12:03:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byjKbdznCUCUmsnS3zPSFShgqv63tX9HpwyE/CcB3LELSyy4tDweFU/tIKcnT0qwY4jr6/Sqk3R/gzs2xLcBmnoArqqrli5sbkN+pSwYIf8r6pS51OtAWmK1bYNVAzYHXJjpxnip18IDyZqrhpaVN2KcYi6Sn3zWYABbl34LcX5WQ5ZhzOmvrqXMNskJG8ZP24GT4CTluWos17o3h9Ix37OqM9ilBiG6FFnvIUqnN6R+xxNhmiQl0Rud130m5gn6lMHBe0sv1vP3j1FRegkCHCtThQeTi/HwErMsLwXHvHtxz4AV1ow6uyw4EZB27kwBWAi5TPnk6zaUi1t27XDAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN1FDlIl1Ruv1dZQF8AnKwQPbbQPvEJDDdD9A6jrFuI=;
 b=Eff+SUnvcWecvWxlt0QB7pJX682hWTvwVATOW/XvljiMVs6EjSLNCttCqYbyxEPfXr5hGGtvoS74OEsyZbcFn/37Q+tCKoyjfHcqXBDnxkpx1+i3Ql2592jPnbcu52ekfX4KMWr8+sajHrZ0QeACtYLgT6BktTDGdUQp1kB/NAiXVGEzmRjFfQs9104YBDSejOWqPTaGyxqCWfpjX2kcY40fv0nrcLuj0AIsZ3m0jGq+pjv7EC9xzMSZguUWIxtaZPPTXM6lsK1+uXmcRjdnIlTlGnf3imihiMBO9K6idPZNDM7Te/gM4vXL4uLBsGsjf/bLJdSG5ok5NqNp9cllRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN1FDlIl1Ruv1dZQF8AnKwQPbbQPvEJDDdD9A6jrFuI=;
 b=CGRAY/gy48LTx6nwBebyNjGJk69aV+zAMIg2mWmsegE8MAoI0MDs/RNu2ovOoclKa0KhVPggkhOK1putcU9OR3UZicH8Sv0RLYbHFVo5kyqu/F54RGDLoAbXb0cqvQy2X3ikf89WIB7vtxyv9KZ/A1QKyuuPxjOEi1qQNDdJ1iE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2565.namprd15.prod.outlook.com (2603:10b6:a03:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 5 Feb
 2021 20:03:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Fri, 5 Feb 2021
 20:03:08 +0000
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <sedat.dilek@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
References: <20210204220741.GA920417@kernel.org>
 <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org>
 <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com>
 <20210205192446.GH920417@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
Date:   Fri, 5 Feb 2021 12:03:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <20210205192446.GH920417@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b8ac]
X-ClientProxiedBy: MWHPR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:301:4c::12) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11b4] (2620:10d:c090:400::5:b8ac) by MWHPR15CA0050.namprd15.prod.outlook.com (2603:10b6:301:4c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 20:03:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5af27ae-ebad-42c0-adff-08d8ca110ea3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2565EB437AEAF2C98B82BAB1D3B29@BYAPR15MB2565.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FsKqqWJACc2BL9QwhjsuumfsHKqKKyKg7eJvChuapgGAmOA+/mKPYmuWuPrTj/PQ2uH8aG3byI4QoMmzrxKorISjcp0Y9MZlkM+vI2i4aPCNNIseLuRuhJvs+OogjMjlksdsmoOlHwdZsUVQPM1Id5v8MeCGgYkEbbc250Vrki3dP41bXtNB3mP8mit0jQ6kLcT1FpSQscMkGwVDDY4j8Wpw1ZzYbrcdtv49YuLJ2byjEUMaU2zNQ+p2QUNL52IzRkzJE9kJan3UdMB7/LAMnqrrms/h7lQeB2acqKSdOLX/B/3DEMnm50FfCiFo36S2PPKSjppk1BVc7gdgxN40ziH0gI4EbdPI9cqej9i3FUXkitJ0cyPealpUF5K+We1H6Q8T/Dg6Drjdp8tgaG6BYzbdAEVJpt4lzGJQfM6W2zd1yVYIsb4+SPjVT+d2zf6vGTCokW1bYbx/h/mx8qa533oQt8pLPhQ2aWH6O3ykSAk9tvO1RL44DoYp6ruWFpS3h95lX6M2KBlocIS9cJiy7/1rVxVgf7BW2r7emqREqtt4yYL5vvqZEws1ddiupzGDrnI4E6fuuyk06NjRRXwSRbibmEMXzKTTLCHSwZaW7K4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(366004)(54906003)(316002)(478600001)(8936002)(8676002)(31696002)(66556008)(66476007)(5660300002)(2616005)(53546011)(7416002)(86362001)(31686004)(52116002)(66946007)(36756003)(6916009)(6486002)(16526019)(2906002)(186003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGJ1OHltd0dVT3o3UWpEM3o3cm9nOENISFl6dG1sRVJqcjNkS3NSdHM0R3BQ?=
 =?utf-8?B?SytMdU1KZ3p4UDZkRnJXNStYNWhJVXlyVTEzcENiNXVFbTk0TVpVUUJmWEZs?=
 =?utf-8?B?MXB5dkdLcCt6dFRHbUdUV2Fwb3VPbVBxdXNiTlZScGQ3NlpKb0diOGVPeEtY?=
 =?utf-8?B?Tys1b0hqVGRralNLSGpVYzJ6S21BMnVHN0VlNHBXSDJIR3RCY1AwSktkK1Aw?=
 =?utf-8?B?WEFsY25jOEJPUGs1RXNiZWVXT2lDbmxwVjc0VHpQd0ZnR2dkc2hPR0JIV2JW?=
 =?utf-8?B?TmFoMVNpdW5ubVhDbi9lODVRSldueVMyZnZhOXZjNWMwbzBKMkdFbUd3QUd5?=
 =?utf-8?B?cmxTNU96eDlTQVpYa3BneVF2MmRhUThrRXl0bitrT3ZWdGNjMDR2N2NXcXds?=
 =?utf-8?B?dlE4SjJPNjUzV1BvNFAwN2NvUEcwdWRhaXpZUVpnWWdNaVY1YUE3Skh3Slcr?=
 =?utf-8?B?aUFTOGs1aTN4b2FFTW54Tis0bTdBNWJ3RXlvYWVLMHNHQ2trNW1iU1E2V2FQ?=
 =?utf-8?B?OXFqZUM3bi9SendUM3ExV0x6UWxQcUV0OWJBeDdvOThtNXZiZk9vRU1oeHMw?=
 =?utf-8?B?R05iMUQzME4xQ3lyNGJlSldNK3htenpnSTVaOE9xRGNudHU4cVVPcVRYVU5u?=
 =?utf-8?B?aG5xYkQrQlV0Z0FSKy9zL0N2d096T1pZQzVZNkJMaFYwRlQ4ZlJkNlZ1Zjhz?=
 =?utf-8?B?R2ZlOFFESk05S1pldm9hUTd6U2xRdjZ3cStSTUozLzZzRGJ1VFpxT2pGK2Yz?=
 =?utf-8?B?UXlsd09MdklLQjgyOHpsV3JBVytqaHhPeE90ZlhNazhjZU16cHRUVlh0TkRT?=
 =?utf-8?B?VlIwenNhUloxNWFhbzVqakN3bGFHTFhwMTZHNEcyKzBjSDdLaDFCQlVReC9R?=
 =?utf-8?B?cXJBVURFaHlPcHpUUG53SVIvakZ1eFVTNFhQZjNubEZ2Q2c4QzJRL3hxRDFr?=
 =?utf-8?B?MWFocFd5ZndxRUczMG5HcVJQTU1VL1JCSHRRN3JvS0t2dmczd3QxRjJqVUpY?=
 =?utf-8?B?N1BzaTRadXViZUE4WXpEOG1CS05xbW84OHRsOWxFbzA5MTJKMzFEZjFYb1cw?=
 =?utf-8?B?SncwYXN6b2F1V2VQL0hzck1laUF4RzFpYWZQVkhqRkgycUxNYm9MaHlpbVN4?=
 =?utf-8?B?cEJwc3E0V1c0empWcWgwbmZNT2k3NlRBVXBuaWZ2ODFYM0d1eVZIbFBTRjdM?=
 =?utf-8?B?UnJqNkcrSkY1c1ZqVFVHRlJvY21oTWZDUTdNWi9YNUNDZHp3cElNK2p3T21Y?=
 =?utf-8?B?RlNjd1FpNDRmNDZvREtVRUFySHFDQkV4RkRlODEyYnVrQ2tHS2pTNGxtZzg1?=
 =?utf-8?B?bklYM25Oa1dmb1cwZVJ0dDV6SXp1ZDJ3ZVV4TTNVMEpZVkNvRGpwMllVa1Vp?=
 =?utf-8?B?RW4zQkp6bklZZExxMXhhWkVMVTdRajJDVUMvUnZxdUs3OXpUemZucG9ROEpH?=
 =?utf-8?B?VFl3RUNzanZ4T3h1OXh1ekVYOVRoeU5tSW5Bd0FuUU9MZFI4U0VrZVJJbHFu?=
 =?utf-8?B?WVlRVkdJeXptcUNLLzFHWXBqTVBiS1RnbDBvR0J0RkpCdkVqc0I1dHRldjQ5?=
 =?utf-8?B?SUNIQzYvMHVGS2U1MURCeXlIOHpXVUlUSVFHSWJ5Vm9nTWRGdnIvU3ZaMEJu?=
 =?utf-8?B?QitUaGpjMXBWQ2pwaWNiZUVmSDZwbjA3eUJvVnBjNFFpWjdvMUY1WXNxd1My?=
 =?utf-8?B?dnNRdVp1NEtOdXUvTVB1SlR6bERvZWQ0TVRyakdJRlgySlIrNnYxWGpINFJO?=
 =?utf-8?B?dkFrNDY2SnVkZkttSDMyb254azBRV2ZtMnFqa3VpWkNOeFl5bCtXa0dQZ3Bn?=
 =?utf-8?Q?sIMoh2O5OftII2Eb6ZGDGh0jI6UIqFaVH0xds=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af27ae-ebad-42c0-adff-08d8ca110ea3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 20:03:08.3646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AopHwESC+Oa0+bRgUUrwsB5hviVT1NZ2Nx1dG6KSVK2LoRJ3MhskwHwR7IWy+I0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2565
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_11:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/5/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
>> On 2/5/21 11:06 AM, Sedat Dilek wrote:
>>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>> Grepping through linux.git/tools I guess some BTF tools/libs need to
>>> know what BTF_INT_UNSIGNED is?
>   
>> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
>> ignore this for now until kernel infrastructure is ready.
> 
> Yeah, I thought about doing that.
> 
>> Not sure whether this information will be useful or not
>> for BTF. This needs to be discussed separately.
> 
> Maybe search for the rationale for its introduction in DWARF.

In LLVM, we have:
   uint8_t BTFEncoding;
   switch (Encoding) {
   case dwarf::DW_ATE_boolean:
     BTFEncoding = BTF::INT_BOOL;
     break;
   case dwarf::DW_ATE_signed:
   case dwarf::DW_ATE_signed_char:
     BTFEncoding = BTF::INT_SIGNED;
     break;
   case dwarf::DW_ATE_unsigned:
   case dwarf::DW_ATE_unsigned_char:
     BTFEncoding = 0;
     break;

I think DW_ATE_unsigned can be ignored in pahole since
the default encoding = 0. A simple comment is enough.

> 
> - ARnaldo
> 
