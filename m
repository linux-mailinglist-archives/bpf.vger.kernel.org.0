Return-Path: <bpf+bounces-3092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B9739336
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 01:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C22D1C2074B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E961DCC7;
	Wed, 21 Jun 2023 23:48:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468F1C769
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 23:48:25 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085910C1;
	Wed, 21 Jun 2023 16:48:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f9c88ac077so10155015e9.1;
        Wed, 21 Jun 2023 16:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687391302; x=1689983302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqEKp9bQYWmAKZa3rwdeFo/lgg6mgIscvQDEfZjWMBg=;
        b=dXT85QQkOMgdFy57PmVWRFub89ilW0nNDc7pJgRrudjm6YNsK0lu1XoF9QNiL/GeTS
         8a7BwS9d0Wa2WOx5wZIvfLUbz0X5rvgTXG6k9d0WUxWHxw9uJtqs8d/sgbrRM8xzqGHC
         cBETyo6T9LWsexIGZ7/i4YtBgsLpEulCnTYYMDYRdrJ9Ifir5XL8g+Qzylq8qBhmKcP3
         Jwr5DAlYFQsiyYQ4vMybF4TeQGVF8UgTH66IzG/LfNsIM+dH32Y0xsw5qkkkitKMl0uA
         CQikKw80yqc/o3hebcyNeDsafXys5HXzZhictbHHFhgByRjpP4n2wvNs5vZwmEt+u1r3
         xlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687391302; x=1689983302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqEKp9bQYWmAKZa3rwdeFo/lgg6mgIscvQDEfZjWMBg=;
        b=Rd25WNAp0czkUZLkorkiQyx80n5Vy38kHnG4tVre5JHxHCuXkS27JcDLOyrpUCd7Ef
         QLrnfMhb/r6oSsv5rgVTT3GT7v/sB2zW9hH6Qv4m975hk6MlBP2XiVmCREXpA2ae0eoh
         wWy9dVb4p5hhjXRnrFIyS0LwjyELbsbRAkmHPTBbAbS+MNdooPBDo87/HsGrMlGVY2TU
         EbbGUVycRTqZwwY3R1d9elbZBg12DGqf+TdajwBSZ+6CfFdt1SStBisDe135VrH1pRa6
         ejkd5AZNN4O4qSRUJ58f8mE+WeUf8PIkqbQPQuRRzwI3VImV4ULho8HFljTt+FW+6oQn
         BZ7w==
X-Gm-Message-State: AC+VfDxbvsWTNKmzKfEBWNgBE0p7Tcv/wB2FNri8jQPwflX7nxhONbQK
	WvzLA4AyMFX7LVFy1YTPj41WpH7adaeEfyXA+FQ=
X-Google-Smtp-Source: ACHHUZ6BReKIdqyB1h/cq7FH63WU+CPflfAK13B12wrNfpq/J6ecEYZ0KsT9t3OnevSzZ1OV0DVP0oh8QRgxKSn5wfs=
X-Received: by 2002:a1c:f718:0:b0:3f7:e65b:5252 with SMTP id
 v24-20020a1cf718000000b003f7e65b5252mr376000wmh.1.1687391301612; Wed, 21 Jun
 2023 16:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com> <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
In-Reply-To: <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Jun 2023 16:48:09 -0700
Message-ID: <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andy Lutomirski <luto@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
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

On Mon, Jun 19, 2023 at 10:40=E2=80=AFAM Andy Lutomirski <luto@kernel.org> =
wrote:
>
>
>
> On Fri, Jun 9, 2023, at 12:08 PM, Andrii Nakryiko wrote:
> > On Fri, Jun 9, 2023 at 11:32=E2=80=AFAM Andy Lutomirski <luto@kernel.or=
g> wrote:
> >>
> >> On Wed, Jun 7, 2023, at 4:53 PM, Andrii Nakryiko wrote:
> >> > This patch set introduces new BPF object, BPF token, which allows to=
 delegate
> >> > a subset of BPF functionality from privileged system-wide daemon (e.=
g.,
> >> > systemd or any other container manager) to a *trusted* unprivileged
> >> > application. Trust is the key here. This functionality is not about =
allowing
> >> > unconditional unprivileged BPF usage. Establishing trust, though, is
> >> > completely up to the discretion of respective privileged application=
 that
> >> > would create a BPF token.
> >> >
> >>
> >> I skimmed the description and the LSFMM slides.
> >>
> >> Years ago, I sent out a patch set to start down the path of making the=
 bpf() API make sense when used in less-privileged contexts (regarding acce=
ss control of BPF objects and such).  It went nowhere.
> >>
> >> Where does BPF token fit in?  Does a kernel with these patches applied=
 actually behave sensibly if you pass a BPF token into a container?
> >
> > Yes?.. In the sense that it is possible to create BPF programs and BPF
> > maps from inside the container (with BPF token). Right now under user
> > namespace it's impossible no matter what you do.
>
> I have no problem with creating BPF maps inside a container, but I think =
the maps should *be in the container*.
>
> My series wasn=E2=80=99t about unprivileged BPF per se.  It was about upd=
ating the existing BPF permission model so that it made sense in a context =
in which it had multiple users that didn=E2=80=99t trust each other.

I don't think it's possible with BPF, in principle, as I mentioned in
the cover letter. Even if some particular types of programs could be
"contained" in some sense, in general BPF is too global by its nature
(it observes everything in kernel memory, it can influence system-wide
behaviors, etc).

>
> >
> >> Giving a way to enable BPF in a container is only a small part of the =
overall task -- making BPF behave sensibly in that container seems like it =
should also be necessary.
> >
> > BPF is still a privileged thing. You can't just say that any
> > unprivileged application should be able to use BPF. That's why BPF
> > token is about trusting unpriv application in a controlled environment
> > (production) to not do something crazy. It can be enforced further
> > through LSM usage, but in a lot of cases, when dealing with internal
> > production applications it's enough to have a proper application
> > design and rely on code review process to avoid any negative effects.
>
> We really shouldn=E2=80=99t be creating new kinds of privileged container=
s that do uncontained things.
>
> If you actually want to go this route, I think you would do much better t=
o introduce a way for a container manager to usefully proxy BPF on behalf o=
f the container.

Please see Hao's reply ([0]) about his and Google's (not so rosy)
experiences with building and using such BPF proxy. We (Meta)
internally didn't go this route at all and strongly prefer not to.
There are lots of downsides and complications to having a BPF proxy.
In the end, this is just shuffling around where the decision about
trusting a given application with BPF access is being made. BPF proxy
adds lots of unnecessary logistical, operational, and development
complexity, but doesn't magically make anything safer.

  [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqSWnP16o-uRZ=
9G0KqCfM4Q@mail.gmail.com/

>
> >
> > So privileged daemon (container manager) will be configured with the
> > knowledge of which services/containers are allowed to use BPF, and
> > will grant BPF token only to those that were explicitly allowlisted.
>

