Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB2498476
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243456AbiAXQPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 11:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiAXQPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 11:15:48 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504EDC06173B
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 08:15:48 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id u6so5679901iln.3
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FBsXtuTrwNpvi2Ah8SOnJG4wkkxubSuwr2HsR56uXp8=;
        b=XahfiBRrczQWFvxyUerT6nz7uWPExcydbIIMtn0KiVLw/jgopNMYDkhFHxkRN0ZChA
         DlfxLIMDPBR1xn8wdnXZheQ19GDKJupcsjqpbDa2WpUpUlmn6RL624MYX6kgAJ0Lk90d
         7YvfM4BWpnx/Uf9U8uuTdXw2IXVcSTnArwWx6Kh8jP4sniaXeXaVXGr7zUXAO6OJJx/w
         RGOxGCO+K3UZ5t8gy2CBTq4/s6+yJOgIooWbhfof9nLeWHjr7QyDS/Cy1AMP0jIXIyCc
         e+3VOnX9O1FxhHADHsdQZrt9tIHbKkys8NQOj9tH9fi9UTepcKMRgmBreyBROXWKOL8V
         3OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FBsXtuTrwNpvi2Ah8SOnJG4wkkxubSuwr2HsR56uXp8=;
        b=GW/bAFPGc7W3ttnN0Pgrhgnr/ALviP6V9hR3q8nOmpJ3aJkXhCrQNEVmVu9YGTIJZ/
         RcZdVQfmQ9OVYHsYD8MxKbAbSEHJDggRHKDDN9Xt6v7XaI8OPXhwNmAcJ/KnvbNTyB4s
         s3xA4DVcL6kbtxGnn3054BiiijgvNgLD9+Z3EYRYVtVMXcc/G1r/7EDPhUP52lluRqNr
         77QYxVgv+ofmashoMv8/xES/ySedxmjI/vujU6A5cIOP+DMopBh96qmZK18IYKVe1pC3
         UyMab4kKy56nGSTHivx4xrPeDFbwkKYNSDw04L7Lduc+t9LAHsdseBbw2SVllkCHd9fe
         Q43w==
X-Gm-Message-State: AOAM5337hvzlJq5dgPYzxVNc7V3L6DpQAwuSzl/heic5ltMLstI9b9GX
        39pYIwuRtqjJ5Dx9zeboj3t+VTr58BHyLe/1IQY=
X-Google-Smtp-Source: ABdhPJyWkV+HEEqs9rTZUjaZFrwhwoNemIdZgtCl1f+uCQe7s7VLeIfW33c8g4f68LlL+vfxtSUVZ02gfUDLOId0GVI=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr8881902iln.98.1643040947603;
 Mon, 24 Jan 2022 08:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20220120060529.1890907-1-andrii@kernel.org> <20220120060529.1890907-4-andrii@kernel.org>
 <87wniu7hss.fsf@toke.dk> <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk>
In-Reply-To: <87lez87rbm.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 08:15:36 -0800
Message-ID: <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map definitions
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 12:43 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii@kernel.org> writes:
> >>
> >> > Enact deprecation of legacy BPF map definition in SEC("maps") ([0]).=
 For
> >> > the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS f=
lag
> >> > for libbpf strict mode. If it is set, error out on any struct
> >> > bpf_map_def-based map definition. If not set, libbpf will print out
> >> > a warning for each legacy BPF map to raise awareness that it goes
> >> > away.
> >>
> >> We've touched upon this subject before, but I (still) don't think it's=
 a
> >> good idea to remove this support entirely: It makes it impossible to
> >> write a loader that can handle both new and old BPF objects.
> >>
> >> So discourage the use of the old map definitions, sure, but please don=
't
> >> make it completely impossible to load such objects.
> >
> > BTF-defined maps have been around for quite a long time now and only
> > have benefits on top of the bpf_map_def way. The source code
> > translation is also very straightforward. If someone didn't get around
> > to update their BPF program in 2 years, I don't think we can do much
> > about that.
> >
> > Maybe instead of trying to please everyone (especially those that
> > refuse to do anything to their BPF programs), let's work together to
> > nudge laggards to actually modernize their source code a little bit
> > and gain some benefits from that along the way?
>
> I'm completely fine with nudging people towards the newer features, and
> I think the compile-time deprecation warning when someone is using the
> old-style map definitions in their BPF programs is an excellent way to
> do that.
>
> I'm also fine with libbpf *by default* refusing to load programs that
> use the old-style map definitions, but if the code is removed completely
> it becomes impossible to write general-purpose loaders that can handle
> both old and new programs. The obvious example of such a loader is
> iproute2, the loader in xdp-tools is another.

This is because you want to deviate from underlying BPF loader's
behavior and feature set and dictate your own extended feature set in
xdp-tools/iproute2/etc. You can technically do that, but with a lot of
added complexity and headaches. But demanding libbpf to maintain
deprecated and discouraged features/APIs/practices for 10+ years and
accumulate all the internal cruft and maintenance burden isn't a great
solution either.

As of right now, recent 0.x libbpf versions do support "old and new
programs", so there is always that option.

>
> > It's the same thinking with stricter section names, and all the other
> > backwards incompatible changes that libbpf 1.0 will do.
>
> If the plan is to refuse entirely to load programs that use the older
> section names, then I obviously have the same objection to that idea :)

I understand, but I disagree about keeping them in libbpf
indefinitely. That's why we have a major version bump at which point
backwards compatibility isn't guaranteed. And we did a lot to make
this transition smoother (all the libbpf_set_strict_mode()
shenanigans) and prepare to it (it's been almost a year now (!), and
we still have few more months).

>
> > If you absolutely cannot afford to drop support for all the
> > to-be-removed things from libbpf, you'll have to stick to 0.x libbpf
> > version. I assume (it will be up to disto maintainers, I suppose)
> > you'll have that option.
>
> As in, you expect distributions to package up the old libbpf in a
> separate package? Really?

NixOS indicated that they are planning to do just that ([0]). Is it a
problem to keep packaging libbpf.so.0 and libbpf.so.1 together?

  [0] https://github.com/libbpf/libbpf/issues/440#issuecomment-1016084088

>
> But either way, that doesn't really help; it just makes it a choice
> between supporting new or old programs. Can't very well link to two
> versions of the same library...

Oh, you probably can with dynamic shared library loading, but yeah,
big PITA for sure. But again, v0.x libbpf supports "new programs" for
current definition of new, if you absolutely insist on supporting
deprecated BPF object file features. I'd be happy if you could instead
nudge your users to modernize their BPF game and prepare for libbpf
1.0 early, though. They can do that easily do to the extra work that
we did for libbpf 1.0 transition period.

>
> I really don't get why you're so insistent on removing that code either;
> it's not like it's code that has a lot of churn (by definition), nor is
> it very much code in the first place. But if it's a question of

There is enough and it is a maintenance burden. And will be forever if
we don't take this chance to shed it and move everyone to better
designed approaches (BTF-based maps), which, BTW, were around for
about 2 years now. Hardly a novelty.

> maintenance burden I'm happy to help maintain it; or we could find some
> other way of letting applications hook into the ELF object parsing so
> the code doesn't have to live inside libbpf proper if that's more to you
> liking?
>
> -Toke
>
