Return-Path: <bpf+bounces-64752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33061B1693A
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343755A5304
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAD5233728;
	Wed, 30 Jul 2025 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujw1rsac"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169121B9E5;
	Wed, 30 Jul 2025 23:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916975; cv=none; b=aAo0QFSD+NGqd/4D7lZH3puImKQhj+j+uaJoKRW5O+IImDKqhnCX2tTHqQRRQ7mJyyr0KisGAfm00JRrfQJTB7eYQWAHthlYErrHprlhyYpVDU/77MG3qg7+SC77epF/2DQhAqObZX82Oj3Ed27NQJ37nLfKzzQjR1flLKGzLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916975; c=relaxed/simple;
	bh=9giMc5WMQXjyGCWYoASdEp0L/eswvvx0aKagdhNO0eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvUNc760r/+LvPl+SVRvgl4t4iEce9ao3EFSqAxHKDcxqO+Hglj7fyv6qxfPXZM6IrpHgxEZR46GuOzfosmNbZZkXfE75SYavPgA48bzTQAuXbphJAgMGTT7nStOUC6zjty+CXIgGH58k6nQYhZVWsw6TXIhCu/j1M4HvtMpRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujw1rsac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40958C4CEE3;
	Wed, 30 Jul 2025 23:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753916974;
	bh=9giMc5WMQXjyGCWYoASdEp0L/eswvvx0aKagdhNO0eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujw1rsac4ShwBzFx/XxeCcf4PhNaIpMbDoc3/6uhOHJtCoVFilWGfhlODjGe11ySM
	 H/4kkJ6cS+X4engEZ6sRcGcPLseHdf+14vdLbtv4AIvFF+4Z6KNrhMuXO1uJGp0mFu
	 yO7mDGbIXhMWe2bgOyww2D984DiGCwKrX5wbA2PmUnO3On6awpdWB0jwG4r12INY4A
	 rEUTt083ct6N4aTAlUJwpsOoy7trQQlzagqomTFgZlLBhzo8v/Jg0ZXpmn11C1TEw/
	 Sw6kxH94ZG5R9c54a5CGRGY0ffj1AS1w6lFe6V8JlWaC1YZ+5jSs0AMEWEoWuUd/Kh
	 KQBr/FFxFpwLw==
Date: Wed, 30 Jul 2025 16:09:33 -0700
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
Message-ID: <202507301608.C939FE7D9@keescook>
References: <20250703204818.925464-1-memxor@gmail.com>
 <20250703204818.925464-9-memxor@gmail.com>
 <202507301559.C832A9C@keescook>
 <CAADnVQ+n-o2qeoLqvfJgY4wf9Ms-xs_SyEZhtfgkidqjX=u3qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+n-o2qeoLqvfJgY4wf9Ms-xs_SyEZhtfgkidqjX=u3qg@mail.gmail.com>

On Wed, Jul 30, 2025 at 04:07:33PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 30, 2025 at 4:02 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Thu, Jul 03, 2025 at 01:48:14PM -0700, Kumar Kartikeya Dwivedi wrote:
> > > +static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bool irqsave)
> > > +{
> > > +     struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
> > > +     struct bpf_stream_stage ss;
> > > +     struct bpf_prog *prog;
> > > +
> > > +     prog = bpf_prog_find_from_stack();
> > > +     if (!prog)
> > > +             return;
> > > +     bpf_stream_stage(ss, prog, BPF_STDERR, ({
> > > +             bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
> > > +             bpf_stream_printk(ss, "Attempted lock   = 0x%px\n", lock);
> > > +             bpf_stream_printk(ss, "Total held locks = %d\n", rqh->cnt);
> > > +             for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
> > > +                     bpf_stream_printk(ss, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
> > > +             bpf_stream_dump_stack(ss);
> >
> > Please don't include %px in stuff going back to userspace in standard
> > error reporting. That's a kernel address leak:
> > https://docs.kernel.org/process/deprecated.html#p-format-specifier
> >
> > I don't see any justification here, please remove the lock address or
> > use regular %p to get a hashed value.
> 
> There is no leak here.
> The prog was loaded by root and error is read by root.

uid has nothing to do with it. Leaking addresses needs the right
capability set. Is that always true here?

-- 
Kees Cook

