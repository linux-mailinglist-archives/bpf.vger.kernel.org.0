Return-Path: <bpf+bounces-77692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C9CEF1A8
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 18:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C573014DB0
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84CA2FA0D3;
	Fri,  2 Jan 2026 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKrqEtUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E762F9C3D
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376580; cv=none; b=TP1MKNdllVkcVpDqPQzekHOz9PT77x/8z/2tD4Vf+cNriR1jcnD5rrgL+gn039wzmQxIPVmcRiOezlcxEI8VSdeR6SiClzMLd6YVEbZwiaEStffZLsFR5bTu27FqS1SPTXqyku+rOQd6C+fImx5N+NX//SHWTJFi1nBaLxoVavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376580; c=relaxed/simple;
	bh=UiGSZJcvecuteX7e4Bg5+YHQwmjNlbVZtc9u8UQSy2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVEXQ5YhDXySZZRdr7b+dgDr+cLKc1uRQE4PXeD76ZHUPSvw8MEdwUkfgr3yQVaBTnptEXMnlsH+ql6LKLAM1BpmT8GmYoUYoFk5HPspu6NUI5XQB4M5Xp0wGtAD3HMxdlClrzN42REWYe+/fayOXymiR8jGgbzLLwA5HiL4U28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKrqEtUu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so9930323f8f.3
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767376577; x=1767981377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz9h0+xuHNc47sZhcMOUOohmcL0zpvfUw5YqbSiPCv4=;
        b=fKrqEtUuBuppQvLv02PwylBhLJSVpijPLqQr4jJ531GfGgjCcd14uWuu2JH6FGhbkS
         BmmzE5px6mtM/D9Wa19jmB8iPn72lX+TU6szVJZnCr6SopKG6VPL9YZfrFpl7xSEDu43
         Q2O9x7IW/cVa17zXFIuDrq1jb+76i+GELO2xj1L+NXissS7DAdJ3caEgRdLiTg37SSk4
         h8+dQU4T/g0+eZkSQsFyLZzkQLUA3kfIXF18Eb7c9X/SuzhOxJ7hV2mDsmBz7ZtrXkei
         B0DwUXWbf2ezA3sMg4Ak5hDb6SLU3dy6JLhzWHc7uI2Ia7KCbrUkmeeN5zFixjL0r+Ct
         3UGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767376577; x=1767981377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cz9h0+xuHNc47sZhcMOUOohmcL0zpvfUw5YqbSiPCv4=;
        b=Xxs/dti4ZzNDg1Thht3lUmwtq6zdfIMWNEZ9Mez3FJ7ZS85YlQLoy2EOi2JG4r6iIP
         y5e+CdFwOQEAJzwYTLTffnq1HaaroPu62YYgdShJ66Rx6jkMBE5ZVBRiIJwDPyFqar6K
         3pRW6b5xYJM2WLUFFnuk8x/Ieu7phtY+GMvyQwDN3CsldNEmL3+xZCJw6K+Ye7yrIpeP
         edM8xsDuAh96MV3rLgQd3RBqC7CzgkyPW6YvhgbOkO1Dmh3WmPRpx2N6OCG1eRrLGbvl
         IA0znYdM3uKxLgu6NN3h37M4JjVoMLNZ/ApnIjG56p1Lpz/t0fu0AgX4d2Tf+vLwPmVS
         5euw==
X-Gm-Message-State: AOJu0Yx+JR0XHbitx1UI2cUlbA7CHzWWM+2VbOvhrwuCOeH69/bSyG3j
	LHZYYxVsu8dKOzGagScZrSG5/fYyCHTmW0iHmh0lRKCYPEsZQIfzG2L9xhdt39biUMS9h/qouX1
	hPVzGatn1Fj/JQORA358ON/AykoHhz/k=
X-Gm-Gg: AY/fxX52g/NBue19XHE2RDjrcG4jXNHOmo4TwwxrbkZ/KwQaf/YNszWgx8EsoPjz2uK
	eAvWaQeGEUNRq9FzR1oHi1PwlMQESuagwNl7lDQZudLZrdIu6+l7MpZKETpWAPwNrpfvyWLbcb8
	9jvH2eq1mk0+U2E2PyDlbtHo8zQbzAfmzOawxpHgsFMfM4lNsuwI2MNLa6QFhaCKMwXZj/DcBKS
	b76PxExyzJIITFvPh4Av7QS0CHiZEoVFgckSBN7lZsfXlv+xnqpIHQfcs08EJ80bvO8aPRavYCS
	VBzVKIimEq/5A/W/jVVlZLM4bHyGK7xRGhpQjDk=
X-Google-Smtp-Source: AGHT+IFOmdXhu8glPAGRe3q0h3R/icU/g43vEh0IwZWmsvY7JQRxREgccjgcLs804tn111rO6eZbfVWfZB7ixgqDdBc=
X-Received: by 2002:a05:6000:178e:b0:430:f7dc:7e96 with SMTP id
 ffacd0b85a97d-4324e50d6ccmr54768364f8f.48.1767376576796; Fri, 02 Jan 2026
 09:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102151852.570285-1-puranjay@kernel.org> <20260102151852.570285-3-puranjay@kernel.org>
In-Reply-To: <20260102151852.570285-3-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jan 2026 09:56:05 -0800
X-Gm-Features: AQt7F2pUUkf-z8FlA06xsv56oFD4aTCfB9vo3ntrqumDvGd38FUgsKaBePSbLHk
Message-ID: <CAADnVQJECvWkJ5XuCrq1Oujg9T+n+3Y-vmb=rw+Y0crRVzRkSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: arena: Reintroduce memcg accounting
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 7:19=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
>         if (map->map_type !=3D BPF_MAP_TYPE_ARENA)
> @@ -885,7 +907,11 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map=
, void *ptr__ign, u32 page_c
>         if (!page_cnt)
>                 return 0;
>
> -       return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
> +       bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
> +       ret =3D arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
> +       bpf_map_memcg_exit(old_memcg, new_memcg);

This one can also move into arena_reserve_pages() for
symmetry with the rest and wrap range_tree_clear() call.

pw-bot: cr

