Return-Path: <bpf+bounces-50099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB87A227DA
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 04:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615797A2519
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 03:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08284A2B;
	Thu, 30 Jan 2025 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvuCoiVT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D8224F0
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738208330; cv=none; b=ZhO79hPgi6kqm6rIojfOWB+NzX9gpGBXh4Gix84j+KbGGyjkh7k4lgZo69Mh9+86Jb8X3ach5xPt/R93Dq2gQYkj1/g4sy/eWBFrawnJI8agtC+J/YjHpoRB+0Y6KHur48GQabN9sBmZU4syUlbWRt2tRsv3nEPvcHJUACK6jUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738208330; c=relaxed/simple;
	bh=DTfc/rqScGLLM2GuFcyHT2WxKXJBR/LNSPwsq6X05Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bySNKoNrSx3b2dBwe5nf7gxyh62dISqs/E49OBPoglo029P/2Yg0NvJ7U1gJ94iphLKXgiB9chuf7dTOLiyfOh0c8K+XC8bjA71J/E97PHFJBuGXj7sZG5YS/53qi+d+qMLnm14A7Xk8z0nYgnOolclmT6BseDZKKq3p2st3bPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvuCoiVT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163affd184so47615ad.1
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 19:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738208328; x=1738813128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2h6VqPwvBVdpdP0LT4AllXhem4WjK7tkni7E0ZVamc=;
        b=JvuCoiVTeVKb5KS2ou/lb4W6UQU0y6LRzszyQ79a2ZHlQb/EfSu1mB4XMKL4PU7B7K
         XEfmz3z7Dfe70L2swJ2yVzOKKRIYKzoLNfgQyx7GjXx6/Q+TikwkvSFnD8AWCacWkFFs
         beMcAQzdZ98NSbB6+226dbHUo79Xf0EmYyvkyADyn6rdNFnGwU0+I/SjFDbUb/AcEHD6
         5k014tr9xPC2sEEMClKDMfHvuiHenYmwrGOCQtT7rXyIDRuND5kOUt2yFlr3C2hFArvB
         g7sxCXgtRGEOoLGfZ61mFNlbqgj0JKJjmN4DGIZJCuAYSu0WXZ5ISNyAbeqOIXcs3vWv
         id6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738208328; x=1738813128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2h6VqPwvBVdpdP0LT4AllXhem4WjK7tkni7E0ZVamc=;
        b=rYl7+XGuOVhJ6guTjZszSNvXycBFBCsmlPzOa1Ixqp/Xm8ZuqebRJL2oTidnuVkW5i
         GRAbDBphhN1PyhI7r5umIAv5+9k1l2OUtKTDcRe628NZDsu4bWaAi4dT9k+OvdLZwEmX
         KsRqyg/i8YsVKWAGKbtPDSX5pt/OcX460Zv4Ni9kqCIAxp2uFD3ZIHW1hHzTirTD+igo
         GwxPi9G4V5hRdlDlWYrmL7GKPdiCyD1nSXyVStRj/2XYkbygqdJXXq9WuH5BI/hAC1fn
         t8h5MLjue/MOxfx7kMqt4s7rX59bSr8r1KUOOUUFSsp7wmJcX7wp6Ubua1nUZmAqAkXz
         EHTA==
X-Gm-Message-State: AOJu0YwS/VR8rZkvW0G0QaodYGbDP7KAZQ+U0/3pRMBDtYqOeQIW5blc
	Z4CjrdhyvZ+DdArGHHp54VhQv/EQcBsv6tqtH9Qckd0jTspxsdAmDrXJwX1FEQ==
X-Gm-Gg: ASbGncvrPNCw9lZNYMqlN2zlQdEe18nqoHrSnUG0pQY9eY/p2eCcwZi0J0V2MhM+OiQ
	e+JEzmCrSz2R/H33AxiNndTcYtcBOUc2BkIchzXZuPRy0g4RZU3Uu9yh4dD0XkBwg1pRPy/LTBm
	dz1zyVf5RM+eltxDsqF31RNyfSDD29SlcEtLPA7XgxNZeu6mxigsgGSNFwBJv1w6o9arG6Fsa8i
	jIHyxBNC7x8uhaFf5F3YMOYjslw8z/aBlVq3rBKCn8eV1/e24rxv/3+W0qQ35E6xlwAbcZ7BWUz
	eLI2d5zM0bqk6UQ1jcD/oFXg3pQi/W5zi7e9o2r1VqW9zCHVVsE=
X-Google-Smtp-Source: AGHT+IHf+GQ922YV6u5BNC7Ftbuq76Fd/ay4ZcRcje5lxIC7r0ijg+0L68jiiIT8FOmQyUwd54xnLw==
X-Received: by 2002:a17:903:298f:b0:216:6ecd:8950 with SMTP id d9443c01a7336-21de36cdb21mr885165ad.19.1738208328087;
        Wed, 29 Jan 2025 19:38:48 -0800 (PST)
Received: from google.com (55.131.16.34.bc.googleusercontent.com. [34.16.131.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796d6sm302970a12.55.2025.01.29.19.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 19:38:47 -0800 (PST)
Date: Thu, 30 Jan 2025 03:38:43 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z5r0Q-JXYPb3mCL-@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
 <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
 <CAADnVQ+5Ybu+rMBz5D-0GcZWemTwrzxy7vUfEiWpQ2CKugwwOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+5Ybu+rMBz5D-0GcZWemTwrzxy7vUfEiWpQ2CKugwwOA@mail.gmail.com>

Hi Alexei,

On Wed, Jan 29, 2025 at 04:41:31PM -0800, Alexei Starovoitov wrote:
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index da729cbbaeb9..ab082ab9d535 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1663,14 +1663,17 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
> >         INSN_3(JMP, JSET, K),                   \
> >         INSN_2(JMP, JA),                        \
> >         INSN_2(JMP32, JA),                      \
> > +       /* Atomic operations. */                \
> > +       INSN_3(STX, ATOMIC, B),                 \
> > +       INSN_3(STX, ATOMIC, H),                 \
> > +       INSN_3(STX, ATOMIC, W),                 \
> > +       INSN_3(STX, ATOMIC, DW),                \
> >         /* Store instructions. */               \
> >         /*   Register based. */                 \
> >         INSN_3(STX, MEM,  B),                   \
> >         INSN_3(STX, MEM,  H),                   \
> >         INSN_3(STX, MEM,  W),                   \
> >         INSN_3(STX, MEM,  DW),                  \
> > -       INSN_3(STX, ATOMIC, W),                 \
> > -       INSN_3(STX, ATOMIC, DW),                \
> >         /*   Immediate based. */                \
> >         INSN_3(ST, MEM, B),                     \
> >         INSN_3(ST, MEM, H),                     \
> > @@ -2169,6 +2172,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
> >
> >         STX_ATOMIC_DW:
> >         STX_ATOMIC_W:
> > +       STX_ATOMIC_H:
> > +       STX_ATOMIC_B:
> >                 switch (IMM) {
> >                 ATOMIC_ALU_OP(BPF_ADD, add)
> >                 ATOMIC_ALU_OP(BPF_AND, and)
> 
> STX_ATOMI_[BH] looks wrong.
> It will do atomic64_*() ops in wrong size.
> BPF_INSN_MAP() applies to bpf_opcode_in_insntable()
> and the verifier will allow such new insns.

We still have this check in check_atomic():

  if (BPF_SIZE(insn->code) != BPF_W && BPF_SIZE(insn->code) != BPF_DW) {
          verbose(env, "invalid atomic operand size\n");
          return -EINVAL;
  }

(moved to check_atomic_rmw() in PATCH 2/8)

Looks like it cannot be triggered before this patch, since
STX_ATOMIC_[BH] would've already been rejected by that
bpf_opcode_in_insntable() check before reaching check_atomic().

I agree that the interpreter code handling RMW atomics might now look a
bit confusing though.  In v2 I'll refactor that part and/or add comments
to make it clearer in the code that:

  * only W and DW are allowed for atomic RMW
  * all of B, H, W and DW are allowed for atomic load/store

Thanks,
Peilin Ye


