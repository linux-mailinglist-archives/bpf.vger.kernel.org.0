Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A773105FC
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 08:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBEHkm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 02:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhBEHkj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 02:40:39 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89196C0613D6;
        Thu,  4 Feb 2021 23:39:59 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i71so5851926ybg.7;
        Thu, 04 Feb 2021 23:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqGNw4G/NzE+7A2wNT+rbd+x4klWLhZ5onfW19HWXFo=;
        b=UtAJ2Izq7fvv2wLdL+Q238QDUT0UXkTQGojPeBuW8jZeTv3I7iSpfd0i3oNDHNDZsz
         mspK3Nhyws3Osm3ia3srJTBAk8WJ4xAlozqMO4L0xrh6dVjgc4iEbm1YzSwce1cC2tde
         htMYaxTxtsNeN51GUx7rX0Rn3HORZe2RissAiYOvrq3/uPVPJwKym8SXWo0CsVHtoDZU
         73YZ/kLFc8QTzlxAeTKHfNe4rAOdm2+Ma+2d/YKYuDkQmRiG/0WHF6hF330PnzLfFHqk
         t/YEVTnjfMp5x+Pltw62JtunJO6R/AhgJnaiLXEEHwLg914WQDm+xdvimGdPx4blb+Dx
         BsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqGNw4G/NzE+7A2wNT+rbd+x4klWLhZ5onfW19HWXFo=;
        b=trHHRflSAjuzU/3NBnFhPGWPpp2fycT+kHZfAD2IBqtnBxBc6ry882hCgmu2nr/510
         XP2jbMPf5FpxfYsJSW6hTMGvX1CfG2F6bYvAYAb887AZVxd1ZJhqy64vSq0VM8Asw/B5
         T93Ee1dAfn6waPKA5B7s/vF8VaT2TQTcdPrb72tVga1jiHoNTe8gjpkY2smBr9iyczRh
         r/SignIOccjEh0pH5BbbXWZqOkz6H4/8Ai/DYVEtKI3hmyMUq3Qx4rl+V3IG49kl9kuD
         3aC29tLR70Gh5YP3tBX0++EwHeEchqpTdhJhwqoa1INLolw+X1rw6QN9DCJ01G7fjzMo
         NwmQ==
X-Gm-Message-State: AOAM531aUD/GvM6SBQQfWnkbWx0iuqhKrCH3QOVDKnSE0Vv4smVmkgs4
        nwzYzYLC7OUO4rZPvmVOcBQe0kTo2ckN+SEpCGyaG+DORdRqRw==
X-Google-Smtp-Source: ABdhPJwprkQQPTa3A3Qjb2rKtEXx/WLgrNN8j2W1vnwCNwfjYMlwGfM8qo7JOih3BfOjIxDXYfzQmSWw5gQOUiiVw4Q=
X-Received: by 2002:a25:d844:: with SMTP id p65mr4228124ybg.27.1612510798784;
 Thu, 04 Feb 2021 23:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CAEf4BzY-RbXXW-Ajcvq4fziOJ=tMtT7O76SUboHQyULNDkhthw@mail.gmail.com>
 <C359F19F-29BC-4F6D-961A-79BFA47F36A7@gmail.com>
In-Reply-To: <C359F19F-29BC-4F6D-961A-79BFA47F36A7@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Feb 2021 23:39:47 -0800
Message-ID: <CAEf4BzZf_1g13dA1t6rbi1TFttufyGNaU14pPxo9uK-FVArCbQ@mail.gmail.com>
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 8:34 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On February 4, 2021 9:01:51 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >On Thu, Feb 4, 2021 at 2:09 PM Arnaldo Carvalho de Melo><acme@kernel.org> wrote:
> >>         The v1.20 release of pahole and its friends is out, mostly
> >> addressing problems related to gcc 11 defaulting to DWARF5 for -g,
> >> available at the usual places:
> >
> >Great, thanks, Arnaldo! Do you plan to build RPMs soon as well?
>
> It's in rawhide already, I'll do it for f33, f32 later,
>

Do you have a link? I tried to find it, but only see 1.19 so far.

> - Arnaldo
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
