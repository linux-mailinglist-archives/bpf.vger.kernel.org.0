Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DBF2FF9F0
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 02:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbhAVB0j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 20:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbhAVB0c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 20:26:32 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E88C061788;
        Thu, 21 Jan 2021 17:25:50 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e7so4688168ljg.10;
        Thu, 21 Jan 2021 17:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEjhjuogvu/oylVL9cSg3hTFtB4Bh5V+iLlXqCyVeqE=;
        b=qQv+hL6dqGs4dUJd01UjMSGpyPGmmIeyarfU4R87AmyUsW43wA3PnyHHU58mtfYs1b
         UfIsf/i12h5N+Kxg5xz/XUuogsiLIOwiBapMA+wqRzw5ET/oD0LEqmwiFFcfHqvLkPku
         UIiWURBoQzz8LXZa+wjCwUqOFE5goqIDpCrSrHznXj9RO96JabJap4q6RJWHI0V5o0zU
         O4nE8L5BiM7L565BGGEgAT1y9ocTAW7DCUZrNLyokP2/f9HQPiYIzbty2AhSr+DOU75f
         Q5bvzpdDay7QwvverjHjJX5gsND5/locMt5iswQV2Uh55ie7PKNLfrR5CREoZdMTRaQB
         Jfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEjhjuogvu/oylVL9cSg3hTFtB4Bh5V+iLlXqCyVeqE=;
        b=ICB9V+u/vm9U6tBQJkR8K413lFCy2QH2DcEmM6aP6jztP9HWPBXc+reaeYUvJuOAHs
         8pp4hwCWDQunIshMKa84xTQTbCJ4Oby1+aRhDI3nIKygGT8okq5kXjXRdpfn4p3WP8t0
         t7xwy0mEqMHfQ73MRUH5050PiPXX90BttcjajtnKTWqubYNbfG+TK+wr9c/FWTf1Svqa
         c0CGVo+Xg0sGvwXiiLARIcJPXsF0FKF4UfxtMeU4n/bF7mdQLQDp7rCsxddai0+JDgFc
         mOwAYZCRfEIelK3ql7io+03rI9GscVvK+I9LtX9Fm2c5ryag6kbhi2/cAxmO7jahNFI+
         RfRg==
X-Gm-Message-State: AOAM531nDK/OcUaJ72WFYyQWl/68JUayFjpjKhYOcbWnZ0ytltjMj6dk
        /ENn2gkYF8yQtlvG8Q7u80WeQrc7US2wv9q9NmM=
X-Google-Smtp-Source: ABdhPJx8Ul/cTkWEuSiC4n9ry0+j8iT5+wd6gC6KOJOgET1PQx5eYoq9nW504nHNEn5C7VXTQxMWOoGMZVANvBEO1cU=
X-Received: by 2002:a2e:86d4:: with SMTP id n20mr1005881ljj.486.1611278748991;
 Thu, 21 Jan 2021 17:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20210120133946.2107897-1-jackmanb@google.com> <20210121115357.31f44f34@lwn.net>
In-Reply-To: <20210121115357.31f44f34@lwn.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Jan 2021 17:25:37 -0800
Message-ID: <CAADnVQJNB9++eWA-uPdOzviV-UXEdC-tWfsUy3DRjV2ULs3LYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] BPF docs fixups
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 21, 2021 at 10:54 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Wed, 20 Jan 2021 13:39:44 +0000
> Brendan Jackman <jackmanb@google.com> wrote:
>
> > Difference from v2->v3 [1]:
> >
> >  * Just fixed a commite message, rebased, and added Lukas' review tag - thanks
> >    Lukas!
> >
> > Difference from v1->v2 [1]:
> >
> >  * Split into 2 patches
> >
> >  * Avoided unnecessary ': ::' in .rst source
> >
> >  * Tweaked wording of the -mcpu=v3 bit a little more
> >
> > [1] Previous versions:
> >     v1: https://lore.kernel.org/bpf/CA+i-1C1LVKjfQLBYk6siiqhxfy0jCR7UBcAmJ4jCED0A9aWsxA@mail.gmail.com/T/#t
> >     v2: https://lore.kernel.org/bpf/20210118155735.532663-1-jackmanb@google.com/T/#t
> >
> > Brendan Jackman (2):
> >   docs: bpf: Fixup atomics markup
> >   docs: bpf: Clarify -mcpu=v3 requirement for atomic ops
> >
> >  Documentation/networking/filter.rst | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
>
> I'm assuming these will go up through the BPF/networking trees; please let
> me know if I should pick them up instead.

I sent an email yesterday indicating that the set was applied to bpf-next.
There is no other tree it can be applied to without conflicts.
Looks like gmail is struggling again.
