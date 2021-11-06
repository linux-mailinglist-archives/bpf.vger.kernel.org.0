Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2308F447050
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 21:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhKFUFF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Nov 2021 16:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhKFUFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Nov 2021 16:05:04 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB9C061570
        for <bpf@vger.kernel.org>; Sat,  6 Nov 2021 13:02:23 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id q74so31996156ybq.11
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yoaA4TbjsXwn1z2dwHqJh3n6gzS1VVqIDVL0LK8Jqw=;
        b=MQXfEf+3grK8+7Hs/8wz5GT2/2xX2LtBJJs3HV7q4hXa1z7jpRMDfE4kAj/O4VHcpk
         rSPoVotjSQ/Y305+3UZubuHf2hX7+6t4npyK5O9b8Sk0T4P/KneS1MIsvw1MY+cPj9Tc
         YG0pt3rCTwCskYftgALkmPWcAoO4MEzCIDs+wT0wH9nzjkilNz7GPPibFgctQUho9hHS
         0X4Koqqh0v9g5phGx2yXNrhzpvIEk+k7pJ6HTnkHkAtWkiAqSusSpcmDU/314G1L6Ykc
         +Fsi5J530w2qXnCpad3ALX7UdG1qFbvowZ0y/AX5MGfZ9NoTIuEU9umjeGsU6w5CSyEc
         jpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yoaA4TbjsXwn1z2dwHqJh3n6gzS1VVqIDVL0LK8Jqw=;
        b=5cLTjfLh4hlB512p3hmtwboweC5lcVzrdLBCXNmx+/QRq76WsMEZ6YdPj5wumtRa4/
         uCymjlFC9+jPVHeOUlk2W587S4ZB9LbAKLXpFCT9Ibx6uqD6+gHIPIAyb2XutLoGle3z
         xzz9u5LMYMpOsHAhVjkCkogOMYJwSe8XedYDVvo0TuRhr6aplYSIqq3LLkhDWbpXmarg
         48rsowHnNVmQ/qDkiKrOTmBjb9SQB1widHw91xw4w+qU+BMBkeW20onbZqoAs9aeEVoN
         lIqgqNEMzluvKmYe0Q6g32T7DAxRiCNue2JVWefKshlja+sh7JhctkW9XFeyY2rmBpGN
         gXEQ==
X-Gm-Message-State: AOAM531FxO3LKBvgI8KemKQaPdmEcB3tiFAZsK5ZNAVhbl4jxo81Pl9T
        1/FGyyAjvIQbtVX5nKUM3CZDHylTFNBy/EXt4R8=
X-Google-Smtp-Source: ABdhPJxMQTtah1txvMwEQFArmXbF7r9D67652K9xNWXrPoMDruS94YQiHD8l9aAsNqzK5I9/qMpf/TvA99566uTX37A=
X-Received: by 2002:a25:d16:: with SMTP id 22mr63879821ybn.51.1636228942635;
 Sat, 06 Nov 2021 13:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211105234243.390179-1-memxor@gmail.com> <CAADnVQ+6D7_7WQr2OdDRHr9tp9L-4zUvSMWh09j=-t8w-1BzCQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+6D7_7WQr2OdDRHr9tp9L-4zUvSMWh09j=-t8w-1BzCQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 6 Nov 2021 13:02:11 -0700
Message-ID: <CAEf4BzYGG04bXBFEv-yk9jmV6amxxzGM-Zr0=0CoJAMRGxg6kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] Change bpftool, libbpf, selftests to
 force GNU89 mode
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 6, 2021 at 9:34 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 5, 2021 at 6:36 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Fix any remaining instances that fail the build in this mode.  For selftests, we
> > also need to separate CXXFLAGS from CFLAGS, since adding it to CFLAGS simply
> > would generate a warning when used with g++.
> >
> > This also cherry-picks Andrii's patch to fix the instance in libbpf. Also tested
> > introducing new invalid usage of C99 features.
> >
> > Andrii Nakryiko (1):
> >   libbpf: fix non-C89 loop variable declaration in gen_loader.c
> >
> > Kumar Kartikeya Dwivedi (5):
> >   bpftool: Compile using -std=gnu89
> >   libbpf: Compile using -std=gnu89
> >   selftests/bpf: Fix non-C89 loop variable declaration instances
> >   selftests/bpf: Switch to non-unicode character in output
> >   selftests/bpf: Compile using -std=gnu89
>
> Please don't.
> I'd rather go the other way and drop gnu89 from everywhere.
> for (int i = 0
> is so much cleaner.

I agree that for (int i) is better, but it's kernel code style which
we followed so far pretty closely for libbpf and bpftool. So I think
this is the right move for bpftool and libbpf.

Selftests are less consistent in styling and lack of unicode character
in bench is annoying, so I don't mind leaving selftest more
permissive.

And even with all that, we've managed to keep BPF program code
consistently in C89 here in selftests and in bcc/libbpf-tools. The
code style uniformity is nice.

Whether to relax BCC compilation flags is a separate discussion (and I
don't have any strong opinion). I'd still enforce -std=gnu89 for BPF
source code for consistency across many BPF projects.
