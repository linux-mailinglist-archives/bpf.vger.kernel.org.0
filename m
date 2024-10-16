Return-Path: <bpf+bounces-42249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632239A15C4
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 00:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9464C1C20F74
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF731D4351;
	Wed, 16 Oct 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnoyuL2t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D91D4352
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729117310; cv=none; b=KAcinieUFO+aGaM/nxTsIPDQCvIeWsh+HWH40tSV5pkBi24q3cWyTRp0/sVTUWk6VOT9lRef2Z/0Jgrf+Y5PWE2ocOiWTJnpIvxLyCAbKQ82JcxGWwPKoNp5WLEA0e0pqv3Fp1dfT8MZsDjdYTAIu7wvZ1U9BtZm4sRAgFINH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729117310; c=relaxed/simple;
	bh=Z3ayjFJol3t+JrwPYtJyBbDwU16XxVVIKPsBEf5HWlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afneKuF+nqGuWeiol30XhI1+z/dIoiM9MAOdadisSlq24IMXzjX3iLxGCbFjug2LB9+iIeRLcpKfZiLcUG3r4yjULFrOAhsTr6JUjt8jTfOlthuOLl8vwlVTAO1+l6+3yCstE2/WZwr0Nxim0eFVgdAmD4fSA1rf+Yxna64Ac/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnoyuL2t; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9625cfe4dso461882a12.0
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729117306; x=1729722106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brWM2G6t2emt3c4j9EVo7ifDZXhOJXvFytTyLfgg90Q=;
        b=mnoyuL2tjjd9AaxXDr82hATrE7NLmb5OJB+hrC5iGdd/7CX7mPlCKFMxtu2Oh8lGAh
         GTcr+DZ1ZnR4w05HFrYOTOOQ0dlWNhra/TgEWOmeY2V/ygSIOsr3IAUrw5agFAiofLhY
         IaWYuvvnQxrD+xlAoxNhljDEfYeDtFI1zVbwfit7wH/dJ4ajiZO4L6LSJh5kDheX9XwC
         I+gQ+Cwbt2TYrhak+AOrRaERUuUxtyLjnCwS1BYqW6MtsHYtQRqxOgBqPYaBtalVmV7Y
         K0x8XG4JOUvHZ/MasGi7VVYeYGYPu+4NnQPf/q92d5KWLmicZfpQ/1URrxcsUuaknJKR
         PHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729117306; x=1729722106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brWM2G6t2emt3c4j9EVo7ifDZXhOJXvFytTyLfgg90Q=;
        b=eVpKhvbwEEcMIzRFMChXCbv0SgaMlcikDHDwKdWiV0lVntoumPQvlkHNkB5F0kg9+7
         PwfeytsEDyhkz+BVUOw57r5uXodlhxpCZGSkZR8YNdQ2VId/Xumb1orhvtuW8mYqriZj
         KojxYQyXkVOFliSlOp6gVBkwTK/4gXIr2mIrlW7i76DUeHPivkk3l5I1DJoHXeC5LIow
         9VVVZPL+8O5LNR/4ZfqC/MZKa+xzo9kt74+sYxqvUIUC0h2MAoY4/cyiWCv8o4XBQm5Q
         pY9Jq87nu5GkXnCwfteLx5/2ZInB27XZJHgxNY5pZz27wvIXBqGi1N9A8DxMXeKuijiu
         buXg==
X-Gm-Message-State: AOJu0YyjHEFYJS8yRieMf2hL1Mem4evMIEvSESs1/f4fHsIKVZZ1anxe
	TwRuEGqs6TOu4FwcyW7PPZyyyFoTpKzKYvM7xVZCUxxdJoElaw11Tw5wKTSIOyUa6dovUrJiRBw
	0EL2EH6MrdgZU3bRvGasGbaJMoQZNbpRT4dClCNR7EZ53qBktrOte
X-Google-Smtp-Source: AGHT+IF07Z3g6o1w4z/AIMrQc+IqyySmDc7fz9ahOcksvgrfvFQRgMCGsZu1SdjfEi+cXeR9yZ4s1v+3VJ01Rrmazho=
X-Received: by 2002:a17:907:7ea0:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a99e3b700b8mr1638007066b.27.1729117306331; Wed, 16 Oct 2024
 15:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016221629.1043883-1-andrii@kernel.org>
In-Reply-To: <20241016221629.1043883-1-andrii@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 16 Oct 2024 15:21:08 -0700
Message-ID: <CAJD7tkZmDz5siqwSHmqck27taMHP+z_Ds2yJPXpzA6vFUOvTwQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rppt@kernel.org, david@redhat.com, 
	shakeel.butt@linux.dev, Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 3:16=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> From memfd_secret(2) manpage:
>
>   The memory areas backing the file created with memfd_secret(2) are
>   visible only to the processes that have access to the file descriptor.
>   The memory region is removed from the kernel page tables and only the
>   page tables of the processes holding the file descriptor map the
>   corresponding physical memory. (Thus, the pages in the region can't be
>   accessed by the kernel itself, so that, for example, pointers to the
>   region can't be passed to system calls.)
>
> So folios backed by such secretmem files are not mapped into kernel
> address space and shouldn't be accessed, in general.
>
> To make this a bit more generic of a fix and prevent regression in the
> future for similar special mappings, do a generic check of whether the
> folio we got is mapped with kernel_page_present(), as suggested in [1].
> This will handle secretmem, and any future special cases that use
> a similar approach.
>
> Original report and repro can be found in [0].
>
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
>   [1] https://lore.kernel.org/bpf/CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO+mhhz=
1_fni4x+COKw@mail.gmail.com/
>
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abs=
traction")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  lib/buildid.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 290641d92ac1..90df64fd64c1 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -5,6 +5,7 @@
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> +#include <linux/set_memory.h>
>
>  #define BUILD_ID 3
>
> @@ -74,7 +75,9 @@ static int freader_get_folio(struct freader *r, loff_t =
file_off)
>                 filemap_invalidate_unlock_shared(r->file->f_mapping);
>         }
>
> -       if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
> +       if (IS_ERR(r->folio) ||
> +           !kernel_page_present(&r->folio->page) ||
> +           !folio_test_uptodate(r->folio)) {

Do we need a comment here about the kernel_page_present() check to
make it clear that it is handling things like secretmem?

>                 if (!IS_ERR(r->folio))
>                         folio_put(r->folio);
>                 r->folio =3D NULL;
> --
> 2.43.5
>

