Return-Path: <bpf+bounces-61570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA2AE8ED4
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83AF3B767A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B0026981E;
	Wed, 25 Jun 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqVa/1Jr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D41FC8
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880302; cv=none; b=sVv/DRiITyzKMC/Dwsp0gZS8kUw4icSyyTN5uS828Wqlzo47Id/26UHpVla0HDt9CwyWRrfxaWwmWDcYNS78N01fr+lCPz4DWRmAJHdR5mT6+j8CsJxxa+b53TjTXj48UmHA6Ltfq9ZNVztS4nO9carecLQlGL07JwvpxDfjTao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880302; c=relaxed/simple;
	bh=O/5XzOd/KGuE5xqR8jRkQLQJC7VAoCsj8nHdu4W7X7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtCGA2wb83Aj/nzaJuNM7YwtLBVFPpevxTrUCWBrnzPTk0LuAfv8aDn34dAkHbQqgkRYC+pSqB5XsOEyMHerniCsRG6GJ1+RfnHtbTS1/OIU7A7qjLUaOtQSLsk6p0GacZkU67ldWCqOKIwWzzE1B9HUIq4tpyYpXx1gJ+ujfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqVa/1Jr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31393526d0dso181192a91.0
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750880300; x=1751485100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIQPXP95Y8jtIzEJurdt7HwLfNvS0XZBamXwTkqWGDs=;
        b=mqVa/1Jr/nSP/bl+ik7gYQ3ntFRNrV6MEkqLhuNRLhPijf0ErVGgAs96kR6K6Sndi0
         tHD4fP/KNsctwfh0Dwu+jnugsVl/2BfVtueONEx62FBv/TiiPyxbVCrXEX63JVybsmGv
         H+dB6zZeO1mSjMl0BeJpwwlipfCzrVbiXp+coOjbRLbZnqe0EFHiZavc702hTF8vt8oz
         FMlnfTMBhTtKCrVVnuvgWGA1C53MHcgaSGNcm7HOoAavGHam380VmQnrAsnlXusIylX4
         tOCDwEXEORhyBB3WwcFT+s2tndkrKH8mO0mGEypwyyUwnalhD3v2JBDE7oSVPWHLs9os
         3DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750880300; x=1751485100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIQPXP95Y8jtIzEJurdt7HwLfNvS0XZBamXwTkqWGDs=;
        b=TIC9Fj0XwzOZF6RCMwUpdTZXdESZeyT/Z3tn8XNKy2l9FjH4do0lg1RP0W0ZK5hdhG
         FRsHO7FbMhZXnKFsQ0ixd4+KzPbTAjTuKIgjL0EiGpg8wWcGKcCoKJoZaZNDluB4UCx/
         KbzoN535sNRjFTSEP6JhKC0I86la1SNSCswcPwaXo1arUpBhZCd1/j2hFOIqbhibA2eS
         7boMCUfhm61yWItFNj5h05YxmTwAEiPPShZcu57Q/kKuplDne5B6H/KFS/PW4SBf80FA
         KP+stRdBzV706ug4psnti5UlaAhDUZCgjR5ml7QLJqmDpbc41/3cSckLVsUiydmQZlMl
         l5tg==
X-Gm-Message-State: AOJu0YyMXcvxbJDb/+VTgYKslL3IIHXP4OE35L+1HwVfa+6UKOb7ycwB
	hRh3/iH+0wQPl+k8QRwnwXIArgqwoJNyBAXtlgaT6MwbcKfeJrZPt4h+HvgSAHlk9fMbKmjVrDf
	HYs5USDuo+7RalFE84xsYoufqTUyaRwo=
X-Gm-Gg: ASbGncv3bkMh0KSqQW5w2PEMW+pCmU/Cr3RbBi07hr8Y5d3b1swCleV6GlHIYZSi/OD
	FlPyomtLhaYv/VJIDhEu2etNo7XlMeuNU45rrnmSx2vWg/e5+R8KGfSvsp7pArEag6Pa5p7Xxqf
	WyJHswFboVK6M5TwgOyRQnahNZHUiw5cwKsznuqvW7DUPfDPpOHZ1yuBdKg3IBBawIpeAkGw==
X-Google-Smtp-Source: AGHT+IGw+Bjgs6+RhGfWJyg8HY1GJ7vJtg1OLZYz6+MDvyMWdPpGWmw3mgZw6sqFY3az14ExpmUTHwjNGqYdlSI1Bug=
X-Received: by 2002:a17:90a:d2ce:b0:311:ad7f:3281 with SMTP id
 98e67ed59e1d1-315f26264b6mr7444014a91.12.1750880300102; Wed, 25 Jun 2025
 12:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182414.30659-1-eddyz87@gmail.com> <20250625182414.30659-4-eddyz87@gmail.com>
In-Reply-To: <20250625182414.30659-4-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Jun 2025 12:38:07 -0700
X-Gm-Features: Ac12FXz6dT5qwzKJlv_9xV9xnjceuGinaDMFhhSW3nCxMAQlAaKXtNUmX6kLnJc
Message-ID: <CAEf4BzYv1GKz81pVsCoeBBO5pdc76bkdg-AY6vA9sbbaXE3Eew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: check operations on
 untrusted ro pointers to mem
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> The following cases are tested:
> - it is ok to load memory at any offset from rdonly_untrusted_mem;
> - rdonly_untrusted_mem offset/bounds are not tracked;
> - writes into rdonly_untrusted_mem are forbidden;
> - atomic operations on rdonly_untrusted_mem are forbidden;
> - rdonly_untrusted_mem can't be passed as a memory argument of a
>   helper of kfunc;
> - it is ok to use PTR_TO_MEM and PTR_TO_BTF_ID in a same load
>   instruction.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../bpf/prog_tests/mem_rdonly_untrusted.c     |   9 ++
>  .../bpf/progs/mem_rdonly_untrusted.c          | 136 ++++++++++++++++++
>  2 files changed, 145 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/mem_rdonly_unt=
rusted.c
>  create mode 100644 tools/testing/selftests/bpf/progs/mem_rdonly_untruste=
d.c
>

Would be good to have a test that demonstrates loads of all
combinations of signed/unsigned and 1/2/4/8 bytes. Maybe as a follow
up?


[...]

