Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C126C277E80
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 05:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIYD1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 23:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgIYD1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 23:27:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F87C0613D3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 20:27:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so1143912pjd.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 20:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DeK1msedXGauky3LlZFdr+n8u+1Ihl4Ki0G/c0dEbRY=;
        b=cQNWEhuaNcfuMfCkkICKyKMwE1l6FY6pAgtxRmC7RXPnlCJ0saei23PhAdo67xody0
         RVpo2EJG4WpdQ5R8+mD+eB/MgkgQZPZufWt9hd4uz6jxYGpgabSCzyVqUGlBLvU+VxBt
         ZSrIa4uahkkdPSl2dtlVqAtgg+jd1CNPrWcwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DeK1msedXGauky3LlZFdr+n8u+1Ihl4Ki0G/c0dEbRY=;
        b=RVFCoKlboOJVFZZQmwc5jJrmDPN228qgTQvjtXShH2vtc7aUoLn0foQC/iR5CFWKQU
         PxOh7OcS9KtqDxMEGTv4w3HPOSaf3EyOnsR8jupxdDZbq2t2P7qP9lp3XB+J3giEknoY
         JvYNOP5D+G4z8byJ7abCMqpoSjhO5itFfDtvdwRsyqtaUNkttygbnU693TvFIXVl3sE2
         3YGXzl9Az8rDvQ1+WZZCfCcZ/1SQ8jNiVv7RsCL0Aaj+OobnpamIv822Hp5QTQGeq+SB
         eQQjIZCo6aQHxNA5ogzFkv4wRL6pajko6xAhgU2RP1FKjt4fQ4deAIp74WSH9YOPG3Yx
         nBKA==
X-Gm-Message-State: AOAM533aOhyNUAbbVbYWnwNiNsBH7J2acprY6Izp9fxc9lOntOHoSQYH
        akD0Zs7M/zSixT3nXiyI4uR5YQ==
X-Google-Smtp-Source: ABdhPJymYYYGWizHsr6HmLpbJR37C6I0dl0R7R4eB+yVnjR5cxc6gFLsOvtjiudHcJH8+ojao39tog==
X-Received: by 2002:a17:90b:4a0c:: with SMTP id kk12mr655501pjb.223.1601004420158;
        Thu, 24 Sep 2020 20:27:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10sm637973pgm.64.2020.09.24.20.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:26:59 -0700 (PDT)
Date:   Thu, 24 Sep 2020 20:26:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
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
Subject: Re: [PATCH v2 seccomp 6/6] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202009242021.B0FB41084@keescook>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
 <b11ebe533838af7829a5e7381a7914bca27cb621.1600951211.git.yifeifz2@illinois.edu>
 <202009241647.2239747F0@keescook>
 <CABqSeASrwXwSHHAsVwjG6vCLbfXpkp+42HWW27MUK2zgMnAu8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeASrwXwSHHAsVwjG6vCLbfXpkp+42HWW27MUK2zgMnAu8w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 10:11:17PM -0500, YiFei Zhu wrote:
> On Thu, Sep 24, 2020 at 6:56 PM Kees Cook <keescook@chromium.org> wrote:
> > > This file is guarded by CONFIG_PROC_SECCOMP_CACHE with a default
> > The question of permissions is my central concern here: who should see
> > this? Some contained processes have been intentionally blocked from
> > self-introspection so even the "standard" high bar of "ptrace attach
> > allowed?" can't always be sufficient.
> >
> > My compromise about filter visibility in the past was saying that
> > CAP_SYS_ADMIN was required (see seccomp_get_filter()). I'm nervous to
> > weaken this. (There is some work that hasn't been sent upstream yet that
> > is looking to expose the filter _contents_ via /proc that has been
> > nervous too.)
> >
> > Now full contents vs "allow"/"filter" are certainly different things,
> > but I don't feel like I've got enough evidence to show that this
> > introspection would help debugging enough to justify the partially
> > imagined safety of not exposing it to potential attackers.
> 
> Agreed. I'm inclined to make it CONFIG_DEBUG_SECCOMP_CACHE and guarded
> by a CAP just to make it "debug only".

Yeah; I just can't quite see what the best direction is here. I will
ponder this more. As I mentioned, it does seem handy. :)

> Is there something to stop a config from being enabled in an
> allyesconfig? I remember seeing something like that. Else if someone
> is manually selecting we can add a help text with a big banner...

Yeah, allyesconfig and allmodconfig both effectively set
CONFIG_COMPILE_TEST. Anyway, likely a caps test will end up being the
way to do it.

> 
> > But behavior-wise, yeah, I like it; I'm fine with human-readable and
> > full AUDIT_ARCH values. (Though, as devil's advocate again, to repeat
> > Jann's own words back: do we want to add this only to have a new UAPI to
> > support going forward?)
> 
> Is this something we want to keep stable?

The Prime Directive of "never break userspace" is really "never break
userspace in a way that someone notices". So if nothing ever parses that
file, then we don't have to keep it stable, but if something does, and
we change it, we have to fix it.

So, a capability test means very few things will touch it, and if we
decide it's not a big deal, we can relax permissions in the future.

-- 
Kees Cook
