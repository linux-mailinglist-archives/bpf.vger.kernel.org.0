Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70D46AAD85
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 00:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCDXjs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 18:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDXjs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 18:39:48 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423AFF3C
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 15:39:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o12so24353755edb.9
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 15:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677973185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7utmNc1D4fxH2sEwOxjVk9bboOcM1tsrFmWH5NhN6nA=;
        b=pPR9klU6oPkA5duvxU0bku1LQ9ZN4uee1AdzJa76Dug5qEUlJ4LLl0m1GFzMNvzsxO
         /q8Sb7zBliiB3AweCv3N555s9+ArXA2YERtvbcg8/iMZkzBDm9y0Rwu/mYKLXc9TbxXu
         h2eM4JV/tK6VIokat/eLs0CZ6yr3n6Jq5k+EmoRFR1ZIxyFEBM+UsIKzXJYxHw7S55QT
         oFE+vGSVZ+zMrvRoEMLRMdKyN6QdTOUiqUGjScWSlypSPb7qUDtXvEvCQV7MBflFRScX
         ZLdJ3/HU9UWBeMdlo3Dg8he/3rtQbKxUGu9sJOmCRnOzxiVNiR+50+YU2pPPfkIrlDri
         JXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677973185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7utmNc1D4fxH2sEwOxjVk9bboOcM1tsrFmWH5NhN6nA=;
        b=AUjv5zcrN1fafDKO0VXbXXqnJQFFXu7LolU7akYc7dkeOp32uJmw8kkDDQ8D/FgemG
         ZLeVWTx7QziW5KeQyMVj0dyyjK+03hr1yBsHiHuh3M9H/AUl3adnzFHwR6/YcueFz+v0
         4Bu9/7TZkYel9xLjmMGBRcoV5Y1uRZi97vT8Vb85FrpU6l5YbNz++9wkbGVkqmWKsmmL
         NTfdAuZmgEanPOrXaOLFGpoO7qABwkm/MZEgdI2biv18fV+NmpGqPBQzALR6GOYGHYka
         EkCQAoxyr3PWlqXUSo87ycmGdMWdo+h31frROW3SIsRUT3Y0haJmhpuigFLAXLIYYSUB
         nK+g==
X-Gm-Message-State: AO0yUKXQI5TQzTBHUemfdXnPnfCf0mcqKhcgkjPDsLfVtnSYGMpcyMlB
        1QzRShxgpekKiHYgFjNLmoODH+rnAqNJlphH/Uo=
X-Google-Smtp-Source: AK7set8gb9JNQJwfOJJoASf3/bvzu7UuWkZckdN5NDST3XQYwfPBigFDq1wgrUvAoohx5yNb3D8kFMf7RcuuaiVXvp4=
X-Received: by 2002:a17:906:1643:b0:8af:4963:fb08 with SMTP id
 n3-20020a170906164300b008af4963fb08mr3013464ejd.15.1677973185057; Sat, 04 Mar
 2023 15:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20230228142531.439324-1-9erthalion6@gmail.com>
 <CAEf4BzYz5dmJBzTuEvihDqjYyWqUcQE6YLUH1WdC_RDifu7FpA@mail.gmail.com> <20230301210726.vqdea7dksathapej@erthalion.local>
In-Reply-To: <20230301210726.vqdea7dksathapej@erthalion.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 4 Mar 2023 15:39:33 -0800
Message-ID: <CAEf4BzaFu_qFvwtE-=WLWM2YUirq5fKbbTGXVeNiqrARdLj+Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Use text error for btf_custom_path failures
To:     Dmitry Dolgov <9erthalion6@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 1, 2023 at 1:09=E2=80=AFPM Dmitry Dolgov <9erthalion6@gmail.com=
> wrote:
>
> > On Wed, Mar 01, 2023 at 11:02:25AM -0800, Andrii Nakryiko wrote:
> >
> > > Use libbpf_strerror_r to expand the error when failed to parse the bt=
f
> > > file at btf_custom_path. It does not change a lot locally, but since =
the
> > > error will bubble up through a few layers, it may become quite
> > > confusing otherwise. As an example here is what happens when the file
> > > indicated via btf_custom_path does not exist and the caller uses
> > > strerror as well:
> > >
> > >     libbpf: failed to parse target BTF: -2
> > >     libbpf: failed to perform CO-RE relocations: -2
> > >     libbpf: failed to load object 'bpf_probe'
> > >     libbpf: failed to load BPF skeleton 'bpf_probe': -2
> > >     [caller]: failed to load BPF object (errno: 2 | message: No such =
file or directory)
> > >
> > > In this context "No such file or directory" could be easily
> > > misinterpreted as belonging to some other part of loading process, e.=
g.
> > > the BPF object itself. With this change it would look a bit better:
> > >
> > >     libbpf: failed to parse target BTF: No such file or directory
> > >     libbpf: failed to perform CO-RE relocations: -2
> > >     libbpf: failed to load object 'bpf_probe'
> > >     libbpf: failed to load BPF skeleton 'bpf_probe': -2
> > >     [caller]: failed to load BPF object (errno: 2 | message: No such =
file or directory)
> >
> > I find these text-only error messages more harmful, actually. Very
> > often their literal meaning is confusing, and instead the process is
> > to guess what's -Exxx error they represent, and go from there.
> >
> > Recently me and Quentin discussed moving towards an approach where
> > we'd log both symbolic error value (-EPERM instead of -1) and also
> > human-readable text message. So I'd prefer us figuring out how to do
> > this ergonomically in libbpf and bpftool code base, and start moving
> > in that direction.
>
> Fair enough, thanks. I would love to try out any suggestions in this
> area -- we were recently looking into error handling, and certain parts
> were suboptimal.
>
> Talking about confusing text error messages, I'm curious about -ESRCH
> usage. It's being used in libbpf and various subsystem as well to
> indicate that something wasn't found, so I guess it's an established
> practice. But then in case btf__load_vmlinux_btf can't find a proper
> file and reports an error, the caller gets surprising "No such process"
> out of strerror. Am I missing something, is it implemented like this on
> purpose?

It's probably not 100% consistent throughout libbpf, but -ESRCH is
used to denote "a process to determine/find something failed". -ENOENT
is used when we are requested to find a specific entry, and it's not
there (but otherwise there were no errors encountered). That's the
distinction.

The problem with those text explanations of errors is that they are
coming from Linux's usage of them in the context of process or file
manipulations, and I don't see a way around that. I'd like to minimize
the use of custom error codes.

But this is the reason I'd like to output `-ESRCH` instead of either
-3 or "No such process". Something like "-ESRCH (No such process)" is
a compromise, but better than nothing.

Or we could stick to just -ESRCH. That might be better than test
descriptions, as we at least don't confuse them with irrelevant
descriptions.

But Quentin might find it not very user-friendly for his bpftool use
cases, probably.
