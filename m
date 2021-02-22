Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612F9320FD0
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 04:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBVDmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Feb 2021 22:42:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhBVDmH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Feb 2021 22:42:07 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11M3PNJ2000916;
        Sun, 21 Feb 2021 19:41:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MVh94QC9Z7ZOba6jCe7LHiSo2A2HAISUEVsUM583lLA=;
 b=ljrtyBTUakPjuvod7oJfYWxCGQM/ZJ6aoEe4GKefT6CqjFRMUfqZJT5Ta1U5NOp8hBfT
 gnn/jTn5OqkV5TG3aa9L4arbTyZh0Pswx0Ek8dZnxmA7eL6NSeV/ww+2sHIzE0AdGi8F
 C6kqAwmaVxH8Zjhi/qK/dm9XZfaDCyBDxuc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36ujy7awes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 21 Feb 2021 19:41:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 21 Feb 2021 19:41:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ5lsMjDlOKrf9BNLm8D67sdvnYAqsEhJCTGnkOVHdsUKWQiw6TAX5dH1ci60BPmZHjgmgsfa+nRy0QjzGg/FnUpQC/v1HoZ330hy79gP73qVLyAuE28/EIGLLS9xrc67HofJep1BrHoj8O+bzqL0UjX41/nxQ4nTgkqGY+i+HhR8wsjI/Mg4j5MNEvnHbDpv99RVyExJgh6pAcOYT/w0cFr7UImXLXCWh3I+5YUeDZvh/ZXJd/qsDHj+XEKZKBk5wu6L8tarBQ1rC0x0vkr8icLo19eVBn9v0j5XzYtm5PrjHNVuR/voMYLrExgIdxJq29zUubnUS3la9HAtENTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVh94QC9Z7ZOba6jCe7LHiSo2A2HAISUEVsUM583lLA=;
 b=VGcofElpYTx/9nZ5nfHyP9r4LLWNvoeo+HO3Ivw8H/gdwQWQYKWNeh7Wg8ihKx0aPBrNDStJcj2Goa/zkZToen7ip87Lpkro+LnfC/MJLXCjF3IL6HbtN8zURWvQ16TG3/ddlplBNWwossfwguG9dOBiqfZzh1vmx1PANO+fyOHJis60dbO+QqeKWxciPHqz+SMnqx9YaMrDet1uU3FVmWI3tqE+zFfykBUZYi9os9dkwWUWjvu4bHhFrtXSnzKcpKVA329zaF/B3irlD9P/BO4zcu/YbvSYXtWl42IoVeu2VuTlWeMVhSj49ZHboTW65OD1ew0SgwsSM8vVR7ac8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR15MB1227.namprd15.prod.outlook.com (2603:10b6:3:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 03:41:08 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3%3]) with mapi id 15.20.3846.042; Mon, 22 Feb 2021
 03:41:08 +0000
Subject: Re: [PATCH v3 bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210220034959.27006-1-iii@linux.ibm.com>
 <20210220034959.27006-3-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b310c684-a436-0fed-cf62-b8c5572f2939@fb.com>
Date:   Sun, 21 Feb 2021 19:41:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210220034959.27006-3-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4afa]
X-ClientProxiedBy: MWHPR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:300:13d::15) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:4afa) by MWHPR20CA0005.namprd20.prod.outlook.com (2603:10b6:300:13d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 03:41:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3f49e93-da2b-4373-f27a-08d8d6e3b05e
X-MS-TrafficTypeDiagnostic: DM5PR15MB1227:
X-Microsoft-Antispam-PRVS: <DM5PR15MB1227DA99248464B1F21BE26DD3819@DM5PR15MB1227.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVeosnIPyj4BO4zAoc+Uk6m0c+0Z3YQrHVKHspxzthNzGUnv80wliRz9E4hsBMK5HLj3OThtApnBX4zBE3o3aUV972d+T/E1G3xwFP5XWx9Touza2h/HtdwpZ9omra+mQDvRnAOB3SFRnvpx+2jXriOaFLK2OgB+IVCNuUMbY9sM8VJJ1vyGSW1HTQAIPo8pvxGm5HYGZEoDf75p2JAHGwRycC3t4x82J5yeE+c0NDDb3KRzdthYAAmWEc+UeWWrW3FoYkvmS0Gie6oQYFilzPQdIPakhp96LPrO6J+pzsuyB6vpqirQ6e4pVdnbfDDxW8h6CiIxQcjGBx4tuJa88RBzTIBLGwfdtvZ6NVkXY1AFu57Hc0verzSzac6bpctW00ET73NW89UVStYOvqpHyvXg621F75t8idjTgWlxHvMiQDYmU7EX1cLcqloXhY4ifwgSa4dyGWB6FMy7URoehJlPyObDTKYKv6c+eJgnTV6ljqvPLVA7DD2sBFBU3L1xfMQFIQ/zXoBvVjhoDGBxXNvxroPBXt/cYz1fo4dnLb7wsAwkFT7h8tnXwzn7+thFVu2usfBN9DsgLwfJnJ9yyop8VdSClvzqinbLrgdJvv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(4326008)(8676002)(316002)(478600001)(2906002)(54906003)(110136005)(31686004)(186003)(16526019)(31696002)(6486002)(66556008)(66476007)(83380400001)(66946007)(5660300002)(2616005)(52116002)(6666004)(36756003)(86362001)(8936002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eE96VHN0Vm5vZXBhakF3Zld1b21MY3ZieTRyRVQ0YU5HS2R0dlFaSUJVaGhI?=
 =?utf-8?B?NUVWZ1NiMk4yYklraUtna2ZqejFiRmxNT3dVZDZscXRSdUFGMW13d1A1bHdL?=
 =?utf-8?B?Zjh1ZWtxWUhiVEVndjAzVTR1NlBMOGRFS0xSQUZNMytRZTlCTzZWM1NmTkpE?=
 =?utf-8?B?YVBKems1T3JJY1pSOXArWXp6VzM0b2xXdmpqbkxmdTBFZU10Y1lKNzhuMElR?=
 =?utf-8?B?ckJPa09KU25CMWNucmN5d0pzN1RwSXg0T0t5VTJGSDhsVU01d05CQW9SQTdH?=
 =?utf-8?B?Unlnb0xGcTdLMGZvUnZOdE9ydXFKRzBsRTVvaHFsRTBtcW5peUNMYjErWGlh?=
 =?utf-8?B?MkhlY05LcGpJWldrbjh3ZFNHYkYvZnkzVlplM1VWY3FGb3dBR01PejBhODY2?=
 =?utf-8?B?eG5pc21scFNjU0dvODc2UEpPSHcwY29tRitTUHY4MmVvSFBzTlFhdlJLNC9x?=
 =?utf-8?B?NFFuMHhsK09EUUovZFJQYnBreXVSSkNqc3ZlZTh0bng5NXlxdTBDVE9wY3Nx?=
 =?utf-8?B?RERqa0E5dzArR1grYi80UmhIS1VPSEN2RzVOZWdXL2FLSEQxZWZUZkpQQm83?=
 =?utf-8?B?UVYwTVNJekFDMGdtMDNTeHNXT240OWpxVHRWVHd4UWUyaU1zcFEvUkI4UzR0?=
 =?utf-8?B?UlgzS2VHNCt3K3pkbThrOXpOL3pycm5IdU9vZENOT3F6aXR1Yk53MFI5QzI2?=
 =?utf-8?B?S0NHQXFQYWQvT0xsTFNJY1pIWFkzd1QyejFuN3djRld2ZDdkaU9VUURNcFU2?=
 =?utf-8?B?TE5vSkVXUVE4Y01SUDN5dFlOejNLQUZER0VXSDV5enFXaHBYVitwWHpuQjhI?=
 =?utf-8?B?RWpkRUwyV0hBQXBGSWs2UFc2OTdTQWF4blJkYVhFcXM2bWVlNlBqRXk1R25i?=
 =?utf-8?B?TUpBcWVpQTdkRzdUSGdCMVV5TitQWVNpUTlWSENOMmNhYktHejMxYnBqRzli?=
 =?utf-8?B?aWFOU0Ixd2ZTSU5aVnVLVjRaandyMlJUU3lGNHpWQTNNSmNYWkhteVJTKzJh?=
 =?utf-8?B?Q1JFbThyNi92b2pSS0xmOHlLOVBURDluUGRQYkRFSTRHUWlaSkNFL0t3UmhX?=
 =?utf-8?B?b2o2MWg3WndKODRqbm5OWVE5V3RId0Y0OERraWMxdS9ERDNRM0Y3NHN0L2I2?=
 =?utf-8?B?QXdaOGh5cHJSK1FBZTJKdUxTTndTZEYweCt1RytpSGhSRzlIUmJ4ZUsza2sx?=
 =?utf-8?B?OUtwMWIzN1AyUjN3UlBDNmk2WmRpbXFadklrR0YvL1lpSkhFMTBNQWt4R0Rl?=
 =?utf-8?B?ZXhMb1BEemExQVVwYUZnb0RxSHlUNExDWTZyLzg0NTFQc3ZIa1Iwd2NkSDF3?=
 =?utf-8?B?U0E4Q3FLbk1ZNmwyTkhSanFneGlTaXJqRkI0RUFOZ0M0OTJ5akVDZXpwK1Fa?=
 =?utf-8?B?L0hCODZEWXBDUEJ0RDdZc0I0TGRiaU0yejV2NjVXTGd0aDNaQU1oOG5Ydndw?=
 =?utf-8?B?bHYreDVNY0FyS0xyazZpOVlLb2tFQTlsWnppemZxT01jWVhYNTJNcmpBU0dQ?=
 =?utf-8?B?S0NZSDA0cmxXaEF5UGFoOGJ4QVNFSDdETXlmNWVCdHkyZVNHZTZtRFRlY29M?=
 =?utf-8?B?RGNiY1g5bElsRVhmV2hSYjBEek9zN2YreHU1VmRqY1Y1WjZEdi9NVkNwdDNC?=
 =?utf-8?B?OUg2VGxudFBqZDRKV3RGZlE5WTI0SDRIZm4xN0p3L0puUW5GZUlhN2FGSUg4?=
 =?utf-8?B?aWRYdm9NVG10REZDRmhESTlsUnZudndjdjhSbnViTFNxSnZ0Q3ErSjJrRnFC?=
 =?utf-8?B?RWxLV0J5aUVlZHZFQlJDWkRERitEM3FUNXhXazlzVG9FQjQxaDNWNnluemlI?=
 =?utf-8?B?VVV2ZnRVT0pwdnptY2IrZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f49e93-da2b-4373-f27a-08d8d6e3b05e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 03:41:07.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KchOyYPJLUwWqYYJrDPG/eM/Jng9Rbk73Gz9FqpHV+CulXaWgd0LNsb8bQPsKU2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1227
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-21_14:2021-02-18,2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/21 7:49 PM, Ilya Leoshkevich wrote:
> The logic follows that of BTF_KIND_INT most of the time. Sanitization
> replaces BTF_KIND_FLOATs with BTF_KIND_CONSTs pointing to
> equally-sized BTF_KIND_ARRAYs on older kernels.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/lib/bpf/btf.c             | 44 ++++++++++++++++++++++++++++++
>   tools/lib/bpf/btf.h             |  8 ++++++
>   tools/lib/bpf/btf_dump.c        |  4 +++
>   tools/lib/bpf/libbpf.c          | 48 ++++++++++++++++++++++++++++++++-
>   tools/lib/bpf/libbpf.map        |  5 ++++
>   tools/lib/bpf/libbpf_internal.h |  2 ++
>   6 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index fdfff544f59a..1ebfcc687dab 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -292,6 +292,7 @@ static int btf_type_size(const struct btf_type *t)
>   	case BTF_KIND_PTR:
>   	case BTF_KIND_TYPEDEF:
>   	case BTF_KIND_FUNC:
> +	case BTF_KIND_FLOAT:
>   		return base_size;
>   	case BTF_KIND_INT:
>   		return base_size + sizeof(__u32);
> @@ -339,6 +340,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
>   	case BTF_KIND_PTR:
>   	case BTF_KIND_TYPEDEF:
>   	case BTF_KIND_FUNC:
> +	case BTF_KIND_FLOAT:
>   		return 0;
>   	case BTF_KIND_INT:
>   		*(__u32 *)(t + 1) = bswap_32(*(__u32 *)(t + 1));
> @@ -579,6 +581,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
>   		case BTF_KIND_UNION:
>   		case BTF_KIND_ENUM:
>   		case BTF_KIND_DATASEC:
> +		case BTF_KIND_FLOAT:
>   			size = t->size;
>   			goto done;
>   		case BTF_KIND_PTR:
> @@ -622,6 +625,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
>   	switch (kind) {
>   	case BTF_KIND_INT:
>   	case BTF_KIND_ENUM:
> +	case BTF_KIND_FLOAT:
>   		return min(btf_ptr_sz(btf), (size_t)t->size);
>   	case BTF_KIND_PTR:
>   		return btf_ptr_sz(btf);
> @@ -2400,6 +2404,42 @@ int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz)
>   	return btf_commit_type(btf, sz);
>   }
[...]

I skipped deduplication part, Andrii can take a look later.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d43cc3f29dae..b79a6a2e6faa 100644
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
> @@ -2384,18 +2387,22 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
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
> +	int t_uchar = 0;
>   	int i, j, vlen;
> +	int t_uint = 0;
>   
>   	for (i = 1; i <= btf__get_nr_types(btf); i++) {
>   		t = (struct btf_type *)btf__type_by_id(btf, i);
> @@ -2445,6 +2452,26 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>   		} else if (!has_func_global && btf_is_func(t)) {
>   			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
>   			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
> +		} else if (!has_float && btf_is_float(t)) {
> +			/* replace FLOAT with TYPEDEF(u8[]) */

replace FLOAT with CONST(u8[]).

> +			int t_array;
> +			__u32 size;
> +
> +			size = t->size;
> +			if (!t_uchar)
> +				t_uchar = btf__add_int(btf, "unsigned char", 1,
> +						       0);
> +			if (!t_uint)
> +				t_uint = btf__add_int(btf, "unsigned int", 4,
> +						      0);
> +			t_array = btf__add_array(btf, t_uint, t_uchar, size);

Checking whether t_array is valid here or not?
We do not need to check t_uchar/t_uint. If they are invalid 
btf__add_array() will return -EINVAL.

> +
> +			/* adding new types may have invalidated t */
> +			t = (struct btf_type *)btf__type_by_id(btf, i);
> +
> +			t->name_off = 0;
> +			t->info = BTF_INFO_ENC(BTF_KIND_CONST, 0, 0);
> +			t->type = t_array;
>   		}
>   	}
>   }
> @@ -3882,6 +3909,18 @@ static int probe_kern_btf_datasec(void)
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
> @@ -4061,6 +4100,9 @@ static struct kern_feature_desc {
>   	[FEAT_MODULE_BTF] = {
>   		"module BTF support", probe_module_btf,
>   	},
> +	[FEAT_BTF_FLOAT] = {
> +		"BTF_KIND_FLOAT support", probe_kern_btf_float,
> +	},
>   };
>   
>   static bool kernel_supports(enum kern_feature_id feat_id)
> @@ -4940,6 +4982,8 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
>   		local_id = btf_array(local_type)->type;
>   		targ_id = btf_array(targ_type)->type;
>   		goto recur;
> +	case BTF_KIND_FLOAT:
> +		return local_type->size == targ_type->size;
>   	default:
>   		pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
>   			btf_kind(local_type), local_id, targ_id);
> @@ -5122,6 +5166,8 @@ static int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id
>   		skip_mods_and_typedefs(targ_btf, targ_type->type, &targ_id);
>   		goto recur;
>   	}
> +	case BTF_KIND_FLOAT:
> +		return local_type->size == targ_type->size;
>   	default:
>   		pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
>   			btf_kind_str(local_type), local_id, targ_id);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 1c0fd2dd233a..ec898f464ab9 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -350,3 +350,8 @@ LIBBPF_0.3.0 {
>   		xsk_setup_xdp_prog;
>   		xsk_socket__update_xskmap;
>   } LIBBPF_0.2.0;
> +
> +LIBBPF_0.4.0 {
> +	global:
> +		btf__add_float;
> +} LIBBPF_0.3.0;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 969d0ac592ba..343f6eb05637 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -31,6 +31,8 @@
>   #define BTF_MEMBER_ENC(name, type, bits_offset) (name), (type), (bits_offset)
>   #define BTF_PARAM_ENC(name, type) (name), (type)
>   #define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
> +#define BTF_TYPE_FLOAT_ENC(name, sz) \
> +	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
>   
>   #ifndef likely
>   #define likely(x) __builtin_expect(!!(x), 1)
> 
