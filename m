Return-Path: <bpf+bounces-64754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C9B16941
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0929165849
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 23:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00122CBD9;
	Wed, 30 Jul 2025 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqrsQlqt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9C84D13;
	Wed, 30 Jul 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753917565; cv=none; b=rmevvHkS7OxWqtEPu4RrCi+Q2t4KTAB297E6D2T/bAF+7tw4H1xNxhheavEi3Fb4VaRg2ZJnWRzUlwaCvLrpAq+h5EkZX228Mq04WivvX6xRRkIkVW8wjEVi7/Egumylz33++IwNQByZM5lZAzFSj6BXWg4xnIOiH7Kgx2/2bws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753917565; c=relaxed/simple;
	bh=TdwkDPId7wYFe/ttb+9uYm/jPwmfM95FDQAoEbN0O/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4K4OHVyDiC6Wr0sU5+q3DkqwcXhoU64QHOZQE6vv9W6C3PsKJAvjOn2F0+OEa4iGErfh7AAuINy2GaK0HMaMls21zPtMxti485byeoiIKUUi95xfwWU4pgItIFLytpzIkgSkgdcOOj3YOxmM+gIfuI+mWQT6zJo7LQWsbIjeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqrsQlqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D913C4CEEB;
	Wed, 30 Jul 2025 23:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753917564;
	bh=TdwkDPId7wYFe/ttb+9uYm/jPwmfM95FDQAoEbN0O/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqrsQlqtsobMlGsKf8PggnusesVb+0dPxdxMrt2rP34ch9qvfpfZYJ0+wvGe3ISK8
	 dHSjYNfmFMd9G0aj4R2BFesYEsB6E4TUmVe3FK8VwS/m2mFdeZHJY99koiC/Dzuwr0
	 b6aVXT3arzenWvswzTcFS2w3T+ycUqoqsMY2AHiu4qbBd+S4qcRIxo3BglZZ/MeTDl
	 xdpoE9T6cFv9dAHDHRyGjaKgzlaSiVUeE1Hvx+maljzWanjddQo27LkRQ4UGh1i6Qp
	 4bWZdtgEzj6bDkl2apMkpQk5IOEcOJ1yjlQxIx/8AecAG9H6aRvU7U00Jr7z6H3Tjo
	 fG/RPninnk55A==
Date: Wed, 30 Jul 2025 16:19:23 -0700
From: Kees Cook <kees@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com,
	Kernel Team <kernel-team@meta.com>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 08/12] bpf: Report rqspinlock
 deadlocks/timeout to BPF stderr
Message-ID: <202507301618.ABE8A9BB23@keescook>
References: <20250703204818.925464-1-memxor@gmail.com>
 <20250703204818.925464-9-memxor@gmail.com>
 <202507301559.C832A9C@keescook>
 <CAADnVQ+n-o2qeoLqvfJgY4wf9Ms-xs_SyEZhtfgkidqjX=u3qg@mail.gmail.com>
 <202507301608.C939FE7D9@keescook>
 <CAADnVQLbgXxUROzhKhdK8v+2Z4f5nqV34rHMn2Q0PebUo+VqyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLbgXxUROzhKhdK8v+2Z4f5nqV34rHMn2Q0PebUo+VqyQ@mail.gmail.com>

On Wed, Jul 30, 2025 at 04:13:25PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 30, 2025 at 4:09 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Wed, Jul 30, 2025 at 04:07:33PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Jul 30, 2025 at 4:02 PM Kees Cook <kees@kernel.org> wrote:
> > > >
> > > > On Thu, Jul 03, 2025 at 01:48:14PM -0700, Kumar Kartikeya Dwivedi wrote:
> > > > > +static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bool irqsave)
> > > > > +{
> > > > > +     struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> > > > > +     struct bpf_stream_stage ss;
> > > > > +     struct bpf_prog *prog;
> > > > > +
> > > > > +     prog = bpf_prog_find_from_stack();
> > > > > +     if (!prog)
> > > > > +             return;
> > > > > +     bpf_stream_stage(ss, prog, BPF_STDERR, ({
> > > > > +             bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
> > > > > +             bpf_stream_printk(ss, "Attempted lock   = 0x%px\n", lock);
> > > > > +             bpf_stream_printk(ss, "Total held locks = %d\n", rqh->cnt);
> > > > > +             for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
> > > > > +                     bpf_stream_printk(ss, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
> > > > > +             bpf_stream_dump_stack(ss);
> > > >
> > > > Please don't include %px in stuff going back to userspace in standard
> > > > error reporting. That's a kernel address leak:
> > > > https://docs.kernel.org/process/deprecated.html#p-format-specifier
> > > >
> > > > I don't see any justification here, please remove the lock address or
> > > > use regular %p to get a hashed value.
> > >
> > > There is no leak here.
> > > The prog was loaded by root and error is read by root.
> >
> > uid has nothing to do with it. Leaking addresses needs the right
> > capability set. Is that always true here?
> 
> yes. For bpf prog to use this kfunc it needs CAP_BPF and CAP_PERMON.
> What's allowed under them is described in include/uapi/linux/capability.h

Okay, thanks! That wasn't detailed in the commit log (for folks like me
with less familiarity with BPF), so I just got worried when I saw
"stderr" mentioned. :)

-- 
Kees Cook

