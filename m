Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9C45CD20
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 20:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245335AbhKXTYI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 14:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbhKXTYF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 14:24:05 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2630C061574
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:20:54 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y68so10303588ybe.1
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxf2ZPFPHQHRKPZ4qcQlaNPUcWG+kgqDb3gbAFCh1yM=;
        b=D/FY4wYL/dggjRgFtq597xNWq3R+rfD+t//0o54/ik2s2rB0CdsEJpXjI3PbDdp21p
         CSTtK6ILppIkuh6F2rr6n3DSEcuRIhl1zUfMVDzujD+m7fMWsUTejpvuzDTr76Y8I1KX
         n6ExnpdT0MfA1PSnfoexXEtc1eUN1xUiMJMGXp+K8nmXatsyJfhe7attPKwvnh8hW9uj
         Stz8fkQc9hrwYXWz5G0ELdTQhUV3aPufwyBCaxA2yaWR10WeS02GdO/cWLBZptOviU0J
         pKUvbncW0eXY5uMcl9FffkDVUBSUrMCJJuwpIg4Vq3kbqpTEtsNj5btpRccMUl1NqcTP
         opDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxf2ZPFPHQHRKPZ4qcQlaNPUcWG+kgqDb3gbAFCh1yM=;
        b=OoPlSJOMNA97teMhAMyQ3CIZn0MIIupLdAESKaa0wqI59WDOqPc+zjHhdtzsunU3rO
         874DXs5Dqj0mNdK/8e/131ZvKUfM61YJe2CHi6pKOb7IHnOXKOXl/Zo7fMWQTIVe+otz
         xU9l2Yv1CmSmuzGZ+mmK5uK7gYsoLxVYrHyJx4Q0wGFdxKEzMwOtaFvyguZ/lkKhzYVr
         xjhfcjzjMqmMr8VOeIkQNGSdfRwl1uICvzTQm/aHhiKetCvpeYnsvJstEsE+Ylb3OXwD
         cFoeKmOb4Q54JvAoFGUyatv3Xm8LxqaK7cfXYTQ08gpbqUUls8zDu4KdhfpCQGHgcehx
         P7Mg==
X-Gm-Message-State: AOAM530IaeuI35l+FRVxSEr9YGyIfUO7GLtyeIul22oMeQlpQ/zVXIzo
        bsFj9bMOinW+n+jgobTACIc05MIZDRhAiwG0vck=
X-Google-Smtp-Source: ABdhPJy4RksVI95P2FgqqQ4oe5EkzaorT/rAVh/n70E6QnNXAxdKc72jeFCttfRloDXNmX5tYTVSbNbFrVBhmj+C5oE=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr19740549ybe.455.1637781653954;
 Wed, 24 Nov 2021 11:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20211117194114.347675-1-andrii@kernel.org> <CAEf4Bza2NSV8MBb0jSokmUcrzy0SpLvY2uqu4mG9ObxnT-jQLw@mail.gmail.com>
 <YZZiwnWReYnthtzH@krava> <CAEf4BzZ9E3Yg2jjCvzdfDN2dCX-hJBqt1cHFvVNzujrx7KWdgg@mail.gmail.com>
 <YZ4kUzG26392CvWi@krava> <YZ5UFmJlb7rf4mKI@krava>
In-Reply-To: <YZ5UFmJlb7rf4mKI@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Nov 2021 11:20:42 -0800
Message-ID: <CAEf4BzZ5DXdKAVD15r4tViH8neaKV4Pq82P6bWKRT2SAt7Jd9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with
 duplicated structs
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 7:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Nov 24, 2021 at 12:39:00PM +0100, Jiri Olsa wrote:
> > On Thu, Nov 18, 2021 at 02:49:35PM -0800, Andrii Nakryiko wrote:
> > > On Thu, Nov 18, 2021 at 6:27 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Wed, Nov 17, 2021 at 11:42:58AM -0800, Andrii Nakryiko wrote:
> > > > > On Wed, Nov 17, 2021 at 11:41 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > > >
> > > > > > According to [0], compilers sometimes might produce duplicate DWARF
> > > > > > definitions for exactly the same struct/union within the same
> > > > > > compilation unit (CU). We've had similar issues with identical arrays
> > > > > > and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
> > > > > > Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
> > > > > > same for struct/union by ensuring that two structs/unions are exactly
> > > > > > the same, down to the integer values of field referenced type IDs.
> > > > >
> > > > > Jiri, can you please try this in your setup and see if that handles
> > > > > all situations or there are more complicated ones still. We'll need a
> > > > > test for more complicated ones in that case :( Thanks.
> > > >
> > > > it seems to help largely, but I still see few modules (67 out of 780)
> > > > that keep 'struct module' for some reason.. their struct module looks
> > > > completely the same as is in vmlinux
> > >
> > > Curious, what's the size of all the module BTFs now?
> >
> > sorry for delay, I was waiting for s390x server
> >
> > so with 'current' fedora kernel rawhide I'm getting slightly different
> > total size number than before, so something has changed after the merge
> > window..
> >
> > however the increase with BTF enabled in modules is now from 16M to 18M,
> > so the BTF data adds just about 2M, which I think we can live with
> >

16MB for vmlinux BTF is quite a lot. Is it a allmodyesconfig or something?

> > > And yes, please
> > > try to narrow down what is causing the bloat this time. I think this
> >
> > I'm on it
>
> I'm seeing vmlinux BTF having just FWD record for sctp_mib struct,
> while the kernel module has the full definition
>
> kernel:
>
>         [2798] STRUCT 'netns_sctp' size=296 vlen=46
>                 'sctp_statistics' type_id=2800 bits_offset=0
>
>         [2799] FWD 'sctp_mib' fwd_kind=struct
>         [2800] PTR '(anon)' type_id=2799
>
>
> module before dedup:
>
>         [78928] STRUCT 'netns_sctp' size=296 vlen=46
>                 'sctp_statistics' type_id=78930 bits_offset=0
>
>         [78929] STRUCT 'sctp_mib' size=272 vlen=1
>                 'mibs' type_id=80518 bits_offset=0
>         [78930] PTR '(anon)' type_id=78929
>
>
> this field is referenced from within 'struct module' so it won't
> match its kernel version and as a result extra 'struct module'
> stays in the module's BTF
>

Yeah, not much we could do about that short of just blindly matching
FWD to STRUCT/UNION/ENUM by name, which sounds bad to me, I avoided
doing that in BTF dedup algorithm. We only resolve FWD to
STRUCT/UNION/ENUM when we have some containing struct with a field
that points to FWD and (in another instance of the containing struct)
to STRUCT/UNION/ENUM. That way we have sort of a proof that we are
resolving the right FWD. While in this case it would be a blind guess
based on name alone.

> I'll need to check debuginfo/pahole if that FWD is correct, but
> I guess it's normal that some structs might end up unwinded only
> in modules and not necessarily in vmlinux

It can happen, yes. If that's a very common case, ideally we should
make sure that modules keep FWD or that vmlinux BTF does have a full
struct instead of FWD.


>
> jirka
>
