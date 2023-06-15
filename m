Return-Path: <bpf+bounces-2676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDD5732056
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E088328134B
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF244EAED;
	Thu, 15 Jun 2023 19:32:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA672E0F5
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 19:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030F7C433C0;
	Thu, 15 Jun 2023 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686857571;
	bh=igXblj4FUuKACLErBDsXYRscsSkvmX/zqPqemYsJenY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=aVOrFX7YA6lIcJ5JZRhYw086xITxONy48/kleDDcmtSrQIpsZoJud5AM0ZE6dPH6d
	 QYDWKIyKQfbyGniz9m4dyv2TTBsOemZ8dP5rhq+DxesdbGBnoDnIlKpJhdtPWSTEKL
	 OKWNWlLDQ85lgI5KnCPe0xSsr/96KktsNhPuUF4h2/Pb90ONd6/4jas8VkpcItl8su
	 /MZsOB82uxLQ97glt1FuwCRkErkurlTO95YkAQezYpSXi2nAZnmsPfvLIbVuvLo8Hj
	 YaxsVuXgsXosLY+gqiKUScnlya4bOOhxUJ2bPmuMdjk0BsagpGgD7JvKZzoVPfSRsB
	 U224siMaDA/yA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 91DACCE3AE9; Thu, 15 Jun 2023 12:32:50 -0700 (PDT)
Date: Thu, 15 Jun 2023 12:32:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <e26e43f1-784f-49f0-ac87-6e38c8ceb61f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de>
 <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
 <20230526112356.fOlWmeOF@linutronix.de>
 <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
 <20230605163733.LD-UCcso@linutronix.de>
 <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
 <20230614083430.oENawF8f@linutronix.de>
 <0658d317-4f44-4b74-8234-8dc037505f77@paulmck-laptop>
 <20230615191341.eAOiYzuZ@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615191341.eAOiYzuZ@linutronix.de>

On Thu, Jun 15, 2023 at 09:13:41PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-06-15 09:43:11 [-0700], Paul E. McKenney wrote:
> > On Wed, Jun 14, 2023 at 10:34:30AM +0200, Sebastian Andrzej Siewior wrote:
> > > bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
> > > invoked within softirq context. By setting rcutree.use_softirq=0 boot
> > > option the RCU callbacks will be invoked in a per-CPU kthread with
> > > bottom halves disabled which implies a RCU read section.
> > > 
> > > On PREEMPT_RT the context remains fully preemptible. The RCU read
> > > section however does not allow schedule() invocation. The latter happens
> > > in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
> > > from bpf_link_put().
> > 
> > Just to make sure that I understand, you are proposing that the RCU
> > callbacks continue to run with BH disabled, but that BH-disabled regions
> > are preemptible in kernels built with CONFIG_PREEMPT_RT=y?
> > 
> > Or did I miss a turn in there somewhere?
> 
> I'm not proposing anything, just stating what we have. On PREEMPT_RT
> you are preemptible within the RCU callback but must not invoke
> schedule(). Similar to the RCU read section on CONFIG_PREEMPT where you
> are preemptible but must not invoke schedule(). 

Thank you for the clarification!

The main risk of preemptible RCU callbacks is callback flooding, but
RCU priority boosting should take care of that.

							Thanx, Paul

