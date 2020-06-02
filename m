Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B771EBEAD
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgFBPDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBPDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 11:03:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0013EC08C5C0
        for <bpf@vger.kernel.org>; Tue,  2 Jun 2020 08:03:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c35so10360410edf.5
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2020 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5Bw7bHNhLIhnpxH+p7LoW1YkbfjJOsVhdrmM7ZNA7E=;
        b=DXAxtN+NaXgfyPGWywvDbUQ3rDei4Ap6ncsfze+LHqZxUZwKdBtgzabdTc+jxvzhl0
         cpLsJxGxCKhV2EVbIPHlf8O5KDUPjsz7lHaKv/mPxq32gRYzVwsTqrgE6ttZ3uNav0eX
         Gj/qrnFaTA49yZxUnKOMpr050+Bc7n7OcES9F9sX+ftBkSlLalbmugrXJ9dP5aC19E/F
         i1syq+UsvjkpjFGSZa5nukYmh+qyWlmPmQx0oRy0w/6bfi1dt4rJngTbzncke2YVlM7J
         k2hWysFyAwLwdSadmV07Ni/a75xrjAoaJlWmSBKkAr3A0sbgwwJZKobaVfWmsGMBkxCC
         wlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5Bw7bHNhLIhnpxH+p7LoW1YkbfjJOsVhdrmM7ZNA7E=;
        b=uCPzGrVDBXSo/WFX0JeL7WoH6sxO1lZyQWs+AdUY9ItYX45Cp/lzVKHxdAqJwTZf/V
         YejjN5y55umGNGHwsbSF7osqhtPC+l6ZS4+ZjLObct8RVSRE/wMx8OuA/SP58jmLHgjH
         CaveiAlDj6GtxsZwXpd1xo+dGVTMhBWss25yUZKXe79tpmTgN0xq+y847pPoAYfNhXoV
         gt34iJoz/QjM5lx3rZwzIp1jAvRFEYbuMJjI72LQohq41ea5ax3CjRe2eZe81jF57ryF
         W/HNWzpKoMC/+JSsoG6kC8poYz2XzLIPk3LdxxbX7r+khYw3pbktOEHaweM5ttDP5CZh
         TecQ==
X-Gm-Message-State: AOAM5314Kvo6mIdguHc8HceLFxHNpw1CKXoDCCKu5+68r0jmleun3VO9
        /SBqXW8hAD81ie+YnFTNFCKdxwQKqrmgQoQCo2JH
X-Google-Smtp-Source: ABdhPJyJC8AuZoNH33BFx72UO1lmCUEEtK3+lGG7fwKQLI++MdFbfg45jFICOElrtrwZmq1TRejrXrWr+GmEIabrNgA=
X-Received: by 2002:aa7:cb8d:: with SMTP id r13mr26336805edt.12.1591110222280;
 Tue, 02 Jun 2020 08:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com> <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook> <202005291043.A63D910A8@keescook>
 <20200601101137.GA121847@gardel-login> <CAHC9VhTK1306C2+ghMWHC0X6XVHiG+vBKPC5=7QLjxXwX4Eu9Q@mail.gmail.com>
 <20200602125323.GB123838@gardel-login>
In-Reply-To: <20200602125323.GB123838@gardel-login>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Jun 2020 11:03:31 -0400
Message-ID: <CAHC9VhShd2GLqei6MSREr_vzeVXNcObdVVgvhj1WP7_Ob2C3ag@mail.gmail.com>
Subject: Re: new seccomp mode aims to improve performance
To:     Lennart Poettering <lennart@poettering.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
        Tom Hromatka <tom.hromatka@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 2, 2020 at 8:53 AM Lennart Poettering
<lennart@poettering.net> wrote:
> On Mo, 01.06.20 08:32, Paul Moore (paul@paul-moore.com) wrote:
>
> > In situations where the calling application creates multiple per-ABI
> > filters, the seccomp_merge(3) function can be used to merge the
> > filters into one.  There are some limitations (same byte ordering,
> > filter attributes, etc.) but in general it should work without problem
> > when merging x86_64, x32, and x86.
>
> Hmm, so we currently only use seccomp_rule_add_exact() to build an
> individual filter and finally seccomp_load() to install it. Which
> tells us exactly what works and what does not.
>
> If we now would use seccomp_rule_add_exact() to build the filters, but
> then use seccomp_merge() to merge them all, and then only do a single
> seccomp_load(), will this give us the same info? i.e. will
> seccomp_merge() give us the same errors seccomp_load() currently gives
> us when something cannot work?

Yes, it should.  The seccomp_merge() API was created for applications,
like systemd, that create multiple per-ABI filters but still wanted to
consolidate the multiple filters into one, either to add common rules
or reduce the number of filters loaded into the kernel.

Since the motivation behind the seccomp_merge() API was to help make
it easier to create complex filters for multiple ABIs, it is limited
to merging filters that do not share any of the same ABIs.  For
example, you could merge a filter that contains a x86 ABI with another
filter that contains x86_64 and x32 ABIs but you can *not* merge two
filters that both contain x86 ABIs.  This greatly simplifies the merge
operation and makes it fairly quick.

If you try it and run into any problems let Tom (CC'd) or I know and
we will try to help you guys out.

> > > If we wanted to optimize that in userspace, then libseccomp would have
> > > to be improved quite substantially to let us know exactly what works
> > > and what doesn't, and to have sane fallback both when building
> > > whitelists and blacklists.
> >
> > It has been quite a while since we last talked about systemd's use of
> > libseccomp, but the upcoming v2.5.0 release (no date set yet, but
> > think weeks not months) finally takes a first step towards defining
> > proper return values on error for the API, no more "negative values on
> > error".  I'm sure there are other things, but I recall this as being
> > one of the bigger systemd wants.
>
> Yes, we care about error codes a lot.

The lack of any real stability in error codes was my fault, we really
should have done it sooner but I felt there were bigger issues to
focus on at the time.  Regardless, starting with v2.5.0 we will have
stable error codes that are documented in the manpages; the number of
errors, and the associated documentation, may be relatively limited to
start with, but it should improve over time as we get feedback.

> > As an aside, it is always going to be difficult to allow fine grained
> > control when you have a single libseccomp filter that includes
> > multiple ABIs; the different ABI oddities are just too great (see
> > comments above).  If you need exacting control of the filter, or ABI
> > specific handling, then the recommended way is to create those filters
> > independently and merge them together before loading them into the
> > kernel or applying any common rules.
>
> Hmm, so not sure I got this. But are you saying that when using
> seccomp_merge() am I supposed to merge filters for different archs
> into one megafilter, or are you saying the opposite: am I supposed not
> to do that?

Okay, let me try this again ...

In the context of this discussion it looks like limiting the number of
seccomp filters loaded into the kernel is desirable and one way to do
that with libseccomp is to use the seccomp_merge() API to consolidate
multiple per-ABI filters into one "megafilter" (I like that term)
which can be loaded into the kernel.  Does that make more sense?

> I.e. in an ideal world, should we come to a situation where per
> service on x86-64 we will have exactly one filter installed, or should
> we come to a situation where we'll have exactly three installed, once
> for each ABI?

Perhaps others will clarify, but from my reading of this thread there
is a performance advantage to be gained by limiting the number of
seccomp filters installed for a given process.

--
paul moore
www.paul-moore.com
