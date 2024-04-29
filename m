Return-Path: <bpf+bounces-28196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0AA8B65CA
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D11E1C216DE
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AACBA2B;
	Mon, 29 Apr 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/nj/Bx4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A5C364
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430174; cv=none; b=OT+yK7JQ9wH5Dxsnomd/EGxwrNDo/xGxkdUakjKLxuFMTF4VhVsBMhpXN4oOzLDKvChRDGOS5POh06Nllv6PxlNjyoMxcPzs0hbIYjiGi5TPE5WLq+fQTlHGxPZku2uKpglohglspZW/7dgtY0OmyFrqQOXjTtAyBU9MfsULudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430174; c=relaxed/simple;
	bh=CRgOlsRRcjrRdyUv5prgTjfPx5Iv22Jj5QIAZ5iM9fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvvRKJIUgGF4QArh/k0Nsr/dEQtxxN8U5LVRJqAUsg3qHewq1H4NSXRNVpGfbPwkg7UdzCH04ltjquuI3kFcTYV+GR3j7TWyZ2h9p1Qou9SpBOvr98YWToMjKk0FowKOrZ4P5frcvir+tTQhXK2euXNoTpeTuntYGkhOxh+VgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/nj/Bx4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e5c7d087e1so43608175ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714430172; x=1715034972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqgVWHApgHGIFmaXpjJB352cFAjW9qrOROGYWMeBiFs=;
        b=G/nj/Bx4WzhY1Mk+N1t90e3iMw4eCM49i/oxmqIgzNtOTQTjiY6spC+tMqEmY48R3R
         u9GATvycpFDxeSEITL7koSsA0lz5YxumPndsRO2mDcZN9twVDSIMul68PKeMrgaP1Bb6
         avfUIrFY5Ke7aPZ4YDt0XZpEJvqzN/X7Ju6UZ8BejLO/V8rrrBwCwMO6k5hbRda2GMi7
         5edcIbPmpSjpgcfotD9v5avvB4b5zUnnzyIHMB0MFCNjLxgyHvyYKYgXP7YBGTLoy2QY
         Ry+gr+i9Wds93Eyj8UCiE0cFbz1VnpFGUanGvhbmAUfz3Fs5FVO0XSA0uY6ip5v3k/g5
         932w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714430172; x=1715034972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqgVWHApgHGIFmaXpjJB352cFAjW9qrOROGYWMeBiFs=;
        b=rAC7iLe4feUohzizkjhFjrM3eqAwH0sh6I2snN7VYDyz3XYf1Jlc25aGlKVu2umX1N
         RBc+B/6dms0O1/yOzrxo+zkRvq/pdAygbRJiIN3JyO5gcbmLPzA0mnKPAaJdAkHQ+M/l
         gBwbCmTvMf15G/8yG+ym28LXk+ECYWplmLnOFOLez763P3L2o8+ZmNFX0BHzzRNZdFnk
         SfAoqJtvaLYi9kPFyePqanO/U7OMV9WFUpyuzxnZ+PBYS8idga7zKnCHRpkgSoDuDG2o
         q449/rri2xG7OazHC4PHTr4MjilogsSCwTgFoUbiRfMLRkWycPO4KwWGf8gWUl7G5Uj8
         7G5g==
X-Forwarded-Encrypted: i=1; AJvYcCXSeN+MQkGqEfKg92AaLfXCsBDx25oP/9GoO98j5oXyyfL6LlbdAH5iyrPEAUD5jM+msvcrFn48HbyIbo7MZiemMvHt
X-Gm-Message-State: AOJu0YwlrjLoYn0aeaj1MmBfegh2ZCt9IOoXX6loM31GKE2/hJol4MnY
	wu9henQ0ovaagmAgaRqIKhdid5lyR3ueYYZ0ZOYAPxeoD0DNu99KXsu2FZ8tGIKM7w7YTAVnfVj
	y2RI+H/+VZmkugChIIIuDa8QzJ4/rDA==
X-Google-Smtp-Source: AGHT+IH8TLb0NdOdoJzj5/USEV5uBK1Cp2uD7mpOzsS0psqQ5WWBZEfoVUa1zECMJh9CDw/FzeK34zVKSSJDJMGkJ5g=
X-Received: by 2002:a17:90a:1fc6:b0:29d:dd93:5865 with SMTP id
 z6-20020a17090a1fc600b0029ddd935865mr9782539pjz.46.1714430172170; Mon, 29 Apr
 2024 15:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428030954.3918764-1-andrii@kernel.org> <20240428030954.3918764-2-andrii@kernel.org>
 <5b3e2db0-1582-4f35-9cee-069de799aa41@linux.dev>
In-Reply-To: <5b3e2db0-1582-4f35-9cee-069de799aa41@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 15:35:59 -0700
Message-ID: <CAEf4BzYo+wCE_dg1kx-dA9egvz7KE6tPS0fzFgeaCgx02+NrcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: validate nulled-out
 struct_ops program is handled properly
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:29=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 4/27/24 8:09 PM, Andrii Nakryiko wrote:
> > Add a selftests validating that it's possible to have some struct_ops
> > callback set declaratively, then disable it (by setting to NULL)
> > programmatically. Libbpf should detect that such program should be
>
> such program should be /not/ loaded ?

yep, can you fix it up while applying or should I send a new revision?

>
> > loaded, even if host kernel doesn't have type information for it.
> >
>
> > @@ -103,6 +104,10 @@ static void test_struct_ops_not_zeroed(void)
> >       if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
> >               return;
> >
> > +     skel->struct_ops.testmod_zeroed->zeroed =3D 0;
> > +     /* zeroed_op prog should be not loaded automatically now */
> > +     skel->struct_ops.testmod_zeroed->zeroed_op =3D NULL;
> > +
> >       err =3D struct_ops_module__load(skel);
> >       ASSERT_OK(err, "struct_ops_module_load");
> >
> > @@ -118,6 +123,7 @@ static void test_struct_ops_not_zeroed(void)
> >        * value of "zeroed" is non-zero.
> >        */
> >       skel->struct_ops.testmod_zeroed->zeroed =3D 0xdeadbeef;
> > +     skel->struct_ops.testmod_zeroed->zeroed_op =3D NULL;
> >       err =3D struct_ops_module__load(skel);
> >       ASSERT_ERR(err, "struct_ops_module_load_not_zeroed");
> >
>

