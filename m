Return-Path: <bpf+bounces-39017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB496D94B
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A01F27F2A
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90319C57F;
	Thu,  5 Sep 2024 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKpk+/+A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E4E1991D9;
	Thu,  5 Sep 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540573; cv=none; b=EXyVg4A/Sxe/dF+NLHLuBA0JT328J1XuYaMg312SanZMW4z1tIhoMiCHbi02VJmqUjYQS1p0YTApjMHCAuaQ9OACN2cpCW3zv79nJ4oaQzR2cQ43JdWO+oPAEhzxPOc+Qdh/HOzpsDVat8gZH1etlT2ax4Uuqr3K6cnP8zJYuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540573; c=relaxed/simple;
	bh=c7RBUKDkdVrWL6djlFZ9hhuOHwJTYVXSlCQOXU7p9yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcDKK2SeLF/QqIZ2I0zGhXuDBv0B/ubQNmU/hTTzn1liRpKlmmMDy9G9F6qlDOMF/7Oce/3PCzPW6TYnct1jKH8Ms5G7J4NTOHmXsG1q4dKIT8qa5jwTs9L55VbM3uOuLBPkHVgZkItJ80V14192ryrAy9G6iid//c5NGLkpPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKpk+/+A; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-457ce5fda1aso4290711cf.1;
        Thu, 05 Sep 2024 05:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725540570; x=1726145370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vs17e4ooftcJ84yldqyZR0DLaKNs/fDVjQanLMu3ClM=;
        b=jKpk+/+AD+diIYlsZ4KwUlNuPiC7gtyxuIZ7REguw5CE0mJ6J2Or9yM7G4a8jIh04q
         /IdJRr5Y7UGmajCFoDeDjmkPhQrAbyQ7sjiiCLPeyFY1qxdWnuzffpkRUu9Q1XqykTct
         co+ExD0e8kXrh/5X/V7/5hbXezQKVMSFZU8qkvuG/Ns32BvlxryNNKaZmj2ycNvlwweb
         YqLEP58iorx9sRkoUVcaCcj+pjCvh5Yd5X30+0gTnTDHeLLeylZK6WLzwIzZ17TP8rsy
         vZiKNftbQ+FRe+fGpFdS3yh1Vlq3gI6Ft4cQN3buK44mJkd6yvkb+Tqox1PlmojpQGpd
         Wsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725540570; x=1726145370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vs17e4ooftcJ84yldqyZR0DLaKNs/fDVjQanLMu3ClM=;
        b=kKj7G7J9W3FxZz5scmqGagohObQvWnOsMn67jgvcVyl6Uf23a4BL4VkyQhLM5S2K8U
         aw7x/MeXI3NkVLTGZCSEGzfE3haxc0NEpl4ThhrQmi5YAsSn0IFDu6KBDO82IUOKq8TJ
         DJMSbCZrL5L2h+YSlgzLtVfYwStzpiAW5+4KJxjK35cK0OW8LmYRPLSLkBjmzZd/j3Ki
         i4NmzMRoi7wK2VPzGnlGCKeDzTK7+j9QyDT0+aIgrmmXnHqjRreJLS8VKkD/yLwtQStz
         g2TXgxhgDiHHaEkfFtPXbhn+RqkOR2OM5+AbW5ilZLwqiOyudo6AL8aA+N6nYKg+cnxQ
         8fmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYbYMFv91otj4btwVrE9Fsx6viOhXwYMF9Hu6w+0G7fA3vHOgDKd3w0rSNDeN7UCdUM1JyBd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCf4pePhkYeSonDfRI3zsKMsV4usjEHbF8FGCCwGF5fWzUKRt
	3s5CweZcThTAGm0bFfXV0rHxo2ajOwz6Fi4UC8joJIxWfVeUIpoyOVYm7cxxsvUsDytabqQWxrh
	H7ohH+6qwK2uqdTRwUIfsq210LoBnDZ0CFVcq+/KT
X-Google-Smtp-Source: AGHT+IG4893ExMAsuFF3XePDFM1RTqtOdBkShXu+XaIzHXAWIIi4yQzgI6vWopXnveUlxufL5mIp56EB2nG36GrW0IA=
X-Received: by 2002:a05:6214:33c2:b0:6c3:61bd:a10 with SMTP id
 6a1803df08f44-6c361bd17a5mr214843096d6.16.1725540569684; Thu, 05 Sep 2024
 05:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904162808.249160-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240904162808.249160-1-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 5 Sep 2024 14:49:18 +0200
Message-ID: <CAJ8uoz0D3SfkJ8vW4d=uurLBBW33oye2+mzYJNXmQoPyM_jVfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] xsk: bump xsk_queue::queue_empty_descs in xp_can_alloc()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 18:46, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> We have STAT_FILL_EMPTY test case in xskxceiver that tries to process
> traffic with fill queue being empty which currently fails for zero copy
> ice driver after it started to use xsk_buff_can_alloc() API. That is
> because xsk_queue::queue_empty_descs is currently only increased from
> alloc APIs and right now if driver sees that xsk_buff_pool will be
> unable to provide the requested count of buffers, it bails out early,
> skipping calls to xsk_buff_alloc{_batch}().
>
> Mentioned statistic should be handled in xsk_buff_can_alloc() from the
> very beginning, so let's add this logic now. Do it by open coding
> xskq_cons_has_entries() and bumping queue_empty_descs in the middle when
> fill queue currently has no entries.

Thanks Maciej.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk_buff_pool.c | 11 ++++++++++-
>  net/xdp/xsk_queue.h     |  5 -----
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index c0e0204b9630..29afa880ffa0 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -656,9 +656,18 @@ EXPORT_SYMBOL(xp_alloc_batch);
>
>  bool xp_can_alloc(struct xsk_buff_pool *pool, u32 count)
>  {
> +       u32 req_count, avail_count;
> +
>         if (pool->free_list_cnt >= count)
>                 return true;
> -       return xskq_cons_has_entries(pool->fq, count - pool->free_list_cnt);
> +       req_count = count - pool->free_list_cnt;
> +
> +       avail_count = xskq_cons_nb_entries(pool->fq, req_count);
> +
> +       if (!avail_count)
> +               pool->fq->queue_empty_descs++;
> +
> +       return avail_count >= req_count;
>  }
>  EXPORT_SYMBOL(xp_can_alloc);
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 6f2d1621c992..406b20dfee8d 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -306,11 +306,6 @@ static inline u32 xskq_cons_nb_entries(struct xsk_queue *q, u32 max)
>         return entries >= max ? max : entries;
>  }
>
> -static inline bool xskq_cons_has_entries(struct xsk_queue *q, u32 cnt)
> -{
> -       return xskq_cons_nb_entries(q, cnt) >= cnt;
> -}
> -
>  static inline bool xskq_cons_peek_addr_unchecked(struct xsk_queue *q, u64 *addr)
>  {
>         if (q->cached_prod == q->cached_cons)
> --
> 2.34.1
>
>

