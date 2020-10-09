Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3749E2881C5
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 07:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgJIFlS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 01:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbgJIFlR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 01:41:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A073CC0613D2
        for <bpf@vger.kernel.org>; Thu,  8 Oct 2020 22:41:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so5928040pfk.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 22:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BtDQZIEMLmhF49jnffnO6s6n101uAcwJbVqfJI9bloU=;
        b=gLtNphPuxO/huMzVOdahNog6vTAfDxOKzwZr8kuLPoDx3zhHExJBFO1FNqXWYHyQB1
         7T1XE/NlhFzFDGSZExn+kdBVZhsW+rVHOhFCneh+yKUT/h46cdWw0qUO4HnlW9dVFynH
         V0rPgGpCr2hIx9M7HyNH1gY3MnOae078/ROgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BtDQZIEMLmhF49jnffnO6s6n101uAcwJbVqfJI9bloU=;
        b=nc0pvSmJCDloM8UPIUJlCzlVn4lckkUBhcArFIvKSh1PRmiCv2QUghb/uMc8LCyFCk
         F0MuW3DzZJjoGl3Vc/OfOQN/tHUUbTsy9X+h1VHHAarVlL8CM2Z/ZLC/INwTVoG1XJKF
         zoLqtnNLB7xzCFp8NAVJ1sYCkkBZBLfu4WalBAiZL/d/K7Szz1XY+G7KhanJfBnN9NLD
         9fY2BP/Q0P8TB62rPWYB/Tn0/7TmJHBzXyjwA6b0Aswik78AIPqBbdDneIeY9Y2ocNoY
         AIsjr/wQ9jS01Y8gnPtcBwBdanAMEqqVWeUFX9y2eXiDNtCZTRhG1z0EBpkJ+1aWq6ej
         OSzA==
X-Gm-Message-State: AOAM5335TBmHXqVybefGBxO6jvwCVCZ0YV5GIolXTLyO8yGZLfqBBb+C
        0pcsxgyvXK6bhsF5qQU2P7KYBA==
X-Google-Smtp-Source: ABdhPJx5nhK9QmdRyfBWqhmKPI9k3k7mtwxMc2RozKFPrmPt2YIUBzplio+r3UmWZcjh8f12k2UeKA==
X-Received: by 2002:a17:90a:248:: with SMTP id t8mr3002688pje.64.1602222077073;
        Thu, 08 Oct 2020 22:41:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z73sm9693620pfc.75.2020.10.08.22.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 22:41:15 -0700 (PDT)
Date:   Thu, 8 Oct 2020 22:41:14 -0700
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
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
Message-ID: <202010082235.3D6A5F2@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
 <CABqSeAQELsMP4116LwOY+WMcs9Zjr9fYUZ-pK+yNTGYETLf46w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABqSeAQELsMP4116LwOY+WMcs9Zjr9fYUZ-pK+yNTGYETLf46w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 08, 2020 at 11:47:17PM -0500, YiFei Zhu wrote:
> On Wed, Sep 30, 2020 at 10:20 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > @@ -544,7 +577,8 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
> >  {
> >         struct seccomp_filter *sfilter;
> >         int ret;
> > -       const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE);
> > +       const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
> > +                              IS_ENABLED(CONFIG_SECCOMP_CACHE_NR_ONLY);
> >
> >         if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
> >                 return ERR_PTR(-EINVAL);
> 
> I'm trying to use __is_defined(SECCOMP_ARCH_NATIVE) here, and got this message:
> 
> kernel/seccomp.c: In function ‘seccomp_prepare_filter’:
> ././include/linux/kconfig.h:44:44: error: pasting "__ARG_PLACEHOLDER_"
> and "(" does not give a valid preprocessing token
>    44 | #define ___is_defined(val)  ____is_defined(__ARG_PLACEHOLDER_##val)
>       |                                            ^~~~~~~~~~~~~~~~~~
> ././include/linux/kconfig.h:43:27: note: in expansion of macro ‘___is_defined’
>    43 | #define __is_defined(x)   ___is_defined(x)
>       |                           ^~~~~~~~~~~~~
> kernel/seccomp.c:629:11: note: in expansion of macro ‘__is_defined’
>   629 |           __is_defined(SECCOMP_ARCH_NATIVE);
>       |           ^~~~~~~~~~~~
> 
> Looking at the implementation of __is_defined, it is:
> 
> #define __ARG_PLACEHOLDER_1 0,
> #define __take_second_arg(__ignored, val, ...) val
> #define __is_defined(x) ___is_defined(x)
> #define ___is_defined(val) ____is_defined(__ARG_PLACEHOLDER_##val)
> #define ____is_defined(arg1_or_junk) __take_second_arg(arg1_or_junk 1, 0)
> 
> Hence, when FOO is defined to be 1, then the expansion would be
> __is_defined(FOO) -> ___is_defined(1) ->
> ____is_defined(__ARG_PLACEHOLDER_1) -> __take_second_arg(0, 1, 0) ->
> 1,
> and when FOO is not defined, the expansion would be __is_defined(FOO)
> -> ___is_defined(FOO) -> ____is_defined(__ARG_PLACEHOLDER_FOO) ->
> __take_second_arg(__ARG_PLACEHOLDER_FOO 1, 0) -> 0
> 
> However, here SECCOMP_ARCH_NATIVE is an expression from an OR of some
> bits, and __is_defined(SECCOMP_ARCH_NATIVE) would not expand to
> __ARG_PLACEHOLDER_1 during any stage in the preprocessing.
> 
> Is there any better way to do this? I'm thinking of just doing #if
> defined(CONFIG_CHECKPOINT_RESTORE) || defined(SECCOMP_ARCH_NATIVE)
> like in Kee's patch.

Yeah, I think that's simplest.

-- 
Kees Cook
