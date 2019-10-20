Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CABDDD6C
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2019 11:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfJTJGi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Oct 2019 05:06:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60111 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJTJGi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Oct 2019 05:06:38 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iM7AK-0006wx-Kg; Sun, 20 Oct 2019 11:06:20 +0200
Date:   Sun, 20 Oct 2019 11:06:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc:     David Miller <davem@davemloft.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
In-Reply-To: <20191018230540.l6e4jtrlu44hk7q5@ast-mbp>
Message-ID: <alpine.DEB.2.21.1910201043460.2090@nanos.tec.linutronix.de>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de> <20191017145358.GA26267@pc-63.home> <20191017154021.ndza4la3hntk4d4o@linutronix.de> <20191017.132548.2120028117307856274.davem@davemloft.net> <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <CAADnVQJPJubTx0TxcXnbCfavcQDZeu8VTnYYpa8JYpWw9Ze4qg@mail.gmail.com> <alpine.DEB.2.21.1910180152110.1869@nanos.tec.linutronix.de> <20191018055222.cwx5dmj6pppqzcpc@ast-mbp> <alpine.DEB.2.21.1910181256120.1869@nanos.tec.linutronix.de>
 <20191018230540.l6e4jtrlu44hk7q5@ast-mbp>
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

On Fri, 18 Oct 2019, Alexei Starovoitov wrote:
> On Fri, Oct 18, 2019 at 01:28:21PM +0200, Thomas Gleixner wrote:
> The concept on local_lock() makes sense to me.
> The magic macro you're proposing that will convert it to old school
> preempt_disable() on !RT should hopefully make the changes across
> net and bpf land mostly mechanical.
> One thing to clarify:
> when networking core interacts with bpf we know that bh doesn't migrate,
> so per-cpu datastructres that bpf side populates are accessed later
> by networking core when program finishes.
> Similar thing happens between tracing bits and bpf progs.
> It feels to me that local_lock() approach should work here as well.
> napi processing bits will grab it. Later bpf will grab potentially
> the same lock again.
> The weird bit that such lock will have numbe_of_lockers >= 1
> for long periods of time. At least until napi runners won't see
> any more incoming packets. I'm not sure yet where such local_lock
> will be placed in the napi code (may be in drivers too for xdp).
> Does this make sense from RT perspective?

I don't see why the lock would have more than one locker. The code in BPF
does

	preempt_disable();
	some operation
	preempt_enable();

So how should that gain more than one context per CPU locking it?

> > > BPF also doesn't have unbound runtime.
> > > So two above issues are actually non-issues.
> > 
> > That'd be nice :)
> > 
> > Anyway, we'll have a look whether this can be solved with local locks which
> > would be nice, but that still does not solve the issue with the non_owner
> > release of the rwsem.
> 
> Sure. We can discuss this separately.
> up_read_non_owner is used only by build_id mode of stack collectors.
> We can disable it for RT for long time. We're using stack with build_id heavily
> and have no plans to use RT. I believe datacenters, in general, are not going
> to use RT for foreseeable future, so a trade off between stack with build_id
> vs RT, I think, is acceptable.
> 
> But reading your other replies the gradual approach we're discussing here
> doesn't sound acceptable ?

I don't know how you read anything like that out of my replies. I clearly
said that we are interested in supporting BPF and you are replying to a
sentence where I clearly said:

  Anyway, we'll have a look whether this can be solved with local locks...

> And you guys insist on disabling bpf under RT just to merge some out of
> tree code ?

Where did I insist on that?

Also you might have to accept that there is a world outside of BPF and that
the 'some out of tree code' which we are talking about is the last part of
a 15+ years effort which significantly helped to bring the Linux kernel
into the shape it is today.

> I find this rude and not acceptable.

I call it a pragmatic approach to solve a real world problem.

> If RT wants to get merged it should be disabled when BPF is on
> and not the other way around.

Of course I could have done that right away without even talking to
you. That'd have been dishonest and sneaky.

It's sad that the discussion between the two of us which started perfectly
fine on a purely technical level had to degrade this way.

If your attitude of wilfully misinterpreting my mails and intentions
continues, I'm surely going this route.

Thanks,

	tglx
