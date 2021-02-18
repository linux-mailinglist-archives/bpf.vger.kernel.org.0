Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE16631E6E3
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 08:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhBRHWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 02:22:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48738 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231129AbhBRHSR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 02:18:17 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11I7EiS4013633;
        Wed, 17 Feb 2021 23:16:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rvdjK0CInHRosj3wQk9Ei2WGDHYG9SLCpthXxK9CGug=;
 b=j69tev4ZEMN7R4hfo6U/1pMmMPlf/F5zlPNSehux9KGXJtlphN0W4HU1UdbhepEHV3jD
 efivKStc0oBlpzcwRZ8FcdE1iz97bwj+XqxMwcPby7W+EjdXjOTSGMd1IAZV8xQnZVQr
 yUJZSMMWfBW2keLA3ElyJ4TN014LkuFj62k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36s10te9m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Feb 2021 23:16:39 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 23:16:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC4LKDX5EBS5LDf3SAHJy6kuopDurm64khEIrjSAiVd2sW3RDsH6oyXBnWbDarnbDKvw2HSP9X/ZPW/oeJF7VlpPQljYPmI8WXUFK8P02mMVY7HbnUZqU9QMonw3oSGnQesUKAzjtzZ4yb1aDydzudomLfI2jBN3yMJfN/lTiNAHBn7Jw1KAqFTfYFKGjAlJY0viWKOmTEUyxUmz7wXSCNcFGl0zWbLNLOixpKnVLgs0Thr0Q1wKPM0oMarDQO9iwbm1/rMfrETlG0WYuYrGLAHMSyjhxnzMocFFUI1ziZ6FD827uWtq6V9BTXLkavmxY6B9klNgMeCZw/DLSt2OKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvdjK0CInHRosj3wQk9Ei2WGDHYG9SLCpthXxK9CGug=;
 b=la+ZKgVyA0LO1STEh4oMk2fkiLk6AOR8WndXV6AuKL/T1m0zB7zuBDqc0uYP91/tKmoL/+Ut7B6ue+UDs4sVRyqyk52a4h8AychATwv6W5dJI9pvb8Apg0okqA6RsgVpkqbgDlyi1hBOnIF96oXKC2FZj0s3qPpl+C7kDAxTRHTQGMTW7dz0OXjRt4PTQ/buD9NAhG0eqM9dn+V5USO+9RSthqfZDffussQleMliGEQNFMCiNiOp8rDvj7bjqNXerJz2F3Bsnyz2ohLj0aR9+Zibe8HpfR2CFiI0fO+GxmpJGtOv5yEiOZ6n7K74b7vFlaT2/cd3jBx6NyzHyqL78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2998.namprd15.prod.outlook.com (2603:10b6:a03:fc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 18 Feb
 2021 07:16:33 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 07:16:33 +0000
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
Message-ID: <a9e9ed02-8791-28b1-60a8-44ea46525d17@fb.com>
Date:   Wed, 17 Feb 2021 23:16:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210216011216.3168-3-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b29a]
X-ClientProxiedBy: MWHPR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:300:ef::15) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1a82] (2620:10d:c090:400::5:b29a) by MWHPR22CA0005.namprd22.prod.outlook.com (2603:10b6:300:ef::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 07:16:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bb95ee8-9512-49d2-4f52-08d8d3dd1ef5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2998:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2998064FFBC696BFC0FA54D0D3859@BYAPR15MB2998.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbZk+7Ogf4Goj0sVq1cnDEFESv6dN+mDI2dXzZjmYOurcWpNi3W3XVWVh+U4Z2Wfig9CG7iGmUufhRG2VSgntxj9pENefp42kY5FNhS6V+nrVaiutrVEFORxcwnSYXwcx54G8Ki5XIKhkvBMvaMdQSqoymbZV2+7AU618ZYlBgfiZC9rdNA6/w0u/B2vD6hhpjnxK0BufwkhRSHj0Q0j11NQSoMcLNayYU9pptsETCyQeqc9raVQjBVc8eLmTl09M0SypoS67ey88ixmMiIjZ3LoliMQAAUXcA16bMmDBBPQbFMZ0LKHkoRnOhP4bV3pv8oAP1mlY24AAWohyhzZP9fWNHLo/QnJUhbnJaLYDRRWCff5O0jYnxI9WhvlQEsGP7TQ6SGTJvN/JddWfV4W6dK4W2t29BLgsUQhJy5ugd3J4n2/N2LO+WReo3dk78/4MAZkmKFGCLRneGXg3VvbzriSjJ3fmI04/KBjyltnBmG9FalblHTBOjyFxFTkV7g8/rKC2G+aRCfyaWOsLRXJxoU29kGNBSzuF54QJd7YalmDnzGNDPUiRXMJmBRi7LBuMUcV5YdNYihzr6GLAZ9k/+kV4Ks4vsyCjNjco/JCs4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(39860400002)(396003)(8936002)(186003)(2616005)(54906003)(36756003)(31696002)(16526019)(52116002)(66556008)(31686004)(66946007)(316002)(66476007)(5660300002)(110136005)(478600001)(53546011)(4326008)(6486002)(83380400001)(2906002)(8676002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzVKSFBZOUhjVlMxb1UzMUNWTWFoN0dCY1hpd0lSb3BkSXZCWE8vR3g2U0NX?=
 =?utf-8?B?cXVvL1V2SnlPZ2FGc05WYlMxVno5cDdYdjdPQkk4TXZzV0xtTHFjNXNHenhn?=
 =?utf-8?B?Sy9FRW1wVERCNTJZMkJReTAya1ZkM3I1K01MMnFDRkpmMXY4U2gvR3p1ZGxv?=
 =?utf-8?B?M2FXdVJUeHlOc01VeXhNdUpJR3lYbjNNTjNnZzc5OWNoYi9NREhzSklnZ3pV?=
 =?utf-8?B?WkRXUU1mcC93SlpaU1YxTUozL2VvcHVRWWEreGxySE9VQUhhSmxmdUh1Yytx?=
 =?utf-8?B?c3BsZVlKOUJlUi9CQk1pWUVZc3JFS1NQcEVRem1TLzRvdlhWN09RMEduR3hW?=
 =?utf-8?B?TnU4Ym0zNk4wNGJlbE5tQlRkeWQwTjFxbEFjc0Y2akxnK2NNZk1aYTBhL1Ra?=
 =?utf-8?B?UE5IazJ2MC8zN1VwWUNVMHB5dUFqWnNNLzc1SUNwUG9iS3RFTXEyQWprbW5q?=
 =?utf-8?B?d3BLa25vRUdLUDIxQ2ZPQmRCRnlqcXVLeGVNV01LTytrN2VTMXp1NTlWL05j?=
 =?utf-8?B?bE44NEYycDlFNFI3TmJDYndUQWNMaVRabWFYcjFSNDJ3c1U2UWNibCt6bkpi?=
 =?utf-8?B?YkhGZGk2SFdvSzY1c1NjU0wzeWRia3NGWDg1VFd6UkxXSUxQSk1qejdWd0JW?=
 =?utf-8?B?ZHR5WmwrT3NSRER1bUJEWnRmUjFjZzNtclFvUWxoeTc1R0k4c3RaUlplamR5?=
 =?utf-8?B?RVUzRlhRcmVGQmVjeTM0M0JDSWc4U2ROWkxGSVRhSCtnVTZsVHB0QmxsT1pJ?=
 =?utf-8?B?QS8yUG10VjhNNVgzVmtjK3RNdlJiY1kxSGRwMCtCYlBoT2xFREErcnJCWmdJ?=
 =?utf-8?B?c3dJUEVWdHpnNmN0YjM1N2ppWStGYTVSYmZNS2FFcFhzZ3pxYkVzUjIwMUVq?=
 =?utf-8?B?Mk12SUt0OXNUU0oyOUpRTnpiaE81VWNxTEVpU2ZnOWozdzFtWFlMRnlnT2kr?=
 =?utf-8?B?MDRpM2RYcUZnYVhrTXBjQlFicmUvNmo3bWl3K1BBSkpDdGE2R0RVQ3FwUjZ6?=
 =?utf-8?B?cHlMV3hTeE9FWThtdzBTMjZ5aDAzbFR3RHJ0OUNTRExLU29YZXQxMUc1WUVL?=
 =?utf-8?B?R2FXVFRJUmtZMU5CVXNjaS9Sa0NTUSt1d1AyMHpTbzJRbnM4MVhzUjF6NFBP?=
 =?utf-8?B?UFAwWm8xZjlWWEpLMlNYd3ZFeWJNRmxrMDQ5OHczRTdJVTFBYXZ3eVBLc1lk?=
 =?utf-8?B?TFV2VVQ4c0o2QTZYOU4zQ0FjSHoyZU9hTkNtT3NOdHJ2SUh0RDRFbU9wajU1?=
 =?utf-8?B?cnU1elZLSCs0YXBjVXlvUmJxTnhuNGpMdmlmcmR2MW53VmxGc25MYWZBNm9L?=
 =?utf-8?B?SS9PQzBKQjI1WWVLVjF1a05CWW5taGdxMi90UjR5NXVHNlZMMDBYTis5VFVC?=
 =?utf-8?B?TXhwc2QyYWoyc0dJSTVqSVBRQ1RoMzBWU2tleWI3dXJJMVlvenBBUzBhdnl6?=
 =?utf-8?B?am1ia1lFV1FMSUdqeVRTRStmNG80Q1p0ZGNwSWhaejloUXEzYUduMzlmcjdV?=
 =?utf-8?B?Smh4bXNUWDdRUUUrUVFicUx6V2M3MTM1TEMzNmxmZERnNFZmQlJheXhaT1lU?=
 =?utf-8?B?aFQvMTRQbEtJcnpaNGlVVWNaZy93akE1eEM3Zms0RmRnYXZrcW1ILy9oYjhk?=
 =?utf-8?B?MnphNldCOTl4YnhzZ1lxY1N5TVFCZ1BsS1kzWnVtZjdPRVlaTE5DWXVmWFdU?=
 =?utf-8?B?RmtzSUg2UDIyV0hWcGptSVNubzlkNG9QT0Q3Yks2TVdMZ2N3VmZhNWp6eUE3?=
 =?utf-8?B?ZjlNSWpGUFg3NkNrb1NqaDJRSThDVVNtZjBueEd1SFU1OUErUEo1UW9MSDRt?=
 =?utf-8?Q?gMAZrgL0j/jG4s9xudEggbgVc4ihbFYIIhy3o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb95ee8-9512-49d2-4f52-08d8d3dd1ef5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 07:16:33.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D+H3Kg5/hOXkofsuy5v+ZaYw0R3FiS9P9JsRrBebMPhbt7i6Hmwj8rcKz7FWmZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2998
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_03:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180058
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
[...]
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d43cc3f29dae..703988d68e73 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -178,6 +178,8 @@ enum kern_feature_id {
>   	FEAT_PROG_BIND_MAP,
>   	/* Kernel support for module BTFs */
>   	FEAT_MODULE_BTF,
> +	/* BTF_KIND_FLOAT support */
> +	FEAT_BTF_FLOAT,
>   	__FEAT_CNT,
>   };
>   
> @@ -1935,6 +1937,7 @@ static const char *btf_kind_str(const struct btf_type *t)
>   	case BTF_KIND_FUNC_PROTO: return "func_proto";
>   	case BTF_KIND_VAR: return "var";
>   	case BTF_KIND_DATASEC: return "datasec";
> +	case BTF_KIND_FLOAT: return "float";
>   	default: return "unknown";
>   	}
>   }
> @@ -2384,15 +2387,17 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
>   {
>   	bool has_func_global = kernel_supports(FEAT_BTF_GLOBAL_FUNC);
>   	bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
> +	bool has_float = kernel_supports(FEAT_BTF_FLOAT);
>   	bool has_func = kernel_supports(FEAT_BTF_FUNC);
>   
> -	return !has_func || !has_datasec || !has_func_global;
> +	return !has_func || !has_datasec || !has_func_global || !has_float;
>   }
>   
>   static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>   {
>   	bool has_func_global = kernel_supports(FEAT_BTF_GLOBAL_FUNC);
>   	bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
> +	bool has_float = kernel_supports(FEAT_BTF_FLOAT);
>   	bool has_func = kernel_supports(FEAT_BTF_FUNC);
>   	struct btf_type *t;
>   	int i, j, vlen;
> @@ -2445,6 +2450,9 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>   		} else if (!has_func_global && btf_is_func(t)) {
>   			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
>   			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
> +		} else if (!has_float && btf_is_float(t)) {
> +			/* replace FLOAT with INT */
> +			t->info = BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0);

You can replace float with a "pointer to void" type.

>   		}
>   	}
>   }
> @@ -3882,6 +3890,18 @@ static int probe_kern_btf_datasec(void)
>   					     strs, sizeof(strs)));
>   }
>   
> +static int probe_kern_btf_float(void)
> +{
> +	static const char strs[] = "\0float";
> +	__u32 types[] = {
> +		/* float */
> +		BTF_TYPE_FLOAT_ENC(1, 4),
> +	};
> +
> +	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
> +					     strs, sizeof(strs)));
> +}
> +
>   static int probe_kern_array_mmap(void)
>   {
>   	struct bpf_create_map_attr attr = {
[...]
