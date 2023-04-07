Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE686DB027
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjDGQFn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbjDGQFk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 12:05:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF56B75D;
        Fri,  7 Apr 2023 09:05:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-502739add9dso2161947a12.0;
        Fri, 07 Apr 2023 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883537; x=1683475537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9YLbdCGW/jX2OamhOktfyVKjMyEWLO0+mLaQ5DYGf0=;
        b=pDeWUWwhC/Cs6/WTOT5WTu86MIGQWKhyGlLnzVCfGqy7HXuSIDZ+MChdBZqP/cxsXx
         F3W+6vQOR8/w/CUGhwzPjCne/n2IuAVf0x5dBMOVCB9GPzXOnFIpuHQqLX2AND5Yg0rY
         5T7I3Xq0wk2ASpmLXCJ3XpNSJGq3bx1anM3qf7baMKH3zPhUneeEzYaw77cyjkSNJsBc
         fyN5bVI5L9RTJtYqFxg9VclZItxWdM6nLUIsjOahI1+Zmqr/PdXyclQYhjaxBhQJtmeH
         ZBtQQqcWBukDH68xWBT7hOR7nMTXGlnzcvkyRu/8jYVJyiF96XoOeHH2+5sgxVS0G4pj
         KeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883537; x=1683475537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9YLbdCGW/jX2OamhOktfyVKjMyEWLO0+mLaQ5DYGf0=;
        b=vSsr4i8zeYyXbK9ZJYF/pntNb66IsPXwsi9mFFG3Pyn1zSOeh83uD5JQqKgxnsYYgi
         U5kven2vOgpHs1BWn25orPOBD9oYbPWYu8jOhp6yftuJOBbARe59kwyF4BgytbswOnEh
         hx8oYf1henzAC0kaKS8Ed7MRPX2qXVs5M6c/8cgmtBAGhVZ3KZTWTrGvddH7+oQpyR9g
         7RrHG5nPppe4XkaGppg0CVdRUckotly+010ec3XHD8lJgxA151tCfure0clrp+gOhZqG
         +uE9dYldKvzceTLblDTxqMBRx9NoKkJFdCbDeekVuATIWjR6CRB+X5E37uQjz8GieQWA
         UEsw==
X-Gm-Message-State: AAQBX9fU3VfX3LYzn5l6rDqgcHYc9JHeqUBJJLaSyaEQGOH2CcWrZwmW
        wEwlCQkHQGRq84iJ2Skoz+43/gnSjY+9HFxLapk=
X-Google-Smtp-Source: AKy350aNZXJPRzbYp8b0SVAvLP5TjVfhkoeoKmME3pofk7TOowEqKmPrxEPADDc9YKgpSVBVRIJjQZaWbeknVVfB3Es=
X-Received: by 2002:a50:d0d9:0:b0:4fb:f19:87f with SMTP id g25-20020a50d0d9000000b004fb0f19087fmr1596876edf.3.1680883537176;
 Fri, 07 Apr 2023 09:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
 <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
 <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbCEsucGRB+n5hTnPm-HssmB91HD4PFVRhdO=CZnJXfR6A@mail.gmail.com>
 <CAADnVQ+1VEBHTM5Rm-gx8-bg=tfv=4x+aONhF0bAmBFZG3W8Qg@mail.gmail.com>
 <CALOAHbAorooyteDjgs82TtujP4Fwo5hSkh-Z5QhxhV9p7_2mfw@mail.gmail.com>
 <CAADnVQKr5Y3z9f_Vv49DvRFcN+OF3JaFx_9NgBL58pz+TLq8ig@mail.gmail.com>
 <CALOAHbDdtj1Qd0h1jzXKN4R=_webEVW=sqYfhSFXXsYftyvnKw@mail.gmail.com>
 <CAEf4Bza_vM8HE5g+4ANW3NAAt8=+cn7Lw+DSkH42gimqzYxPdw@mail.gmail.com>
 <20230407014359.m6tff5ffemvrsyt3@dhcp-172-26-102-232.dhcp.thefacebook.com> <CAEf4BzaBd9y1O_u-ixr+OGiKarHfX95iHUSGtpSbGnrayg7=zQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaBd9y1O_u-ixr+OGiKarHfX95iHUSGtpSbGnrayg7=zQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 7 Apr 2023 09:05:25 -0700
Message-ID: <CAADnVQJ6LSxZ3=x9AnqiYObYaSnKQj1mWB0CzSn2c4PGRmSUSw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 7, 2023 at 8:59=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 6, 2023 at 6:44=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Apr 06, 2023 at 01:22:26PM -0700, Andrii Nakryiko wrote:
> > > On Wed, Apr 5, 2023 at 10:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Thu, Apr 6, 2023 at 12:24=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Apr 5, 2023 at 8:22=E2=80=AFPM Yafang Shao <laoar.shao@gm=
ail.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 6, 2023 at 11:06=E2=80=AFAM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 5, 2023 at 7:55=E2=80=AFPM Yafang Shao <laoar.sha=
o@gmail.com> wrote:
> > > > > > > >
> > > > > > > > It seems that I didn't describe the issue clearly.
> > > > > > > > The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS_A=
DMIN is
> > > > > > > > required to run bpftool,  so the bpftool running in the con=
tainer
> > > > > > > > can't get the ID of bpf objects or convert IDs to FDs.
> > > > > > > > Is there something that I missed ?
> > > > > > >
> > > > > > > Nothing. This is by design. bpftool needs sudo. That's all.
> > > > > > >
> > > > > >
> > > > > > Hmm, what I'm trying to do is make bpftool run without sudo.
> > > > >
> > > > > This is not a task that is worth solving.
> > > > >
> > > >
> > > > Then the container with CAP_BPF enabled can't even iterate its bpf =
progs ...
> > >
> > > I'll leave the BPF namespace discussion aside (I agree that it needs
> > > way more thought).
> > >
> > > I am a bit surprised that we require CAP_SYS_ADMIN for GET_NEXT_ID
> > > operations. GET_FD_BY_ID is definitely CAP_SYS_ADMIN, as they allow
> > > you to take over someone else's link and stuff like this. But just
> > > iterating IDs seems like a pretty innocent functionality, so maybe we
> > > should remove CAP_SYS_ADMIN for GET_NEXT_ID?
> > >
> > > By itself GET_NEXT_ID is relatively useless without capabilities, but
> > > we've been floating the idea of providing GET_INFO_BY_ID (not by FD)
> > > for a while now, and that seems useful in itself, as it would indeed
> > > help tools like bpftool to get *some* information even without
> > > privileges. Whether those GET_INFO_BY_ID operations should return sam=
e
> > > full bpf_{prog,map,link,btf}_info or some trimmed down version of the=
m
> > > would be up to discussion, but I think getting some info without
> > > creating an FD seems useful in itself.
> > >
> > > Would it be worth discussing and solving this separately from
> > > namespacing issues?
> >
> > Iteration of IDs itself is fine. The set of IDs is not security sensiti=
ve,
> > but GET_NEXT_BY_ID has to be carefully restricted.
> > It returns xlated, jited, BTF, line info, etc
> > and with all the restrictions it would need something like
> > CAP_SYS_PTRACE and CAP_PERFMON to be useful.
> > And with that we're not far from CAP_SYS_ADMIN.
> > Why bother then?
>
> You probably meant that GET_INFO_BY_ID should be carefully restricted?

yes.

> So yeah, that's what I said that this would have to be discussed
> further. I agree that returning func/line info, program dump, etc is
> probably a privileged part. But there is plenty of useful info besides
> that (e.g., prog name, insns cnt, run stats, etc) that would be useful
> for unpriv applications to monitor their own apps that they opened
> from BPF FS, or just some observability daemons.
>
> There is a lot of useful information in bpf_map_info and bpf_link_info
> that's way less privileged. I think bpf_link_info is good as is. Same
> for bpf_map_info.
>
> Either way, I'm not insisting, just something that seems pretty simple
> to add and useful in some scenarios. We can reuse existing code and
> types for GET_INFO_BY_FD and just zero-out (or prevent filling out)
> those privileged fields you mentioned. Anyway, something to put on the
> backburner, perhaps.

Sorry, but I only see negatives. It's an extra code in the kernel
that has to be carefully reviewed when initially submitted and
then every patch that touches get_info_by_id would have to go
through a microscope every time to avoid introducing a security issue.
And for what? So that CAP_BPF application can read prog name and run stats?
