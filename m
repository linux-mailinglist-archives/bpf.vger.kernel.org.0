Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3263DAAD7
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 20:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhG2SRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 14:17:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28286 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhG2SRu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Jul 2021 14:17:50 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TI8rda007479;
        Thu, 29 Jul 2021 11:17:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EFhSAeHCFLZf5VOzf958MR4jeKWu9cDNUPsZlUiRtC0=;
 b=gF5riBKxKQohfNSW34ZiC1us0N5GWlR/Fcs8An5v/aaDWPxjs+69twhRwEoMkyYZGai6
 u1t7E4S8tWWs0/dzI0D0A9GFFaUcnjxUUiRgEt9FuEa5pjS3hDkbFwb0c+IURgWW54Cz
 cp/xZmzKo0LFHsIZ1w65WxTZj0vbKLCTniY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3cddymdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 11:17:32 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 11:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMwNp3ewlNvG0b1F7LO1Yr1rEN3aCcX0MdPdolzJY06MhiGD6JAw/vc7CMB2M6M7ebXUbvKkNkMuSmnTpw04Z3kmxnxdNdl0ZTjIs3my3IRDFD68A9M0MxkkAHqJ9GdSq4xffQMTBCsj45zcyC+V8pSYscXWK1EmA4D6oaOXKchPocflNwn+aFocE+V/iVs9Fn6lUAQQi9aKZcfPXep9DXIRBJcJP2H/594iAjldAq5ioTYquBSdgBx6ZaY5cvLbAAuYyZKKrqwCehI4kQp3FnWTXjnlGF9uI7VFmqYxWNV35j9pLfWDJUrvVGQwsZF9WCAmB/KsPSaojdU4ouKg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFhSAeHCFLZf5VOzf958MR4jeKWu9cDNUPsZlUiRtC0=;
 b=eMsMX35grvSwGjyRTnYUzO92rxX2G4+zIAOd4wvT8djfe9XJxXX26Dp/+kU7TT43fmvzi9ItigHy7xtHSmoBAr5ogUxJa7CltPMf8A/baX9TMcB0GjKnt7z0B2jw+4ZHCeWfImxQ11KDeKFjhROt+8GicaEZ8yU7hBK61IzxuJLuk4WWDri3Na7OSEqwe+6nhMJyZfxmxvL/1Gz9Ylpudoa6UsbSzlfur0TOUvYaqFKGQJplW4pu0D8GPykdqFjbmi0VQca7/0KJvkUuGk+Xk084+f/fbi2nxKCHpOtLh3s5NhanRuxJdkj3lE53TJrii6Jx7FmACBe1d7G849tMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4705.namprd15.prod.outlook.com (2603:10b6:806:19c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 18:17:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 18:17:27 +0000
Subject: Re: [PATCH v2 bpf-next 06/14] bpf: add bpf_get_user_ctx() BPF helper
 to access user_ctx value
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-7-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ca7119de-3bb5-7a68-4005-4485ec151bb9@fb.com>
Date:   Thu, 29 Jul 2021 11:17:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210726161211.925206-7-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::42) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::11d1] (2620:10d:c090:400::5:81b5) by BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 18:17:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d26746-8f6b-4887-2e54-08d952bd1f31
X-MS-TrafficTypeDiagnostic: SA1PR15MB4705:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4705B1C45DA3316630C47BF5D3EB9@SA1PR15MB4705.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWxj992inVZlyTZ+CKIAQZkHwtn+T0yNF9KdNif+2WZMb/Tj7j35RpLhUD8jhqbCgRQWO+nP2l7UUaNpkkORafIcdpdwXUBoFsieJVyBldMUjUlGcydRyes0W0xm1hP9Dz7rDt93tEKKl0QD+Ts/m1xJKK7cWb+MLXVheBcqXXxLzz4bUmiHT9OSYRrb5gJwVrM1MpJSxtLGhZH/0nx+46PUlyFUQE/f4vX4MkVBW6A/9v8SapbMgopIjwydiyZZv4LrCWoxtM0BfLsqvUaGEELUTNHR2oQ2j9Tdrj31PSz3oWDiazxzqfwEn0IIMRdFaXNoRM71P6OR3gaJgnN4MX72vSV4yR3PeqohWeJ0xV1gP3TF+QeOlHub4edKijowQYp6ESTC/H/X6HPw9pWmU5domRW7quEIRku37Q4qKKl2Pk3ttOb9iydycFyW9jCRcLW0swwvu32jqhAzh58RnzpSKi/jD1xzxznOZdV9RwD0ZSv+6iSCbYPNFLXLb/c44cDnWL9yiRjI0GBqNoZz1K/XhQJN1iKhlM3oRJSByys7Ss09vuSLqAvtb41Qq5ucYtx2pNAUDdUfZrHJwlai2mZ+DpSdcSsPdNJd8LMvLNpUMIXdtelc5Epmc1oyezTe9GKDY/BrrrXqmmZ3f2m6+oZ670dLxWFaBFvv3X9U4vbojbwa2S8nxKV4SxJNrE3vMo5emboD6tDrlsVTyFUZkstzRG5ttjTATZHIcFeaplA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(66476007)(66556008)(53546011)(6486002)(8676002)(83380400001)(478600001)(5660300002)(38100700002)(8936002)(31686004)(186003)(36756003)(52116002)(31696002)(66946007)(316002)(86362001)(2906002)(2616005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tnc0SjBIRXU1RHkzckhNZ3N3b1dmUU1naWxMTS9KMEtKVjZUcjd2S0NnQUNH?=
 =?utf-8?B?REg3eHl2azNXcDV1Q2x2NFhSSmprejk2QXJ6eUdoRFhJTGtHbWxlWFRzMGRp?=
 =?utf-8?B?T0t1VCtBNFl2TXRMb1hFdVMrdlVVMUdYRGF3Y0pJalhuOWtWUldHYlp3eXN5?=
 =?utf-8?B?eThXenlhU0doR1hMZW9FM2xBdkNyMG5XSHZwc2VsSExxTzFoYnZCbUVjTG9Z?=
 =?utf-8?B?Y2EvQWVaSUY1ZlVFd1poUDhwZm0wU0NiOWFUOS9pUGwvZmI0aEd0QmpIVnN4?=
 =?utf-8?B?SjZtRXQxRnFYaWw0dFd3RzRycGV1Smo4djMyb2dFVURsOUZlUzRGcm5naURz?=
 =?utf-8?B?MzRlRStIRGtEOC84MFV2eER5MlI3c2pZMlh3cFpVeWlpQXBGN0dTdlBZOEdy?=
 =?utf-8?B?MVlhTStBUUNhaW0vRW9BSFQyajlmRjc4bGVSeXJUem02M05CMlgvMVZjSjlv?=
 =?utf-8?B?U040UDBYRzJFSWdmNWFZcVNZRG1PTWE0UXJISlBlam4vcXVUTzdWVjU4SERt?=
 =?utf-8?B?S09NY0padnBhQmxlcEp1cXFENm1LYUdycHJOSFpLdC9GNHFVMzM1Rjdib1gz?=
 =?utf-8?B?cW9pZXE4OHMxU09OYU1HdGdtN29GdWh6UEd3YUVBcVNUdlljK0Y0VUxlMGNK?=
 =?utf-8?B?NXowVG9YUHd6cEFCbEtMMmVWTUcrVzROZm5hT3FMZHlOeFVaQ2NTOHVlWmFV?=
 =?utf-8?B?M0N5Sk5mTCtkTlNlRHRjTXNuMEY3MHlCdzJOT2VPeWo0VkcyeUpCdjJNTkRl?=
 =?utf-8?B?QnNjT2F4OEN1UFduUlJpbzFxYXJ4andmS2hORzBrQ2t6WWtvaGtIMWFhQ2dP?=
 =?utf-8?B?NlNTWVBjL1M4TkRHSFoyM3lNdnVjMlhNZUVVUHV0dUN6SlE1UlBWUExoS0Nv?=
 =?utf-8?B?U0NJa093MkJNTFViNjRFcUdJR2RRZlNHWE4vVlExR1VtNUlGTEk1UUhlZlQv?=
 =?utf-8?B?SU42ZWNDZEFrQ1RIek11TmlzWlF6cFUxMkVYZC9acitieXprbm1yZXZNVEpV?=
 =?utf-8?B?Z0FibDA4bjQrN0lYWVhNK2dyNXZEQ1ZuUVZiejJLSlpUaC9zbXdyWXNXeVJ1?=
 =?utf-8?B?enNhZmtvN3VJbUhaS1IrTmR2WjhhMHh4c1QvUTlYaEtoRmUrS3JjUVB0emEz?=
 =?utf-8?B?SlpQQjZjNVlLUGpFODJHUmpjSDRLT2VUNEc2eU9YcGMyN2JGMXRKMlhCTXJO?=
 =?utf-8?B?WnRMemdpVmF3VFpLdGlsZkxuUjlydUNiQStEcHNIUVBEMzJTeEE3TVZWVUQz?=
 =?utf-8?B?RXVSbC9JNnpXRFVBWVd0Qy9PcmMzY1d4VzlyTkVoblFmR0pnTHpDMEN5d1BN?=
 =?utf-8?B?ZUM0NzFJZTJPWVkrN0ZRdU5SbThjbDJqOGdWQlNFQ0doalhUU1oweFhtdXBQ?=
 =?utf-8?B?VWJDK2tiSzlWR2lCOW5TVjlSOC84bTFLRktFQkE3cXZtY3lIbThZYkZESVpC?=
 =?utf-8?B?T0o3VC9sRmtrR21IMXcyREo1QnpsWEduaHdlNUJDNlQrU282aCtodXRkYWZy?=
 =?utf-8?B?VzNEbDdQUk44SGNTM3NoRE1sUGZxdm5oNnFzYmxKRHEyVDNWbzBxRG5PTllB?=
 =?utf-8?B?VHpmTGsxU3NOak5EMC9yMUMvaDhqOW5OVlZRSDduVjVyNng3eHJINUYwd0l6?=
 =?utf-8?B?TVlOSE5PRlFaUjB4cDF5NU90R2JablE3ckthZEsvMFVxRTkzUzd4TEw3OG1K?=
 =?utf-8?B?TEcxeGUzV3RFVExQU3g4KzQ1enlTU0V5Yy84cFY3bkVSN2FzeS9KbGFwdm1H?=
 =?utf-8?B?YXh2MFdUTDYzSGpSQ09VMy85ZkxLVHdCczBzM201L1E2cHhtcURmYzFlOE9x?=
 =?utf-8?Q?YM96w92bj5jQdgTzoHQD53QNCeSBUTXMkZUTo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d26746-8f6b-4887-2e54-08d952bd1f31
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 18:17:27.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkvheQ9P2J3ZIwaQod0fgBW0F4hniMbIp9zzfqVpGwsjE7QqehyJAdTee0djCxRG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4705
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: pVzJWZTwsiAQ_Iji3acvS20ScAc3D5uA
X-Proofpoint-GUID: pVzJWZTwsiAQ_Iji3acvS20ScAc3D5uA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_14:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
> Add new BPF helper, bpf_get_user_ctx(), which can be used by BPF programs to
> get access to the user_ctx value, specified during BPF program attachment (BPF
> link creation) time.
> 
> Currently all perf_event-backed BPF program types support bpf_get_user_ctx()
> helper. Follow-up patches will add support for fentry/fexit programs as well.
> 
> While at it, mark bpf_tracing_func_proto() as static to make it obvious that
> it's only used from within the kernel/trace/bpf_trace.c.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   include/linux/bpf.h            |  3 ---
>   include/uapi/linux/bpf.h       | 16 ++++++++++++++++
>   kernel/trace/bpf_trace.c       | 35 +++++++++++++++++++++++++++++++++-
>   tools/include/uapi/linux/bpf.h | 16 ++++++++++++++++
>   4 files changed, 66 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 74b35faf0b73..94ebedc1e13a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2110,9 +2110,6 @@ extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
>   extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
>   extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
>   
> -const struct bpf_func_proto *bpf_tracing_func_proto(
> -	enum bpf_func_id func_id, const struct bpf_prog *prog);
> -
>   const struct bpf_func_proto *tracing_prog_func_proto(
>     enum bpf_func_id func_id, const struct bpf_prog *prog);
>   
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bc1fd54a8f58..96afeced3467 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4856,6 +4856,21 @@ union bpf_attr {
>    * 		Get address of the traced function (for tracing and kprobe programs).
>    * 	Return
>    * 		Address of the traced function.
> + *
> + * u64 bpf_get_user_ctx(void *ctx)
> + * 	Description
> + * 		Get user_ctx value provided (optionally) during the program
> + * 		attachment. It might be different for each individual
> + * 		attachment, even if BPF program itself is the same.
> + * 		Expects BPF program context *ctx* as a first argument.
> + *
> + * 		Supported for the following program types:
> + *			- kprobe/uprobe;
> + *			- tracepoint;
> + *			- perf_event.

I think it is possible in the future we may need to support more
program types with user_ctx, not just u64 but more than 64bit value. 
Should we may make this helper extensible like
     long bpf_get_user_ctx(void *ctx, void *user_ctx, u32 user_ctx_len)

The return value will 0 to be good and a negative indicating an error.
What do you think?

> + * 	Return
> + *		Value specified by user at BPF link creation/attachment time
> + *		or 0, if it was not specified.
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -5032,6 +5047,7 @@ union bpf_attr {
>   	FN(timer_start),		\
>   	FN(timer_cancel),		\
>   	FN(get_func_ip),		\
> +	FN(get_user_ctx),		\
>   	/* */
>   
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c9cf6a0d0fb3..b14978b3f6fb 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -975,7 +975,34 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
>   	.arg1_type	= ARG_PTR_TO_CTX,
>   };
>   
> -const struct bpf_func_proto *
> +BPF_CALL_1(bpf_get_user_ctx_trace, void *, ctx)
> +{
> +	struct bpf_trace_run_ctx *run_ctx;
> +
> +	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
> +	return run_ctx->user_ctx;
> +}
> +
> +static const struct bpf_func_proto bpf_get_user_ctx_proto_trace = {
> +	.func		= bpf_get_user_ctx_trace,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_CTX,
> +};
> +
[...]
