Return-Path: <bpf+bounces-11559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CEA7BBEC0
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A926282060
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A52772C;
	Fri,  6 Oct 2023 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMnehza8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A638F82
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 18:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF34C433CD
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 18:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696617174;
	bh=Wo5TVsAh4zwAyG8YmJok1TKMSHsOxoXM59UTIVqzIQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PMnehza84yQrST6C04Zo/j199M6miOPmmndVao5lnwEDABWosVZyOlIfmWYumVJu+
	 BgdJ4C/ErVd0lGVYVestMG8DGZejaiZfVlTg3eAA+ey0h168u+ETHC6a01eHlq+o6N
	 NXkx5Yg8Nch5VlC50wjlS7GDTztEs86kg/sHK/WiJ2lrCIg7YqrjXIp/irtvbQMiLS
	 yUUrbZ7eK+hcNCSSHhANe/pxG8S9m7ZkQEMp0avclZK7Vb9WfmTXjWwjhIG5w6rBEU
	 cPwKLVmqmsu1g1RnrpbikqDkQasfCO0abo7LG0BBQfQK/Y5q6hXpom3Wyx31VlgInc
	 /PxiPO3S1cnQw==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-32329d935d4so2138689f8f.2
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 11:32:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YzapbuSuMt7+TXuhn+hR5TqAuJT9LsYRUV+qzvO1xufaJiKp93s
	s/A2ujiyvp2E1IVNWaHeEYuQx7uWlElo6Cye5a1N/A==
X-Google-Smtp-Source: AGHT+IEKq7JkOnxheDwh+EPrFD06USuUEnDxzzGY/pl2gR2Zu8Xw2N+xl5PYO3drM5T863PU1C9rwL7BPhVdYcCO87o=
X-Received: by 2002:a5d:6d41:0:b0:323:2f54:b6cb with SMTP id
 k1-20020a5d6d41000000b003232f54b6cbmr8405157wri.8.1696617172896; Fri, 06 Oct
 2023 11:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928202410.3765062-1-kpsingh@kernel.org> <20230928202410.3765062-5-kpsingh@kernel.org>
 <ZR5vSyyNGBb8TvNH@krava> <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
 <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com>
 <ZR6/iMnfl1q6Hf9I@krava> <CACYkzJ7aeBjMFTrBPf5u-Wib0Jk=rOX31yeBT5koUt=iYUF2MA@mail.gmail.com>
 <ZR+2+gQ3B3tgFI/8@krava> <ZR/Nz+aPH4sIQMwT@krava> <CACYkzJ5zGma1OJyxfnx=P7gNJDcTbQ8mJ56dqszyJj+guXg9Zw@mail.gmail.com>
In-Reply-To: <CACYkzJ5zGma1OJyxfnx=P7gNJDcTbQ8mJ56dqszyJj+guXg9Zw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 6 Oct 2023 20:32:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7OyKvYP+cmTbMn3DWn8vFtwC-CJHJqYOBjJg0fmu2Yvw@mail.gmail.com>
Message-ID: <CACYkzJ7OyKvYP+cmTbMn3DWn8vFtwC-CJHJqYOBjJg0fmu2Yvw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 6, 2023 at 12:57=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Fri, Oct 6, 2023 at 11:05=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Fri, Oct 06, 2023 at 09:27:57AM +0200, Jiri Olsa wrote:
> >
> > SNIP
> >
> > > >  static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> > > > struct bpf_trampoline *tr)
> > > >  {
> > > >         enum bpf_tramp_prog_type kind;
> > > >         struct bpf_tramp_link *link_exiting;
> > > > -       int err =3D 0, num_lsm_progs =3D 0;
> > > > +       int err =3D 0;
> > > >         int cnt =3D 0, i;
> > > >
> > > >         kind =3D bpf_attach_type_to_tramp(link->link.prog);
> > > > @@ -547,15 +566,14 @@ static int __bpf_trampoline_link_prog(struct
> > > > bpf_tramp_link *link, struct bpf_tr
> > > >                 /* prog already linked */
> > > >                 return -EBUSY;
> > > >
> > > > -               if (link_exiting->link.prog->type =3D=3D BPF_PROG_T=
YPE_LSM)
> > > > -                       num_lsm_progs++;
> > > >         }
> > > >
> > > > -       if (!num_lsm_progs && link->link.prog->type =3D=3D BPF_PROG=
_TYPE_LSM)
> > > > -               bpf_lsm_toggle_hook(tr->func.addr, true);
> > > > -
> > > >         hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
> > > >         tr->progs_cnt[kind]++;
> > > > +
> > > > +       if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > > +               bpf_trampoline_toggle_lsm(tr, kind);
> > >
> > > how about keeping BPF_PROG_TYPE_LSM progs type count of attached prog=
rams
> > > in bpf_trampoline and toggle lsm on first coming in and last going ou=
t?
> >
> > hm we actually allow other tracing program types to attach to bpf_lsm_*
> > functions, so I wonder we should toggle the lsm hook for each program
> > type (for bpf_lsm_* trampolines) because they'd expect the hook is call=
ed
>
> Tracing is about tracing, attaching a tracing program to bpf_lsm_ that
> changes the actual trace here is not something I would recommend.
> Infact, I have used tracing programs to figure out whether bpf_lsm_*
> is being called to debug stuff. Tracing users can always attach to
> security_* if they like.
>

I will rev up with this fix and send it out as I will be unavailable
for the next 2 weeks.

- KP

> - KP
>
> >
> > but I'm not sure it's a valid use case to have like normal fentry progr=
am
> > attached to bpf_lsm_XXX function
> >
> > jirka
> >
> > >
> > > also the trampoline attach is actually made in bpf_trampoline_update,
> > > so I wonder it'd make more sense to put it in there, but it's already
> > > complicated, so it actually might be easier in here
> > >
> > > jirka
> > >
> > > > +
> > > >         err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex=
 */);
> > > >         if (err) {
> > > >                 hlist_del_init(&link->tramp_hlist);
> > > > @@ -578,7 +596,6 @@ static int __bpf_trampoline_unlink_prog(struct
> > > > bpf_tramp_link *link, struct bpf_
> > > >  {
> > > >         struct bpf_tramp_link *link_exiting;
> > > >         enum bpf_tramp_prog_type kind;
> > > > -       bool lsm_link_found =3D false;
> > > >         int err, num_lsm_progs =3D 0;
> > > >
> > > >         kind =3D bpf_attach_type_to_tramp(link->link.prog);
> > > > @@ -595,18 +612,14 @@ static int __bpf_trampoline_unlink_prog(struc=
t
> > > > bpf_tramp_link *link, struct bpf_
> > > >                                      tramp_hlist) {
> > > >                         if (link_exiting->link.prog->type =3D=3D BP=
F_PROG_TYPE_LSM)
> > > >                                 num_lsm_progs++;
> > > > -
> > > > -                       if (link_exiting->link.prog =3D=3D link->li=
nk.prog)
> > > > -                               lsm_link_found =3D true;
> > > >                 }
> > > >         }
> > > >
> > > >         hlist_del_init(&link->tramp_hlist);
> > > >         tr->progs_cnt[kind]--;
> > > >
> > > > -       if (lsm_link_found && num_lsm_progs =3D=3D 1)
> > > > -               bpf_lsm_toggle_hook(tr->func.addr, false);
> > > > -
> > > > +       if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > > +               bpf_trampoline_toggle_lsm(tr, kind);
> > > >         return bpf_trampoline_update(tr, true /* lock_direct_mutex =
*/);
> > > >  }
> > > >
> > > >
> > > > - KP
> >

