Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA40E447056
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 21:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhKFUK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Nov 2021 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhKFUK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Nov 2021 16:10:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC343C061570
        for <bpf@vger.kernel.org>; Sat,  6 Nov 2021 13:07:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso750734wml.1
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YTwExqzbaLzxuqvV/oJ9V6E17L9+TERCkYUMoZe/UPM=;
        b=2/tfJl2l+6tcayj/K3ATETjvDd2NNQorHEsPZjv/kiLQQ/PtrwOB1jckPRS8AtfFsj
         6i71NrLYm72TuGZe+K0ANABFbD5uxpN4P2j2iF+6ERtYQCaZdENvOY7DNKmD5AupQAeP
         TVxA88yV0S8EDqls5mlwbc6PkueL4iTcZvbHe1tf7lvgkhtVf3ckdIE57ec5UFPhH9s8
         ckypZQl2B9hkRPAUuyBXtpZvnZQ1k4TuFePlhSoVYr0FU1hkxG7g5DPGmCBPmuHVU7C6
         2XYHK0KRk/pZ0Kgn3yDMeOI9oQp96gWf61+sKP2AjhuaxRnGjsccSQQlEDyr/SRtOW2N
         U/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YTwExqzbaLzxuqvV/oJ9V6E17L9+TERCkYUMoZe/UPM=;
        b=qM5anLei6yeCPhZCmekzpvlqrqlyP325HTglPPeZOEXGDTC7hAKlQoO/TyD7aSSBsx
         jLIImt8ijbEqasYmc9iye5bPTP+28u6uDt7ixkTV9/PUwB4r5CkNqf+MiOoDYwMsnL7D
         H1clXRxQakcalBoQklYaRSLDgVLiSg29FhKlcuTPjOJ2RjWKoJctfLCPcC1nL2IWG2Vj
         7tbbS0F84OPo57P8wASg9b6Erds3gS2a3sNG8uOATKAH00EMg94IGwQGsR/3BRet9HTU
         ZBgGGGu3M0NkEoIixoJKespUsm+QS2+guaR+gA7xczqAU/JFi9UwQ0rqWnSobSSBKOQT
         C68Q==
X-Gm-Message-State: AOAM533Nze7OF5Plwm9NM2E5WxCp5BqLeiMxFOTT/iqcqVk5Q/alVhPR
        2IzxqQl0/Jn/Aijy53zKlfbNrA==
X-Google-Smtp-Source: ABdhPJyBgw/+HTFOY0WehGT/wpO/NKWSOmcw3aJMNosWNWzOPztp2YAs24zEZ8taCCQNRv9qfleTKg==
X-Received: by 2002:a05:600c:5101:: with SMTP id o1mr40540284wms.81.1636229262302;
        Sat, 06 Nov 2021 13:07:42 -0700 (PDT)
Received: from localhost ([91.75.210.37])
        by smtp.gmail.com with ESMTPSA id o9sm11571286wrs.4.2021.11.06.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 13:07:41 -0700 (PDT)
Date:   Sun, 7 Nov 2021 00:07:33 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20211106200733.meank7oonwvsdjy4@amnesia>
References: <00000000000013aebd05cff8e064@google.com>
 <87lf224uki.ffs@tglx>
 <CAADnVQLcuMAr3XMTD1Lys5S5ybME4h=NL3=adEwib2UT6b-E9w@mail.gmail.com>
 <20211105170328.fjnzr6bnbca7mdfq@amnesia>
 <875yt64isx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yt64isx.ffs@tglx>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 05, 2021 at 06:24:30PM +0100, Thomas Gleixner wrote:
> On Fri, Nov 05 2021 at 21:03, Dmitrii Banshchikov wrote:
> > On Fri, Nov 05, 2021 at 08:53:06AM -0700, Alexei Starovoitov wrote:
> >> > Timestamps from within a tracepoint can only be taken with:
> >> >
> >> >          1) jiffies
> >> >          2) sched_clock()
> >> >          3) ktime_get_*_fast_ns()
> >> >
> >> > Those are NMI safe and can be invoked from anywhere.
> >> >
> >> > All other time getters which have to use the timekeeping seqcount
> >> > protection are prone to live locks and _cannot_ be used from
> >> > tracepoints ever.
> >> 
> >> Obviously.
> >> That helper was added for networking use cases and accidentally
> >> enabled for tracing.
> >
> > Sorry for that.
> > I'm preparing a patch that will forbid using bpf_ktime_get_coarse_ns()
> > helper in BPF_LINK_TYPE_RAW_TRACEPOINT.
> 
> It cannot be used in TRACING and PERF_EVENT either. But those contexts
> have to exclude other functions as well:
> 
>      bpf_ktime_get_ns
>      bpf_ktime_get_boot_ns
> 
> along with
> 
>     bpf_spin_lock/unlock
>     bpf_timer_*

1) bpf_ktime_get_ns and bpf_ktime_get_boot_ns use
ktime_get_{mono,boot}_fast_ns.
2) bpf_spin_lock/unlock have notrace attribute set.
3) bpf_timer_* helpers fail early if they are in NMI.

Why they have to be excluded?



-- 

Dmitrii Banshchikov
