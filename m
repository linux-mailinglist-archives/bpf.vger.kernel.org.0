Return-Path: <bpf+bounces-66310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F480B323FC
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 23:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8DB189689A
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 21:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C209313552;
	Fri, 22 Aug 2025 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA4QHHUV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B89205AD7
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897291; cv=none; b=HH7OigZ1cdM72gAdEAI3Za1FuR3ZWjVeMt5KDsKbC/FIf3jf9zVolrRvA0tlXnzG5PYj3zk4F0AhAQEe2hZzrl8+ut2d45+nkTs6PXiNHIzi1I1Oo2nnj+BRJqeswXao9coRSRhn58v8GEhdMFH7VcSgRIVsMIxzP6cF4pKvZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897291; c=relaxed/simple;
	bh=PWYEQrWduq0+Jiko4Bli33in5MiPa6kdLNql8vdi6o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqJTGVf/90dbm+xpoNv+tyRwZGBw02aauhgmcbd9rsz6lk0Jvnk26+dQuU1cGoTIIUnGCkQx4d2rgCltF21rPS9gx2ZShKnDbQSh+2dik4zVEU2oucBHtJl7b11LPPUlB8KpPC+5agWyeJSxTDrHzm4Ie2hc0Fxsy9Wxzn/Os78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA4QHHUV; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53b1736eae2so1874367e0c.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755897289; x=1756502089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt7OxrD6mry8W8s8THghB14IgXRJDQLnErBlhginQ+4=;
        b=OA4QHHUVIOr08RDjTmnJ6hda17JgZAQJSJRnT/w7H13xox9vYYNuwDpFPs9v/LYCvy
         NJzOnIrXbYMceJ31jiWZNyR9lBJhKvIP3WVBg6fKbag/uhdmIUBfwoJis/h4muvKUARK
         nGD6SCfsSiLPfx4g9FJbVQ6+Q29qV9MTpZtEoBISYdq50+HFaT4IVTQQ1h//hiXZmLYJ
         9WXjwvqH0K4OPDvq6FijZvrFQTtdR7K1TKX+zoLo7ROadwSFgCx8qDcpK9zIntadnF3v
         +tPmP7Rf2zfCE/YkISbBTqvDeOjMIxz5SGmFKEjA4sigVKXvLNDjjY3E00N+t+wd8RaE
         mMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897289; x=1756502089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bt7OxrD6mry8W8s8THghB14IgXRJDQLnErBlhginQ+4=;
        b=OTGZtTWoi2SxAWZspjt9/vtC/YhiQ5nbHJzmtwAaS5M/XO9nPzRLqE7LGLpWwy7iZg
         UzE2sBP4+9d7hXBqeKaXrSwYqShKAaOcKAvOhuywASiwd7yWDA+D3dguVbNTSRT/oZ64
         XoIf1LNwoYklk9IEYIVAKKar3gu+R7dvn+KU/I7VlDYw5I+dZ0vWEY76WYnPuuH5f/UO
         vrU+TiJuPaO/9366sT3Cj2b4Cu936OsGhIvglN2d4Wk8qy7SgY4ZqxmF9Fbe2peAgatx
         5VLjq5y9KAxT87iLiCzHLbnV26SKPs6sEZxutlRrXDTs9u4F726INtMXxeK6z1u/TZXu
         zhvA==
X-Forwarded-Encrypted: i=1; AJvYcCWgDjn8XpabCF4J6ELbHzT2Eq2HAOTAQSiMHqM8FOyGHDLFHyWQfTRd7WAvZbx0PcubDQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNxvmuDsSJblDkT7A+OP0Qogzg4Nef3Xd81IHgemE45PQyeIS
	RJwy7TL7dt+0FeANpOrQzn0tv3n4ZaYKq5s+qLcI8IUf5AkcOOnG5moOmO+nLOw7VlySwAmFbTj
	F48xi6Z70PfxTYEYDRi0xGEPZCKheqt8=
X-Gm-Gg: ASbGncu6Gvjk6gvFNMEP8vSMaMEcxlVo3FdaBDkgZA8jm35F/AQHvslkuii3faQxoqX
	WX8sITZcRDpB7Z/D2wqHEM9iNeYu+s0qiKk1elScJeReVF2hYNtOYZ5aOIeD5FWcUYiQqXlS7hB
	Y4V1bWsXpA6EgS3AV/+2yKEGQSiDpha6WOhpOboZ1dU/pYx9tZQyrX52efZP4UiUI/QM2MvwgBD
	Ud73IswnQMGjSIu0twdGHw7H1Q415pSjFEVlui+bN7KVo68/JDS
X-Google-Smtp-Source: AGHT+IGMjvu3uX1kittLtjldDSNkRLUAYFr7638Dw+2Uti7+fpWNJ09L3/LcNeqcgKCKycbArweAw7/XFiJH4jgSJ+s=
X-Received: by 2002:a05:6122:1686:b0:539:8b51:fbe8 with SMTP id
 71dfb90a1353d-53c8a0fbae2mr1466534e0c.0.1755897289010; Fri, 22 Aug 2025
 14:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
In-Reply-To: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Fri, 22 Aug 2025 17:14:38 -0400
X-Gm-Features: Ac12FXy5FW9S7Qck831UVX2mYT_YSCVhieCK2X0tdHA1IsDUL0OXSlmLCn4PrPE
Message-ID: <CAM=Ch06h4Uf8RsRikPj5JJOpGc5DSmznWRKc4MVZAVzdJWB0ZA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of tnum_mul
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:08=E2=80=AFPM Nandakumar Edamana
<nandakumar@nandakumar.co.in> wrote:
>
> This commit addresses a challenge explained in an open question ("How
> can we incorporate correlation in unknown bits across partial
> products?") left by Harishankar et al. in their paper:
> https://arxiv.org/abs/2105.05398
>
> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> from which we could find two possible partial products and take a
> union. Experiment shows that applying this technique in long
> multiplication improves the precision in a significant number of cases
> (at the cost of losing precision in a relatively lower number of
> cases).
>
> This commit also removes the value-mask decomposition technique
> employed by Harishankar et al., as its direct incorporation did not
> result in any improvements for the new algorithm.
>
> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---
>  include/linux/tnum.h |  3 +++
>  kernel/bpf/tnum.c    | 47 ++++++++++++++++++++++++++++++++------------
>  2 files changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> index 57ed3035cc30..68e9cdd0a2ab 100644
> --- a/include/linux/tnum.h
> +++ b/include/linux/tnum.h
> @@ -54,6 +54,9 @@ struct tnum tnum_mul(struct tnum a, struct tnum b);
>  /* Return a tnum representing numbers satisfying both @a and @b */
>  struct tnum tnum_intersect(struct tnum a, struct tnum b);
>
> +/* Returns a tnum representing numbers satisfying either @a or @b */
> +struct tnum tnum_union(struct tnum t1, struct tnum t2);
> +
>  /* Return @a with all but the lowest @size bytes cleared */
>  struct tnum tnum_cast(struct tnum a, u8 size);
>
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index fa353c5d550f..50e4d34d4774 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -116,31 +116,39 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
>         return TNUM(v & ~mu, mu);
>  }
>
> -/* Generate partial products by multiplying each bit in the multiplier (=
tnum a)
> - * with the multiplicand (tnum b), and add the partial products after
> - * appropriately bit-shifting them. Instead of directly performing tnum =
addition
> - * on the generated partial products, equivalenty, decompose each partia=
l
> - * product into two tnums, consisting of the value-sum (acc_v) and the
> - * mask-sum (acc_m) and then perform tnum addition on them. The followin=
g paper
> - * explains the algorithm in more detail: https://arxiv.org/abs/2105.053=
98.
> +/* Perform long multiplication, iterating through the trits in a.
> + * Inside `else if (a.mask & 1)`, instead of simply multiplying b with L=
SB(a)'s
> + * uncertainty and accumulating directly, we find two possible partial p=
roducts
> + * (one for LSB(a) =3D 0 and another for LSB(a) =3D 1), and add their un=
ion to the
> + * accumulator. This addresses an issue pointed out in an open question =
("How
> + * can we incorporate correlation in unknown bits across partial product=
s?")
> + * left by Harishankar et al. (https://arxiv.org/abs/2105.05398), improv=
ing
> + * the general precision significantly.
>   */
>  struct tnum tnum_mul(struct tnum a, struct tnum b)
>  {
> -       u64 acc_v =3D a.value * b.value;
> -       struct tnum acc_m =3D TNUM(0, 0);
> +       struct tnum acc =3D TNUM(0, 0);
>
>         while (a.value || a.mask) {
>                 /* LSB of tnum a is a certain 1 */
>                 if (a.value & 1)
> -                       acc_m =3D tnum_add(acc_m, TNUM(0, b.mask));
> +                       acc =3D tnum_add(acc, b);
>                 /* LSB of tnum a is uncertain */
> -               else if (a.mask & 1)
> -                       acc_m =3D tnum_add(acc_m, TNUM(0, b.value | b.mas=
k));
> +               else if (a.mask & 1) {
> +                       /* acc =3D tnum_union(acc_0, acc_1), where acc_0 =
and
> +                        * acc_1 are partial accumulators for cases
> +                        * LSB(a) =3D certain 0 and LSB(a) =3D certain 1.
> +                        * acc_0 =3D acc + 0 * b =3D acc.
> +                        * acc_1 =3D acc + 1 * b =3D tnum_add(acc, b).
> +                        */
> +
> +                       acc =3D tnum_union(acc, tnum_add(acc, b));
> +               }
>                 /* Note: no case for LSB is certain 0 */
>                 a =3D tnum_rshift(a, 1);
>                 b =3D tnum_lshift(b, 1);
>         }
> -       return tnum_add(TNUM(acc_v, 0), acc_m);
> +       return acc;
>  }
>
>  /* Note that if a and b disagree - i.e. one has a 'known 1' where the ot=
her has
> @@ -155,6 +163,19 @@ struct tnum tnum_intersect(struct tnum a, struct tnu=
m b)
>         return TNUM(v & ~mu, mu);
>  }
>
> +/* Returns a tnum with the uncertainty from both a and b, and in additio=
n, new
> + * uncertainty at any position that a and b disagree. This represents a
> + * superset of the union of the concrete sets of both a and b. Despite t=
he
> + * overapproximation, it is optimal.
> + */
> +struct tnum tnum_union(struct tnum a, struct tnum b)
> +{
> +       u64 v =3D a.value & b.value;
> +       u64 mu =3D (a.value ^ b.value) | a.mask | b.mask;
> +
> +       return TNUM(v & ~mu, mu);
> +}
> +
>  struct tnum tnum_cast(struct tnum a, u8 size)
>  {
>         a.value &=3D (1ULL << (size * 8)) - 1;
> --
> 2.39.5
>

I was able to confirm the soundness of the algorithm in z3 for 8-bits
by unrolling the
loop [1] (assuming my encoding of the algorithm in logic is correct).

python3 tnum.py --bitwidth 8 --op tnum_new_mul
Verifying correctness of [tnum_new_mul] for tnums of width [8] ...
 SUCCESS.

https://github.com/bpfverif/tnums-cgo22/blob/dafc49f929c1160d81c39808fac98c=
0f55e639f3/verification/tnum.py#L279

Having said that,
Reviewed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

