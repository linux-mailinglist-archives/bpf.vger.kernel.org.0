Return-Path: <bpf+bounces-77536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECDDCEA80D
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 19:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D533C3033D56
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447012F28EF;
	Tue, 30 Dec 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7KlYGx1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8F1E8329
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767120329; cv=none; b=owSeCaaxG/0mb5yyur7mi4TT24i1WlCZdZ/hv2oc+7XwLfAh6krNrdeueV4iRVMoQ79mjo7gGvyfPNOc8EUpnqSfYXcDzB7S5gAaEERpy7eB/qybjOmLRUPOZoK96RsUT0c7hYgZt4AuMCHBy4bkscHS9L32R1ItHW3jLEs2uSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767120329; c=relaxed/simple;
	bh=FpDD2TwPWa4M5fgZPts+75iyDxtNmzs1swl5kLP8onQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ89CJba3fe/65e5MuzOB9D13t+k9jYDfa5NwQYJ9M9b1NNBMY3PjhhBOJ+5XWwc2ma6L8Z30UbLPddggyXGYzWAiUi7IJwUOr6EbQKHd+R0W6nCSQT83zPFN1pMfjenxKnLMVrN3hbhmIS5lAdFpCtgnVp2Zw4LqMMVRclawqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7KlYGx1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-431048c4068so5628118f8f.1
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 10:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767120326; x=1767725126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUs+XJ/tmGWPaZTu0VNMbHqUG+BDru/HlhrUUBVzGW4=;
        b=j7KlYGx1FWI6AJ+ZHoHCG/APP7KhK6e7cFJZCebBO4qv8SO6X9Or1zfKYZEgfx8cCC
         FD2VSqNTdz1DWYNKuRf4Isb8Ew8KNoSvHMV7RX/1LcvJbAPFd8rgrBCpGpIGSZ2h0kqr
         DC3dHkQi0cBlZS7XWFT134hc4R4TQME7iizFCk1S84uJL11dayapix9sqRJhb2GqQ/oB
         Ra6T5MWleiV/iaJHkMpCKciI8ARySAF/f7S8+Y3uz1vWlobQarHLgPzJ8H+KbnTSA4c2
         NateL9nQilthjXRN95PR7mMqhARmWiF+jv6rAL+F33gZxEcYDE9xnlyPSxyzjZqh4oc8
         HY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767120326; x=1767725126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aUs+XJ/tmGWPaZTu0VNMbHqUG+BDru/HlhrUUBVzGW4=;
        b=V+aN+YDoczx5gVfZOKfg3vXm2kydcvslScdoiCsHmuAdWC49PWTFXYKVgxcS0SlqKq
         zjNSPr+WLt29nazuHF9lrFjZd+VCrhCjcQ2vyVmwlYBRR7I4kwKZEu/Ty0DQ3JS0BTNf
         qgzMBa6kfUl/82zhC0pbLWxShAtcBbYtlWmx2Gon+VqQ+QLFSshMOGINV5/aaIvUOjoW
         FPv6knBuCCOtEbhJO7Qud33nmhMV7haXU97FDI+HnLOmy5E3dAf6iBZba+E+6DdSiutC
         JPwQkTU3lxFQIvmJAFquZGZ8trCWYUClh0Rt3rU+vazhjdK/KRmS7AR8aKikci2DG1CH
         MleA==
X-Gm-Message-State: AOJu0YyXTM7jAiNBz8N6VhrSmoScMHs7t9QYp4dtw7OHcResYaoNjdC6
	EQtUgeFqQIEDi6Z4y3EOkxX633C1JHZtzXm24lP1RDP2VYtuMshtKMuT8RtuwxRpuZwYdPqZhM6
	wtnKYTEkFVJX05ignucjdT1uaibQcHzE=
X-Gm-Gg: AY/fxX6q0DiSGEjBXrBtqm/2NmoTEGhqcxbgrXtjqrjEwNqhXsAtFEQ2aiIaHiYo23p
	OaaLiysiCiDb/MV8gglMsszd0XHemU6zk11ZpEFB8ZvVsNBenggTg2Cq1n17JVi0VOEmmK1n1Tj
	Gi9GT8cGs2ReT52YODq5KkPrqG16d3VDPFqLT1uTGqmX/UPfYin6D7tZPwn/kKvrbyk+yjW88v1
	bCFw1yR8fbgHkYdypI0WgLHpb32vMPWkCLYUYQcpfxg7mXUZqbqYV1vonYcEUajyWcZ/4KQoMsV
	OvfQZaBEgqvzmQhJ0myqrI8C/IR9
X-Google-Smtp-Source: AGHT+IFu8MxhvdTHihCZQiKGDRkvTlebUdQ6AumB41uGdBICQHMsgBN4FWTDOKDnqFuk4aCkRs13LoMSGjKvV0duIGY=
X-Received: by 2002:a5d:5f46:0:b0:425:86da:325f with SMTP id
 ffacd0b85a97d-4324e4379aemr44169396f8f.27.1767120326343; Tue, 30 Dec 2025
 10:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230153006.1347742-1-puranjay@kernel.org> <20251230153006.1347742-2-puranjay@kernel.org>
In-Reply-To: <20251230153006.1347742-2-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Dec 2025 10:45:15 -0800
X-Gm-Features: AQt7F2q9ors-Snfqu48L457FR2jO40YzKKZSmbj4IlOAPY8qSMD1TwmQve9Ogfs
Message-ID: <CAADnVQLFJ2a8n2xBbu4c9Soh2qEtoJsKAKUqQ6Bn+Z-OUMXTOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: syscall: Introduce memcg enter/exit helpers
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 7:30=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Introduce bpf_map_memcg_enter() and bpf_map_memcg_exit() helpers to
> reduce code duplication in memcg context management.
>
> bpf_map_memcg_enter() gets the memcg from the map, sets it as active,
> and returns the previous active memcg.
>
> bpf_map_memcg_exit() restores the previous active memcg and releases the
> reference obtained during enter.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/bpf.h  | 15 +++++++++++++
>  kernel/bpf/syscall.c | 50 +++++++++++++++++++++++---------------------
>  2 files changed, 41 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4e7d72dfbcd4..4aedc3ceb482 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2608,6 +2608,10 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id=
);
>  int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>                         unsigned long nr_pages, struct page **page_array)=
;
>  #ifdef CONFIG_MEMCG
> +struct mem_cgroup *bpf_map_memcg_enter(const struct bpf_map *map,
> +                                      struct mem_cgroup **memcg);
> +void bpf_map_memcg_exit(struct mem_cgroup *old_memcg,
> +                       struct mem_cgroup *memcg);
>  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t=
 flags,
>                            int node);
>  void *bpf_map_kmalloc_nolock(const struct bpf_map *map, size_t size, gfp=
_t flags,
> @@ -2632,6 +2636,17 @@ void __percpu *bpf_map_alloc_percpu(const struct b=
pf_map *map, size_t size,
>                 kvcalloc(_n, _size, _flags)
>  #define bpf_map_alloc_percpu(_map, _size, _align, _flags)      \
>                 __alloc_percpu_gfp(_size, _align, _flags)
> +static inline struct mem_cgroup *bpf_map_memcg_enter(const struct bpf_ma=
p *map,
> +                                                    struct mem_cgroup **=
memcg)
> +{
> +       *memcg =3D NULL;
> +       return NULL;
> +}
> +
> +static inline void bpf_map_memcg_exit(struct mem_cgroup *old_memcg,
> +                                     struct mem_cgroup *memcg)
> +{
> +}
>  #endif
>
>  static inline int
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a4d38272d8bc..e7c0c469c60e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -505,17 +505,29 @@ static struct mem_cgroup *bpf_map_get_memcg(const s=
truct bpf_map *map)
>         return root_mem_cgroup;
>  }
>
> +struct mem_cgroup *bpf_map_memcg_enter(const struct bpf_map *map,
> +                                      struct mem_cgroup **memcg)
> +{
> +       *memcg =3D bpf_map_get_memcg(map);
> +       return set_active_memcg(*memcg);
> +}

A bit odd to return two pointers differently. One as return and another as
an argument.
Since it cannot fail let's return both as arguments.
That will match _exit() too.
bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
bpf_map_memcg_exit(old_memcg, new_memcg);

pw-bot: cr

