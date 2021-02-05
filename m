Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BA931013C
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 01:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhBEACs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 19:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhBEACr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 19:02:47 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B604C06121D;
        Thu,  4 Feb 2021 16:02:03 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id r2so4976737ybk.11;
        Thu, 04 Feb 2021 16:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPLYbscW30uUnmFS2EtBGE+/+NamJbrbryNTpw6+TtQ=;
        b=IkbC3NZf3mDtZwVs4vPkcHCCGrTPOi4CkAwZ1W+pDpupMPibvDoBT4z5IcNs5rUFqg
         pYZQqLFlKlO/L5G/kCTup0yk6+q1qaafhn9JrRdhQtMzESns3rjLDkN91vmAF0T8De80
         KAYx6paKCNjUEqLrvQYzL3JQLUrj93l0qnRDwssB2CPNu48bU3APGsHnlpjJGqDsZOpw
         1LZsjcys514jufuZUJWJJ4joAZEMgdrcTBFe5Y2B4J6CTjkvf+6KpR6J0EYsU+ikRU5I
         Uhgs8EN8r8JLGZygC3qYiXAtHR2sHuVyj2ElCTXqKcNtBY/lyfdsbvLnHbMJNCSY7f3j
         2d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPLYbscW30uUnmFS2EtBGE+/+NamJbrbryNTpw6+TtQ=;
        b=PKFKNqmFgVdB/ZQ42F4CrNBSJXC2AJt0yNljKzjPzgvjxe6eq5I4nGtrezBIX2CaVy
         vTX9gzzaCvD06jgOiO7B6VMjHKvp33PYfQ8k/9KNWoeIFv3CEli/ymRMlKVedkXxcdcN
         Hahovk2hHySyqwtyUABR4rP3QNmHueeIjROjpO65K6hPjH+AOM9kMVPpfeXVhjL6PkSq
         0Rg3aLCSQ4eCLdf3ZlZLtgAtoILfCtlCeTmOSrq1Vk7owuF17+legyRJKNtj8cn+ZHrc
         eBJRxmrFyMRUWEE1vPFkTCf14wcRfWmCXAJjx0yAa6954sjJKKFar6Ag11crgbdiD8z3
         d2cg==
X-Gm-Message-State: AOAM5312w2i33ZnNG7/BmtPv0z7/M3YH7fDy155Kf3NrkG8gIgmN1RRN
        OIQHsl3x1pXNKSWRvB5TccmN+sN5GBkfucrn9wY=
X-Google-Smtp-Source: ABdhPJy3/NjcT0Y2DbYezgYmqrjXhztdNTW/Z5D51s82ZLlcsS/bAEpWRYQ+Xk/DI4sVSiTKGsvHf07wmg/fQ5lPSRo=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr2446517yba.403.1612483322704;
 Thu, 04 Feb 2021 16:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org>
In-Reply-To: <20210204220741.GA920417@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Feb 2021 16:01:51 -0800
Message-ID: <CAEf4BzY-RbXXW-Ajcvq4fziOJ=tMtT7O76SUboHQyULNDkhthw@mail.gmail.com>
Subject: Re: ANNOUNCE: pahole v1.20 (gcc11 DWARF5's default, lots of ELF
 sections, BTF)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org,
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

On Thu, Feb 4, 2021 at 2:09 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Hi,
>
>         The v1.20 release of pahole and its friends is out, mostly
> addressing problems related to gcc 11 defaulting to DWARF5 for -g,
> available at the usual places:

Great, thanks, Arnaldo! Do you plan to build RPMs soon as well?

>
> Main git repo:
>
>    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
>
> Mirror git repo:
>
>    https://github.com/acmel/dwarves.git
>
> tarball + gpg signature:
>
>    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.xz
>    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.bz2
>    https://fedorapeople.org/~acme/dwarves/dwarves-1.20.tar.sign
>
> Best Regards,
>
>  - Arnaldo
>

[...]
