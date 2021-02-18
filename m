Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0D31E6E0
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 08:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBRHVn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 02:21:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30716 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231300AbhBRHOq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 02:14:46 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11I6wLsQ005378;
        Wed, 17 Feb 2021 23:13:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yueMrT19fECJ4pfe1y6cM4or6mVWpECQGv7/RmHfoyM=;
 b=B5dIFS8yMRrYEjyh3fhvuIzu8+yz7N+2DFDq3tB0Dhv9fKoBKReSFcYxy42R/MXI0+1d
 cADqDT3btKaq6OAnaY5EcqQckogoIV41ijYhPGzd8t0jI2yz6ovvhMMd/753CQBAcIRZ
 kBPGAceG1da6K9QhtKPj7PMToMBuqKBQJ+E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36s1jge6hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Feb 2021 23:13:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 23:13:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifwctl8aG9Mqeye0ZX4NvUpKo2RCJAHH1xWsUHeZsBLAtW0RtGxBdiymvKuuZC6lD0sEgYrp34s+JeXnqo+vYpglSgkPt7qx01dVW21bqjE2JELpa59W/ydT6NspDmq0QgLDUmq+RKpeCvMXJHa+d/c0X/fkFa5De+C2pABCF1pgrC4IQgNkH4FDrA+WOnKM3qLst9Pg64gj/C5LQ/qsndCdCmVaJ/GK/kXZZbDmaAeoUu4EwX6Yf+e9VKjG/tF3ffxbebGsplW0x//wLwkC2DsyYMwxCHpTD8DraKr2eo9JXenN4v/WozIcbV1yNKxCzFqQs0/6aL6t0Kyv+LlFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yueMrT19fECJ4pfe1y6cM4or6mVWpECQGv7/RmHfoyM=;
 b=Ktnw1d2yjBQdRH03kdr8pWKGRPJ0u8ehXMSnE5QZig0EUlAN3Iizycp40VEe7wedLTs6/QJVrtNyksR0Piof15FyAXG9HLR4fWnDm4Y4+E+h2Fn7lSnx9bChVQ7qDNHtKs7QleCUAtZc4AKx6nL0SWNVDgC6uavTMzbEi2Lz+7l78H8luE6pO0LGdzNUAYyr40Z/o9Rgg56InvxBrCTe65e23epLKmFlbChMcODgTiHJqB1L5xatqtnRtNqVZkq0E2tA98RnQ6zqI5JM1qVI05148Tsh9Le5NUIBDwtmpURCmNRViXUCXeodrdyROK3OBWEjot6NtCLMe++UPrTlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2582.namprd15.prod.outlook.com (2603:10b6:a03:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 07:13:11 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 07:13:11 +0000
Subject: Re: [PATCH bpf-next 4/6] bpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
 <20210216011216.3168-5-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c2bb7d1c-c126-2fdd-6da9-9f8515f0df29@fb.com>
Date:   Wed, 17 Feb 2021 23:13:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210216011216.3168-5-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b29a]
X-ClientProxiedBy: MWHPR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:300:95::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1a82] (2620:10d:c090:400::5:b29a) by MWHPR13CA0030.namprd13.prod.outlook.com (2603:10b6:300:95::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Thu, 18 Feb 2021 07:13:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5a0db20-ce0c-42ff-255c-08d8d3dca690
X-MS-TrafficTypeDiagnostic: BYAPR15MB2582:
X-Microsoft-Antispam-PRVS: <BYAPR15MB258230C00627813997212214D3859@BYAPR15MB2582.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIDRfjB6mizgbn6pXjNxNr51Yasvyvq0MXC6urRe5MQZekzZDR3nm8VQunlEj9umTLU3qKFpt04gBNcv8Y6k5WCQpDBkUGnBm8xLzqoLnB2NtDzfuIvlll7XmkyXqQCPOGpveFd+o0IX3aRbbFy7mkrX82I1bY72cz9MkT+cYsixOSdRw5cds4vlj0PSQbhFguvkxvz+zdJhtQtAHpOpOSnonZ6nXOeCDXnyHjDibwfy0oPzS8AQuUfD9paWiz+1FWYI6gPVfJGfTx/8eraUx4+8lsxfsbwcB8Q3Xb3Ve8QkGmN3OhtBHyHGie78yCq3tjoXQIit3X+53eAkUQJO3jcWkU7FL+mbDyUD5QVPcINSSu6DVMvHzj/k6yKxQ9xveUYihCaWOv2in84M+moj1RwT2qijo2r5SsXVFz8kzlEmDCjHdNMwVfFa+HanI7H4ukXiNIZ3zmlbX0qt/bG1KmPecehxA4/4FLBZo9x7a4V0woObg3Li3ARqzq8RwFiBIMj/7p4dmJJRdOHHa7rMR3QGF//USBIr1tLSxiCAqO4eIG6KApoeJFr0vAb5IRoYH57MIgEJKCO/7GIWlJXV9KECLwpmYUQ9AhPKoS/eRzISTwmOzdl3Zf78EZB9R/6SyXbbqGD3Z0A+qk1eBmMpHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(31696002)(66556008)(8676002)(6486002)(53546011)(478600001)(66476007)(31686004)(52116002)(86362001)(66946007)(186003)(5660300002)(36756003)(8936002)(110136005)(16526019)(316002)(54906003)(4326008)(83380400001)(2616005)(2906002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OTk5K1k3aWdQUEZyckc3Q3F2eXdsUWdKeEp0YUVDcnlydDV1Y3ljS2FLbkZ0?=
 =?utf-8?B?NmRJUDlLWUp6TU1XY2xaVDJsODVEQitvSkUzS0RNVWZXNDh1MHZiTmx0Vkgy?=
 =?utf-8?B?SGFsMnE5cUh0VzFEeVNWRUZhMTBaczdnTFBqVDZuRVd2RzIxUFNtZGZuME5K?=
 =?utf-8?B?Z2xhTTRGOUozQXhML0k0WEdFemRzTE1CZXZ3YlNPbzZadk1VMS9WRkVpRkEz?=
 =?utf-8?B?eWhHaCsweXJYUTEvblFteHNzK1dnUXFFRGxxQVFRK25sdDVuTEtEMUFqNHVm?=
 =?utf-8?B?RVZZUG5tcitndkJYcEU2VmQvME53Z3E3WUdZVDFFWmk3KzVBRngwWm83MkJO?=
 =?utf-8?B?c01uWUFzcWNLTFpwNWVIQVJFeERFNmRmVUZxaEdOTWk1VlVJUThpakJGd2tY?=
 =?utf-8?B?NFEvaVcrM1Niby9FL243OERWL0taNnVpZUlTZ0s2Wk1DSjhsODlHZ2dUUzEx?=
 =?utf-8?B?S0tYM0VPV2tFc0Y3K21VU1BSc0FWcENkSTlNRTFYL2hRM2VqYlJIYTJuS0p2?=
 =?utf-8?B?SzcyRFhuOEpMaTkwV2wyRUFEYXVHMjJhVGgvZlhBdldaa3VWNm9EUEdMNGh0?=
 =?utf-8?B?WjBGeDhBNlh0Z3htZlpyNEVKT1NGQnAyZGZ0b0ZsbFcyWVNadWxvZ3VEczJt?=
 =?utf-8?B?OHc0VHJrRGdKeEh2eWdDQmlVL2hNbXNPSVdiM0NSbTFkZEhNQUZ5MVgwblIx?=
 =?utf-8?B?NlBZVmFXa2VETXhnV2pXbzJqdXBXb1BHbmtGK2doRVRkMDJoeUVheDdZMVdq?=
 =?utf-8?B?UXZ0K0VrMENmV0NnbmF2QkM1Q0ZiZ3d1eGlnazBDZ2hrSG52Zi9mdzhBM3Ex?=
 =?utf-8?B?L3ZKVmZqd0V4bUtBUThwbEpLdlNQZEdBUGlHOW5jV2hUeTVObVhseUdZTXVv?=
 =?utf-8?B?djdCemRGdzRRR3BaaXlEdGtuT0ZEQmlSU0FJZjVrN3FDMjVldS83Q1pqOWxJ?=
 =?utf-8?B?MWhqR1NDdEd4UFZCaHYxR2dqZi9Za0RTYXgwdUthdURZdmRKVTYzcFh4R0tr?=
 =?utf-8?B?Uk0yZmRjTHZJRVZmVklubG1FN2IyalNSUS92ZDgvekcrRk4vTTBlcy8vY1FB?=
 =?utf-8?B?NmRocmIzNHRObnppT25OZjFYK2pKbHVMaFBPdkdUMENaRzB5QmJuK0ZTK2Rv?=
 =?utf-8?B?dEZva0tTYXlxQ0R5cngyRXZUYlAxTTRtdStmLzdRSW5YdlBiazM4Qk9NUysw?=
 =?utf-8?B?SnNHZFZJb2JTRW5Jdm15U3E5d3dhMm9INEE0d2Q4OTk5aTIyTkp1Y29KVCsx?=
 =?utf-8?B?Ujk5aUNhWjFZREI1Wis4N2RzOXA2REI0M1NaOGc1M2JvdlhiRk9tS1NlbXZY?=
 =?utf-8?B?SEx2MVlyY21xZWNzaFdvSHV0T2hvMUVBc25jTDVxQWl0Wkw5RVExRWZKM3Fm?=
 =?utf-8?B?RDZOZG1wRndnUFZFV09zbXVBeXZVUFloeHFaZzdHVm52ditxNjhtSEVsWG1E?=
 =?utf-8?B?WGZZazYwTHRENVNtS3NERk4vK01MZFp6aE4yYUUyKzBhYzUzYURkNTF2TDVt?=
 =?utf-8?B?ZlRoWm9JRk01bzdvWUQ0cXAxSzNjb0RTeU80SE96dWtMWEFJV0ZidlcrOHlo?=
 =?utf-8?B?SFBmV3lVcWV4UkVqL0dXeWFEK1hUV2ZLQjQ4Yy9RallZVm9WeWJkSTd2Ukwx?=
 =?utf-8?B?aERQRUZKVHBoK2xNdW0wM2l3MmUrZzEvVG5OUnlNU3lyVm1tR2g2UjdmUURD?=
 =?utf-8?B?Q0dvR0JhWkRid2lsckltbW5VYXA3VElJbE1jUVNCYzVYSEMyckhaZUV6b0I3?=
 =?utf-8?B?UGRwaVdVK0dyNllBT1ozWm9obnU0RDNhSVVLZ0tBZ1Y1aTdXb0paYU5Zbm83?=
 =?utf-8?Q?5oO+IWYAjsvypqZpb9bDmGU2IKyTZmjpAOa/U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a0db20-ce0c-42ff-255c-08d8d3dca690
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 07:13:11.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGTE2su7TVOzt155btJ4io6nUdmTGQS0Dug2MjBvO2t8b9DJWHYVuU3U7LMBHWhd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2582
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_03:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180057
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/15/21 5:12 PM, Ilya Leoshkevich wrote:
> On the kernel side, introduce a new btf_kind_operations. It is
> similar to that of BTF_KIND_INT, however, it does not need to
> handle encodings and bit offsets. Do not implement printing, since
> the kernel does not know how to format floating-point values.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   kernel/bpf/btf.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 2efeb5f4b343..6c73e5484409 100644
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
> @@ -3675,6 +3678,64 @@ static const struct btf_kind_operations datasec_ops = {
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

I think we should enforce proper float size as well (2/4/8/16).

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
> +	u64 end_offset_bytes;
> +	u64 end_offset_bits;
> +	u64 offset_bits;
> +	u64 size_bits;
> +
> +	size_bits = member_type->size * BITS_PER_BYTE;
> +	offset_bits = member->offset;

float type cannot be used for bitfield, so offset here must of
a multiple of allowed alignment, i.e., min(ptr_size, member_type->size).
We should enforce here.

> +	end_offset_bits = offset_bits + size_bits;
> +	end_offset_bytes = BITS_ROUNDUP_BYTES(end_offset_bits);

There is no need to do BITS_ROUNDUP_BYTES if we enforce member->offset
as in the above.

> +
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
> @@ -3808,6 +3869,7 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
>   	[BTF_KIND_FUNC_PROTO] = &func_proto_ops,
>   	[BTF_KIND_VAR] = &var_ops,
>   	[BTF_KIND_DATASEC] = &datasec_ops,
> +	[BTF_KIND_FLOAT] = &float_ops,
>   };
>   
>   static s32 btf_check_meta(struct btf_verifier_env *env,
> 
