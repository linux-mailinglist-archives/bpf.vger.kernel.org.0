Return-Path: <bpf+bounces-11459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AFC7BA498
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 18:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 01D6D281D24
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779DB341A0;
	Thu,  5 Oct 2023 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1qIUMvL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202A30CEA
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FED1C433C7
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696522061;
	bh=ex/4a4hL/BltlrDLRwQmRO36M3XSgUdNoud2wHz73uk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W1qIUMvLHpZgC40aypRPHNV0O+GXBEjGd2uh9Wkzj+hjLsSMPZ5yLmVmwYjyBFMhD
	 53pQsOdySkiMbX6lbRA7x6rl4azcXZH3jyESqnV6DQT3JQdXuoxgy5G/2zvfzFkdcy
	 z7eFYAWuW8fxYUMBVskAwluvQW6N5GlYUxRoMwFCVRJ3UBJb7NgREEh8Do4R7hYKId
	 RElnucdw/qA3bdrQpWd2ZewIM+dqj2rz4VciO0IZB06MWQ0yd63P7k+YNqD2mRYSqf
	 IDe99wZaCs+TLbYW+uXh8jin3KJ+YDctnSETmL0ctay38JlhD9aZG1AT96b4N3Nynp
	 823CJinaTj2cg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-533df112914so1995226a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 09:07:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw1G7914KKp1yVLm0V9UfmAJBZtBL69n/37PHQwqVAQNDgrBWyR
	DOFsNeqzHfObSo+WBZGm4wGPcy1DJ3BpDpynB14HGg==
X-Google-Smtp-Source: AGHT+IE7N4R7qSzwfyOnCXQ5AyhDWnTCTUlUj7HsQKIphesyMcFKL3WGpx4Ygep9GXG7lC/FEh6Eq7vs3lRgEsRl6QE=
X-Received: by 2002:a05:6402:217:b0:533:4c15:c337 with SMTP id
 t23-20020a056402021700b005334c15c337mr4822697edv.16.1696522059790; Thu, 05
 Oct 2023 09:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928202410.3765062-1-kpsingh@kernel.org> <20230928202410.3765062-5-kpsingh@kernel.org>
 <ZR5vSyyNGBb8TvNH@krava> <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
 <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com> <ZR6/iMnfl1q6Hf9I@krava>
In-Reply-To: <ZR6/iMnfl1q6Hf9I@krava>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 5 Oct 2023 18:07:28 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7aeBjMFTrBPf5u-Wib0Jk=rOX31yeBT5koUt=iYUF2MA@mail.gmail.com>
Message-ID: <CACYkzJ7aeBjMFTrBPf5u-Wib0Jk=rOX31yeBT5koUt=iYUF2MA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 5, 2023 at 3:52=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Oct 05, 2023 at 03:27:35PM +0200, KP Singh wrote:
> > On Thu, Oct 5, 2023 at 3:26=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> > >
> > > On Thu, Oct 5, 2023 at 10:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > On Thu, Sep 28, 2023 at 10:24:09PM +0200, KP Singh wrote:
> > > >
> > > > SNIP
> > > >
> > > > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > > > index e97aeda3a86b..df9699bce372 100644
> > > > > --- a/kernel/bpf/trampoline.c
> > > > > +++ b/kernel/bpf/trampoline.c
> > > > > @@ -13,6 +13,7 @@
> > > > >  #include <linux/bpf_verifier.h>
> > > > >  #include <linux/bpf_lsm.h>
> > > > >  #include <linux/delay.h>
> > > > > +#include <linux/bpf_lsm.h>
> > > > >
> > > > >  /* dummy _ops. The verifier will operate on target program's ops=
. */
> > > > >  const struct bpf_verifier_ops bpf_extension_verifier_ops =3D {
> > > > > @@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct =
bpf_tramp_link *link, struct bpf_tr
> > > > >  {
> > > > >       enum bpf_tramp_prog_type kind;
> > > > >       struct bpf_tramp_link *link_exiting;
> >
> > I think this is a typo here. It should be existing, no?
>
> yes, I was wondering about that as well ;-)
>
> jirka
>
> >
> > > > > -     int err =3D 0;
> > > > > +     int err =3D 0, num_lsm_progs =3D 0;
> > > > >       int cnt =3D 0, i;
> > > > >
> > > > >       kind =3D bpf_attach_type_to_tramp(link->link.prog);
> > > > > @@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct=
 bpf_tramp_link *link, struct bpf_tr
> > > > >                       continue;
> > > > >               /* prog already linked */
> > > > >               return -EBUSY;
> > > > > +
> > > > > +             if (link_exiting->link.prog->type =3D=3D BPF_PROG_T=
YPE_LSM)
> > > > > +                     num_lsm_progs++;
> > > >
> > > > this looks wrong, it's never reached.. seems like we should add sep=
arate
> > > > hlist_for_each_entry loop over trampoline's links for this check/in=
it of
> > > > num_lsm_progs ?
> > > >
> > > > jirka
> > >
> > > Good catch, I missed this during my rebase, after
> > > https://lore.kernel.org/bpf/20220510205923.3206889-2-kuifeng@fb.com/
> > > this condition is basically never reached. I will do a general loop
> > > over to count LSM programs and toggle the hook to true (and same for
> > > unlink).

So, there is something that is unclear about this code, i.e. what
happens when there is an error from bpf_trampoline_update fails and
the link and unlink seem to have different expectations:

* link seems to go back to the linked list and removes the trampoline
and restores the refcount:

[...]
 err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 if (err) {
    hlist_del_init(&link->tramp_hlist);
    tr->progs_cnt[kind]--;
  }
 return err;
}


* unlink does restore the side effect (i.e. it does not put the
removed trampoline back and increments the refcount).

hlist_del_init(&link->tramp_hlist);
tr->progs_cnt[kind]--;
return bpf_trampoline_update(tr, true /* lock_direct_mutex */);

However, I think I will make it simpler and enforce the invariant that
if an LSM program is attached, the hook is enabled and vice versa. How
about:

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index df9699bce372..4f31384b5637 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -511,11 +511,30 @@ static enum bpf_tramp_prog_type
bpf_attach_type_to_tramp(struct bpf_prog *prog)
        }
 }

+static void bpf_trampoline_toggle_lsm(struct bpf_trampoline *tr,
+                                     enum bpf_tramp_prog_type kind)
+{
+       struct bpf_tramp_link *link;
+       volatile bool found =3D false;
+
+       /* Loop through the links and if any LSM program is attached, ensur=
e
+        * that the hook is enabled.
+        */
+       hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
+               if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM) {
+                       found  =3D true;
+                       break;
+               }
+       }
+
+       bpf_lsm_toggle_hook(tr->func.addr, found);
+}
+
 static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
struct bpf_trampoline *tr)
 {
        enum bpf_tramp_prog_type kind;
        struct bpf_tramp_link *link_exiting;
-       int err =3D 0, num_lsm_progs =3D 0;
+       int err =3D 0;
        int cnt =3D 0, i;

        kind =3D bpf_attach_type_to_tramp(link->link.prog);
@@ -547,15 +566,14 @@ static int __bpf_trampoline_link_prog(struct
bpf_tramp_link *link, struct bpf_tr
                /* prog already linked */
                return -EBUSY;

-               if (link_exiting->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
-                       num_lsm_progs++;
        }

-       if (!num_lsm_progs && link->link.prog->type =3D=3D BPF_PROG_TYPE_LS=
M)
-               bpf_lsm_toggle_hook(tr->func.addr, true);
-
        hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
        tr->progs_cnt[kind]++;
+
+       if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
+               bpf_trampoline_toggle_lsm(tr, kind);
+
        err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex */);
        if (err) {
                hlist_del_init(&link->tramp_hlist);
@@ -578,7 +596,6 @@ static int __bpf_trampoline_unlink_prog(struct
bpf_tramp_link *link, struct bpf_
 {
        struct bpf_tramp_link *link_exiting;
        enum bpf_tramp_prog_type kind;
-       bool lsm_link_found =3D false;
        int err, num_lsm_progs =3D 0;

        kind =3D bpf_attach_type_to_tramp(link->link.prog);
@@ -595,18 +612,14 @@ static int __bpf_trampoline_unlink_prog(struct
bpf_tramp_link *link, struct bpf_
                                     tramp_hlist) {
                        if (link_exiting->link.prog->type =3D=3D BPF_PROG_T=
YPE_LSM)
                                num_lsm_progs++;
-
-                       if (link_exiting->link.prog =3D=3D link->link.prog)
-                               lsm_link_found =3D true;
                }
        }

        hlist_del_init(&link->tramp_hlist);
        tr->progs_cnt[kind]--;

-       if (lsm_link_found && num_lsm_progs =3D=3D 1)
-               bpf_lsm_toggle_hook(tr->func.addr, false);
-
+       if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
+               bpf_trampoline_toggle_lsm(tr, kind);
        return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 }


- KP

