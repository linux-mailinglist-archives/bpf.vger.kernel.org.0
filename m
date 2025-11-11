Return-Path: <bpf+bounces-74249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B61C4F4E2
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F36E189D489
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D4366567;
	Tue, 11 Nov 2025 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0nFCv8O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66F22157B
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883259; cv=none; b=FYWqqlqr5bXtFvVU//QucMrRc6rFtjrHNiSez6RUhgrOmBD02tn3g/8+qtVwo/MbOXes+HL8HDgl9x8ykJqpb18iF6XQqybEGlvZwtdAMSXhJR9Ahhx5psMaF0ug6d/AP40EYHvBj4gbUAO34//UpvJvbS9cPdLCNvWpQf3ASZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883259; c=relaxed/simple;
	bh=uRxiaeS/rGUu91Z1xiw35I7R7R7eWGbwulxofjy8CEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFWnvxeo7YyuOKuL10P1uLCrB6XZnj2DC01MtetjqMDHKTY0ia5tC2a2z2nx044gNjRoA0a1lnN/RaMXwU+BN/3+Y9ZJusPk5NrHJ0NOAhCdIkc2+9C08CNiPdosjM8rRIRwf+lcK7rZPjRzoCE9XeoZtVPx1OIX5ESv3trFEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0nFCv8O; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632cc932so1015e9.3
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 09:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762883256; x=1763488056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj1dxEfAj32rYAf1VEim9PEULgW9zQZK58CWPz11doo=;
        b=W0nFCv8OL20H+U3wlVbyBOeJEqjnEpcY05zSSl25U55hgWfJB+FmZ6KM3eJpf5U4XD
         YDo3RYFTmNDuBMsjNCwwuuDeCS3D98bYtfR6DSREVrggbPZ8zuahM7ID/wagNzAiIF7a
         BuBnWbyCkx3RgUCUDzZGaYGumUcmMsetTG8F5SdKLB8m6puOM7V51VdrclgOdytKSxyQ
         VlyRG1Id680Q2dJqFHNEwOqMrng1Mqru9YJAIi5g6+tXq3xptUxdNAqWZpL28aPoWoh6
         MhnzZpNbqxHwuAV5nikOZNgPg2sGrs2Y8/BtKwLQwUW6NpvHTDdjcqNDNu1UO/dWJ+u4
         HscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762883256; x=1763488056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rj1dxEfAj32rYAf1VEim9PEULgW9zQZK58CWPz11doo=;
        b=pwD0sE7Qyc/CVqe4L2gnZW+ZBeIW6ua2Nm5g/kY8PQc4VQ5tkB4UrZ+nDN+2s9YETt
         MhVXHJsJ1zWyrKCe8JrS3E1pqBasR7EWxXcmhkiO3yxueNzzboJ75tMElpzhXkJ4VPwl
         JF1JnCu4W8VI4Px81hDYQvDYglwR+wU0O84dYG/eet5g6plD3hX4Kbs5avYro3cIUAPz
         l6q+F9ixZsJezG+G02MfP28KWgcnjkQ5lwNljC0sOFi/vmt1ohRGYrNQIkpPQUNkVUqO
         vzgvu7FxnkO8MgLGN2lekCpxdNfdmYiMRIBQdeTugQancCgH3Oes2vDZcSMJNYEzEIer
         H8JA==
X-Forwarded-Encrypted: i=1; AJvYcCUPiA/EPp7qpNTNt9X05cGlTStcK5lEBEHRO8tGjEDboppxEhxfIGBZjHdxXNOGtvkWyw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MT8Oi58rxb0I2Ukdy7mZwiZi4Sl2YjUDATQy62ljJ7YA+mJK
	UYwDWbObJq6eNOvRddNR3jPOwMZyXr9+hMOo+ADTHPJEuG+pfS05Mln7jaLdnDZMLU8zSUZvXhn
	oYoGZ/4shkEpss2x/jwVw/8S0oTVYEN4=
X-Gm-Gg: ASbGncv76V+UhCKu79IlR5ByNdd9fThWnqKtmPefMs3RHutXQnXdc4u5E3CK0EslqBz
	aYahkp4JEjwdl+CXjuilSO/6/Fhkfx22nxMi/wTWjaA68W8j0mEKzjkZlPjPyYIHyRpgZYF7/Ig
	PgALJqGD2A2UDE908r5S1T/SEAOjaEjihJdFFQJefrCsOyYK26AZodpaRLHmvG3PPzTjffGE74k
	Btm6FEHZ3tk5xsBvNBrWC8QhjV7VWM4N/hwh3yl+bz6s22MhmYdw9w9RWvJu1SU7wCr5Md8+gwo
	9tITsHf5lX0=
X-Google-Smtp-Source: AGHT+IHayPxhCAJUa9GC4fnFS/jnPshZt4S4Pw/evT5r41iee94aINbFkUagp+EyqfqbUrGRfURA6MGy8O0zkc3Dw/o=
X-Received: by 2002:a05:600c:3550:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-477871c4762mr2522485e9.28.1762883256108; Tue, 11 Nov 2025
 09:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111163424.16471-3-puranjay@kernel.org> <e04dae3b764c7076dd68094db235b0aab2683bf176b1bdb951e7b50137927553@mail.kernel.org>
In-Reply-To: <e04dae3b764c7076dd68094db235b0aab2683bf176b1bdb951e7b50137927553@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Nov 2025 09:47:22 -0800
X-Gm-Features: AWmQ_bkufI6y1KLNzQfp-XnpxC0z2asYXmM8HJkGQMTyljR4dQXaaHHHXAJS3C0
Message-ID: <CAADnVQJ3LAm9CHgeC3NBPSEHBsjkSGF8v-DsWS8sLhxz_hHOoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: arena: use kmalloc_nolock() in place of kvcalloc()
To: bot+bpf-ci@kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 9:01=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index dd5100a2f..9d8a8eb44 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -506,8 +506,7 @@ static long arena_alloc_pages(struct bpf_arena *are=
na, long uaddr, long page_cnt
> >                       return 0;
> >       }
> >
> > -     /* zeroing is needed, since alloc_pages_bulk() only fills in non-=
zero entries */
> > -     pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
> > +     pages =3D kmalloc_nolock(page_cnt * sizeof(struct page *), __GFP_=
ZERO, -1);
>
> Can kmalloc_nolock() handle the same allocation sizes as kvcalloc()?
>
> Looking at arena_alloc_pages(), page_cnt can be up to the full arena
> size (4GB / 4KB =3D 1M pages). This means the allocation size can reach
> 1M * 8 =3D 8MB for the pages array.
>
> In mm/slub.c:5686, kmalloc_nolock() returns NULL for allocations larger
> than KMALLOC_MAX_CACHE_SIZE, which is (PAGE_SIZE * 2) =3D 8KB on systems
> with 4KB pages.
>
> kvcalloc() could handle larger allocations by falling back to vmalloc.
> With kmalloc_nolock(), arena allocations requiring more than 1024 pages
> will fail where they previously succeeded.

sched-ext as a main user of arena allocates 512 pages at a time,
but AI has a good point. 1024 is too limiting.
Let's round down this kmalloc_nolock() to 1024 * 8 and add
an explicit loop to reuse this array while allocating all of page_cnt
pages. 1024 pages at a time.
Error path will be a bit more complex, since we would
need to call arena_free_pages(), since some pages might be
already populated and active.

pw-bot: cr

