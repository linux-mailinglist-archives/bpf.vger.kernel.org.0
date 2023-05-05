Return-Path: <bpf+bounces-136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591326F88E4
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 20:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DC92810BF
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C62C8DB;
	Fri,  5 May 2023 18:47:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC76C12D
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 18:47:42 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FF4203E8
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 11:47:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24e25e2808fso1963972a91.0
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683312456; x=1685904456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TciyR7juwxjGC/htL5PTfWm5OISl0NVnck7a0zAsIT8=;
        b=0au1gkuGwAJUg/tFBIBbtgpI/2w8fXyRq/IZfcvHcv3t5mainJ/o+2Ls5QSbPNVtnb
         m1qwEgn+rxiiY05aqLnTwqW8fOYU6TJhzaHBZEQnyE/NNFwhqNj/vhvAYTGDhB6Jcoex
         1swU/ubSe2duWN130679KV+fPoFQnnXdLkYcr96Yukurp5viCl2A8gUDwrOD3bGVALvL
         vNb1eGOTLmrHy6HDFZrzrTTN0iJUBwJuaIV3phJI4xoRbSIYsTOCuCZqHXyzjy/qyeBN
         JaaK/oBGJ0tkpSQpsTdyfvTEqSHGMeAkKbDDQMrAuQFdTcS39dRiMvNau9oQtGeftU2a
         Zw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312456; x=1685904456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TciyR7juwxjGC/htL5PTfWm5OISl0NVnck7a0zAsIT8=;
        b=EtuCrwcaLOgVPz7SoL6/ZSVtP2mWgrboix6UcFzabF3vEz5bXH5JoGvq5r2Wx+U2MC
         v05RFAw3n6tozL1MpU81LOUmTXXVSj5cYt6+yLM1osFRFhTKg5YH7pquYDVui2X6ZvZu
         cb4fcINJJ8BImkXy7Voi9PKk9Wa6UTCqrACCW/VV7o1+eRGArkK9fpYUjj84ct1fuNoz
         BgqUpTkeK1cpEwdBfBnynK0a/pDPbiKLWn52NSzsfyYi71TFHUj5jdUWUbmx1lyfPD1w
         1s4nxNCnfe7e7O6yOZl219PGpnwi0kEmxX9MdZyPDK1oTLOHUxEYYQf/WI/TxEEwLOLU
         XQ8A==
X-Gm-Message-State: AC+VfDwHX58JxYQnncjdoeiM8ctOeLkmSuwxlomphTQHSmUmCcnvAFyA
	RZ8Bbj0Xb5HCn1gXjt5yjynVe/xbhCtp/q0gED32T+7JQgWKXMPcl2nVhQ==
X-Google-Smtp-Source: ACHHUZ7utIEcreENdSHaPbswG1gMpKqIUsm9lXXlGNnABKtKUqsfqXaIVW9WLaQuBkj67XrDx03Tc9wO65d1ohlSANA=
X-Received: by 2002:a17:90b:3807:b0:24d:d7fd:86c3 with SMTP id
 mq7-20020a17090b380700b0024dd7fd86c3mr2307511pjb.16.1683312456482; Fri, 05
 May 2023 11:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230505184550.1386802-1-sdf@google.com>
In-Reply-To: <20230505184550.1386802-1-sdf@google.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 5 May 2023 11:47:25 -0700
Message-ID: <CAKH8qBuDzThzDcN6WwyLmD75LSv0zrd-ZiwDMwVmJiQ82DxepQ@mail.gmail.com>
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

On Fri, May 5, 2023 at 11:45=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
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
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  kernel/bpf/cgroup.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index a06e118a9be5..c9d4b66e2c15 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1022,10 +1022,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp=
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
> @@ -1051,9 +1051,9 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>
>         for (atype =3D from_atype; atype <=3D to_atype; atype++) {
>                 if (effective_query) {
> -                       effective =3D rcu_dereference_protected(cgrp->bpf=
.effective[atype],
> -                                                             lockdep_is_=
held(&cgroup_mutex));
> -                       total_cnt +=3D bpf_prog_array_length(effective);
> +                       effective[atype] =3D rcu_dereference_protected(cg=
rp->bpf.effective[atype],
> +                                                                    lock=
dep_is_held(&cgroup_mutex));
> +                       total_cnt +=3D bpf_prog_array_length(effective[at=
ype]);
>                 } else {
>                         total_cnt +=3D prog_list_length(&cgrp->bpf.progs[=
atype]);
>                 }
> @@ -1076,10 +1076,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp,=
 const union bpf_attr *attr,
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
>                         struct hlist_head *progs;
>                         struct bpf_prog_list *pl;
> @@ -1118,11 +1116,23 @@ static int __cgroup_bpf_query(struct cgroup *cgrp=
, const union bpf_attr *attr,
>  static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *a=
ttr,
>                             union bpf_attr __user *uattr)
>  {
> +       __u32 __user *prog_attach_flags =3D u64_to_user_ptr(attr->query.p=
rog_attach_flags);
> +       bool effective_query =3D attr->query.query_flags & BPF_F_QUERY_EF=
FECTIVE;
> +       bool need_mutex =3D false;

Oops, this has to be true, but you get the idea...

>         int ret;
>
> -       mutex_lock(&cgroup_mutex);
> +       if (effective_query && !prog_attach_flags)
> +               need_mutex =3D false;
> +
> +       if (need_mutex)
> +               mutex_lock(&cgroup_mutex);
> +       else
> +               rcu_read_lock();
>         ret =3D __cgroup_bpf_query(cgrp, attr, uattr);
> -       mutex_unlock(&cgroup_mutex);
> +       if (need_mutex)
> +               mutex_unlock(&cgroup_mutex);
> +       else
> +               rcu_read_unlock();
>         return ret;
>  }
>
> --
> 2.40.1.521.gf1e218fcd8-goog
>

