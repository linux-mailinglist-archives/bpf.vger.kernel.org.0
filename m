Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2DC65DC72
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 19:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjADS7i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 13:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjADS73 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 13:59:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81913DFA
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 10:59:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id x22so84833349ejs.11
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 10:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=po1R5C8srfii+Jb1xQD7HqUHS3ObITC9Dq+VlO/lBeI=;
        b=BTftb7FGtfm1g2ljiJ9PklLW6hiyIWrqM/q+w4kbewPJ/8o8iuPHPJsvayiWVsHgJ6
         vQSzvV308qR5VO3kjIJgIVomYvVUz/MAb/o+5z6CZeWKH9QPs+1/CnSrYO3zt8LGnMTe
         M+Sl3qhDsTIg05dFN7t/i5sTVYk7qtFxkmGd3uNhRoMFLwTpqUGmZ6gwZ5e81q8XLsQc
         x3IJKpt7LuNg9eNRYmNVjBySAPYTDFXnfjjOgr8igz5qfFwtsChP9GCNc5y7TglhUKyY
         1w/e1WtzT8fQq0O5dFTZZumvosJTo8iYSU8ZRcQH6gncpAbDpMsogbeqWh3sr1uM8P+V
         s+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po1R5C8srfii+Jb1xQD7HqUHS3ObITC9Dq+VlO/lBeI=;
        b=2vrt4VpoZP5dw3bmMIdCY41mTv3abAbwlQUW4fSICPq5PnfOdRrmPJxzCA4WsJC7u5
         EKKfvyDdtEtz9IEEf4h/DyDN4/sD6V3652zz0la4RKSjGBBgwkbFsv8+vUMveo5auckd
         D9LuzI/zhoZAOK8vdfAxVgHzISGV/s2doJlCQxQg3+kFOyuDEU9G3u8Wojw0gewPxre7
         rQpjt8mAY3pyARsDLAju9xkqREDuO1d1peY19obJeRYNAFyIgjT0rcuoL6PqBT+IJQE8
         BU75HmnvZ3EoXI7glyW2N84TzeQvY3rfpVFqMKkAw1wXOJRTMdkqjPG+3L/S5Spo2tCV
         E8dA==
X-Gm-Message-State: AFqh2krTjJPugf0QUkvjIzX0QqiBlAh0lcvXVgJ0M6isU0nHyBpVNibl
        3TBFQSAQNqhqsunzvUyBQe8O0ktjQniW0h1zuT8=
X-Google-Smtp-Source: AMrXdXv6KNa7Zc1vOYArFUZwAGjkn/G1cCxoKMzHvd+cUY6mqwl+cB0LCHRTzu19uEuU8tB0KfDsHVTniFuN/xYkgIQ=
X-Received: by 2002:a17:906:f209:b0:7fd:f0b1:c8ec with SMTP id
 gt9-20020a170906f20900b007fdf0b1c8ecmr3141073ejb.114.1672858767470; Wed, 04
 Jan 2023 10:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan> <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net> <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net>
In-Reply-To: <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 10:59:15 -0800
Message-ID: <CAEf4BzYXpJtUy9yp_jE-BYG-goAC-5QGwwFM+cPDOHEEKT4kYw@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 4, 2023 at 6:25 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/4/23 12:51 AM, Alexei Starovoitov wrote:
> > On Tue, Jan 03, 2023 at 12:43:58PM +0100, Daniel Borkmann wrote:
> >> On 12/31/22 1:42 AM, Alexei Starovoitov wrote:
> >>> On Fri, Dec 30, 2022 at 03:00:21PM -0600, David Vernet wrote:
> >>>>>>
> >>>>>> Taking bpf_get_current_task() as an example, I think it's better to have
> >>>>>> the debate be "should we keep supporting this / are users still using
> >>>>>> it?" rather than, "it's UAPI, there's nothing to even discuss". The
> >>>>>> point being that even if bpf_get_current_task() is still used, there may
> >>>>>> (and inevitably will) be other UAPI helpers that are useless and that we
> >>>>>> just can't remove.
> >>>

+1 to all the things Daniel said about end user pains and barriers for
adoption, glad I'm not the only one arguing this anymore.

[...]

> >> to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
> >> and from an API PoV that it is ready to be a proper BPF helper, and until this point
> >
> > "Proper BPF helper" model is broken.
> > static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> >
> > is a hack that works only when compiler optimizes the code.
> > See gcc's attr(kernel_helper) workaround.
> > This 'proper helper' hack is the reason we cannot compile bpf programs with -O0.
> > And because it's uapi we cannot even fix this
> > With kfuncs we will be able to compile with -O0 and debug bpf programs with better tools.
> > These tools don't exist yet, but we have a way forward whereas with helpers
> > we are stuck with -O2.
>

But specifically about how the BPF helper model is broken, that's at
least an exaggeration. BPF helper call is defined at BPF ISA level, it
has to be a `call <some constant>;`, and as long as compiler generates
such code, it's all good. From C standpoint UAPI is just a function
call:

bpf_map_lookup_elem(&map, ...);

As long as this compiles and generates proper `call 1;` assembly
instruction, we are good. If/when both Clang and GCC support an
alternative way to define helper and not as a static func pointer, -O0
builds (at least in the aspect of calling BPF helpers, I suspect other
stuff will break still) will just work. And what's better,
bpf_helper_defs.h would be able to pick the best option based on
compiler's support with end users not having to care or notice the
difference.

This is not an UAPI problem at all.


> Better debugging tools are needed either way, independent of -O0 or -O2. I don't
> think -O0 is a requirement or barrier for that. It may open up possibilities for
> new tools, but production is still running with -O2. Proper BPF helper model is
> broken, but everyone relies on it, and will be for a very very long time to come,
> whether we like it or not. There is a larger ecosystem around BPF devs outside of
> kernel, and developers will use the existing means today. There are recommendations /
> guidelines that we can provide but we also don't have control over what developers
> are doing. Yet we should make their life easier, not harder. Better debugging
> possibilities should cater to everyone.
>
> Thanks,
> Daniel
