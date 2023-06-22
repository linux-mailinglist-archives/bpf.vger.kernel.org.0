Return-Path: <bpf+bounces-3176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20A873A81F
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 20:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB153281A48
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 18:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646920692;
	Thu, 22 Jun 2023 18:21:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5601F182
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 18:21:14 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847BF1FF1;
	Thu, 22 Jun 2023 11:21:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa798cf204so3109375e9.0;
        Thu, 22 Jun 2023 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687458071; x=1690050071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC4RE0qzdyYrTcJ76s8eLsJIMG1aIPWgpxvZBfxllaE=;
        b=Td2jfDE7J7HurJvOlC6S6Anz5/qvmTAXrOCsgTStonimoxnFKTNsHPnOSotYN1SD3f
         3Y/8T4j29txwSHQ0BxsrZoZqa1Oe24SCY27D/l63RG7SHiYCUyf9RxVD4E8JR4CYhWsq
         FlWliXLzjzXOQHW0raUnwm/OQ4KzjDr67qvrSAYJ+omZ02Si3YxsTKBAGADbfsde5cEQ
         B0lpZz5WOcA4AI9RHM867LU/j2zUE0+xJcUvbAsVBnHxEPoBNMZRa5hUKmTOPG5+WRiq
         A7w4RNtwrENg3Dt9PMyPBTCI54fu8/FKeoB+oQ5WdBbKn/d3KM8JXFgWRYOby4+U6I41
         NxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687458071; x=1690050071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC4RE0qzdyYrTcJ76s8eLsJIMG1aIPWgpxvZBfxllaE=;
        b=G8P0NiXyLY20dHnZQUd3WoHM+aqZwBP7awVUQgRk5N+2lxPRFmhufZw2euX86M/6ij
         9m6PwE5rsUPb1kVKFniH0zaSwoMK8aRdX1fVOOfgkx5X8n39PRb0VYHW4s67l4oGGyZ3
         xJ982q+i9gPLRB5H0JdV6B7VKrCfYxSDPw2AbTxAHbxx44v3X4yUF5uQLRrpA3ZsUqti
         nxLR9RcBQ/8Y/zntxJBRCxepQC/XvqLcQT06tsVgk/KKSnDH91Y4+7fa71PA73xrmXz1
         CHQSECDvNeWMgiw8Pin8CTcZVrxJBr/CITo6WnYLIR1BJTqAydt7ps0LwpV8zAcTGGi5
         GWGg==
X-Gm-Message-State: AC+VfDwv3gSYfUsJLqg7v7tVprv82SrrRfpPCcGZnLWCiwfPbacXpYV7
	uC0nzl2w1g4n3Zs8GAG1IM66L6ZQ/DaHmqFuqQOFOkzC/L2ICw==
X-Google-Smtp-Source: ACHHUZ7W6EIHOy9y1GppAOPEO2F+mBJBur3bQ00/u7JwHBBNGR+cyuaaBk2n3OjHANzBpcoNX2RYFj93aSEBUJJzp3g=
X-Received: by 2002:a7b:cc8d:0:b0:3f7:33cf:707e with SMTP id
 p13-20020a7bcc8d000000b003f733cf707emr20044761wma.18.1687458070648; Thu, 22
 Jun 2023 11:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com> <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
In-Reply-To: <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 11:20:58 -0700
Message-ID: <CAEf4BzY2dKvMk_Mg2oLnD5a8aOhXCmU-0QD6sWGNZqkjbMrhBA@mail.gmail.com>
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

On Thu, Jun 22, 2023 at 1:23=E2=80=AFAM Maryam Tahhan <mtahhan@redhat.com> =
wrote:
>
> On 22/06/2023 00:48, Andrii Nakryiko wrote:
> >
> >>>> Giving a way to enable BPF in a container is only a small part of th=
e overall task -- making BPF behave sensibly in that container seems like i=
t should also be necessary.
> >>> BPF is still a privileged thing. You can't just say that any
> >>> unprivileged application should be able to use BPF. That's why BPF
> >>> token is about trusting unpriv application in a controlled environmen=
t
> >>> (production) to not do something crazy. It can be enforced further
> >>> through LSM usage, but in a lot of cases, when dealing with internal
> >>> production applications it's enough to have a proper application
> >>> design and rely on code review process to avoid any negative effects.
> >> We really shouldn=E2=80=99t be creating new kinds of privileged contai=
ners that do uncontained things.
> >>
> >> If you actually want to go this route, I think you would do much bette=
r to introduce a way for a container manager to usefully proxy BPF on behal=
f of the container.
> > Please see Hao's reply ([0]) about his and Google's (not so rosy)
> > experiences with building and using such BPF proxy. We (Meta)
> > internally didn't go this route at all and strongly prefer not to.
> > There are lots of downsides and complications to having a BPF proxy.
> > In the end, this is just shuffling around where the decision about
> > trusting a given application with BPF access is being made. BPF proxy
> > adds lots of unnecessary logistical, operational, and development
> > complexity, but doesn't magically make anything safer.
> >
> >    [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqSWnP16=
o-uRZ9G0KqCfM4Q@mail.gmail.com/
> >
> Apologies for being blunt, but  the token approach to me seems to be a
> work around providing the right level/classification for a pod/container
> in order to say you support unprivileged containers using eBPF. I think
> if your container needs to do privileged things it should have and be
> classified with the right permissions (privileges) to do what it needs
> to do.

For one, when user namespaces are involved, there is no BPF use at
all, no matter how privileged you want to mark the container. I
mentioned this in the cover letter. Now, the claim is that user
namespaces are indeed useful and necessary, and yet we also want such
user-namespaced applications to be able to use BPF.

Currently there is no solution to that. And external BPF service is
not a great one, see [0], for real world users' feedback.

  [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqSWnP16o-uRZ=
9G0KqCfM4Q@mail.gmail.com/


>
> The  proxy BPF on behalf of the container approach works for containers
> that don't need to do privileged BPF operations.

BPF usage *is privileged* in all but some tiny use cases that are ok
with heavily limited unprivileged BPF functionality (and even then
recommendation is to disable unprivileged BPF altogether). Whether you
proxy such privileged BPF usage through an external application or you
are granting BPF token to such application is in the same category:
someone has to decide to trust the application to perform privileged
BPF operations.

And the only debatable thing here is whether the application itself
should do bpf() syscalls directly and be able to use the entire BPF
ecosystem of libraries, tools, techniques, and approaches. Or we go
and rewrite the world to use some RPC-based proxy to bpf() syscall?

And to put it bluntly, the latter is not a realistic (or even good) option.

>
> I have to say that  the `proxy BPF on behalf of the container` meets the
> needs of unprivileged pods and at the same time giving CAP_BPF to the

I tried to make it very clear in the cover letter, but granting
CAP_BPF under user namespace means precisely nothing. CAP_BPF is only
useful in the init namespace.

> applications meets the needs of these PODs that need to do
> privileged/bpf things without any tokens. Ultimately you are trusting
> these apps in the same way as if you were granting a token.

Yes, absolutely. As I mentioned very explicitly, it's the question of
trusting application. Service vs token is implementation details, but
the one that has huge implications in how applications are built,
tested, versioned, deployed, etc.

>
>
> >>> So privileged daemon (container manager) will be configured with the
> >>> knowledge of which services/containers are allowed to use BPF, and
> >>> will grant BPF token only to those that were explicitly allowlisted.
>
>

