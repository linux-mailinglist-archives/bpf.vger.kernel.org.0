Return-Path: <bpf+bounces-76370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3ACCB03EF
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8961A308A397
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3652C11E5;
	Tue,  9 Dec 2025 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZxB+4Mn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B42BEFE5
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765290029; cv=none; b=nCIBnnt0dJ85/F+C12x/KzjmXH4FjmoqjJDV6SZpFC95txfJ7PeydnrZ2r7OCrkAKcD0ZA8SMErbv8b0lsRNBIWS75Qs5Tczcl5nEDWpmqV5E+xXmrqB1Znvd6izyLSaZ8sOqYACfrkgMHY6bM1l7pMH+USGwZwjxwTJVKCwOT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765290029; c=relaxed/simple;
	bh=yD1piTTKkLTY5r8SbmErzOY/XWJulI5Pp9NE5eyw3mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A19B1VJoC1JpNjehQb3fhGXJMcXrFXTEPAhPyTz+kAPKt+u36TNFF87UUURg8LvIom5CPJzwKTXDpB8lJmehTdTbUNI3bgu/ReY8UlvMNbP+96lrB4FdypSPiQVFcDKEyYxNZJUJ+UBGoyJWZNUu7ZF1WtsktiD3h79k+Geapxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZxB+4Mn; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-656de56ce7aso1798148eaf.3
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765290026; x=1765894826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBJfE2hGb6P9n37NYpV4LGZCWsJx5hal4Ysxh0cWioo=;
        b=OZxB+4MnpyGbLsuYk3YUjiRM0lBBpMF+zvvZ/TWNlOGBACfUEz8nfEYBE92ywQN41d
         P524cHrQzfE62HI3BL1UWjCglAwwUZR7QbsV9rqjjf9HItqeSJBZgJKNwsXGOwXlw2zP
         kJxrzcN9/t+523GiztaKuGcQlw4hsJj+a7kN2LtAHpwCiujK4F9z6GDXh6nVZ9ekx0hE
         yYYCaK50ofJJDiZOa6xG/ygp5xEZla/H1kBnWSVisWDbhaJpPx+nfUyOv8QIAVaA5Qfg
         xoFu82W4KZC6tRrwTTXJtXUtm1RIxDHkv7PiXstUzLgR6XUKR/6+CeqEX7a+I8NpKhcr
         abhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765290026; x=1765894826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBJfE2hGb6P9n37NYpV4LGZCWsJx5hal4Ysxh0cWioo=;
        b=nxMMDuxyXI+RUdjj8x+nPO2lj2RMNAJTOgLBclo5RkSR5GfJ0cV7x3zWcFOqLgmAPv
         lOHS0hguyWA4zufQBEC+KEBv44wfnkepyNnMlHBPNabjXwdJBt2Xv64wyoZwlqaMxZiX
         mYd5s/7QGD1/0LKoV7R23L+k+ysGZ9sXcIcmKpJ1GK+bMF4yplc+H32Pf3dVFetNsoc3
         mjiegRCRig6f0HzkCXnB3Yc1d2odNSeA1dkiNVf2dIcuPQokz6Tn6kb3iqqSAH9a/cPe
         r8NfJsU4qml7ReHLLTEzjlx4BbKSDtzVbbv8c2D8agXvft7y971aK3iwqceMgYbbPIbL
         EnQw==
X-Forwarded-Encrypted: i=1; AJvYcCVK2aGft+LwoyAIeNpz3aVf0TX0rUHigVEq5BOxHS0WRRVAvumMVh6QTtLVMJtLMCjA6Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4oSFCuj4kHeNNNo977QOMRUwOmMgwXwZcxU7wOMMmTKXmQ+0u
	tQDDtMhik+E0N7haeU5l5LuE37SPWqWaFFUl4WwD5apid3YPhcBQ+QBKhxlDKY0P5YXwyZKfBEy
	04ant/4miliFZLCqmbyTNguqiG8uI3/A=
X-Gm-Gg: ASbGncsckyLvAa5B230BNkzDJk2RNU63R4fzAsottBTWZf+Gi3jyoeDAB0l4Kcargl1
	OvrRvNQ4obeZpwhCCQUJcaFCCzCCEdosdYfuXmkLcfxFFhkGEBGDgtAtnx+jW9lk+55JTfR9Ukj
	n/NLq+7dW5s/8MmRX2Eoc6BwebRA9hSoGvxu6fc9kmiznqR5sJtRIUI8eTl8/t8fsYbQtU4IgUt
	6PTfeTBeCSDBrH6j1+oIcfoHFrMRlQ++GW7AXQIJjFoVNE0DKugZm6Wxq5dsc42q6kFIA==
X-Google-Smtp-Source: AGHT+IFc+EscoKLJ8xfpNpKZHnmvmIcf/SbHosp8AgCNsBwkh+gXjMCCcCW0C1l5LFpiu2DddXXV4UXr4RB8zSOlpXE=
X-Received: by 2002:a05:6820:f008:b0:659:9a49:8e07 with SMTP id
 006d021491bc7-6599a98ad19mr4876672eaf.73.1765290026448; Tue, 09 Dec 2025
 06:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209085950.96231-2-kerneljasonxing@gmail.com> <3b8d7e918263a668f37e7c991de87d9473d01604ae5e61c5a40310ef00ffc017@mail.kernel.org>
In-Reply-To: <3b8d7e918263a668f37e7c991de87d9473d01604ae5e61c5a40310ef00ffc017@mail.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 9 Dec 2025 22:19:50 +0800
X-Gm-Features: AQt7F2oTRB5KgJ9LNJop9gl58v6h2U3JtCaT7Su-biNwoyYvy7ZmbcVaHLEdlgA
Message-ID: <CAL+tcoB5Y1YiQjbdzN4FdxGBf4=1neLMUvyZRPL55752GHyKPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] xsk: introduce local_cq for each af_xdp socket
To: bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	kernelxing@tencent.com, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 5:29=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 23e8861e8b25..c53ab2609d8c 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -45,6 +45,12 @@ struct xsk_map {
> >       struct xdp_sock __rcu *xsk_map[];
> >  };
> >
> > +struct local_cq {
> > +     u32 prod ____cacheline_aligned_in_smp;
> > +     u32 ring_mask ____cacheline_aligned_in_smp;
> > +     u64 desc[] ____cacheline_aligned_in_smp;
> > +};
>
> The prod field is not initialized in xsk_init_local_cq(). Since vmalloc()
> does not zero memory, prod will contain garbage values when first used.
> The next commit in this series (722af5ef5295 "xsk: introduce a dedicated
> local completion queue for each xsk") uses prod with lcq->prod++ before
> any initialization occurs.
>
> Should prod be initialized to 0 in xsk_init_local_cq()?

Yes, it can be done here. Will fix it. Thanks.


>
> > +
> >  struct xdp_sock {
> >       /* struct sock must be the first member of struct xdp_sock */
> >       struct sock sk;
>
> [ ... ]
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f093c3453f64..ce165d093105 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > +static int xsk_init_local_cq(struct xdp_sock *xs)
> > +{
> > +     u32 nentries =3D xs->pool->cq->nentries;
> > +     size_t size =3D struct_size_t(struct local_cq, desc, nentries);
> > +
> > +     xs->lcq =3D vmalloc(size);
> > +     if (!xs->lcq)
> > +             return -ENOMEM;
> > +     xs->lcq->ring_mask =3D nentries - 1;
> > +
> > +     return 0;
> > +}
>
> Can xs->pool->cq be NULL here? In the XDP_SHARED_UMEM path with
> different queue_id or device (xsk_bind()->xp_create_and_assign_umem()->
> xsk_init_local_cq()), xp_create_and_assign_umem() sets pool->cq =3D
> xs->cq_tmp, but there's no validation that xs->cq_tmp is non-NULL
> before calling xsk_init_local_cq().

Yes, it can happen here. But it should not happen in theory. I did a
quick analysis at the following link:
https://lore.kernel.org/all/CAL+tcoDQ6MyuGRE8mJi_cafqyO0wfgOw5WTqnCvKGbQBhK=
OGpA@mail.gmail.com/.
I felt tired and sleepy right now and will dig deeper into this
tomorrow. Hopefully I'm right.

My take is this NULL pointer of cq case should be avoided.

Thanks,
Jason

>
> For comparison, the non-shared umem path validates cq_tmp via
> xsk_validate_queues() before reaching xsk_init_local_cq(). Should the
> XDP_SHARED_UMEM path with different qid/dev also validate that cq_tmp
> is set before calling xp_create_and_assign_umem()?
>
> > +
> > +static void xsk_clear_local_cq(struct xdp_sock *xs)
> > +{
> > +     vfree(xs->lcq);
> > +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/200580=
64407

