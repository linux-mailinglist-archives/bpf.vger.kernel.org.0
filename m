Return-Path: <bpf+bounces-23271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FBD86F50E
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 14:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A9A1C20C38
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8C290A;
	Sun,  3 Mar 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc4LRroC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CCBE5A
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471927; cv=none; b=HRUu3TPUqqMs2bZnGS4DTF/fYiGLyLF89zJCpv85P7U2PSvzBlJktQTHCIT0uf45jcIw49AjLwqDI9ahsD/x4cRlENLid+Nzh14Gn477Z3pslt3iTbwMQQbW7/ZcQOoDIMBGJ6Y2r2jNfW/0mdcZQReTyHawnFRbsZnwWQWev5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471927; c=relaxed/simple;
	bh=OEvZ2agys6oKZJBETdEFlR5fDvi/lMJL9VD07bTMnaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcPnxmxmfsmHqq2MoJyKF55J56TUfkd+DEtWKWAmop613ep2pzE9I7uGW18Gt3x5ThaEsqBetmzD9akNMHs5yMIR6XtfZWpcSizT5wCUuRPmAGyAndBEAV/3lCekmxRBWAsxbpYzG7SJd9qPiI9bujJ9eI4ItJTD0jbJ/2MrT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oc4LRroC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e56da425b5so2573477b3a.0
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 05:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709471925; x=1710076725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+CNxPmOMG+35llN1STnY54ToieEzr3BC0GqD8x8Ceo=;
        b=Oc4LRroCDvmGMYj8XpGjIu3zVqL7hOEfg4RB32gp4fBz4QsLlIlYpZQpaJpbWlXiTG
         iJVepbX27B0RA+04ls2vVpjYTfheiIluUdLTKVuVstg2NOO3n5MetF5N862xaAODJA4s
         zrpZVpaWtDhIcGdYSHuvCW6Y3DXwIyOPG5/d1SVPAK2P8xFYXUIRTxoqkAnxnmiR1ZK1
         jt9OY+pt+0Ftcd6qlYaHM5B4CsVrHADB+ypvAsSzkO6VhfqRn899U6FAXZiGNOgORz1u
         +Nrn1gaQL2NOpFGYNpN6/flvEc0jnKh9ZjupeYlTR2pMxxR5IDoccmgehu4D9/oA67br
         +XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709471925; x=1710076725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+CNxPmOMG+35llN1STnY54ToieEzr3BC0GqD8x8Ceo=;
        b=ARP1DovvVk0u5S3985Iy1l147JBn/icEC8iAwM2fwFzjGfvlomxROL1TKqZeYFmwei
         mUMjlnERDh5e7RYIBLDHEN1ER5BOMocLH44VlNb1Jqt6LK1wRYD7lAbu9PJjDUYepH77
         7mjmKsxUEZSrpNfk9nwEZ9ALrk3cZ5hFfnw54xbz9QJKaEKf3koRaNyp2wjqdCCPdhrd
         0Y3WbP/NCZLG2LecOov0H4xnIij2p+P9gZ3qQxWyNB2RozZ1qVRxseMsPPOd7DFenS7b
         XtXlsp+MGVLmdfZVuIdeKCmxy2XvNTJC0/rXeZKZGz8n3RwOKJZGw5+YzVOdMm8cRJrJ
         9Rmg==
X-Gm-Message-State: AOJu0YxVoauquc6HX0UJYYcs+nMuoA/jSbKG/DSEADbsht5ezT7p6RvC
	w5g3AotEL6dPwyvs94QOzyDazefKNcdBxairQ6nPZVKcnwcTrodc
X-Google-Smtp-Source: AGHT+IHt4Hvoq4cS6HsMOW04g6VfuCYlV7g+ICzq4NDHe2OZ4qXgY7nPa7uXeCOKUqXBNKS/wm+XyQ==
X-Received: by 2002:a17:90a:3907:b0:299:5b06:5814 with SMTP id y7-20020a17090a390700b002995b065814mr4429926pjb.40.1709471924725;
        Sun, 03 Mar 2024 05:18:44 -0800 (PST)
Received: from [192.168.1.76] (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090abb0d00b0029b2eccd158sm3032915pjr.48.2024.03.03.05.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 05:18:44 -0800 (PST)
Message-ID: <8ef0de43-e0a8-4f08-8feb-a2484201db3e@gmail.com>
Date: Sun, 3 Mar 2024 21:18:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 0/2] bpf: Add generic kfunc bpf_ffs64()
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
References: <20240131155607.51157-1-hffilwlqm@gmail.com>
 <CAEf4BzYsYHi1s_7PZ5QknUg+Oe9drN0OSXbxT06WDB57o0Ju9w@mail.gmail.com>
 <a910fc94-47cd-419e-baf9-5c00140cbc60@linux.dev>
 <CAEf4BzaA+hhVdh=gGd2uz10ZLPeUKWN2H75MiF93L1AWPJ2O7g@mail.gmail.com>
 <66f56100-0ef6-4d6a-8d98-26b87a7f10da@linux.dev>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <66f56100-0ef6-4d6a-8d98-26b87a7f10da@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/2/6 02:34, Yonghong Song wrote:
> 
> On 2/5/24 10:18 AM, Andrii Nakryiko wrote:
>> On Sun, Feb 4, 2024 at 11:20 AM Yonghong Song
>> <yonghong.song@linux.dev> wrote:
>>>
>>> On 2/2/24 2:18 PM, Andrii Nakryiko wrote:
>>>> On Wed, Jan 31, 2024 at 7:56 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>> This patchset introduces a new generic kfunc bpf_ffs64(). This kfunc
>>>>> allows bpf to reuse kernel's __ffs64() function to improve ffs
>>>>> performance in bpf.
>>>>>
>>>> The downside of using kfunc for this is that the compiler will assume
>>>> that R1-R5 have to be spilled/filled, because that's function call
>>>> convention in BPF.
>>>>
>>>> If this was an instruction, though, it would be much more efficient
>>>> and would avoid this problem. But I see how something like ffs64 is
>>>> useful. I think it would be good to also have popcnt instruction and a
>>>> few other fast bit manipulation operations as well.
>>>>
>>>> Perhaps we should think about another BPF ISA extension to add fast
>>>> bit manipulation instructions?
>>> Sounds a good idea to start the conversion. Besides popcnt, lzcnt
>>> is also a candidate. From llvm perspective, it would be hard to
>>> generate ffs64/popcnt/lzcnt etc. from source generic implementation.
>> I'm curious why? I assumed that if a user used __builtin_popcount()
>> Clang could just generate BPF's popcnt instruction (assuming the right
>> BPF cpu version is enabled, of course).
> 
> Not aware of __builtin_popcount(). Yes, BPF backend should be able easily
> converts __builtin_popcount() to a BPF insn.
> 
>>
>>> So most likely, inline asm will be used. libbpf could define
>>> some macros to make adoption easier. Verifier and JIT will do
>>> proper thing, either using corresponding arch insns directly or
>>> verifier will rewrite so JIT won't be aware of these insns.
> [...]


Sorry for late reply. I was busy trying to fix a tailcall issue[0]. But,
unluckily, it's hopeless to achieve it.

[0] bpf, x64: Fix tailcall hierarchy
    https://lore.kernel.org/bpf/20240222085232.62483-1-hffilwlqm@gmail.com/

It seems great that another BPF ISA extension adds fast bit manipulation
instructions. With assuming the right BPF cpu version, clang expects to
generate ffs64/popcnt/lzcnt BPF insn for
__builtin_ffs64()/__builtin_popcount()/__builtin_clz().

Then, I did a POC to do jit for this kfunc bpf_ffs64(). It's ok to do
jit for kfunc bpf_ffs64() with being aware of cpu features and adding
'BPF_ALU64|BPF_BITOPS'.

Here's the diff of the POC:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e3..9cd552dd7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -18,6 +18,7 @@
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
+#include <asm/cpufeatures.h>

 static bool all_callee_regs_used[4] = {true, true, true, true};

@@ -1131,6 +1132,39 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg,
u8 src_reg, bool is64, u8 op)
 	*pprog = prog;
 }

+static int emit_bitops(u8 **pprog, u32 bitops)
+{
+	u8 *prog = *pprog;
+
+	switch (bitops) {
+#ifdef X86_FEATURE_AVX2
+	case BPF_FFS64:
+		/* identical to tzcnt rax, rdi */
+		/* rep bsf rax, rdi */
+		EMIT1(0xF3);
+		EMIT4(0x48, 0x0F, 0xBC, 0xC7);
+		break;
+#endif
+#ifdef X86_FEATURE_XMM4_1
+	case BPF_POPCNT:
+		/* popcnt rax, rdi */
+		EMIT1(0xF3);
+		EMIT4(0X8, 0X0F, 0XB8, 0XC7);
+		break;
+	case BPF_LZCNT:
+		/* lzcnt rax, rdi */
+		EMIT1(0xF3);
+		EMIT4(0X8, 0X0F, 0XBD, 0XC7);
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	*pprog = prog;
+	return 0;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))

 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
@@ -1521,6 +1555,12 @@ static int do_jit(struct bpf_prog *bpf_prog, int
*addrs, u8 *image, u8 *rw_image
 			}
 			break;

+		case BPF_ALU64 | BPF_BITOPS:
+			err = emit_bitops(&prog, insn->imm);
+			if (err)
+				return err;
+			break;
+
 			/* speculation barrier */
 		case BPF_ST | BPF_NOSPEC:
 			EMIT_LFENCE();
@@ -3145,6 +3185,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }

+bool bpf_jit_supports_bitops(void)
+{
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 36cc29a29..27ad34e20 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -959,6 +959,7 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
+bool bpf_jit_supports_bitops(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64
sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d96708380..0391e2d94 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -34,6 +34,12 @@
 #define BPF_FROM_LE	BPF_TO_LE
 #define BPF_FROM_BE	BPF_TO_BE

+/* bitops on a register */
+#define BPF_BITOPS	0xe0	/* flags for bitops */
+#define BPF_FFS64	0x00	/* opcode for ffs64 */
+#define BPF_POPCNT	0x01	/* opcode for popcnt */
+#define BPF_LZCNT	0x02	/* opcode for lzcnt */
+
 /* jmp encodings */
 #define BPF_JNE		0x50	/* jump != */
 #define BPF_JLT		0xa0	/* LT is unsigned, '<' */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 71c459a51..d90163ede 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2936,6 +2936,12 @@ bool __weak bpf_jit_supports_ptr_xchg(void)
 	return false;
 }

+/* return TRUE if the JIT backend supports bitops with few instructions. */
+bool __weak bpf_jit_supports_bitops(void)
+{
+	return false;
+}
+
 /* To execute LD_ABS/LD_IND instructions __bpf_prog_run() may call
  * skb_copy_bits(), so provide a weak definition of it for NET-less config.
  */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 93edf730d..f5123e92f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#include <linux/bitops.h>

 #include "../../lib/kstrtox.h"

@@ -2542,6 +2543,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }

+__bpf_kfunc unsigned long bpf_ffs64(u64 word)
+{
+	return __ffs64(word);
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(generic_btf_ids)
@@ -2573,6 +2579,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1,
KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_ffs64)
 BTF_KFUNCS_END(generic_btf_ids)

 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 011d54a1d..a5965e1b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10926,6 +10926,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
 	KF_bpf_iter_css_task_new,
+	KF_bpf_ffs64,
 };

 BTF_SET_START(special_kfunc_set)
@@ -10952,6 +10953,7 @@ BTF_ID(func, bpf_throw)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
+BTF_ID(func, bpf_ffs64)
 BTF_SET_END(special_kfunc_set)

 BTF_ID_LIST(special_kfunc_list)
@@ -10982,6 +10984,7 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_ffs64)

 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -19349,6 +19352,10 @@ static int fixup_kfunc_call(struct
bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_ffs64]) {
+		insn_buf[0].code = BPF_ALU64 | BPF_BITOPS;
+		insn_buf[0].imm = BPF_FFS64;
+		*cnt = 1;
 	}
 	return 0;
 }

Thanks,
Leon


