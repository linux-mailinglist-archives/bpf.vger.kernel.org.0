Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE0DBA4E
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 01:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441779AbfJQXuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 19:50:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438680AbfJQXuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 19:50:20 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLFWz-0000L5-OD; Fri, 18 Oct 2019 01:50:09 +0200
Date:   Fri, 18 Oct 2019 01:50:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Miller <davem@davemloft.net>
cc:     Sebastian Sewior <bigeasy@linutronix.de>, daniel@iogearbox.net,
        bpf@vger.kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
In-Reply-To: <20191017.151335.597242104804050107.davem@davemloft.net>
Message-ID: <alpine.DEB.2.21.1910180041430.1869@nanos.tec.linutronix.de>
References: <20191017154021.ndza4la3hntk4d4o@linutronix.de> <20191017.132548.2120028117307856274.davem@davemloft.net> <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de> <20191017.151335.597242104804050107.davem@davemloft.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David,

On Thu, 17 Oct 2019, David Miller wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, 17 Oct 2019 23:54:07 +0200 (CEST)
> 
> > Clark might have some insight from the product side for you how much that
> > impacts usability.
> 
> You won't even be able to load systemd, it uses bpf.

As I said before: At some point in the future from now.

Right now I'm writing this mail from a Debian testing system which runs a
kernel with Sebastians patch applied. That means a halfways recent systemd
started just fine and everything works.

You surely made your point.
 
> We're moving to the point where even LSM modules will be implemented in bpf.

Emphasis on 'We're moving'. Which means this is in progress and not after
the fact. 

> IR drivers require bpf:
> 
> 	https://lwn.net/Articles/759188/

The fact that IR drivers require BPF is not a real convincing argument
either.

  Guess how many RT systems depend on functional IR drivers?

  Guess how many other subsystems are not RT safe and disabled on RT and
  still RT is successfully deployed in production?

Quoting from the other end of that thread just to avoid fragmentation:

> > tcpdump and wireshark work perfectly fine on a BPF disabled kernel at least
> > in the limited way I am using them.
>
> Yes it works, but with every packet flowing through the system getting
> copied into userspace.  This takes us back to 1992 :-)

Guess what? RT real world deployments survived for the past 15 years on the
packet sniffing state of 1992. There is a world outside of networking...

> I understand the problems, and realize they are non-trivial, but this hammer
> is really destructive on a fundamental level.

The fundamentally desctructive component is that this whole thread does not
provide any form of constructive feedback.

 - Sebastians changelog has a list of the issues
 - I expanded on those

All we got as a reply is a destructive NO along with a long list of half
baken arguments why temporary disabling of this functionality solely for RT
is unacceptable.

It's probably also solely my (our / RT folks) problem that BPF made design
decisions which are focussed on (network) performance without considering
any other already existing constraints.

Sure we have the usual policy that we don't care about out of tree stuff
and it's the problem of the out of tree folks to deal with that, but I
politely ask you to think hard about this in the context of RT.

I'm going to shut up for now and wait for constructive and reasonable
feedback how to tackle these issues on a technical level.

Thanks,

	Thomas
