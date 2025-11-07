Return-Path: <bpf+bounces-73926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF71C3E2E7
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 02:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1EE188A96F
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C562FBDFF;
	Fri,  7 Nov 2025 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP0s5TO1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5F2FBE02
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480723; cv=none; b=lGale7OR4zoOJAcwlmL065lPK0X6rNzaK4U0P869rQKGqrc8fc6kl9wmEWFCBXClm+e9bqNLNV3/3ETJKxOpb4lZ9iDkd3UTop33EcNR2MeaBIF7kuM6Rhq8cy3zxjKZmEKLvt8Y/11K8r2WPtLdVD3bn6RlUUHHhMnlEuono54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480723; c=relaxed/simple;
	bh=uE+Rkygh9horIXIFvnROjufDWX1NgopkGjoPYzMfJYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpLFXvxa7ThTD8OekWDPvoikdbwectcoKcAXFOcS/xr6MMknBs+WDkKFbSjAMOi6ffG/m8tBBzzF6du4FvFhseny8gtBmXAbHGcpC0CIDVMWVl/bkyXgUFlRX/Wk8o/BK5Lh1pP0ucWvs7fj5SbmRSwlZBOdVMHElGFsTuRK9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gP0s5TO1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7866dcf50b1so2443587b3.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 17:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762480721; x=1763085521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws1923/IMmVOcT4O7JQ0j2rMySLfeg19gDf6kDjpaRU=;
        b=gP0s5TO1U7xSlsLirO/yPY7M4TaVxwpNBj98UtcrMyl04CeZ0mDjfpNwy70ahNXHKd
         t2jjeyNqq7moI9r3VlNkSODiiUCupLurs6cOy4GuVcPXgahwzW8Pi5Nuylke8sGXytLc
         nzJHVgROcZzPNz1lY9ZdTiYX+yuAdrQ/rca3+5v548xNzOprOwmc6j4oIJCL9y8VjtFI
         NKrvEJEjMoqqMMNcg9hJTZGIhyjsmvdXflclV76QL3IOPcC5WlXB3MTd73Lriid+P+bb
         lD1q/OrGsM8dDEHqpvIBiPG/J+gx64hLBBQ5kJfw4a9y6Ba6pUjbZVWrBIXdg+qp1kKg
         Z2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762480721; x=1763085521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ws1923/IMmVOcT4O7JQ0j2rMySLfeg19gDf6kDjpaRU=;
        b=rhE15umCdfN1Lj+/lg8LOA/SCy+SoUOr4foQcu9hWlQSsqEgWr4K8RWe3y8sJU59ub
         /AwiMuo7+VGe5Yw6t3uJUVEvHw0lFWa3VXf73ek9dn07NjQ+nD/FpMImI2AZUSjqdSlr
         6UT0V6HuLJWzeZk9yD2ywkZBw+iV2MT2NN+aFZCqTWF1evS4Cozx+wEaUwLwLN6vnKQ9
         qBPmAhyPvQpuhq3216OXUx974SHTUeCgioGy55dUcYykbjrlFY55bwEM5XU8AHCOozxM
         BSVYR+/cdY6dGFzH6Z86sRw8Bw0CTP23pEoPvJPEUxEnEu0G54QAdbfaGM90xWthFTPm
         RJuA==
X-Forwarded-Encrypted: i=1; AJvYcCWSVIYRaSr0o3eaw3wZGPA4v/dxkKRJHtbh62UhvtSqcS6xfwN/5vVTgO152knKYHy+roM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytWjupLretZOO/pj2MmI8bakHXObzjmhZWboiy45CdcMr9EVTh
	gmY1VOFdpK4NLjnBaz8ar18H6oAiwbJGEw4F0R7wjiaTWskvwQ9dC6YnavM23pbJ/JJOEjaVIFa
	H6jklPyKcwIt4SQfZAafv0wZOLzNgTL0=
X-Gm-Gg: ASbGncsydwNKzG6r++itDzaUUgZOJfquAouvYS/VzQtKHbwVjxUE2lykrbKknLzDZtz
	zo4mB9OP43SbRcRLU0mqAtAXap8kfaugdFX3NgsUV67kl9SS8FULJDP4xRcOsWDSfWVs2UDpcTP
	uUR+GsQxw1p9wijeM8OE6INgTka2o/27FPEW5QHZOcXNJtIWASYI1/7iRFgnF9jKn7qngsDJqCc
	pvWEJDs7keZ3uScrL3FW+svhZi5Gt7vA/cEJhN6bRrV4UpHtZtFe407znTxmA==
X-Google-Smtp-Source: AGHT+IFD1W4wWaFnX4WWC5V+GTvvDhI/nCF0mztprUtQtCHUG3Xcq5/Li5dJnu2eCXiyQxiY6R9td23BLW3X6YNPej0=
X-Received: by 2002:a05:690e:dc6:b0:63f:8734:36d5 with SMTP id
 956f58d0204a3-640c43eb044mr1470211d50.61.1762480720646; Thu, 06 Nov 2025
 17:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106205852.45511-1-a.safin@rosa.ru>
In-Reply-To: <20251106205852.45511-1-a.safin@rosa.ru>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 7 Nov 2025 09:58:04 +0800
X-Gm-Features: AWmQ_blKz8xkp87Ie3SuRJxJXNqDNP3e1oq6mV_yZNh0EqOO6_kc5GFDmtfaPIg
Message-ID: <CALOAHbCcfszFFDuABhPHoMioT26GAXOKZzMqww0QY1wKogNm1g@mail.gmail.com>
Subject: Re: [PATCH] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: Alexei Safin <a.safin@rosa.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:59=E2=80=AFAM Alexei Safin <a.safin@rosa.ru> wrote=
:
>
> The intermediate product value_size * num_possible_cpus() is evaluated
> in 32-bit arithmetic and only then promoted to 64 bits. On systems with
> large value_size and many possible CPUs this can overflow and lead to
> an underestimated memory usage.
>
> Cast value_size to u64 before multiplying.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 304849a27b34 ("bpf: hashtab memory usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexei Safin <a.safin@rosa.ru>
> ---
>  kernel/bpf/hashtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 570e2f723144..7ad6b5137ba1 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2269,7 +2269,7 @@ static u64 htab_map_mem_usage(const struct bpf_map =
*map)
>                 usage +=3D htab->elem_size * num_entries;
>
>                 if (percpu)
> -                       usage +=3D value_size * num_possible_cpus() * num=
_entries;
> +                       usage +=3D (u64)value_size * num_possible_cpus() =
* num_entries;
>                 else if (!lru)
>                         usage +=3D sizeof(struct htab_elem *) * num_possi=
ble_cpus();
>         } else {
> @@ -2281,7 +2281,7 @@ static u64 htab_map_mem_usage(const struct bpf_map =
*map)
>                 usage +=3D (htab->elem_size + LLIST_NODE_SZ) * num_entrie=
s;
>                 if (percpu) {
>                         usage +=3D (LLIST_NODE_SZ + sizeof(void *)) * num=
_entries;
> -                       usage +=3D value_size * num_possible_cpus() * num=
_entries;
> +                       usage +=3D (u64)value_size * num_possible_cpus() =
* num_entries;
>                 }
>         }
>         return usage;
> --
> 2.50.1 (Apple Git-155)
>

Thanks for the fix. What do you think about this change?

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a9eeb7aef85..f9084158bfe2 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2251,7 +2251,7 @@ static long bpf_for_each_hash_elem(struct
bpf_map *map, bpf_callback_t callback_
 static u64 htab_map_mem_usage(const struct bpf_map *map)
 {
        struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
-       u32 value_size =3D round_up(htab->map.value_size, 8);
+       u64 value_size =3D round_up(htab->map.value_size, 8);
        bool prealloc =3D htab_is_prealloc(htab);
        bool percpu =3D htab_is_percpu(htab);
        bool lru =3D htab_is_lru(htab);


--=20
Regards
Yafang

