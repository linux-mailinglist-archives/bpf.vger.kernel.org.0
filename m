Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B153B65DF61
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 22:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbjADV5Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 16:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbjADV5X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 16:57:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE62137537
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 13:57:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s5so50494295edc.12
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5BxzheT8i/2oiN7+07znQeqnjLK7q6soNBkpyG38cqI=;
        b=eFN6I+SdKfKhR8lKJMtoGJEb4JRHUbbR/PYL9EZcTYwLXHyvFE7++RghMe+eqFiCrG
         E2ZIlGYBkvSZPCBddBWJYnOkc0siYZ4ba11xMf/Ko8KyNOerRL6jZ+RLrujj7yR4qNKN
         /JKvB8hiLeShnsRu8ZMyCKqSE65K0Vkhz173CRzODUOjxCRplGr7a80o+VtLCnjSydFs
         mteajJisk1ONzVtCEBSE3eB5NaCmL3ptwZdn00Sb7gKHmHGLDnlVDhyFR2lQIssMHl/s
         pXqCxRRrH33A9jjKZI5MAFsdvmWmKZKSw9Eoa0b6y46Pv2Kke81HmyyTQMVple01/v4e
         5sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BxzheT8i/2oiN7+07znQeqnjLK7q6soNBkpyG38cqI=;
        b=REPcZg+3S/E2IshEjgSFLBC3Q+pstL1YBadk/VyGzfyTy9uwxqGTitU8nSoL5jDQQm
         CdEO2fWT3ONRBgDGt5SlSZmn6rE8KygMewylphmeYMSVjtSvXMrvPOQ312Tb7JDJC9+n
         rT4u+lxFdwMJmEcS2z4niU3Wv7fCkX3Ii/dinz9l3BFfEiT6xWFBToW1TjrAgDGQSg8D
         GUZC7Dp07/Kqwyd21bkfwzXVsQpyYjf2W66MEFVmXMYdVezNmyqquWMNxioAaPCWaLZE
         CplcZ0kFokBDhdGtdGHs18Omiu9xlQBDPIWyWqequEs7H57lja5QItRoKkveeMZtkOKP
         J1UA==
X-Gm-Message-State: AFqh2kpae1KYYZAadw8ezuIfJk0gs98UIhFDmtgzWpdMpU7Y7ZDr+oT8
        Gw1C0RxLhxElvprJeb3KK849LprP4xAoM8JcjeM=
X-Google-Smtp-Source: AMrXdXsGFK9IlHG1Zo11IMHtXqeytaTwPUhf7R+IiVYcCr4e76u/8jU/WusmbEwNP9AiNPXU+CjIZ88/DlV5DddZlLc=
X-Received: by 2002:aa7:c948:0:b0:48e:9afd:de63 with SMTP id
 h8-20020aa7c948000000b0048e9afdde63mr757170edt.232.1672869441345; Wed, 04 Jan
 2023 13:57:21 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan> <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net> <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
 <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net> <CAEf4BzYXpJtUy9yp_jE-BYG-goAC-5QGwwFM+cPDOHEEKT4kYw@mail.gmail.com>
 <20230104200345.ir6karrn3gfd3iu5@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20230104200345.ir6karrn3gfd3iu5@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 13:57:09 -0800
Message-ID: <CAEf4Bza7xQDjbYKROSyJ=mCamKU5zhzx6B_Tw+Bnu0MxOBLiog@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
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

On Wed, Jan 4, 2023 at 12:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 04, 2023 at 10:59:15AM -0800, Andrii Nakryiko wrote:
> >
> > > >> to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
> > > >> and from an API PoV that it is ready to be a proper BPF helper, and until this point
> > > >
> > > > "Proper BPF helper" model is broken.
> > > > static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> > > >
> > > > is a hack that works only when compiler optimizes the code.
> > > > See gcc's attr(kernel_helper) workaround.
> > > > This 'proper helper' hack is the reason we cannot compile bpf programs with -O0.
> > > > And because it's uapi we cannot even fix this
> > > > With kfuncs we will be able to compile with -O0 and debug bpf programs with better tools.
> > > > These tools don't exist yet, but we have a way forward whereas with helpers
> > > > we are stuck with -O2.
> > >
> >
> > But specifically about how the BPF helper model is broken, that's at
> > least an exaggeration. BPF helper call is defined at BPF ISA level, it
> > has to be a `call <some constant>;`, and as long as compiler generates
> > such code, it's all good. From C standpoint UAPI is just a function
> > call:
> >
> > bpf_map_lookup_elem(&map, ...);
> >
> > As long as this compiles and generates proper `call 1;` assembly
> > instruction, we are good. If/when both Clang and GCC support an
> > alternative way to define helper and not as a static func pointer, -O0
> > builds (at least in the aspect of calling BPF helpers, I suspect other
> > stuff will break still) will just work. And what's better,
> > bpf_helper_defs.h would be able to pick the best option based on
> > compiler's support with end users not having to care or notice the
> > difference.
>
> Right and that's what gcc did with attribute((kernel_helper(1)),
> but we didn't like it because gcc and clang would diverge.
> Now you're arguing it's just a bpf_helper_defs.h change and we should
> have allowed it?

No, I'm saying if you feel so strongly that the current situation is
bad and attribute-based approach is preferable (presumably to allow
-O0 to work), then we can do that (both on GCC and Clang sides) and
everything will work with no UAPI changes. And I did suggest a
relatively clean approach with BPF_HELPER_DEF() ([0]) which would
combine both old and new ways.

But I personally have no problem with the current approach. You are
bringing it up as an UAPI problem, which I'm claiming it is not.

  [0] https://lore.kernel.org/bpf/CAEf4BzYwRyXG1zE5BK1ZXmxLh+ZPU0=yQhNhpqr0JmfNA30tdQ@mail.gmail.com/


>
> Also consider that 'call <some constant>' or more precise 'call absolute_address'
> as an instruction exist in only one CPU architecture. It's BPF ISA.
> It's a mistake that I made 8 years ago and inability to fix it bothers me.
> Now we have 100 times more developers than we had 8 years ago.
> I expect 100 time more UAPI and ABI mistakes.
> Minimizing unfixable mistakes is what I'm after.
