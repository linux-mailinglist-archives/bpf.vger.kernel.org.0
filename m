Return-Path: <bpf+bounces-352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8596FF6A5
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD1D1C20FDA
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BA546A3;
	Thu, 11 May 2023 16:00:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D938469E
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 16:00:09 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741DB6188
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 09:00:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24de3a8bfcfso8290776a91.1
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683820805; x=1686412805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dobW9Z7RORQp9gnWv+e9JXcgTmjHiwqvGBQaSlbLitI=;
        b=CohC9LBG9PPuTFMiApaO0NTjOk0n5Rjo1hy4G6Vcs3U3jqJlTbx33dJW184ZV9lXdb
         aYy3Kc1bcDxLx0D2bYgMk9ON4hKvmIUSHzXnVh/xzlr2AjlUzSG+tZxHp8XI2cfblh+b
         nxTK7QMJVcQ8uPaDx+noOufyYngj/9FESp4jj0OfvwaLl3qKKajEJsb0s+AOuYA1LNEU
         7cBTJ5tiuIcunDLlVmNsH8pTblwtmGwFBehXzt4Jkj2TGk8QakoYoCX+IBk6rbPdAaxY
         b2M3AKpEgsGlw7Vwdcpx80Mfhbt+g+OsRtcoHwvBx/rAY6lg2Yh7Y5KUPmnpJ4WFxEHP
         X1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683820805; x=1686412805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dobW9Z7RORQp9gnWv+e9JXcgTmjHiwqvGBQaSlbLitI=;
        b=BQV0IcEc1bKLV1lqpI0Af+jdUE2URlV+fx8O8NSjGt3duHLzGNgRO6Wr+gadyz0Dg/
         MruBTSMi0hgPTP1EAjqJacNRqyNqPEWK6HmFjlf477ddMeOpdr202CqGZW7GbIOt0lbr
         7+IWoJAh2oqMnIjNZniwJrp8vUkJOxRJhsQ2WkiQkHERAPhURlpzoTlkbGcO2JtHtDi1
         Ho0q3QFdZkjVnUdqtKI+HGrvUVAkKM+bo1hnBBNx8jE4e7gj7pgtb7iDa8KBaWQw9HcM
         EPtxz9YeO9qXKWQXp+MisM4H6aQE6L3w4R2sVdFoJefJLymeXuoelzA7IJBiMaBQ2lhP
         LjPQ==
X-Gm-Message-State: AC+VfDxeobTIBDqQZgNTgsvLlxjg6bIQ6eKxcDQHXInzoSD9Kz9SKwiZ
	YwzLwubPcMKlGehrrLQZYZT6mIg8OoWuy4JLthlis0zjVu842opnwQq9SNX9
X-Google-Smtp-Source: ACHHUZ4YYDdR8DV+0ureIgPI8JDWFmSPqD94Ehy9Ylt/f6ijp95czvecX82XTSHdensbp6AVjx5OM9x85FHhc6a3eeY=
X-Received: by 2002:a17:90b:a54:b0:246:681c:71fd with SMTP id
 gw20-20020a17090b0a5400b00246681c71fdmr22031416pjb.6.1683820805356; Thu, 11
 May 2023 09:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511155740.902548-1-sdf@google.com>
In-Reply-To: <20230511155740.902548-1-sdf@google.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 11 May 2023 08:59:51 -0700
Message-ID: <CAKH8qBv_phmpvNsO02DYQXmAWD5nYRCW98BnctYzDhBDRdc4sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] RFC: bpf: query effective progs without cgroup_mutex
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 11, 2023 at 8:57=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> We're observing some stalls on the heavily loaded machines
> in the cgroup_bpf_prog_query path. This is likely due to
> being blocked on cgroup_mutex.
>
> IIUC, the cgroup_mutex is there mostly to protect the non-effective
> fields (cgrp->bpf.progs) which might be changed by the update path.
> For the BPF_F_QUERY_EFFECTIVE case, all we need is to rcu_dereference
> a bunch of pointers (and keep them around for consistency), so
> let's do it.
>
> Sending out as an RFC because it looks a bit ugly. It would also
> be nice to handle non-effective case locklessly as well, but it
> might require a larger rework.

Oops, please ignore this one. Somehow got into my unrelated sockopt series.=
.

> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/bpf-cgroup-defs.h |  2 +-
>  include/linux/bpf-cgroup.h      |  1 +
>  kernel/bpf/cgroup.c             | 80 +++++++++++++++++----------------
>  3 files changed, 44 insertions(+), 39 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-d=
efs.h
> index 7b121bd780eb..df0b8faa1a17 100644
> --- a/include/linux/bpf-cgroup-defs.h
> +++ b/include/linux/bpf-cgroup-defs.h
> @@ -56,7 +56,7 @@ struct cgroup_bpf {
>          * have either zero or one element
>          * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_=
PROGS
>          */
> -       struct hlist_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
> +       struct hlist_head __rcu progs[MAX_CGROUP_BPF_ATTACH_TYPE];
>         u8 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
>
>         /* list of cgroup shared storages */
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 57e9e109257e..555e9cbb3a05 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -106,6 +106,7 @@ struct bpf_prog_list {
>         struct bpf_prog *prog;
>         struct bpf_cgroup_link *link;
>         struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
> +       struct rcu_head rcu;
>  };
>
>  int cgroup_bpf_inherit(struct cgroup *cgrp);
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index a06e118a9be5..92a1b33dcc06 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -285,12 +285,15 @@ static void cgroup_bpf_release(struct work_struct *=
work)
>         mutex_lock(&cgroup_mutex);
>
>         for (atype =3D 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
> -               struct hlist_head *progs =3D &cgrp->bpf.progs[atype];
> +               struct hlist_head *progs;
>                 struct bpf_prog_list *pl;
>                 struct hlist_node *pltmp;
>
> +               progs =3D rcu_dereference_protected(&cgrp->bpf.progs[atyp=
e],
> +                                                 lockdep_is_held(&cgroup=
_mutex));
> +
>                 hlist_for_each_entry_safe(pl, pltmp, progs, node) {
> -                       hlist_del(&pl->node);
> +                       hlist_del_rcu(&pl->node);
>                         if (pl->prog) {
>                                 if (pl->prog->expected_attach_type =3D=3D=
 BPF_LSM_CGROUP)
>                                         bpf_trampoline_unlink_cgroup_shim=
(pl->prog);
> @@ -301,7 +304,7 @@ static void cgroup_bpf_release(struct work_struct *wo=
rk)
>                                         bpf_trampoline_unlink_cgroup_shim=
(pl->link->link.prog);
>                                 bpf_cgroup_link_auto_detach(pl->link);
>                         }
> -                       kfree(pl);
> +                       kfree_rcu(pl, rcu);
>                         static_branch_dec(&cgroup_bpf_enabled_key[atype])=
;
>                 }
>                 old_array =3D rcu_dereference_protected(
> @@ -352,12 +355,12 @@ static struct bpf_prog *prog_list_prog(struct bpf_p=
rog_list *pl)
>  /* count number of elements in the list.
>   * it's slow but the list cannot be long
>   */
> -static u32 prog_list_length(struct hlist_head *head)
> +static u32 prog_list_length(struct hlist_head __rcu *head)
>  {
>         struct bpf_prog_list *pl;
>         u32 cnt =3D 0;
>
> -       hlist_for_each_entry(pl, head, node) {
> +       hlist_for_each_entry_rcu(pl, head, node) {
>                 if (!prog_list_prog(pl))
>                         continue;
>                 cnt++;
> @@ -553,7 +556,7 @@ static int update_effective_progs(struct cgroup *cgrp=
,
>
>  #define BPF_CGROUP_MAX_PROGS 64
>
> -static struct bpf_prog_list *find_attach_entry(struct hlist_head *progs,
> +static struct bpf_prog_list *find_attach_entry(struct hlist_head __rcu *=
progs,
>                                                struct bpf_prog *prog,
>                                                struct bpf_cgroup_link *li=
nk,
>                                                struct bpf_prog *replace_p=
rog,
> @@ -565,10 +568,10 @@ static struct bpf_prog_list *find_attach_entry(stru=
ct hlist_head *progs,
>         if (!allow_multi) {
>                 if (hlist_empty(progs))
>                         return NULL;
> -               return hlist_entry(progs->first, typeof(*pl), node);
> +               return hlist_entry(rcu_dereference_raw(progs)->first, typ=
eof(*pl), node);
>         }
>
> -       hlist_for_each_entry(pl, progs, node) {
> +       hlist_for_each_entry_rcu(pl, progs, node) {
>                 if (prog && pl->prog =3D=3D prog && prog !=3D replace_pro=
g)
>                         /* disallow attaching the same prog twice */
>                         return ERR_PTR(-EINVAL);
> @@ -579,7 +582,7 @@ static struct bpf_prog_list *find_attach_entry(struct=
 hlist_head *progs,
>
>         /* direct prog multi-attach w/ replacement case */
>         if (replace_prog) {
> -               hlist_for_each_entry(pl, progs, node) {
> +               hlist_for_each_entry_rcu(pl, progs, node) {
>                         if (pl->prog =3D=3D replace_prog)
>                                 /* a match found */
>                                 return pl;
> @@ -615,8 +618,8 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>         struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYP=
E] =3D {};
>         struct bpf_prog *new_prog =3D prog ? : link->link.prog;
>         enum cgroup_bpf_attach_type atype;
> +       struct hlist_head __rcu *progs;
>         struct bpf_prog_list *pl;
> -       struct hlist_head *progs;
>         int err;
>
>         if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI=
)) ||
> @@ -658,6 +661,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>                                       prog ? : link->link.prog, cgrp))
>                 return -ENOMEM;
>
> +       WRITE_ONCE(cgrp->bpf.flags[atype], saved_flags);
>         if (pl) {
>                 old_prog =3D pl->prog;
>         } else {
> @@ -669,12 +673,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>                         return -ENOMEM;
>                 }
>                 if (hlist_empty(progs))
> -                       hlist_add_head(&pl->node, progs);
> +                       hlist_add_head_rcu(&pl->node, progs);
>                 else
> -                       hlist_for_each(last, progs) {
> +                       __hlist_for_each_rcu(last, progs) {
>                                 if (last->next)
>                                         continue;
> -                               hlist_add_behind(&pl->node, last);
> +                               hlist_add_behind_rcu(&pl->node, last);
>                                 break;
>                         }
>         }
> @@ -682,7 +686,6 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>         pl->prog =3D prog;
>         pl->link =3D link;
>         bpf_cgroup_storages_assign(pl->storage, storage);
> -       cgrp->bpf.flags[atype] =3D saved_flags;
>
>         if (type =3D=3D BPF_LSM_CGROUP) {
>                 err =3D bpf_trampoline_link_cgroup_shim(new_prog, atype);
> @@ -796,7 +799,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>         enum cgroup_bpf_attach_type atype;
>         struct bpf_prog *old_prog;
>         struct bpf_prog_list *pl;
> -       struct hlist_head *progs;
> +       struct hlist_head __rcu *progs;
>         bool found =3D false;
>
>         atype =3D bpf_cgroup_atype_find(link->type, new_prog->aux->attach=
_btf_id);
> @@ -808,7 +811,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>         if (link->link.prog->type !=3D new_prog->type)
>                 return -EINVAL;
>
> -       hlist_for_each_entry(pl, progs, node) {
> +       hlist_for_each_entry_rcu(pl, progs, node) {
>                 if (pl->link =3D=3D link) {
>                         found =3D true;
>                         break;
> @@ -847,7 +850,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, =
struct bpf_prog *new_prog,
>         return ret;
>  }
>
> -static struct bpf_prog_list *find_detach_entry(struct hlist_head *progs,
> +static struct bpf_prog_list *find_detach_entry(struct hlist_head __rcu *=
progs,
>                                                struct bpf_prog *prog,
>                                                struct bpf_cgroup_link *li=
nk,
>                                                bool allow_multi)
> @@ -862,7 +865,7 @@ static struct bpf_prog_list *find_detach_entry(struct=
 hlist_head *progs,
>                 /* to maintain backward compatibility NONE and OVERRIDE c=
groups
>                  * allow detaching with invalid FD (prog=3D=3DNULL) in le=
gacy mode
>                  */
> -               return hlist_entry(progs->first, typeof(*pl), node);
> +               return hlist_entry(rcu_dereference_raw(progs)->first, typ=
eof(*pl), node);
>         }
>
>         if (!prog && !link)
> @@ -872,7 +875,7 @@ static struct bpf_prog_list *find_detach_entry(struct=
 hlist_head *progs,
>                 return ERR_PTR(-EINVAL);
>
>         /* find the prog or link and detach it */
> -       hlist_for_each_entry(pl, progs, node) {
> +       hlist_for_each_entry_rcu(pl, progs, node) {
>                 if (pl->prog =3D=3D prog && pl->link =3D=3D link)
>                         return pl;
>         }
> @@ -894,9 +897,9 @@ static void purge_effective_progs(struct cgroup *cgrp=
, struct bpf_prog *prog,
>                                   enum cgroup_bpf_attach_type atype)
>  {
>         struct cgroup_subsys_state *css;
> +       struct hlist_head __rcu *head;
>         struct bpf_prog_array *progs;
>         struct bpf_prog_list *pl;
> -       struct hlist_head *head;
>         struct cgroup *cg;
>         int pos;
>
> @@ -913,7 +916,7 @@ static void purge_effective_progs(struct cgroup *cgrp=
, struct bpf_prog *prog,
>                                 continue;
>
>                         head =3D &cg->bpf.progs[atype];
> -                       hlist_for_each_entry(pl, head, node) {
> +                       hlist_for_each_entry_rcu(pl, head, node) {
>                                 if (!prog_list_prog(pl))
>                                         continue;
>                                 if (pl->prog =3D=3D prog && pl->link =3D=
=3D link)
> @@ -950,9 +953,9 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, s=
truct bpf_prog *prog,
>                                struct bpf_cgroup_link *link, enum bpf_att=
ach_type type)
>  {
>         enum cgroup_bpf_attach_type atype;
> +       struct hlist_head __rcu *progs;
>         struct bpf_prog *old_prog;
>         struct bpf_prog_list *pl;
> -       struct hlist_head *progs;
>         u32 attach_btf_id =3D 0;
>         u32 flags;
>
> @@ -989,12 +992,12 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp,=
 struct bpf_prog *prog,
>         }
>
>         /* now can actually delete it from this cgroup list */
> -       hlist_del(&pl->node);
> +       hlist_del_rcu(&pl->node);
>
>         kfree(pl);
>         if (hlist_empty(progs))
>                 /* last program was detached, reset flags to zero */
> -               cgrp->bpf.flags[atype] =3D 0;
> +               WRITE_ONCE(cgrp->bpf.flags[atype], 0);
>         if (old_prog) {
>                 if (type =3D=3D BPF_LSM_CGROUP)
>                         bpf_trampoline_unlink_cgroup_shim(old_prog);
> @@ -1022,10 +1025,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp=
, const union bpf_attr *attr,
>         __u32 __user *prog_attach_flags =3D u64_to_user_ptr(attr->query.p=
rog_attach_flags);
>         bool effective_query =3D attr->query.query_flags & BPF_F_QUERY_EF=
FECTIVE;
>         __u32 __user *prog_ids =3D u64_to_user_ptr(attr->query.prog_ids);
> +       struct bpf_prog_array *effective[MAX_CGROUP_BPF_ATTACH_TYPE];
>         enum bpf_attach_type type =3D attr->query.attach_type;
>         enum cgroup_bpf_attach_type from_atype, to_atype;
>         enum cgroup_bpf_attach_type atype;
> -       struct bpf_prog_array *effective;
>         int cnt, ret =3D 0, i;
>         int total_cnt =3D 0;
>         u32 flags;
> @@ -1046,14 +1049,15 @@ static int __cgroup_bpf_query(struct cgroup *cgrp=
, const union bpf_attr *attr,
>                 if (from_atype < 0)
>                         return -EINVAL;
>                 to_atype =3D from_atype;
> -               flags =3D cgrp->bpf.flags[from_atype];
> +               flags =3D READ_ONCE(cgrp->bpf.flags[from_atype]);
>         }
>
>         for (atype =3D from_atype; atype <=3D to_atype; atype++) {
>                 if (effective_query) {
> -                       effective =3D rcu_dereference_protected(cgrp->bpf=
.effective[atype],
> -                                                             lockdep_is_=
held(&cgroup_mutex));
> -                       total_cnt +=3D bpf_prog_array_length(effective);
> +                       effective[atype] =3D rcu_dereference_protected(
> +                                               cgrp->bpf.effective[atype=
],
> +                                               lockdep_is_held(&cgroup_m=
utex));
> +                       total_cnt +=3D bpf_prog_array_length(effective[at=
ype]);
>                 } else {
>                         total_cnt +=3D prog_list_length(&cgrp->bpf.progs[=
atype]);
>                 }
> @@ -1076,12 +1080,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp=
, const union bpf_attr *attr,
>
>         for (atype =3D from_atype; atype <=3D to_atype && total_cnt; atyp=
e++) {
>                 if (effective_query) {
> -                       effective =3D rcu_dereference_protected(cgrp->bpf=
.effective[atype],
> -                                                             lockdep_is_=
held(&cgroup_mutex));
> -                       cnt =3D min_t(int, bpf_prog_array_length(effectiv=
e), total_cnt);
> -                       ret =3D bpf_prog_array_copy_to_user(effective, pr=
og_ids, cnt);
> +                       cnt =3D min_t(int, bpf_prog_array_length(effectiv=
e[atype]), total_cnt);
> +                       ret =3D bpf_prog_array_copy_to_user(effective[aty=
pe], prog_ids, cnt);
>                 } else {
> -                       struct hlist_head *progs;
> +                       struct hlist_head __rcu *progs;
>                         struct bpf_prog_list *pl;
>                         struct bpf_prog *prog;
>                         u32 id;
> @@ -1089,7 +1091,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>                         progs =3D &cgrp->bpf.progs[atype];
>                         cnt =3D min_t(int, prog_list_length(progs), total=
_cnt);
>                         i =3D 0;
> -                       hlist_for_each_entry(pl, progs, node) {
> +                       hlist_for_each_entry_rcu(pl, progs, node) {
>                                 prog =3D prog_list_prog(pl);
>                                 id =3D prog->aux->id;
>                                 if (copy_to_user(prog_ids + i, &id, sizeo=
f(id)))
> @@ -1099,7 +1101,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>                         }
>
>                         if (prog_attach_flags) {
> -                               flags =3D cgrp->bpf.flags[atype];
> +                               flags =3D READ_ONCE(cgrp->bpf.flags[atype=
]);
>
>                                 for (i =3D 0; i < cnt; i++)
>                                         if (copy_to_user(prog_attach_flag=
s + i,
> @@ -1112,6 +1114,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>                 prog_ids +=3D cnt;
>                 total_cnt -=3D cnt;
>         }
> +       if (total_cnt !=3D 0)
> +               return -EAGAIN; /* raced with the detach */
>         return ret;
>  }
>
> @@ -1120,9 +1124,9 @@ static int cgroup_bpf_query(struct cgroup *cgrp, co=
nst union bpf_attr *attr,
>  {
>         int ret;
>
> -       mutex_lock(&cgroup_mutex);
> +       rcu_read_lock();
>         ret =3D __cgroup_bpf_query(cgrp, attr, uattr);
> -       mutex_unlock(&cgroup_mutex);
> +       rcu_read_unlock();
>         return ret;
>  }
>
> --
> 2.40.1.521.gf1e218fcd8-goog
>

