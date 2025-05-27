Return-Path: <bpf+bounces-59024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F84EAC5C4B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300E94A6EFF
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A621420A;
	Tue, 27 May 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4ILUrCf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27CB213236
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381823; cv=none; b=V0FJK8Ftuw0i+orPFDSPOITb0ERnLcypdn1CtzgknAfrihwbpMpy+3lLEMjUMYjKYv6u2+ajd8Mx4/8QcFLmwBxomySkbvg+CrK5uU/gVVl1Wzgqw+AnMPwRA6d8tnPG7IEnf5+zk1l4O/tbrVINfBCT9suuqK1IalJ8b98tIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381823; c=relaxed/simple;
	bh=nLBa9wLLY3CwMDBe8hxCS2x3XzWfpJqtaVjsKBnNXxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNe11HRKmLs6TbnCEbfVdodFxqyduVRNJhghGECcjzrmjCm0gzs8sgVgC+foJb8wNEAWXDTRTNvq46o52Gy9IZeFIDV1bFUb85Q3w2mui0BHwSBwH73z6aMEPgJwOfhFQoypUvC5ieIegQODIP2sJN3A+Gv9AdMRXphWVuzN5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4ILUrCf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3081f72c271so2801102a91.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748381821; x=1748986621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt41j97WttI8BhAnS6UD8OYiC2n6guDH9qF3Y3EnT0g=;
        b=k4ILUrCfK9W3DiEZDgsdz7eUil7oF4MKTv8BdvcvC8Si4r3UAph4/lB7Mvwu/PxPIp
         vtLoCiulgEYYXuqipBevDsGdhOZSPhYqcX0/a7Zuw7v1iNwSzfr5Pw6Fa45CZMIaOPom
         A21vBrjbx8+Ct2C0Z21ZF8UAMSIWHNHSrvHqqv2TXfzsezk8ta74DHVjI65Q6H0oSAbs
         O69arpeoQ9nX0MFZFFI0v++WCpvdpnpsnsIeQzLIPrwTEBxbyD1lxTTF/yB/Vcn+UyjH
         TG1O7+H2UmuyKQih7Dnz986mqM+697N0s8C9GcAHlY7WeC1ts/7X6JoGjUbX35bnzzLE
         i6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748381821; x=1748986621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt41j97WttI8BhAnS6UD8OYiC2n6guDH9qF3Y3EnT0g=;
        b=eOrXKkUCy/NGEWD3wkgyS1tsoxDbI8/HRj5JJOTg9sMQHIYY3wr7NvI3bnPLiOUobk
         Gvzia9AbkZICdZQFx74VPWd8mu/PNOsxW21iAG4QqjcCpmlCayVJunSQbrz1TpcmK25w
         No+WXs6dtPbTPcC9ZlXQdV1m51BYZ8yx+ivklhrO6wpgc3tZeuO5zg56ILJcH18c0KUE
         4x2pH8zvQ7Xeuy2AYkE7UJ+iCNtsfh66y78pGE/nGK4qQinnGFAhLa+obXrWU4AF8Ioc
         r5Ien2da1nCK/SPXg0YX1wUGK2gkmM2zkFjNwI/q6xRAhagBKyei74hdyOmIlbwEeFZ3
         T9cg==
X-Gm-Message-State: AOJu0Yz5AbJLrYw2rh7N5qc5BBgG4SmeX1isZJCTLiXHzP0mTA8GZfNX
	Sgql6dX9ROh7Ajii8Jxi3WAf9YW9nJBMAVNL2B4ru5K78AFnQJ25lXm5y4HeMwGMJRgpvKOeyPt
	KodY3ugiH4kvG4UHxquLgafaUvyI+UBI=
X-Gm-Gg: ASbGncvB3x5cebDZZ9mPk/BtG06jCfB3G3pn4HE5gOyZJzvIJefivIBjIrMm7eKpcc5
	zGKd4o66aU3QgNCdbRJd/LWGrP6/1/Qzb6tswoHe5BnTI9Kc2Pb994ScxwOcwBi3OGPYoSM4GeL
	sCiP+7ZORcZj7SuOkkkxvwuG2ykzfx7nEw6cWwaLObNkKUCkzPQgsLBYM0Ofw=
X-Google-Smtp-Source: AGHT+IHLTk/wNPLoyP58VOzS+7TA1Iv7crdk847UbGnDFbVgiYFau1hBn1BqYDH/POUwQ9DuGdyUsETPDwdiV9sNbdg=
X-Received: by 2002:a17:90b:1809:b0:311:b5ac:6f6b with SMTP id
 98e67ed59e1d1-311b5ac713dmr5447600a91.9.1748381820856; Tue, 27 May 2025
 14:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517162720.4077882-1-yonghong.song@linux.dev>
 <20250517162731.4078451-1-yonghong.song@linux.dev> <CAEf4BzbnSKr9JrdO266cN1tdPDpQKOGRrxn+ZbSX7cM5jVQh2g@mail.gmail.com>
 <067aec4f-6847-4c86-9e93-1be8145b252a@linux.dev>
In-Reply-To: <067aec4f-6847-4c86-9e93-1be8145b252a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 May 2025 14:36:46 -0700
X-Gm-Features: AX0GCFs_RRR_lulkcNe78TNoxMzvJBdmEk9ElamChQfBPNc_NHSpDAk99B7-3oM
Message-ID: <CAEf4BzZi7frCiq_vWfXb=QtNvpv91kf=9CymXNJUxRiPW7fxFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Implement mprog API on top of
 existing cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 6:04=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 5/22/25 1:45 PM, Andrii Nakryiko wrote:
> > On Sat, May 17, 2025 at 9:27=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Current cgroup prog ordering is appending at attachment time. This is =
not
> >> ideal. In some cases, users want specific ordering at a particular cgr=
oup
> >> level. To address this, the existing mprog API seems an ideal solution=
 with
> >> supporting BPF_F_BEFORE and BPF_F_AFTER flags.
> >>
> >> But there are a few obstacles to directly use kernel mprog interface.
> >> Currently cgroup bpf progs already support prog attach/detach/replace
> >> and link-based attach/detach/replace. For example, in struct
> >> bpf_prog_array_item, the cgroup_storage field needs to be together
> >> with bpf prog. But the mprog API struct bpf_mprog_fp only has bpf_prog
> >> as the member, which makes it difficult to use kernel mprog interface.
> >>
> >> In another case, the current cgroup prog detach tries to use the
> >> same flag as in attach. This is different from mprog kernel interface
> >> which uses flags passed from user space.
> >>
> >> So to avoid modifying existing behavior, I made the following changes =
to
> >> support mprog API for cgroup progs:
> >>   - The support is for prog list at cgroup level. Cross-level prog lis=
t
> >>     (a.k.a. effective prog list) is not supported.
> >>   - Previously, BPF_F_PREORDER is supported only for prog attach, now
> >>     BPF_F_PREORDER is also supported by link-based attach.
> >>   - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID/BPF_F_LINK is suppor=
ted
> >>     similar to kernel mprog but with different implementation.
> >>   - For detach and replace, use the existing implementation.
> >>   - For attach, detach and replace, the revision for a particular prog
> >>     list, associated with a particular attach type, will be updated
> >>     by increasing count by 1.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   include/uapi/linux/bpf.h       |   7 ++
> >>   kernel/bpf/cgroup.c            | 195 +++++++++++++++++++++++++++++--=
--
> >>   kernel/bpf/syscall.c           |  43 +++++---
> >>   tools/include/uapi/linux/bpf.h |   7 ++
> >>   4 files changed, 214 insertions(+), 38 deletions(-)
> >>

[...]

> >> +
> >> +       if (link || id || id_or_fd) {
> > please, use "is_id" to make it obvious that this is bool, it's very
> > confusing to see "id || id_or_fd"
> >
> > same for is_link, please
>
> Okay, I am following mprog.c code like below:
>
> =3D=3D=3D=3D
> static int bpf_mprog_link(struct bpf_tuple *tuple,
>                            u32 id_or_fd, u32 flags,
>                            enum bpf_prog_type type)
> {
>          struct bpf_link *link =3D ERR_PTR(-EINVAL);
>          bool id =3D flags & BPF_F_ID;
>
>          if (id)
>                  link =3D bpf_link_by_id(id_or_fd);
>          else if (id_or_fd)
>                  link =3D bpf_link_get_from_fd(id_or_fd);
> =3D=3D=3D=3D
>
> But agree is_id/is_link is more clear.

yeah, existing code is also confusing :)


>
> >
> >> +               /* flags must have either BPF_F_BEFORE or BPF_F_AFTER =
*/
> >> +               if (!(flags & BPF_F_BEFORE) !=3D !!(flags & BPF_F_AFTE=
R))
> > either/or here means exclusive or inclusive?
> >
> > if it's inclusive: if (flags & (BPF_F_BEFORE | BPF_F_AFTER)) should be
> > enough to check that at least one of them is set
> >
> > if exclusive, below you use a different style of checking (which
> > arguably is easier to follow), so let's stay consistent
> >
> >
> > I got to say that my brain broke trying to reason about this pattern:
> >
> >     if (!(...) !=3D !!(...))

Note how you used singular ! in the left condition. Probably a typo,
but I wasn't sure if that was intentional.

> >
> > Way too many exclamations/negations, IMO... I'm not sure what sort of
> > condition we are expressing here?
>
> Sorry for confusion. What I mean is 'exclusive'. I guess I can do

It's fine to use a sort-of-standard pattern of !!(...) !=3D !!(...),
just make sure to use the right amount of !!

>
> bool is_before =3D flags & BPF_F_BEFORE;
> bool is_after =3D flags & BPF_F_AFTER;
> if (is_link || is_id || id_or_fd) {
>      if (is_before =3D=3D is_after)
>          return ERR_PTR(-EINVAL);
> } else if (!hist_empty(progs)) {
>      if (is_before && is_after)
>          return ERR_PTR(-EINVAL);
>      ...
> }
>
> >
> > pw-bot: cr
> >
> >> +                       return ERR_PTR(-EINVAL);
> >> +       } else if (!hlist_empty(progs)) {
> >> +               /* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER=
 */
> >> +               if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
> >> +                       return ERR_PTR(-EINVAL);
> > do I understand correctly that neither BEFORE or AFTER might be set,
> > in which case it must be BPF_F_REPLACE, is that right? Can it happen
> > that we have neither REPLACE nor BEFORE/AFTER? Asked that below as
> > well...
>
> I think 'neither REPLACE nor BEFORE/AFTER' is possible. In that case,
> the prog is appended to the prog list.
>
> The code path here should not have REPLACE. See the code
>
>          if (pl) {
>                  old_prog =3D pl->prog;
>          } else {
>                  pl =3D kmalloc(sizeof(*pl), GFP_KERNEL);
>                  if (!pl) {
>                          bpf_cgroup_storages_free(new_storage);
>                          return -ENOMEM;
>                  }
>
>                  err =3D insert_pl_to_hlist(pl, progs, prog ? : link->lin=
k.prog, flags, id_or_fd);
>                  if (err) {
>                          kfree(pl);
>                          bpf_cgroup_storages_free(new_storage);
>                          return err;
>                  }
>          }
>
> If REPLACE is in the flag and prog replacement is successful, 'pl'
> will not be null.
>

ok, thanks

> >
> >> +       }
> >> +
> >> +       if (link) {
> >> +               anchor_link =3D bpf_get_anchor_link(flags, id_or_fd, p=
rog->type);
> >> +               if (IS_ERR(anchor_link))
> >> +                       return ERR_PTR(PTR_ERR(anchor_link));
> >> +               anchor_prog =3D anchor_link->prog;
> >> +       } else if (id || id_or_fd) {
> >> +               anchor_prog =3D bpf_get_anchor_prog(flags, id_or_fd, p=
rog->type);
> >> +               if (IS_ERR(anchor_prog))
> >> +                       return ERR_PTR(PTR_ERR(anchor_prog));
> >> +       }
> >> +
> >> +       if (!anchor_prog) {
> >> +               /* if there is no anchor_prog, then BPF_F_PREORDER doe=
sn't matter
> >> +                * since either prepend or append to a combined list o=
f progs will
> >> +                * end up with correct result.
> >> +                */
> >> +               hlist_for_each_entry(pltmp, progs, node) {
> >> +                       if (flags & BPF_F_BEFORE)
> >> +                               return pltmp;
> >> +                       if (pltmp->node.next)
> >> +                               continue;
> >> +                       return pltmp;
> >> +               }
> >> +               return NULL;
> >> +       }
> >> +
> >> +       hlist_for_each_entry(pltmp, progs, node) {
> >> +               pltmp_prog =3D pltmp->link ? pltmp->link->link.prog : =
pltmp->prog;
> >> +               if (pltmp_prog !=3D anchor_prog)
> >> +                       continue;
> >> +               if (!!(pltmp->flags & BPF_F_PREORDER) !=3D preorder)
> >> +                       goto out;
> > hm... thinking about this a bit more, is it illegal to have the same
> > BPF program attached as PREORDER and POSTORDER? That seems legit to
> > me, do we artificially disallow this?
>
> Good question, in find_attach_entry(), we have
>
>          hlist_for_each_entry(pl, progs, node) {
>                  if (prog && pl->prog =3D=3D prog && prog !=3D replace_pr=
og)
>                          /* disallow attaching the same prog twice */
>                          return ERR_PTR(-EINVAL);
>                  if (link && pl->link =3D=3D link)
>                          /* disallow attaching the same link twice */
>                          return ERR_PTR(-EINVAL);
>          }
>
> Basically, two same progs are not allowed. Here we didn't check PREORDER =
flag.
> Should we relax this for this patch set?

So with BPF link-based attachment we already allow multiple same BPF
programs to be attached, regardless of PREORDER. I don't think we need
to make any relaxations for old-style program attachment. But your
mprog API is, effectively ignoring link stuff and checking for
uniqueness of the program (regardless of whether it came from link or
not), which is problematic, I think, no?

[...]

> >> @@ -640,7 +765,8 @@ static struct bpf_prog_list *find_attach_entry(str=
uct hlist_head *progs,
> >>   static int __cgroup_bpf_attach(struct cgroup *cgrp,
> >>                                 struct bpf_prog *prog, struct bpf_prog=
 *replace_prog,
> >>                                 struct bpf_cgroup_link *link,
> >> -                              enum bpf_attach_type type, u32 flags)
> >> +                              enum bpf_attach_type type, u32 flags, u=
32 id_or_fd,
> >> +                              u64 revision)
> >>   {
> >>          u32 saved_flags =3D (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_AL=
LOW_MULTI));
> >>          struct bpf_prog *old_prog =3D NULL;
> >> @@ -656,6 +782,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp=
,
> >>              ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI))=
)
> >>                  /* invalid combination */
> >>                  return -EINVAL;
> >> +       if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_=
AFTER)))
> > but can it be that neither is set?
>
> I would say it is possible. In that case, the new prog is appended to
> the end of prog list.

ok, makes sense

>
> >
> >> +               /* only either replace or insertion with before/after =
*/
> >> +               return -EINVAL;
> >>          if (link && (prog || replace_prog))
> >>                  /* only either link or prog/replace_prog can be speci=
fied */
> >>                  return -EINVAL;
> > [...]
>

