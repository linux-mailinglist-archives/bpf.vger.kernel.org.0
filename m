Return-Path: <bpf+bounces-3213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3DE73AD3C
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 01:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E38281794
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4A323C79;
	Thu, 22 Jun 2023 23:35:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785A23C72
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 23:35:18 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9B62101;
	Thu, 22 Jun 2023 16:35:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so1427775e9.3;
        Thu, 22 Jun 2023 16:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687476915; x=1690068915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJGBxgcrp8RzuCC4+LR2+tCev35qdHuOMegldNw87J4=;
        b=V9HGgWu+FXu9VJlJzhEDPqI6jOgjMrdEX1vVhH9iLdNFj98xRAVkrWBuCql+VMmCiZ
         jOxLkbwiZgNdqb9CFwJyQrALJQAfd0Diz6I3RtuWSMOmtkhdYGHrxSe3ss0G6NDSdYQr
         H8IZgJDf1jdXG/smEfPGBFpYdE5qZfDWiAOLr8TTTRfATgDPh5/0nts5XWOWrV9nqimW
         B8IFPkbaFXN+bE4QeV975ADZq779RZOuJyztontxVp6NliEP0RYfKSvTwHOtgpAkWPk4
         nXnJFpor31pZ2E6T8EmNO7B/sTDzLkNGhA3VwBzOrXUpGHwBRsx7RPJuRMI4tuWw+OK6
         V/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687476915; x=1690068915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJGBxgcrp8RzuCC4+LR2+tCev35qdHuOMegldNw87J4=;
        b=LFc53V8Ihr02dpWypvVu7407j7IISXLfm+WsSZWl/WMH1oEZPgwBnHjF0yPW4mTwdc
         /tDXSjSg/7atv5s03tcBTtZ7KTfQQDQnSNm/FXQca2SpbZGuXCJiTldHpVsDjsimJxPt
         +IFdc5zekAaEeOLrKMqsirsVMEdoVAIB4H0JHZm8f3ROpUVrE3NbO0fFEBEcOY+t0ylG
         1OqOPlvbr88PfNJ89FHlLrcdEgwieVQTBvjpCDNf2NfKayBMvbWCtCnMnBczvRYlZYu8
         jxsHY4jdwnjZPjvDQyOXE5CQ1CzmyooTKgQ0mjVMIYd71JU0vUQUkBG6O5POdCJWeokm
         t/Ug==
X-Gm-Message-State: AC+VfDxongA1SKgjFA+7lPB2noTwPwhpLxyCUU1WIPloBsBF/0dhSUQ3
	GgARktBg8jqrK8QHXNbDYpcKiKy0S61NklYbqC8=
X-Google-Smtp-Source: ACHHUZ6ASiwFYbcSz0FFNMofWJjbhqQo8ZjVLAStNNUsE8bI3CFZDa78DQCr6q7FltVO4dM9UJ6jLNPPwxPZ3Jw4b0E=
X-Received: by 2002:a1c:7c13:0:b0:3f8:fe21:b754 with SMTP id
 x19-20020a1c7c13000000b003f8fe21b754mr18517717wmc.6.1687476915102; Thu, 22
 Jun 2023 16:35:15 -0700 (PDT)
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
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com> <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
 <CAFdtZitYhOK4TzAJVbFPMfup_homxSSu3Q8zjJCCiHCf22eJvQ@mail.gmail.com>
In-Reply-To: <CAFdtZitYhOK4TzAJVbFPMfup_homxSSu3Q8zjJCCiHCf22eJvQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 16:35:02 -0700
Message-ID: <CAEf4BzYheYSuEyaRExODDa4F46A9nOeb-KJ13xrKqQKpXVjXsw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
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

On Thu, Jun 22, 2023 at 2:04=E2=80=AFPM Maryam Tahhan <mtahhan@redhat.com> =
wrote:
>
> On Thu, Jun 22, 2023 at 7:40=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jun 22, 2023 at 10:38=E2=80=AFAM Maryam Tahhan <mtahhan@redhat.=
com> wrote:
> > >
> >
> > Please avoid replying in HTML.
> >
>
> Sorry.

No worries, the problem is that the mailing list filters out such
messages. So if you go to [0] and scroll to the bottom of the page,
you'll see that your email is not in the lore archive. People not
CC'ed directly will only see what you wrote through my reply quoting
your email.

  [0] https://lore.kernel.org/bpf/CAFdtZitYhOK4TzAJVbFPMfup_homxSSu3Q8zjJCC=
iHCf22eJvQ@mail.gmail.com/#t

>
> [...]
>
> >
> > Disclaimer: I don't know anything about Kubernetes, so don't expect me
> > reply with correct terminology or detailed understanding of
> > configuration of containers.
> >
> > But on a more generic and conceptual level, it seems like you are
> > making some implementation assumptions and arguing based on that.
> >
>
> Firstly, thank you for taking the time to respond and explain. I can see
> where you are coming from.
>
> Yeah, admittedly I did make a few assumptions. I was thrown by the refere=
nce
> to `unprivileged` processes in the cover letter. It seems like this is a =
way to
> grant namespaced BPF permissions to a process (my gross
> oversimplification - sorry).

Yep, with the caveat that BPF functionality itself cannot be
namespaced (i.e., contained within the container), so this has to be
granted by a fully privileged process/proxy based on trusting the
workload to not do anything harmful.


> Looking back throughout your responses there's nothing unprivileged here.
>
> [...]
>
>
> > Hopefully you can see where I'm going with this. And this is just one
> > random tiny example. We can think up tons of other cases to prove BPF
> > is not isolatable to any sort of "container".
> >
> > >
> > > Anyway - I hope this clarifies my original intent - which is proxy at=
 least starts to solve one part of the puzzle. Whatever approach(es) we tak=
e to solve the rest of these problems the more we can stick to tried and tr=
usted mechanisms the better.
> >
> > I disagree. BPF proxy complicates logistics, operations, and developer
> > experience, without resolving the issue of determining trust and the
> > need to delegate or proxy BPF functionality.
>
> I appreciate your viewpoint. I just don't think that this is a one
> solution fits every
> scenario situation.

Absolutely. It's also not my intent or goal to kill any sort of BPF
proxy. What I'm trying to convey is that the BPF proxy approach has
severe downsides, depending on application, deployment practices, etc,
etc. It's not always a (good) answer. So I just want to avoid having
the dichotomy of "BPF token or BPF proxy, there could be only one".

> For example in the case of AF_XDP, I'd like to be
> able to run
> my containers without any additional privileges. I've been working on a d=
evice
> plugin for Kubernetes whose job is to provision netdevs with an XDP redir=
ect
> program (then later there's a CNI that moves the netdev into the pod netw=
ork
> namespace).  Originally I was using bpf locally in the device plugin
> (to load the
> bpf program and get the XSK map fd) and SCM rights to pass the XSK_MAP ov=
er
> UDS but honestly it was relatively cumbersome from an app development POV=
, very
> easy to get wrong, and trying to keep up with the latest bpf api
> changes started to
> become an issue. If I wanted to add more interesting bpf programs I
> had to do a full
> recompile...
>
> I've now moved to using bpfd, for the loading and unloading of the bpf
> program on my behalf,
> it also comes with a bunch of other advantages including being able to
> update my trusted bpf
> program transparently to both the device plugin my application (I
> don't have to respin this either
> when I write/want to add a new bpf prog), but mainly I have a trusted
> proxy managing bpffs, bpf progs and maps for me. There's still more
> work to do here...
>

It's a spectrum, and from my observations networking BPF programs lend
themselves more easily to this model of BPF proxy (at least until they
become complicated ensembles of networking and tracing BPF programs).
Very often networking applications can indeed load BPF program
completely independently from user-space parts, keep them "persisted"
in kernel, occasionally control them through pinned BPF maps, etc.

But the further you go towards tracing applications where BPF parts
are integral part of overall user-space application, this model
doesn't work very well. It's much simple to have BPF parts embedded,
loaded, versioned, initialized and interacted with from inside the
same process. And we have lots of such applications. BPF proxy
approach is a massive complication for such use cases with a bunch of
downsides.

> I understand this is a much simplified scenario. and I'm sure I can
> think of several more where
> proxy is useful. All I'm trying to say is, I'm not sure there's just a
> one size fits all soln for these issues.

100% agree. BPF token won't fit all use cases. And BPF proxy won't fit
all use cases either. Both approaches can and should coexist.

>
> Thanks
> Maryam
>

