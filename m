Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8638A277E66
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 05:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgIYDJL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 23:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDJK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 23:09:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3D3C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 20:09:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 197so1319662pge.8
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 20:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hJ1W1/RS5W0hSkVAbx2PZJL6p6qwRikie5JVs3zNzvM=;
        b=EeXCN+viasa0U6+b2eUA5OPmUiG4kY9mInu5zsqE0vKBwiPrI2/yiRGJavfHhEJAJP
         J7yh3KiOAm0o+rViCqageC3W19loqvQ2a99KvKlv24zmIbBZEha/N+LHrlVWOgOEgk9J
         jxulU8Gikr3EQZgr6dMYlPslVFZjSjsGK+Cxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hJ1W1/RS5W0hSkVAbx2PZJL6p6qwRikie5JVs3zNzvM=;
        b=QbSWC0EcLMfsnl5UPUGIRpFhtBEiB2RD2AAUm8uv6RavvzXZGv1PcAdaRp5biRY+BF
         Pn+L3X5CS2K81yrpiX1wrOe7fvcLX09jRcnae8UogHGCm6E5RsnRoi4DJOzkWycfCkCV
         LHVJHu+EOEwM4642XDymegS6NE6sJwG/cgdwhI95To1xXthWPleBL/UE9KsnnRvSp56j
         U17sgPxZ3EEcRJNsPFUWyj82gtvlLCxpgJzoGpEj1zWeb3WaH2AV46hgjfxfQM+s6OyZ
         Q/b0eH+KAYZhta94t4F6tUcjK3OgCOylIOrEdOF30ifpbhiW7qKyTtVze8grfGEfZXFa
         CIMA==
X-Gm-Message-State: AOAM533u+B4IA6uny5f7bIFFfDCf6GniPRkn3BU3wD9PHM8ux4a/KqWd
        w4LMDuHLUHxipF46J5N+BIEraA==
X-Google-Smtp-Source: ABdhPJy3M327HKr9IezlNDMptTHO3YONc893KnALpMIxtXbLrvx0ZnSoE0AAxZuUKojDDbhv4QCZ7w==
X-Received: by 2002:a17:902:b7c4:b029:d0:b7a2:d16 with SMTP id v4-20020a170902b7c4b02900d0b7a20d16mr2244425plz.11.1601003350409;
        Thu, 24 Sep 2020 20:09:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q140sm95635pfc.39.2020.09.24.20.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:09:09 -0700 (PDT)
Date:   Thu, 24 Sep 2020 20:09:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
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
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
Message-ID: <202009242000.DE12689BD8@keescook>
References: <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <202009241658.A062D6AE@keescook>
 <CABqSeAQ=joheH+0LUZ201U-XwFFsHN3Ouo5FGoscUwn+itkL2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeAQ=joheH+0LUZ201U-XwFFsHN3Ouo5FGoscUwn+itkL2w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 08:27:40PM -0500, YiFei Zhu wrote:
> [resending this too]
> 
> On Thu, Sep 24, 2020 at 6:01 PM Kees Cook <keescook@chromium.org> wrote:
> > Disregarding the "how" of this, yeah, we'll certainly need something to
> > tell seccomp about the arrangement of syscall tables and how to find
> > them.
> >
> > However, I'd still prefer to do this on a per-arch basis, and include
> > more detail, as I've got in my v1.
> >
> > Something missing from both styles, though, is a consolidation of
> > values, where the AUDIT_ARCH* isn't reused in both the seccomp info and
> > the syscall_get_arch() return. The problems here were two-fold:
> >
> > 1) putting this in syscall.h meant you do not have full NR_syscall*
> >    visibility on some architectures (e.g. arm64 plays weird games with
> >    header include order).
> 
> I don't get this one -- I'm not playing with NR_syscall here.

Right, sorry, I may not have been clear. When building my RFC I noticed
that I couldn't use NR_syscall very "early" in the header file include
stack on arm64, which complicated things. So I guess what I mean is
something like "it's probably better to do all these seccomp-specific
macros/etc in asm/include/seccomp.h rather than in syscall.h because I
know at least one architecture that might cause trouble."

> > 2) seccomp needs to handle "multiplexed" tables like x86_x32 (distros
> >    haven't removed CONFIG_X86_X32 widely yet, so it is a reality that
> >    it must be dealt with), which means seccomp's idea of the arch
> >    "number" can't be the same as the AUDIT_ARCH.
> 
> Why so? Does anyone actually use x32 in a container? The memory cost
> and analysis cost is on everyone. The worst case scenario if we don't
> support it is that the syscall is not accelerated.

Ironicailly, that's the only place I actually know for sure where people
using x32 because it shows measurable (10%) speed-up for builders:
https://lore.kernel.org/lkml/CAOesGMgu1i3p7XMZuCEtj63T-ST_jh+BfaHy-K6LhgqNriKHAA@mail.gmail.com

So, yes, as you and Jann both point out, it wouldn't be terrible to just
ignore x32, it seems a shame to penalize it. That said, if the masking
step from my v1 is actually noticable on a native workload, then yeah,
probably x32 should be ignored. My instinct (not measured) is that it's
faster than walking a small array.[citation needed]

> > So, likely a combo of approaches is needed: an array (or more likely,
> > enum), declared in the per-arch seccomp.h file. And I don't see a way
> > to solve #1 cleanly.
> >
> > Regardless, it needs to be split per architecture so that regressions
> > can be bisected/reverted/isolated cleanly. And if we can't actually test
> > it at runtime (or find someone who can) it's not a good idea to make the
> > change. :)
> 
> You have a good point regarding tests. Don't see how it affects
> regressions though. Only one file here is ever included per-build.

It's easier to do a per-arch revert (i.e. all the -stable tree
machinery, etc) with a single SHA instead of having to write a partial
revert, etc.

-- 
Kees Cook
