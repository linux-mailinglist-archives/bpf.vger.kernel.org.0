Return-Path: <bpf+bounces-71967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB77C03495
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 21:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F5D14F6D6D
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 19:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2679234DB68;
	Thu, 23 Oct 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8xVuc0O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEB34E75A
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249446; cv=none; b=luu+0TWw/RKJHr5PWcckdbwgsRm9pDpBQtSEvXpV1gbcbnMEd80sKCebTaxpX2UGm1BayXteu9v1Zggy/Zf4JwRpggpvmAf06C31fG/EM2CuJ1koFmLZiCwQnDW217Tw6m0aXClXRrkZCa+sb1G6eS4B46uZla1a/7a6RZ8oCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249446; c=relaxed/simple;
	bh=QOtIwdqj7hOoW4dyxEa9KcpQUMTiun6i65dHPetbI1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfV1jC/mwsEda53DPl/7rsHRGiEvAsM1zenYi63QEy03DqQmVZxAKgqZz+M6lTZ44fYwH6XA3o7OrvXRyA5cXibuGGYyQ+1VgJM4l4EHDbRTwMg8c3g8V5J1QR0C88bMTVMhC7kDXjggtqAJRdBH6doc5JhSoLURQDN3BktPd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8xVuc0O; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso230804766b.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761249443; x=1761854243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L7DG63VX9NHMNgCYdXEotzEYz+l54InR1Sf8DVAQoH0=;
        b=Z8xVuc0O2StbA0ZVJLswtNy3w0spQn6y6Yuerv+Hp7AXIOorCPcjZ7TzCX7eFh2g66
         HPtv4+HWWPi9EuDaY5lcSH12/XjYjDqpDP1FXigIIQMGcHBBbe/rQxkhr2UcZoodJ3iP
         C7z9XoEqxfjBZbh/QTi0FkE/PKpALeoJXpjzBL2l9xfJ7rS0lHr1DZPSYnNaX98+pi7L
         i1G36tkDyC0e/CM06Sy2fugdTKbt3sMqSk+/mODj7UO5J4VVMi96/SK15niUMXCi4Zp2
         XqJbgI+WsgzZAlE08jacxRJ8mplkm0LsMt9deVd6qBMLA1Reg69q+OkmSH9ElYfRvP8H
         xVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761249443; x=1761854243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7DG63VX9NHMNgCYdXEotzEYz+l54InR1Sf8DVAQoH0=;
        b=IcaA0s3bU5vutW+Sk972hgsAR2MSrDOGiUhptHt928HZkxIIBfE4oxU8uP7xxZQVeR
         NejlMT4AdU6y1NkqwX1tsp5OHSG1/fAEazEY9RrTASg72jntfkVWiFGWzOFpFNSdViRs
         zqJd5uq1yfRVwtM4ZSIBy7FBIwMZg4Ad2RG1meWlkYCeXYl7NLN/OCGMDQOYB6oAHwBn
         ub4kyHNZwQDyPDINtehJsfo0F4PmosIrLcB/uw9jZBMsFr2Tcur4JBR0rIEPNO1uIFLw
         sxbCb1WgGMr9Wgh4yNk387vNgZYu4FrBXaM13n0mmpoFmkxk5AL5qFNtKs3ve40meaD6
         6f7A==
X-Gm-Message-State: AOJu0Yx5NWbrAEXSfndnTnuXZMy0DZSPlfk3SIgK6l98hBvZq7q5t/BU
	kGib0G1rorgsBjPrlLRsBZBQXWL8/YZuyxOuRhI1xh1BQuQxsK1MbOJQcGjTKIAaQ6z7Di81f23
	YdXFi+t9xjkgJQMaaiQ0BvVfXOAMiVDIuS2Uk5DgpJQ==
X-Gm-Gg: ASbGncvs7t4pMbCa3s45Wk/fkuEWGLLFQnZfg/LfoWAXvqRKCM5YiHlGIDYeF/kxj/t
	mP9ZCK0xVPFtc3RuJra9xL/EpPtRSTA3iSsqxlPLYBNQKD0RmSAQFXFi8UxVz1hDJ+gRZOZVxce
	wNzcmhFgneTOCQzcC/PBCuNXsOI59v2kvII6xfmV2AsYdtnhxoCWu9e1aeZH9UUVGMksaRX1MWA
	Bs6v5YgCJzwRuxBr8Pp2bDqRriIjTq5ovVjJSt0yFmhUN4RSfHMcLGZwr147oXZtOA0fK0B8/ur
	kuRQhqy91ZAfOHeLGCT+RP4FhqbU
X-Google-Smtp-Source: AGHT+IEmxG0if5tM44uFlwxij4lDmoEGZ9UP80i05hw6YEDmF7z1yJpMAnTKHfcySS1Vodt7m3oT/Xfy8RbmicM28gg=
X-Received: by 2002:a17:906:7308:b0:b46:6718:3f20 with SMTP id
 a640c23a62f3a-b6473f4245cmr3441020966b.48.1761249442613; Thu, 23 Oct 2025
 12:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023161448.4263-1-puranjay@kernel.org>
In-Reply-To: <20251023161448.4263-1-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 23 Oct 2025 21:56:46 +0200
X-Gm-Features: AWmQ_blNATIavbVZCIDwCIqkWoDmavvFA1iU54rnJNqvJ89rrjjNu3cCSmp8hfQ
Message-ID: <CAP01T74MS9fWmboh=vYeP=sQJT68E-naOUVfAV66xYjy6BH7NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: stream: start using kmalloc_nolock()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 18:18, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> BPF stream kfuncs need to be non-sleeping as they can be called from
> programs running in any context, this requires a way to allocate memory
> from any context. Currently, this is done by a custom per-CPU NMI-safe
> bump allocation mechanism, backed by try_alloc_pages() and
> free_pages_nolock() primitives.
>
> As kmalloc_nolock() and kfree_nolock() primitives are available now, the
> custom allocator can be removed in favor of these.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

One nit below.

>  kernel/bpf/stream.c | 159 +++-----------------------------------------
>  1 file changed, 8 insertions(+), 151 deletions(-)
>
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index eb6c5a21c2ef..593976a5d6c8 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -4,111 +4,10 @@
>  #include <linux/bpf.h>
>  #include <linux/filter.h>
>  #include <linux/bpf_mem_alloc.h>
> -#include <linux/percpu.h>
> -#include <linux/refcount.h>
>  #include <linux/gfp.h>
>  #include <linux/memory.h>
> -#include <linux/local_lock.h>
>  #include <linux/mutex.h>
>
> -/*
> - * Simple per-CPU NMI-safe bump allocation mechanism, backed by the NMI-safe
> - * try_alloc_pages()/free_pages_nolock() primitives. We allocate a page and
> - * stash it in a local per-CPU variable, and bump allocate from the page
> - * whenever items need to be printed to a stream. Each page holds a global
> - * atomic refcount in its first 4 bytes, and then records of variable length
> - * that describe the printed messages. Once the global refcount has dropped to
> - * zero, it is a signal to free the page back to the kernel's page allocator,
> - * given all the individual records in it have been consumed.
> - *
> - * It is possible the same page is used to serve allocations across different
> - * programs, which may be consumed at different times individually, hence
> - * maintaining a reference count per-page is critical for correct lifetime
> - * tracking.
> - *
> - * The bpf_stream_page code will be replaced to use kmalloc_nolock() once it
> - * lands.
> - */
> -struct bpf_stream_page {
> -       refcount_t ref;
> -       u32 consumed;
> -       char buf[];
> -};
> -
> -/* Available room to add data to a refcounted page. */
> -#define BPF_STREAM_PAGE_SZ (PAGE_SIZE - offsetofend(struct bpf_stream_page, consumed))
> -
> -static DEFINE_PER_CPU(local_trylock_t, stream_local_lock) = INIT_LOCAL_TRYLOCK(stream_local_lock);
> -static DEFINE_PER_CPU(struct bpf_stream_page *, stream_pcpu_page);
> -
> -static bool bpf_stream_page_local_lock(unsigned long *flags)
> -{
> -       return local_trylock_irqsave(&stream_local_lock, *flags);
> -}
> -
> -static void bpf_stream_page_local_unlock(unsigned long *flags)
> -{
> -       local_unlock_irqrestore(&stream_local_lock, *flags);
> -}
> -
> -static void bpf_stream_page_free(struct bpf_stream_page *stream_page)
> -{
> -       struct page *p;
> -
> -       if (!stream_page)
> -               return;
> -       p = virt_to_page(stream_page);
> -       free_pages_nolock(p, 0);
> -}
> -
> -static void bpf_stream_page_get(struct bpf_stream_page *stream_page)
> -{
> -       refcount_inc(&stream_page->ref);
> -}
> -
> -static void bpf_stream_page_put(struct bpf_stream_page *stream_page)
> -{
> -       if (refcount_dec_and_test(&stream_page->ref))
> -               bpf_stream_page_free(stream_page);
> -}
> -
> -static void bpf_stream_page_init(struct bpf_stream_page *stream_page)
> -{
> -       refcount_set(&stream_page->ref, 1);
> -       stream_page->consumed = 0;
> -}
> -
> -static struct bpf_stream_page *bpf_stream_page_replace(void)
> -{
> -       struct bpf_stream_page *stream_page, *old_stream_page;
> -       struct page *page;
> -
> -       page = alloc_pages_nolock(/* Don't account */ 0, NUMA_NO_NODE, 0);
> -       if (!page)
> -               return NULL;
> -       stream_page = page_address(page);
> -       bpf_stream_page_init(stream_page);
> -
> -       old_stream_page = this_cpu_read(stream_pcpu_page);
> -       if (old_stream_page)
> -               bpf_stream_page_put(old_stream_page);
> -       this_cpu_write(stream_pcpu_page, stream_page);
> -       return stream_page;
> -}
> -
> -static int bpf_stream_page_check_room(struct bpf_stream_page *stream_page, int len)
> -{
> -       int min = offsetof(struct bpf_stream_elem, str[0]);
> -       int consumed = stream_page->consumed;
> -       int total = BPF_STREAM_PAGE_SZ;
> -       int rem = max(0, total - consumed - min);
> -
> -       /* Let's give room of at least 8 bytes. */
> -       WARN_ON_ONCE(rem % 8 != 0);
> -       rem = rem < 8 ? 0 : rem;
> -       return min(len, rem);
> -}
> -
>  static void bpf_stream_elem_init(struct bpf_stream_elem *elem, int len)
>  {
>         init_llist_node(&elem->node);
> @@ -116,54 +15,12 @@ static void bpf_stream_elem_init(struct bpf_stream_elem *elem, int len)
>         elem->consumed_len = 0;
>  }
>
> -static struct bpf_stream_page *bpf_stream_page_from_elem(struct bpf_stream_elem *elem)
> -{
> -       unsigned long addr = (unsigned long)elem;
> -
> -       return (struct bpf_stream_page *)PAGE_ALIGN_DOWN(addr);
> -}
> -
> -static struct bpf_stream_elem *bpf_stream_page_push_elem(struct bpf_stream_page *stream_page, int len)
> -{
> -       u32 consumed = stream_page->consumed;
> -
> -       stream_page->consumed += round_up(offsetof(struct bpf_stream_elem, str[len]), 8);
> -       return (struct bpf_stream_elem *)&stream_page->buf[consumed];
> -}
> -
> -static struct bpf_stream_elem *bpf_stream_page_reserve_elem(int len)
> -{
> -       struct bpf_stream_elem *elem = NULL;
> -       struct bpf_stream_page *page;
> -       int room = 0;
> -
> -       page = this_cpu_read(stream_pcpu_page);
> -       if (!page)
> -               page = bpf_stream_page_replace();
> -       if (!page)
> -               return NULL;
> -
> -       room = bpf_stream_page_check_room(page, len);
> -       if (room != len)
> -               page = bpf_stream_page_replace();
> -       if (!page)
> -               return NULL;
> -       bpf_stream_page_get(page);
> -       room = bpf_stream_page_check_room(page, len);
> -       WARN_ON_ONCE(room != len);
> -
> -       elem = bpf_stream_page_push_elem(page, room);
> -       bpf_stream_elem_init(elem, room);
> -       return elem;
> -}
> -
>  static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
>  {
>         const int max_len = ARRAY_SIZE((struct bpf_bprintf_buffers){}.buf);
>         struct bpf_stream_elem *elem;
> -       unsigned long flags;
> +       size_t alloc_size;
>
> -       BUILD_BUG_ON(max_len > BPF_STREAM_PAGE_SZ);
>         /*
>          * Length denotes the amount of data to be written as part of stream element,
>          * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
> @@ -172,10 +29,13 @@ static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
>         if (len < 0 || len > max_len)
>                 return NULL;
>
> -       if (!bpf_stream_page_local_lock(&flags))
> +       alloc_size = round_up(offsetof(struct bpf_stream_elem, str[len]), 8);

nit: Is this round_up necessary anymore? I would just drop it.

> +       elem = kmalloc_nolock(alloc_size, __GFP_ZERO, -1);
> +       if (!elem)
>                 return NULL;
> -       elem = bpf_stream_page_reserve_elem(len);
> -       bpf_stream_page_local_unlock(&flags);
> +
> +       bpf_stream_elem_init(elem, len);
> +
>         return elem;
>  }
>
> @@ -231,10 +91,7 @@ static struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, struct bp
>
>  static void bpf_stream_free_elem(struct bpf_stream_elem *elem)
>  {
> -       struct bpf_stream_page *p;
> -
> -       p = bpf_stream_page_from_elem(elem);
> -       bpf_stream_page_put(p);
> +       kfree_nolock(elem);
>  }
>
>  static void bpf_stream_free_list(struct llist_node *list)
> --
> 2.47.3
>
>

