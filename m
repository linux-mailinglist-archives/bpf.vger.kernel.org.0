Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B7844DD32
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 22:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhKKVlk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 16:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhKKVlj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 16:41:39 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45CC061767
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 13:38:49 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t11so6664645qtw.3
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 13:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxwVJThHJAypRrQZRCH+RaU8Jxawa/0/CzC1MrNvdNk=;
        b=Rhk8DulPQRbyf7GUFOo5B9sFqsH2/6LF8kqn5/6pVAnkZEVCNOiCifQxSFL420V9d6
         P0eyAsQkOdFTX/ThIvldfdZNDJsoM6onhZ3IzqvrxU6gG7O8UomC/0PHLBWAAD0OxuQA
         2OaPfh/waUEd4clUk+N1fjJcIDVx1pUXR2FpB+Z5XNNUUuNknOfDKTQsCj0eZDFN3Xud
         bSGS01cXX55hQA9MFITidHXS4LY0mwp9qjG5f2qukcCDaB5i97GAlIBEIDJzSIxp3fl0
         VhiGvR865sreCTMf8zu4YCu7nNl1jCXcnbpmZposaoJ7J823wHBGr6w+9Y8vx9IShH1p
         swjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxwVJThHJAypRrQZRCH+RaU8Jxawa/0/CzC1MrNvdNk=;
        b=j0UfXYWR1ciXjpbvkSB+sWkArfMSCKjSUZhu/6kDXPhh83SGBiomn77E2Wy5UXIiVM
         3EOEWkXmDdWeLJ9wL/icrPRZZeGhfzYQrDvDymH5FAdn03oOFyWtmTTN7Pf1iwZqVy1n
         wr8qd4eFWO7d+x6E2d6HISHvdxv6hOVF3UqQF6Rp5Klg2WeUCP7JIu9QpX7jnBC1I0ng
         QiFib9DR84WRv1XBE86oPgm7HSJpx6GwRy1NSCw4Yl8Ek8UNh5If5nW9nmLHJNbIvGdE
         0Sp/aVZETb0jVoZFNVaon4ASj/AAT0BLJUq0b/wU5f+kQ12chTv+BLnAnF+qIxdBqgie
         bWfg==
X-Gm-Message-State: AOAM533xSIvIwqp280z7vJN8zwUKDrJLIBvJAcyM70hMmdUld4ncy4At
        DEQbUaaOxqjKBxrwpmrySPBfkGItDAeoLAHqeMoqpfW//YTbkQ==
X-Google-Smtp-Source: ABdhPJwACpFQXm9HUxlPtmIeP8qujbApF90FdRPuTR6VDMKH/kRrX953/Q3bW2Z3t+ISQDvCyRWNepBwq8M3F3IMRjw=
X-Received: by 2002:a05:622a:4cd:: with SMTP id q13mr11021449qtx.180.1636666728606;
 Thu, 11 Nov 2021 13:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20211110192324.920934-1-sdf@google.com> <CAEf4BzYbvKjOmvgWvNWSK6ra0X5mM_=igi8DVwdojtZodz5pbQ@mail.gmail.com>
 <CACdoK4JzQ2_v+TtLY=61rkv4VPYHBQRgjW-ikMi6KSiBjK7CBg@mail.gmail.com>
In-Reply-To: <CACdoK4JzQ2_v+TtLY=61rkv4VPYHBQRgjW-ikMi6KSiBjK7CBg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 11 Nov 2021 13:38:37 -0800
Message-ID: <CAKH8qBs_4Wk7xM7e__y6FCxZSM8nmqpWXwrpYfxE7Cj5PbPSfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: enable libbpf's strict mode by default
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 1:07 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On Thu, 11 Nov 2021 at 18:19, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Nov 10, 2021 at 11:23 AM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > Otherwise, attaching with bpftool doesn't work with strict section names.
> > >
> > > Also:
> > >
> > > - add --legacy option to switch back to pre-1.0 behavior
> > > - print a warning when program fails to load in strict mode to point
> > >   to --legacy flag
> > > - by default, don't append / to the section name; in strict
> > >   mode it's relevant only for a small subset of prog types
> > >
> >
> > LGTM. I'll wait for Quenting's ack before applying. Thanks!
>
> Looks good as well, thanks Stanislav!
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
>
> I wonder if we should display some indication ("libbpf_strict"?) in
> the output of "bpftool version", alongside "libbfd" and "skeleton"?
> It's not strictly a feature (and would always be present for newer
> versions), but it could help to check how a bpftool binary will
> behave? (I don't mind taking it as a follow-up.)

Sure, makes sense, I can follow up on that.
