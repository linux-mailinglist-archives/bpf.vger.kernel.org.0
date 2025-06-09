Return-Path: <bpf+bounces-60072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4028CAD251A
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 19:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A77216F07F
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAAE21B9FD;
	Mon,  9 Jun 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxFchhEB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4521B9DB
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490761; cv=none; b=rnuYZTooZhh5vswIsaM1Qw4Usu+Ftz9xJZ+0tHaYVIEnVe/9KtyC0kMNGeyZcCeRkFId9k/Bf1Bs9uHvpHhMEJbrjTGh8NVPxxTp1bzKfgbZnVDBbD3Pu6kDGZXIPN5IySINRBLlgelJxjBsTH++XvrGBGNaG0SJIq7fzJvs3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490761; c=relaxed/simple;
	bh=vDEZLmFiWUgAEhhMnpPxC2x5ptegpxqcBtIXF4EgUvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTt2fEwU9ZtuxdgJnCZAnA83f9BZuE6SBYXJUCwdtGEwtdtFsYAuW6HyIRwcS+dk9U4C8QUcy9aKuvzXfYDCj/prWg4NwC04EhUP4Qn9Gxrsai+/yzZjIi214lkojGtRlGSJ9yfex1nDx1fzx1hPqExZRfYV3R+Sz31bDpVH3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxFchhEB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e389599fso25695ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 10:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749490759; x=1750095559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RRpRkvuNJy3cXkOhH8biChoDOFuxh8lZ/u2fpQqLzg=;
        b=UxFchhEB/EOTc0w70KhZaY15W09uYu6jXZOdr2ase+hIfTCPnYc/ZCm8tpKuJPWiOY
         xZJfxn+61Ida+6G3EvB/BAOPBOyt9hI4GgbeyzuBG9TCxdpv0yWiNx+10mK38OG8e0YT
         njTgmMc4zguYLqaxNenGblIq6z0Z8wqh9hm59Kfbjy+dkQUMe6KED7usY9RvlBxgF+3i
         pCE1id1SQeHxgEQygp3chDNtfyiTg+MIK2RFk9nxvVh6TbdJiCQv8iz16M15ZPipF32q
         Gs6Q9ysEJjPpaVmI39FOiyCGGRz2hKEMgb7wWg+9x67ahJ6X0DcMqFebPc/FxvZhcJM1
         zfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749490759; x=1750095559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RRpRkvuNJy3cXkOhH8biChoDOFuxh8lZ/u2fpQqLzg=;
        b=w9n7KQvGOA7InLJmn5N90a/xq8v8Pv3ZFNPfELysp7Fe9jd/gE7jnWpnXnT9XovdAn
         CWRivLt9lWgw6phmsHNtADfmYjr6eZkewSRcKUfMpfVkBNKq2BqKKmFIDDxGwIziiDEM
         7E9zAVMw5jEeHJwG/Nc3vdZR9DgnG4BZMae/Sdt1az/2ReusYVj7XIN4sS9Hu3jOm2t/
         Y3BVqTkYMaA6ct5uxkt5lTfo3OxEWXbrcbDO6vF6I7fBNZjOyja79tyZ82nDNzUZWKkv
         Q1y8cxDhQmawTwadt8X1qz30xPwH6KdGD8wzR7Rr/fUNUYdzMwRJwDcwWSbNzBAugzfs
         Oxnw==
X-Forwarded-Encrypted: i=1; AJvYcCVJl1pY24j4XTdQKXxUX3ANEHmPLq9qIuclQAsAFqctVMkxbTki26XoVbiQeQgzdwWVPaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EgSv1Vx+YjgCImtYqAE8N7vb4Caua4cGo83CW/jK3j1PCl7D
	rj4uHQ9gKut9vLCcwE3mku7+rSz2X42xdro/+h0DmT/sbXgXWJC0QjAu954Vbyl/I+op93tmtF6
	q5NmdjtPiDYlrcbsc9315Dh+vMCtNLvNFhvqdx5Wf
X-Gm-Gg: ASbGncvYATEZRDlXEPzSqBtM7YweiqP3LUy3Km1KyXGebrkLrZaFzMcyt9Q94j26WUi
	MZ9zvfRAgXdDbkRUmDOFn2hhTW+BaY3Vm8POtK1ny1soNnp3kxpGgAmNksaFu5PjharITt9VSQE
	FZK8DjuStIFDFy7lV+B5EnjnfOdyUq97srbVoLb9n4Fg+/JzsMB77dgPWPqG7BAc/aqFNmYgf4B
	g==
X-Google-Smtp-Source: AGHT+IEvrq24XpltBFWvdSIlKpCIc8JCZdMNJ6F/M800m9IOuRhKavTYagOECC3DsNK5G3lKUSM8nYe/B6o3T3jdn9Q=
X-Received: by 2002:a17:902:e745:b0:231:ed22:e230 with SMTP id
 d9443c01a7336-23613de3742mr5147245ad.15.1749490759104; Mon, 09 Jun 2025
 10:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-10-byungchul@sk.com>
In-Reply-To: <20250609043225.77229-10-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 9 Jun 2025 10:39:06 -0700
X-Gm-Features: AX0GCFuAdxMyfuOpDJOl1NBEK5X2zXvXF5ManUgjd3SO6IAFQ752DFSmiJ8__HE
Message-ID: <CAHS8izMLnyJNnK-K-kR1cSt0LOaZ5iGSYsM2R=QhTQDSjCm8pg@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 9:32=E2=80=AFPM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid directly accessing page pool
> members of struct page.
>
> Access ->pp_magic through struct netmem_desc instead of directly
> accessing it through struct page in page_pool_page_is_pp().  Plus, move
> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> without header dependency issue.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  include/linux/mm.h   | 12 ------------
>  include/net/netmem.h | 14 ++++++++++++++
>  mm/page_alloc.c      |  1 +
>  3 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e51dba8398f7..f23560853447 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   */
>  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return false;
> -}
> -#endif
> -
>  #endif /* _LINUX_MM_H */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index d84ab624b489..8f354ae7d5c3 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>   */
>  static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct page, _ref=
count));
>
> +#ifdef CONFIG_PAGE_POOL
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +       struct netmem_desc *desc =3D (struct netmem_desc *)page;
> +
> +       return (desc->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> +}
> +#else
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +       return false;
> +}
> +#endif
> +
>  /* net_iov */
>
>  DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4f29e393f6af..be0752c0ac92 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -55,6 +55,7 @@
>  #include <linux/delayacct.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/pgalloc_tag.h>
> +#include <net/netmem.h>

mm files starting to include netmem.h is a bit interesting. I did not
expect/want dependencies outside of net. If anything the netmem stuff
include linux/mm.h

But I don't have a butter suggestion here and I don't see any huge
problems with this off the top of my head, so

Reviewed-by: Mina Almasry <almasrymina@google.com>

Lets see if Jakub objects though. To be fair, we did put the netmem
private stuff in net/core/netmem_priv.h, so technically
include/net/netmem.h should be exportable indeed.

--=20
Thanks,
Mina

