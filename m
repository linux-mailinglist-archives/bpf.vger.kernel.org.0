Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F531F470
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 05:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBSEXg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 23:23:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32860 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229598AbhBSEXe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 23:23:34 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11J4Eqi6016613;
        Thu, 18 Feb 2021 20:22:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VkG3FlZ2NXB73yKZfzEZpb0kE17Zp/jHuz3/g3lFwIQ=;
 b=lT/d1u+zrvHNwcHHdyW9fkY5OnmdWf0jisub3XLkm9hHexnkdMlmAKDPpEdBIDSMqlUx
 VoM+f9D24VuuUGz3DWlwdLLuBCqF7jWoEczDQbKB5s08BWV96vPtnhk4Wxx9ohpRdlqe
 UN9ZvQSc7PJ89cyK/FMvcp/d+l4Qn5+5l70= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36sdpmqjcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Feb 2021 20:22:35 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 20:22:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiiCeKQQraQ136ulcSeh4/MS5pZdoD4JS8mazyJ9FEb/N+n44eZx/pHy4zCBr22elxj+Mr+j2npY6Ty6/NWZbV1KZNy2/Zs/XvOI7I72jJL/wIs3dpDKHNexulu48mXcDWnFi/cq8RLE/mU8N689kpdSUASFsoN1OEh4JhNJCp4cT/97FnGfmWpkcL36+68KbNQDOL/hfoerJ+7/cedjTMpoVzRJt6TO6u/noEFn+rPJp4p2GLdAgjvv04XD+4j2bRDQM9qnHSi2RRjv6gQoEGNJufnQ+K0A4xT/4nAzMhmPjXV3eV59UiuZiWUVpc7P4jTIKoFU0RWGaQ8jf8VMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkG3FlZ2NXB73yKZfzEZpb0kE17Zp/jHuz3/g3lFwIQ=;
 b=FE1BbvqnUUVBkA+Bevdc7VXNPWPYO87Y396zy2ZKJhnll6Da3megRi0/UdBpDAp0jwjER280k9pBHd27ntCAbQcjeOxOc0B9EGV2E2BYg5E90j+GkTq+FCswyZm4zJ6cNHziNNKxvKmN83RF1JFvnTzX1tqweoyUKtURHiICxxUUoG0EBwzKayMc4CluR5CnFL5VoH/8xkJG/deJj7rC9X1PUH3g2ZwFWgeL+J9l87yEKpb51i8r+OH1X6g/VRgN9hgp+6+mJpokBJVCqeE1Hxf3WaFcQ+/JM9KMODdR4PLr8FLHzEdMSupSOfCEBcheX627hSeM8ZiYfBJiZurBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3570.namprd15.prod.outlook.com (2603:10b6:a03:1f9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Fri, 19 Feb
 2021 04:22:30 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 04:22:30 +0000
Subject: Re: [PATCH v2 bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
 <20210219022543.20893-3-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3503fca1-9702-97bc-5385-d36919cb50a4@fb.com>
Date:   Thu, 18 Feb 2021 20:22:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210219022543.20893-3-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:45c1]
X-ClientProxiedBy: MWHPR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:300:ae::12) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::110e] (2620:10d:c090:400::5:45c1) by MWHPR14CA0002.namprd14.prod.outlook.com (2603:10b6:300:ae::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 04:22:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d4c81ff-378d-4760-ae37-08d8d48df8ed
X-MS-TrafficTypeDiagnostic: BY5PR15MB3570:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3570FA4B8493ED41C731B7EDD3849@BY5PR15MB3570.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXik6401L1f0TFg1WvaRGtqXMCJGWrkmLr2RM9um+EZZNRT1pc7loSp2GTElZ/gBuhRH+wwCSLI4I72Dmi3w4iLCJ3teovIFBkTX6qpj+t9CbbLnhSH0vASjZibv3ty81O0olgFQGw5yOIHZLSaRQAcUBMvCuT+Q7GENUCmq5fhiw1DslE74OuXbbN3RFEKEiiXpAAepw03QRYqibP/t6tAnC17DvJSUh0GBHdAvtoblLwO0V9Vc7u2Z2lGOLP8Zp01jR6yjxlYyt0eKHmEqMzwZ2bThTM8ZvHw+cCcmBcEwUHq/QL15rsR65bby6mrzPylMkpHtxpkvrzlw1XGQn74eZnVczo5DV+/XSVtq6tZQgEbCcjS/mbHW8iCHpPOeMTJMU3cjAymcuJIzCeRYZIXJzSQDCHlRxuyR5v1cCmpQxe49xVEPHPpaMMMjeWO51mxHB5djYVvKwG9+EAX0r+IG1GQmiU9ZLlDcu21Rj0zZ8UiBzZ2m4EWHSkbAusE+RnEpOu+XEt9SNvhYUwsoq/4KhMq1G4MaU6IlmZTnxfboKTnQadNqtdIt9JFwiSiBJs38WmE5zzPif7kwF+r4fCvzKz3sVcBrKoEy1KImDrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(376002)(136003)(8936002)(86362001)(31686004)(186003)(52116002)(36756003)(66946007)(66476007)(16526019)(2906002)(2616005)(110136005)(478600001)(8676002)(66556008)(316002)(54906003)(53546011)(5660300002)(6486002)(31696002)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QXRoWUkxZ2d0aTZ0VVZrclAzbko1OG1jSGMzM3A5dWt2VUpkcU95MkhlSFVH?=
 =?utf-8?B?WWR3QmVvcm9YNnBGSUl3LzBGalFVZWRUcjYzZ2xUcFhTS0Y5LzExS0daODha?=
 =?utf-8?B?anlYUVJJRUZaaC9kQjVWUWdsZUI0MGlJZVNnZjl0SkJ3UHRSOUxxeFVPSzJu?=
 =?utf-8?B?MWcwOGN4cTlwd0VUNDNIN2paUXoxRWhxbTBIRjlJMllOWnR1WXBYQ0craUM1?=
 =?utf-8?B?Z09CWHNZQlFxY0U2M216ODNwRGFWcEtFcWl3NEdGMDRDNFVIRnkxY05jR1ZG?=
 =?utf-8?B?cGRkdWR3OENzblZ4anJKMDdIZzd5YVFKRC9lTHYxSXIrcWxNK09ldFFJL0N5?=
 =?utf-8?B?SVF1aEdzWlpXb0RQbzRzRGsrRGYwUmN2Znh4VUNVWDh0NWZxcmt2bUprci9k?=
 =?utf-8?B?WWdSdjVDYXdFSkUvOVVLL0wxcXU3Y3hkaTJ2VXhlbWR5VmMwMVRZMEpmRkdD?=
 =?utf-8?B?T2xvV2d1RmloMXBZbXlMQmJkWjlJeVhiTC9WcnN0bGxwT2MvTVc2UHBUWWwr?=
 =?utf-8?B?NUhLck41VysxMUlsTXRVUlczUzlUYTVNVTNOb2k0dS9USWF4MUxkYVhPTHFR?=
 =?utf-8?B?OXpwNS92MHZ4TU9BZzNNU3F0ZXR4NzR4ei9VaW5UN0NsTmF2Snoyd1oxeW9F?=
 =?utf-8?B?eS84YXg1RWZpY09Hd1pvdkR1L0ZlbGJzNnEvSUtQME1IbXR2U0pvWmdVTTU1?=
 =?utf-8?B?NzYzUGxFWWdtWHNiVVF3c0RYd2RCdXJBd2xBWG1SMGxra0V2eHZ5YTEzbVd6?=
 =?utf-8?B?MUhTL3FLZlpJQzg5WlhmWjRyNlF1Q0tKQjB3TXJ2R2l6MkJybXVFSGNMcGFm?=
 =?utf-8?B?MGdWdTdXNTNOZTV3ZjZLZFRoTGUxR091Zkt5TkJKR1o4ampwSDVEYjN1YWRo?=
 =?utf-8?B?M2E1OWFVeDJYQ2tWYVVxb1Q0Y2ErU014enptWkcrcHhMS3pSaURkM0RPRUNT?=
 =?utf-8?B?V2J1MEJDSTFWQlJTa2NZazF0L2NuaEVFT1RWSk5pc3hlclEzbnlJTFNXZi83?=
 =?utf-8?B?VkRtT1RpQksrTHVVOC80T2F6cFJ1WjFWSDlNNzl1c0M5aGtYczRXV1c5eExP?=
 =?utf-8?B?ejFCQXBoV1QzbDUwckpvblcxZExKODhpWmdIMUtzWnY5Q0J1UFRzZ1F1R0hr?=
 =?utf-8?B?VWFqNWJqa1ppZDh2M2FmT1ZjZzNoZEJJOXJnckFFMFByQkxmUzBKU2ZCOGlL?=
 =?utf-8?B?ZW9uZ3QyakpZTlg0YVZYc0ZLTmQ1NHJjWWlPY1J1QWpvYVZibWFFdHRmY2ox?=
 =?utf-8?B?eEh6SE1Ta2FiNW1qZWVsUStXY0RhYkYvdlFsanRCdnp4MXkxTy9MMVhTR1lD?=
 =?utf-8?B?dDZXZG9nQ1VGZ3dNbjNoOHZMT1Jxb1BwVUFrRzdVcU1SYkhpOE4yRCtEeVVT?=
 =?utf-8?B?TFczRkRBSFBuZWowWEdTMXU1L0F4Y0hXMUJDZGtKdFJCM0dOMENucUttWXZn?=
 =?utf-8?B?LzlnYk9lUWR0dTdMT3ZUZTFkYnNVckJQQ1FSaFFmVC9WQUQzTnNVODdnZVor?=
 =?utf-8?B?d25pait0bkhaQ2dBcVdQcDc5dEx1TmlLSk9Zd05VcUloUEh4REdVSWV3blBC?=
 =?utf-8?B?d25KZTdYMDNybUxSc2YyNjVhWkthVnVEQ01QOWNmNWNUR2xIcE1uVTRyUmMw?=
 =?utf-8?B?ODl4bVV3RkovcWJ1bGZjMFphUGxqa0J2NWFjSExGemR5b0theG5sckd0eWVj?=
 =?utf-8?B?eWhLa3lWSXhxY0FFVitnMitVL3VLSEtxMEJyYy9MNWxITGhKWUFzVTdzVmxF?=
 =?utf-8?B?eExzSnVVSUlLSFdtZkwvVHRsbW1rYVVCTW5SZUViQVFoRkZDUzhjM3N6amow?=
 =?utf-8?Q?Knlrv9R5IWy6bw0p9icPN2tHjyJhW03JtARtc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4c81ff-378d-4760-ae37-08d8d48df8ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 04:22:30.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Fyb2YZ0AKAxBdJYWYDdGtc0kBI6IgfVF8JZyF/mtu/N1K3FSnEArZDx5sytktla
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3570
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_01:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/18/21 6:25 PM, Ilya Leoshkevich wrote:
> The logic follows that of BTF_KIND_INT most of the time. Sanitization
> replaces BTF_KIND_FLOATs with BTF_KIND_TYPEDEFs pointing to
> equally-sized BTF_KIND_ARRAYs on older kernels.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/lib/bpf/btf.c             | 44 ++++++++++++++++++++++++++++++++
>   tools/lib/bpf/btf.h             |  8 ++++++
>   tools/lib/bpf/btf_dump.c        |  4 +++
>   tools/lib/bpf/libbpf.c          | 45 ++++++++++++++++++++++++++++++++-
>   tools/lib/bpf/libbpf.map        |  5 ++++
>   tools/lib/bpf/libbpf_internal.h |  2 ++
>   6 files changed, 107 insertions(+), 1 deletion(-)
> 
[...]
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 2f9d685bd522..5e957fcceee6 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -279,6 +279,7 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
>   		case BTF_KIND_INT:
>   		case BTF_KIND_ENUM:
>   		case BTF_KIND_FWD:
> +		case BTF_KIND_FLOAT:
>   			break;
>   
>   		case BTF_KIND_VOLATILE:
> @@ -453,6 +454,7 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
>   
>   	switch (btf_kind(t)) {
>   	case BTF_KIND_INT:
> +	case BTF_KIND_FLOAT:
>   		tstate->order_state = ORDERED;
>   		return 0;
>   
> @@ -1133,6 +1135,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
>   		case BTF_KIND_STRUCT:
>   		case BTF_KIND_UNION:
>   		case BTF_KIND_TYPEDEF:
> +		case BTF_KIND_FLOAT:
>   			goto done;
>   		default:
>   			pr_warn("unexpected type in decl chain, kind:%u, id:[%u]\n",
> @@ -1247,6 +1250,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>   
>   		switch (kind) {
>   		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
>   			btf_dump_emit_mods(d, decls);
>   			name = btf_name_of(d, t->name_off);
>   			btf_dump_printf(d, "%s", name);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d43cc3f29dae..3b170066d613 100644
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
>   	int i, j, vlen;
> +	int t_u32 = 0;
> +	int t_u8 = 0;
>   
>   	for (i = 1; i <= btf__get_nr_types(btf); i++) {
>   		t = (struct btf_type *)btf__type_by_id(btf, i);
> @@ -2445,6 +2452,23 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>   		} else if (!has_func_global && btf_is_func(t)) {
>   			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
>   			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
> +		} else if (!has_float && btf_is_float(t)) {
> +			/* replace FLOAT with TYPEDEF(u8[]) */
> +			int t_array;
> +			__u32 size;
> +
> +			size = t->size;
> +			if (!t_u8)
> +				t_u8 = btf__add_int(btf, "u8", 1, 0);
> +			if (!t_u32)
> +				t_u32 = btf__add_int(btf, "u32", 4, 0);
> +			t_array = btf__add_array(btf, t_u32, t_u8, size);
> +
> +			/* adding new types may have invalidated t */
> +			t = (struct btf_type *)btf__type_by_id(btf, i);
> +
> +			t->info = BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0);

This won't work. The typedef must have a valid name. Otherwise, kernel 
will reject it. A const char array should be okay here.

> +			t->type = t_array;
>   		}
>   	}
>   }
[...]
