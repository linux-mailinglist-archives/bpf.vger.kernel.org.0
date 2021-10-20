Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50AA435261
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 20:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJTSLq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhJTSLp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 14:11:45 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066CEC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:09:31 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g14so2618647qvb.0
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qx9MNDLFl2CLYg3YdYhFkrY5J8l1IltFAth2Q7AZH7A=;
        b=mFKxycmmDrJOttP0QwEhHcqSn0eGRW91n08I1mSpmfxxxC6eQd4cl9nrcWqrEa7XNa
         EDnqzdru3Vp25feRx4gqjXoXCQWHELVyQujzxGkCVBKVYmlnQEVgALPaJ3p+HWtZfk1c
         NfxwZvc8KTMxQ4jldQQjQg2MKAyn7t0sIvxwBOXaBJxifLPeHty+IIGFwamMi4GSL9JU
         DTIoJfkh3yX0EKYU6CR98sody8nvpd/4azuFlPulJ5uyIleKMSFanp7j786AM3JucTYZ
         sU/WYsu55dTGyq7v1hqLU4DoAzDWQX806Y3dU7MslIlj5cD2YHIW4y248T/Z9rnF3yAM
         jtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qx9MNDLFl2CLYg3YdYhFkrY5J8l1IltFAth2Q7AZH7A=;
        b=Dli6U3qihehsEEJNJb3QvhJ+0EG+MMoXNar5hyRSkwFhzwPhr/+GUYkZrLnsZppu2n
         li6wnMGMDdRtW+tgCweefEEL5QB/8V7ElWYayOtZcqHO/j5X3kFwBtWFLv57IiVNq5cg
         GqATM/C9f1cGE1fOGZmjwwYuQmaumeyiAIbpg+pGkYiW8BvBVnomjD/VYTdPjfLBSohn
         keVU2xqZu3O7c/FGZpQtYxRnWKi8jD3XUX/6RXSONoQ0JI9SkLQ6TWCDx3ZMfN1QhhUN
         x70Yckh7/eSbBIo3kvVv3rE6y3ihd+8gp/4vZR/t+aGEcO6gtxnCQRvzufawg2LmLcj/
         /36g==
X-Gm-Message-State: AOAM531BmUc89UdXKFW9DGjh7MLU+3CdzAXQ545gvxf1D5g3mZUBjMDy
        GBZ3f97PSAgrc7OgEoRy53dPX6nv9oTpfwNAdAHHdQ==
X-Google-Smtp-Source: ABdhPJyHb4muCdCWxMB5B2qiuk9xz/qb0i8WqXJcxDPB9BzgCBGkpeJXzgTvnNmLuWQi3puN1gN6DWH0F0wwbEHgByI=
X-Received: by 2002:a05:6214:154d:: with SMTP id t13mr248458qvw.40.1634753370046;
 Wed, 20 Oct 2021 11:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-10-andrii@kernel.org>
 <87pmsfl8z0.fsf@toke.dk> <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
 <87r1cvjioa.fsf@toke.dk> <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com>
 <CAEf4BzYJj_R1V=OtQUmWGXiUh0Bd=kYXXFHOKwzafF=JRAaBfQ@mail.gmail.com>
 <CAKH8qBtiDLeJmp9GXNTCNBnWbGbu66o+CE7NGyeEKB8o1=9bgA@mail.gmail.com> <CAEf4BzYkrabS=7fpn01BesM06P9gNEreQLReQBhbbqhvW6dTzQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYkrabS=7fpn01BesM06P9gNEreQLReQBhbbqhvW6dTzQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 20 Oct 2021 11:09:19 -0700
Message-ID: <CAKH8qBsazaRM+ACSJc69Tt9RXR95twtG-T+Sn8LmV9sKWkhu1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 10:59 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 12, 2021 at 8:29 AM Stanislav Fomichev <sdf@google.com> wrote=
:
> >
> > On Mon, Oct 11, 2021 at 8:45 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 11:24 PM Alexei Starovoitov <ast@fb.com> wrot=
e:
> > > >
> > > > On 10/8/21 2:44 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > > > >
> > > > > Hmm, so introduce a new 'map_name_long' field, and on query the k=
ernel
> > > > > will fill in the old map_name with a truncated version, and put t=
he full
> > > > > name in the new field? Yeah, I guess that would work too!
> > > >
> > > > Let's start storing full map names in BTF instead.
> > > > Like we do already for progs.
> > > > Some tools already fetch full prog names this way.
> > >
> > > We do have those names in BTF. Each map has either corresponding VAR
> > > or DATASEC. The problem is that we don't know which.
> > >
> > > Are you proposing to add some extra "btf_def_type_id" field to specif=
y
> > > BTF type ID of what "defines" the map (VAR or DATASEC)? That would
> > > work. Would still require UAPI and kernel changes, of course.
> > >
> > > The reason Toke and others were asking to preserve that object name
> > > prefix for .rodata/.data maps was different though, and won't be
> > > addressed by the above. Even if you know the BTF VAR/DATASEC, you
> > > don't know the "object name" associated with the map. And the kernel
> > > doesn't know because it's purely libbpf's abstraction. And sometimes
> > > that abstraction doesn't make sense (e.g., if we create a map that's
> > > pinned and reused from multiple BPF apps/objects).
> >
> > [..]
> >
> > > We do have BPF metadata that Stanislav added a while ago, so maybe we
> > > should just punt that problem to that? I'd love to have clean
> > > ".rodata" and ".data" names, of course.
> >
> > Are you suggesting we add some option to associate the metadata with
> > the maps (might be an option)? IIRC, the metadata can only be
> > associated with the progs right now.
>
> Well, maps have associated BTF fd, when they are created, no? So you
> can find all the same metadata for the map, no?

I guess that's true, we can store this metadata in the map itself
using something like existing bpf_metadata_ prefix.
