Return-Path: <bpf+bounces-13220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A897D6683
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BC3B210BB
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F8420B11;
	Wed, 25 Oct 2023 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLo5AZ+V"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC62D60E
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 09:16:48 +0000 (UTC)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D7187;
	Wed, 25 Oct 2023 02:16:47 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-457c441555cso1968473137.3;
        Wed, 25 Oct 2023 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698225406; x=1698830206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXDj7UmqGpf4o1RnvyXyvt/9oEx9PkyWj6Qbo9+PLek=;
        b=RLo5AZ+V65WxDT1DmOVZG0MHFkYlot8a8byJmMHaCM5H98JnaF2bEbJahnx/jX/cBx
         eUTUenIL9eQOos7KpAisivxsckM+nD4EC5Zhq8PTx0+MS3AkGxFo00qURcM+dGX3x6PJ
         mqZ5VRAsrrxuJ+Tai0/x5R6bn5Oq1VRMVcBrquXR8GJ3iuPa79X4Qv/Nq+lKqfMZFBrD
         Ra9JRD9OjkVQwKu1S2NUxxhIC2xk+BSo1xNw7AVK8aCi+RmrvTPtdxtmis+fCsAhHrCG
         0IM93DuC+worI4zqoj046A7neNqtyJ0YWVuO73ah8mTs5wfHwip6A20cLV4le1einc1f
         QVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698225406; x=1698830206;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXDj7UmqGpf4o1RnvyXyvt/9oEx9PkyWj6Qbo9+PLek=;
        b=vhvsbhI0BAwCpuy6+CZPJsoLkCF0BHey+10Hjlm4j57PrDUpP9OJ3ri0uBm2LcJ8Bx
         Pour2U37PokpW1JWbCxDMlHuWvI2x3XxD1P4vZfEuDLQIiLqOzbIbzax+lhSgQKw+61W
         jMF43Z67MM0Dcm7wFWYW7GYtkyhYfCU8xLGN1g7j8Dt31frhpZnSE1q/fPdIl9DxBlvr
         LEDdjFdqu6FFEUA9mYvcdDJkVQDcz37tIuoOHUStkTVdKZ1Tii/XcNZQsj199iPfjzKL
         lu5c/5A26fCCVzQm6qIvFlsUpIG/uxI64sMvlQbrIr7DWMZ2/Ljxqp0hSf/ks4sY/NB7
         +2cg==
X-Gm-Message-State: AOJu0YwCGkeYESyRZyq+UMCAtjIhGqJEO8YLbRPYgwz5F3Y+lpzwjE8H
	961P9307KhcnDG8Srrj3b7pMjxRQUXou270zpmeqUdcgcQ==
X-Google-Smtp-Source: AGHT+IExPU+oUaJs3JlxiDqGLrpRCbfCe5ZnpCMy/r8O1byNw0a4N+ZitImCLo429XQHmy/hd3SuSXM+uwivDKBHE9o=
X-Received: by 2002:a05:6102:475c:b0:45a:d57c:36f9 with SMTP id
 ej28-20020a056102475c00b0045ad57c36f9mr807656vsb.22.1698225406013; Wed, 25
 Oct 2023 02:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 25 Oct 2023 11:16:34 +0200
Message-ID: <CACkBjsYXA8myxoP0Naz=ZxB0FWG-xS9e28CSFffGk1bA_n5RXw@mail.gmail.com>
Subject: bpf: incorrect value spill in check_stack_write_fixed_off()
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

In check_stack_write_fixed_off(), the verifier creates a fake reg to store the
imm in a BPF_ST_MEM:
...
else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
insn->imm != 0 && env->bpf_capable) {
        struct bpf_reg_state fake_reg = {};

        __mark_reg_known(&fake_reg, (u32)insn->imm);
        fake_reg.type = SCALAR_VALUE;
        save_register_state(state, spi, &fake_reg, size);

Here, insn->imm is cast to u32, and used to mark fake_reg, which is incorrect
and may lose sign information. Consider the following program:

r2 = r10
*(u64*)(r2 -40) = -44
r0 = *(u64*)(r2 - 40)
if r0 s<= 0xa goto +2
r0 = 0
exit
r0  = 1
exit

The verifier gives the following log:

-------- Verifier Log --------
func#0 @0
0: R1=ctx(off=0,imm=0) R10=fp0
0: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
1: (7a) *(u64 *)(r2 -40) = -44        ; R2_w=fp0 fp-40_w=4294967252
2: (79) r0 = *(u64 *)(r2 -40)         ; R0_w=4294967252 R2_w=fp0
fp-40_w=4294967252
3: (c5) if r0 s< 0xa goto pc+2
mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=r0 stack= before 2: (79) r0 = *(u64 *)(r2 -40)
3: R0_w=4294967252
4: (b7) r0 = 1                        ; R0_w=1
5: (95) exit
verification time 7971 usec
stack depth 40
processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

Here, the verifier incorrectly thinks R0 is 0xffffffd4, which should
be 0xffffffffffffffd4,
due to the u32 cast in check_stack_write_fixed_off(). This makes the verifier
collect incorrect reg scalar range.

Since insn->imm is i32, we should cast it to the signed integer with
correct size
according to BPF_MEM, then promoting the imm to u64 to mark fake reg as
known, right?

Best
Hao

