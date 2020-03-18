Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C47B1894BF
	for <lists+bpf@lfdr.de>; Wed, 18 Mar 2020 05:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgCREGN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Mar 2020 00:06:13 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37693 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgCREGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Mar 2020 00:06:12 -0400
Received: by mail-pj1-f65.google.com with SMTP id ca13so630307pjb.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2020 21:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7NJiSJJsn7uiLh7Cvx0ggtnn/qvPqiLQL9PelNdKr40=;
        b=LLFwCb6m129VqiUIVzImsyROsA0l3qHoEFW2RsL6NyhHboHjx/0rnjK9+XtD0om9DO
         viX51mgiD4HOHQmcqAn8ePhU2DbWhbUSLPthEUaT9kzr2VRfRup1FfsZHGubolbxvn3/
         D83deLS0Ajd8WxTR2voZjpFeSdvcrop2W8CLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7NJiSJJsn7uiLh7Cvx0ggtnn/qvPqiLQL9PelNdKr40=;
        b=eRJ4NtA/EOA1K8hqhr98+UydLVuGS++ebq8Dsy3TY5tr2ydyC+l3Cd5YV4BeoCf4ty
         4ALnY5wVAuWH1OfN82lbSLytiJbBAFLFSh67cVdkhak0dm9aW9pNA7JXBTy7YAKhazWr
         iBo2Bkd+EmGtl83xf61GIsYQIuEfNMp2IK8NibAksm1Cg701p+s7lr7RZRjGWZ+ABjy8
         /stSwK00jQbwhrDJ0L2CJyd5730UaEU9pe/2ds30/TrkHssEntln7w0r9XNDMtoFngTR
         eAGY3hCeNswVq2ljAjEKuOLBqPSRMaoWA15DGGUTJRc6Mg7mtSFslzqCOJAdubSQ59bA
         5vyg==
X-Gm-Message-State: ANhLgQ0Sjj7XQD7vyx/W/baueHuKKCntaihiX6Ck1ephEE6eKfAUDs6D
        n3R3Z8J0Qvnb7X2D+DdkBBb94cJmDDg=
X-Google-Smtp-Source: ADFU+vswXSlUDGAdugtErh23ZUQBbS2UhbxYy/RYtpM536DAaJBoaMNYPF9LnK+zOfqfCJkUUwH7Yw==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr2543293pjc.160.1584504370417;
        Tue, 17 Mar 2020 21:06:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y9sm3937422pgo.80.2020.03.17.21.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 21:06:09 -0700 (PDT)
Date:   Tue, 17 Mar 2020 21:06:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anton Protopopov <a.s.protopopov@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] seccomp: allow BPF_MOD ALU instructions
Message-ID: <202003172058.3CB0D95@keescook>
References: <20200316163646.2465-1-a.s.protopopov@gmail.com>
 <202003161423.B51FDA8083@keescook>
 <CAGn_itw594Q_-4gC8=3jjRGF-wx90GeXMWBAz54X-UEer9pbtA@mail.gmail.com>
 <202003171314.387F3F187D@keescook>
 <CAGn_itz7jgoP5J1pjJ7BLaeh4my=JY2yQ7T8ssoYrqPOWvwKug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGn_itz7jgoP5J1pjJ7BLaeh4my=JY2yQ7T8ssoYrqPOWvwKug@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 17, 2020 at 09:11:57PM -0400, Anton Protopopov wrote:
> вт, 17 мар. 2020 г. в 16:21, Kees Cook <keescook@chromium.org>:
> >
> > On Mon, Mar 16, 2020 at 06:17:34PM -0400, Anton Protopopov wrote:
> > > and in every case to walk only a corresponding factor-list. In my case
> > > I had a list of ~40 syscall numbers and after this change filter
> > > executed in 17.25 instructions on average per syscall vs. 45
> > > instructions for the linear filter (so this removes about 30
> > > instructions penalty per every syscall). To replace "mod #4" I
> > > actually used "and #3", but this obviously doesn't work for
> > > non-power-of-two divisors. If I would use "mod 5", then it would give
> > > me about 15.5 instructions on average.
> >
> > Gotcha. My real concern is with breaking the ABI here -- using BPF_MOD
> > would mean a process couldn't run on older kernels without some tricks
> > on the seccomp side.
> 
> Yes, I understood. Could you tell what would you do exactly if there
> was a real need in a new instruction?

I'd likely need to introduce some kind of way to query (and declare) the
"language version" of seccomp filters. New programs would need to
declare the language level (EINVAL would mean the program must support
the original "v1", ENOTSUPP would mean "kernel doesn't support that
level"), and the program would have to build a filter based on the
supported language features. The kernel would assume all undeclared
seccomp users were "v1" and would need to reject BPF_MOD. All programs
declaring "v2" would be allowed to use BPF_MOD.

It's really a lot for something that isn't really needed. :)

> > Since the syscall list is static for a given filter, why not arrange it
> > as a binary search? That should get even better average instructions
> > as O(log n) instead of O(n).
> 
> Right, thanks! This saves about 4 more instructions for my case and
> works 1-2 ns faster.

Excellent!

> > Though frankly I've also been considering an ABI version bump for adding
> > a syscall bitmap feature: the vast majority of seccomp filters are just
> > binary yes/no across a list of syscalls. Only the special cases need
> > special handling (arg inspection, fd notification, etc). Then these
> > kinds of filters could run as O(1).

*This* feature wouldn't need my crazy language version idea, but it
_would_ still need to be detectable, much like how RET_USER_NOTIF was
added.

-- 
Kees Cook
