Return-Path: <bpf+bounces-23060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B79F86D028
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB288280FBA
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B576CC01;
	Thu, 29 Feb 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWKcaEMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1F692F6
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226493; cv=none; b=d2BTniOwyQHmeiQSxh6tcBQrreLUm6e2tqk/fbmAK7xQ4D0P1h8B8B09a/b/F9yXL1DXRVJj8i0qHXDetnFafy3PmqkCvjvvbQhumzR/g8KD6pXBhiQk+2PG/Kc7gwusNjzZdy7KcYwQnnM6H/s5tnQGlGDxeZ7c8Cz0cFCJcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226493; c=relaxed/simple;
	bh=/rxNu2j8OFaTYcYQnIZwpRdT6xFuWFtYRRMuqs+n67o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCOkQY/FMnoEYHcmogSyHSngO7YEpQfxG1hXwdTJhdK/oqtzLHpCohCekBwCVL2UltLWfyJxDR9ivhPFd34SeXbb8I1TViWeecijN2hgg6NJ36iC2lKgQSgsPLY8CrhfSg1sfpZw0hyLIl9akjSAQ/BG1h5E65OCXmbbvJWZ3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWKcaEMH; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513235b5975so1564382e87.2
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226490; x=1709831290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sI00XjoZAywK0927SW0g2Wr/t1dR3eVrp9oN8BX9quA=;
        b=RWKcaEMHspMgzDJx0JJjrR/dh5Kq+z+ognba05I1oVKvX3cQA0S6aGceIHvHefz3a5
         COTo4KKdBBEm52g3ob88Ro2Ot8hfXZPleTcZ0v2szYue2RmmAlwFPjulTwrOpRagnY26
         Wkeeoaapy6WHbVT3mynLKnnTfHmmj8FrCVmvgHDnP0tsP8x7tChhn6Gr4Zx7Iovg30Ra
         waL5dIEH/pRZdZQpLs28EyQ5h4lMni4k6zqWfhKICLWpe5x0aJ4fGhgxJ/yktl54rhVk
         Y8mLmp982Ps0Tha0DozqzVQgdn5IeXsyEbcFZsGeD/odi4SMXKmSoa7MRuxemNV+dw6p
         09HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226490; x=1709831290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sI00XjoZAywK0927SW0g2Wr/t1dR3eVrp9oN8BX9quA=;
        b=asIdJcIbMMh4SNV05xRv/F/7H6yfDFg5Vy/kC7f1P6Sm9j1VW2hTtW8dda0dr2vnmm
         voeFFwEBrJC0fA+KwbVwuymEnDhblnRH1wzGnx0sG3CGYoXq6T2h+G2y7epJwRgqkv/2
         WlABUeWg0gm9tol7OiIcWHc6t+gy2CXCcFvFCUCMiGoREa8ml0IDwiaiSizz5MI5Uln/
         1sVfewOvASvSTJppgQx466MmEimumtiZUY2fkHHQq9JFsIWESOuY6OeazPQSNbZQBGId
         bKTc3uEAVdLwC67lvUYree9agfrwBJeOvwvBb9jFxxKdEHYqjcRPuCpWxauDbVRWyohw
         sjtA==
X-Forwarded-Encrypted: i=1; AJvYcCXnBuNwOihJsA8oxx4jyjYUk7KtILlYfx3zpfqV2WHcqoP8rE9x5Np86WoDmsISxhD5GIXfuGPbKHgGJ4pJRpfkvpDF
X-Gm-Message-State: AOJu0YwK+Tol9rWFHXaTqKq2vl1iM9amATkiKNrhFiAUC7AtL7aG/OZ2
	fkPAodOy3gNBxSmNBN8cwC2lI3dSVPm+lCz1G3NWUIAg8svOOh6qMRUDRdKkLb7uH5xKvxB4pCd
	bXXxSf+9kE3yQ7w/pPlw2WOvH0TQ=
X-Google-Smtp-Source: AGHT+IHKYnMBM5/kyhvDQoB2puAuFwgau2F1cdm/TYxxDExqdUOWLvPo1Y9fjJaKG3szzmERx2iTnK6EY57of2IQEnQ=
X-Received: by 2002:a19:5514:0:b0:513:140b:e57 with SMTP id
 n20-20020a195514000000b00513140b0e57mr2046610lfe.12.1709226489734; Thu, 29
 Feb 2024 09:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229112250.13723-1-toke@redhat.com> <20240229112250.13723-3-toke@redhat.com>
In-Reply-To: <20240229112250.13723-3-toke@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Feb 2024 09:07:58 -0800
Message-ID: <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Fix hashtab overflow check on 32-bit arches
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> The hashtab code relies on roundup_pow_of_two() to compute the number of
> hash buckets, and contains an overflow check by checking if the resulting
> value is 0. However, on 32-bit arches, the roundup code itself can overfl=
ow
> by doing a 32-bit left-shift of an unsigned long value, which is undefine=
d
> behaviour, so it is not guaranteed to truncate neatly. This was triggered
> by syzbot on the DEVMAP_HASH type, which contains the same check, copied
> from the hashtab code. So apply the same fix to hashtab, by moving the
> overflow check to before the roundup.
>
> The hashtab code also contained a check that prevents the total allocatio=
n
> size for the buckets from overflowing a 32-bit value, but since all the
> allocation code uses u64s, this does not really seem to be necessary, so
> drop it and keep only the strict overflow check of the n_buckets variable=
.
>
> Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing overflow a=
nd zero size checks")
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  kernel/bpf/hashtab.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 03a6a2500b6a..4caf8dab18b0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(union bpf_attr =
*attr)
>                                                           num_possible_cp=
us());
>         }
>
> -       /* hash table size must be power of 2 */
> -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries);
>
>         htab->elem_size =3D sizeof(struct htab_elem) +
>                           round_up(htab->map.key_size, 8);
> @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(union bpf_att=
r *attr)
>                 htab->elem_size +=3D round_up(htab->map.value_size, 8);
>
>         err =3D -E2BIG;
> -       /* prevent zero size kmalloc and check for u32 overflow */
> -       if (htab->n_buckets =3D=3D 0 ||
> -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
> +       /* prevent overflow in roundup below */
> +       if (htab->map.max_entries > U32_MAX / 2 + 1)
>                 goto free_htab;

No. We cannot artificially reduce max_entries that will break real users.
Hash table with 4B elements is not that uncommon.

pw-bot: cr

