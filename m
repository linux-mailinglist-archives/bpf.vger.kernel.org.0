Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019E0301E3
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 20:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE3S1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 14:27:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44254 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfE3S1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 14:27:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id x47so4801469qtk.11;
        Thu, 30 May 2019 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U39CGluTtC101GGj3eC1sfgooLLaLn7la6O3dF2wb8k=;
        b=KHfmzG1FEGNUAmw9P2qZ1gedjA7AErUpKZtbPUaPnpaXO/fexEqq/ViqxeLhRwG4rS
         23zD3OsjzxmTMVp4chldJpszpaA8jEDGJNb3DxvILL3rxrNlz+/eUNb1F1UhFatP5NAl
         a7aevFI1SVBYqIzmLUpX04AynDtGreky9lqcUQkHC1b0swcnUzt50lZKr9W9N0VzIdy9
         xvgUhwrD+M4WCTM+3xzIS/K7s7QCvUtk9nFM9spYCRXaqf3K8WCJbsizhvSMwEEQTZJo
         pkGNcpzvWwsvBy+l84A4kM1d+lH05vsfL276FUAoNIuUg9NPbaH0tQ912vcHNuNhsYDj
         BLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U39CGluTtC101GGj3eC1sfgooLLaLn7la6O3dF2wb8k=;
        b=ck5sNSNj1RtI2aWFttjBANK9bfLv80TZC8E9nKO6UH9Vwz+PzkfMh/0KG1VBJek7V7
         v05MII4YjfQ39Cy72EQRreLJ4bJh3G3K3/PFeiaK47eF7aAX5PXUZyEj9tXhjfBRFMEd
         GqEzu/ZURkllRfrKiLjhI/hj2KTv5xKmnWlch4PLbcj0/EwNBKsibIG+rqAk8HVZF2AT
         G1iyiC2pJkS39I4dJOa4AQhpoudgV3nkwF93/6r4Lb56HdYfYIoAE35s8tMZoeIFUwci
         vK//gQDg/qDZYQgxz+auG4+QJkHA7EKlKTQ31AoqlTVoVvd+E3VxeQOTNQrU+WuVDmuj
         IkoQ==
X-Gm-Message-State: APjAAAUPfFYil87oRImHbjCqrd79r/uSlyNIv5073d5pAFHjqQLEOFoK
        /nJMHCJStIohIpFg1Vaj5l+GTUthhi5yA1GUzGQ=
X-Google-Smtp-Source: APXvYqwBedhtM7sICx5e8OtUsAq2knjHWe9TjbXGAFgyILtcmqp7M1CmMBTNv/0/1VmtVlzM8QshPwxUy3y3RcX7Njw=
X-Received: by 2002:a0c:bf4f:: with SMTP id b15mr4737694qvj.24.1559240819991;
 Thu, 30 May 2019 11:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190530010359.2499670-1-guro@fb.com> <20190530010359.2499670-3-guro@fb.com>
In-Reply-To: <20190530010359.2499670-3-guro@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 30 May 2019 11:26:48 -0700
Message-ID: <CAPhsuW68VmmryjT1owjGY1W0e=n_X6f6kOQm_di-BkCagioKmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: add memlock precharge for socket local storage
To:     Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 29, 2019 at 6:05 PM Roman Gushchin <guro@fb.com> wrote:
>
> Socket local storage maps lack the memlock precharge check,
> which is performed before the memory allocation for
> most other bpf map types.
>
> Let's add it in order to unify all map types.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  net/core/bpf_sk_storage.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index cc9597a87770..9a8aaf8e235d 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -626,7 +626,9 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
>         struct bpf_sk_storage_map *smap;
>         unsigned int i;
>         u32 nbuckets;
> +       u32 pages;
>         u64 cost;
> +       int ret;
>
>         smap = kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN);
>         if (!smap)
> @@ -635,13 +637,19 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
>
>         smap->bucket_log = ilog2(roundup_pow_of_two(num_possible_cpus()));
>         nbuckets = 1U << smap->bucket_log;
> +       cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
> +       pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> +
> +       ret = bpf_map_precharge_memlock(pages);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
> +
>         smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
>                                  GFP_USER | __GFP_NOWARN);
>         if (!smap->buckets) {
>                 kfree(smap);
>                 return ERR_PTR(-ENOMEM);
>         }
> -       cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
>
>         for (i = 0; i < nbuckets; i++) {
>                 INIT_HLIST_HEAD(&smap->buckets[i].list);
> @@ -651,7 +659,7 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
>         smap->elem_size = sizeof(struct bpf_sk_storage_elem) + attr->value_size;
>         smap->cache_idx = (unsigned int)atomic_inc_return(&cache_idx) %
>                 BPF_SK_STORAGE_CACHE_SIZE;
> -       smap->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
> +       smap->map.pages = pages;
>
>         return &smap->map;
>  }
> --
> 2.20.1
>
