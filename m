Return-Path: <bpf+bounces-9818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B8379DC3F
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0309D282586
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD107BA56;
	Tue, 12 Sep 2023 22:49:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858817C2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 22:49:52 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86A310EB
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 15:49:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so10588207e87.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694558990; x=1695163790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6T4QXGZbwWVRUZhjh+OU25Q4rqlIuPPl9FILmF+ns7U=;
        b=Pe7AZhywwuQCUDQiwq4zveYyBISJF2ctTG2GVQHV734sXMFJtM5XZV78B2TR5jFllf
         BAY4VboHmNps2y7kuXn0tbdopurZebxVVakLkKjxx5q8/katuHQ4M9f/ygUOHbLQ7xkM
         LVxSYFGGjdMlAk00T66X0ADjwNwOlulvg3z3FYIzXHdoMQUG+8X/l79VaErRtYgPmLZK
         /A8PN5nbymh7+YP1Ox/r+4vlWTmjXfUaDYxcLbCMqZ5GDYfLPgBHNwcs3VbOeQNd+4nb
         k3WbQiD002t9XQ/+XmU0DYEyfnQlcuAw1f1GOjOHDlRnNnh7NlN8pM6iMlMDPeVxp3Vq
         Qgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558990; x=1695163790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6T4QXGZbwWVRUZhjh+OU25Q4rqlIuPPl9FILmF+ns7U=;
        b=kt3eRP7zPKZ1OKwyjTGsXC8IH5+l5L1eDXrkcykS0FSZZ1nLUB9yZFTnfgo7VkpH33
         p9U+9MxPNY1Z9MJQMsIRvELYx5U2sIQVvNSYHTA/LKPft0IxvGvxycvQoktOh9nb/Bev
         VVu3+Y3yh92bjv3ykEPSetmfJzO5BGLI3HoDoTbUVZ7yf94sp+WVIkbiEqtLWMiBq+Lf
         v4yqV3ldoe7ohxIauojN1aoGPhLessgU06ksB6Omon+4eTXQIWiTQyC9GbtF5c3mhf0d
         bzx29O7ePK3l9Y3KU5rdFqsFVN/Jq4D2cnQK+eEuYoA+cZ0fLba5bX0A5lmhKmfQ4Xg6
         c9Ag==
X-Gm-Message-State: AOJu0YwpHd/qKjtm72BVVvCvL3yJ2kIZyZJBL1cAWrP9IuChyIpSHVhj
	0+T3yuc/T8Oa73ps/ymgngpH639c+aj7v5QSjSc=
X-Google-Smtp-Source: AGHT+IEvvL8acxKA9iQ073LPhUuyzlWeQmGy8RqFvXjr1jwyiW8uOU1fIPocijCSYHBu8LF6CxoS6v+UEg9byLsrbdo=
X-Received: by 2002:a05:6512:3b83:b0:4fe:7e1f:766a with SMTP id
 g3-20020a0565123b8300b004fe7e1f766amr762097lfv.24.1694558989651; Tue, 12 Sep
 2023 15:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830011128.1415752-1-iii@linux.ibm.com> <20230830011128.1415752-2-iii@linux.ibm.com>
 <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
 <mb61p5y4u3ptd.fsf@amazon.com> <CAADnVQ+u1hMBS3rm=meQaAgujHf6bOvONrwg6nYh1qWzVLVoAA@mail.gmail.com>
 <mb61p4jk630a9.fsf@amazon.com> <CAADnVQJCc6t82H+iFXvhs=mfg1DMxZ-1PS3DP5h7mtbuCW79qQ@mail.gmail.com>
 <mb61pv8cm0wf9.fsf@amazon.com> <CAADnVQ+ccoQrTcOZW_BZXMv2A+uYEYdHqx0tSVgXK31vGS=+gA@mail.gmail.com>
In-Reply-To: <CAADnVQ+ccoQrTcOZW_BZXMv2A+uYEYdHqx0tSVgXK31vGS=+gA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 13 Sep 2023 00:49:38 +0200
Message-ID: <CANk7y0hK9sQJ-kRx3nQpVJSxpP=NzzFaLitOYq8=Pb6Dvk9fpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"

Hi Alexei,

[...]

> I guess we never clearly defined what 'needs_zext' is supposed to be,
> so it wouldn't be fair to call 32-bit JITs buggy.
> But we better address this issue now.
> This 32-bit zeroing after LDX hurts mips64, s390, ppc64, riscv64.
> I believe all 4 JITs emit proper zero extension into 64-bit register
> by using single cpu instruction,
> but they also define bpf_jit_needs_zext() as true,
> so extra BPF_ZEXT_REG() is added by the verifier
> and it is a pure run-time overhead.

I just realised that these zext instructions will not be a runtime
overhead because the JITs ignore them.
Like
s390 does:
case BPF_LDX | BPF_MEM | BPF_B: /* dst = *(u8 *)(ul) (src + off) */
case BPF_LDX | BPF_PROBE_MEM | BPF_B:
        /* llgc %dst,0(off,%src) */
        EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg, REG_0, off);
        jit->seen |= SEEN_MEM;
        if (insn_is_zext(&insn[1]))
                insn_count = 2; /* this will skip the next zext instruction */
        break;

powerpc does after LDX:
if (size != BPF_DW && insn_is_zext(&insn[i + 1]))
        addrs[++i] = ctx->idx * 4;

> It's better to remove
> if (t != SRC_OP)
>     return BPF_SIZE(code) == BPF_DW;
> from is_reg64() to avoid adding BPF_ZEXT_REG() insn
> and fix 32-bit JITs at the same time.
> RISCV32, PowerPC32, x86-32 JITs fixed in the first 3 patches
> to always zero upper 32-bit after LDX and
> then 4th patch to remove these two lines.

I have sent the patches for above, although I think this optimization
is useful because
zero extension after LDX is only required when the loaded value is
later being used as
a 64-bit value. If it is not the case then the verifier will not emit
the zext and 32-bit JITs will emit
1 less instruction because they expect the verifier to do the zext for
them where required.

Link to patch series:
https://lore.kernel.org/bpf/20230912224654.6556-1-puranjay12@gmail.com/T/#t

Thanks,
Puranjay

