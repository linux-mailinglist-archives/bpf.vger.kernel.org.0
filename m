Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63934DB98B
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 00:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438094AbfJQWL4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 18:11:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54603 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfJQWL4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 18:11:56 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLDzf-0007mT-So; Fri, 18 Oct 2019 00:11:40 +0200
Date:   Fri, 18 Oct 2019 00:11:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Miller <davem@davemloft.net>
cc:     Sebastian Sewior <bigeasy@linutronix.de>, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
In-Reply-To: <20191017.132548.2120028117307856274.davem@davemloft.net>
Message-ID: <alpine.DEB.2.21.1910180006110.1869@nanos.tec.linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de> <20191017145358.GA26267@pc-63.home> <20191017154021.ndza4la3hntk4d4o@linutronix.de> <20191017.132548.2120028117307856274.davem@davemloft.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2141773991-1571350299=:1869"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2141773991-1571350299=:1869
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

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

Just for the record.

tcpdump and wireshark work perfectly fine on a BPF disabled kernel at least
in the limited way I am using them.

They might become non functional in a decade from now but I assume that we
find a solution for those problems until then.

Thanks,

	tglx
--8323329-2141773991-1571350299=:1869--
