Return-Path: <bpf+bounces-35109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CFC937C6C
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560D01F21D72
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93AC1474BE;
	Fri, 19 Jul 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHEKzi50"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF31474A4;
	Fri, 19 Jul 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413401; cv=none; b=ial16HaI2bOcXBo9TM3bw4RCAZnaghCNtQLVatRJrTeB0CQnYDvv6dMkPds2xSPunD7ccrm+QVy6mGnmA5f0g6ND2aWRzKU0+7ET7AcS9v9TNdSYS+9FxuUGzf7l+aQsjsBR0FOJbKor9sKhz2tRX96fF+TkbJz9M+F/fqBan5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413401; c=relaxed/simple;
	bh=ByQqO6yRUoYdXvd8U4QMkjKUwQkcpdK2VJKXSe7t8HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+Ks6EDz5t1/n5y8RFIRE22ldWfr9jHrkxz6Qo04TEadxNuLo/G+OOCL/EDlvHXclILrlWTsV2EIyGwSSQkaes7le4jyPdYpg7CZIwpsVWJveQJb4NO49l0Q0ESFcXSeRVDhHeQ6hVxvrKZkgWUUwv+R/wFcFuQPY6I+oJCQAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHEKzi50; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-80fa1509989so1124813241.0;
        Fri, 19 Jul 2024 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721413398; x=1722018198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAYT9wcosYGwlGACKbFHYcr5e0FKih5Fv1v3xvkzP7g=;
        b=NHEKzi50D+AxX9kLBfFLTz01DjusxIaO+5YS+YRNDhbrcyiA4nNWbY2Xi7Ea6FuAsa
         yHqRamsZyjsqUfp1MhKoyrDJ5KiRfNkjJJFqR6V53pjS2nfhZV0/WU5PVZe//5BhQlWw
         d43LjHMJC5TiLO047T0pqAfwpV9B1/lV+f8gNkeL9tIA0TnZKTVrA84E9PHEES8Sgx50
         kbeqcXWjBawJAiwgUjGeOZ9WtYgMU0bHrjQqIlp63fZfuB589GFoOMHprz5DmeFvp7bd
         oD/Fe53bphlrNUWbmtnQHIScjqWeAo8RbMFgcVrgyiSbVZtjH5vLLDdA1oECE7g6CBKE
         X/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721413398; x=1722018198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAYT9wcosYGwlGACKbFHYcr5e0FKih5Fv1v3xvkzP7g=;
        b=KD+DX8OQ0aoZLpm4juu9YcJTZU/zuKUOlR5Lbl8TDmABMX5wgDF0lon0dzbb32PY2X
         5r4h0IRlCcOyGXrcoGv+xjofKgstBr3TfjinNQUXYg1qNF7gF4eGb7R2UNFWePbxWCh3
         DapMGOzgxcSJYB9fgdR35bl4FY4FYMWjn1U4ct2Gjqta3nc7aIotGr8zibU6r/WiUvbs
         SXS5MTWu3pNRCI+xcTEN37CWY1ixtLf1xFK2amq1Yp7oi48HQrRzD1A2ZaWgOVBY3v2J
         QGldsKzrJRKYyDNhD8NbuZmeX69X+9GqlBnG0j7H+Ku3YP2GRmh6pcDoj9+bHRn95sYT
         G57A==
X-Forwarded-Encrypted: i=1; AJvYcCUO+unVNq5nV2PzONWat0m+qHgE8D96ZXuYS4wV6AUg4TfOovnSKNrFU47t52Q96Lgo+sfDFFfJuCb8kNsbee5X6EiiNjZpddGUrnFU/huO6WZaXtal9Jt6cpnAm49O1hApBeWnk1xs9TOu3JLDeWMLjt+FgY0PWN8D
X-Gm-Message-State: AOJu0YzmxIgBpWd5oze/df7B05+SXybUQlhs37Z19tI+KjphN4VhONUQ
	lj8hxx58VxtiEDL06gWUqOF7g573etAgS3fnTumcR7VW1cv35Ct6Kj6/MS+pd9DovvAU2oSKybb
	MmPrJPe6Jq9ePb6FGhy5/7MgE9gU=
X-Google-Smtp-Source: AGHT+IGqF9pjkq9IL0+IRf9LOiQvL6S45AvEcfY88+qLhCYMIg1BDUCKYrx/ENqH7OdfcF3bZIV/2j6FbVYhESjezNM=
X-Received: by 2002:a05:6102:cd3:b0:48c:37c1:34a8 with SMTP id
 ada2fe7eead31-4925c1fec7cmr6381672137.7.1721413398435; Fri, 19 Jul 2024
 11:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch> <20240719024653.77006-1-dracodingfly@gmail.com>
In-Reply-To: <20240719024653.77006-1-dracodingfly@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 19 Jul 2024 11:22:42 -0700
Message-ID: <CAF=yD-++mDGU=mm6LE5G6sVVwst7iq6NRicACzeHwOjEdf2Apw@mail.gmail.com>
Subject: Re: [PATCH v4] bpf: Fixed a segment issue when downgrade gso_size
To: Fred Li <dracodingfly@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, herbert@gondor.apana.org.au, john.fastabend@gmail.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:47=E2=80=AFPM Fred Li <dracodingfly@gmail.com> wr=
ote:
>
> Linearizing skb when downgrade gso_size because it may
> trigger the BUG_ON when segment skb as described in [1].
>
> v4 changes:
>   add fixed tag.
>
> v3 changes:
>   linearize skb if having frag_list as Willem de Bruijn suggested[2].
>
> [1] https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail=
.com/
> [2] https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.google=
rs.com.notmuch/
>
> Fixes: 2be7e212d5419 ("bpf: add bpf_skb_adjust_room helper")
> Signed-off-by: Fred Li <dracodingfly@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

For next time:
- add target: [PATCH bpf]
- use imperative mood in commit messages: "Linearize ..."

https://www.kernel.org/doc/Documentation/bpf/bpf_devel_QA.rst
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

> ---
>  net/core/filter.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index df4578219e82..71396ecfc574 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3525,13 +3525,21 @@ static int bpf_skb_net_grow(struct sk_buff *skb, =
u32 off, u32 len_diff,
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>
> -               /* Due to header grow, MSS needs to be downgraded. */
> -               if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
> -                       skb_decrease_gso_size(shinfo, len_diff);
> -
>                 /* Header must be checked, and gso_segs recomputed. */
>                 shinfo->gso_type |=3D gso_type;
>                 shinfo->gso_segs =3D 0;
> +
> +               /* Due to header grow, MSS needs to be downgraded.
> +                * There is BUG_ON when segment the frag_list with
> +                * head_frag true so linearize skb after downgrade
> +                * the MSS.
> +                */
> +               if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
> +                       skb_decrease_gso_size(shinfo, len_diff);
> +                       if (shinfo->frag_list)
> +                               return skb_linearize(skb);
> +               }
> +
>         }
>
>         return 0;
> --
> 2.33.0
>

