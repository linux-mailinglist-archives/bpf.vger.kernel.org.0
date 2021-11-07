Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E8447325
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 14:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhKGNyH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Nov 2021 08:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhKGNyH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Nov 2021 08:54:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7903C061570
        for <bpf@vger.kernel.org>; Sun,  7 Nov 2021 05:51:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n29so10334691wra.11
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3yVpPO0r/qITHteS4fsEzbLkYGCl0u5VUYb9MU6DMSw=;
        b=VC9z4vemDTkn/EFs3v9RnK94bYTsxLtkywc6KyidgSu383GOqctuu/O/p1q8uHbHwS
         grnowSTDXsaPjvX/VzHvqqeK9Ib3u0PWmH6wTFWJJtvIsySLHKZCP0+w8BU75/8i4YDD
         S4lrk5i3r7A7OZYQHsqjHTQAmrB/nPXswnvPscRqJcTQ+8kNMDUak7E3vB/zJx5hGDym
         ehv01ejyhMOExAmZhhiJXNkIqQDCItZ7+GjMDZbcXov3WSIOwIuTq7Tz/qPINyzPiX9m
         50XfOCJ0qEPlo3bjUuzwyxC4tm1qaDORO6rDIwSd0WZq59HmFxfwcdBcALOUOMHJj1Kq
         EGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3yVpPO0r/qITHteS4fsEzbLkYGCl0u5VUYb9MU6DMSw=;
        b=Oq+g8Fbbr94++NZqcRZVgQZtkDIiSQAYGREKyNPghMqYXfw85HlOcL+EbGo8Th7p2j
         ZsK0eGJWEV2IFYWj1wVykbmD4jlyVtsHcrjdPJdErbvCwniusl/Yk7tefkYjGwtFsfy7
         VR5YtQrZVf6SAr4pAUQDRktO9OKA53c15hpQxzyVVf+SoKBpxPICZxQk9MQE8R2YyiBq
         Vha0NdhItdLJcMVdjHFQVVA7uBFnn7bToyssx0iCP2osXfxob4kZicX91VyTItjZ/shx
         jOXCNDpMdCKwrszq6zUUYWwRxjm7hx20DZn6OADqpduam3RU2YxFYwm12rSY3GYkeuQU
         Sl+w==
X-Gm-Message-State: AOAM533bSexCd9p2hterH0deuLVFcp0G6ZZl5SyBVvrw5ngsCdA98VDF
        S5d9XsjwyvcPDiDLS96ITxm21g==
X-Google-Smtp-Source: ABdhPJy0q+kSfNRXUd/Fn8e3u1u8P+ecqf3noxN5M4Wy1mXiGGOw/3PK/eAzzIqgieiqmdSlX2/nUQ==
X-Received: by 2002:adf:c183:: with SMTP id x3mr91597468wre.90.1636293082225;
        Sun, 07 Nov 2021 05:51:22 -0800 (PST)
Received: from localhost ([91.75.210.37])
        by smtp.gmail.com with ESMTPSA id m3sm4171415wmi.19.2021.11.07.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 05:51:21 -0800 (PST)
Date:   Sun, 7 Nov 2021 17:51:15 +0400
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
Message-ID: <20211107135115.tqqx62sxsfeuzslb@amnesia>
References: <00000000000013aebd05cff8e064@google.com>
 <87lf224uki.ffs@tglx>
 <CAADnVQLcuMAr3XMTD1Lys5S5ybME4h=NL3=adEwib2UT6b-E9w@mail.gmail.com>
 <20211105170328.fjnzr6bnbca7mdfq@amnesia>
 <875yt64isx.ffs@tglx>
 <20211106200733.meank7oonwvsdjy4@amnesia>
 <87zgqg2r4o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgqg2r4o.ffs@tglx>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 07, 2021 at 11:32:07AM +0100, Thomas Gleixner wrote:
> > 2) bpf_spin_lock/unlock have notrace attribute set.
> 
> How is that supposed to help?
> 
> You cannot take a spinlock from NMI context if that same lock can be
> taken by other contexts as well.
> 
> Also notrace on the public function is not guaranteeing that the inlines
> (as defined) are not traceable and it does not exclude it from being
> kprobed.
> 
> > 3) bpf_timer_* helpers fail early if they are in NMI.
> >
> > Why they have to be excluded?
> 
> Because timers take locks and you can just end up in the very same
> situation that you create invers lock dependencies or deadlocks when you
> use that from a tracepoint.
> 
> hrtimer_start()
>   lock_base();
>   trace_hrtimer...()
>     perf_event()
>       bpf_run()
>         bpf_timer_start()
>           hrtimer_start()
>             lock_base()         <- DEADLOCK
> 
> Tracepoints and perf events are very limited in what they can actually
> do. Just because it's BPF these rules are not magically going away.
> 

Thanks for the clarification.


-- 

Dmitrii Banshchikov
