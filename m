Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD06DB001
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 17:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbjDGP7d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjDGP71 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 11:59:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611ABB472;
        Fri,  7 Apr 2023 08:59:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9188b85a615so214208966b.1;
        Fri, 07 Apr 2023 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTKbMO7QV9DQ15+D3/acLjl4fN+DpQaTcmCVYIqKbSw=;
        b=os2163IBQyvJzeCw1LT1+UYYUHRgCE9BJnywgZPMW2tuCNLRLNLP0sHzHKa2KqU36x
         SvAJS8LO85eSEw+KEhnFFfy+2ZU3CFbwsS/f6eZO4/ur2Pnf+qXWcO2bwUhSBQYy5xlg
         PUrrKFj77RNSslhu6ZuZCHa8DbBfNudONp7g3HZpFxqRto1MtcQ/teAm4e35ZVYyDbpq
         rgfh4JZZY5I2iCU3K3wBiaC69u1LxcoH9CpN2jxsHklfEbxdYElbAcAgWmOhP2Z4la1G
         f9pq+XNrE2kBjsu+3RU5xMNfLJ/HHTBzemDnxYmPWYyY6RjLjQNqMSeFbW7Fo44nmpQ5
         CXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTKbMO7QV9DQ15+D3/acLjl4fN+DpQaTcmCVYIqKbSw=;
        b=tYltOcn/d4apSc2wjsA3dWyCgPSTRUXLBDOCVNobi256oqmQc9D3ZphQsCNSpAuV7N
         KnvkWFuKh80FsT6UJlt3E5V5ll4jCOM/rbxeY2thA4DEodxlv0he9KK2W4FTdFKRijPg
         uEyie2zs8kWOIafi8LmTQLr3yWQiQuvoiEVjrRSIR3mWSiO2ESKtkRUWkwWxCx2QX0Sc
         Ft7glRzC8MJsi6Q7hgo3ddlpBFo/6Rw9B6CqYjq1o5mq9Ws01CoU7WfFUbve0cZpd2xn
         Ti4BfkVyZdyRF5T7AeFimCfhaQUCNxgeDQv8D54KjZh09JJ9LQ6eYQ/sIsXJUTJDaWtE
         fM1g==
X-Gm-Message-State: AAQBX9ea5KYzs30mfVHe0/A77d+8VMIh9lbDC4q4OlWpIX5U2sNCj/vy
        VoFcPD8FTGo6JHdDQz5toM/qaVM3V+jZTDLqDQk=
X-Google-Smtp-Source: AKy350bTHoxp2w9VuMwwG6RDDzE86j/xzJpk7SHAykSX8tp+PoCpAJcZvxJH/E1jYNZUcqeShDHLgfuRQVfMgbwZ2hc=
X-Received: by 2002:a50:d75b:0:b0:4fc:2096:b15c with SMTP id
 i27-20020a50d75b000000b004fc2096b15cmr1636432edj.1.1680883159267; Fri, 07 Apr
 2023 08:59:19 -0700 (PDT)
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
 <CAEf4Bza_vM8HE5g+4ANW3NAAt8=+cn7Lw+DSkH42gimqzYxPdw@mail.gmail.com> <20230407014359.m6tff5ffemvrsyt3@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230407014359.m6tff5ffemvrsyt3@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 7 Apr 2023 08:59:07 -0700
Message-ID: <CAEf4BzaBd9y1O_u-ixr+OGiKarHfX95iHUSGtpSbGnrayg7=zQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Apr 6, 2023 at 6:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 06, 2023 at 01:22:26PM -0700, Andrii Nakryiko wrote:
> > On Wed, Apr 5, 2023 at 10:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Thu, Apr 6, 2023 at 12:24=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 5, 2023 at 8:22=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > > >
> > > > > On Thu, Apr 6, 2023 at 11:06=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 5, 2023 at 7:55=E2=80=AFPM Yafang Shao <laoar.shao@=
gmail.com> wrote:
> > > > > > >
> > > > > > > It seems that I didn't describe the issue clearly.
> > > > > > > The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS_ADM=
IN is
> > > > > > > required to run bpftool,  so the bpftool running in the conta=
iner
> > > > > > > can't get the ID of bpf objects or convert IDs to FDs.
> > > > > > > Is there something that I missed ?
> > > > > >
> > > > > > Nothing. This is by design. bpftool needs sudo. That's all.
> > > > > >
> > > > >
> > > > > Hmm, what I'm trying to do is make bpftool run without sudo.
> > > >
> > > > This is not a task that is worth solving.
> > > >
> > >
> > > Then the container with CAP_BPF enabled can't even iterate its bpf pr=
ogs ...
> >
> > I'll leave the BPF namespace discussion aside (I agree that it needs
> > way more thought).
> >
> > I am a bit surprised that we require CAP_SYS_ADMIN for GET_NEXT_ID
> > operations. GET_FD_BY_ID is definitely CAP_SYS_ADMIN, as they allow
> > you to take over someone else's link and stuff like this. But just
> > iterating IDs seems like a pretty innocent functionality, so maybe we
> > should remove CAP_SYS_ADMIN for GET_NEXT_ID?
> >
> > By itself GET_NEXT_ID is relatively useless without capabilities, but
> > we've been floating the idea of providing GET_INFO_BY_ID (not by FD)
> > for a while now, and that seems useful in itself, as it would indeed
> > help tools like bpftool to get *some* information even without
> > privileges. Whether those GET_INFO_BY_ID operations should return same
> > full bpf_{prog,map,link,btf}_info or some trimmed down version of them
> > would be up to discussion, but I think getting some info without
> > creating an FD seems useful in itself.
> >
> > Would it be worth discussing and solving this separately from
> > namespacing issues?
>
> Iteration of IDs itself is fine. The set of IDs is not security sensitive=
,
> but GET_NEXT_BY_ID has to be carefully restricted.
> It returns xlated, jited, BTF, line info, etc
> and with all the restrictions it would need something like
> CAP_SYS_PTRACE and CAP_PERFMON to be useful.
> And with that we're not far from CAP_SYS_ADMIN.
> Why bother then?

You probably meant that GET_INFO_BY_ID should be carefully restricted?
So yeah, that's what I said that this would have to be discussed
further. I agree that returning func/line info, program dump, etc is
probably a privileged part. But there is plenty of useful info besides
that (e.g., prog name, insns cnt, run stats, etc) that would be useful
for unpriv applications to monitor their own apps that they opened
from BPF FS, or just some observability daemons.

There is a lot of useful information in bpf_map_info and bpf_link_info
that's way less privileged. I think bpf_link_info is good as is. Same
for bpf_map_info.

Either way, I'm not insisting, just something that seems pretty simple
to add and useful in some scenarios. We can reuse existing code and
types for GET_INFO_BY_FD and just zero-out (or prevent filling out)
those privileged fields you mentioned. Anyway, something to put on the
backburner, perhaps.
