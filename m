Return-Path: <bpf+bounces-39658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D37975C21
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 23:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DFAEB23D9B
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A0513B2A8;
	Wed, 11 Sep 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl3H183/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BA524D7
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088472; cv=none; b=rxETa1GJ7mGSx9jB9lYKl8UU+il36nqDU1O4taXqbyiBuvUP2Tvzwn4KQrjw7C40NRMBg/z0Htnjz4kWuXm7t9M4Vk+ZTwEkgXIH0RbpbdCPXD6VwAnl3JslGlJn6DHXB9SRyBiTwNqT45SogqO8DhUJmhFGMsMg8NhV37vSIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088472; c=relaxed/simple;
	bh=VOvOWPlabNVYfY4BzZbBaY5/9Q5e8oJCdSTRjpiQc4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgCg+cR1qW4KHQlXo/JOm1wGzU0+NfEY9+NyhbYGqQx6rcN6JUa+JvmuqO6/+g1uiK44rNDLK0vJNdXAFLnRkdnkFURK8bvLZm768Sf+KRhEa3VtN8LQ9RTlP5u3j2gh5lABFYR0lo4PVIbNwHek3f/fdVNXcGPmZFPiubCBUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl3H183/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso156558a91.3
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726088470; x=1726693270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXNJSO1Gg8eH9d3wXpfGybLqy8DIcRDJJMrUl6hPhRs=;
        b=Pl3H183/gNsIYSPiRzU069gaQvV2CW/aK033SseULvvS88hrkk8NXdpO2gfX75k5aG
         E6JgKGdxRNjlsh1GRqVNEn/eeYbXVNWE+S/zSLJ/WFAx0qFrTw4lqPLV8uSaiBoyh2Ox
         DnWAAnTEQu/swfbcPuYh9Dew4tmGOqdt/05nAft+E5C115IINl/DXQ+3k1NoFSDXUsY2
         aG6uadLao52N40IY7U8oMKtErE11mCnIsoNnLCVoTVxCmmCWeIgCgLDYx0YjSHm9d/gh
         tw/x+H9jgUzIR/or10PiID3kxu7IdU5G8lHhSUm3EQj49WU4pX/R/4MjOzCpvA+mxVaQ
         zntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726088470; x=1726693270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXNJSO1Gg8eH9d3wXpfGybLqy8DIcRDJJMrUl6hPhRs=;
        b=aGFJqU5TRhHTexyw1bLzJZ887gFEHK9yk0fsTUl7FHL/4y2Q/yjvfccZSqWOEUqViS
         WxK64muzf61wc80UFdJes+fb5uLZKPiCxug0+UYh0b7c5/x7Lbr2SdtU7c/AaU+iTet0
         BsXo5FQ7by+rAgqPlb5hfs0cQxrDjFOUCawJlUhoXFLzWXXb2L8875/QkDQ9ivRfhqd5
         tDmCzWB/d+Ys/iKHLWQ+bPFhdbNEijDt2nU0Evm9nWhGeT+R1/izK9gyRETYvQF4d7L+
         RK+Nb8pqFQLmbXAjq2eykOn64V1aVFoWuYW5bV72UHa74C0kWu+mjKkJWn8xA1BhBIOa
         k/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVaXNNG0bgfp5s/88hmGIgs/G/fZk7QLxtdXp9q0iZ0lj598WWc2jyvesWv4hcJes5xEJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqDQNTKiLIZnIb/kIzUCfMBympOgy8OQnfbjqucSaG7zgTVMV
	rJRcOAaAwlQVQhUFjebbm7ukImVKIruFTppSBRr6F+AhRygzdNz7ww+qeJzxOm9WeAXVD2TqMoV
	wzPMenL/c6bqo2yQC63E+o8p42HI=
X-Google-Smtp-Source: AGHT+IFG/n3vuTWLJHTFv1o3YpQiGik3jsiSFAIfKhCfNXZulTHBrS/OLgUiotIo6to+VUH8BJPqGrEceXrEmEa7gjQ=
X-Received: by 2002:a17:90b:4b48:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2db9ffa4ef4mr555807a91.1.1726088470041; Wed, 11 Sep 2024
 14:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725946276.git.tanggeliang@kylinos.cn> <026dce3d6903ad189e4b0518a64b60c910e660c0.1725946276.git.tanggeliang@kylinos.cn>
In-Reply-To: <026dce3d6903ad189e4b0518a64b60c910e660c0.1725946276.git.tanggeliang@kylinos.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 14:00:57 -0700
Message-ID: <CAEf4BzamHdsUnRJN1sVA2rrotug8dFOrSUdE6GZAaF83nU58Og@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 1/5] bpf: Add mptcp_subflow bpf_iter
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:37=E2=80=AFPM Geliang Tang <geliang@kernel.org> w=
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
> Then bpf_for_each() for mptcp_subflow can be used in BPF program like
> this:
>
>         bpf_rcu_read_lock();
>         bpf_for_each(mptcp_subflow, subflow, msk)
>                 kfunc(subflow);
>         bpf_rcu_read_unlock();
>
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
>

Not sure why, but only this patch made it to the BPF mailing list? Did
you cc bpf@vger on all patches?

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 6414824402e6..350672e24a3d 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -201,9 +201,48 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodr=
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
> +       if (!msk)
> +               return -EINVAL;

you still need to initialize at least kit->msk to NULL to prevent next
implementation below doing the wrong thing

keep in mind, iterator constructor returning error doesn't prevent BPF
program from still calling next() and destroy(), so implementation has
to set iterator state such that next can return NULL if iterator was
never successfully initialized

pw-bot: cr

> +
> +       kit->msk =3D msk;
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

you should check if (!msk) early here, before accessing kit->pos->next belo=
w

> +       subflow =3D list_entry((kit->pos)->next, struct mptcp_subflow_con=
text, node);

nit: why () around kit->pos?

> +       if (!msk || list_entry_is_head(subflow, &msk->conn_list, node))

as I mentioned, !msk check seems too late. Maybe list_entry_is_head()
is a bit too late as well?

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
> @@ -218,7 +257,7 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struc=
t sock *sk)
>         return tcp_rtx_queue_empty(sk);
>  }
>
> -__diag_pop();
> +__bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
>  BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> --
> 2.43.0
>
>

