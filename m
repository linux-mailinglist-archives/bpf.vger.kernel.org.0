Return-Path: <bpf+bounces-17012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD22808B59
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E761C20AD9
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A6344394;
	Thu,  7 Dec 2023 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0+PC0jS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0935288
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 15:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAD9C433C8
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701961476;
	bh=gGsBBUdzE4uPOpF7BY4qUy3f50uGrvZiodpR1CVRjcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n0+PC0jS30Fb0BpUMMXcHc7RKr4RjJ7PSwTBa/VM0zy4bRvjhWHQx5ddIb41lHPJO
	 6gcqHmuHn00CnzQRBkd/EoxbZqNRrx9YfTsh9iFANkBkERw0ZRlnQYMAU80447u2Xk
	 ygWJ/qjUX7G84K56Md/4pSpFgB2AyWZKjE8R0VrH1a+Kzzqvk5+/2ZocuYaCcmmPj4
	 mPVhcxFlAQoTgOxQ9o2AjOXK2yZKTKfOS/Kz0zIIBEIP54qALGpzV0dh3ceOnr6DZ1
	 U+/8ry3g8q22bk9GUMugYeM6ab0mJt2mcf62KcyDqLs3HwARNEu3zJybjcJUZGYlmy
	 mWc8Itx2PG70g==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54c671acd2eso1332661a12.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 07:04:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yy5hd820Lf2ZAfqttVFOXmU9kZeok4c3q1ULdjbHLfHcaIi+wzG
	IyBlSVGKthKCnHN7wVfoTDbKipC6IV9F6xt6icPiVA==
X-Google-Smtp-Source: AGHT+IGOhALX3ZlyCyf0/AtmMA/4f/5le2SnLZ+FOxKMUEKhniGDdAdpyJ1k7cNP1/FwdL4rdt6F+HE89OcfyHR/1qQ=
X-Received: by 2002:a05:6402:cac:b0:54a:ff96:2cba with SMTP id
 cn12-20020a0564020cac00b0054aff962cbamr1564176edb.33.1701961475327; Thu, 07
 Dec 2023 07:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3> <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
 <CALOAHbDjdNhtkTdimkQaqrPOX2gOxao9Z_udjyPsfhPfu=+vKA@mail.gmail.com>
 <CACYkzJ6fgjMHvyUt0v5Z_-_uSKPu-zdKu+iXDZBNQZWsVc2WXQ@mail.gmail.com> <CALOAHbC3b9scsysawvAQ5Pq2igaxdvCdeL4=2LdKQn5TVWgY6w@mail.gmail.com>
In-Reply-To: <CALOAHbC3b9scsysawvAQ5Pq2igaxdvCdeL4=2LdKQn5TVWgY6w@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 7 Dec 2023 16:04:24 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4QpQZ8JmdNXKWeSh8oc=jAyRh4Zj98Z+TG37Ce=cfE0w@mail.gmail.com>
Message-ID: <CACYkzJ4QpQZ8JmdNXKWeSh8oc=jAyRh4Zj98Z+TG37Ce=cfE0w@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, revest@chromium.org, jackmanb@chromium.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 3:56=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Thu, Dec 7, 2023 at 10:39=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > > >
> > > > IMHO this is the best option. Here:
> > > >
> > > > * BPF LSM Program =3D MAC Policy
> > > > * Removing / detaching / updating programs =3D Updating MAC policy
> > >
> > > What happens if a privileged user terminates the BPF LSM task and
> > > deletes any pinned BPF files that might exist?
> >
> > The LSM program is pinned, so it does not matter if the task is termina=
ted.
> >
> > > We can apply specific capabilities to restrict access, but it's
> > > important to note that privileged users might also possess these
> >
> > That depends on how you implement your restriction logic. If your LSM
> > program says, check CAP_MAC_ADMIN -> Allow removal, then your logic
> > explicitly grants the privilege. If your LSM hook denies all
> > privileged users the ability to remove the program, then no privileged
> > user can remove the LSM program.
>
> If it's impossible for any privileged user to remove the LSM program,
> this brings up another question: how can we stop this program?

Again, it depends on how you implement the logic in the LSM hook, few ideas=
:

* Layout xattr based policy that allows one particular binary running
as one particular user to remove the program
* Come up with your own rules that, e.g. say allows the system to boot
in a "privileged / un-enforced mode" which allows CAP_MAC_ADMIN to
update the policy.
* A really terrible way. All odd user IDs with MAC_ADMIN are allowed
to remove the program.

The point here is to further fine grain the concept of administrative
"privilege" for accessing specific resources, LSM programs being a
resource and BPF LSM programs is one way.

What I would encourage you to look at is how other LSM programs allow
dynamic updates to their LSM policy and the same mechanisms should be
usable in BPF.


> However, if a privileged user does have the capability to remove it,
> then the individual capable of doing so might possess these
> privileges.
>
> >
> > The whole point here is to restrict privileged users from doing stuff.
> >
> > - KP
> >
> > > capabilities.
> > >
> > > >
> > > > The decision around who can update MAC policy can be governed by th=
e
> > > > policy itself a.k.a. implemented with BPF LSM programs.  So we can
> > > > update hooks (as suggested here inode_unlink, sb_unmount, path_unli=
nk)
> > > > to only allow this action for a subset of users (e.g. CAP_MAC_ADMIN=
 or
> > > > even further restricted)
> > > >
> > > > While, I think this may be doable with existing LSM hooks but we ne=
ed
> > > > to probably have to cover multiple hook points needed to prevent on=
e
> > > > action which makes a good case for another LSM hook, perhaps someth=
ing
> > > > in the link->ops->detach path like
> > > > https://elixir.bootlin.com/linux/latest/source/kernel/bpf/syscall.c=
#L5074
> > > >
> > > > What do you think?
> > > >
> > > > - KP
> >
> > >
> > >
> > > --
> > > Regards
> > > Yafang
>
>
>
> --
> Regards
> Yafang

