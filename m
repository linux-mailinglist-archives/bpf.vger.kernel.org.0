Return-Path: <bpf+bounces-50879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94062A2DAAF
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 04:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869AC3A6A86
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 03:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4FC18E25;
	Sun,  9 Feb 2025 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSARVwGe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326018AE2;
	Sun,  9 Feb 2025 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739072829; cv=none; b=VarxsSJHLMGakDNtPBEyBOqg23kcOSwOQGWEMEZ5zJAV0AUXa5MgeUIokamV8L1yHVjyeaCjYe2AGyfjtXzdaITJLEO6MyoAS7U6F3UnQ1g+YwUDdfNspurAfJQB8/apOl77p2+G2eFBAbF1RdtXLDLd9q/B1j7x8jKRBcdclq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739072829; c=relaxed/simple;
	bh=pAbTcBcqnkEDr++cvXShfYLcz9ZAMkFCjXF1DdPj4tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCXXv91CYbcSmiyVtHM19TVz7CRf4Q1w1X5hCC+fFB1FHqfrxVXM7/ePaSu6OtdnGf2ChUn6bYNk+jdykyq9tE9jPaF2E9ZpY4Fh0P+ulj5HgEgk0R2FVXAA/hzWIpm2eBkOT72/lVC01BqpgZ/8hdSqHOlZABQso5148MmRF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSARVwGe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso3297294f8f.2;
        Sat, 08 Feb 2025 19:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739072826; x=1739677626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9QGCEe4s4f07RDG6bDFRWUa5WupjjYHN4Gq0S0QTJU=;
        b=QSARVwGetdR8idy9Y+0bL6sJtw3uRr/61pQ/n4aPtoNQrQQQpGLuHMdxAoqI9/x9Yu
         6+r1SP3xoYXLnO/itGL7YZhbRV0hSiCc2X0vlaMybKkalfqh+/hXqfomMHiCPMPOc/9h
         XbXJUfsr+zXDqjxb3tjSrrCFkazMaWUtS31GSGrgRzdKLR32cTBJ8ADbshZAaAUVD4eM
         rXIruBmVpYy89gik4B/P+InXX6W8fighzE8Kk5cGUYSbe9dUlXpy1qFd+c0uJ0hJBDQu
         XTmLfy1Pvck6zxkSmoKhJkEWqBad3znMpz6t4s0qN/96ApqEeVBuqFvAJcOchAhkS6gD
         MYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739072826; x=1739677626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9QGCEe4s4f07RDG6bDFRWUa5WupjjYHN4Gq0S0QTJU=;
        b=giVnelTHvOrF1SCZRfUb57Nyqdi96f/GScDklFzGVoIzwBi5zcDjVx8u5mFeBjUDL4
         ONUb1BC7NzQeXnyjWgcp7S5wSVw1pVxvYPsSUTH9qzmIH6z3ZRzVM4unWQX7XzMqnPSe
         BHXOMbOlgq7rvJMFOKjuxNIe2RF4iwhEa1o0w9Z/2PLjDZXAyPeGjcza0eqCe5zEqQG3
         1y8kotUjEcwPCmwSKltM7hVJy1iXYtj5lQvzhWrTZRURAY055RjJR+dAIs5fb16KRbrM
         P7Sv7zB3GHXkmCtuXwnJiCXFdCjvFlJnT0MLCF2rLZAOAnmtC+QwulgiPiTs65QJUXP/
         NeHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoBW+96Lq4wAejMZOuISHMNP3rb27bCp7WEjHn2mypyoAXbjKzn0jOHi/JoJgOEl2lobYCyEw+B9IieQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiI7KwpPUQcmYldctznlJ1pk3LkP1BElBoEnJlMUA1Gj03M0E7
	ylrPAfPDF5Zh/di5GLEw1PT1eHCeGGKrvrKKZG65iIUuHm7Sfy8/6lbNbKI6tFbA6mk8tTm9qjx
	P1W795dnpWzGg7xcG92C43thx2oY=
X-Gm-Gg: ASbGnctPO92wblzgzJzNeYykTXAjh1jAmMjTVA6brEWHEMQzOUmIA7vPn0y+bKxgDY3
	ekj4mX7PZ00qQ7ZBCOzDS3EmcUVpqfdN5QO2ADoh5dlN68fKg4ZdOGO0OpAzCxP1IhbBKYL9enw
	RupsIHfbnbX2vCVMTLEzuIGUROFY4A
X-Google-Smtp-Source: AGHT+IF8qpP7A+++uJooWGB2HYk2iXUbQzNwWZlU1Ir/ZBmmG/NjHXNgAp0R6jE703cBXGA5ZDTGWW24Bz9vvqWovbY=
X-Received: by 2002:a05:6000:2c2:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38dc8ddc464mr7061834f8f.20.1739072825622; Sat, 08 Feb 2025
 19:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738888641.git.yepeilin@google.com> <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
 <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com> <Z6gRHDLfA7cjnlSn@google.com>
In-Reply-To: <Z6gRHDLfA7cjnlSn@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 8 Feb 2025 19:46:54 -0800
X-Gm-Features: AWEUYZmrws4n9Tklxz5TlDMfaZkKg_EoOGMe8Vohc-FDZY-WZlDb1JfHtCemc_I
Message-ID: <CAADnVQLkHA9LGv99k2TZOJEGUU=dw=q6nVurJ=aoh0v6cFS6zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 6:21=E2=80=AFPM Peilin Ye <yepeilin@google.com> wrot=
e:
>
> Hi Alexei,
>
> On Sat, Feb 08, 2025 at 01:30:46PM -0800, Alexei Starovoitov wrote:
> > > Introduce BPF instructions with load-acquire and store-release
> > > semantics, as discussed in [1].  The following new flags are defined:
> > >
> > >   BPF_ATOMIC_LOAD         0x10
> > >   BPF_ATOMIC_STORE        0x20
> > >   BPF_ATOMIC_TYPE(imm)    ((imm) & 0xf0)
> > >
> > >   BPF_RELAXED        0x0
> > >   BPF_ACQUIRE        0x1
> > >   BPF_RELEASE        0x2
> > >   BPF_ACQ_REL        0x3
> > >   BPF_SEQ_CST        0x4
> >
> > I still don't like this.
> >
> > Earlier you said:
> >
> > > If yes, I think we either:
> > >
> > >  (a) add more flags to imm<4-7>: maybe LOAD_SEQ_CST (0x3) and
> > >      STORE_SEQ_CST (0x6); need to skip OR (0x4) and AND (0x5) used by
> > >      RMW atomics
> > >  (b) specify memorder in imm<0-3>
> > >
> > > I chose (b) for fewer "What would be a good numerical value so that R=
MW
> > > atomics won't need to use it in imm<4-7>?" questions to answer.
> > >
> > > If we're having dedicated fields for memorder, I think it's better to
> > > define all possible values once and for all, just so that e.g. 0x2 wi=
ll
> > > always mean RELEASE in a memorder field.  Initially I defined all six=
 of
> > > them [2], then Yonghong suggested dropping CONSUME [3].
> >
> > I don't think we should be defining "all possible values",
> > since these are the values that llvm and C model supports,
> > but do we have any plans to support anything bug ld_acq/st_rel ?
> > I haven't heard anything.
> > What even the meaning of BPF_ATOMIC_LOAD | BPF_ACQ_REL ?
> >
> > What does the verifier suppose to do? reject for now? and then what?
> > Map to what insn?
> >
> > These values might imply that bpf infra is supposed to map all the valu=
es
> > to cpu instructions, but that's not what we're doing here.
> > We're only dealing with two specific instructions.
> > We're not defining a memory model for all future new instructions.
>
> Got it!  In v3, I'll change it back to:
>
>   #define BPF_LOAD_ACQ   0x10
>   #define BPF_STORE_REL  0x20

why not 1 and 2 ?
All other bits are reserved and the verifier will make sure they're zero,
so when/if we need to extend it then it wouldn't matter whether
lower 4 bits are reserved or other bits.
Say, we decide to support cmpwait_relaxed as a new insn.
It can take the value 3 and arm64 JIT will map it to ldxr+wfe+...

Then with this new load_acq and cmpwait_relaxed we can efficiently
implement both smp_cond_load_relaxed and smp_cond_load_acquire.

