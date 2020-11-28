Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA92C726F
	for <lists+bpf@lfdr.de>; Sat, 28 Nov 2020 23:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgK1VuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 16:50:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729180AbgK1SCL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 28 Nov 2020 13:02:11 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS5UAF6012269;
        Fri, 27 Nov 2020 21:35:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2sz6X++NbX0TyYiFyDXpIA3BJnohuXPTvJUDQcXXVV0=;
 b=g2HZMqPwu8e3EFs53SzFtFhj0NjyEo5VCYQETngEiT9W5KGQFgcecw13Kv9uOAHROJQa
 bQaMS6R5yUEaEP36cBMApvSTc7Pc9QQGytHLvcvB8/GFJbErucfGl85em9g4d1GXg0/k
 1j8fdwAxMXXj7TqzAi4IuI7KA5L6ankWDJM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 353f8ug6nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Nov 2020 21:35:13 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 21:35:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmft4k6tLeJnFflFVfpWD3YQmDogVWkM8pkdPyD74JEY8E3Qq9gpWNCydEVRquTBwKq86it5dRq3/7Ae73GOVR5wnPHzX2G7oBAciYCozCJqQUjmsNyjFnDHN3fN0CIdRS/J8/Uc7OCU8kTUZhOVpIoQthNMuEpKqmauHgPCqxIVt23yIgO5bQ3SDqt+6qxDm5q45jht8S3a5XJSktRC8VKXjR8lsQ40KvcTgmEfAzVzGQJ/QF3Tw7unwTxcUMMsWHYkkZHu9F0XvNrPisH5Q1kIypIl9jl02W6TM+Ec6MQadTIp7mAIytxMCHlb785Sb/0CxfOaQ/c2uwMIFeSndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sz6X++NbX0TyYiFyDXpIA3BJnohuXPTvJUDQcXXVV0=;
 b=Ugj3k/ZPkQB9SCzzu1UOGEdwyO8ZgFI7Xs6SJPobHlTmgnqAIcKpLnxtmZJ8neYXDWTmAi03C+i+w1lwoArEU4YynPVPYl/B5wsbTaxE92ODtS9UVKsi5ERT98bG3Pnj7oauGyl32zssbeFerGpQv5pwVTH0XBUal3fBHxL9mXoyD9I0U6v/VSxAo9ei2rpGobUjSrKY6ES9ilZ6dfjIoiX8OILO6NWQvd8MgvZ4e3/19qzDwzXP3Lv8ut3vpjJz584Cv7FJJcclEBskmcVZjWDceYDxYi/VKVPsyoxBDyVwdXJqu/RDr3N8u2p4YQmRdcHe5X4znjuBFGFIMCNlpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sz6X++NbX0TyYiFyDXpIA3BJnohuXPTvJUDQcXXVV0=;
 b=UwzCuX53vZk8CqIhGBzSqxjhBoM2gTtEadxNuGCRduVEPSQOkB6zBm7Vx1UdmmtVZZ1MvexkmozvZWswM2Kn8n202nHwCeoE4jG3iyypy/MXvqBwlWxCPdWuxK70onBAoFIrhDfVH5YBd2iYFVB8u5HARfxf3VbZyXd5kmPYuDQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2774.namprd15.prod.outlook.com (2603:10b6:a03:15d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Sat, 28 Nov
 2020 05:35:10 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Sat, 28 Nov 2020
 05:35:10 +0000
Subject: Re: [PATCH v2 bpf-next 10/13] bpf: Add instructions for
 atomic[64]_[fetch_]sub
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-11-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0fd52966-24b2-c50c-4f23-93428d8993c4@fb.com>
Date:   Fri, 27 Nov 2020 21:35:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201127175738.1085417-11-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fca2]
X-ClientProxiedBy: MWHPR10CA0001.namprd10.prod.outlook.com (2603:10b6:301::11)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::102b] (2620:10d:c090:400::5:fca2) by MWHPR10CA0001.namprd10.prod.outlook.com (2603:10b6:301::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Sat, 28 Nov 2020 05:35:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a94cf620-aae9-4286-e099-08d8935f5f75
X-MS-TrafficTypeDiagnostic: BYAPR15MB2774:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2774A8010472FE49803133F7D3F70@BYAPR15MB2774.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htlC7P9RRAPHwOV4QSEIWGf6++C1a2jrKQzCR2SeAAnpx3WotPwgG+T2WQJHMarowKsZJDY8gCc+ot0nIy19K7ysOVUb7yILLCVbfYCN8IGyQ1/h3ElBd/ySEc7PiOAoNN5pBqmWOJ/H/hp3yByccUmA9a8xWHXRQv22Y8u3uOkLiAYLRahK1CSUMVB/1yvmptJZRIhnGkkNJkaZIV84esnEyAhdPvDXIUMXsOXo9BhWPThZEynRBKPj86zZQUZqaRV8vQ8e9A+TckSjkMSxLVhsl36k116znLqpJL+koxNJvL3gYrD5ry1BDkzJmPlkydJivLl6tQ8xQV8lVKkpcGJizkfJlAWju24wdeWP1T47zC4d++PbWcGfYqbEA8mn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(478600001)(6486002)(31686004)(8676002)(5660300002)(4326008)(52116002)(66476007)(2616005)(86362001)(2906002)(36756003)(16526019)(186003)(316002)(66556008)(83380400001)(8936002)(53546011)(54906003)(66946007)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWtQcFZxQ3Q2MFlvQ1p5VFdPRkRLd0JkNS9sY1B5NjlDUXJaQ2JhSlZScDFK?=
 =?utf-8?B?aVU4N0t1SktHdzN6QXJiOEF0V2hyM2NVMGxvNDNMRkM4L0RpVmM0WDNWNnBR?=
 =?utf-8?B?OGVvMnkzRCswNmcvRU9JaTh5L1hFemJuYnRGSWxJY0I4bnZ2bld0QUh1NnF6?=
 =?utf-8?B?RTZoV2haT1Z6TWRwWHpKeG5GNHRZbGJqejQrV1k4YkpxYzh4dXRDNHp1NTRo?=
 =?utf-8?B?UXBWMWNQR0xaSUJxUWs0MDJveHZYdkh2OXNXRmZZUjZ3YjN0dDZsejNZK1pT?=
 =?utf-8?B?R09rQmgyU0NoNzFmMnE4N09oeDFWY0s1VjE1YUh2R1dzcGxGOFI0OUpoVVRv?=
 =?utf-8?B?WFB5WlAwT0dGZjE0VFJjdlJGc1VPWkJGY09HYzNZSHM1UUlUYzRydUdNUEly?=
 =?utf-8?B?WkZWSC9xZFVLRGlqYmRIc3ZhTUtvaVAzd2FONTFTU3BEOWdDelJ1bXBTd2Yv?=
 =?utf-8?B?TXlVYWtBWEdWaUw2dGlZTHpGUDdEZ1J0ZDJJMWxXeVRHVlF6dzF0SGdQWGZk?=
 =?utf-8?B?NjJucWExaUp6aHBsVzB0eFZLS0V6MnBFSnZyc1czaWdFWGY1SHZ3UDk1VEFC?=
 =?utf-8?B?MmZvcTlSLzF4akRMZHJxbDg2QUVmODBBRHhORWhmV2JxM0xIdmtHV1VBY2tX?=
 =?utf-8?B?NGlqMmtCQlZUM0YxVjFLb2dWNlBRN2JxMlpRbWpNb2ViajErVmtJQnpkUXFn?=
 =?utf-8?B?aVhiTzc5MFBkaUhwcUU2RFMvaW5wb2pUaDNwTEM3cGcrSEhaWXlTcHdTSHZx?=
 =?utf-8?B?QllxaHFEYkRWaFpRSG4vODNXaDVKUFhTS1lhU1RnSjQ2SnZabnI5WEFMZmww?=
 =?utf-8?B?RVdmNVREUENFSlRoMGhxUmZ1bFEwcElVYkdqVmhMVncxcWFTN00xcWRNcmtY?=
 =?utf-8?B?czBrUzFtM3h0QXV3MmtNTXRBdkNLY21HTXVYKzBKMit1UmpHOEt4VXVqUVpK?=
 =?utf-8?B?WWpzdHBXL1BianRYVzFEK0FJYld1bTVBT2xQUklmaGh3d2pOcUVmWTQ0QVZR?=
 =?utf-8?B?cm1DbUt5TGFSNlZYbTZvckFQZzJPN1JRNWd5YjJ6cS9BUEJ4dEN6WWRPNTlQ?=
 =?utf-8?B?dEE4cXlZN1prOGF4b2k1eXZ1SzF3NzBvdnN0bVU0Tk9QQlJYOCttNUU5Ymcx?=
 =?utf-8?B?cTJVVDlYVGVsT29Ea09DbnY5OFRqd2xGNmhCczZydUxjMFQxbllDb01GaS92?=
 =?utf-8?B?L2h5NGFUK3dLU3BXVFdKL3o4VFV1cHFtSVk1NGdkTWMzZndJLzdUMTVkZUg3?=
 =?utf-8?B?MHNVenhaTkZDNDZQcy9EQ1VyaExVRzFjK081VFE0WklabnhRcUFlbllTUjdN?=
 =?utf-8?B?b3MvNno5NytqU2hhUXRnNTdVN2ZjQnJLWlIyRGJGNG5BSkZmeDVLTnFaSERh?=
 =?utf-8?B?azVUVG1rTldzZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a94cf620-aae9-4286-e099-08d8935f5f75
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 05:35:10.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNhUK8tVj+to6K8lH/6njFzcsq7ibrwKGyI3WA5PZRjDs4UJoHuvkKsrS4JsRSPz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2774
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011280039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/27/20 9:57 AM, Brendan Jackman wrote:
> Including only interpreter and x86 JIT support.
> 
> x86 doesn't provide an atomic exchange-and-subtract instruction that
> could be used for BPF_SUB | BPF_FETCH, however we can just emit a NEG
> followed by an XADD to get the same effect.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   arch/x86/net/bpf_jit_comp.c  | 16 ++++++++++++++--
>   include/linux/filter.h       | 20 ++++++++++++++++++++
>   kernel/bpf/core.c            |  1 +
>   kernel/bpf/disasm.c          | 16 ++++++++++++----
>   kernel/bpf/verifier.c        |  2 ++
>   tools/include/linux/filter.h | 20 ++++++++++++++++++++
>   6 files changed, 69 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7431b2937157..a8a9fab13fcf 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -823,6 +823,7 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>   
>   	/* emit opcode */
>   	switch (atomic_op) {
> +	case BPF_SUB:
>   	case BPF_ADD:
>   		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
>   		EMIT1(simple_alu_opcodes[atomic_op]);
> @@ -1306,8 +1307,19 @@ st:			if (is_imm8(insn->off))
>   
>   		case BPF_STX | BPF_ATOMIC | BPF_W:
>   		case BPF_STX | BPF_ATOMIC | BPF_DW:
> -			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
> -					  insn->off, BPF_SIZE(insn->code));
> +			if (insn->imm == (BPF_SUB | BPF_FETCH)) {
> +				/*
> +				 * x86 doesn't have an XSUB insn, so we negate
> +				 * and XADD instead.
> +				 */
> +				emit_neg(&prog, src_reg, BPF_SIZE(insn->code) == BPF_DW);
> +				err = emit_atomic(&prog, BPF_ADD | BPF_FETCH,
> +						  dst_reg, src_reg, insn->off,
> +						  BPF_SIZE(insn->code));
> +			} else {
> +				err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
> +						  insn->off, BPF_SIZE(insn->code));
> +			}
>   			if (err)
>   				return err;
>   			break;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 6186280715ed..a20a3a536bf5 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -280,6 +280,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   		.off   = OFF,					\
>   		.imm   = BPF_ADD | BPF_FETCH })
>   
> +/* Atomic memory sub, *(uint *)(dst_reg + off16) -= src_reg */
> +
> +#define BPF_ATOMIC_SUB(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_SUB })

Currently, llvm does not support XSUB, should we support it in llvm?
At source code, as implemented in JIT, user can just do a negate
followed by xadd.

> +
> +/* Atomic memory sub with fetch, src_reg = atomic_fetch_sub(*(dst_reg + off), src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_SUB(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_SUB | BPF_FETCH })
> +
>   /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
>   
>   #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
[...]
