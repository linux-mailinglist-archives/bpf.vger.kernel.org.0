Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5816429C0B
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 05:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhJLDrh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 23:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhJLDrg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 23:47:36 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEBBC061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:45:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id u32so43576353ybd.9
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CrhSUOnnTDF7TwW33Sh1t+RcIZMjYgE7WtmPKBO4J/k=;
        b=Q63V9k94RFy8ZB9FZCxE7h1lbxElXrIAskoAzaovGvLyigxrpBB/NMDto2PSiVESDK
         03fyefUPCrtsl9kt+9K3RMBVRhXv0YGoD5d/L6KlzL4jITbe0z4STZDJQxVxin1wuCG7
         rcZzVGz1p91YDIQ8FnwdJ+i22mv3RenlE2eyik+48vMKzRlWWLF5CQcvfno6lKGXDbDK
         bE2VFSkNUJqNVA0TpGQgQsOZUt7kApTuWQj8DDwI4rDLmOTwg7wCmT3tnvDPuIz5k95T
         tmB7QncegUTjGruDkIwjMzSGWo3kOmRTuV7iXzaCRnEkzWZSkGS10r171UyT6Gm+BBpO
         HN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CrhSUOnnTDF7TwW33Sh1t+RcIZMjYgE7WtmPKBO4J/k=;
        b=eXvqBh3kPwmHO7dsOmTFhwaJnb9wG7RMZqD6lRWpETEFDUL7vj/YfV+WP0EhQBh5v5
         5U/TJXBlVZpwgacKmdI1XtS+sNQICqG90uPlcVDTYLdCA72gfA9Ieb8XMxt/TL8f/miO
         i1C52Mcn9F540jZuArz0tXUleeSZJ1WaeSwnATaMyBQvn38YLnieKZwwnBiEvjKod1SB
         ONCtYBRn9I+JqNqOyO59/fKKjU1HY9ZA8RkQ0owVrbTEw+rBruiaBssoG628HhbMtUCE
         5KHXGWy1nX9xDYn48U6AYV2YnCvmufjpTgEG1BD8vrVb7QuU5AlO381yhTSsQPwUhzZW
         3NOQ==
X-Gm-Message-State: AOAM531nlgrW/xCNVKU+eRSjis5kpFD6UNQhMdHbaAb9fGCILgOCHN+I
        noQJi1ROR8sqU5ooyeiaqyUJWamexped/RaWsHg=
X-Google-Smtp-Source: ABdhPJzfompTdzgDL+LEZ51CqkKKDLy66BmJ7MZLmFNaE65d4yGn5soGHNT6VxoBpgIi/9tD7Bz2BDG8Fm5HnzTn7wA=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr26364519ybk.2.1634010334787;
 Mon, 11 Oct 2021 20:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-10-andrii@kernel.org>
 <87pmsfl8z0.fsf@toke.dk> <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
 <87r1cvjioa.fsf@toke.dk> <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com>
In-Reply-To: <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Oct 2021 05:45:23 +0200
Message-ID: <CAEf4BzYJj_R1V=OtQUmWGXiUh0Bd=kYXXFHOKwzafF=JRAaBfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     Alexei Starovoitov <ast@fb.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 11:24 PM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 10/8/21 2:44 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >
> > Hmm, so introduce a new 'map_name_long' field, and on query the kernel
> > will fill in the old map_name with a truncated version, and put the ful=
l
> > name in the new field? Yeah, I guess that would work too!
>
> Let's start storing full map names in BTF instead.
> Like we do already for progs.
> Some tools already fetch full prog names this way.

We do have those names in BTF. Each map has either corresponding VAR
or DATASEC. The problem is that we don't know which.

Are you proposing to add some extra "btf_def_type_id" field to specify
BTF type ID of what "defines" the map (VAR or DATASEC)? That would
work. Would still require UAPI and kernel changes, of course.

The reason Toke and others were asking to preserve that object name
prefix for .rodata/.data maps was different though, and won't be
addressed by the above. Even if you know the BTF VAR/DATASEC, you
don't know the "object name" associated with the map. And the kernel
doesn't know because it's purely libbpf's abstraction. And sometimes
that abstraction doesn't make sense (e.g., if we create a map that's
pinned and reused from multiple BPF apps/objects).

We do have BPF metadata that Stanislav added a while ago, so maybe we
should just punt that problem to that? I'd love to have clean
".rodata" and ".data" names, of course.
