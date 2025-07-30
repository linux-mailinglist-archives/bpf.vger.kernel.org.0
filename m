Return-Path: <bpf+bounces-64753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42CB1693C
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC531AA2E20
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 23:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1823535E;
	Wed, 30 Jul 2025 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTtGk/a1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90422224FA;
	Wed, 30 Jul 2025 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753917221; cv=none; b=CbMmNFWiivJmIxotNAGee7dNHh4Wp6ODhbaVoreMl2LqRCIcgUeoRnEmE8GVOWln19eTTDMzu6xqxL7iBFZzBZCwjk5/js1WMO9iccgJn2RlFOdGprNF62gQtN+UFlFCWmJzHph/eM5UV0VhFCxqg1P3Jw5BAC6fKPtPlEsqlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753917221; c=relaxed/simple;
	bh=1fvEaaCn3jJxDIjHviECqTXmZPexpC0mVCG8Wmu+vCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9zRJnjLqtWrALZcLe29kRa+9bSerrXzaFI3d3iR7IP0Js1EEGO/9ERZpzmdRq3UQNrQIjVTMw3wv0APdjHcYOWvpXGlYPMSto7maD4FSvgj2dUDIJV5o2fOZT8n2KGH5vPHMk1XKeUwG1GTF4SSzcOVuHzfTQqHduHJPRViQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTtGk/a1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b79bdc9a7dso121329f8f.1;
        Wed, 30 Jul 2025 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753917217; x=1754522017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMOn1FATeMm5cX/CtQqze+8WZdpNhGzCjTWbaSvk6Z4=;
        b=JTtGk/a1DhwUzqHylyOfstDIVYyyDaiinl7jFSx4HL0jUcAtMzFQ5aykIZueFB4fMR
         NzZhdHVOjVDtG7ScVmA+TDHhfu0q2UgYA3F8u/BVZwSG0mcxDNAy76YFNDs0XCrvQeCw
         PSkUCmQxNwtIvHG9ACXu5PWNUDhSGbF5jFGiTpu4krY53y6GkSzGhyosKOefYjtN598s
         zwFu2ApaVvwJ5vxekzmJluQog529Fqr4Vp0C8UgGqLyavKuAKICXv5hExdOe7mVBjqK0
         YtSyC7GmdZigY4unCpSn5AB6KPxuI+urOtpqCcOh/kfCJgw32Er6C7Za04arrelzuh+x
         Z+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753917217; x=1754522017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMOn1FATeMm5cX/CtQqze+8WZdpNhGzCjTWbaSvk6Z4=;
        b=CPpJM1EWJ1AUJrX0l3NJRWy9IkUCiediGXJlo/Bi+2SLWRLwCzrJT/e/zFUprM0HUS
         qus1UiE0bJH84cXmyVUmJIDiIz2O5BpfCL1ZHjI/jTakKNeE9d8PMrEUQcollHA9Z0Dz
         KiuAibseBX3uiwralQARIRX2v/WLLMKAN5RcqumaHJDjLzRzad63rdfI78ACWU0t3i22
         lJwfoNr0QYQzcLeobdEfBlw8xb1n2PYOsbzWAWhoBLJ0FFKL2dD60heZvx6TGtmoOerT
         u8pbBpFg+c/Ebx2wrVOH/1PGdEJeNSHgxbWHvNZWT5irwxFApNqiwjKUEpmOkaDuAPx4
         J03w==
X-Forwarded-Encrypted: i=1; AJvYcCUxWOFqZFGujIAQQ1Txb9rw98VQG1EPPjMg7rbKX+8BTKEDAsTWaKtzxMP6WUMZwjMw7XM=@vger.kernel.org, AJvYcCVW+8TnG8SPiV7X/GEfgl0wkinIH2YJ2Ft9etU6RlnF2O2eI3DLvv14PpDhpw3r9n9KkCnv0W/GmSFQRkpxI57G@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNn7YsaArQ+ch8sB1WJ1jCD5Ef4H6vHXv079f/Mk8O4pkcBgi
	GW+8SE0fncKX1aeUEF1JHdhqVjU+l6A+VIC8HKPbQ81wvSvRMC7T8h9gRd+B9gQ4rK1aSEmofRg
	svhknx6EMhjQiMLChf/VyT3g5F+n7ZeY=
X-Gm-Gg: ASbGncsRd2djXi3Dc2xTP0m++gl0Crg1pwGQtz4bVs1w5HM6svlmfthzK6rrkNLFTsQ
	Yq4UbkJAZwixS+iKnlLV+EdTPIIRQf/S6XSNrQSX3kMxZfA36KMtQQnBWkKk6IAQ3yRnCs895WL
	20MygEUGqHO+FhEXBDQ6xMrkGoq/2uPu4iEZwRmA4IopXiL5mSYq143HYNORFNmkJPra9T3ZxwF
	uMuxDTZ/nfH78xtZnxKcEt6yGwDhPmLY6gY
X-Google-Smtp-Source: AGHT+IHAUFCWz0dr2TRplf2G3XNY7Aqop4IynhY1LwNHCbF/tiGDGUivbOCSlK3CwvB6NRukdHEpgLwdnsGA2h8hom8=
X-Received: by 2002:a05:6000:40e0:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3b79501d7d5mr4501574f8f.53.1753917216634; Wed, 30 Jul 2025
 16:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703204818.925464-1-memxor@gmail.com> <20250703204818.925464-9-memxor@gmail.com>
 <202507301559.C832A9C@keescook> <CAADnVQ+n-o2qeoLqvfJgY4wf9Ms-xs_SyEZhtfgkidqjX=u3qg@mail.gmail.com>
 <202507301608.C939FE7D9@keescook>
In-Reply-To: <202507301608.C939FE7D9@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Jul 2025 16:13:25 -0700
X-Gm-Features: Ac12FXwBXKKfeBXsBdBcxB6EUbVuK6HnARjo98DveD6-A6q02fFMerlvpbmiXeY
Message-ID: <CAADnVQLbgXxUROzhKhdK8v+2Z4f5nqV34rHMn2Q0PebUo+VqyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 08/12] bpf: Report rqspinlock
 deadlocks/timeout to BPF stderr
To: Kees Cook <kees@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 4:09=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Jul 30, 2025 at 04:07:33PM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 30, 2025 at 4:02=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > On Thu, Jul 03, 2025 at 01:48:14PM -0700, Kumar Kartikeya Dwivedi wro=
te:
> > > > +static void bpf_prog_report_rqspinlock_violation(const char *str, =
void *lock, bool irqsave)
> > > > +{
> > > > +     struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held=
_locks);
> > > > +     struct bpf_stream_stage ss;
> > > > +     struct bpf_prog *prog;
> > > > +
> > > > +     prog =3D bpf_prog_find_from_stack();
> > > > +     if (!prog)
> > > > +             return;
> > > > +     bpf_stream_stage(ss, prog, BPF_STDERR, ({
> > > > +             bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_loc=
k%s\n", str, irqsave ? "_irqsave" : "");
> > > > +             bpf_stream_printk(ss, "Attempted lock   =3D 0x%px\n",=
 lock);
> > > > +             bpf_stream_printk(ss, "Total held locks =3D %d\n", rq=
h->cnt);
> > > > +             for (int i =3D 0; i < min(RES_NR_HELD, rqh->cnt); i++=
)
> > > > +                     bpf_stream_printk(ss, "Held lock[%2d] =3D 0x%=
px\n", i, rqh->locks[i]);
> > > > +             bpf_stream_dump_stack(ss);
> > >
> > > Please don't include %px in stuff going back to userspace in standard
> > > error reporting. That's a kernel address leak:
> > > https://docs.kernel.org/process/deprecated.html#p-format-specifier
> > >
> > > I don't see any justification here, please remove the lock address or
> > > use regular %p to get a hashed value.
> >
> > There is no leak here.
> > The prog was loaded by root and error is read by root.
>
> uid has nothing to do with it. Leaking addresses needs the right
> capability set. Is that always true here?

yes. For bpf prog to use this kfunc it needs CAP_BPF and CAP_PERMON.
What's allowed under them is described in include/uapi/linux/capability.h

