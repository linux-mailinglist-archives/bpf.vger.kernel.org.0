Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103AB6E8207
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjDSTmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjDSTmy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 15:42:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD71FC3;
        Wed, 19 Apr 2023 12:42:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a35b0ec77so12188066b.3;
        Wed, 19 Apr 2023 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681933371; x=1684525371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeCHwVewXxRQz7uBVuRx5dFaTKKHPE5z4kRpEwoyUeA=;
        b=kk/1v5jVqjsWAepyn9pVnIwWRBdIiJdlkA2ya/l9RzSg/SWlDwo2y0uOmgKePRhHJ7
         OF47aho92ag3t6DazNniWrHQfers9nshefUWWYWB8GoJWIs4tV/4o0yFCINQEFTU5tdw
         H+gFuifSnduPsWDYbkrxJJu1vgF04JUveZ/+hL1VWR3tGM1FyHz7B4Oh1qNimAvmskG0
         w/23MNzNcKXZDu+mDCtZXlMhaxtNEX9qTTNb0NKihPAc+jcrOQdFx1pV5YtQoBBfsh3S
         uzmQ5jobvSpBtjmwlaGx1vcd36K1s4r0P3yhTuwTLD3dIHT24IXaILryCIpA/1GnZMOC
         423w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681933371; x=1684525371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeCHwVewXxRQz7uBVuRx5dFaTKKHPE5z4kRpEwoyUeA=;
        b=TE/qGDpJkKSKksMYbfXHq7XLPnMCAL9UBRYm8ouGjcb9BybfBmDAEVp3VJ4jHfTa4J
         foNpo5pAVUJT1xbm3JQgJhu/2KIq+68cEn1+lptwpCKGVdbXr2SzetX2qaRXISiYCsi3
         TPhcBXyOud1CGZl6WsVIhr6OWmhKnncfzBI42LDgWEapVzRqAoLSFDGgw+6USgf7DFu5
         YqaxPXkTwvTTPvbehPPZms2OoGrZN8pQXER8WWSss3g+5nc/ivTI7zWqSDcknT2uyyIm
         uEYiOTCzT4qTcIaWB51EFlhcHxW02ssBXomiUTvRKZ8qbz0doO50hGXUBtVi+BPb6xC9
         tA8w==
X-Gm-Message-State: AAQBX9fHSsmEupVrDfsmpwlSUG+RT+bvKk3gnpHFwoU0E2FeOdgbwg8i
        QXiUTsjMmobLVHDZY0uJTw+oTHarsj8gT8Cx618=
X-Google-Smtp-Source: AKy350ZM9nb3arhvy1ZwfCGMamb4jTRoFRMWEwYpqDknKBtTgCnjs+7cSjv3SBzbavMqzughupbESt1jJfUT2Wj8XxE=
X-Received: by 2002:aa7:c999:0:b0:506:77e5:fbb3 with SMTP id
 c25-20020aa7c999000000b0050677e5fbb3mr6647622edt.35.1681933371182; Wed, 19
 Apr 2023 12:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <87leiw11yz.fsf@toke.dk> <ZD/IcBvVxtFtOhUC@syu-laptop.lan>
In-Reply-To: <ZD/IcBvVxtFtOhUC@syu-laptop.lan>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Apr 2023 12:42:39 -0700
Message-ID: <CAEf4BzbxfvR4Ji1q4wJCFHOxQgFzHr8t7TMK1VJj9sJ+a0srVQ@mail.gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin@isovalent.com>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 19, 2023 at 3:55=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> Thanks for sharing! I though I'd expands on what you said to draw a clear=
er
> picture of the challenges.
>
> On Thu, Apr 13, 2023 at 01:00:20PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> > Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:
> >
> > > A side note: if we want all userspace visible libbpf to have a cohere=
nt
> > > version, perf needs to use the shared libbpf library as well (either
> > > autodetected or forced with LIBBPF_DYNAMIC=3D1 like Fedora[4]). But h=
aving to
> > > backport patches to kernel source to keep up with userspace package (=
libbpf)
> > > changes could be a pain.
>
> Here some more context for completeness. Kernel source changes are publis=
hed
> at a much slower pace than userspace. When an application in the kernel
> source (e.g. perf) depends on the userspace library, it's kind of like
> trying to catchup a car on a bike, which is doable, as evident by the
> plethora of userspace libraries perf already depends on. While I don't
> having experience maintaining perf, judging by tools/perf/Makefile.config
> that does not seem like an easy feat.
>
> For perf to use libbpf in kernel would mean that it's just depending on
> something that moves at the same pace.
>
> That said, maybe perf won't need additional backport to keep up with libb=
pf
> as long as we keep it within that same major version (and disable
> deprecation warning)? @Andrii
>
> Now that We've got pass libbpf 1.0 it seems like a good time to reconside=
r.

I'm not sure what the proposal is, but I'll delegate to Arnaldo.

>
> > So basically, this here is the reason we're building libbpf from the
> > kernel tree for the RHEL package: If we use the github version we'd nee=
d
> > to juggle two different versions of libbpf, one for the in-kernel-tree
> > users (perf as you mention, but also the BPF selftests), and one for th=
e
> > userspace packages. Also, having libbpf in the kernel tree means we can
> > just backport patches to it along with the BPF-related kernel patches
> > (we do quite extensive BPF backports for each RHEL version).
>
> > Finally, building from the kernel tree means we can use the existing
> > kernel-related procedures for any out of order hotfixes (since AFAIK no=
ne
> > of the github repositories have any concept of stable branches that
> > receive fixes).
>
> +1
>
> Got something similar in place as well and being able to stick with exist=
ing
> procedure is appealing.
>
> > YMMV of course, but figured I'd share our reasoning. To be clear,
> > building from the kernel tree is not without its own pain points (mostl=
y
> > related to how the build scripts are structured for our kernel builds).
> > We've discussed moving to the github version of libbpf multiple times,
> > but every time we've concluded that it would be more, not less, painful
> > than having the kernel tree be the single source of truth.
>
> We package maintainer are certainly quite hard to please :)
>
> Just having an individual package easy to work with is not enough, we wan=
t
> it to be easier for most packages before jumping on the bandwagon, which =
is
> why this email ended up talking about perf despite it started as a
> discussion on packaging libbpf and bpftool.
>
> I suppose the mileage depends on the build system & scripts in use and ho=
w
> much backporting is done; the more kernel backporting (along with more
> established processes in place), the more painful it'd be to move to the
> GitHub version. My gut feeling is that SLES do less backporting compared =
to
> RHEL when it comes to BPF, and that probably placed us closer to the midd=
le
> ground.

Even though libbpf source is developed in kernel repo, it's not tied
to specific kernel. So any kernel backports have no relevance to
libbpf itself. It's yet another reason to switch to Github mirror.
Github is merging libbpf-related fixes from both bpf and bpf-next
trees during sync, and is meant to always be the latest and best
version with all fixes included.

I won't claim anything for perf, maybe Arnaldo can clarify, but I
suspect that perf is also meant to be relatively independent from
specific kernel and work on wide variety of kernels.

As for stable branches. For libbpf, we don't have it because we didn't
need it yet. We did have bug fix patch releases that seem to be
working out fine, though.

>
> Thanks,
> Shung-Hsi
>
> > -Toke
> >
