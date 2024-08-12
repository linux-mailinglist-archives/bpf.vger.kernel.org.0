Return-Path: <bpf+bounces-36910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0257E94F578
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FF71C20FB5
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178D187FEB;
	Mon, 12 Aug 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZzZzrtz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806218754F
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481923; cv=none; b=dt1pOSTPM7WnQ0aHIAfPu2eaLkd1CbJ3bx8zaaAIVrCGZQHDT3RX8UUpNEDsRAeRs6ChvNPLWWYkFzrZIvPzjRux3Hd3WyPxG5gdkvW7xm1evAJewEq2tJO6dl4Ink7QQENB6LCYnk59jWTNB8EwmHaRza4NTsNuLYMWc+0thyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481923; c=relaxed/simple;
	bh=iW2oeRxLOvjT/ZSnFfmUgFx6YGlOt1sML844rqOfDII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1QedNHRO2e175V2HXbOm8zEMxrVNGVZVet11VUKBQXb+5TUj54JhzQjtC7tjK0IzNoxuROLjL3rivjnFWNlk6AOF4l30ElHcMpcmi3wev6QxnQI1wJTOinI0IAIAJFa9u3nigaKY4hUygwrSv4svJb+BJgD+s84hdtCdrBpX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZzZzrtz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36bb2047bf4so3104869f8f.2
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723481920; x=1724086720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYvdbxluo/ZrGSjWKiwMCL/zRapmJskDuPv3z1YVEhI=;
        b=FZzZzrtzAxoZD41rDl4vMhFFQbu4gisv1rOXWj96/O2496qEWZ8x7gwzDhg+bOWFYm
         lc4HRzcUL+bQOLe7KQ5SR6uIEX9b2W/xyEjYf6CZTz3VwZNpX1eMrltBV3ZDdsoU+uGf
         rVTG/W1F7up+gazxskaqiHl2ipdo7S5AVdgBcaSa4nDCsci6XQGeCAUypOGlm0OhNGhB
         JbP1rj4XeBE5azSY/YLVOyk98I0fRYBTTeFmRWwUGEWJA7XuGDKBW7H2bef+ZzzrLBdq
         N1O9THrw9GOsM7BfNvhHtJlbErRSc3LHjKwp1crHIIkPv1uN798lXbzIEYEOp8KWdeip
         lhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481920; x=1724086720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYvdbxluo/ZrGSjWKiwMCL/zRapmJskDuPv3z1YVEhI=;
        b=VQlNTqdED+LKU3lvIdWyPkwKKX56tg8MgtdOgS67ZMX6wy2vMKM8tQ7GFSR2J4cnsV
         1g8XR0pvZrrpYwxC2GEYNsvBY9zGduV3snBosKMVr4p9GPH6fxrpvFrguKUmlRGeJm5S
         sIcp+/2TQ/AdGBBIGCXF4ZZP+ipA1AMBkMhfCZA0MvONA3rFxCTOOdPGwnIPkKX5RV6k
         CC7tcvJiPrnwFyH3+mx4Rxlne/l3uSftzX+FnXjeoF/+Yc7sjcouxczkN9h9V1xx/MCL
         VZLyPjFZC2dMl2E/W4++0Yxo4yhnSzwJM51wNguqTNkRWIAj62HiNMgu64Jk1H/jBoEQ
         XsoA==
X-Gm-Message-State: AOJu0YxlwqSAVHcf6V0ZPDDNjhFtmWa/pshWJl6OWe7GzECOYsGvPnwE
	wsJINDpScPn/ZXmuKNVcdXwFQFsPGXcHclr/v5TWSIpLCZxQ0tx3YEi6OpKzhAzZ0svZfTooYFA
	Lm9rklH+awRdS94T9m7w1Hqk6rZD4Qtxx
X-Google-Smtp-Source: AGHT+IFXhmisuYDHB3Vx+ymT+fY+vA8eP/qYa3IjrB04qcWhJ/ABh+11dCZ5hdRA4+J6fF1vR1mimXotHbTHqxO+zCE=
X-Received: by 2002:adf:fc81:0:b0:36b:bb61:f576 with SMTP id
 ffacd0b85a97d-3716cd28f56mr610586f8f.44.1723481919635; Mon, 12 Aug 2024
 09:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807235755.1435806-1-thinker.li@gmail.com> <20240807235755.1435806-6-thinker.li@gmail.com>
In-Reply-To: <20240807235755.1435806-6-thinker.li@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 09:58:28 -0700
Message-ID: <CAADnVQ+B1oB2Ct+n0PrWnb5zJ2SEBS1ZmREqR_sK=tQys6y3zQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 5/5] selftests/bpf: test __kptr_user on the value
 of a task storage map.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 4:58=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com> =
wrote:
> +
> +       user_data_mmap =3D mmap(NULL, sizeof(*user_data_mmap), PROT_READ =
| PROT_WRITE,
> +                             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (!ASSERT_NEQ(user_data_mmap, MAP_FAILED, "mmap"))
> +               return;
> +
> +       memcpy(user_data_mmap, &user_data_mmap_v, sizeof(*user_data_mmap)=
);
> +       value.udata_mmap =3D user_data_mmap;
> +       value.udata =3D &user_data;

There shouldn't be a need to do mmap(). It's too much memory overhead.
The user should be able to write:
static __thread struct user_data udata;
value.udata =3D &udata;
bpf_map_update_elem(map_fd, my_task_fd, &value)
and do it once.
Later multi thread user code will just access "udata".
No map lookups.

If sizeof(udata) is small enough the kernel will pin either
one or two pages (if udata crosses page boundary).

So no extra memory consumption by the user process while the kernel
pins a page or two.
In a good case it's one page and no extra vmap.
I wonder whether we should enforce that one page case.
It's not hard for users to write:
static __thread struct user_data udata __attribute__((aligned(sizeof(udata)=
)));

