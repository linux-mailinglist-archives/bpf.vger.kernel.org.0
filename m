Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14439DD52B
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2019 01:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfJRXFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 19:05:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39316 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJRXFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 19:05:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so3537436plp.6
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AH3jrOFqzFSDzm5MfjtOgoAoOgfHRxzMVOBqcozOwFo=;
        b=LW8UcDdVGwW2bYTwGCLaIYNVagQGILt+rVTTLMWlddXsHu3UseQcc4vY1pe5iN0JkC
         /2VHBWqcSXe5IRhSxakKIhPlX7rDYTxPy36PggeI6cj2O2DCMAOTgS/xytMFiRstsKwF
         i4PoWaZG7Z9CtNP7XcgmpfqfUbR337+l2Lmf6tBJPUk/oehkSCml0g/MfBaUUXrI2ERD
         RAVKIwHG77cEIxyg7FTfnHJFcLCXbCMK3WHYnmNB5W9fcOnFX+wYg37Ppf9MvF6SBU5l
         DjvN0BE9eYBGs0fbZOzvn2Phi8s0J2c0uy2lMyCKepSRN6wWKbF6lbGujfwWTH9r/ZHW
         4n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AH3jrOFqzFSDzm5MfjtOgoAoOgfHRxzMVOBqcozOwFo=;
        b=FfqV+B023e0ZS6G8WrUddUI4WVL7ORtRaviwxoFWp0V0435STkjmjQYS68EgWNZeR7
         8aMC8fn3TXCLN00YQ2BCBuY1TUPz/sZ4h9auYCxCeD7y/GHZtOmjN3xKOIPEkOzrMFAj
         rYyBX226vCeenTQ7wemfB3OFlywDRLSHrwSyN2y9DgdN7qmstPVj982fHz7SkLKHUGHU
         cmyRxUZV9aQEJ+V3PKQwvZ46ph6WXcAr/Dl6fkvNBmQNIYrhLg7KZlZD/WVyDZBUiesN
         0rOSQs8IqUnBFjTHORu+gLFKvVw6Vn2l9zfjbKHNSZQGU0RmzhdDsi1GC9nPxa4lVsL8
         0wXg==
X-Gm-Message-State: APjAAAVzLltG0pLtdV+/THC+f4bl/3yh7RK0RZq7duaZXYkS4gvJ6vcw
        IQoOcAIuAoE4vOcnjBddFFo=
X-Google-Smtp-Source: APXvYqxzY00J7ZU5QilwRylLFRrUVY6bMMNrVebXfCKS6HdF+jjlpwPjCq8Tdnu4hRlbWaSK/ogvKg==
X-Received: by 2002:a17:902:9002:: with SMTP id a2mr12753047plp.147.1571439946322;
        Fri, 18 Oct 2019 16:05:46 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::6038])
        by smtp.gmail.com with ESMTPSA id t12sm5870334pjq.18.2019.10.18.16.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 16:05:45 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:05:43 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Miller <davem@davemloft.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191018230540.l6e4jtrlu44hk7q5@ast-mbp>
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
 <20191017145358.GA26267@pc-63.home>
 <20191017154021.ndza4la3hntk4d4o@linutronix.de>
 <20191017.132548.2120028117307856274.davem@davemloft.net>
 <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <CAADnVQJPJubTx0TxcXnbCfavcQDZeu8VTnYYpa8JYpWw9Ze4qg@mail.gmail.com>
 <alpine.DEB.2.21.1910180152110.1869@nanos.tec.linutronix.de>
 <20191018055222.cwx5dmj6pppqzcpc@ast-mbp>
 <alpine.DEB.2.21.1910181256120.1869@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910181256120.1869@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 18, 2019 at 01:28:21PM +0200, Thomas Gleixner wrote:
> 
> On a non RT enabled build these primitives just resolve to
> preempt_disable(), local_bh_disable(), local_irq_disable() and
> local_irq_save().
> 
> On RT the local lock is actually a per CPU lock which allows nesting. i.e.
> 
>       preempt_disable();
>       ...
>       local_irq_disable();
> 
> becomes
> 
> 	local_lock(this_scope);
> 	...
> 	local_lock_irq(this_scope);
> 
> The local lock is a 'sleeping' spinlock on RT (PI support) and as any other
> RT substituted lock it also ensures that the task cannot be migrated when
> it is held, which makes per cpu assumptions work - the kernel has lots of
> them. :)
> 
> That works as long as the scope is well defined and clear. It does not work
> when preempt_disable() or any of the other scopeless protections is used to
> protect random (unidentifiable) code against each other, which means the
> protection has the dreaded per CPU BKL semantics, i.e. undefined.
> 
> One nice thing about local_lock even aside of RT is that it annotates the
> code in terms of protection scope which actually gives you also lockdep
> coverage. We found already a few bugs that way in the past, where data was
> protected with preempt_disable() when the code was introduced and later
> access from interrupt code was added without anyone noticing for years....

The concept on local_lock() makes sense to me.
The magic macro you're proposing that will convert it to old school
preempt_disable() on !RT should hopefully make the changes across
net and bpf land mostly mechanical.
One thing to clarify:
when networking core interacts with bpf we know that bh doesn't migrate,
so per-cpu datastructres that bpf side populates are accessed later
by networking core when program finishes.
Similar thing happens between tracing bits and bpf progs.
It feels to me that local_lock() approach should work here as well.
napi processing bits will grab it. Later bpf will grab potentially
the same lock again.
The weird bit that such lock will have numbe_of_lockers >= 1
for long periods of time. At least until napi runners won't see
any more incoming packets. I'm not sure yet where such local_lock
will be placed in the napi code (may be in drivers too for xdp).
Does this make sense from RT perspective?

> > BPF also doesn't have unbound runtime.
> > So two above issues are actually non-issues.
> 
> That'd be nice :)
> 
> Anyway, we'll have a look whether this can be solved with local locks which
> would be nice, but that still does not solve the issue with the non_owner
> release of the rwsem.

Sure. We can discuss this separately.
up_read_non_owner is used only by build_id mode of stack collectors.
We can disable it for RT for long time. We're using stack with build_id heavily
and have no plans to use RT. I believe datacenters, in general, are not going
to use RT for foreseeable future, so a trade off between stack with build_id
vs RT, I think, is acceptable.

But reading your other replies the gradual approach we're discussing here
doesn't sound acceptable ? And you guys insist on disabling bpf under RT
just to merge some out of tree code ? I find this rude and not acceptable.

If RT wants to get merged it should be disabled when BPF is on
and not the other way around.
Something like this:
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index deff97217496..b3dbc5f9a6de 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -57,7 +57,7 @@ config PREEMPT

 config PREEMPT_RT
        bool "Fully Preemptible Kernel (Real-Time)"
-       depends on EXPERT && ARCH_SUPPORTS_RT
+       depends on EXPERT && ARCH_SUPPORTS_RT && !BPF_SYSCALL
        select PREEMPTION
        help
          This option turns the kernel into a real-time kernel by replacing

