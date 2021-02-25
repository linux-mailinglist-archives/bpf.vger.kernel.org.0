Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C249324B16
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 08:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhBYHNg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 02:13:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233293AbhBYHML (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 02:12:11 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11P76c58018723;
        Wed, 24 Feb 2021 23:10:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hqQXYY2teKAjCk8a6PYJKX5uFzTxeMATuZXv9RccoGI=;
 b=kMGTn6uq6tt8pptCvRdRb+xaPTcux+9/BrLalsgdQGKZHfswBJv6R73Owf6XBfOVBqgT
 /niUhsSEQd6lVMYSH3ziXCn7G+mpd5lbzq9dxrgQHNyz/cI/OCVUogBhZmULPCwPmrHr
 CscxIpousF+bWcOna6ZHDUEGUfrTznbFtdQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36wnbxwxut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 23:10:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 23:10:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvM3j1BEs3C6g1eBfH2cymhxn/WYGFXd6cup0lPufUO3PegXTMqH6q8MRLXZacpKVBtWcFjzdT9lOhFanifa9nPwEVAE7PiMHIwiiXl+M0elUAAgy4dDSuWGG6XYGxrs1cZiaD4wdTEsfolk57q9TZ+Q2EavqATsEdAKoxT500jnoZ/Weziy6fiCbHG5czZItGEUyrE9IV/2/BmWYlwZAiZp13z+U736XTBv/ZcgXDw2p6T3neRji2L+/NXK78NJE5pzG1avSv0Li91J/GadqzciP2r3JxijkiWHjft8S44hubWPj1Klcxpra56+n+oQ1OVdAHJy7lSEoeAbt8/CIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqQXYY2teKAjCk8a6PYJKX5uFzTxeMATuZXv9RccoGI=;
 b=gYpTg0nHrUm65FDeEOvUlr0p17hRYME5zaE467MPCQfGJl5GoHX0O7V5Ah9yXmsfPZPEPmvs4bKh7ROHEwJkAITlNm4xusLq04u0cpOS8RIetKLa4Uk5hXfXh95na0uJCPaqa3HjSCZBeGGGiLNnJk0F0cknNCI4Xi1ocME4lGglHa8vnr3JKfa53t0D+eUfyaxm8oINfWqQctfMFNn4AbTv/1bdXCrBTaA0KeyhWJYQHwJFhPGY2l7skhlDSoHu9wVVtzW7p7m8hPQsRkdX+EWP9g6U7r5siyW2bt/VLZ887bLVcHEYrpumebivSZFkkh+ZD3sEELkOYs87S3xq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4449.namprd15.prod.outlook.com (2603:10b6:806:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 07:10:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 07:10:32 +0000
Subject: Re: [PATCH v6 bpf-next 6/9] bpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-7-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e7957fca-b938-e50d-74f5-ecc40145eb4d@fb.com>
Date:   Wed, 24 Feb 2021 23:10:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210224234535.106970-7-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:78a9]
X-ClientProxiedBy: MN2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:208:234::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:78a9) by MN2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:208:234::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 07:10:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4eedc9b-1702-455e-8402-08d8d95c7099
X-MS-TrafficTypeDiagnostic: SA1PR15MB4449:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4449B3A3684E41FFA423E8FED39E9@SA1PR15MB4449.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frsQIhmoaSthENlpejMFFu26PYGteDnTFCcGYmJrBhysTlqHoR9GI1lYsUl4iCUD2ndildjWMdSP00XsU0ShbqOJvx44E2+Ikx4+nVmTy+uy21ndHri8npblDjwrj8psTwcpYCMJi+lnLMgxzKbEywaGNsffuwCme/WgnENB0ftxEuYXtfm117FU5HZeN44L3uTIONL9VINLGcPJeTvQRAQEC523fqUiDDNSLPUXKdJhIqy27/IixRu+L12EpprSgCSmNPjGi7ZuU9AKWI/38sUtYxwLZ6Yek+Xq8AF4e13b5MJohHFkLiKraabmLGggmm1OpuNcWiG8AIAClMPi7xhuTLSPmpiBB3cmafgt920Hv9aHUHxZ11x5EiqgXy4IPcr6F08w6f/Q/O0qSVwoL5PgGO8xCyPsE3uzgKOfdHyJCDs0eYtH87cjdxjBDRa3vOTZNw+QnAwZI2a2P+0TyeX5V0oUGN22es7UJ8VWP0H8S6XmO4WdZmb1XFls5AD8+fBbzxbhrEUpuXGtt0h/wtTqxyk3zmwjLBAnvnyFmvJe3KenKgYGXglg2/KCj+HbfUnWN9iuuDNvmvgt5XThLkJ6whyS3StThnSaAJo8tvhOSqhxBTwSRJtB8OgG2T3aIYH8RfghdoauEne5ijqnkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(110136005)(8936002)(53546011)(54906003)(6666004)(31686004)(8676002)(2616005)(4326008)(86362001)(66476007)(52116002)(66946007)(66556008)(16526019)(186003)(316002)(2906002)(31696002)(83380400001)(478600001)(6486002)(36756003)(5660300002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RUdvZEhyMGtRNEk2K3hGZkJSdk9BbjhsMFFRNUNjaWI0Q1JPVnZGeE5GU2tY?=
 =?utf-8?B?eEVKMDVwRXNSYnRhVnNSVWg3RmluSWRDVGN0Z1Irem5nQ1htVExGaGo0c3E3?=
 =?utf-8?B?aGJ6UTR1MWxTNHRodUd1a1htcUJrWmZTRlBwZXk0QW1GK3hsNUJCMmdyclVy?=
 =?utf-8?B?NGFCZTM3a05pb2VhQXZ2aldFZXdiTGVUenNzY3BBeVhrbCtnbE9UY0ZCZmFn?=
 =?utf-8?B?cHh0OXphN1BJMUVkQmZhOE1NLytZYWV0aHRzTloya0loK3NxbHlBKzFYZ1ND?=
 =?utf-8?B?WEFITnRzVGE2c1A5ZDhHa3ZmY0RnTjNKaXp2Nzl0aFJXdW80dUVlejNYaTNQ?=
 =?utf-8?B?YjZXMktTbVlhQVlRRkFmY0pFWlNsSzZ3YUpPVmxQU3dIQmlyRnB3Tk9YMGxa?=
 =?utf-8?B?ZUVkKy8zTm1idUt5MmhoQXI0cHVTK3Rsd1VMYVUzbFczZW5MVzlLYmtRZDBp?=
 =?utf-8?B?NXp5Y3FIK0JQVXQ1a2s3VVZDTDVDd09Kd1IrTnY3c1QxVFBPTm5hTktWWi9H?=
 =?utf-8?B?aklKMzhhQTNBcmlJOFVkenF5c2htOFdvUlgxVlloY2Zzb25hZ0NBUHZmT1FS?=
 =?utf-8?B?YUpnek14ZTJMZmYxQ3lTTld1dExPU3hzbW9MNFlPRmdqNDNhS3Z3Zy9OVldv?=
 =?utf-8?B?REtYZGtqdmt0Si9LL2dreVlYUm1mQ21NQ21RNUpNZjRybTFaZFFVZ3puTXND?=
 =?utf-8?B?Y2JBaFRrMFR1ZDFSSFdHS2RvSFl2aldyWFgyeDMxVWNDcXZqOSsvaWI3Zkps?=
 =?utf-8?B?WlJkVmFOK0RIbWZGUXUxVlgxNis2ZUJtcEJLblZiTURUcFpKZmtHc0lsSmxQ?=
 =?utf-8?B?NXpnZXhDcTMrdzJRZk5OUDduN3lPaWpmZ3lBdEk4a1VINWhKRktTR0VJSHlR?=
 =?utf-8?B?OUs2bThvUy9ManZUZ1ltaS80cjJuUUwzSm0yUWNSaGhIcnRJZjkzNS91QXFL?=
 =?utf-8?B?ZUFVK1RLQVhFamRtM3NVbkxncXlhN3NrS1huOGlvMkJpbEZrbmloZlNncjRy?=
 =?utf-8?B?SUtGQm5pUk9UZmp2WGdBb1RnWktNUHlhTWxsYS9WTXNZRi9yd1hnQkQyOGUy?=
 =?utf-8?B?eXQ1WmFkQ0tJN1FRTEpGVjMyZXVZbkNSMVFOemx0MlFmNGFIZm8wenE4dW9a?=
 =?utf-8?B?ZzRudDh0d05iVXhmcERKT3RMSUJSUXp0NjhKZlJMZGxKRk9WbzVhV2FoL0JU?=
 =?utf-8?B?S0x6bGgrQUQ2eklGQ0FtL3JpTkhOUDQ5SklReWRqUTNYMUNyWUpmQVJvYkY0?=
 =?utf-8?B?SFlNb1l2ZUpYcEdwWVhoRmhDalRZWnZXc2g1S0NLWitxVHNnM2hhNGJSL21a?=
 =?utf-8?B?eWEvMGpPTjk1TnJQR1d5dzc5UjhLV2h3ajc5clVlV0NpL2Q0T3N1SnZlUW5i?=
 =?utf-8?B?NENTeHhjZnZVLzBkWU1ReUlndU9Ld1ZRUVY4cTVNN2FFVXZ4ZFJ2Uk1TM1Vx?=
 =?utf-8?B?OXBidVNyMU5ySGxmb1RPSXcyelhMVUc3NDE2cFhORnA2Q0VzRTdHeWpZakRp?=
 =?utf-8?B?Q052dnk5UnBCQ1l1WkJjYnN4aW1HTGhpN3o4em5iWDAreXpEMXFIanVVcjlm?=
 =?utf-8?B?N1kzZ1FnQ1FjdzBISlBNWndIRGNtWk1PRW1rdU5OampQWkpjQ1UzWnpkK1dD?=
 =?utf-8?B?cUhlWFRIczMwMmNJdmxSUTZ1L1Jibm1RRWZueDV4ekhQbDVEbFRoK2RlcHNB?=
 =?utf-8?B?Tm1PbjNEN3YwTnptaVNZQzNIbnpWK2M2YzAwdTZyN3RvQ1Z0c0lKRmlqbVYx?=
 =?utf-8?B?S2hlRjZSa0tyMng2UzQrVHZuanFKM3FiZ09nbnMyeS8rT1I5aHB4SmQwV3RD?=
 =?utf-8?Q?F1qr7/UYM6NkiEMd1S9rmY9LE7fYpXXIE70l4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eedc9b-1702-455e-8402-08d8d95c7099
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 07:10:32.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: himFC03JDTvXGcfjqVAlHBZ3NJjIjzdPRZRc7VVpXgUBFDUMk5cuGU7WI6AH+bjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4449
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_04:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250058
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/24/21 3:45 PM, Ilya Leoshkevich wrote:
> On the kernel side, introduce a new btf_kind_operations. It is
> similar to that of BTF_KIND_INT, however, it does not need to
> handle encodings and bit offsets. Do not implement printing, since
> the kernel does not know how to format floating-point values.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   kernel/bpf/btf.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 2efeb5f4b343..c405edc8e615 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -173,7 +173,7 @@
>   #define BITS_ROUNDUP_BYTES(bits) \
>   	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
>   
> -#define BTF_INFO_MASK 0x8f00ffff
> +#define BTF_INFO_MASK 0x9f00ffff
>   #define BTF_INT_MASK 0x0fffffff
>   #define BTF_TYPE_ID_VALID(type_id) ((type_id) <= BTF_MAX_TYPE)
>   #define BTF_STR_OFFSET_VALID(name_off) ((name_off) <= BTF_MAX_NAME_OFFSET)
> @@ -280,6 +280,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>   	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
>   	[BTF_KIND_VAR]		= "VAR",
>   	[BTF_KIND_DATASEC]	= "DATASEC",
> +	[BTF_KIND_FLOAT]	= "FLOAT",
>   };
>   
>   static const char *btf_type_str(const struct btf_type *t)
> @@ -574,6 +575,7 @@ static bool btf_type_has_size(const struct btf_type *t)
>   	case BTF_KIND_UNION:
>   	case BTF_KIND_ENUM:
>   	case BTF_KIND_DATASEC:
> +	case BTF_KIND_FLOAT:
>   		return true;
>   	}
>   
> @@ -1704,6 +1706,7 @@ __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
>   		case BTF_KIND_STRUCT:
>   		case BTF_KIND_UNION:
>   		case BTF_KIND_ENUM:
> +		case BTF_KIND_FLOAT:
>   			size = type->size;
>   			goto resolved;
>   
> @@ -1849,7 +1852,7 @@ static int btf_df_check_kflag_member(struct btf_verifier_env *env,
>   	return -EINVAL;
>   }
>   
> -/* Used for ptr, array and struct/union type members.
> +/* Used for ptr, array struct/union and float type members.
>    * int, enum and modifier types have their specific callback functions.
>    */
>   static int btf_generic_check_kflag_member(struct btf_verifier_env *env,
> @@ -3675,6 +3678,77 @@ static const struct btf_kind_operations datasec_ops = {
>   	.show			= btf_datasec_show,
>   };
>   
> +static s32 btf_float_check_meta(struct btf_verifier_env *env,
> +				const struct btf_type *t,
> +				u32 meta_left)
> +{
> +	if (btf_type_vlen(t)) {
> +		btf_verifier_log_type(env, t, "vlen != 0");
> +		return -EINVAL;
> +	}
> +
> +	if (btf_type_kflag(t)) {
> +		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> +		return -EINVAL;
> +	}
> +
> +	if (t->size != 2 && t->size != 4 && t->size != 8 && t->size != 12 &&
> +	    t->size != 16) {
> +		btf_verifier_log_type(env, t, "Invalid type_size");
> +		return -EINVAL;
> +	}
> +
> +	btf_verifier_log_type(env, t, NULL);
> +
> +	return 0;
> +}
> +
> +static int btf_float_check_member(struct btf_verifier_env *env,
> +				  const struct btf_type *struct_type,
> +				  const struct btf_member *member,
> +				  const struct btf_type *member_type)
> +{
> +	u64 start_offset_bytes;
> +	u64 end_offset_bytes;
> +	u64 misalign_bits;
> +	u64 align_bytes;
> +	u64 align_bits;
> +
> +	align_bytes = min_t(u64, sizeof(void *), member_type->size);

I listed the following possible (size, align) pairs:
     size     x86_32 align_bytes   x86_64 align bytes
      2        2                    2
      4        4                    4
      8        4                    8
      12       4                    8
      16       4                    8

A few observations.
   1. I don't know, just want to confirm, for double, the alignment 
could be 4 (for a member) on 32bit system, is that right?
   2. for size 12, alignment will be 8 for x86_64 system, this is 
strange, not sure whether it is true or not. Or size 12 cannot be
on x86_64 and we should error out if sizeof(void *) is 8.

> +	align_bits = align_bytes * BITS_PER_BYTE;
> +	div64_u64_rem(member->offset, align_bits, &misalign_bits);
> +	if (misalign_bits) {
> +		btf_verifier_log_member(env, struct_type, member,
> +					"Member is not properly aligned");
> +		return -EINVAL;
> +	}
> +
> +	start_offset_bytes = member->offset / BITS_PER_BYTE;
> +	end_offset_bytes = start_offset_bytes + member_type->size;
> +	if (end_offset_bytes > struct_type->size) {
> +		btf_verifier_log_member(env, struct_type, member,
> +					"Member exceeds struct_size");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void btf_float_log(struct btf_verifier_env *env,
> +			  const struct btf_type *t)
> +{
> +	btf_verifier_log(env, "size=%u", t->size);
> +}
> +
> +static const struct btf_kind_operations float_ops = {
> +	.check_meta = btf_float_check_meta,
> +	.resolve = btf_df_resolve,
> +	.check_member = btf_float_check_member,
> +	.check_kflag_member = btf_generic_check_kflag_member,
> +	.log_details = btf_float_log,
> +	.show = btf_df_show,
> +};
> +
>   static int btf_func_proto_check(struct btf_verifier_env *env,
>   				const struct btf_type *t)
>   {
> @@ -3808,6 +3882,7 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
>   	[BTF_KIND_FUNC_PROTO] = &func_proto_ops,
>   	[BTF_KIND_VAR] = &var_ops,
>   	[BTF_KIND_DATASEC] = &datasec_ops,
> +	[BTF_KIND_FLOAT] = &float_ops,
>   };
>   
>   static s32 btf_check_meta(struct btf_verifier_env *env,
> 
