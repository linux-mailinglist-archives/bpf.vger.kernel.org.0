Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60DA44728E
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 11:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhKGKex (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Nov 2021 05:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhKGKex (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Nov 2021 05:34:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD901C061570;
        Sun,  7 Nov 2021 02:32:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636281128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rd3ffGQQJChg/Hb94WlJufijU/0aWer4s6t1U07NuVA=;
        b=kOiv5v2+u8C1UOLT1f1I2XzxTlDJVp6IcSJ2fBFqASpU/Ny1xOEUiv9eWaHRRrgq5rh6gC
        Iid1LKOLo2EhRKWnIcZxah/chirl0IdFyKKhLrxqRC5btmJB5nUiTaj8vPmy1ccTfa3EHT
        LEPQH85k9hlkiUoj6l7Deiko2nkjUCXMn4HGmruyAf8qk2GZPyHskjYS7rARxU7vcWYZCw
        Vi7OW3bHoBfG/iLqlKDHnD+BWarvPTMXKl4lBdDxfq7dO6fd0B3tO7RBwLEdE0sOZ6s7Jl
        DGAqOMZx7LSgm4V7fXnrO//ZUqybhypbTVlSLXQdxycPeBN64ob92Djrred3FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636281128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rd3ffGQQJChg/Hb94WlJufijU/0aWer4s6t1U07NuVA=;
        b=f1338RiamZStL8yRo6YOlOH4bHwoHKfb6/iRJVbwUWWpHSbop0chV7X1JQ/Cmau0U/7iSj
        yBfncaMJNiL9n/AQ==
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        syzbot <syzbot+43fd005b5a1b4d10781e@syzkaller.appspotmail.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, sboyd@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rosted@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [syzbot] possible deadlock in ktime_get_coarse_ts64
In-Reply-To: <20211106200733.meank7oonwvsdjy4@amnesia>
References: <00000000000013aebd05cff8e064@google.com> <87lf224uki.ffs@tglx>
 <CAADnVQLcuMAr3XMTD1Lys5S5ybME4h=NL3=adEwib2UT6b-E9w@mail.gmail.com>
 <20211105170328.fjnzr6bnbca7mdfq@amnesia> <875yt64isx.ffs@tglx>
 <20211106200733.meank7oonwvsdjy4@amnesia>
Date:   Sun, 07 Nov 2021 11:32:07 +0100
Message-ID: <87zgqg2r4o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dmitrii,

On Sun, Nov 07 2021 at 00:07, Dmitrii Banshchikov wrote:
> On Fri, Nov 05, 2021 at 06:24:30PM +0100, Thomas Gleixner wrote:
>> It cannot be used in TRACING and PERF_EVENT either. But those contexts
>> have to exclude other functions as well:
>> 
>>      bpf_ktime_get_ns
>>      bpf_ktime_get_boot_ns
>> 
>> along with
>> 
>>     bpf_spin_lock/unlock
>>     bpf_timer_*
>
> 1) bpf_ktime_get_ns and bpf_ktime_get_boot_ns use
> ktime_get_{mono,boot}_fast_ns.

Ok. That's fine then. I was just going from the bpf function names and
missed the implementation detail.

> 2) bpf_spin_lock/unlock have notrace attribute set.

How is that supposed to help?

You cannot take a spinlock from NMI context if that same lock can be
taken by other contexts as well.

Also notrace on the public function is not guaranteeing that the inlines
(as defined) are not traceable and it does not exclude it from being
kprobed.

> 3) bpf_timer_* helpers fail early if they are in NMI.
>
> Why they have to be excluded?

Because timers take locks and you can just end up in the very same
situation that you create invers lock dependencies or deadlocks when you
use that from a tracepoint.

hrtimer_start()
  lock_base();
  trace_hrtimer...()
    perf_event()
      bpf_run()
        bpf_timer_start()
          hrtimer_start()
            lock_base()         <- DEADLOCK

Tracepoints and perf events are very limited in what they can actually
do. Just because it's BPF these rules are not magically going away.

Thanks,

        tglx
