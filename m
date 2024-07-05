Return-Path: <bpf+bounces-33964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609F2928DCD
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 21:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18511284BE3
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44838171669;
	Fri,  5 Jul 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM4Dp8o1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F7171E54
	for <bpf@vger.kernel.org>; Fri,  5 Jul 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208072; cv=none; b=Z7BXLYHmXc+ary9bMcJDZrdIbqyA/9TGexIQlQqem/zNW9fd9cCOXekYBN2+lvGzWqqv9hB3CF7eEGvzYWvRtvqXc85y6jHMz2HObvN/MV2O7JFmOCV3cWhs6zOH1qhNXA0AXLFG2x2QZnj/6ezxdsnPToyjhPJUJALZ50I9KoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208072; c=relaxed/simple;
	bh=Jl/Ul6u9NBEzTxilrzAq+Pq2dawf3hYw6nAfqj4ST2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1aYVZ0kkViA9pnDLeaeXZ1h20fCD7HQiJi9OVEFQosOeiWLCKD5JbaR1bzghdrSZ9Sxp/resnl7sEMjjoRHse8427gcX/wTa7DG58QxjVsxl2iA4YZ9U+f7Sw54O3VDf7NRJhbXsBhNR9C7A4Q8z5HzGQ5iZ2bTOjSTqEKwZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM4Dp8o1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A133C4AF13
	for <bpf@vger.kernel.org>; Fri,  5 Jul 2024 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720208072;
	bh=Jl/Ul6u9NBEzTxilrzAq+Pq2dawf3hYw6nAfqj4ST2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AM4Dp8o1IOxl8pK8hxU0MUt1rIz4WsYomoc2A2cPZ6PQfu6vZB01qgfTry3/al4vZ
	 ++z8modwBFbclHJmpIkAWgocKKVDctxB0gV+bjuGnfje5Hgnu9X8+Aek4oiTcJjlBK
	 Myoa/W+oE8sYOtuvTQ3quneqcIDKiXQ1QROUTzMlTNgdj++SZe5uX407F8co8xvkq6
	 4SdkM2pimPpraLpbSX4a0Y4NMLxEC6NI2YyHbh/IviLMSk6An6QcHMV8NoCLYF39N5
	 gmUQcs4jD7anq5bWX60OUPMbG2M5YAh3qt/SfrKbYUaNRnBxRZwaG+vr5IAlcjHm+n
	 o6R6zMcflGI0Q==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77d876273dso47906566b.0
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 12:34:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUE8dE2WIuVcYEeLms65S5CFFtWwH9ocdNPRgx7FMzUgDE3D0dsp2cPzc0cJ6fOip+7T9m0iUPVToRQX5zB0hnzT5Ez
X-Gm-Message-State: AOJu0Yw54G8Uzd69+abBNgm6b5k1tyEPiV9XCBs9V3ETRAkUIvvUc3Nh
	B2Tocnv2uxYqPGNaiJ0O8bNW5lr8h96sDctyo2GPwcs/OpkMHNYP8jgoFOPCjIo8apvOXAAu1T5
	f5r7Wou2mZPo3ku1z2YdffADPN3CW+300Ts3C
X-Google-Smtp-Source: AGHT+IHtiVHcAY9C/xkpmbteQ+AY7LBT37paLc1T5H6ELMbqwbW26j/EuFJyZS9M/QM4ql7C6C80XkxQdb9fAcb3PL0=
X-Received: by 2002:a05:6402:35c9:b0:58b:e192:3635 with SMTP id
 4fb4d7f45d1cf-58e59e32cd3mr6100250a12.11.1720208071076; Fri, 05 Jul 2024
 12:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
 <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
 <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
 <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com> <CAHC9VhRA0hX-Nx20CK+yV276d7nooMmR+Q5OBNOy5fces4q9Bw@mail.gmail.com>
In-Reply-To: <CAHC9VhRA0hX-Nx20CK+yV276d7nooMmR+Q5OBNOy5fces4q9Bw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 5 Jul 2024 21:34:20 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com>
Message-ID: <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 8:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Jul 3, 2024 at 7:08=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> > On Thu, Jul 4, 2024 at 12:52=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Wed, Jul 3, 2024 at 6:22=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> > > > On Wed, Jul 3, 2024 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > On Wed, Jul 3, 2024 at 12:55=E2=80=AFPM KP Singh <kpsingh@kernel.=
org> wrote:
> > > > > > On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > > > > > On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > > > > > > >
> > > > > > > > LSM hooks are currently invoked from a linked list as indir=
ect calls
> > > > > > > > which are invoked using retpolines as a mitigation for spec=
ulative
> > > > > > > > attacks (Branch History / Target injection) and add extra o=
verhead which
> > > > > > > > is especially bad in kernel hot paths:
>
> ...
>
> > > > > I'm not aware of any other existing problems relating to the LSM =
hook
> > > > > default values, if there are any, we need to fix them independent=
 of
> > > > > this patchset.  The LSM framework should function properly if the
> > > > > "default" values are used.
> > > >
> > > > Patch 5 eliminates the possibilities of errors and subtle bugs all
> > > > together. The problem with subtle bugs is, well, they are subtle, i=
f
> > > > you and I knew of the bugs, we would fix all of them, but we don't.=
 I
> > > > really feel we ought to eliminate the class of issues and not just
> > > > whack-a-mole when we see the bugs.
> > >
> > > Here's the thing, I don't really like patch 5/5.  To be honest, I
> > > don't really like a lot of this patchset.  From my perspective, the
> > > complexity of the code is likely going to mean more maintenance
> > > headaches down the road, but Linus hath spoken so we're doing this
> > > (although "this" is still a bit undefined as far as I'm concerned).
> > > If you want me to merge patch 5/5 you've got to give me something rea=
l
> > > and convincing that can't be fixed by any other means.  My current
> > > opinion is that you're trying to use a previously fixed bug to scare
> > > and/or coerce the merging of some changes I don't really want to
> > > merge.  If you want me to take patch 5/5, you've got to give me a
> > > reason that is far more compelling that what you've written thus far.
> >
> > Paul, I am not scaring you, I am providing a solution that saves us
> > from headaches with side-effects and bugs in the future. It's safer by
> > design.
>
> Perhaps I wasn't clear enough in my previous emails; instead of trying
> to convince me that your solution is literally the best possible thing
> to ever touch the kernel, convince me that there is a problem we need
> to fix.  Right now, I'm not convinced there is a bug that requires all
> of the extra code in patch 5/5 (all of which have the potential to
> introduce new bugs).  As mentioned previously, the bugs that typically
> have been used as examples of unwanted side effects with the LSM hooks
> have been resolved, both in the specific and general case.  If you
> want me to add more code/functionality to fix a bug, you must first
> demonstrate the bug exists and the risk is real; you have not done
> that as far as I'm concerned.
>
> > You say you have not reviewed it carefully ...
>
> That may have been true of previous versions of this patchset, but I
> did not say that about this current patchset.
>
> > ... but you did ask me to move
> > the function from the BPF LSM layer to an LSM API, and we had a bunch
> > of discussion around naming in the subsequent revisions.
> >
> > https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moore=
.com/
>
> That discussion predates commit 61df7b828204 ("lsm: fixup the inode
> xattr capability handling") which is currently in the lsm/dev branch,
> marked for stable, and will go up to Linus during the upcoming merge
> window.
>
> > My reasons are:
> >
> > 1. It's safer, no side effects, guaranteed to be not buggy. Neither
> > you, nor me, can guarantee that a default value will be safe in the
> > LSM layer.
>
> In the first sentence above you "guarantee" that your code is not
> buggy and then follow that up with a second sentence discussing how no
> one can guarantee source code safety.  Regardless of whatever point
> you were trying to make here, I maintain that *all* patches have the
> potential for bugs, even those that are attempting to fix bugs.  WithD
> that in mind, if you want me to merge more code to fix a bug (class),
> a bug that I've mentioned several times now that I believe we've
> already fixed, you first MUST convince me that the bug (class) still
> exists.  You have not done that.
>

Paul, I am talking about eliminating a class of bugs, but you don't
seem to get the point and you are fixated on the very instance of this
bug class.

> > 2. Performance, no extra function call.
>
> Convince me the bug still exists first and then we can discuss the
> merits of whatever solutions are proposed.

This is independent of the bug!

The extra function calls have performance overhead and as the BPF LSM
maintainer I am not okay with these extraneous calls when I have a
clear way of solving it.

As I said, If you don't want to modify the core LSM layer, it's okay,
I still want to go with changes local to the BPF LSM, If you really
don't agree with the changes local to the BPF LSM, we can have it go
via the BPF tree and seek Linus' help to resolve the conflict.

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..5a2ab1067095 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -29,6 +29,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,

 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
 bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
+void bpf_lsm_toggle_hook(void *addr, bool value);

 static inline struct bpf_storage_blob *bpf_inode(
        const struct inode *inode)
@@ -52,6 +53,10 @@ static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
        return false;
 }

+static inline void bpf_lsm_toggle_hook(void *addr, bool value)
+{
+}
+
 static inline bool bpf_lsm_is_trusted(const struct bpf_prog *prog)
 {
        return false;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f8302a5ca400..bc59025b3d46 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -523,6 +523,22 @@ static enum bpf_tramp_prog_type
bpf_attach_type_to_tramp(struct bpf_prog *prog)
        }
 }

+static void bpf_trampoline_toggle_lsm(struct bpf_trampoline *tr,
+                                     enum bpf_tramp_prog_type kind)
+{
+       struct bpf_tramp_link *link;
+       bool found =3D false;
+
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
@@ -562,6 +578,10 @@ static int __bpf_trampoline_link_prog(struct
bpf_tramp_link *link, struct bpf_tr

        hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
        tr->progs_cnt[kind]++;
+
+       if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
+               bpf_trampoline_toggle_lsm(tr, kind);
+
        err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex */);
        if (err) {
                hlist_del_init(&link->tramp_hlist);
@@ -595,6 +615,10 @@ static int __bpf_trampoline_unlink_prog(struct
bpf_tramp_link *link, struct bpf_
        }
        hlist_del_init(&link->tramp_hlist);
        tr->progs_cnt[kind]--;
+
+       if (link->link.prog->type =3D=3D BPF_PROG_TYPE_LSM)
+               bpf_trampoline_toggle_lsm(tr, kind);
+
        return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 }

diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 57b9ffd53c98..9ca3db6d2b07 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -16,6 +16,29 @@ static struct security_hook_list bpf_lsm_hooks[]
__ro_after_init =3D {
        LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };

+void bpf_lsm_toggle_hook(void *addr, bool enable)
+{
+       struct lsm_static_call *scalls;
+       struct security_hook_list *h;
+       int i, j;
+
+       for (i =3D 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
+               h =3D &bpf_lsm_hooks[i];
+               if (h->hook.lsm_func_addr !=3D addr)
+                       continue;
+
+               for (j =3D 0; j < MAX_LSM_COUNT; j++) {
+                       scalls =3D &h->scalls[j];
+                       if (scalls->hl !=3D &bpf_lsm_hooks[i])
+                               continue;
+                       if (enable)
+                               static_branch_enable(scalls->active);
+                       else
+                               static_branch_disable(scalls->active);
+               }
+       }
+}
+
 static const struct lsm_id bpf_lsmid =3D {
        .name =3D "bpf",
        .id =3D LSM_ID_BPF,
@@ -23,8 +46,14 @@ static const struct lsm_id bpf_lsmid =3D {

 static int __init bpf_lsm_init(void)
 {
+       int i;
+
        security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
                           &bpf_lsmid);
+
+       for (i =3D 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++)
+               bpf_lsm_toggle_hook(bpf_lsm_hooks[i].hook.lsm_func_addr, fa=
lse);
+
        pr_info("LSM support for eBPF active\n");
        return 0;
 }



>
> --
> paul-moore.com

