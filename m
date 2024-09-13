Return-Path: <bpf+bounces-39861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCAE978938
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 22:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA437285BE4
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96A126F2A;
	Fri, 13 Sep 2024 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tFm9xIc9"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72BDBA2E
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257622; cv=none; b=Qf/KqD3e1JP4A6g9lmoPTUFAEKe09f72nBxBMMoxRhnL9P2ksxR5LC8/27noJw6QT8lSFFDkeai5jFai1az1kcOF7quvXKGcekxFn9aQl2UkC6Z31or08U+ol4n557s9D7/4RDeX5AEwJSPL1TeJNnq80GMttqSshSKMudjL3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257622; c=relaxed/simple;
	bh=hHIJssMqJKRZCUO151MGYXNIrkTEnsXq25qjh58/yP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJhseueyh+RYsPQZs/N/SvDDDtXLGqCVPfp6yhQ3FyL4s2Y4jWU5inP4SI73viHEmzWtA1h+UUIpKfZH6CngYK/7k9vmnPcimvwTokxPUPKtPyJ6fEn5bHdi7w5BkvhEpHxfGm+IYFdiw68DtVaoqd24ijFQGyb5/BbsoolFICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tFm9xIc9; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d162c454-702c-40bd-b1dd-a70fe476e1d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726257617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHiT5w/EE6pfdmmxsdrVrO7gpmtb07Jmd0iikIYue4Q=;
	b=tFm9xIc9KC4SwhsT0Rzjm4wa3paIQatjW0T5bP+mSMlCyjaZiFOOzqNHg2eahegb8muOsB
	ADolFo2Joqyiws4rfuVwgEMVoyWrMeLeik4kVMV2uCnc2fpj4zh+jHBTQBeAaX+MzSoWL9
	roL3ZCXGYxSvE/8lOQXpB0NHN7i1Ye4=
Date: Fri, 13 Sep 2024 13:00:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix a sdiv overflow issue
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Zac Ecob <zacecob@protonmail.com>
References: <20240913150326.1187788-1-yonghong.song@linux.dev>
 <CAADnVQ+RgqfSTOoWVVokk5zXkeUE1ZxF_neH=HMyKwEeFAJ_aA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+RgqfSTOoWVVokk5zXkeUE1ZxF_neH=HMyKwEeFAJ_aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/13/24 12:44 PM, Alexei Starovoitov wrote:
> On Fri, Sep 13, 2024 at 8:03 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                            BPF_OP(BPF_ADD) | BPF_K, BPF_REG_AX,
>> +                                            0, 0, 1),
>> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                            BPF_JGT | BPF_K, BPF_REG_AX,
>> +                                            0, 4, 1),
>> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
>> +                                            BPF_JEQ | BPF_K, BPF_REG_AX,
>> +                                            0, 1, 0),
>> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                            BPF_OP(BPF_MOV) | BPF_K, insn->dst_reg,
>> +                                            0, 0, 0),
>> +                               /* BPF_NEG(LLONG_MIN) == -LLONG_MIN == LLONG_MIN */
>> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
>> +                                            BPF_OP(BPF_NEG) | BPF_K, insn->dst_reg,
> lgtm, but all of BPF_OP(..) are confusing.
> What's the point?
> We use BPF_OP(insn->code) to reuse the code when we create a new opcode,
> but BPF_OP(BPF_NEG) == BPF_NEG and BPF_OP(BPF_MOV) == BPF_MOV, so why?

Sorry, I focused on the algorithm and missed this one. Yes, changing
BPF_OP(BPF_NEG) to BPF_NEG and other similar cases are correct.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69b8d91f5136..068f763dcefb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20510,7 +20510,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
                         struct bpf_insn *patchlet;
                         struct bpf_insn chk_and_sdiv[] = {
                                 BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-                                            BPF_OP(BPF_NEG) | BPF_K, insn->dst_reg,
+                                            BPF_NEG | BPF_K, insn->dst_reg,
                                              0, 0, 0),
                         };
                         struct bpf_insn chk_and_smod[] = {
@@ -20565,7 +20565,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
                                  */
                                 BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
                                 BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-                                            BPF_OP(BPF_ADD) | BPF_K, BPF_REG_AX,
+                                            BPF_ADD | BPF_K, BPF_REG_AX,
                                              0, 0, 1),
                                 BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
                                              BPF_JGT | BPF_K, BPF_REG_AX,
@@ -20574,11 +20574,11 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
                                              BPF_JEQ | BPF_K, BPF_REG_AX,
                                              0, 1, 0),
                                 BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-                                            BPF_OP(BPF_MOV) | BPF_K, insn->dst_reg,
+                                            BPF_MOV | BPF_K, insn->dst_reg,
                                              0, 0, 0),
                                 /* BPF_NEG(LLONG_MIN) == -LLONG_MIN == LLONG_MIN */
                                 BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-                                            BPF_OP(BPF_NEG) | BPF_K, insn->dst_reg,
+                                            BPF_NEG | BPF_K, insn->dst_reg,
                                              0, 0, 0),
                                 BPF_JMP_IMM(BPF_JA, 0, 0, 1),
                                 *insn,
@@ -20588,7 +20588,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
                                 /* [R,W]x mod -1 -> 0 */
                                 BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
                                 BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-                                            BPF_OP(BPF_ADD) | BPF_K, BPF_REG_AX,
+                                            BPF_ADD | BPF_K, BPF_REG_AX,
                                              0, 0, 1),
                                 BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |

>
> If I'm not missing anything I can remove these BPF_OP wrapping when applying.
> wdyt?

Yes, pelase do. Thanks!


