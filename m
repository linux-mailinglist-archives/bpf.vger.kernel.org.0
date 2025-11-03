Return-Path: <bpf+bounces-73371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2BC2D9D7
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 19:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21E4234A377
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F23195FC;
	Mon,  3 Nov 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZeZ5T4s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84DF23ABA0
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193675; cv=none; b=bIg9+ooZkTMAQT6cAc0FKBkvwc/aXLAqSearsP/zTDZAV4jvmdalPr3ZV3xAF++hcrQjLBwU1jvuE7dkIKI9TmBNXiZjp/noN0EkG7N8mnD+0O8CQjlv90yiQ7Qlcp9/UgUPbqUHc+xp0LLf+o+vH+swVzhAp1NxQuJpd9a5b54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193675; c=relaxed/simple;
	bh=Rw/NfzoIuLB/7y5HVpo8MFDK+bJOp+AVq5UhXwEFFnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H49ept6P4J4T+AMzAweTKzFH+UY8I5xPkJKTrmyG5K/v3Z7BoaElsh8hINcMdM9f3+g5xWEoipWYNNhx2QXCysN5s86AaW1FZh/4a+D2rlGnh+obMOWVZeZ8ipCuzeqt+TThdiyPtSVRgUlhfQcCX/l6DHRJXhfY0b+qsDUZsWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZeZ5T4s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so42469675e9.0
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762193672; x=1762798472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E610/qb1Nrr84i5re5GcL4WuanAHiKtr+tt/vf4ODc=;
        b=DZeZ5T4scWLQddblsnCjvjnrSLnILfdvkThcCK53xV221+PKOPKjEoGb0l8EoEqumi
         QQdyJw3fvdyNXEnFJxFc2PCg2EwfrhDxYUqF8B4+9ud+Mo8WDTUcZtgvzeFa1v62F33n
         tyJytFTmRSIV2aNVFSHDeMlsjfb5lrh1H3VzwAuuRVOLJNuSeNw0pCl6agLyjWGoVxRF
         a9ZK3JRc8Nh2MF2g5MRUeqP5PlrQh+MNmQAyxQopvutzD4GpzwE+BDVAMVW6LKwkqyCL
         uWbz2jmZNZDCJBblsrsNdJk3nGjND0zbSgL0XCqFUHmsDkiHX/jNnFSxkzoNqxj3vXW5
         I0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193672; x=1762798472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7E610/qb1Nrr84i5re5GcL4WuanAHiKtr+tt/vf4ODc=;
        b=EwMN7exqGc379mP8BMI3ytjcnlKpJGC+0xhfdWlT+OKQyX+Kz09wqMxoLH6jS1yCRc
         lyLz6C6as8r7uebVT+6ny3Ure09P4rUlGtiYEyIql1qdps5GzPvVTkeSDHfkPDD2BQuf
         CRLGB94DxsKxbVOSLwXug2PXxwTbFeGyPwHOshu1CgPxwgZROATLItgyX8zRFquhO5q4
         JQsUXPnqexYl1nvm0umm4BZ9hGAlrLtuP3Y32KBtsNC9qzYJsYRllaX3za76MbTEznM6
         BLGvjH74WeI3nOaAzrzftIL1vbXr8/anCTc1goYRS8P6gKVqos0xVoabQ2043ytuebBI
         YwSw==
X-Forwarded-Encrypted: i=1; AJvYcCXgu5R/hW0wPmcyLbrAD+pz5llDQdD4yvTmdjl5P/R8LR5Zyki03D9vupId57B5rimI7AY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eEVizd5MKfWc9gcFBhkIyLu+jv1kdTCaeFTQVzs8kkLj99ci
	jTNcXvey69kN03zLxfosYf+YuHeZWB0h2T3/e15IoXedcdMMG/Fi5bppiGV9EMcoTK6f7lNIt3T
	k7qrw6eW3WueKaHPbSuj5EhU+hr7Ga7c=
X-Gm-Gg: ASbGncssJ67hOKGxHoB5koNNPJoDGk6QjTuRARcJjVNwB1s0EbesWpt7v/H5bKJcUcL
	MFuzHQYKM1FFQ30xRAWo1J+Tqb0edAn7PJeudKogTopyFW+bTmYQT2edkfKNuNBTGwPot3pXw/y
	1DFmTK1JXXnN2yA+ryECKeHieX1utjB6I7Ajs/YHcUIpnfAo+MsDjsp8MenKlKEXjBtPzicU9Rs
	3rwhvjSbhkO2MOwcoFgv4UBItVQIxEHRHoRygHtYOkIBdMbEAueudam3bkibccEXNVuU2cnATcp
X-Google-Smtp-Source: AGHT+IFzn9y68SRBpD5BfjieEYZhNxw/JeraBJAq2sAbcCNbyTXLwnen137k2JeOWui+mIjcbeLWQFrSRany76dT9v4=
X-Received: by 2002:a05:600c:c16b:b0:477:f9c:67f5 with SMTP id
 5b1f17b1804b1-477376d769amr104137685e9.16.1762193672096; Mon, 03 Nov 2025
 10:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-timer_nolock-v1-4-bf8266d2fb20@meta.com> <12c9090b388155c7aaac9f503b30a1b678ac630c6f38eb0bee97feec7b6937e2@mail.kernel.org>
In-Reply-To: <12c9090b388155c7aaac9f503b30a1b678ac630c6f38eb0bee97feec7b6937e2@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Nov 2025 10:14:18 -0800
X-Gm-Features: AWmQ_bnSmrXe_PkFHktDKISqIEGfDeleSZgmWiMpaKE789eGD6ki87IkI4WpwnA
Message-ID: <CAADnVQ+W0Fmx3BWzV3Gphor-icsgckC_d6brOyEcO_kC9CKGfw@mail.gmail.com>
Subject: Re: [PATCH RFC v1 4/5] bpf: add refcnt into struct bpf_async_cb
To: bot+bpf-ci@kernel.org
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 3:35=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> ```
> commit 10c6a92e712bfb1625f74ea7088ae806ccf9a91e
> Author: Mykyta Yatsenko <yatsenko@meta.com>
>
> bpf: add refcnt into struct bpf_async_cb
>
> This patch adds a refcount field to struct bpf_async_cb to manage
> lifetime guarantees when no lock serializes mutations, and implements
> bpf_async_tryget() and bpf_async_put() helper functions.
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 2eb2369ca..3d9b370e4 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1102,6 +1102,7 @@ struct bpf_async_cb {
> >               struct work_struct delete_work;
> >       };
> >       u64 flags;
> > +     refcount_t refcnt;
> >  };
>
> Is the refcnt field initialized anywhere? In __bpf_async_init(), the
> bpf_async_cb structure is allocated via bpf_map_kmalloc_nolock() which
> uses kmalloc_nolock (not kzalloc), so the memory is not zero-filled.
>
> After allocation, __bpf_async_init() initializes several fields (map,
> prog, flags, callback_fn, value, delete_work) but I don't see where
> refcnt is set to an initial value. The refcount_t APIs require proper
> initialization (typically via refcount_set()) before use.
>
> When bpf_async_tryget() or bpf_async_put() are called later, they will
> operate on this uninitialized memory:
>
> > @@ -1155,6 +1156,33 @@ static DEFINE_PER_CPU(struct bpf_hrtimer *, hrti=
mer_running);
> >
> >  static void bpf_timer_delete(struct bpf_hrtimer *t);
> >
> > +static bool bpf_async_tryget(struct bpf_async_cb *cb)
> > +{
> > +     return refcount_inc_not_zero(&cb->refcnt);
> > +}
> > +
> > +static void bpf_async_put(struct bpf_async_cb *cb, enum bpf_async_type=
 type)
> > +{
> > +     if (!refcount_dec_and_test(&cb->refcnt))
> > +             return;
>
> Both refcount_inc_not_zero() in bpf_async_tryget() and
> refcount_dec_and_test() in bpf_async_put() will read the uninitialized
> refcnt field, leading to undefined behavior.
>
> Should __bpf_async_init() call refcount_set(&cb->refcnt, 1) after
> allocating the structure?

I have to agree with AI.
It's better to move refcount_set(&cb->refcnt, 1); from patch 5 to this
patch. Squashing both is an option too.

