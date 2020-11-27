Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B212C60B7
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 09:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgK0IJI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 03:09:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbgK0IJH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 03:09:07 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AR86jKl028702;
        Fri, 27 Nov 2020 00:08:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dYkL7fquSx7P37WggPtE/pLADQKz8tiYz2+hRL5MzFA=;
 b=OLDb69DUqwYEMV5Um56YLCb1vQk9FhAQtWu0OjYdE/HgRSEY0LzZTveRqwABEoLcOWxl
 STW/SZl5wmntTdDNSXaOFxjwfVySnJzI9jDHu48JiEN4+EmcVRoj8lDjHzaQFH6Kol7P
 m+L8ELrYKETq73NMMKbUKuxmayx6wTKIgPs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 352u5wgf7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Nov 2020 00:08:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 00:08:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zil9I9inTuzVl/cFJ3xlpX2/PpCNHac/AYTHavjqB5jNzHjl1jDO62IjuovhvAGnnCn1UlQYF21FtMcAmKEo39mPedNbomweUNbToe9w8GLosxVW4hufqAy/qPCMXEJC9kAFjh510sv8H7toQtQ6sPVYnSgAm1jgVahUqxmG6hg37X7lL7WezXT8pWdEJjo6wfslDlC/O0q7mH1vDlWHzXeyPPPosABZcNvWXWjIqZH+QXp1eK8wOFjBSzrfqW0ArfZ3qela1F0aImgCB4PjcM/SLde1Gddg3oBdPQjdpVKgxJln0IwbB5dSNLcnOTxkZB4pPZEAxfKA4JNSfo3pkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYkL7fquSx7P37WggPtE/pLADQKz8tiYz2+hRL5MzFA=;
 b=dZ0oXvFBasqT0h+26KeM3cP77zWs810t7r9HiUlmt9Bn7Mui5W3pFt7CK7XLIg6hDbD1Rx2Yh8dI3gI1xvXL4FphDSwOQ/kW4JQ0/2K2IKbCJfu+EXUJuvLuMM5n/FipkYkXrHLIFLAmyB0pneB3fF1KOzgiIIcqeq+9v9bGRPu7+6byM/dNkFrRTVsYeEuTjP0sST0ryUm7r+voFXxuP06QnVLYDPsTHEPiSRXjcxHRDAeGlt7cBL8bm/oV0m5as3D9PsE+QDTeT4ZMlKYx1dpJYGWqXthHtTCgJ61GTE1fwet3KuvbZfB0mQ9jna569e3847XFWruQ+XZY+v43BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYkL7fquSx7P37WggPtE/pLADQKz8tiYz2+hRL5MzFA=;
 b=WmewgeGItkVrygxvYgT4/Rgqh6bjGMskS2ns22tYwd5ZM8uo9lga9Pfcf7ClQqYDfMLwns8JhANR9t6hRHd3HqQdNYHl2Jnz8wT40GCpwTZuO7203WXPdCYkyhLG1r6uSAxd7OtgRbRh1uIO3FfNstE0tUcSytRl4VwkXDJ2uCY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2455.namprd15.prod.outlook.com (2603:10b6:a02:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 08:08:47 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 08:08:47 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: Expose bpf_get_socket_cookie to tracing
 programs
To:     Florent Revest <revest@chromium.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kpsingh@chromium.org>, <revest@google.com>,
        <linux-kernel@vger.kernel.org>
References: <20201126170212.1749137-1-revest@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cc4a3bd1-d9ea-7778-6711-c3a576b3f843@fb.com>
Date:   Fri, 27 Nov 2020 00:08:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201126170212.1749137-1-revest@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:7e72]
X-ClientProxiedBy: CO2PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:104:7::17) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1008] (2620:10d:c090:400::5:7e72) by CO2PR04CA0115.namprd04.prod.outlook.com (2603:10b6:104:7::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 08:08:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985b861d-161a-4e41-5984-08d892abaaa3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2455:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2455C2C5882619857C3033E1D3F80@BYAPR15MB2455.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMYVftgyP+rH9zyWORlGqR2jOMyNVU4qlvmeKMH48743goQDwBcEw3UU51Y46+KuZRcoDg6cpbNxwVVGlCzr1DdL3tDVYxAEgOn7pM+37xaUpUWySDZG5mJ87lCk7/NdMqf62rr7sW0GACAMMqVcBapyToRzx4HyQ1O+peTODCzH53n7mUwi2uUV91NnPafEF7Xb+t5dKJyEB7Q5qQNH7KddazBvk2wFR3RFZRBVHWJQ3crN04c8/SlxJgcE73XkYbuPIKwjvCBDVe4ziTtfqP2lksgL3Lae+2j+V4Ool31RfQDmj9u3Lt/GUQqfPHKNcsU7SH9i8aEqrfAIU4YO7TS8qGeveIkOSJZxxjeKw8LA25eLTKB8BhuI9lMBUNH+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(39860400002)(396003)(86362001)(316002)(31686004)(52116002)(5660300002)(4326008)(6486002)(186003)(16526019)(83380400001)(66946007)(36756003)(53546011)(2616005)(66476007)(31696002)(8936002)(2906002)(478600001)(66556008)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NzNlRi9TZVZSQ0tLcjdkZEIySjdqRDVaZWtFZkIxWXFsYlZ0ZitFM2dIa09n?=
 =?utf-8?B?Mm5Ja0lzeW9wSUpYeGQ1V3dRckt5dTNzdExuUi8zWG5tNG15S04wZmM1WStm?=
 =?utf-8?B?dUZNeTFkRjZNTUJReTRsNHJyQ2Y2bisvYUlHa2cxMW9XdDFjSUxGbEFjTnla?=
 =?utf-8?B?Y3BzNjcyODR0c3BKVkFGTlhxQVpQWFNMeEJPS2ZmWGx4djFkUEtpSzdoZm5z?=
 =?utf-8?B?cGMzcGVKZHpEVFFZVzdwUHlBc1VvL1lWbWVzSlB0U09TdjlreHVZTGsya2tp?=
 =?utf-8?B?ak13L0FUVE5kbFRsZ3VGSVMzbmkwcUhSbE41ODJZMlRJckdFa1lEWDdxK1Z3?=
 =?utf-8?B?V3pwYWhZVHNjVGZjRW96L05uS3BEdVRVTFhneDFLYVlWaWhmWWpmZG1ZcC9D?=
 =?utf-8?B?eHJmNTJnREhXTzcvK3pEUmFBY3BPUHhCWkoxb1J6NlZ5ZmFXdHJFeHE5Q21P?=
 =?utf-8?B?dG5XZWpacUJueTlYa2hVWXB2SlRSWU1ra1pNZm5zMXFVMVBtVlJlOHpDUlFm?=
 =?utf-8?B?RENtekF1RWxZWHVKK1R2c2dCSUY1cEtENVJUVjRTbmhFelhSK3piM3FzNlVK?=
 =?utf-8?B?RWhqbjlyL2FVRkpDeGloYktpNXZ3VS9GNS9JY2RwQmFDSEM4UGdIME91Ympi?=
 =?utf-8?B?NXF0L3Q1Szh3YXJObko5WDk3UkVkdWQ1eHRkOG5kdXpnQStNQnZiaTNQWEFx?=
 =?utf-8?B?U1pnNEhLakpXeXljdXNxaFZuemh4MFE0R3FFZWg1SkhYS0UvTHhkZkhzd1hR?=
 =?utf-8?B?R3RYQ01hUDRyMUJEQ0JQZGcwVGJsQXl2M05WKzdWK2tCNXJaaXoxNjlpMXA5?=
 =?utf-8?B?M0JVSVNZeWxWRFdSMlhVU0xLZjF0dEUzblNQQjYzNnVYSHRBT1VmSkJINWI0?=
 =?utf-8?B?UXFwamFsbDZOUzQ0SngwWEJmQXpNU3JsL1FmMnJtK0NQUnpibldidnhRVWtq?=
 =?utf-8?B?a3AzTFVyT0xONys1blZ1NWNCeS9MdldaVzZmay9pdkh5ZktGSHdRd0M1aWNZ?=
 =?utf-8?B?TXhvZVRXNktpLzdpYlVYODhzaUE2RTVaM1I0bFp3NWxHYnB4NkdZUXRmVUgw?=
 =?utf-8?B?QXJyTG1SWDdDaWdyY0FNMURraUdxMEFPNllWN2lsS1pLNUc1OWZsK0UvZUVn?=
 =?utf-8?B?cVhhRXdVWXBpTkhLOVg5eSs1Vi9XWGt2NG9vZXM4MCtPUEtJcVRBK0lHdmlZ?=
 =?utf-8?B?NS80V3FTMGthaUZjYXIxTGdjR3NXWW5OY1RDOUxTQlhQaU1ka2pGaVVnVDdz?=
 =?utf-8?B?clU1aUdKclhmQjRiWUxlYmVya2pSZ1JwcDZnSjd1Rm1VV0Rrc21lZjNaNlFE?=
 =?utf-8?B?UXVjK3ZWeHc5Y1BqV1dDS3ZXZHpuVG1FendGdXRMY2tzK3RObUprclQ0Mmxu?=
 =?utf-8?B?UTYwdHE0amI1SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 985b861d-161a-4e41-5984-08d892abaaa3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 08:08:47.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTytwZDRxihV9a3kjYTa1lMiMgZONYhzs0V2NBcA25hSM23LmTVZKiq0vne2cpDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2455
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_04:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270049
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/26/20 9:02 AM, Florent Revest wrote:
> This creates a new helper proto because the existing
> bpf_get_socket_cookie_sock_proto has a ARG_PTR_TO_CTX argument and only
> works for BPF programs where the context is a sock.
> 
> This helper could also be useful to other BPF program types such as LSM.
> 
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>   kernel/trace/bpf_trace.c | 4 ++++
>   net/core/filter.c        | 7 +++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d255bc9b2bfa..14ad96579813 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1725,6 +1725,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   	}
>   }
>   
> +extern const struct bpf_func_proto bpf_get_socket_cookie_sock_tracing_proto;
> +
>   const struct bpf_func_proto *
>   tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   {
> @@ -1748,6 +1750,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_sk_storage_get_tracing_proto;
>   	case BPF_FUNC_sk_storage_delete:
>   		return &bpf_sk_storage_delete_tracing_proto;
> +	case BPF_FUNC_get_socket_cookie:
> +		return &bpf_get_socket_cookie_sock_tracing_proto;
>   #endif
>   	case BPF_FUNC_seq_printf:
>   		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ca5eecebacf..177c4e5e529d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4631,6 +4631,13 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
>   	.arg1_type	= ARG_PTR_TO_CTX,
>   };
>   
> +const struct bpf_func_proto bpf_get_socket_cookie_sock_tracing_proto = {
> +	.func		= bpf_get_socket_cookie_sock,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> +};

This seems correct to me. Could you add another helper description in 
uapi bpf.h? Currently we already have:
   u64 bpf_get_socket_cookie(struct sk_buff *skb)
   u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
   u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)

The btf-id based helper will be something like below
   u64 bpf_get_socket_cookie(void *sk)


> +
>   BPF_CALL_1(bpf_get_socket_cookie_sock_ops, struct bpf_sock_ops_kern *, ctx)
>   {
>   	return __sock_gen_cookie(ctx->sk);
> 
