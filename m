Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B956D4272BC
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 23:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJHVCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhJHVCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 17:02:40 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B5C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 14:00:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id k3so7195922qve.10
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIjHTOCEgqb8wSqWrjSt0lOQ0vIhUJOZcqMxdo7PNeo=;
        b=sHG/H/1rI8AkfJvdDTxynqx8jmqvorhf7RQhk4QYb2nt+l8qGwt5XDxnGkmxWlVIF6
         S4FunvMkHhF1FXhJ2xtBXta2/KLeq3UKZBrKdLFAWqZAGnJXKVQjBJmYA4dslcVLRZeq
         9GvMF4u7Pglccfb1EhH49UqLr2DBopCy2g9PSOHNwfP0lMrr3VdbKHEGHXOrxA8ycuH2
         TGbDftckP3A4cmcqdlkHBY6LT9DVCpTz1fJdBFMimz+NeB/HrZJ2p/h2psNacLNmRWKW
         d7lcw0yKjOe8cF4BfR15iTQCGQv0+HnqGjldtIEW36LXxwwZeJig6jlU2wRSOiroVEiO
         a6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIjHTOCEgqb8wSqWrjSt0lOQ0vIhUJOZcqMxdo7PNeo=;
        b=hoiCE/cHsPg8ijpILnliGlBGamC3S5t9sFp5SQpR2Gw7kRycK2ecPBfiMxS8YpU0Gf
         rFwTrIgSmiAadvW3Pv/9aRnnQQAVR0F/tkhU3EI7lO/wmAADjgxHYO9nWfJAORHf6idz
         2WsAs9pLhZeF7siyKskTDqdgb4I1karcqAlTC63PQK9678wL7UKJokWdoAT7qmR2IUsi
         DrKlEJ21g5aadnAFOm+hP5yFr82zoz228MNDcxKU/oj7I+6MSn++xCN+eRNxVUZi8OtY
         NsmxXUTTTeyRaJ/jMC69epdxAOtxGosGgY2UH/znqw3L5D5/xm/QhwpyF+uwnkVM+68V
         TjCw==
X-Gm-Message-State: AOAM531D9wN7ts6QPpmS58e1NPJAAZ9dTQMT8vo2q/boCI99nOzrwfLZ
        GiMnLJub3NpRxQagDqnj8Jmkst6STX2PJbDAlITf6w==
X-Google-Smtp-Source: ABdhPJyGrTfF6KD8u7VaX/yV35gAgmnI3kzyxPy+l4ugCdvILiI6/PaSNC+DrA2sMfIMPBAI4oN4ck75JaQno1acOsw=
X-Received: by 2002:a05:6214:1c8d:: with SMTP id ib13mr12056486qvb.10.1633726843970;
 Fri, 08 Oct 2021 14:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAPhsuW4UaidSZXj4-L9t4Ez9TjzoXR6yQvwn_7LC87hYmJbtFw@mail.gmail.com>
 <CAPhsuW5aAq9wA+PsunL0hGKiZc_BTLWjOPpOjYUyADc0+BZCAg@mail.gmail.com>
 <YV8OBHd4/gdZ6tu3@google.com> <CAA-VZPkSGJC0akTFrfUduAn0zd0sjq8+bMHkyOsuiH5zXo5TeA@mail.gmail.com>
 <CAPhsuW6AfFd7-xa1TVXJJfg02wqQ5QHHv2xttND+NnW93wkh-w@mail.gmail.com> <CAA-VZP=nSZmMjw8Fjk+ucz2X1hALhSKU3rdzSYN8KwEMegd0PA@mail.gmail.com>
In-Reply-To: <CAA-VZP=nSZmMjw8Fjk+ucz2X1hALhSKU3rdzSYN8KwEMegd0PA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 8 Oct 2021 14:00:33 -0700
Message-ID: <CAKH8qBtiB+VCySL59340u6DLH4f0KhH=4bKYxJ4-bVMhdajOCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     Song Liu <song@kernel.org>, YiFei Zhu <zhuyifei1999@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 1:49 PM YiFei Zhu <zhuyifei@google.com> wrote:
>
> On Thu, Oct 7, 2021 at 9:34 AM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Oct 7, 2021 at 9:23 AM YiFei Zhu <zhuyifei@google.com> wrote:
> > >
> > > Yeah it felt like we only needed one helper for the parameters and
> > > return values to be unambiguous. But if two better avoid confusion for
> > > users, we can do that.
> > >
> > > YiFei Zhu
> > >
> > [...]
> > > > > >
> > > > > > One question, if the program want to retrieve existing errno_val, and
> > > > > > set a different one, it needs to call the helper twice, right? I guess
> > > > > it
> > > > > > is possible to do that in one call with a "swap" logic. Would this work?
> > > >
> > > > > Actually, how about we split this into two helpers:bpf_set_errno() and
> > > > > bpf_get_errno(). This should avoid some confusion in long term.
> > > >
> > > > We've agreed on the single helper during bpf office hours (about 2 weeks
> > > > ago), but we can do two, I don't think it matters that much.
> >
> > I see. If we agreed on this syntax, I won't object.
> >
> > Thanks,
> > Song
>
> Shall I do the swap then? I don't think it has been discussed, and I
> don't see any downsides from doing so, but I don't really see a
> scenario in which someone would want to get and set at the same time
> either.

What kind of swap do you have in mind? IMO it's such a corner case
operation that doing 2 calls is fine. I'm assuming the majority of
use-cases are: (1) export a custom errno regardless of was was
previously done in the chain (2) see if there was already an errno set
in the chain and bail out early. I don't see any real need for some
efficient swapping and rewriting, but I might be missing something..
