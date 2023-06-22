Return-Path: <bpf+bounces-3182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710F73A8CC
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 21:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C2A281AF0
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A821063;
	Thu, 22 Jun 2023 19:06:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208D1F923
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 19:06:00 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF6B186;
	Thu, 22 Jun 2023 12:05:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so23772505e9.1;
        Thu, 22 Jun 2023 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687460756; x=1690052756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKzX8HU3iGA7YZj30ZFXXUvRRkmVjRXxGOr7ayh9S3A=;
        b=axRLq/UrfBfmAnnxFqYiAYsBCZiOmsrSXfV50vA+P8oUiRXariryLoCZ27zD14Db01
         qKTvFS7xauU57l4FMiIfNxTT6VhFvvhuis0lNlq101LtVsWtQli4Xc2LeRoKNLNi8nom
         qqISy04YrcXwgr/TDTvkXXuoRB06QtoFiUGnuisS+GWFV5AHp9e/TIyhWyPKWohIlekt
         Km7skWrSZAgI0pKZfNUiD/SI0fy8r5F0nR7L7RceV0ektQUnt7Xn4/hsogJEMvm0rDOB
         GeEhL0ScvrdQzIHNzSN9Y2RopDBgw1FFR2FaTkwmtCdWYk6J7Mj+lKkX9MPvWcq6c7fj
         Rw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460756; x=1690052756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKzX8HU3iGA7YZj30ZFXXUvRRkmVjRXxGOr7ayh9S3A=;
        b=CeHeA5/TdkvC4ieiPcSrPWNRCEFsMjTTZJ4fegn43c24dE7CW3Egia/F1JO4njOpog
         Rz06349d4fh5ZwELjHarsk9cfbhiGunW1jYC1HG2XaHWw/fUYpo/rotZ/h3ImMSskPJr
         EYWKAwrZT8PAkp5chS1cJhVJKPgGdXWO5X2dFRSVFROGHbVm52J3a6GqXjOx2SgfCDio
         ae1zPQ7ghw2TIaPjgSfUB6D+KPkEiS2A3RBoVeYF/E4fC8uRC8AwEA7KxDmNf0kkaaeo
         zMKOpZONFymKcKBeUjJDi3nGXJBYY9g56+vXZ0BzKFpFiwUGU0LYwNQVoXbp0abPhl7y
         agHg==
X-Gm-Message-State: AC+VfDwSJ0L+1pBBF8b8vx0hQju/WXxXiMdWbUmxCRG4oRrtsoWj+3P7
	CCBZ+MJQwiyWFP+8156K8MX4n0/XIoGX9jy6L+o=
X-Google-Smtp-Source: ACHHUZ7WKBQRnyHouM0Mgv81oRiCwPqkvyDlRShbq6U3hsDIsxxguVSgoGiRKSJELSHtOtbCwrlD/vXJQm8tafox5I0=
X-Received: by 2002:adf:df0b:0:b0:311:1009:10c9 with SMTP id
 y11-20020adfdf0b000000b00311100910c9mr2654579wrl.5.1687460755621; Thu, 22 Jun
 2023 12:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com> <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com> <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
In-Reply-To: <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 12:05:43 -0700
Message-ID: <CAEf4BzZz2yOkHZSuzpYd2Hv_6pxDJt2GdGVnd3yG8AUj0tSudw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andy Lutomirski <luto@kernel.org>
Cc: Maryam Tahhan <mtahhan@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, lennart@poettering.net, cyphar@cyphar.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 9:50=E2=80=AFAM Andy Lutomirski <luto@kernel.org> w=
rote:
>
>
>
> On Thu, Jun 22, 2023, at 1:22 AM, Maryam Tahhan wrote:
> > On 22/06/2023 00:48, Andrii Nakryiko wrote:
> >>
> >>>>> Giving a way to enable BPF in a container is only a small part of t=
he overall task -- making BPF behave sensibly in that container seems like =
it should also be necessary.
> >>>> BPF is still a privileged thing. You can't just say that any
> >>>> unprivileged application should be able to use BPF. That's why BPF
> >>>> token is about trusting unpriv application in a controlled environme=
nt
> >>>> (production) to not do something crazy. It can be enforced further
> >>>> through LSM usage, but in a lot of cases, when dealing with internal
> >>>> production applications it's enough to have a proper application
> >>>> design and rely on code review process to avoid any negative effects=
.
> >>> We really shouldn=E2=80=99t be creating new kinds of privileged conta=
iners that do uncontained things.
> >>>
> >>> If you actually want to go this route, I think you would do much bett=
er to introduce a way for a container manager to usefully proxy BPF on beha=
lf of the container.
> >> Please see Hao's reply ([0]) about his and Google's (not so rosy)
> >> experiences with building and using such BPF proxy. We (Meta)
> >> internally didn't go this route at all and strongly prefer not to.
> >> There are lots of downsides and complications to having a BPF proxy.
> >> In the end, this is just shuffling around where the decision about
> >> trusting a given application with BPF access is being made. BPF proxy
> >> adds lots of unnecessary logistical, operational, and development
> >> complexity, but doesn't magically make anything safer.
> >>
> >>    [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqSWnP1=
6o-uRZ9G0KqCfM4Q@mail.gmail.com/
> >>
> > Apologies for being blunt, but  the token approach to me seems to be a
> > work around providing the right level/classification for a pod/containe=
r
> > in order to say you support unprivileged containers using eBPF. I think
> > if your container needs to do privileged things it should have and be
> > classified with the right permissions (privileges) to do what it needs
> > to do.
>
> Bluntness is great.
>
> I think that this whole level/classification thing is utterly wrong.  Rep=
lace "BPF" with basically anything else, and you'll see how absurd it is.

BPF is not "anything else", it's important to understand that BPF is
inherently not compratmentalizable. And it's vast and generic in its
capabilities. This changes everything. So your analogies are
misleading.

>
> "the token approach to me seems like a work around providing the right le=
vel/classification for a pod/container in order to say you support unprivil=
eged containers using files on disk"
>
> That's very 1990's.  Maybe 1980's.  Of *course* giving access to a filesy=
stem has some inherent security exposure.  So we can give containers access=
 to *different* filesystems.  Or we can use ACLs.  Or MAC policy.  Or whate=
ver.  We have many solutions, none of which are perfect, and we're doing ok=
ay.
>
> "the token approach to me seems like a work around providing the right le=
vel/classification for a pod/container in order to say you support unprivil=
eged containers using the network"
>
> The network is a big deal.  For some reason, it's cool these days to trea=
t TCP as highly privileged.  You can get secrets from your favorite (or lea=
st favorite) cloud provider with unauthenticated HTTP to a magic IP and por=
t.  You can bypass a whole lot of authenticating/authorizing proxies with u=
nauthenticated HTTP (no TLS!) if you're on the right network.
>
> This is IMO obnoxious, but we deal with it by having network namespaces a=
nd firewalls and rather outdated port <=3D 1024 rules.
>
> "the token approach to me seems like a work around providing the right le=
vel/classification for a pod/container in order to say you support unprivil=
eged containers using BPF"
>
> My response is: what's wrong with BPF?  BPF has maps and programs and suc=
h, and we could easily apply 1990's style ownership and DAC rules to them.

Can you apply DAC rules to which kernel events BPF program can be run
on? Can you apply DAC rules to which in-kernel data structures a BPF
program can look at and make sure that it doesn't access a
task/socket/etc that "belongs" to some other container/user/etc?

Can we limit XDP or AF_XDP BPF programs from seeing and controlling
network traffic that will be eventually routed to a container that XDP
program "should not" have access to? Without making everything so slow
that it's useless?

> I even *wrote the code*.

Did you submit it upstream for review and wide discussion? Did you
test it and integrate it with production workloads to prove that your
solution is actually a viable real-world solution and not a toy?
Writing the code doesn't mean solving the problem.

> But for some reason, the BPF community wants to bury its head in the sand=
, pretend it's 1980, declare that BPF is too privileged to have access cont=
rol, and instead just have a complicated switch to turn it on and off in di=
fferent contexts.

I won't speak on behalf of the entire BPF community, but I'm trying to
explain that BPF cannot be reasonably sandboxed and has to be
privileged due to its global nature. And I haven't yet seen any
realistic counter-proposal to change that. And it's not about
ownership of the BPF map or BPF program, it's way beyond that..

>
> Please try harder.

Well, maybe there is something in that "some reason" you mentioned
above that you so quickly dismissed?

