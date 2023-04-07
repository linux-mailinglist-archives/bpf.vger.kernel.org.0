Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B71E6DA846
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 06:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDGEeN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 00:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDGEeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 00:34:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E3D8A6D;
        Thu,  6 Apr 2023 21:34:11 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id dw4so12986008qkb.10;
        Thu, 06 Apr 2023 21:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680842050; x=1683434050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENTDpWQNMAAcYyxjnbNBT6TxnHRnHxSrpQMgU7wzGhc=;
        b=aMyM3TqIW7qmSw5h5v6MEvEVkdgzgvHx9SzhorhMNCC3J4jQpGeVxgQCGKKjYqbsod
         5736UAQfC9l+sR3+VDDQUmEnFr2aunII0u2GIiYZAQiXMmTGnhZNCwL391f8jtLC05Z+
         iPsJreqCcMgEdAjgGofnbLIgww603FXUuVIRGqRdkt8R/6wRT49r/BjC4ViRGfHXBoUY
         kPyqd+9pkZaUNj1x6kyue8jIO0kClrVPXUCrqJjuPiBvYEf4hJtUVlAYw9JQBZ0VWWYn
         k3gGsdNgRJpJ/seE+JTupoEWZtdcfgcjAxE5SGcx57sNEaV/IAHI30gPv670Ht51gBy0
         CCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680842050; x=1683434050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENTDpWQNMAAcYyxjnbNBT6TxnHRnHxSrpQMgU7wzGhc=;
        b=6C1d+T+iWsvBnsXpDHo8aMWo3rUDCP/ASBME2ZGdUtcFgVe8JDKbcmyIM7b90+iFuE
         qBnQ2RPQRhBSt1+luFFhXY5DuqKcrh7xYyvrg73K1i48LEeim7d0JSpNlfPv+SnzrDlt
         88u9ievFT0cRrNc35+r4AVY2zcO7LMuI0wK4/6pWMEnRa4x7lo/vOIUmjihe+aEPKWo/
         COGmVj5955SIsXE5bGe73gxO+z2BV0tShwo7XM6xD1DDZqyTeGeib2C0GDlZlYJUSKFi
         qP6EFLeN44yh7fL8ieDi61q2WG6VXOxhBQsg1J3Q9RFij/Wrc74ybrJE+ePJwlmx/6MN
         T79w==
X-Gm-Message-State: AAQBX9exa9Z43U0QrJFXWndj4uVT9RIHoSy9td/gZUDVQmt+f/By115P
        fKqD6SNYL5bVWvXE28kiJk/JMHFpi4q6+yBK1eDYCw9dz7g=
X-Google-Smtp-Source: AKy350b82r95WgyQhUijH5slfp8PRjIjxdnO1Yk3HrNuVS52p24GwMMJ9UtoXx100r4UBVRsdDKbx/pb+ei29B39oZQ=
X-Received: by 2002:a05:620a:c46:b0:743:6092:91b4 with SMTP id
 u6-20020a05620a0c4600b00743609291b4mr194985qki.14.1680842050437; Thu, 06 Apr
 2023 21:34:10 -0700 (PDT)
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
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 7 Apr 2023 12:33:34 +0800
Message-ID: <CALOAHbCT455UyFqg3K7dtr4vOh6kcC8VryVaJYB31UBS3x=9cA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Fri, Apr 7, 2023 at 9:44=E2=80=AFAM Alexei Starovoitov
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

Not sure if I get your point clearly.  I think the reason we introduce
CAP_BPF is that we don't want the user to enable CAP_SYS_ADMIN.
Enabling specific CAPs instead of CAP_SYS_ADMIN should be our
alignment goal, right?
If so, then it is worth doing.  As Andrii suggested, a trimmed down
version is also helpful and should be acceptable. Agreed with you that
we have lots of things to do, but if we don't try to move it forward,
it will always be as-is.


--=20
Regards
Yafang
