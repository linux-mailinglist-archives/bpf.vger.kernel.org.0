Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06C44467D0
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhKER1S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhKER1M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 13:27:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAAEC06120D;
        Fri,  5 Nov 2021 10:24:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636133071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+70iYdg6zUu8Lqi6l7KLgNhOA3/zlkFH1TwBReetG8=;
        b=WFzb2tacbq96jVu7RhlPEY4ULAeT4NuRbAOanTgGuRy/qpi2bUkxmNNLRTWO0SncoPbetJ
        GzG1hhnas/4PzZ4pG0L+QAy0fclAP8oT52Ueai63Lbb7Bc4oIvAKvwY0n3D6RTgtHZjrq4
        vYYzbW2TlmyZzM0kFZt41Umm5TiXT4+TXhzqW8ZKU7DvqlvUctH9g+AFDzxMjxaN0jh4an
        43Qp0WDRm5pzufSwvweUov/AvbFltQR3bMotKfEmao3NwkGHMsAMvcI4zMsoU4E9WAO9+D
        Ty067a+yyQd/E+8EsUsAzDY/HSIg6psHVWh6q+ZuCyQGsd5x6yH7jEzQozvCjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636133071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+70iYdg6zUu8Lqi6l7KLgNhOA3/zlkFH1TwBReetG8=;
        b=r+mu8TZwIG5G63i+/GeMuj/wlWX2MPGiPtXez1sg5Nbz+KWGwShfBlubhoAfBgjTgH4eeI
        I/+66eCg6UgqYYAw==
To:     Dmitrii Banshchikov <me@ubique.spb.ru>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     syzbot <syzbot+43fd005b5a1b4d10781e@syzkaller.appspotmail.com>,
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
In-Reply-To: <20211105170328.fjnzr6bnbca7mdfq@amnesia>
References: <00000000000013aebd05cff8e064@google.com> <87lf224uki.ffs@tglx>
 <CAADnVQLcuMAr3XMTD1Lys5S5ybME4h=NL3=adEwib2UT6b-E9w@mail.gmail.com>
 <20211105170328.fjnzr6bnbca7mdfq@amnesia>
Date:   Fri, 05 Nov 2021 18:24:30 +0100
Message-ID: <875yt64isx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 05 2021 at 21:03, Dmitrii Banshchikov wrote:
> On Fri, Nov 05, 2021 at 08:53:06AM -0700, Alexei Starovoitov wrote:
>> > Timestamps from within a tracepoint can only be taken with:
>> >
>> >          1) jiffies
>> >          2) sched_clock()
>> >          3) ktime_get_*_fast_ns()
>> >
>> > Those are NMI safe and can be invoked from anywhere.
>> >
>> > All other time getters which have to use the timekeeping seqcount
>> > protection are prone to live locks and _cannot_ be used from
>> > tracepoints ever.
>> 
>> Obviously.
>> That helper was added for networking use cases and accidentally
>> enabled for tracing.
>
> Sorry for that.
> I'm preparing a patch that will forbid using bpf_ktime_get_coarse_ns()
> helper in BPF_LINK_TYPE_RAW_TRACEPOINT.

It cannot be used in TRACING and PERF_EVENT either. But those contexts
have to exclude other functions as well:

     bpf_ktime_get_ns
     bpf_ktime_get_boot_ns

along with

    bpf_spin_lock/unlock
    bpf_timer_*

Thanks,

        tglx
