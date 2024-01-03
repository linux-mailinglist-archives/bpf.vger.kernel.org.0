Return-Path: <bpf+bounces-18901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCEB8235B3
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5C3287519
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFBA1CF8A;
	Wed,  3 Jan 2024 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8xUQWdo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED61CAB1;
	Wed,  3 Jan 2024 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so7700827e87.0;
        Wed, 03 Jan 2024 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704310935; x=1704915735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQMMyp/+VqJgJzvufNwTc8r2Xq2Zt9hxS7khxJRxxoU=;
        b=M8xUQWdoQPjQPDElcyAIOJRKgPKKPynBjvqc697mF/94PyoTLnyM5pQ4k12MzT4n8a
         jqiauXRzVvKkcctkEUEHi3aG72jKUX2ArM0eBe8rEwGlzqynWpPObw35z+H45rjKQ9kd
         ODdJZB8oNA2fHkO34FdrH1nxbTvyjlOtJKRJ9V455wlKwxBAYkxM9DYbqnzAPKaGAMPu
         cfarLSal09EtYxwtHErMywHxAOddipp/p4024CyLdCjouz5xQ2ar/QrfATWkfeOteQFw
         +sfGztrQpAbAJVWKktMfufhZV8gB/u8RofBDETCO98p8hHNlfyKfEwrhHGO4yvrmWC6b
         61yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704310935; x=1704915735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQMMyp/+VqJgJzvufNwTc8r2Xq2Zt9hxS7khxJRxxoU=;
        b=WeOpf10Ao0mc4JxpAVClK0aVF75PAK0ydOhoVSyUq8ksuLP64ZMaCujhDHg1GvJFUa
         PaP8IhavibUUQ6wTNdhFNPkbRf02FWGoaON2bqw1sDRUcLjjkfbWdXSV5zw4nYYIsT0y
         y5xzAo9Qm3uv08BGN5JFz/2MaxLNe/ao6kQiYT9pORrHAxRTcDWVrn42OWnqQ7MIi3vx
         Opr2gOMOaJK/ePsSS2aGDpgx2Z64gUv1H6cmW6F9FSswGHOyxTqEumIN+cst9zqbj4eJ
         8mwoJtklTMXK+RlUvpHU33Yqr6vBbAjpWojG6ocgXiTLkbYjlPubblszAUsMXNqNlHTw
         ckxQ==
X-Gm-Message-State: AOJu0Yy3BVyaR8ff09BxXJEVXynjjM4hFs6bATnxP2tYknTzUeGsoNdv
	F8xYW5GNs7HUu0ERNrUmphC8YyC6tlZBKl+s294=
X-Google-Smtp-Source: AGHT+IFZ2kNlc97/ou759aCINQx3j3wITZpKQVG0lOao7npD6AMZzwIzaE5KN2dlhjSNoORgefuBtM6CXY4Rig3vygI=
X-Received: by 2002:a05:6512:3912:b0:50d:6249:17cc with SMTP id
 a18-20020a056512391200b0050d624917ccmr3923088lfu.245.1704310934397; Wed, 03
 Jan 2024 11:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103185403.610641-1-brho@google.com> <20240103185403.610641-2-brho@google.com>
In-Reply-To: <20240103185403.610641-2-brho@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 11:42:01 -0800
Message-ID: <CAEf4Bzbyn8VaMz8jWCShDDMtwif5Qt+YTEih0GEzULFeAAS2LQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: add helpers for mmapping maps
To: Barret Rhoden <brho@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 10:54=E2=80=AFAM Barret Rhoden <brho@google.com> wro=
te:
>
> bpf_map__mmap_size() was internal to bpftool.  Use that to make wrappers
> for mmap and munmap.
>
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  tools/bpf/bpftool/gen.c  | 16 +++-------------
>  tools/lib/bpf/libbpf.c   | 18 ++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  6 ++++++
>  tools/lib/bpf/libbpf.map |  4 ++++
>  4 files changed, 31 insertions(+), 13 deletions(-)
>

There is very little added value provided by these APIs, while adding
API obligations. bpf_map__mmap() assumes READ/WRITE access, why? What
if the user needs only read-only? And so on.

Please drop this patch, we don't need to expose these functions as
stable APIs. Definitely not bpf_map__mmap/munmap. bpf_map__mmap_size()
might be useful to hide various per-map type details, but we'll need
to discuss all this separately.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee3ce2b8000d..a328e960c141 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -453,16 +453,6 @@ static void print_hex(const char *data, int data_sz)
>         }
>  }
>
> -static size_t bpf_map_mmap_sz(const struct bpf_map *map)
> -{
> -       long page_sz =3D sysconf(_SC_PAGE_SIZE);
> -       size_t map_sz;
> -
> -       map_sz =3D (size_t)roundup(bpf_map__value_size(map), 8) * bpf_map=
__max_entries(map);

this is specifically ARRAY map's rules, it might differ for other map
types (e.g., RINGBUF has different logic)

> -       map_sz =3D roundup(map_sz, page_sz);
> -       return map_sz;
> -}
> -

[...]

