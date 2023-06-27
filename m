Return-Path: <bpf+bounces-3554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B2573FA1F
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 12:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE9C1C20AC2
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6D17727;
	Tue, 27 Jun 2023 10:23:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C57490
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 10:23:22 +0000 (UTC)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAA72711;
	Tue, 27 Jun 2023 03:23:19 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-440ad406bc8so1132160137.3;
        Tue, 27 Jun 2023 03:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687861398; x=1690453398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVcCh4vtuM/z1A3XiNDqF8oXRsUQ3XFCOYJzOB8usD0=;
        b=q7T+7nVhUcQhsi+iZd0Mp95Vj44gjOHwG1yMF5ynq+6LqhgR0jcmulMgMO7kcAqnT1
         pac3zzOjEqKnISXVZBQLpWk6AasVXTTSkSsLS284qCqSWMrC2uLTnRte1gIKAyoua6p4
         YrkdZ5m83DiQPcR0zOYjRvA7izUbLxJl73hSMDhKMwvyXk89QAJT6wdrCSn8TiYjdN+n
         Zq60cDRN3WAWGbHWZbZUbOuWXOZaP8OxCS7TwJdoVsHGY37MhKelV0tyW4vsOfjiOJe6
         ycumLIVFnaSo6wnCNJ867aZqYhYqKxiMfMaFS2ZMuyPU799N441FIl3zxkLP7Yt/CPPr
         +XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687861398; x=1690453398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVcCh4vtuM/z1A3XiNDqF8oXRsUQ3XFCOYJzOB8usD0=;
        b=YUMp+cvw8xcJfyv6GKhwwAkXDmVlaGl6Plh4ETEhMAyp0Z29sYGCzML5gxPKhdKH1l
         liPx72Iq3VgZwfuklorRv8AupJYB5MkdQhPExaJ9zukcIpvQIVKIXX2RooG4Cjg+wXoE
         BMn/MH3RXBrftDBfZbonI1VvqqgQcXC1yvU3fx269o2YZsA4SJWgdQrYKY5elBFW3B+6
         8BbG7vzep6grSDe1xhWGs+XHm0A+hmACWEQQhIlPFVOkMWJOTTs53KgFI8JphhMjgo7z
         m9h+PjS7Xv2CWuHac76neL+570ehrlpZDniEQlppY0ryU1mWJ3IOp8Hq4ctdrZ5o38T1
         UBWA==
X-Gm-Message-State: AC+VfDwY++BEx2DOohki7po7X+JbWIiuHz6012XWCc4QlMSPglTrYs6h
	mCa8rBIv2sMt+LC3hKlvLHjGG2Jglke6CkWEJaA=
X-Google-Smtp-Source: ACHHUZ7g7D3K9ej5vJ0pPLMavpFMAjxeNYamH+wpFt6VXqOuS5/GOvMWUg3KjHxQNM1WlLl7X4xiLYjtqjlgfjzaf4w=
X-Received: by 2002:a05:6102:2847:b0:443:59e3:f4f6 with SMTP id
 az7-20020a056102284700b0044359e3f4f6mr1805500vsb.22.1687861397948; Tue, 27
 Jun 2023 03:23:17 -0700 (PDT)
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
 <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com> <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
 <173f0af7-e6e1-f4b7-e0a6-a91b7a4da5d7@iogearbox.net> <fe47aeb6-dae8-43a6-bcb0-ada2ebf62e08@app.fastmail.com>
 <8340aaf2-8b4c-4f7d-8eed-f72f615f6fd0@app.fastmail.com>
In-Reply-To: <8340aaf2-8b4c-4f7d-8eed-f72f615f6fd0@app.fastmail.com>
From: Djalal Harouni <tixxdz@gmail.com>
Date: Tue, 27 Jun 2023 12:22:51 +0200
Message-ID: <CAEiveUcwi8Sqz0MZm2k3d7uesZai4B738CJxDEd_=h8fPCc+ow@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To: Andy Lutomirski <luto@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Maryam Tahhan <mtahhan@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
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

On Sat, Jun 24, 2023 at 5:28=E2=80=AFPM Andy Lutomirski <luto@kernel.org> w=
rote:
>
>
>
> On Sat, Jun 24, 2023, at 6:59 AM, Andy Lutomirski wrote:
> > On Fri, Jun 23, 2023, at 4:23 PM, Daniel Borkmann wrote:
>
> >
> > If this series was about passing a =E2=80=9Cmay load kernel modules=E2=
=80=9D token
> > around, I think it would get an extremely chilly reception, even though
> > we have module signatures.  I don=E2=80=99t see anything about BPF that=
 makes
> > BPF tokens more reasonable unless a real security model is developed
> > first.
> >
>
> To be clear, I'm not saying that there should not be a mechanism to use B=
PF from a user namespace.  I'm saying the mechanism should have explicit ac=
cess control.  It wouldn't need to solve all problems right away, but it sh=
ould allow incrementally more features to be enabled as the access control =
solution gets more powerful over time.
>
> BPF, unlike kernel modules, has a verifier.  While it would be a departur=
e from current practice, permission to use BPF could come with an explicit =
list of allowed functions and allowed hooks.
>
> (The hooks wouldn't just be a list, presumably -- premission to install a=
n XDP program would be scoped to networks over which one has CAP_NET_ADMIN,=
 presumably.  Other hooks would have their own scoping.  Attaching to a cgr=
oup should (and maybe already does?) require some kind of permission on the=
 cgroup.  Etc.)
>
> If new, more restrictive functions are needed, they could be added.
>

This seems to align with BPF fd/token delegation. I asked in another
thread if more context/policies could be provided from user space when
configuring the fd and the answer: it can be on top as a follow up...

The user namespace is just one single use case of many, also confirmed
in this reply [0] . Getting it to work in init userns should be the
first logical step anyway, then once you have an fd you can delegate
it or pass it around to childs that create nested user namespaces, etc
as it is currently done within container managers when they setup the
environments including the uid mapping... and of course there should
be some sort of mechanism to ensure that the delegated fd comes say
from a parent user namespace before using it and deny any cross
namespaces usage...


> Alternatively, people could try a limited form of BPF proxying.  It would=
n't need to be a full proxy -- an outside daemon really could approve the a=
ttachment of a BPF program, and it could parse the program, examine the lis=
t of function it uses and what the proposed attachment is to, and make an e=
ducated decision.  This would need some API changes (maybe), but it seems e=
minently doable.
>

Even a *limited* BPF proxying seems more in the opposite direction of
what you are suggesting above?

If I have an fd or the bpffs mount with a token properly setup by the
manager I can directly use it inside my containers, load small bpf
programs without talking to another external API of another
container... I assume the manager passed me the rights or already
pre-approved the operation...

Of course there is also the case of approving the attachment of bpf
programs without passing an fd/token which I assume is your point or
in other words denying it which makes perfectly sense indeed, then
yes: an outside daemon could do this, systemd / container managers etc
with the help of LSMs could *deny* attachment of BPF programs without
any external API changes (they already support LSMs), IIRC there is
already a hook part of bpf() syscall to restrict some program types
maybe, so future cases of bpf token should add in kernel and LSMs +
bpf-lsm hooks, ensure they are properly called with the full context
and restrict further...

So for the "limited form of BPF proxying... to approve attachment..."
I think with fd delegation of bpffs mount (that requires privileges to
set it up) then an in kernel LSM hooks on top to tighten this up is
the way to go


[0] https://lore.kernel.org/bpf/CAEf4BzbjGBY2=3DXGmTBWX3Vrgkc7h0FRQMTbB-SeK=
Ef28h6OhAQ@mail.gmail.com/

