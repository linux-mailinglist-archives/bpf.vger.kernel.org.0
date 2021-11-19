Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402A5457581
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 18:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhKSRei (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 12:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbhKSReh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 12:34:37 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB31C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 09:31:36 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e136so30293637ybc.4
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 09:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vz1/FORRvf0OZAYDcEItLanvk+PIgIStjiOYFqMXhxc=;
        b=AFkz38KkjwfhlL3IBsLSpSBX/FdsDy1/ctNu/3jKqqQvf/mhQK9ljL7o49jQIixERb
         gGB1leGkdRvGUxa6FB2zJYIt0/ijIp79Jn5cLtQ4/00Nt9WCRzF1B4Wor0AoUIQS0+a9
         AhDeQkwtDDnyX2GL7zl2OX34MxXiP+4x5i8KTdC0qenAw++NSAR2Ny23ZBWgvn5uHlo7
         lfEk3VwY0LWr20r5AUEnzTc3wX/HtXg7NChguJ68doAlpfRCZ7Bv2CgfXFMgMC6PjAp7
         btaHWalvQkPJ7j/q7xzu6uVpnrJ3TVelZzmZGtCDApOBxt9MmLVBiFmH2uPx3MCTVNMn
         lQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vz1/FORRvf0OZAYDcEItLanvk+PIgIStjiOYFqMXhxc=;
        b=1xd81wX5hG8pPy/TEBnq/hYvEwTCpDLpMiFHa16l2bpe5pFCOfv1eEEyaPI0tbuuSt
         5n2HdFFlwg7w84+S5F6b0eVDoHngchGvpb5QqZ0Eor2QsvYSnc92qVkj2GYNBa6djFq+
         +4ekVLfy4hdCDa4u/wGyfPRmI++2ooklcCZu0CVD6bSyR+eocMIZ5aLIROv/ja7cVrnl
         nwUk83o9FCIsog0/Swll4oj19Aa0aXR3C1T1eaPUPy41pBrsqwHuMNyg1656Gni1DXtu
         RGwPBxUXLIO/QjGmImclRU4cwseiWijUX0F80Nv+BypVnxbHHlrFJzMHqKcP4xpMx0fG
         l2mQ==
X-Gm-Message-State: AOAM530xVn3lKcgybsk2J/E3ELd576zm9hKPtm97MV5sQ5xKHxgRApXo
        CHLCF79D4/Z35JCWVOfiKERlUlzFKdNTrs5j/bPej6EMeqc=
X-Google-Smtp-Source: ABdhPJwYwVOAZ7JLVgFcLEkgmh1TGFCVQFBa36jOobrhWwBx8oCi3lMGYScLyVbfrw3fu7j/xs6EFJQxkjfT2CdE1K4=
X-Received: by 2002:a25:d16:: with SMTP id 22mr38613057ybn.51.1637343095310;
 Fri, 19 Nov 2021 09:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <20211112050230.85640-3-alexei.starovoitov@gmail.com> <CAEf4BzYjvg+iqs8wB9bMYWJ-BAH6s4iM89vvB9ZywjHKQBJg8g@mail.gmail.com>
 <20211119031716.47gpmk7wahpfuixw@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211119031716.47gpmk7wahpfuixw@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Nov 2021 09:31:24 -0800
Message-ID: <CAEf4BzZ5d0rv_p7o6QXxevU9Os8mvBCRHiX_8ykWik5Yv3aTqA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/12] bpf: Rename btf_member accessors.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 7:17 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 16, 2021 at 04:38:18PM -0800, Andrii Nakryiko wrote:
> > >
> > > -static inline u32 btf_member_bit_offset(const struct btf_type *struct_type,
> > > -                                       const struct btf_member *member)
> > > +static inline u32 __btf_member_bit_offset(const struct btf_type *struct_type,
> > > +                                         const struct btf_member *member)
> >
> > a bit surprised you didn't choose to just remove them, given you had
> > to touch all 24 places in the kernel that call this helper
> > > -                       if (btf_member_bitfield_size(t, member)) {
> > > +                       if (__btf_member_bitfield_size(t, member)) {
> >
> > like in this case it would be btf_member_bitfield_size(t, j)
>
> In this and few other cases it's indeed possible, but not in net/ipv4/bpf_tcp_ca.c
> It has two callbacks:
> struct bpf_struct_ops {
>         const struct bpf_verifier_ops *verifier_ops;
>         int (*init)(struct btf *btf);
>         int (*check_member)(const struct btf_type *t,
>                             const struct btf_member *member);
>         int (*init_member)(const struct btf_type *t,
>                            const struct btf_member *member,
> so they cannot be changed without massive refactoring.

member_idx = member - btf_type_member(t);

But as I said, not a big deal.

> Also member pointer vs index is arguably a better api.

Not so sure about that, as it allows accidentally passing a completely
irrelevant member pointer from a different type. With member_idx you
can do some sanity checking and make sure you are not accessing
members out of bounds. But I don't really care, just wanted to point
out the possibility of eliminating a somewhat redundant helper.

> I'm not sure compiler can optimize index into pointer in case like below
> and won't introduce redundant loads.
>
> > >         for_each_member(i, t, member) {
> > > -               moff = btf_member_bit_offset(t, member) / 8;
> > > +               moff = __btf_member_bit_offset(t, member) / 8;
> >
> > same here, seema like in all the cases we already have member_idx (i
> > in this case)
