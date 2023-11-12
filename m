Return-Path: <bpf+bounces-14943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A447E91DA
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F75280C3E
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E916156D2;
	Sun, 12 Nov 2023 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj+f/dD3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500871548F
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 17:45:57 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F8A259D;
	Sun, 12 Nov 2023 09:45:53 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so3458783276.0;
        Sun, 12 Nov 2023 09:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699811153; x=1700415953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U65j6SnQAO4jpjNrIVpi4RFk+/GspTSXHnvwvRMYWcQ=;
        b=kj+f/dD3ildGjkub4urepw8bHFFPAmNRZHoT8CObVysVLQYGDRAa47BmneoWZPPqKO
         bTmC/PFkzbvBBx+jUgfyLovu954T7jSNbO4MZuvtyATgHmr7vIcrKDtk5MTG5iQf5w+A
         jsaB65UxlHdfz8st63nc+5yI2GrhAzmGZyV93mGsb6gwCZLGSkwEvk734GfVkdikb+Ao
         fVteMNfZFpvdvo7uqJJ5b78T4S7E8DU1QJI9tVVCMjFOH8821kfArX7Y5YpcNGNsMj4s
         RP6RISdbG5UBPXMevMHm7e0Sa/tBOiNzijHwznUo7ym48HNGLCiA1cuYQqoPtWQNYzLY
         XpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699811153; x=1700415953;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U65j6SnQAO4jpjNrIVpi4RFk+/GspTSXHnvwvRMYWcQ=;
        b=FTE3xn+0Ro39JZLAbL6S298izewUMpOEWZ2zndvpeoFX6FtCJKxau7Jg0dp5puvNHM
         1Wo9vRt+2g1QSu0AGTAKiWNZA6Hff9wv8ltAOUfcFbe6w4xqoC+1NVFEhPpvKuWSSIc8
         CkuXp6iPk+FgZ46KfCh6DJ4/wOzTqTNxRLrEp/GBBtxi/2LZoT/gnf+OmLS4pqZn1pIs
         3tJPFEJg0yiR53NSX4m61JVLSYBgH+vkdpRMjhhbdda7gTB+FZF5sOG+UGd51nEQYbvy
         3RojKp6/3TntDe/TdY48qBudUAzqGlZ7Yrzy/x+I4ChsCnCNtdUJ9hOYeBzDNR05F2ru
         A3+w==
X-Gm-Message-State: AOJu0Ywh7ngVXzEX9jdr6rfbEc7bK2Xu7l3muNqTw1rkB3nwFEKl2a1K
	4WEZN+lTFgzYQHzvLG0dLEpQZSCb9X1agJip7CEjN0fnyQ==
X-Google-Smtp-Source: AGHT+IHenMLJjDxPLQFLdTMb+6YKJvula1l0gL6FOu/CJ/iNEzxsox1pfJXh62x+OAhUzI7ssWvFWBvU4rNhcG9ofEY=
X-Received: by 2002:a25:aae1:0:b0:d9a:e815:38f6 with SMTP id
 t88-20020a25aae1000000b00d9ae81538f6mr2316308ybi.15.1699811152973; Sun, 12
 Nov 2023 09:45:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hao Sun <sunhao.th@gmail.com>
Date: Sun, 12 Nov 2023 18:45:41 +0100
Message-ID: <CACkBjsa_7JcskJPDGFDY9QPAnZq4yH7jxTrz7QnQeX9Dg4vYJw@mail.gmail.com>
Subject: bpf: incorrect range tracking on JE and JNE with non-overlap ranges
To: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Currently, the verifier collects incorrect ranges on the fall-through
of JNE and the branch-taken of JE when ranges of their operands are
non-overlap. The following program can trigger a shift out of bounds
on the fall-through of the JNE path.

C Program: https://pastebin.com/raw/CKvS707A
Shift-out-of-bound: https://pastebin.com/raw/AkJWxVue
Verifier Log: https://pastebin.com/raw/fdjG3u61

In the C program, r7 and r1 have different ranges and are compared:

12: (bf) r4 = r0                      ;
R0_w=scalar(id=2,smin=smin32=-4,smax=smax32=-1,umin=18446744073709551612,umin32=4294967292,var_off=(0xfffffffffffffffc;
0x3)) R4_w=scalar(id=2,smin=smin32=-4,smax=smax32=-1,umin=18446744073709551612,umin32=4294967292,var_off=(0xfffffffffffffffc;
0x3))
13: (bf) r6 = r7                      ;
R6=scalar(id=3,smin=smin32=0,smax=umax=smax32=umax32=24,var_off=(0x0;
0x18)) R7=scalar(id=3,smin=smin32=0,smax=umax=smax32=umax32=24,var_off=(0x0;
0x18))
14: (5d) if r7 != r0 goto pc+2        ; R0=-4 R7=-4

The issue is that is_branch_taken() requires one of the regs to be
known/const, and it returns -1 even when the ranges are non-overlap.
Later, reg_combine_min_max() is called, which assumes two regs could
equal. So, when two ranges are non-overlap, the range of the
corresponding eq path of JE and JNE is incorrect:

if (dst_reg->type == SCALAR_VALUE &&
    src_reg->type == SCALAR_VALUE &&
    !is_jmp32 && (opcode == BPF_JEQ || opcode == BPF_JNE)) {
        /* Comparing for equality, we can combine knowledge */
        reg_combine_min_max(&other_branch_regs[insn->src_reg],
        &other_branch_regs[insn->dst_reg],
        src_reg, dst_reg, opcode);
}

Andrii's patch sets fixed similar issues
(https://lore.kernel.org/bpf/CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6XELnE7VeoUWgKf3cpig@mail.gmail.com/)
where ranges are non-overlap, but one of the subreg is known.

Report this one since this case seems different from the previous one,
and still triggers issues on the latest bpf-next. Also, the range
tracking of non-overlap const/range for JSLT is not correct either,
see my previous report:
https://lore.kernel.org/bpf/CACkBjsbvk7rNfV0uS8uvrw497ybB1uLvUFvZWPx_SBzSRn2Raw@mail.gmail.com/

