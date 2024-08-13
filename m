Return-Path: <bpf+bounces-37090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A28950E3E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0F01C235B9
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5641A76C7;
	Tue, 13 Aug 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vshsCTUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF31A38D3
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582796; cv=none; b=So/9qD3kRpyPLrI+z7rp4TzcFpl4MDxbOqdMuxeHIqtUwCNy9edI7t/JqpjP7C7BEmwFD6F6CYzdrRPevv10M+zzZEnnmjJyexsv81cQwUTpLK95XTj+l6xKhJX3tCrTvsEmodlX17fk4YOamTNffoe8fVzhtwAkfzMGvxlYZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582796; c=relaxed/simple;
	bh=hlBe3bO5nqL/9JxUsPJ41ih8e91oO5SDAycqip8w3t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/rjdKgPhq7V7wygLhcQZB7560PA6gZ6ySqBu5R+BPtbSTZiTRLW6nrAic0OEGTnXa5MZ8tZePE8YzFk0UP3YYdsRYZQrGQAjQcqJYgUthKivdnBBCZC8UMjpzujQ2Il13wgwnRmM6Owrq0QbXlNf64IDZzN++3uf0RGoYPpsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vshsCTUu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-200aa53d6d2so27375ad.0
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723582794; x=1724187594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhgGYVMx+jW9NS5avNe3UcbWXP3uzGmp3M9nSD5W+Bo=;
        b=vshsCTUuNNTZL2oqksGKcyE19bjvuZRnBweL8t6iC2HOt88hS5++QZ3fxDxME+nF5d
         xVWcAlSt+0dtb64fUT/EXa6kZkRy9STOC9ITpu+5f3iTYx1hSAfABAKfshQAn4+kj6j9
         2umV+ES7ZYtp5AzSM8a1I3t/F/VFcDhOhC5hScwAn3N8WSgo5YRyG3FUGbH+OhidqvKg
         AMoFTSus2uAivEhqEfsudgcytpJQKn4w/U3fk8jSxAU48eEzoSM38wjHzbI+LtlCjiBG
         z0T+hUCuS2Wbf1bib/sYJv5OZ14Mod95q0EaXDZSoOWO17yc92Pay/hDs561h0q3Jowh
         MeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582794; x=1724187594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhgGYVMx+jW9NS5avNe3UcbWXP3uzGmp3M9nSD5W+Bo=;
        b=ds8jiMXoakQR9E7ROjkWlu+qhhVWZrx+iKS8LGGGjmCUPKleyGxLbcFN0y5qp2IP0f
         Yb5gLhLD08i5J4EBVcrjaE3+Fzsecg4/stnzyzxjLtEqzgCWRsyYkFpdLWD8+GPO8o91
         UaRVMUKDgdNGmKN1pEf/9MpE40b5cFPNeDzasHFOEpN4O90hKn9qkXoTKJAJOUoI7/Qj
         Ad3PWEYY1JejWQSw6FFSkqlhzipT3EJHVbgFjwr2u3ANROGoLr0692JLGVG+UfGxSwCV
         wZCDsMHCEoUkLIZhHBvLfowAlRFlgaISom0IkqR47EpQ2SKjLkGdMn3eBkX0tG8rk4ke
         c83g==
X-Gm-Message-State: AOJu0YzkmkIqaZ+gz3rhdo6IYbvSTfTGIzZZDIapZ8hgBjfrrlbAJKr+
	WSLOg/Zma5UxqlVzRC4nTob32FOs67v4SLTxqtUfnA6MbyOryxt28dAytymjARLDwZV2C2ZTiJn
	MyOsUtoFV4IrSQSN+ZpPig071zH0u11nflFro
X-Google-Smtp-Source: AGHT+IE7evxZcY5Q1trGPNN8QB7kOuoEiJu2YVj+e1IaKF5gw6xisj04CQzafN0peuVm9S/Q8W+/NmStPFUsjWgQGzQ=
X-Received: by 2002:a17:902:c949:b0:1fd:d0c0:1a69 with SMTP id
 d9443c01a7336-201d9261633mr66975ad.9.1723582793740; Tue, 13 Aug 2024 13:59:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813002932.3373935-1-andrii@kernel.org> <20240813002932.3373935-2-andrii@kernel.org>
In-Reply-To: <20240813002932.3373935-2-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 22:59:14 +0200
Message-ID: <CAG48ez1oUas3ZMsDdJSxbZoFK0xfsLFiEZjJmOryzkURPPBeBA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:29=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
> Harden build ID parsing logic, adding explicit READ_ONCE() where it's
> important to have a consistent value read and validated just once.
>
> Also, as pointed out by Andi Kleen, we need to make sure that entire ELF
> note is within a page bounds, so move the overflow check up and add an
> extra note_size boundaries validation.
>
> Fixes tag below points to the code that moved this code into
> lib/buildid.c, and then subsequently was used in perf subsystem, making
> this code exposed to perf_event_open() users in v5.12+.

Sorry, I missed some things in previous review rounds:

[...]
> @@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *build_id=
,
[...]
>                 if (nhdr->n_type =3D=3D BUILD_ID &&
> -                   nhdr->n_namesz =3D=3D sizeof("GNU") &&
> -                   !strcmp((char *)(nhdr + 1), "GNU") &&
> -                   nhdr->n_descsz > 0 &&
> -                   nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
> -                       memcpy(build_id,
> -                              note_start + note_offs +
> -                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhd=
r),
> -                              nhdr->n_descsz);
> -                       memset(build_id + nhdr->n_descsz, 0,
> -                              BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> +                   name_sz =3D=3D note_name_sz &&
> +                   strcmp((char *)(nhdr + 1), note_name) =3D=3D 0 &&

Please change this to something like "memcmp((char *)(nhdr + 1),
note_name, note_name_sz) =3D=3D 0" to ensure that we can't run off the end
of the page if there are no null bytes in the rest of the page.

[...]
> @@ -90,8 +97,8 @@ static int get_build_id_32(const void *page_addr, unsig=
ned char *build_id,
>         for (i =3D 0; i < ehdr->e_phnum; ++i) {

Please change this to "for (i =3D 0; i < phnum; ++i) {" like in the
64-bit version.

With these two changes applied:

Reviewed-by: Jann Horn <jannh@google.com>

