Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596C5435235
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhJTSBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhJTSBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 14:01:50 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D31C06174E
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 10:59:36 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id b9so2052587ybc.5
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Q/YY1s7DruprfF4vw13I5OQshTXjhD1Bx7ZbvI15O0=;
        b=fBhisVAnX/mHti/eu0fTQTprXA5zoEQ18gy9DUvWxNKPTI9kRW25Nim5n+SHFMdRRp
         ctumahbJRzjPgxAHaub27LdstIi2GJPEqhEpsiwqkQbXQZ7tOYws4GlO5dARDdvCmuyr
         /yRbSmoIsUUHSkqOmZDyJPLvt/VZiFaTaAqN0IMvrJqZdgDMSuPSrERFx089R+J3W+sA
         QXDkmzINgxXFFOZZJ/YRuyT/ksuGTZ9wzwun8AxBj0nvF1u0rmxzRndvTHHQENt+UVvW
         ZVAckt2WiPyMQ43SggJAc2XQE1yK9a9iyzRaSSQNM8uTA65udPm+mUlM6tFRsYzMkJLl
         mBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Q/YY1s7DruprfF4vw13I5OQshTXjhD1Bx7ZbvI15O0=;
        b=6CbMFWDRxtP6eRJl6Z+UN4Fd1wMeiC1Wh0/vpSeVVsCtpNHZYMq8Y5XoEl/cEE+3BI
         Q+E3bPu4gi0UZvOXtslfP2RnErbPL3xCkIXpSm+qAf9eUwSdTYNxaHhT7ZvlwvoWjxPv
         ES/KHHstz4G5Y5H2ZjP3D+HKB+4hllnGqgJn4mdWFLBqK8RbUThqjpnqCuB+s9WQz4V9
         /3FsGpPaNNs+fh5rthmoOZcKONRa8BjU388LzwpS9oIOEbWg8VlOHsPHsW/O24ODMszj
         5EhyySnm+yOhWj1x62iF/9OYn/VRIEdpOTVEc0KcIRJKSlqg8geb6NoJLOkMB/r36Ux3
         6IZw==
X-Gm-Message-State: AOAM530GnJWKULM/7WmEThcLVkmzRbab3Sb7c9w+qHimiekjD7saUm6V
        GWC2GpAhff2cCGAK779nWDaFduedLpc/YJYUXfQ=
X-Google-Smtp-Source: ABdhPJyxay9KYoXiz/YZUD+5V5bKJ9K+3vRlOgow5l9cukl/WRZ0PdaScfQg0i4FGsotY8V3MHU9tS9jwf08tl0/qKc=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr519993ybf.455.1634752775628;
 Wed, 20 Oct 2021 10:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-10-andrii@kernel.org>
 <87pmsfl8z0.fsf@toke.dk> <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
 <87r1cvjioa.fsf@toke.dk> <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com>
 <CAEf4BzYJj_R1V=OtQUmWGXiUh0Bd=kYXXFHOKwzafF=JRAaBfQ@mail.gmail.com> <CAKH8qBtiDLeJmp9GXNTCNBnWbGbu66o+CE7NGyeEKB8o1=9bgA@mail.gmail.com>
In-Reply-To: <CAKH8qBtiDLeJmp9GXNTCNBnWbGbu66o+CE7NGyeEKB8o1=9bgA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 10:59:24 -0700
Message-ID: <CAEf4BzYkrabS=7fpn01BesM06P9gNEreQLReQBhbbqhvW6dTzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     Stanislav Fomichev <sdf@google.com>
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

On Tue, Oct 12, 2021 at 8:29 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Mon, Oct 11, 2021 at 8:45 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 11:24 PM Alexei Starovoitov <ast@fb.com> wrote:
> > >
> > > On 10/8/21 2:44 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > > >
> > > > Hmm, so introduce a new 'map_name_long' field, and on query the ker=
nel
> > > > will fill in the old map_name with a truncated version, and put the=
 full
> > > > name in the new field? Yeah, I guess that would work too!
> > >
> > > Let's start storing full map names in BTF instead.
> > > Like we do already for progs.
> > > Some tools already fetch full prog names this way.
> >
> > We do have those names in BTF. Each map has either corresponding VAR
> > or DATASEC. The problem is that we don't know which.
> >
> > Are you proposing to add some extra "btf_def_type_id" field to specify
> > BTF type ID of what "defines" the map (VAR or DATASEC)? That would
> > work. Would still require UAPI and kernel changes, of course.
> >
> > The reason Toke and others were asking to preserve that object name
> > prefix for .rodata/.data maps was different though, and won't be
> > addressed by the above. Even if you know the BTF VAR/DATASEC, you
> > don't know the "object name" associated with the map. And the kernel
> > doesn't know because it's purely libbpf's abstraction. And sometimes
> > that abstraction doesn't make sense (e.g., if we create a map that's
> > pinned and reused from multiple BPF apps/objects).
>
> [..]
>
> > We do have BPF metadata that Stanislav added a while ago, so maybe we
> > should just punt that problem to that? I'd love to have clean
> > ".rodata" and ".data" names, of course.
>
> Are you suggesting we add some option to associate the metadata with
> the maps (might be an option)? IIRC, the metadata can only be
> associated with the progs right now.

Well, maps have associated BTF fd, when they are created, no? So you
can find all the same metadata for the map, no?
