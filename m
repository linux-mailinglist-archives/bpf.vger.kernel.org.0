Return-Path: <bpf+bounces-41678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86529999CC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 03:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A46282648
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5B1754B;
	Fri, 11 Oct 2024 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2agys2C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C03D6D;
	Fri, 11 Oct 2024 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611320; cv=none; b=aifBEnyG7yifaXwe2mIt2vxaaV6B3Dd43Klty95BYLMSWc7YsETZY0BiYiwOZZ8W14YUnhf3gVShxf3+gmA9PobfKuIVPO/AgF7cD2XKjRwNquNUTN8JgxiG68oZE/6r+qzGl77cjduU8LLZSgIJ4Mb6030wPgbfIMMk4AeAwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611320; c=relaxed/simple;
	bh=XIeuuvXjLXLXH1bKDit8wML0q7WZRltVqQ+s4r+O0Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjFY9Eye/u7NIb8THSJUndcekKzNLpb6xysPtxXLP7nCcmNjirSGyqNK1nuNNAd34AF67SNXjDuazRLoBbo6+pYd0ugPDrdt7IwvvEDijZXdQEdZO3PdwAPP/Z7rZgR5V2oSFvC+wJOUfUuYKTqr0jn+6nGc9WJZfdn09jjvBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2agys2C; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so1354334a91.0;
        Thu, 10 Oct 2024 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728611318; x=1729216118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Oeox1DY3lu8bwIT9G3sohtCKJP4RcMcoaDuW7SRu2w=;
        b=l2agys2CMZp7bwVHnfXenzUaMdM9Typ3ULiINePN/Fxl3d7G1H0WCZT6xTkDGCgDFq
         +CHS2Hkli4RtcQyf3e+Kz40Nhtl0JvA3ucKv3W4v+PwtnslZXCSRJ2XYlsZC/1L2r/76
         OfDXEW0xe+vavfNZuLvW6kyLmhld3TPQQheAD/afVKjAsybXdDy5IPiSOKotQyw/QNd7
         aVWDu9FtYcfWxm7zGY8Nc5iFNpnFQXnmMBXXEPl47e3O5otUtZFebgrKbDvOaVIGNO99
         LKEtHubpwDnRjOONRWTRAZN+biH6MwnzIE9I+fqAgGSfdxmc+iD47h3a7IcEkCMWmMAZ
         X9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728611318; x=1729216118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Oeox1DY3lu8bwIT9G3sohtCKJP4RcMcoaDuW7SRu2w=;
        b=GbQp6FSRdmpz7gT+zOCXnyQydZeKZcOoJS50oOo1yAxQ1pK2Dwd0wu89g6C+lhlZFH
         gt2bisF+x80p9x2pyae4vOYaY0g3Uuw5eXtVWT4lbyER0GEN9fzuWBMNcPAWn6Frc3GV
         PYhN+fD0sfh+HNYIj67FzFP+8IH62rg1DA3DpcODN1I4Fd2OzQ6GF/s2ZZgCgE/4etji
         MALmIT+wFYE2ju8XPytwA5CFWybLX004lBganmzDNv4WFYv/wTb0OUmdUaCv+g9ULaPH
         HEmnY3PiYd8qLlNDfNt0N1HlnDI8VUKIN9AP8Wc9LHRhU+Uhg4x8SNBiZW+azkHO3M8A
         OaaA==
X-Forwarded-Encrypted: i=1; AJvYcCV5VMnchLM4qC7tKFoxhJREggtnOv3VZR+hTEAizYMI8XyhOB2qIPd8zs1VR2xy5hhwsp0bAQJwePMU0KEa@vger.kernel.org, AJvYcCXQNlAT9iOqGd8PTT9vvBHvny+vWdOaxYoIMAwldNriD4hKGPW10pCzB7nllII0SdpottKMLBJ/52Vgw4/L3eCLWw==@vger.kernel.org, AJvYcCXk+SgiIpxXo4TggjgwLNyv7UkJdId+aVXY94AUHlPwRyTe49D021GvnCwMUS0jp3acyok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Nt2lFw+2Oubzime9///wPxP+NcoxcuwkCYMBNDQ77ab2xDG2
	nCImNVKJS3mT2HU91N7FMeW+/msyyV6im8zWQYZqOXbzkbXyMyH3BBOik9wfMtOF0qSOD3HXZaY
	JJp17Lty3d6kfddYB3/6Nr/Lwt7Q=
X-Google-Smtp-Source: AGHT+IHCkO1RyxYmBhIli5jU4/S24BMyPrhlWT/1AglajwH1bRZNc6R0U0EAcLol2DS5tyrMzHXf5FG3lgFhgT+9IwY=
X-Received: by 2002:a17:90a:d808:b0:2e2:d74f:65b5 with SMTP id
 98e67ed59e1d1-2e2f0ad1729mr1428363a91.16.1728611318395; Thu, 10 Oct 2024
 18:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009202009.884884-1-namhyung@kernel.org>
In-Reply-To: <20241009202009.884884-1-namhyung@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 18:48:26 -0700
Message-ID: <CAEf4BzYQenNtKPmWV=P3EsnqBsjNuAeXpC5ypL1k2z-H60i0=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Fix possible compiler warnings in hashmap
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The hashmap__for_each_entry[_safe] is accessing 'map' as if it's a
> pointer.  But it does without parentheses so passing a static hash map
> with an ampersand (like &slab_hash below) caused compiler warnings due
> to unmatched types.
>
>   In file included from util/bpf_lock_contention.c:5:
>   util/bpf_lock_contention.c: In function =E2=80=98exit_slab_cache_iter=
=E2=80=99:
>   linux/tools/perf/util/hashmap.h:169:32: error: invalid type argument of=
 =E2=80=98->=E2=80=99 (have =E2=80=98struct hashmap=E2=80=99)
>     169 |         for (bkt =3D 0; bkt < map->cap; bkt++)                 =
               \
>         |                                ^~
>   util/bpf_lock_contention.c:105:9: note: in expansion of macro =E2=80=98=
hashmap__for_each_entry=E2=80=99
>     105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
>         |         ^~~~~~~~~~~~~~~~~~~~~~~
>   /home/namhyung/project/linux/tools/perf/util/hashmap.h:170:31: error: i=
nvalid type argument of =E2=80=98->=E2=80=99 (have =E2=80=98struct hashmap=
=E2=80=99)
>     170 |                 for (cur =3D map->buckets[bkt]; cur; cur =3D cu=
r->next)
>         |                               ^~
>   util/bpf_lock_contention.c:105:9: note: in expansion of macro =E2=80=98=
hashmap__for_each_entry=E2=80=99
>     105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
>         |         ^~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> I've discovered this while prototyping the slab symbolization for perf
> lock contention.  So this code is not available yet but I'd like to fix
> the problem first.
>
> Also noticed bpf has the same code and the same problem.  I'll send a
> separate patch for them.
>

Yep, please do. Fixes look good, thanks.

>  tools/perf/util/hashmap.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
> index c12f8320e6682d50..0c4f155e8eb745d9 100644
> --- a/tools/perf/util/hashmap.h
> +++ b/tools/perf/util/hashmap.h
> @@ -166,8 +166,8 @@ bool hashmap_find(const struct hashmap *map, long key=
, long *value);
>   * @bkt: integer used as a bucket loop cursor
>   */
>  #define hashmap__for_each_entry(map, cur, bkt)                          =
   \
> -       for (bkt =3D 0; bkt < map->cap; bkt++)                           =
     \
> -               for (cur =3D map->buckets[bkt]; cur; cur =3D cur->next)
> +       for (bkt =3D 0; bkt < (map)->cap; bkt++)                         =
     \
> +               for (cur =3D (map)->buckets[bkt]; cur; cur =3D cur->next)
>
>  /*
>   * hashmap__for_each_entry_safe - iterate over all entries in hashmap, s=
afe
> @@ -178,8 +178,8 @@ bool hashmap_find(const struct hashmap *map, long key=
, long *value);
>   * @bkt: integer used as a bucket loop cursor
>   */
>  #define hashmap__for_each_entry_safe(map, cur, tmp, bkt)                =
   \
> -       for (bkt =3D 0; bkt < map->cap; bkt++)                           =
     \
> -               for (cur =3D map->buckets[bkt];                          =
     \
> +       for (bkt =3D 0; bkt < (map)->cap; bkt++)                         =
     \
> +               for (cur =3D (map)->buckets[bkt];                        =
     \
>                      cur && ({tmp =3D cur->next; true; });               =
     \
>                      cur =3D tmp)
>
> @@ -190,19 +190,19 @@ bool hashmap_find(const struct hashmap *map, long k=
ey, long *value);
>   * @key: key to iterate entries for
>   */
>  #define hashmap__for_each_key_entry(map, cur, _key)                     =
   \
> -       for (cur =3D map->buckets                                        =
     \
> -                    ? map->buckets[hash_bits(map->hash_fn((_key), map->c=
tx), map->cap_bits)] \
> +       for (cur =3D (map)->buckets                                      =
     \
> +                    ? (map)->buckets[hash_bits((map)->hash_fn((_key), (m=
ap)->ctx), (map)->cap_bits)] \
>                      : NULL;                                             =
   \
>              cur;                                                        =
   \
>              cur =3D cur->next)                                          =
     \
> -               if (map->equal_fn(cur->key, (_key), map->ctx))
> +               if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
>
>  #define hashmap__for_each_key_entry_safe(map, cur, tmp, _key)           =
   \
> -       for (cur =3D map->buckets                                        =
     \
> -                    ? map->buckets[hash_bits(map->hash_fn((_key), map->c=
tx), map->cap_bits)] \
> +       for (cur =3D (map)->buckets                                      =
     \
> +                    ? (map)->buckets[hash_bits((map)->hash_fn((_key), (m=
ap)->ctx), (map)->cap_bits)] \
>                      : NULL;                                             =
   \
>              cur && ({ tmp =3D cur->next; true; });                      =
     \
>              cur =3D tmp)                                                =
     \
> -               if (map->equal_fn(cur->key, (_key), map->ctx))
> +               if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
>
>  #endif /* __LIBBPF_HASHMAP_H */
> --
> 2.47.0.rc0.187.ge670bccf7e-goog
>
>

