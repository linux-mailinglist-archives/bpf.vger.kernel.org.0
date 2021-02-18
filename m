Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825AC31E69D
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 08:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhBRHCF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 02:02:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231373AbhBRG7i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 01:59:38 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11I6wMuw005438;
        Wed, 17 Feb 2021 22:58:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=IvB2Z7zCEdkNSwpqO2TWxPuAJv7acUeQFLoYFcxJXiI=;
 b=S5kYF4c9HCbrMucIRj0yl77YpiZIKqcbh4vHSj/1DiqiSS7Go4nWor7A4CgQkG1GHStf
 4b8AdzDQ/+SImsw9aZpVlKYO2OIGyTSE/smAXWiolUzzkvI2nsyVzQPjUasOjx81T3bj
 qjJSSBz9/1fYcZPqsIMDQZRQ9COn+NZzYgE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36s1jge51g-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Feb 2021 22:58:23 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 22:58:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXFumKBwqG5/w0dJix+myKeZco5aAFcfStIflwqIiZGjDzgobSJdkFrMtwDUO5enO1sVzXW/4+43ltB5028UH1v8S/TU4KnGud/21lIc9ayIwmO3/E0+Pope2xViCA154yXfR2lcw2OLYm9i9yMu8ZSVD6gJKoYQsmBBwSx70NHbMBddl14CRVFdyDLVbYuOiKKDIsYzP1dUKeIDxV7O1YOJRWkanJkNtWfFWcWoMWlZEBY7EkT0kWcwkVbWxroAibL36/YYpjjRaWja8bjQXdjQHqdAHG8X7+mH2YFM6jIaz+odXfCSSNEtsVvdcv5XWKsjaHpQ7+xU6EXcFlU7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvB2Z7zCEdkNSwpqO2TWxPuAJv7acUeQFLoYFcxJXiI=;
 b=gUNwr22iNch/WKB3jdL5eRSwJbKgmGyluDegxGd1b26MrOyscwkyMCAUdaVEX3pndnufGboqPsRZOBaK7QsO6fMV9a7zYshn1UOpPRsJuRAy7sT9Dxdccjh3P3PooYdsaTV28baESP/vlu+jhTm9IiStShaOC3rsWD5dCgPGUwbniQnrv9ab6TfiGu0Tsa2fU3Aire/Rdubkcbepnne/wpxBB0ZXnrocFXHYHSu2JbwnbcFURf8ONPeMmvLvuzRBVdrv0a4rlL40uMxeMNw0x2WGTQadmnMRl27nKiquV/NdFMZie/P+VCIIP6YmeugLRIXHmuHndLtdxwdG1xD08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2998.namprd15.prod.outlook.com (2603:10b6:a03:fc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 18 Feb
 2021 06:58:18 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 06:58:18 +0000
Subject: Re: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
 <20210216011216.3168-3-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ace21632-0292-bcde-d87b-fc3b00fc612c@fb.com>
Date:   Wed, 17 Feb 2021 22:58:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210216011216.3168-3-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b29a]
X-ClientProxiedBy: MW4PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:303:b5::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1a82] (2620:10d:c090:400::5:b29a) by MW4PR03CA0297.namprd03.prod.outlook.com (2603:10b6:303:b5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Thu, 18 Feb 2021 06:58:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2513d596-1867-4f08-da37-08d8d3da922b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2998:
X-Microsoft-Antispam-PRVS: <BYAPR15MB29983AC6A86D3A69913885FCD3859@BYAPR15MB2998.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjOHop6msHWdC+2Ee/cL5WWWuVPmpaObH+BM09mIRtOhwRtRfQMViaVhLigglxtCA+wONRqIj2jEdFnCs6JFZX9p2eJ+yMcNSHnh/L+/p2G9L3acMJWoaLjwbzfhRSMK9FAwOc5+OSP09ctaIhyEvfnDQ+U+Zmyo8SS2JnE9hOHq5Kx3Zn/199VzUCJIjRZ7MSYNfi2QIS2f5joh61KSJfuIfII0ZTEUwjLinxsNx/UN9miK6wqV0nzZHUxHALmgqf3QlYXs3/XlDkBswZFIO00d5pKc/PXsmBaR0NA8wHACT4uA+C7aeb8Qx7YYI/mdBmM5qUCV6LlpS67MWCReEjgqbAP5pNAoyDwOnV+xRlmO5jzAzCgK67D91ZE7qb/xtP0tMEZtVYIphZw11ddk0oaanlT3v/WkM8QHd+cQsoyFcg1gBGxknKCI54Hg1wf0rNWof9cqksfW5i1kAcKPP57OlsbxcHrsDungGy4+pmqZ8UruOGjoThw1kWIJIdFM0wo8Fb9sfbtzVyJGTgFKAfHxfddS4Nn3V/E4269mHWlaDWgutpjtGSocJXNdeKTnmvdCKF3vwm8Ep3PgigzRKrFrdh1JFe1gLF0VKPl0QmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(346002)(366004)(53546011)(4326008)(83380400001)(86362001)(6486002)(2906002)(8676002)(16526019)(54906003)(36756003)(31696002)(52116002)(8936002)(186003)(2616005)(110136005)(5660300002)(478600001)(66946007)(66556008)(31686004)(316002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bGYyRHFxVlFocUtzK0FnY3Zpb2dkcjMyUmNveU4rVG1SUnNtdE14QzlKM3RT?=
 =?utf-8?B?K0YxYmxabkxUYXZYenVZejNCQ1Zpc2lkWmltOVljMXRBVHJBQW1jZ0h4TGJv?=
 =?utf-8?B?ZndQdXBKS3IxRFppTlU3VVpYQUdyUU5kanc5QXl3SkhtR281ZURIVWthV25h?=
 =?utf-8?B?azFNREVjNzJja3NqdnBPTGZaNllBU3FUMHZxOHQxaFhYWGx2YWpVWnZKcXY1?=
 =?utf-8?B?ZFVPNzhYR29NS29sUUl6QWVZdkxjY0U0bCtsSm9WQkJCTHo3ZVBwQkl1ZDNl?=
 =?utf-8?B?QytqdmEwdHZnV21qdG5TVGRHU3RJL3lyaE82MFRGdmsvQXBtdFM4c0wrTHFv?=
 =?utf-8?B?R08zazlPWlBHR0JKWU9xaXNxZ2VtbWRnQVNlOVd5OVdCNWRNL3o4TXdCMlhP?=
 =?utf-8?B?aVE3VHpoRmxKVXQycHJwOFFsZmVEYTV1T3pibVRuZ1F0Y1FkdEZRb1Q0SVk2?=
 =?utf-8?B?SU9xa00yMkwxN1VIWGUveDNKcjBUQ1hjMUtXMFFQRWpmMkhXL3gydUFFOHIz?=
 =?utf-8?B?WFZpRVpCdTFLa29vRG9UaGxOSXlld2d6eEx5aGEvamsvcjJkNkRtVHAxeTJ4?=
 =?utf-8?B?cmdjdG5JR0xjbTdxYVJVL1Y4bUlvS2RselNmYnhPQmh1Q1JiM1N3RHFCekwz?=
 =?utf-8?B?ZVBtVzU4a0RTcFFKL09Ibjl4Tm14QVZzTlMzZk1zYWtMMUN6YVBoS2gxbmFG?=
 =?utf-8?B?SjFxb0U1STRySExuL0ZISmxRUFJuVndPb1NTbnpDUE1HTkp4b1pJTlF2UEhM?=
 =?utf-8?B?NWI4Z2pERVlCTTFYU2pGazlhVXJPZVlLNHRQZThPaU9iMEJMQnV1Y2RNaFY5?=
 =?utf-8?B?WEtsbTB2Sk1nNHFYTGNodTJaZnBQZzQrOXpXeWhYNjRXRVJxRlYvTjVIZExm?=
 =?utf-8?B?ckhlQ0l4ZFRxVEE3bElvVDdoRzZxU2FYei9HSldpMjMvbE9wV09uTFdLelcy?=
 =?utf-8?B?QXEyZ01ld2w3UXdiKzNiSHE3czhxT0c3S1AvZHdDWTRZNmQ5Qk50Sml5ME1Z?=
 =?utf-8?B?Vis4Qk9ldlk4Rjk3Y1NkbTRIQVVMb2xkcStkRm5oSDd3NU53cmVJN2ZDaDdr?=
 =?utf-8?B?eEhab2lHeW55Nm9xc3dzYzJTVC96Q2tVUzdhRUl5M3FYVTdQaWwvRzdrc3My?=
 =?utf-8?B?NnRFYWlVSzQ0bWx5cE54WlFHRFZkcVg3QmU1NjdmL3ZIVXorcjk3eVMvWDRZ?=
 =?utf-8?B?bHhLMWFLU0lFOE9UZUNBSXFmMk1aS1dITlRreElWbjd1TXpmbFJSZ3Y4YmRz?=
 =?utf-8?B?alY4bEU5TTIwaHowVEZteko5aXdlbWo1TW1DOXQwU2hodEdwZWFyek91NmJJ?=
 =?utf-8?B?NXhuYy9hdEJlOXY5dEtGRTROM3dnNS9KQVh4Sng5MW1zaDFSempTcS85QURD?=
 =?utf-8?B?ekJvUUhPQVF6cE1ISzJDZEg0K0pjYWZhUk9TcDV5b1Z5aXdOeFhoaWs1TXJH?=
 =?utf-8?B?MEdqM0ZCemQ2ZE9XYTN5Y2dLRTg5Y3pQRk1vbFp6ZVphdHBxeXdXQ2s4Vzc2?=
 =?utf-8?B?MVgrWVRDR3VOR3JvbElJL0NENVNTMXE4clNhbHhwVHpsL1gwY29tRzdMdmhj?=
 =?utf-8?B?THRoZTVKeHBWOGY5cTZja0ozZ3dnOGhreWZKWUN4WVpXT2F0SURpc3p3cDd4?=
 =?utf-8?B?MFpmNloveTRHTFlOMG9ZR1QwZDlPRnVEQVBMSXhOZm5ucUFhVG5rY3BubU5a?=
 =?utf-8?B?Q0VRZDBqRW1qQUtlQ1YrL1QrVGhVbm9FUmxMbVpOY0FzWnE4TGJodkNvdkRP?=
 =?utf-8?B?WHZvMzk2VDhqTWxKa3p3U1NGTFFVbWovWjgxZFdYWEowQVZJTmZkWmN2OW1t?=
 =?utf-8?B?OTYwc0hwNHd1S0g3M3QyZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2513d596-1867-4f08-da37-08d8d3da922b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:58:18.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rHChQb4supUmp+tBcBEDkIiXbX3cl3oCiMS2jCXPdEADFUVFkG3zT4k7BhGWCrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2998
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_03:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180057
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/15/21 5:12 PM, Ilya Leoshkevich wrote:
> The logic follows that of BTF_KIND_INT most of the time. Sanitization
> replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on older
> kernels.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/lib/bpf/btf.c             | 44 +++++++++++++++++++++++++++++++++
>   tools/lib/bpf/btf.h             |  8 ++++++
>   tools/lib/bpf/btf_dump.c        |  4 +++
>   tools/lib/bpf/libbpf.c          | 29 +++++++++++++++++++++-
>   tools/lib/bpf/libbpf.map        |  5 ++++
>   tools/lib/bpf/libbpf_internal.h |  2 ++
>   6 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index d9c10830d749..07a30e98c3de 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -291,6 +291,7 @@ static int btf_type_size(const struct btf_type *t)
>   	case BTF_KIND_PTR:
>   	case BTF_KIND_TYPEDEF:
>   	case BTF_KIND_FUNC:
> +	case BTF_KIND_FLOAT:
>   		return base_size;
>   	case BTF_KIND_INT:
>   		return base_size + sizeof(__u32);
> @@ -338,6 +339,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
>   	case BTF_KIND_PTR:
>   	case BTF_KIND_TYPEDEF:
>   	case BTF_KIND_FUNC:
> +	case BTF_KIND_FLOAT:
>   		return 0;
>   	case BTF_KIND_INT:
>   		*(__u32 *)(t + 1) = bswap_32(*(__u32 *)(t + 1));
> @@ -578,6 +580,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
>   		case BTF_KIND_UNION:
>   		case BTF_KIND_ENUM:
>   		case BTF_KIND_DATASEC:
> +		case BTF_KIND_FLOAT:
>   			size = t->size;
>   			goto done;
>   		case BTF_KIND_PTR:
> @@ -621,6 +624,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
>   	switch (kind) {
>   	case BTF_KIND_INT:
>   	case BTF_KIND_ENUM:
> +	case BTF_KIND_FLOAT:
>   		return min(btf_ptr_sz(btf), (size_t)t->size);
>   	case BTF_KIND_PTR:
>   		return btf_ptr_sz(btf);
> @@ -2373,6 +2377,42 @@ int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz)
>   	return btf_commit_type(btf, sz);
>   }
>   
> +/*
> + * Append new BTF_KIND_FLOAT type with:
> + *   - *name* - non-empty, non-NULL type name;
> + *   - *sz* - size of the type, in bytes;
> + * Returns:
> + *   - >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_float(struct btf *btf, const char *name, size_t byte_sz)
> +{
> +	struct btf_type *t;
> +	int sz, name_off;
> +
> +	/* non-empty name */
> +	if (!name || !name[0])
> +		return -EINVAL;

Do we want to ensure byte_sz to be 2/4/8/16?
Currently, the int type supports 1/2/4/8/16.

In LLVM, the following are supported float types:

   case BuiltinType::Half:
   case BuiltinType::Float:
   case BuiltinType::LongDouble:
   case BuiltinType::Float16:
   case BuiltinType::BFloat16:
   case BuiltinType::Float128:
   case BuiltinType::Double:


> +
> +	if (btf_ensure_modifiable(btf))
> +		return -ENOMEM;
> +
> +	sz = sizeof(struct btf_type);
> +	t = btf_add_type_mem(btf, sz);
> +	if (!t)
> +		return -ENOMEM;
> +
> +	name_off = btf__add_str(btf, name);
> +	if (name_off < 0)
> +		return name_off;
> +
> +	t->name_off = name_off;
> +	t->info = btf_type_info(BTF_KIND_FLOAT, 0, 0);
> +	t->size = byte_sz;
> +
> +	return btf_commit_type(btf, sz);
> +}
> +
[...]
