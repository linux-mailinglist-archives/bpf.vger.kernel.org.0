Return-Path: <bpf+bounces-79168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5FAD2966B
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 01:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE44C302CF5E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 00:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F742F39CF;
	Fri, 16 Jan 2026 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X52jemAR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B43253F05
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522975; cv=pass; b=tU5kW4aO/QJgWjAxzilD4zOVlUjbl9EDXTbJg0jXTHCx9rVZmjtLgoyAudeOX32+IjhTyA6+hBwO90yhYcykggmvfWBkYEQGEVuM1T5iyHt/hLFYgcA9sMYU03qgTQWq9UMN56Ed3huWEO6VwS4xj1B8Pp0zVI7dtAFCpuuRYBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522975; c=relaxed/simple;
	bh=7IjaKVr9Qjs79eTGTTDTXYnTpcN3WgBNmCFA4kCF0BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cINfWy1py2TRHA0Sj4NaDJNIcxfr9E+14ZTWNDH6+ARi122ufZPY+rNm/ZX6EGqSirRVPNok8HqS/rYcN0cs0CHZlZnUAaLqUrzr1jByoXIfwEsBmTVRpQs/8eQnIvbvzVkTFI1UXLMMYqQ230FkAzfCpsq3OJcbDHzYq+RTvWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X52jemAR; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50299648ae9so103631cf.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 16:22:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768522973; cv=none;
        d=google.com; s=arc-20240605;
        b=YWQu4admEM96tx8LBv6Dmx6+w8mfTYUvqDOWe0mgRFDUXiVVmmTS9xuZ2WVx8KuzYP
         S9jKADex5al4jnjwtH9B8UbCFeo6uj+HowQfzatkQjAdf5sqrbSuUJmaBsxS3uzpL+Hf
         fQwbuQJa4WeYbeDYtojdOYYo+Z/d5OdLJHMMVKyCeVlBdBe0Es53PJs32KYhUwKYKlb2
         oiCE5wrq8D8ndDVbxkfkXQebias50XKo6Zcv3i8a6M+Qd9YQaW8NxW1OlhH3vo9bQH4I
         kyuBVnT5jnygUydxClmNMnQNrniXswAsS1Ly4Q0x2RnNxK1fDPtk0YUn7+YDzqwqTMe3
         x2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DW/ITMg56jRAZJtQnAt5F58BDqK/01GQKI49GCbQ0F8=;
        fh=kpz3RJ4U6QwHm5s2BOrWqxCN1k6aFTHDuFM21DUy33s=;
        b=Ih1tq7dIt4VrVD9YjXwyiV0wGuXzwUneLPtmC0rQXYLbajXj6F9JxBB6kjjoUbCQeQ
         U4rj2sORujyxdKo1u/N5A/m95f2sxlIOLwuB5mKDz/a55LemAkM/mEyuv+5HGp0xpKuT
         5kM+biCiZ5hzhT1r68n3jyeDpeoSCzeGPPvZtqs9ol0M2Q7CQJlUJ5g69p1YXd8CNWe9
         MOLo4MA8Bg4nobGtdO2eIfoLKSCxg2hK0fujlj8ucWERR1XHuFB6VEvLFDaEZDB6qk1d
         deUSDZpRfyGdEtwJC23p0K3bohFCCXjQL9oUJ+0sEWbWrpfUjyLR92wKxFzS/3cxgOof
         ri0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768522973; x=1769127773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW/ITMg56jRAZJtQnAt5F58BDqK/01GQKI49GCbQ0F8=;
        b=X52jemARNUYGGoo19sKtQP6UBgBVBVj6EUNhmGlWpBfbW0n1qmVuXtuVDUuqYVNmgk
         MUjJJoBmrqRCwpgSiunBixz+IZeqYSt8WLDFO6X5zToyuDPDpyN+5TThVPQSLemf8Qrr
         4opPg0QmqqSQVNuv6nP2CRTvAxY0+6aUCef/E2lLAIjYb0BJrvEE7bim4d/iMWonbFhy
         Z3R8JcX3vY8sCnIsC7ErJ1k22MUj4zA0/rVnhFqcKIFxmBAiyCm4h7H7KHLA+Of89Va0
         iSKTlLhsPGCSCrpDe+GaCgqeqD09bvG40kUz5QXMQIDf9r4U7FexFnvEFQqzYnwyURK/
         dDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768522973; x=1769127773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DW/ITMg56jRAZJtQnAt5F58BDqK/01GQKI49GCbQ0F8=;
        b=lC9KqvLkr/rdbRW7IQtVd1kEMx7ny0PaeV/0e6iZojY8n/UnY/a5jPFY/ARyO+lyKo
         RRg0P953rgxLyHvXJMcsA3P8IWzT6QEyLFP43eJHT8fnjAT+HvliXoNzbvkL0Tb2h7w7
         71ihObB3KU0n9hVzzjqhKInI/KivRv09VK4n/6EQGaQg+4XTN8EvXlSWgsKbWnYURbNX
         RLDb57LDH58pDJtFH7/mQ6cywPVsnHHAxZ8pPlB+QVJIF29ObELX6vvxQxCJTtafLYSU
         lIl8trqA8QXUoZpZD25ul6nAuTh6vqQ/32dXsDcT3pHYbzfEt+/aNrvzw7jSStGEwMqJ
         oZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCXDy3fTDx3IR6tGO2CcIOLbGxpTAUtZlLgK6ahlv7QYAsBAD24eIiiLLLj6/dHaIovgdeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzdS91jne4g4LnwFMmeL2Zyj189Jz82DLfaT8DwyYj1nED8sZ
	vlsqerwplAoLKLTLngyzuoisIbKLV9KECk3fjKplO7CX/vt8Fzo4cE9hV1B4OzyG+F+hxsUGqRw
	GzmVHPPw/M27WkBL5eaLxIuo91SZhyBeiNzbsx0al
X-Gm-Gg: AY/fxX7zevUSv9vkdY3985uXuyOLiqL8cIHIJ2Ey2FrelaLay5/v+9kZq8P3Nnoqsj/
	lbTNKitoTi4ktoeb5lwRtpFJ1bNmfKJl4ExXr5BndF48UL/vXsdv9oQqb/q6B9FP46RPXNWRsV+
	/YNaTsFMzkbr3/Fez8/RrxyF/CLYJu394vkf/gjNe1CUju3YFFnxs06SS6YXACaXA6xXTEi5XtY
	ePKbeaIhdRXQckE6BbUrsbk/Rt46WOYslgltky3wVL8PSbD/lCQFRiYZ/ae6SDi+OAjn//XMXIj
	jARDRbkvE+yAg3XZpZKXwAU=
X-Received: by 2002:ac8:7d0b:0:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-502a367742fmr2431351cf.1.1768522972940; Thu, 15 Jan 2026
 16:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz> <20260112-sheaves-for-all-v2-3-98225cfb50cf@suse.cz>
In-Reply-To: <20260112-sheaves-for-all-v2-3-98225cfb50cf@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 00:22:42 +0000
X-Gm-Features: AZwV_Qi0xiGM2d4FuoLFqXrZf077B4nd0NZeqj4924Qs7epHRHPkVirBgIQQHEM
Message-ID: <CAJuCfpHowLbqn7ex1COBTZBchhWFy=C3sgD0Uo=J-nKX+NYBvA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 03/20] mm/slab: make caches with sheaves mergeable
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Before enabling sheaves for all caches (with automatically determined
> capacity), their enablement should no longer prevent merging of caches.
> Limit this merge prevention only to caches that were created with a
> specific sheaf capacity, by adding the SLAB_NO_MERGE flag to them.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab_common.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 52591d9c04f3..54c17dc6d5ec 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -163,9 +163,6 @@ int slab_unmergeable(struct kmem_cache *s)
>                 return 1;
>  #endif
>
> -       if (s->cpu_sheaves)
> -               return 1;
> -
>         /*
>          * We may have set a slab to be unmergeable during bootstrap.
>          */
> @@ -190,9 +187,6 @@ static struct kmem_cache *find_mergeable(unsigned int=
 size, slab_flags_t flags,
>         if (IS_ENABLED(CONFIG_HARDENED_USERCOPY) && args->usersize)
>                 return NULL;
>
> -       if (args->sheaf_capacity)
> -               return NULL;
> -
>         flags =3D kmem_cache_flags(flags, name);
>
>         if (flags & SLAB_NEVER_MERGE)
> @@ -337,6 +331,13 @@ struct kmem_cache *__kmem_cache_create_args(const ch=
ar *name,
>         flags &=3D ~SLAB_DEBUG_FLAGS;
>  #endif
>
> +       /*
> +        * Caches with specific capacity are special enough. It's simpler=
 to
> +        * make them unmergeable.
> +        */
> +       if (args->sheaf_capacity)
> +               flags |=3D SLAB_NO_MERGE;

So, this is very subtle and maybe not that important but the comment
for kmem_cache_args.sheaf_capacity claims "When slub_debug is enabled
for the cache, the sheaf_capacity argument is ignored.". With this
change this argument is not completely ignored anymore... It sets
SLAB_NO_MERGE even if slub_debug is enabled, doesn't it?

> +
>         mutex_lock(&slab_mutex);
>
>         err =3D kmem_cache_sanity_check(name, object_size);
>
> --
> 2.52.0
>

