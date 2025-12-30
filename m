Return-Path: <bpf+bounces-77526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2843CCEA2B8
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC0D830245FF
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2642E320CA9;
	Tue, 30 Dec 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe7rs9IL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A751DE2C9
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112029; cv=none; b=BeZ2kNIC0j993biIhGFTOCWebz0Y6RXejpBPAkPXoY7jifm0LgRbFfLMWYZKybvsBIBSxI3sZwpYrcRBGKe4CKCmihoa1/G3wJ4BNzSKtoGM0gHDfkf/qlMcfDJCoWjuV2cuLOilm1MCA7Kxvlk6CWRQv+7A6L4J4N+GO1LoU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112029; c=relaxed/simple;
	bh=6Q6P/ORdRCxVRJd5X+lanvlagRvYeHtmo7V4wbxTo7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIceZS7Vu7vk7gfVaFCradZ5opNlOkQfd34th7zVMWJzCgHpRlAZapK7c153ZskD6F6v++QyJD4DjzkpKNePobf5pTjg1Z0YLjw/g73feet204sUBNwkygMvh7Y6NfkpF0iEfuky3ddjm1flezM3nBirs7RtCPVAqhtIrraNCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe7rs9IL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so12638408a12.0
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767112026; x=1767716826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5OK3aTNP3/J3FbWImThBxfZrtYgwX+K1SjAcbcXqlk=;
        b=Qe7rs9IL7NOMlUb1JqAGIPC2YDB+xD/YWc6vBg2mXNWtCUaFvjruZMXaZ8LWTY4ww0
         vvp4vOjBVdKT5nXrRlmFNjVqyRq4IGvNG2FZ6z062LUXeJds+AwEas+mxprJrDR1sFN6
         XIAxMCtg1bMyEF9aHdaZXQ5t300mo/nBFOeEKYyGJgrkI2qUVvyWA9henl9ScvGvEpUl
         pSOWlqiI+QnU7CNc0ur3EM24+syG1YkK4KgGeGhasjCBuzjIS99gVLI/VJuTbyswrBPe
         LvkvGA0m5DKu9nrcknXGl0GIKSXIs/Y2eM09PqMOPOGkzd7YF1KbtfAa7ypTp/DORe1M
         wP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112026; x=1767716826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5OK3aTNP3/J3FbWImThBxfZrtYgwX+K1SjAcbcXqlk=;
        b=ggNUKp3fTxWdLXzDcI49VGi9v4ARpKMeZqsRb1aN+83Mh7UacoIXHAPC0DjOsoqp0o
         4r6Gj+dvMnuH+aHngyzLp88+OmSCB07NqZ/Ft+PEglfCO1F+3WMHLcVUrRAtcYV45HBi
         YMwBTJXLT+g72ms9gVV5V3/5NV/gSn3VYbFDmwXNwMxZMznp+28n2Nrqv/XYbLErV22M
         NbfepVzD0sIRTRHPb+6W4DvrFuG7DgT4BpgiBGusulWO2qjqvbFfooA0INRJFvk1iJ+G
         dzL3IQu/0kaKZdYKkdBGc8Ovu2ppG/JdUPJTUrAAzpXiHJwnDHXiRx4CEIPsuWIsPpPL
         9Wpg==
X-Gm-Message-State: AOJu0YxAeMjPMXeVZcOw2o4CRxOf0fvUQhyiCJPNi9rctNgdYzG8iYeE
	m71qq/9EamTdb0PoKVw7ZRTei7XzmWaEJbN23cZp7g1NOc5oQk0UwxYCrjKeZxA/dIMJk++uCXk
	KjRn9MrD77llJFSH9c/LH8E+Q0GatvtM=
X-Gm-Gg: AY/fxX7xcQ40PJwUHk9lCf+hvFHuWQkX/DahoWfGoLf+HSiN2Ph0KHfDGhAJXYIlW0R
	xYqjw+p4vYIRF0WdDuTdv6v3q4NevL1TfAx5uiU+5VobrF/3Ng5+iML5wSdYmhhLj/By0p8yK1M
	z3BPhtAbhD6XDNQQwnI2PqUaw/7x1RPI8B5U6XEPysnrabSa3A7jnKqS0+MKctqYcwavYdpOAlY
	jq9tg/eo+fNSR45fTYmTKiWNYH2SNMfXIgPRYUsR8f1R3WVeFV7XIvZlOPhOQ+s/s3457glHmdU
	5WpHXTGYKyI=
X-Google-Smtp-Source: AGHT+IHqoqlrN8oAeSmiw6KeVjh+4730loCRBdQ+K89VVSW0mXtx0azC0HVfCJPjSlcFSisCFdJiuy/3/gVY9gPWia0=
X-Received: by 2002:a17:907:86a4:b0:b7a:6178:2b4a with SMTP id
 a640c23a62f3a-b8036f2ae4cmr3820773866b.26.1767112026150; Tue, 30 Dec 2025
 08:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230153006.1347742-3-puranjay@kernel.org> <f29cb38331f26f41672903896d38fb3321a34f2d31f27fbd2b7a34a16a2caac6@mail.kernel.org>
In-Reply-To: <f29cb38331f26f41672903896d38fb3321a34f2d31f27fbd2b7a34a16a2caac6@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 30 Dec 2025 16:26:52 +0000
X-Gm-Features: AQt7F2qi1LoAClKb68HrbPP3F9mGYb6fLCC8SAGcsxnDuERLhOv2wxw0R8bhP6I
Message-ID: <CANk7y0jeQMUBS1F1sK8S-a04hOzqQypZfd0iMkfQTacb7HBi2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: arena: Reintroduce memcg accounting
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, kernel-team@meta.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 3:52=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> > index 99c63d982c5d..2f28886f3ff7 100644
> > --- a/kernel/bpf/range_tree.c
> > +++ b/kernel/bpf/range_tree.c
>
> [ ... ]
>
> > @@ -234,7 +235,7 @@ int range_tree_set(struct range_tree *rt, u32 start=
, u32 len)
> >               right->rn_start =3D start;
> >               range_it_insert(right, rt);
> >       } else {
> > -             left =3D kmalloc_nolock(sizeof(struct range_node), 0, NUM=
A_NO_NODE);
> > +             left =3D kmalloc_nolock(sizeof(struct range_node), __GFP_=
ACCOUNT, NUMA_NO_NODE);
> >               if (!left)
> >                       return -ENOMEM;
>
> range_tree_set() is also called from arena_free_worker() at arena.c line =
803.
> arena_free_worker() runs in workqueue context and does not use
> bpf_map_memcg_enter/exit around its range_tree_set() call.
>
> With this change, when range_tree_set() allocates a new range_node in
> arena_free_worker(), it will be charged to the kworker's memcg rather
> than the map creator's memcg.
>
> Is this consistent with the commit message claim that "All arena related
> allocations are accounted into memcg of the process that created
> bpf_arena"? Should arena_free_worker() also wrap its range_tree_set()
> call with bpf_map_memcg_enter/exit?

Yes, this needs to be fixed, will add bpf_map_memcg_enter/exit around
the range_tree_set() call in arena_free_worker()

