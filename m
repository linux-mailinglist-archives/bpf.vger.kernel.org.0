Return-Path: <bpf+bounces-76196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28ECA9AEB
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 01:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B38316DB73
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 00:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171733EC;
	Sat,  6 Dec 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/O+AaUk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF6A1E86E
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979911; cv=none; b=jQGN9lU6s86xda1ht0mTpq7piXSNp/9lamg3IhIDah5KZAzlSG4rpC2agGdDHAY2BZDkhEAE3pURMCvEa5Uy5+RGWw87MCpt/F86WywfSWStgtUOtg2O357PFflxvzgZRL34Zkko0JAjdbp+EcmISO+usp2E6EVCyEMfs8gG2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979911; c=relaxed/simple;
	bh=ict5m73LWb42P3uwGvy0jjd9jLvoxZpa0MVVTp5eSyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfpV20ZrEEtEQ7gWkiWAzW5m+fSogqRUj1Nga1vFr5ohRdldpxyKULTZ1OqgiQEYpyZaJhCKUfU1Ht0M+/D3ksKJhtJsBgz5K0ouBh0La70OhcTZjPpRF4Z3VHy3prRla9GBypi1VUMLjppfzZVbbWxfhK1yjr8Ly6/lciJizro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/O+AaUk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so2629292a91.0
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 16:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764979908; x=1765584708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+R8VyUIbjIU+QH6jUlz69QCw3Iu2i2ZMam2mMULebsc=;
        b=g/O+AaUk5T9BsYk37BqMLIi02HiVF/KMhznX5oStJ0BYE1fQ1LYv4Z25LNKnDBywoO
         dd1IiKhCvD8nmBT6QAxVXRgvsX5RsUOwpKVvBOfmaxVFd/Ss6OmgyC4sU2jio9MMgwHJ
         0Cl/6HJ0NLMZLxdP3r9hRKGv7AttM1JBQ36a1fOYIogpa/oHBhQwvB9v6SOGDRMSwG7y
         odRputC9IigAW4LV7INMN8lqRnTFaxBdhSK9S8aanpi6eEzpZasHwDRxoOUELx+aCWEY
         QK0BQUf1BEjBPTVUJ23Zq2FJYKlGpV8SLB6jNzHnvUpu0LkhQ9NRAeXNXIAOwktZNuRA
         9WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764979908; x=1765584708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+R8VyUIbjIU+QH6jUlz69QCw3Iu2i2ZMam2mMULebsc=;
        b=JqTw8q2c26DIoYesufmNG77RzdEfQMQZ/jaEiJkmbAqvwG+YzcoYVjXwzmEMNDs25C
         UaodZW14qjkZOqlA6XwqUPdTH9SIMvRuPwf0S8HVlRmZWfvDchvxrbc2lbqbXzKHwB+C
         1iVQ6zf0zAjpIhMGJd9Qwe3ynorz1XvWW4zVWqHye1G8lfXUM8uOpSOue3QEil6qAc6h
         S5fcaD8IOlYsoYJBP1AypM/IVkDNAXRSI92Am/nCJ+ei/HH2iw+OT75FlSjKV1Zld0AJ
         BmC+gjRxAZSKXpp23jd2/lwd7h+N7Me/oQIrOS/gwRFmAUR8I9LGCzmzi2bopu1SAF0X
         QQJw==
X-Gm-Message-State: AOJu0YxjrQGqBCGl2lhUQEfTSdyJyX8y980zU2f6M3QGqyUbIJE6aPpj
	zW9H09JYD7Be4C8LLr+AXgDklbh8AlMaynWyFCUvCq/OKbmIZpz0EolI562PQuS1FN9B9f8qRuK
	Rj+AfqO2ek43yjsUQINQQgoA1bVp+QA8=
X-Gm-Gg: ASbGncvEUQWb/n2BvaOhFEDm6xCbiDbp8bMCFqyM4uFDUlb9oa6H1mpm/xNQ8J+JyEl
	z9OMjnZPEu17WHTx7XERDrxrqyQ7xCHkQ2ETJ6AIxtD2CJ7OhdxqV7HEEQeBb2SEm0smina8PKP
	WrWmG5Sl/7g1uFBuri3L8Rn43rVNU/6pazm1y1tU3NuAO3XNnhBQZkt8m6oAJ8Ra6GMBtzITDjI
	6jQrfvQfdMMh/3IWLCM74XA6RrK/6LjkflXuVyVs60QOY+oVIS5ctyRSFw/ceyaG8C6e0pIETPK
	jk3xUrWvrQM=
X-Google-Smtp-Source: AGHT+IG0rZ9wmBwfJ6E/uZ0DhiJwbWAuNBInzfpeQtV5L3s/KPLPiyNYJhJn1sWcV9lcUDNPqnZhKm7qzbT3JAg6fMc=
X-Received: by 2002:a17:90b:3f0e:b0:341:88c9:aefb with SMTP id
 98e67ed59e1d1-349a24eaa24mr540068a91.5.1764979908470; Fri, 05 Dec 2025
 16:11:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203162625.13152-1-emil@etsalapatis.com> <20251203162625.13152-3-emil@etsalapatis.com>
In-Reply-To: <20251203162625.13152-3-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Dec 2025 16:11:34 -0800
X-Gm-Features: AWmQ_bla6qRW8XH2rAEh2L-rP1KGFQcKron7g6-LpnC_bgy0SD8SEcWkrxYzvLg
Message-ID: <CAEf4BzbvcDoiYe6Lr4y6s_ZftHXdyViocftc73xEf4uRH8kAog@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] bpf/verifier: do not limit maximum direct offset
 into arena map
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 8:26=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> The verifier currently limits direct offsets into a map to 512MiB
> to avoid overflow during pointer arithmetic. However, this prevents
> arena maps from using direct addressing instructions to access data
> at the end of > 512MiB arena maps. This is necessary when moving
> arena globals to the end of the arena instead of the front.
>
> Relax the limitation for direct offsets into arena maps to 4GiB,
> the maximum arena size.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/verifier.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 098dd7f21c89..a64cc5caf4aa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21084,13 +21084,13 @@ static int resolve_pseudo_ldimm64(struct bpf_ve=
rifier_env *env)
>                         } else {
>                                 u32 off =3D insn[1].imm;
>
> -                               if (off >=3D BPF_MAX_VAR_OFF) {
> -                                       verbose(env, "direct value offset=
 of %u is not allowed\n", off);
> +                               if (!map->ops->map_direct_value_addr) {
> +                                       verbose(env, "no direct value acc=
ess support for this map type\n");
>                                         return -EINVAL;
>                                 }
>
> -                               if (!map->ops->map_direct_value_addr) {
> -                                       verbose(env, "no direct value acc=
ess support for this map type\n");
> +                               if (off >=3D BPF_MAX_VAR_OFF && map->map_=
type !=3D BPF_MAP_TYPE_ARENA) {
> +                                       verbose(env, "direct value offset=
 of %u is not allowed\n", off);
>                                         return -EINVAL;
>                                 }

both arena and array maps validate off for correct range, not sure we
even need this check here?


>
> --
> 2.49.0
>

