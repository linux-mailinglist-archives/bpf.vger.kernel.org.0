Return-Path: <bpf+bounces-74327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20202C5469A
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 21:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C915A4E8802
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 20:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE82BE7B6;
	Wed, 12 Nov 2025 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ujCFF9vV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694829B217
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978339; cv=none; b=qvv9npPzhrafU4epJwWlWaToXDPlb5CxbMfC5C3kEWN3lEaM5ZEv7xhSdCRjyY3G5lCqcV7Ik7B5y3lGFx6xQG1pmh3FJo2HFDV5T7JiVvKlBvg9brL9hHBl7pCCPu1znbgRa6J0Ore2q+luxrYk43bSraJtuKvB7JRkCRnFF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978339; c=relaxed/simple;
	bh=gsP4RuV0SX74Q4sn2qalh8C+3yPvQoVzq/xVfun11BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEpqeO06PSDMlw8zoEDB2gC2Hllq+A9ZU7E01LSDoLjJ9QwprJzeLYyASaLXYs33b0wiXxdLoMxY2+z/sNRWIwfZRuKPNUv6tCOZkEGgTU85hqkQJvd9rGYq1WwZHMb6qqjCL+zZD6SnGLJk2TrTzQqVRckykVF7aIVAIAObnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ujCFF9vV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so29074b3a.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 12:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762978336; x=1763583136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsP4RuV0SX74Q4sn2qalh8C+3yPvQoVzq/xVfun11BQ=;
        b=ujCFF9vVRnLXzvMS2k3iAG8SDEEJO5uSSvMq6Esy8L5kuhwMHCaOZFqZZ4qtAIUy1d
         XQ44qIYBcNuxiyQaIUFIZ6GjH5pWkxSjWTOg96GlX+cz7yS9iQ5szPdiD74Xccj1mZQr
         50W6mg62KC7dH2JGkSwXBA1vpVi4pEw6t9QrQzbJEs5WvNZ0UDBx2OUgb7Mt7XPJuIya
         y3farylFxhsdp9NHRhQyljRBhHH09c/B44PWG/kXG6MaEJRZOJImesuFbni2tXeQVeLU
         X1SR6hyYhRZKP76LN5coM6vSBCScVuoSZzCiqP1wjRufdbyQkLToFe7X7ACvKFDWdMnj
         UWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978336; x=1763583136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gsP4RuV0SX74Q4sn2qalh8C+3yPvQoVzq/xVfun11BQ=;
        b=pWpMD6i9ry4HXEtwG5eMfB7IOvcJtLel8CEONaKSDpxrxDQuEXEFWM6oKHtVGHXHQ2
         PKuOl3Ue25yjgPV+hgp+pwKbvT5wIZpfflNLJaAOVMxldIlS6WvNSr3hMQ7Q7iMHvvfz
         Ios/WfqitqQF9hsZACfiIE0xCxUuLw5XoLheeJXpPfhmqcZ6VQAYzBX4gV1PxilR2sAS
         4W0M1FDi7gviGpRVGx/MzA5U6L1N5hIubvyS5sDDJNbCTRDTQAz3ub0hAuzIASg+7Jwr
         Xaxhzk5PXiotDzdKQIscpTEZt9j4BxFuE4EU+21NzQCgL9mh6AlHDO9IaA1pj8yNgPcQ
         IiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVstfXJgx4NtQvR+eYclEM4O0c4I4UUWBaW2nghrnl8pUVfS1wUOQWEDJsA+P+ieoiy4EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9egQowCj1bp58HGjMYqDgT4yTQnR826WNjqBKTd8Pgwzu6+B
	O9VvclhNg7/EyO+gRgYUZzNE1HBTcjjRYweL/LWIvEjRYmqgU/QeZtNxt8JS/1cq5QU=
X-Gm-Gg: ASbGncuKy6BaGz/hpy2i+8zAnHqGWxsTb4Xug5Xt2eFIWun5UW8xvc3zb6y0O/Og2uE
	5BsE4bs5f5Mc4FeZJ+LsT1PRDe0Ug8l1TrwBoEWLZ/K5hWjJBspwaTAsUWX7lvIo7Ik7Vdv9pG3
	GBC9ggLbXqKZ1dYWtdcNe/EwHbURBMXSPW4xicEBiZ0arROL33eaylcvntwZbJ2eUPC+RHnOyIn
	bLgRO4gfphswlk5flj38OMN0PkqycuoJK4gzbGFdqG3jRwsdwGq3TkOdCEkQcGioFMOJ4vCklAK
	MyP3gNoAChqf+cn3ejVrq9+4Uwkmb929pxY6kYmFtb72kP5QX9IaKzXiOEY+0om+xB5E7N26lAs
	2ZUEU2U/tNVKDdQIbrbh71TRXk945LPrmir6rMMBySaHf66KruxLq7sq8WlNro3LPHFqD5Duf4r
	ItAy5/q+vGKdI4EXAmq70jrQHQoRfNBPKcuA==
X-Google-Smtp-Source: AGHT+IG0T8LAB89N+NLBKJi4tziCPLU6tUuh6eDgoooLFm7itDIrTgHFde48cWwu0NOkAzvIltUARQ==
X-Received: by 2002:a05:6a00:4616:b0:7a9:f465:f25 with SMTP id d2e1a72fcca58-7b7a52c74b9mr4620225b3a.27.1762978335682;
        Wed, 12 Nov 2025 12:12:15 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff8538sm19700242b3a.28.2025.11.12.12.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:12:15 -0800 (PST)
Date: Wed, 12 Nov 2025 12:12:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1
 code instead of AF_ALG
Message-ID: <20251112121212.66e15a2d@phoenix>
In-Reply-To: <20250929194648.145585-1-ebiggers@kernel.org>
References: <20250929194648.145585-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 12:46:48 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> diff --git a/lib/sha1.c b/lib/sha1.c
> new file mode 100644
> index 00000000..1aa8fd83
> --- /dev/null
> +++ b/lib/sha1.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * SHA-1 message digest algorithm
> + *
> + * Copyright 2025 Google LLC
> + */

Not a big fan of having actual crypto in iproute2.
It creates even more technical debt.
Is there another crypto library that could be used?


Better yet, is there a reason legacy BPF code needs to still exist
in current iproute2? When was the cut over.

