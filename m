Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616CF276977
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgIXGw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 02:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgIXGwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 02:52:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF32C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 23:52:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so1168794pjb.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7CCPIZlew0HbBYh6o4RhoViTEMk2IJj8qqgM/1ilcsk=;
        b=IjvwHDuOZhYxiKk5rGRzbTJSz4CvNMuL/Bw50mnVKKJCCmYCIkG3LPK+ZhEUhz0IBa
         Lc8PPhKv15Rlh/TOPi/5T/m+GGmJsh2KADJTPcnByV3mRN6f28st7i6o3/g6awYca3Al
         L3J+938e5086Ib68nasdGRrE3ACJ7GVaryhvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7CCPIZlew0HbBYh6o4RhoViTEMk2IJj8qqgM/1ilcsk=;
        b=qFjKlPg/6QkKJyJwrOPlYCdjgpGxd6coiIQz7iYYwuFb1d2SGUdi5t67oD94qh2pjp
         F3ZwKNBQukhITqhIPjL0GU4mCBPxA4ufs4OuFHhjpdDh1PAsKvJQnZh/EauOdaDu0X/l
         wRumGMWJWe5Af0ZAvar4iraJ5VfsjmNAcTPob/mAOgAfaVTTHL7Ys3+J4LbuaxQq6r08
         8G22Ujbx1Sv0WHm59nvzRsvIwUHWATY7rIxVQ9QfgMHmwLGMbapKtZGANLjU2ywYN4VO
         BgF7pAYuaZOwV6+m/TYax6mhQyfEFGYaif1FZ1A1aqKQOm+o028LamiSqtXNLGzJaHOc
         kR7A==
X-Gm-Message-State: AOAM530JTVlLMTZ+vdAhT1hsoVAZOk/N6E+18ZBHTlBzZmeKJstATyrv
        NvwWn+5kkPqwbQx8xWyiPLfBRg==
X-Google-Smtp-Source: ABdhPJzq7ELh3YIQhcHZ8HdH22fqLwsTMjIs1wcWhiPUhmVT5b9cF8PzCaJcckm2GCQ9iHXVAQkEjw==
X-Received: by 2002:a17:90b:1216:: with SMTP id gl22mr2614202pjb.121.1600930341608;
        Wed, 23 Sep 2020 23:52:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y29sm1735134pfq.207.2020.09.23.23.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 23:52:20 -0700 (PDT)
Date:   Wed, 23 Sep 2020 23:52:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
Message-ID: <202009232348.448EC2088@keescook>
References: <cover.1600661418.git.yifeifz2@illinois.edu>
 <202009231224.21BCB3BC6@keescook>
 <CABqSeAR+69BQ7OKJ9o2DD1=uz8ZozY8ygu41oodn-GUYb_gVmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeAR+69BQ7OKJ9o2DD1=uz8ZozY8ygu41oodn-GUYb_gVmQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 05:54:51PM -0500, YiFei Zhu wrote:
> On Wed, Sep 23, 2020 at 2:26 PM Kees Cook <keescook@chromium.org> wrote:
> > Did you see the RFC series for this?
> >
> > https://lore.kernel.org/lkml/20200616074934.1600036-1-keescook@chromium.org/
> > [...]
> > Which also includes updated benchmarking:
> >
> > https://lore.kernel.org/lkml/20200616074934.1600036-6-keescook@chromium.org/
> 
> Nice. I was not aware of that series. Looking at it, it seems that our
> reasoning for checking arch and nr only, and verify if the filter
> accesses anything else, is the same. However, the approach in that RFC
> used was some page table dark magic, and it has been concluded that an
> emulator is superior. Was there a seperate patch series with emulator?
> If not, would you mind me cherry-picking some of your changes in that
> series?

I've sent that series refreshed with Jann's emulator now[1]. (Which I
see you've replied to as well, but I figured I'd just link these threads
for any future archaeology. ;)

> Also, I see that BPF_AND is said to be used in the discussion of the
> linked series. I think it wouldn't hurt to emulate a few BPF_ALU so
> I'll add that.

If you could add ALU|AND, that would get us complete coverage for
libseccomp and Chrome. I don't want the emulator to get any more complex
than that, as I view it as fairly high risk part. As you can see, I
tried really hard to _not_ use an emulator in the RFC. ;)

[1] https://lore.kernel.org/lkml/20200923232923.3142503-1-keescook@chromium.org/

-- 
Kees Cook
