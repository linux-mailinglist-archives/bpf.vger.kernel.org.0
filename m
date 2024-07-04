Return-Path: <bpf+bounces-33847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B7926D0B
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 03:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FBD1F23DA8
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 01:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA275C2FD;
	Thu,  4 Jul 2024 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDP7thGI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB88BFF
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720055754; cv=none; b=mnGaEDnK0rhLA3imT52CoXTQrHsV2lL4KHrwRkm/XghGsEcpi1RKjsj0LmKa3a1kQjeTHyOjahsGfHaGnaMESNUKIRxYna5Bn6CHpdhlDb8NGKAqT/FkKtPndS9zwPcTR3ZQm3Gxd2zN1TnapAOF4SeO1/nRCEyl14QEJ3+zuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720055754; c=relaxed/simple;
	bh=Tp5t82YbewD6JhTpD4Xg/CpOt9d7af3B9Twes1lFg3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kePmfeqPbIHl4ErPBRA1brgqUkv1tWV5OchGIPXedqLlk6gsYq1LTyTyGwqrXgZ/Z8CcH+TXPR8ZhmN2bvdvudG62jO7pN3LVph6r4XXWTV7WAEq/BUHpnt+ZjLtZnAZkqXDMZEzR+/+qsaEA5Hdku3GAS60qM6gPyQiNceFCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDP7thGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7074C4AF0C
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 01:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720055753;
	bh=Tp5t82YbewD6JhTpD4Xg/CpOt9d7af3B9Twes1lFg3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cDP7thGIpZhzdR5zStRC7oLZykBuPvRvpE17ajSzUybGtAtCXWAxAKxtrd4GnUV9a
	 wWWCmr2MaIaTEshJ0uRv1F1AT2kQp6Mya9dFbWG1hyaGgDriwgS44l1wRraxkN67LG
	 HOiSdkRYcV82ygJlkWOAVxulFzUpsaLcWoUeUuG0uUzePLgbjhZaAsC3bnfttEvaRC
	 YiOxEqDKdBlCAVZ+uBHcDIhggoaa1apTleDJaYJ2PfRtrdX2UAHj83LKi1vmHT7MDp
	 hfm1zZ4MdfBd/qa47WqfN1WFKTrQNb/XM4sU4trkDZpn2Ml66ghuZwVn4rkiiHwzFM
	 FfyQ0jUvFuKxw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so797181fa.2
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 18:15:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX74zZC22Ge4bo2IAZsC77fNkHxfO4K2Qad0oVHVcuuqF9NQvUxUiipBWhJf5IAOTCaQAss/0U89lZqJ7ygLIn5F4K3
X-Gm-Message-State: AOJu0YwfXmMrumG4ET5lGZfCienEYrgpzhyyN6ECPyXOeIdCOx3/XSRN
	rE7mMYIfGCsNiw+zlFqCS8t6jStATpAghuPsjbzsLBY3VQX0eBAzTyeZVQgSASxe77tKimQtUmF
	/jPQ1y78tl2AqdX/A5kzEp9IuLHiqkVJGIFL/
X-Google-Smtp-Source: AGHT+IHd4dimsdXcdqPqIt3sAcKbarU7PgERVOZ6GK2d4tK8gF6QggUNxqjvmF+lW/DBLJG2Q72n0jsNfw3n+ikM9iY=
X-Received: by 2002:ac2:5606:0:b0:52c:7f25:dbac with SMTP id
 2adb3069b0e04-52ea062e2f8mr49178e87.20.1720055752108; Wed, 03 Jul 2024
 18:15:52 -0700 (PDT)
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
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
 <90baed2b-b775-4eb7-9024-c15e65d8aee3@schaufler-ca.com> <CACYkzJ4R9mE+4-fYWb6UwVr9x3jw2PFp4Axt6ot1iWKngRv55A@mail.gmail.com>
In-Reply-To: <CACYkzJ4R9mE+4-fYWb6UwVr9x3jw2PFp4Axt6ot1iWKngRv55A@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 4 Jul 2024 03:15:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5D4Ft=gGwtvO-FT3Dxe4S5nSut+cM92aTqd==+iJ1OzA@mail.gmail.com>
Message-ID: <CACYkzJ5D4Ft=gGwtvO-FT3Dxe4S5nSut+cM92aTqd==+iJ1OzA@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 2:24=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
>
> On Thu, Jul 4, 2024 at 2:04=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> >
> > On 7/3/2024 4:08 PM, KP Singh wrote:
> > > On Thu, Jul 4, 2024 at 12:52=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > >> On Wed, Jul 3, 2024 at 6:22=E2=80=AFPM KP Singh <kpsingh@kernel.org>=
 wrote:
> > >>> On Wed, Jul 3, 2024 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > >>>> On Wed, Jul 3, 2024 at 12:55=E2=80=AFPM KP Singh <kpsingh@kernel.o=
rg> wrote:
> > >>>>> On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-moor=
e.com> wrote:
> > >>>>>> On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > >>>>>>> LSM hooks are currently invoked from a linked list as indirect =
calls
> > >>>>>>> which are invoked using retpolines as a mitigation for speculat=
ive
> > >>>>>>> attacks (Branch History / Target injection) and add extra overh=
ead which
> > >>>>>>> is especially bad in kernel hot paths:
> > >>>>> [...]
> > >>>>>
> > >>>>>> should fix the more obvious problems.  I'd like to know if you a=
re
> > >>>>>> aware of any others?  If not, the text above should be adjusted =
and
> > >>>>>> we should reconsider patch 5/5.  If there are other problems I'd
> > >>>>>> like to better understand them as there may be an independent
> > >>>>>> solution for those particular problems.
> > >>>>> We did have problems with some other hooks but I was unable to di=
g up
> > >>>>> specific examples though, it's been a while. More broadly speakin=
g, a
> > >>>>> default decision is still a decision. Whereas the intent from the=
 BPF
> > >>>>> LSM is not to make a default decision unless a BPF program is loa=
ded.
> > >>>>> I am quite worried about the holes this leaves open, subtle bugs
> > >>>>> (security or crashes) we have not caught yet and PATCH 5/5 engine=
ers away
> > >>>>>  the problem of the "default decision".
> > >>>> The inode/xattr problem you originally mentioned wasn't really roo=
ted
> > >>>> in a "bad" default return value, it was really an issue with how t=
he
> > >>>> LSM hook was structured due to some legacy design assumptions made
> > >>>> well before the initial stacking patches were merged.  That should=
 be
> > >>>> fixed now[1] and given that the inode/xattr set/remove hooks were
> > >>>> unique in this regard (individual LSMs were responsible for perfor=
ming
> > >>>> the capabilities checks) I don't expect this to be a general probl=
em.
> > >>>>
> > >>>> There were also some issues caused by the fact that we were defini=
ng
> > >>>> the default return value in multiple places and these values had g=
one
> > >>>> out of sync in a number of hooks.  We've also fixed this problem b=
y
> > >>>> only defining the default return value once for each hook, solving=
 all
> > >>>> of those problems.
> > >>> I don't see how this solves problems or prevents any future problem=
s
> > >>> with side-effects. I have always been uncomfortable with an extrane=
ous
> > >>> function being called with a side effect ever since we merged BPF L=
SM
> > >>> with default callback. We have found one bug due to this, not all t=
he
> > >>> bugs.
> > >> You've got to give me something more concrete than that.  If you can=
't
> > >> provide any concrete examples, start with providing a basic concept
> > >> with far more detail than just "side-effects".
> > >>
> > >>>> I'm not aware of any other existing problems relating to the LSM h=
ook
> > >>>> default values, if there are any, we need to fix them independent =
of
> > >>>> this patchset.  The LSM framework should function properly if the
> > >>>> "default" values are used.
> > >>> Patch 5 eliminates the possibilities of errors and subtle bugs all
> > >>> together. The problem with subtle bugs is, well, they are subtle, i=
f
> > >>> you and I knew of the bugs, we would fix all of them, but we don't.=
 I
> > >>> really feel we ought to eliminate the class of issues and not just
> > >>> whack-a-mole when we see the bugs.
> > >> Here's the thing, I don't really like patch 5/5.  To be honest, I
> > >> don't really like a lot of this patchset.  From my perspective, the
> > >> complexity of the code is likely going to mean more maintenance
> > >> headaches down the road, but Linus hath spoken so we're doing this
> > >> (although "this" is still a bit undefined as far as I'm concerned).
> > >> If you want me to merge patch 5/5 you've got to give me something re=
al
> > >> and convincing that can't be fixed by any other means.  My current
> > >> opinion is that you're trying to use a previously fixed bug to scare
> > >> and/or coerce the merging of some changes I don't really want to
> > >> merge.  If you want me to take patch 5/5, you've got to give me a
> > >> reason that is far more compelling that what you've written thus far=
.
> > > Paul, I am not scaring you, I am providing a solution that saves us
> > > from headaches with side-effects and bugs in the future. It's safer b=
y
> > > design.
> > >
> > > You say you have not reviewed it carefully, but you did ask me to mov=
e
> > > the function from the BPF LSM layer to an LSM API, and we had a bunch
> > > of discussion around naming in the subsequent revisions.
> > >
> > > https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moo=
re.com/
> > >
> > > My reasons are:
> > >
> > > 1. It's safer, no side effects, guaranteed to be not buggy. Neither
> > > you, nor me, can guarantee that a default value will be safe in the
> > > LSM layer. I request others (Casey, Kees) for their opinion here too.
> > > 2. Performance, no extra function call.
> >
> > I want to be very careful about the comments I make on this patch set.
> > I can't say that I trust any fix for the BPF LSM layer. My natural
> > inclination is to isolate the fix to the area that has the problem,
> > that is, BPF. I have a hard time accepting the notion that the implemen=
tation
> > will really fix all possible bugs in the future. The pace at which eBPF
> > is evolving gives me the heebee geebees when I think of it as a mechani=
sm
> > for implementing security modules.
> >
> > My biggest concern is that we may be trying too hard for perfection.
> > I see a situation where we're not moving forward because there are two
> > reasonable solutions and rather than running with either we're desperat=
ely
> > looking for a compelling reason to pick one over the other.
>
> I am fine with either, if you folks prefer security_toggle_hook to be
> in BPF only / limited to BPF. I can revert back to what we had in v9,
> the changes to the LSM layer are then very minimal.

Now if you folks really don't want any changes to the core LSM layer,
that too is doable, the patch below accomplishes that.

So, here's where we are at, while the LSM framework is comfortable
with saying that default values and empty callbacks are fine, that's
not what BPF LSM is comfortable doing. Your concerns around changes to
the LSM layer should be addressed by the propose patch below:

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

- KP

>
> - KP
>
> >
> > >
> > > If you still don't like it, it's your call, I would still like to kee=
p
> > > most of the logic local to the BPF LSM as proposed in
> > > https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moo=
re.com/
> > >
> > > - KP
> > >
> > >> --
> > >> paul-moore.com

