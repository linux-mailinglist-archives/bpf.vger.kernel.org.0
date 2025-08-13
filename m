Return-Path: <bpf+bounces-65488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E99FCB2403A
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 07:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8157B436C
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 05:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4B2BE7BC;
	Wed, 13 Aug 2025 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oFFbHKfD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JR1S7p3O"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9CA1C6B4;
	Wed, 13 Aug 2025 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063282; cv=none; b=RcdIC5/x/wQlPsLryNlTwlDefDWLzzspJXZ30fr9QdHntlDS9W+ePDubrFjgBWrebW+x0f1jren6j/NzCrulqxknHt9iyruhMgZEj8m0JAvy9AHg9pTsFiZi/VD986JpwrKCQL+QDC+/GuA2/22PXQ7lKr+VsvE5UZD4a6u/AVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063282; c=relaxed/simple;
	bh=sSVyc0vfuS5JnCK6jVCCVVS26yC8zr9xB1KconvqMI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il4PWUJfyTbaVNLWtbGI2BZNk3S2I0vTpUhdrwT1+6hrm4YIlaOQZQsAsYmLgy6cbnI06LmqcOpCijUPQwbKMzGdXcQKnL/hdPa1kvaxUkek0+pTjO5cxO8rmpRmKOgifQVnWBzOEJng5wh4FREKhb8VkCderzWnfsJgZsNMdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oFFbHKfD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JR1S7p3O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Aug 2025 07:34:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755063275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRtAoFXM6CBbGd0bnclye/NT0dGHwWE/tDm5kNLRpMc=;
	b=oFFbHKfD6ucfHqJ0RRIgTieMgvuHoFbJBk8LpW5PkcH+AKeKSZq800ctzw8u2IiQkBfrr3
	YYeV5Jj+SiNOT5alzJFIrseKwe2yYdzGM/KeZmxVZ+K8Y/svnKYP0ucaCMQ11CgHkxmmRl
	OK+0FASNdgR/EQQk1UFOpV9/iqMl8dnYE9Mv6KFgtHFyHMcgaG0D43t3LT9/PQrFZOJORv
	AsumwGIKISH6UsL3iesLE0Tf+38QtjBeudpF7j9WV4dUjn1xLhv7gt70L5Q8RRshzoNpWl
	pfb4AqN1R4S2toFmrCjsDxb68I19rExFSz/QdlOMRcQ6q5smWaK/sDTWV2SLLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755063275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRtAoFXM6CBbGd0bnclye/NT0dGHwWE/tDm5kNLRpMc=;
	b=JR1S7p3Ob2pZKbds1Wr6oQ5wyg1CYq0XkgSMHVX2/pbdPo/cKR8fEKn+JkbO6MA1WOQ+GG
	AgVfKRaME3T2i4Dg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Don't use %pK through printk
Message-ID: <20250813072929-5c7eb9fd-bdc9-4fe3-b885-bfff31def14f@linutronix.de>
References: <20250811-restricted-pointers-bpf-v1-1-a1d7cc3cb9e7@linutronix.de>
 <CAEf4Bzb7DFwvh6J8sPv34U+M=prFKQ8QZiJAk2SE5hPvy7DG1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb7DFwvh6J8sPv34U+M=prFKQ8QZiJAk2SE5hPvy7DG1g@mail.gmail.com>

On Tue, Aug 12, 2025 at 03:19:45PM -0700, Andrii Nakryiko wrote:
> On Mon, Aug 11, 2025 at 5:08 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > In the past %pK was preferable to %p as it would not leak raw pointer
> > values into the kernel log.
> > Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> > the regular %p has been improved to avoid this issue.
> > Furthermore, restricted pointers ("%pK") were never meant to be used
> > through printk(). They can still unintentionally leak raw pointers or
> > acquire sleeping locks in atomic contexts.
> >
> > Switch to the regular pointer formatting which is safer and
> > easier to reason about.
> >
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  include/linux/filter.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 1e7fd3ee759e07534eee7d8b48cffa1dfea056fb..52fecb7a1fe36d233328aabbe5eadcbd7e07cc5a 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1296,7 +1296,7 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
> >  static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
> >                                 u32 pass, void *image)
> >  {
> > -       pr_err("flen=%u proglen=%u pass=%u image=%pK from=%s pid=%d\n", flen,
> > +       pr_err("flen=%u proglen=%u pass=%u image=%p from=%s pid=%d\n", flen,
> >                proglen, pass, image, current->comm, task_pid_nr(current));
> 
> this particular printk won't ever be called from atomic context, so I
> don't think the leak from atomic context matters much here. On the
> other hand, %pK behavior is controlled by kptr_restrict and that might
> be useful for debugging, so not sure there is much of a benefit to
> switching to always obfuscated %p? Or am I missing something else
> here?

As %pK is so easy to abuse and the breakage is very non-obvious, I want to
rework it to enforce its usage from "file context".
For that, the printk users need to be gone first.
For debugging, there is still "no_hash_pointers".

How would the image pointer be used for debugging?
It is logged from nowhere else.
And the raw image is dumped right after anyways.

> 
> >
> >         if (image)
> >
> > ---
> > base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> > change-id: 20250811-restricted-pointers-bpf-04da04ea1b8a
> >
> > Best regards,
> > --
> > Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> >

