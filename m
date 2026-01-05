Return-Path: <bpf+bounces-77847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA047CF4A48
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 17:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06B2430D8AEB
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2F6339860;
	Mon,  5 Jan 2026 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgiCZxuT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF29307491
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629171; cv=none; b=sCURvHaxUowjVqCjZ/df0FOWZoSAezwtOXltClAkJqWvEsXaAl5nRedTCrR647q7sVEfrvYXSac/FF12DOZEXHsx3EtzkosxtP51ZiqBYev2NY9A3YzHp9S77uwhnXgZ46LEbS2q64XenwLK9/C1K3rMofD10G8TdyYTetQv7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629171; c=relaxed/simple;
	bh=Z+gjLDipIMUL9dempdjXyuPmU/vwivKlOWRjXPdfJGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9xUEeSn2uPdyDWpbLYRGhQYPi82vb+Ujp4V3Ge1+ySlr+NI9VbGbxDQE+CZQoiZGsIg5+Cc9updVWd6Fmsetj+oMWmd2NXsSTGlTPvwRmTDdoiMkSyfYALlN2i0Fwl74pj8Q3sO7WFxUlNUHwA0i3bx8/pwUB/a/gPph4J2rm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgiCZxuT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so2259f8f.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767629166; x=1768233966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+gjLDipIMUL9dempdjXyuPmU/vwivKlOWRjXPdfJGo=;
        b=XgiCZxuT4sUcfEvzz8mimmEjHUg9kUMmNSYN2aVltiGHuhiuj7Ax4dSdt8LCmIsK3O
         0lOWpdgfR4I/VG1D55Q/fidV3jwFpJ6MxdUIXvO3rIBFl4N1JNAosG/NpONHyCxJp7pn
         L8RAU5DcXTEFGRfiTLz64qda821lq6y1Iq/1PaH8XQjQvt4CtE7yfFx5S4n4X8Ms8WlP
         wQ11QLhb6r0Ka+sEvzXKIpB2tUaD7f4eBI74N5Dl0DWoyw0A9jCVyDb6Y277RrZF7tTE
         nkOYJnhdJRdqtQiuMQCD9gdVyQepXIb+CRb1QoNp+CGRaRlTnAEh48V93HbQIK5ieLNm
         5yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767629166; x=1768233966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+gjLDipIMUL9dempdjXyuPmU/vwivKlOWRjXPdfJGo=;
        b=HJLO4qkFkgCs9qvVKM4C3AE5irt9eVNN4GSdxwHYF8H0olOaw+KsfFJCDsGlGdJyUF
         Dczb2/F3lMhnWCL+ht1gVTeQUvAZWmMlOvdzvPE/o8gWAUGJQtaNcwk9uAyivV/ldO78
         lh2Zal0tsvdghMoiBWQc5lN986QsU58eSF3+CjOCVlKiqG+uwh/667eojVK8XwbCs5Ij
         hJR9UNorcvwa86ttlIENHmaVSpO4iGAK2Rhq3mrIlzyOCVHbwMKMRRwml7WdhTK6EkQm
         XyF0nKb8HYhUON23QDS1RQJl2EbLr78RDNmzQpLYQqK6hXvO7IGH7t7I7kqXIEUZQp5u
         N+xg==
X-Forwarded-Encrypted: i=1; AJvYcCUx1aXWT8eSGDkIkI/Wvp51D2hdN++moOJkaG/IMYcz0PHgRoLo8zAc87tcBoOm1Txnfrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbS7BNv++tB/96eC5vDyS5IG3WnXSusTtP1UV0wCqhdxwRAVI
	mEVvd5W5QikWelda9Q/L+PfV17UuN2do5A8S6z4Qfu4DA/AK5/AJtQNE31AnyJvAlFjvVeNaMBc
	GwBC26ORXwomWgM78ZQVftViDg3fKpgk=
X-Gm-Gg: AY/fxX6YyXuaJFw+ynbTY3J1SfQ69IGq5KH7xHputuhwokvUicuZM8RX+V7ngmvqSW8
	+6e3zEp4Fw++dxxJoEZjRMMxzI6W7Nb8sp9RxssO8maao4Nd7IxGoX//b7gC6+pu+NGOa9juPi9
	ACSazQdoiPgwgF3uH84KRnm+IYoOW/4UBH5ISATxI8KO9H8QqPkJYqEFW1E3oSuJL78pX3TN4vn
	MSxKat8hW1ERbfC/ffR6gdgAzXYjrEXM4/gQevgMIE7dwxlvl695m0heEmw4Y+cnl9xriQdaR8K
	gB0Nq3DhpL8H29ddQik7EW13SKkc
X-Google-Smtp-Source: AGHT+IH91ju9x26fwpmxKHCdxAk8uiY92yKq0jBd/lsXT5SeT8QJFOnafkbENxS6BD2bJ2pFHihHX423TaK749jOh98=
X-Received: by 2002:a5d:5888:0:b0:42b:2ac7:7942 with SMTP id
 ffacd0b85a97d-432bca168c4mr376036f8f.5.1767629165881; Mon, 05 Jan 2026
 08:06:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
 <20251223044156.208250-4-roman.gushchin@linux.dev> <aVQ1zvBE9csQYffT@google.com>
 <7ia4ms2zwuqb.fsf@castle.c.googlers.com> <aVTTxjwgNgWMF-9Q@google.com>
 <CAADnVQLNiMTG5=BCMHQZcPC-+=owFvRW+DDNdSKFdF8RPHGrqQ@mail.gmail.com> <aVts9hQyy-yAjlIK@google.com>
In-Reply-To: <aVts9hQyy-yAjlIK@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 08:05:54 -0800
X-Gm-Features: AQt7F2pFjbuNmXIapoQzPTyKKnnTbgegxc-4fgtPxfMOBgrMLb4YI8ApwcxajHA
Message-ID: <CAADnVQJr0WqmqA2fQeC0=Jn5F-ujWmUkL-GfT6Jbv8jiQwCAMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/6] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
To: Matt Bobrowski <mattbobrowski@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 11:49=E2=80=AFPM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> >
> > No need for a new KF flag. Any struct returned by kfunc should be
> > trusted or trusted_or_null if KF_RET_NULL was specified.
> > I don't remember off the top of my head, but this behavior
> > is already implemented or we discussed making it this way.
>
> Hm, I do not see any evidence of this kind of semantic currently
> implemented, so perhaps it was only discussed at some point. Would you
> like me to put forward a patch that introduces this kind of implicit
> trust semantic for BPF kfuncs returning pointer to struct types?

Hmm. What about these:
BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_RET_NULL)
BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_RCU_PROTECTED)

I thought they're returning a trusted pointer without acquiring it.
iirc the last one returns trusted in RCU CS,
but the first two return just a legacy ptr_to_btf_id ?
This is something to fix asap then.

