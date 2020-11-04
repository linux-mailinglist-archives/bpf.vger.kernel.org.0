Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9549A2A6D4C
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 19:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgKDS5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 13:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgKDS5F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 13:57:05 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C1C0613D3
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 10:57:05 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id j5so10717468plk.7
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 10:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eFbEFkCwKJ1hR3ookQi/7V8Itg1IPtT/zHbmeIxSz6g=;
        b=M8V29X75bdxqtjcKywJmnyr1FqzkhvieUPrJY63jv4RFhMimKu9+P3nJ1F+HndPJsh
         QzfeuWZuKcE8FrwefX0HGV1DUScWByoTiabA2VGBkCDVtSUXskkYKZXjTs191p7kBgsy
         q5yRcPFcVQ+sw3CiP8F/EyXbTycT5ga0dpB7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eFbEFkCwKJ1hR3ookQi/7V8Itg1IPtT/zHbmeIxSz6g=;
        b=OKYZLow+ETTgTOfyq3lUfZFByI+7MgOolu2I8AVhVZGSSWQKk6bDHKYXA47SlR31jt
         fn0XKxzuYMjBkEb+VeMcc8RzOfwyHMo8ls7C0BeqsCjy110CkuoCdhKCFd2z/tFW2YoZ
         05R7tiAKsDpxkM2muZhD5oNOfLmcyk1URFk+7Zp1mNbIWzMZWgNggp6wnNSkZbIfv8da
         XEI75VkL4PS/yVzXPu5q/bfvGM2hf6zyxUuii2vBRYaNqGN/LA+TksX/MefivJw12f+2
         3u62UA5+13MXpDE+HshYdWlkMNN1skN3wZpr8W7jaM9wDR2nFRshNlJe0IqLecv51xJg
         j9gA==
X-Gm-Message-State: AOAM5335t1LYDEtnmdDMBxaP+XYFKhB4clAuuUrmSSTZJcw2T/Q2gE4s
        ZcMWyiY7X4hVyWBpFAupoSh7ow==
X-Google-Smtp-Source: ABdhPJyu2rjAfEpo9PsZku1g5A6IasXMm5exN3bYVxllgILGsUnNv/NS1FwRd/sfhdORw2FuF5f16w==
X-Received: by 2002:a17:902:ff0e:b029:d6:820d:cb81 with SMTP id f14-20020a170902ff0eb02900d6820dcb81mr31394012plj.47.1604516225344;
        Wed, 04 Nov 2020 10:57:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16sm3066965pff.114.2020.11.04.10.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:57:04 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:57:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202011041052.0D14CD6@keescook>
References: <202010121556.1110776B83@keescook>
 <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
 <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com>
 <202010221520.44C5A7833E@keescook>
 <CABqSeAT4L65_uS=45uxPZALKaDSDocMviMginLOV2N0h-e1AzA@mail.gmail.com>
 <202010231945.90FA4A4AA@keescook>
 <CABqSeAQ4cCwiPuXEeaGdErMmLDCGxJ-RgweAbUqdrdm+XJXxeg@mail.gmail.com>
 <CABqSeATiV0sQvqpvCuqkOXNbjetY=1=6ry_SciMVmo63W9A88A@mail.gmail.com>
 <202011031612.6AA505157@keescook>
 <CABqSeASFkTFn8ix8-5D0vdZ_FR9bR1PpU3j5eQPYOMshK6FuNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeASFkTFn8ix8-5D0vdZ_FR9bR1PpU3j5eQPYOMshK6FuNA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 04, 2020 at 05:40:51AM -0600, YiFei Zhu wrote:
> On Tue, Nov 3, 2020 at 6:29 PM Kees Cook <keescook@chromium.org> wrote:
> > Yeah, this is very interesting. That there is anything measurably _slower_
> > with the cache is surprising. Though with only 4 runs, I wonder if it's
> > still noisy? What happens at 10 runs -- more importantly what is the
> > standard deviation?
> 
> I could do that. it just takes such a long time. Each run takes about
> 20 minutes so with 10 runs per environment, 3 environments (native + 2
> docker) per boot, and 4 boots (2 bootparam * 2 compile config), it's
> 27 hours of compilation. I should probably script it at that point.

Yeah, I was facing the same issues. Though perhaps hackbench (with
multiple CPUs) would be a better test (and it's much faster):

https://lore.kernel.org/lkml/7723ae8d-8333-ba17-6983-a45ec8b11c54@redhat.com/

(I usually run this with a CNT of 20 to get quick results.)

> > I assume this is from Indirect Branch Prediction Barrier (IBPB) and
> > Single Threaded Indirect Branch Prediction (STIBP) (which get enabled
> > for threads under seccomp by default).
> >
> > Try booting with "spectre_v2_user=prctl"
> 
> Hmm, to make sure, boot with just "spectre_v2_user=prctl" on the
> command line and test the performance of that?

Right, see if that eliminates the 3 minute jump seen for seccomp.

-- 
Kees Cook
