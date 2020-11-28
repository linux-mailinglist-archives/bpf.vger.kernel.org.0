Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC772C703F
	for <lists+bpf@lfdr.de>; Sat, 28 Nov 2020 18:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbgK1Rz5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 12:55:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732191AbgK1EQb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 23:16:31 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS4FvYf019390;
        Fri, 27 Nov 2020 20:15:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dtukeqQONtMtGhcEgnl73uhHLZYirXuapFrGBX0aS6A=;
 b=Nb2kg5ZRe0UMmdEwXt+pEX8DiPYl5eYKSmQffenn0NE1f0/49cwcPvZHM7OO19HpRskt
 4u+KaL5uEge1vOgbAOpNBjQlxqacD9BhYZ/fiLZLlZ3SGA0b54BmqMB2EK7xpT6hDWSw
 RRuaaevcnq/+ZpmToZCLgPkijjHWBPD5nyg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 352r1bcxmf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Nov 2020 20:15:58 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 20:15:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8+vq5aWKUdb6CmQaG4ehRlRSVu1CojdOV0eFPegZrhd9Asr/YqbF+DudLtdioPrPsp/EHGXy/kzDcrJYUd8jKqkd+Z5muBKR4F5hOyUFqaBt4dsrvTHFiQn20bVnQMweqhyMsdsbk2j0gRoA7XZZHGwGAS/xFuRQdezdWfv6muTfJ5RTldrRFnigfIvCY2l4Oor9a1q4Q323qQ9lElpR9QeNL+MRBQwk2qcgewUtkFSQvFnj3+ZwLpfdg4mnCLswfZVeHT2srPj1ZkZaYs+0ykJLhog0OuEXXKA8s3V1BvWWtSKzmWEyFaUKugVG4zjMm80KWeqP5fi+u0wkGoRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtukeqQONtMtGhcEgnl73uhHLZYirXuapFrGBX0aS6A=;
 b=iqB+GQYYbr9Cgva3Nqpp5aOWamKu24LRg9u6DFsHGjf6bW0+aTBhEcTho/x0MNKa4GTLRbcvVCTI5KVhzasISKLqRL8yQB+11rB3HnD+UhAALox1gK7AnG9MlnrCBcWCpwLjRxSHc5cspUnsXQUD6i/ATFu1v/qzh1hqMdYtQf2m/rDh0e+dHaZ0G21pb2bKwgBOscXRuoQtKE0vBn0HLL74qF1Oq4fIsOlgop7hrM7oR5JSUAwbwTv7ROfKv7iHRNHsbq5+D/4ZH0JqPq0q1qIaw/wOC+kTYG3JodypOIXQgKj2kIKvyK0tVh+HuPf4z3DZ8hSZX/Jgku5wvHJeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtukeqQONtMtGhcEgnl73uhHLZYirXuapFrGBX0aS6A=;
 b=jGFdJrHm6xPT5rjk1w57xCK4DZSD8h8HmoL1gWxkq9khid+bwTsA23Y8DIZ/Lkp4e/bST2/6XmiimYVPXLBx1oPLQ/WGhsQVIZQ6NX3f0Gri4BW2fcJRv9BE7cN4Xej+ZwtTFzq4D/jolSteC1ttAYJDOOyKjYElJAp0DOkoU3E=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2885.namprd15.prod.outlook.com (2603:10b6:a03:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sat, 28 Nov
 2020 04:15:52 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Sat, 28 Nov 2020
 04:15:52 +0000
Subject: Re: [PATCH v2 bpf-next 07/13] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-8-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d3a3c534-ae62-7703-9740-f3664c63459c@fb.com>
Date:   Fri, 27 Nov 2020 20:15:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201127175738.1085417-8-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b678]
X-ClientProxiedBy: MWHPR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:300:ad::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::102b] (2620:10d:c090:400::5:b678) by MWHPR15CA0047.namprd15.prod.outlook.com (2603:10b6:300:ad::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Sat, 28 Nov 2020 04:15:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 821276a4-9afb-4a8a-58d6-08d893544af5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2885:
X-Microsoft-Antispam-PRVS: <BYAPR15MB288586A5B9AEE2EDCA239A88D3F70@BYAPR15MB2885.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:128;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6i1KKEH3Y8mc9o6HUK7+F0H4GhyuT03tNodYPa2Ob2cJ+xfF1CtsmSVaHraEnWOTVR33KeOCbNyG1wMi3jjyElZmeLve/cgqxkgv5ztJbjhMhLXTFDd+ynENT0IzWThhHr//9a1nIsLLDa5HIl3AZ2c65xSNGbZ7yuuLH1dAsX4P+XBVh6/tqpDZqf8EU3dIHIsvglrcCrdCnwRahY7WoyJzHRKuc7x1XaBixlefcU7PWRK7a1E1JPyD3gCvF77LzzGnpz8XBHYklzgSeT/Z3rx49qOAxNiJxLjzMDuVJ05ERh87a4uUi0R85k3lx5aL+nSCpvr/dZ2b+X08FSMw8B+wnba+UGEykRZhy3KTNnQpYQozXxPyQ68TEze+92D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(396003)(346002)(2906002)(6486002)(8676002)(66946007)(8936002)(66476007)(66556008)(83380400001)(4326008)(316002)(36756003)(54906003)(53546011)(52116002)(86362001)(31686004)(31696002)(16526019)(186003)(478600001)(2616005)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eVNiTU90MVYyWEUzZnFiZTZaZ2dHU3E2M3huMkorcGxYM3IxamJqeVdIblFG?=
 =?utf-8?B?ZzQ3YzNxMFIrVUVmWEQ4NnBYOW9WSG0wanJFMXhSNGtQOW5zU0xHSVNaaXUy?=
 =?utf-8?B?enNPcUVodXJMcUt2NVpXQ1lVdDZOZXl0OXBYQXZMOVF5TjhtaUsxZ0gzbW9P?=
 =?utf-8?B?OHZJRzZTc1dQR0tJbHJ6K2owU3NxTU9Wd01vTHMyMWx6cmNnV2REcUFtV3U5?=
 =?utf-8?B?b3JvNmQwZVc1YkFlT0lkUFpSUWpKejdlTHZwUmtmb1oxamRHSlZpN3JXZ0ll?=
 =?utf-8?B?V0F1eTNEOGJxaUpOdCtESFpMMW9wRmVYVVNPRVFHK0ZHYW11LzNJa2hGd1px?=
 =?utf-8?B?T0JQZWpzb3JNb2JjVzlRZUIzbjU2R1VpOGVMQXFlcmViN21nV1hkcGFCTGtQ?=
 =?utf-8?B?WVU0VjJWSkhHbytOT1p2K20xY1FJNjN3Y2tWWE1nT3dFdER0ckp0NEJ3MGNP?=
 =?utf-8?B?c2hYaVBJTks2b1RTd2oyY1Z3bjBUWTBTQno3UDBEUGlrOFZmQ1pqTUJoeVMz?=
 =?utf-8?B?VzlaZE1yMTkxUGtTVVN0TWkzUVFpampGZnhMSkFwc2daYVZsZ2szUTBDS3J0?=
 =?utf-8?B?WVZkQmYzdnJlM2E2Q1lXaHZ6WjU5QXNnU0NNNlR2RTVTVVhiN1IxOGU5Q1Z6?=
 =?utf-8?B?RERIZWhjZDBHclVMWG1hUFhVRkZzMCtKVjlYR1gybjZ5Y24ydlBtL0kxWFNt?=
 =?utf-8?B?ekJqaW9yV3k5VlJkODZJWm5yeWQ0YkNhcGFUWDRrNDJoYlNyaURpSkFYelFY?=
 =?utf-8?B?bVhNSTB4OHlLT2E2cGF1V3dXWVY2dVFlNUIvRmVKZDJPMUdoOVBJc2dPbHli?=
 =?utf-8?B?SVphcWd3bUZueDAyaU1vUndpQkpsVmY0RWNoR3Y3cU9IWFIrQzlpSmR0UTZ4?=
 =?utf-8?B?UGVjbnhsQUNpRzB1ZFd1Rnh6Y2lVNEsyblRJbDE3K2lBZWpYRXpkcGxucHRV?=
 =?utf-8?B?cDIxUWlac2l2dDVvSS9lcEpnYmEzL0VYUFhRSHgxYjljblAxek04aUdkZWZR?=
 =?utf-8?B?V1hyYTN0R2ptSkNUeStYcDRabnc2SHFjREpnZHhFbk1Kc1RtVWtmdnZXaVk1?=
 =?utf-8?B?TjU0MTZjd3ZnelUyajBkeHY5UlZLaGloRFlHaGtoSjU1SWM3Z0g4TndsUDJu?=
 =?utf-8?B?MENWU01Ib0ZpMzc2WStyTldMT0l6enhZR2JBb2tBemsxcWpqdmJzbVVxWGlE?=
 =?utf-8?B?aE92QkFla3N6QTRKK1Q3TEJDcmZtUmlMNUoxbUVSQlEwN2YveXRoMzY1L253?=
 =?utf-8?B?NXNxbFFJRnJQZjhlMHlvcUZ4MkQvdVF1S0JDUFFDUWw3OGw3UE9kSlV5Y0ZY?=
 =?utf-8?B?T1hrdG92ZTVHdlJ0R1g2all3K0dGMGR2ZXA3VEo1UjR1RW12ODVITHQ4bWhQ?=
 =?utf-8?B?WWFWMTMycGpNaVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 821276a4-9afb-4a8a-58d6-08d893544af5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 04:15:51.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGo6ziNtp3cyWLarmIa/1Uvb028dKVokZBIqTSu78gMwi75mf3M+uO73zgoQPuxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2885
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011280031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/27/20 9:57 AM, Brendan Jackman wrote:
> This value can be set in bpf_insn.imm, for BPF_ATOMIC instructions,
> in order to have the previous value of the atomically-modified memory
> location loaded into the src register after an atomic op is carried
> out.
> 
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   arch/x86/net/bpf_jit_comp.c    |  4 ++++
>   include/linux/filter.h         |  9 +++++++++
>   include/uapi/linux/bpf.h       |  3 +++
>   kernel/bpf/core.c              | 13 +++++++++++++
>   kernel/bpf/disasm.c            |  7 +++++++
>   kernel/bpf/verifier.c          | 35 ++++++++++++++++++++++++----------
>   tools/include/linux/filter.h   | 10 ++++++++++
>   tools/include/uapi/linux/bpf.h |  3 +++
>   8 files changed, 74 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7c47ad70ddb4..d3cd45bcd0c1 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -827,6 +827,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>   		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
>   		EMIT1(simple_alu_opcodes[atomic_op]);
>   		break;
> +	case BPF_ADD | BPF_FETCH:
> +		/* src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
> +		EMIT2(0x0F, 0xC1);
> +		break;
>   	default:
>   		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
>   		return -EFAULT;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index ce19988fb312..4e04d0fc454f 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -270,6 +270,15 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   		.imm   = BPF_ADD })
>   #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
>   
> +/* Atomic memory add with fetch, src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
> +
> +#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = BPF_ADD | BPF_FETCH })
>   
>   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>   
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d0adc48db43c..025e377e7229 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -44,6 +44,9 @@
>   #define BPF_CALL	0x80	/* function call */
>   #define BPF_EXIT	0x90	/* function return */
>   
> +/* atomic op type fields (stored in immediate) */
> +#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> +
>   /* Register numbers */
>   enum {
>   	BPF_REG_0 = 0,
[...]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e8b41ccdfb90..cd4c03b25573 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3602,7 +3602,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   {
>   	int err;
>   
> -	if (insn->imm != BPF_ADD) {
> +	switch (insn->imm) {
> +	case BPF_ADD:
> +	case BPF_ADD | BPF_FETCH:
> +		break;
> +	default:
>   		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
>   		return -EINVAL;
>   	}
> @@ -3631,7 +3635,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   	    is_pkt_reg(env, insn->dst_reg) ||
>   	    is_flow_key_reg(env, insn->dst_reg) ||
>   	    is_sk_reg(env, insn->dst_reg)) {
> -		verbose(env, "atomic stores into R%d %s is not allowed\n",
> +		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
>   			insn->dst_reg,
>   			reg_type_str[reg_state(env, insn->dst_reg)->type]);
>   		return -EACCES;
> @@ -3644,8 +3648,20 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>   		return err;
>   
>   	/* check whether we can write into the same memory */
> -	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> +	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> +			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> +	if (err)
> +		return err;
> +
> +	if (!(insn->imm & BPF_FETCH))
> +		return 0;
> +
> +	/* check and record load of old value into src reg  */
> +	err = check_reg_arg(env, insn->src_reg, DST_OP);
> +	if (err)
> +		return err;
> +
> +	return 0;
>   }
>   
>   static int __check_stack_boundary(struct bpf_verifier_env *env, u32 regno,
> @@ -9501,12 +9517,6 @@ static int do_check(struct bpf_verifier_env *env)
>   		} else if (class == BPF_STX) {
>   			enum bpf_reg_type *prev_dst_type, dst_reg_type;
>   
> -			if (((BPF_MODE(insn->code) != BPF_MEM &&
> -			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
> -				verbose(env, "BPF_STX uses reserved fields\n");
> -				return -EINVAL;
> -			}
> -
>   			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
>   				err = check_atomic(env, env->insn_idx, insn);
>   				if (err)
> @@ -9515,6 +9525,11 @@ static int do_check(struct bpf_verifier_env *env)
>   				continue;
>   			}
>   
> +			if (BPF_MODE(insn->code) != BPF_MEM && insn->imm != 0) {

"||" here instead of "&&"?

> +				verbose(env, "BPF_STX uses reserved fields\n");
> +				return -EINVAL;
> +			}
> +
>   			/* check src1 operand */
>   			err = check_reg_arg(env, insn->src_reg, SRC_OP);
>   			if (err)
> diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
[...]
