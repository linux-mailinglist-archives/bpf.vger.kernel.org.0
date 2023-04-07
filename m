Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEFB6DAFB3
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjDGPdL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjDGPdD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 11:33:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AD68A42;
        Fri,  7 Apr 2023 08:33:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g18so9160272ejx.7;
        Fri, 07 Apr 2023 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680881581; x=1683473581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Std2wvPlWvxGTdco3iJX8Byg7jtyxi5GlWE5krxkAA=;
        b=MlovedopbIwt8TyePQaSHFzMH4ZAI2xyf2btgeqoDeBH0mc6k6VgtY6NS2n22R/NL4
         N10I3HV85IDz56hnP3kgPzsWBwjinbgWorQr4BrisO4lXCs1xlPJjH2OWidvwQtvg9T5
         76lNpoXUKUhfS7X3f4F6o03cA7yRgaTIoNcc1rRQNRTsyX2W40S4eZ3zGaFCFWbsZsF4
         CdTf0y1DIWOXoIrGKPYJIQOeui9JhPVZ/nn7/8wj7NEHuyOGL5kft4+RBb5ybx6sGpyk
         Zho0fj8ITBTpZNZMFR536i2+Z26S2Av1I8GlND1q6hNanyWJ4zJnIssrqiMo8OLsC9u+
         gzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680881581; x=1683473581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Std2wvPlWvxGTdco3iJX8Byg7jtyxi5GlWE5krxkAA=;
        b=lEzXFPpC/SqCADMhhVYcR5PqFEq3nGkcXEsOYijv1hNu76wmo4VEfXqv1W/iMJ+Fsp
         xFTEAz+1jcncReAfQMCWiQddQvDdsnsue7MiOnW0ZHrzmEw5Dtzt6kb+MEvaDv4lxVqP
         kpKk+zVtvC0hyfxQodJH9s6dVP7cuSMLISkbMdpsUyhDH+7MwGKU0xy1THAGwNibAo6K
         a8VdHwuvPkLgLlARpu8Kijy0miK4rTM0GtfcAtfOIM5LhK0KMLfFrThxoMhITzP8acDs
         2lWysuJ/xrVWFE7RKqo5bODCmImf4DHa/MoCGm+rCaLzkZJFW+nG668gE1u3yls9DlTD
         HI1A==
X-Gm-Message-State: AAQBX9etEVRZCgecA7Hs4R1oDe1VZyOfc42KSRVRlpzxYbIuXQD3PGYf
        nw53/tgT1x7T5JSJ7PcJxcbEbsL4wFgyCFs0l1k=
X-Google-Smtp-Source: AKy350aeGRPB27ciRt2aCwOUu83S0wtXdovlMXKxnzcZC3DHzIyn4cS0Bv0HTQt8xrxHZSeIRzBkxmeyT4FwFn250dk=
X-Received: by 2002:a17:907:9626:b0:92a:581:ac49 with SMTP id
 gb38-20020a170907962600b0092a0581ac49mr1179419ejc.3.1680881580894; Fri, 07
 Apr 2023 08:33:00 -0700 (PDT)
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
 <20230407014359.m6tff5ffemvrsyt3@dhcp-172-26-102-232.dhcp.thefacebook.com> <CALOAHbCT455UyFqg3K7dtr4vOh6kcC8VryVaJYB31UBS3x=9cA@mail.gmail.com>
In-Reply-To: <CALOAHbCT455UyFqg3K7dtr4vOh6kcC8VryVaJYB31UBS3x=9cA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 7 Apr 2023 08:32:49 -0700
Message-ID: <CAADnVQJGxR=QT4tVKHbdhRsf5507NWcSmnu7R1H_1dKD7vpzBg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <song@kernel.org>,
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

On Thu, Apr 6, 2023 at 9:34=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Fri, Apr 7, 2023 at 9:44=E2=80=AFAM Alexei Starovoitov
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
> Not sure if I get your point clearly.  I think the reason we introduce
> CAP_BPF is that we don't want the user to enable CAP_SYS_ADMIN.
> Enabling specific CAPs instead of CAP_SYS_ADMIN should be our
> alignment goal, right?

We want users to switch to CAP_BPF (potentially with CAP_PERFMON)
from full CAP_SYS_ADMIN to reduce attack surface of production workloads.
bpftool is a tool for humans to do introspection and debugging.
It will stay root only.

> If so, then it is worth doing.  As Andrii suggested, a trimmed down
> version is also helpful and should be acceptable.

It's not helpful. It's actively misleading.
