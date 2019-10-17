Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA85DB955
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406545AbfJQVyS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 17:54:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54542 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391375AbfJQVyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 17:54:18 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLDii-0007XI-K9; Thu, 17 Oct 2019 23:54:08 +0200
Date:   Thu, 17 Oct 2019 23:54:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Miller <davem@davemloft.net>
cc:     Sebastian Sewior <bigeasy@linutronix.de>, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
In-Reply-To: <20191017.132548.2120028117307856274.davem@davemloft.net>
Message-ID: <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de> <20191017145358.GA26267@pc-63.home> <20191017154021.ndza4la3hntk4d4o@linutronix.de> <20191017.132548.2120028117307856274.davem@davemloft.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-854047423-1571348578=:1869"
Content-ID: <alpine.DEB.2.21.1910172343260.1869@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-854047423-1571348578=:1869
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1910172343261.1869@nanos.tec.linutronix.de>

On Thu, 17 Oct 2019, David Miller wrote:

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Thu, 17 Oct 2019 17:40:21 +0200
> 
> > On 2019-10-17 16:53:58 [+0200], Daniel Borkmann wrote:
> >> On Thu, Oct 17, 2019 at 11:05:01AM +0200, Sebastian Andrzej Siewior wrote:
> >> > Disable BPF on PREEMPT_RT because
> >> > - it allocates and frees memory in atomic context
> >> > - it uses up_read_non_owner()
> >> > - BPF_PROG_RUN() expects to be invoked in non-preemptible context
> >> 
> >> For the latter you'd also need to disable seccomp-BPF and everything
> >> cBPF related as they are /all/ invoked via BPF_PROG_RUN() ...
> > 
> > I looked at tracing and it depended on BPF_SYSCALL so I assumed they all
> > do… Now looking for BPF_PROG_RUN() there is PPP_FILTER,
> > NET_TEAM_MODE_LOADBALANCE and probably more.  I didn't find a symbol for
> > seccomp-BPF. 
> > Would it make sense to override BPF_PROG_RUN() and make each caller fail
> > instead? Other recommendations?
> 
> I hope you understand that basically you are disabling any packet sniffing
> on the system with this patch you are proposing.
> 
> This means no tcpdump, not wireshark, etc.  They will all become
> non-functional.
> 
> Turning off BPF just because PREEMPT_RT is enabled is a non-starter it is
> absolutely essential functionality for a Linux system at this point.

I'm all ears for an alternative solution. Here are the pain points:

  #1) BPF disables preemption unconditionally with no way to do a proper RT
      substitution like most other infrastructure in the kernel provides
      via spinlocks or other locking primitives.

  #2) BPF does allocations in atomic contexts, which is a dubious decision
      even for non RT. That's related to #1

  #3) BPF uses the up_read_non_owner() hackery which was only invented to
      deal with already existing horrors and not meant to be proliferated.

      Yes, I know it's a existing facility ....

TBH, I have no idea how to deal with those things. So the only way forward
for RT right now is to disable the whole thing.

Clark might have some insight from the product side for you how much that
impacts usability.

Thanks,

	tglx
--8323329-854047423-1571348578=:1869--
