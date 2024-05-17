Return-Path: <bpf+bounces-29950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0638C8903
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 17:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E6B1F22AB0
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 15:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6885B664DD;
	Fri, 17 May 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4vQqC9h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B0B1A2C23
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958341; cv=none; b=lSUmy3R2TiOry+18WKhqloj3DkRgkLlKjxtfCYJfDf2t41Y1UnrWZH21XPrzX2HA2b4Ky+N4PwAjbVqDco9lXp+3j1zHJMcBQeVQlZS3vYlTHcCauC5rjo++rOxoUJ7iF96lOVa/BLRE7/ifmdw5KNuMAbDfTQV+l5YHCU7FN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958341; c=relaxed/simple;
	bh=wBU7tkAVK4/Ql7Vh3owdnXi8N5p4LdKcjE3l7YWvsTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGHnQDQBU1dcGouM6bVsnLayrHtHgKUHNxO6w2uShShOSAbd+r/5y9tiuE0CXbsdbHL9njeLMpvPEKbuJkEhGVVN/NxzA5CtfP4X18RAPQ/mcnrjxjCV5UsyWkgtzZ7LgrO3cttdpg/bbYmgZXslNQGpCnKGKmOsTpVN50MD1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4vQqC9h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1edfc57ac0cso11031055ad.3
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715958339; x=1716563139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9t/c5qhHAr6XNZpogV/gslaLFHPSz8UVFQayWVosKg8=;
        b=m4vQqC9h4/TCUP4nBHZ/qgSVGpoqzRrGUPF01UctyCyCoSC/RswrCQjydpUZCgC0Z6
         YNHkMecu1usDUdCVV+4EaKTzVmeEwrznL68PpA24b3iDZlAWcyoNZxBm/pP0RUEE87jb
         zxBnzhSzPPGcoVisXycp0iArU7EZG38GjwkcO4Rb4Mb6VU0N3JjK/rVFAR4AKbVWPbcq
         elEwF1NZ83NzIfdKxebNmmdo5PPk+TWbHfGDQS0ayVtxtq+ufMIpYQD38+bvh3ySX5oD
         eIeZWLsNqPvi3VnN9XT4xgy7/E4f9aXElIllMO4JdIeFSUdGcLRsMnGeXQLW4M7U2Xii
         J/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715958339; x=1716563139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9t/c5qhHAr6XNZpogV/gslaLFHPSz8UVFQayWVosKg8=;
        b=wlw1uoJiN5VTkDD/wY9SdVHui3K6m7Yy/kXbAkD01ZpqC2I+5yUZJmB6kmFBYG8GxJ
         N2ivk5V199WQiECiep+JjitDjBNyugzyWP+WdsAHyYHnXJa2evvHTsgbcBn7dBNUa9xa
         hyBFFK8i1Ey20SGIThp4oz3y7EjCj28EwIYBG7Jc3LQ7kaS246j/QzLNhmD0i/yuB77G
         shccyQDQAGR60HDUc7JzBU2CubYmOVz1wshiaTG6qegvpbGN66K5+SIfepMxv/Ktf8vb
         THoksFSZJlb/iSZwUCGHgd4TsPI6FLYia1JHQiMg3fPOf8trTOasQTpq2xXdqXvOB756
         bCoQ==
X-Gm-Message-State: AOJu0YwmkZdXPaxonDHxq9WeoJcaXC8qd0iwvkmdobtQl71g8i+TtDo6
	JMawT/rZ6ikx5sh2uKGPCWCGgiiX8EKoiNWVYxxXQsAHy/I6DJ6X
X-Google-Smtp-Source: AGHT+IFsGBY0LL+eJq+HtHGpKdIbqbxnSVu3/Vz1GKS361QNetolyXk4su66SSiFvwxksm577dWsXA==
X-Received: by 2002:a05:6a20:1056:b0:1ad:9202:2391 with SMTP id adf61e73a8af0-1afde07cecbmr20032783637.2.1715958338603;
        Fri, 17 May 2024 08:05:38 -0700 (PDT)
Received: from [192.168.1.76] (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b72sm14843117b3a.159.2024.05.17.08.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 08:05:38 -0700 (PDT)
Message-ID: <c1483467-b7e5-4511-8c8e-3ab9dfd0ea49@gmail.com>
Date: Fri, 17 May 2024 23:05:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/5] bpf, x64: Fix tailcall hierarchy
To: Zvi Effron <zeffron@riotgames.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, maciej.fijalkowski@intel.com, jakub@cloudflare.com,
 pulehui@huawei.com, kernel-patches-bot@fb.com
References: <20240509150541.81799-1-hffilwlqm@gmail.com>
 <20240509150541.81799-4-hffilwlqm@gmail.com>
 <a6b60575-6342-4ce7-9652-2a7438a3e1f4@gmail.com>
 <CAC1LvL27bXu5zbPj+wO1hQCGvdHooUbQchiwwawyd+iokKc42Q@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAC1LvL27bXu5zbPj+wO1hQCGvdHooUbQchiwwawyd+iokKc42Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/5/17 02:56, Zvi Effron wrote:
> On Thu, May 16, 2024 at 8:28 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 2024/5/9 23:05, Leon Hwang wrote:
>>> This patch fixes a tailcall issue caused by abusing the tailcall in
>>> bpf2bpf feature.
>>>

[SNIP]

>>>
>>
>> Oh, I missed a case here.
>>
>> This patch set is unable to provide tcc_ptr for freplace programs that
>> use tail calls in bpf2bpf.
>>
>> How can this approach provide tcc_ptr for freplace programs?
>>
>> Achieving this is not straightforward. However, it is simpler to disable
>> the use of tail calls in bpf2bpf for freplace programs, even though this
>> is a desired feature for my project.
>>
>> Therefore, I will disable it in the v5 patch set.
>>
> 
> Isn't this a breaking change such that it would effectively be a regression for
> any users already using tail_calls in bpf2bpf for freplace programs? And,
> correct me if I'm wrong, but aren't those pieces of eBPF essentially considered
> UAPI stable (unlike kfuncs)?

Yeah, this is a breaking change. However, I think it's acceptable, as
tail_calls in subprogs was considered to be disabled[0].

[0]
https://lore.kernel.org/bpf/CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com/

> 
> I appreciate that this is an esoteric use of eBPF, but as you said, you have a
> use case for it, as does my team (although we haven't had a chance to implement
> it yet), and if the two of us have use cases for it, I imagine other may have
> as well, and some of them might already have done their implementation.
> 


It seems it is an useful feature for us. I haven't use it either because
of old kernel version.

So, I figure out another approach to resolve this issue.

Here's the diff just for idea discussion:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5159c7a229229..b0b6c84874e54 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -273,7 +273,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(22 + ENDBR_INSN_SIZE)

 static void push_r12(u8 **pprog)
 {
@@ -403,6 +403,22 @@ static void emit_cfi(u8 **pprog, u32 hash)
 	*pprog = prog;
 }

+static notrace void bpf_prepare_tail_call_cnt_ptr()
+{
+	/* %rax stores the position to call the original prog. */
+
+	asm (
+	    "pushq %r9\n\t"       /* Push %r9. */
+	    "movq %rax, %r9\n\t"  /* Cache calling position. */
+	    "xor %eax, %eax\n\t"  /* Initialise tail_call_cnt. */
+	    "pushq %rax\n\t"      /* Push tail_call_cnt. */
+	    "movq %rsp, %rax\n\t" /* Make %rax as tcc_ptr. */
+	    "callq *%r9\n\t"      /* Call the original prog. */
+	    "popq %r9\n\t"        /* Pop tail_call_cnt. */
+	    "popq %r9\n\t"        /* Pop %r9. */
+	);
+}
+
 /*
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
@@ -410,9 +426,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			  bool tail_call_reachable, bool is_subprog,
-			  bool is_exception_cb)
+			  bool is_exception_cb, u8 *image)
 {
-	u8 *prog = *pprog;
+	u8 *prog = *pprog, *start = *pprog;

 	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
 	/* BPF trampoline can be made to work without these nops,
@@ -420,14 +436,16 @@ static void emit_prologue(u8 **pprog, u32
stack_depth, bool ebpf_from_cbpf,
 	 */
 	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog)
-			/* When it's the entry of the whole tailcall context,
-			 * zeroing rax means initialising tail_call_cnt.
-			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
-		else
+		if (tail_call_reachable && !is_subprog) {
+			/* mov rax, offset */
+			u32 offset = image + (prog - start) + 13;
+			EMIT4_off32(0x48, 0x8B, 0x04, 0x25, offset);
+			/* call bpf_prepare_tail_call_cnt_ptr */
+			emit_call(&prog, bpf_prepare_tail_call_cnt_ptr, offset-5);
+		 } else {
 			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
+			emit_nops(&prog, 13);
+		 }
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -1344,7 +1362,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int
*addrs, u8 *image, u8 *rw_image

 	emit_prologue(&prog, bpf_prog->aux->stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
+		      image);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */


Unlink the way to prepare tcc_ptr of current patch set by bpf prog's
caller, it prepares tcc_ptr by calling a function at prologue to reserve
tail_call_cnt memory on stack. And then, call the remain part of the bpf
prog. At the end of prologue, rax is tcc_ptr, too.

This is inspired by the original RFC PATCH[0]. And then, it avoids
unwind-breaking issue by a real function call.

[0] https://lore.kernel.org/bpf/20240104142226.87869-3-hffilwlqm@gmail.com/

However, it introduces an indirect call in
bpf_prepare_tail_call_cnt_ptr(), which costs performance by retpoline.
If to improve performance here, bpf dispatcher should be considered,
like XDP.

Thanks,
Leon

