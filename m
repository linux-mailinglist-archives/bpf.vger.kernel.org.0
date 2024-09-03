Return-Path: <bpf+bounces-38844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5596ABDE
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 00:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F039A286D81
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 22:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E611D58B8;
	Tue,  3 Sep 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGEBxxsx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308E18FDBA;
	Tue,  3 Sep 2024 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401449; cv=none; b=WmaiNxjhVy4ufB+jYq6AFyDo2JTwKixYWUDSGfaWQ+lSwdQ5q7ENraVvxcFipRJWGHCcqm/Dbatwjz2UvEEgULf47A3nqQxcio32Z6Td5jojeKVcx1xQCPbKVVNP72uLuHSfuawfxoHZDLAfiRZ/gh4X5aeeQVkfg4Pvm4Ykcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401449; c=relaxed/simple;
	bh=YToOnPwe4/lMBc4WWQWOR4PxqLZrjW8XUk2WGpI41eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pda8cJsRwEbzaoeB0qrD38Y7N9+vfAhq3Ue3Cf0Xu3u5COWje+ieTL9997HsoBTuYr6WbuAkqpScRXn+yF2eH2Zx1hv9QbkKKXxf9fjQnmKE3Emyh7X2KxPEFm8P8wCFu1SgCvboelKgjKDtQtzOjMBunsUhmN/hP6+NRq7qu2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGEBxxsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E05C4CEC4;
	Tue,  3 Sep 2024 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725401448;
	bh=YToOnPwe4/lMBc4WWQWOR4PxqLZrjW8XUk2WGpI41eE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OGEBxxsxxFiomc9WIP8k3FtI28wTvOWbmS16bjsqc2KKzk89r6CSpn1kNpoFsunGf
	 Uaj3DFB5j8PDhi9VUYv4Wlpv2Gf5q1ZHZbK250WQQ9NXicwfbbmp+4oG1cd2H/9cys
	 CKDYuO2dre3iJbAm8sIUaRMiD9ZNaQvPtsowlNv7X0kgBb3sVX5DQXtMQyo/44pIlH
	 IoVfA3VpJuSusTl5Y6hv++u2uCd6f/+g8CkVBbbkktlR9pJQIGR0Wh9+OLOArL/t7n
	 +Cdx7HtuL3vUNt07VE9zKIl4nClf+fdGRVnCiV/F7pTcTC+MRlom0FHgYqqdT+acKb
	 z+JvDPlDE5NMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 05E4DCE1257; Tue,  3 Sep 2024 15:10:48 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:10:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH rcu 07/11] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
Message-ID: <2e8c01a3-4ad7-4c4b-a697-acebdf7db8ad@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
 <20240903163318.480678-7-paulmck@kernel.org>
 <CAADnVQJCRksMjpKzpNFNXR4ZggnuLN4yTmBbFCr5YW33bbwSwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJCRksMjpKzpNFNXR4ZggnuLN4yTmBbFCr5YW33bbwSwQ@mail.gmail.com>

On Tue, Sep 03, 2024 at 12:45:23PM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 3, 2024 at 9:33 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 84daaa33ea0ab..4ba96e2cfa405 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> ...
> 
> > +static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
> > +{
> > +       int retval;
> > +
> > +       srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
> > +       retval = __srcu_read_lock_lite(ssp);
> > +       rcu_try_lock_acquire(&ssp->dep_map);
> > +       return retval;
> > +}
> 
> ...
> 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 602b4b8c4b891..bab888e86b9bb 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > +int __srcu_read_lock_lite(struct srcu_struct *ssp)
> > +{
> > +       int idx;
> > +
> > +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
> > +       idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > +       this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
> > +       barrier(); /* Avoid leaking the critical section. */
> > +       return idx;
> > +}
> > +EXPORT_SYMBOL_GPL(__srcu_read_lock_lite);
> 
> The use cases where smp_mb() penalty is noticeable probably will notice
> the cost of extra call too.
> Can the main part be in srcu.h as well to make it truly "lite" ?
> Otherwise we'd have to rely on compilers doing LTO which may or may not happen.

I vaguely recall #include issues for old-times srcu_read_lock() and
srcu_read_unlock(), but I will try it and see what happens.

In the meantime, if you are too curious for your own good...  ;-)

One way to check the performance is to work in the other direction.  For
example, add ndelay(10) or similar to the current srcu_read_lock_lite()
implementation and seeing if this is visible at the system level.

							Thanx, Paul

