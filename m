Return-Path: <bpf+bounces-39761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D513F9770CB
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547CF1F2A7E3
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 18:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6C31C2320;
	Thu, 12 Sep 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l659o6AG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF513E41A
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165507; cv=none; b=JeIdJj4lifJOrkbrnJPeKcsucn2vYutrgqjsDUVPe50fXbbNuosOGeGNFAjXRNxT6lJbz8rLIqOXpcCw337R5XtyOrMZGbsodQohw67SUxmKCj6KcdqEHFgKJpn0Jd8h+ypt0UqCy3jlRUkwnm0gKtyQwYqhLDGqehs94ltK8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165507; c=relaxed/simple;
	bh=CqgKJoU70/zaNBXLmS7MX8pWs9zwUqIvB69GsgVsNas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5s8sRFtqYHEkUZ+Au1QiEinaAIZgSzvwxwBdpBCLfIXrOZnE55HwKTgb2UBiV5CKcwR6KugKVm50m80I1kA4JYoZFm8tJkM2AiXA8XwLk6OHiJQ3i1jPIqldfKTBh1EPlCjYLfSsSKhGms/AEpWhv62roQyqr4tDHTncID9Lak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l659o6AG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2db85775c43so933712a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726165503; x=1726770303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx4ywAvrCZYPD4eVBSgg3GbZmRWxGgFxGIcgKq1xC+4=;
        b=l659o6AGg2jMCTRNkWMdMVcib5IrYJAGLmKFpE0cT0ElMY7kEjRNvUfgVM0NYURAPH
         2ygXwzUbkkUSWdvpooOAffdM03jquESB5WPErMS2+cxlPD2G10XPYQlUrKnKbK2HkS3g
         u4Q2Np91KEhY3EYYYALYyBEVUNPiH18lRUhRBM/+bctObW8GUI91Faq110nFj+VMwV5C
         2MgM1+JeRWZQD+aW08yioTdAWC4eIgJ5xz9Qz9tjheRekMGEahy3y7Q5FN6gn1q1UJ6m
         +f+ZdgwvaJMBxyPyhqBGgFyY/nr8cgXol8KBnWvhKwSceXyhbzBQ50drkGhKRFOqJ7aG
         ulSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165503; x=1726770303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xx4ywAvrCZYPD4eVBSgg3GbZmRWxGgFxGIcgKq1xC+4=;
        b=Vj+cFrtE6RoKz9JJC6jyYsg7vZZ9cNyCw9Y6Kowh7sfKC2hiMR9smXYQEg1XSO8ujK
         BQxDPL7UoJpBErcESvl5qRVDflLN3QSSMKVzJCyvtuy2ZYUZ7cZcoNDKcYVj14JtYNEy
         KeqH05+aJZ/LJDHC+7DcgW14aK5rOLwFFSkNY3d4HUpkXcDb/HXRYrYJ0CyMfXQfPpN8
         TdMH5oLbI3SxXgGYnWXjEF3dfTUxLdpIVR1yiVA/GpzUDqhlI5euJrN1c5fb/jqg9/YW
         9ihRqg0akPGCUS09bc4oLhxZhJ5wM2hXazFjsYyl4ZR7OyE23HHsLORGDWYIuqU57UBx
         AKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk+6Urdmx+b4aaiQK/iCiBbZJPrxyYUNasFfoH4z9FTl4HFMOJ/Sr+/qWf7ggHKdZlXl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtP/MeKkA/swkjMvVMs9SWU92Olj1ejuJhqmfriUj+2qruZaLv
	XHYjr2yJiq3PiF+RjIGrb99QJRb93mdUljIgLhW2DC7uXk+PFHwYZ5h+YU6u0pypIlDoqr+Yk7V
	T9kJjAMhNPxDlIPWE2D361QIwaiIwi57p
X-Google-Smtp-Source: AGHT+IHvzcPyknydMfiYIEZ1M+ai1N0iMQd0+KlJbmGq9bHrJWaDfXL0p8iLCO3JQKPPk1o400N0yqoUYbEMMXful4w=
X-Received: by 2002:a17:90a:2c0f:b0:2d8:25ce:e6e3 with SMTP id
 98e67ed59e1d1-2db6718d8b4mr18054090a91.5.1726165503593; Thu, 12 Sep 2024
 11:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726132802.git.tanggeliang@kylinos.cn> <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
In-Reply-To: <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 11:24:51 -0700
Message-ID: <CAEf4BzaVzVhoqhzpq-FD5GGJT1wW5=LbZ4ADs2+NdLO5rcJMMw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 1/5] bpf: Add mptcp_subflow bpf_iter
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:26=E2=80=AFAM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> It's necessary to traverse all subflows on the conn_list of an MPTCP
> socket and then call kfunc to modify the fields of each subflow. In
> kernel space, mptcp_for_each_subflow() helper is used for this:
>
>         mptcp_for_each_subflow(msk, subflow)
>                 kfunc(subflow);
>
> But in the MPTCP BPF program, this has not yet been implemented. As
> Martin suggested recently, this conn_list walking + modify-by-kfunc
> usage fits the bpf_iter use case. So this patch adds a new bpf_iter
> type named "mptcp_subflow" to do this and implements its helpers
> bpf_iter_mptcp_subflow_new()/_next()/_destroy().
>
> Since these bpf_iter mptcp_subflow helpers are invoked in its selftest
> in a ftrace hook for mptcp_sched_get_send(), it's necessary to register
> them into a BPF_PROG_TYPE_TRACING type kfunc set together with other
> two used kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled().
>
> Then bpf_for_each() for mptcp_subflow can be used in BPF program like
> this:
>
>         i =3D 0;
>         bpf_rcu_read_lock();
>         bpf_for_each(mptcp_subflow, subflow, msk) {
>                 if (i++ >=3D MPTCP_SUBFLOWS_MAX)
>                         break;
>                 kfunc(subflow);
>         }
>         bpf_rcu_read_unlock();
>
> v2: remove msk->pm.lock in _new() and _destroy() (Martin)
>     drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
> v3: drop bpf_iter__mptcp_subflow
> v4: if msk is NULL, initialize kit->msk to NULL in _new() and check it in
>     _next() (Andrii)
>
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 5 deletions(-)
>

Looks ok from setting up open-coded iterator things, but I can't speak
for other aspects I mentioned below.

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 6414824402e6..fec18e7e5e4a 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -201,9 +201,51 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodr=
et_set =3D {
>         .set   =3D &bpf_mptcp_fmodret_ids,
>  };
>
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -                 "kfuncs which will be used in BPF programs");
> +struct bpf_iter_mptcp_subflow {
> +       __u64 __opaque[2];
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_mptcp_subflow_kern {
> +       struct mptcp_sock *msk;
> +       struct list_head *pos;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow=
 *it,
> +                                          struct mptcp_sock *msk)
> +{
> +       struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
> +
> +       kit->msk =3D msk;
> +       if (!msk)
> +               return -EINVAL;
> +
> +       kit->pos =3D &msk->conn_list;
> +       return 0;
> +}
> +
> +__bpf_kfunc struct mptcp_subflow_context *
> +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> +{
> +       struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
> +       struct mptcp_subflow_context *subflow;
> +       struct mptcp_sock *msk =3D kit->msk;
> +
> +       if (!msk)
> +               return NULL;
> +
> +       subflow =3D list_entry(kit->pos->next, struct mptcp_subflow_conte=
xt, node);
> +       if (!subflow || list_entry_is_head(subflow, &msk->conn_list, node=
))

it's a bit weird that you need both !subflow and list_entry_is_head().
Can you have NULL subflow at all? But this is the question to
msk->conn_list semantics.

> +               return NULL;
> +
> +       kit->pos =3D &subflow->node;
> +       return subflow;
> +}
> +
> +__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_su=
bflow *it)
> +{
> +}
>
>  __bpf_kfunc struct mptcp_subflow_context *
>  bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsign=
ed int pos)
> @@ -218,12 +260,15 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(str=
uct sock *sk)
>         return tcp_rtx_queue_empty(sk);
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)

I'm not 100% sure, but I suspect you might need to specify
KF_TRUSTED_ARGS here to ensure that `struct mptcp_sock *msk` is a
valid owned kernel object. Other BPF folks might help to clarify this.

> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
> +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
> +BTF_ID_FLAGS(func, mptcp_subflow_active)
>  BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
>  BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
> -BTF_ID_FLAGS(func, mptcp_subflow_active)
>  BTF_ID_FLAGS(func, mptcp_set_timeout)
>  BTF_ID_FLAGS(func, mptcp_wnd_end)
>  BTF_ID_FLAGS(func, tcp_stream_memory_free)
> @@ -241,6 +286,8 @@ static int __init bpf_mptcp_kfunc_init(void)
>         int ret;
>
>         ret =3D register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +                                              &bpf_mptcp_sched_kfunc_set=
);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS=
,
>                                                &bpf_mptcp_sched_kfunc_set=
);
>  #ifdef CONFIG_BPF_JIT
> --
> 2.43.0
>
>

