Return-Path: <bpf+bounces-63680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919FB09908
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 03:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC94A636D5
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 01:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3872613;
	Fri, 18 Jul 2025 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRlsFl23"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552B27453
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752800752; cv=none; b=oKse288u7ZB01R6QRV/JqubqDC/uXDRhvWP1nLmaimZ8HkS+VCPBZfshyR/S9kmMQCiT4G5v/bkrNIGrK6T3AvA33ALiUh5JStuutFuf3U3athC30EW/HnviCdKpni0Ja3ZS9vlWIkC6fkzWae1b4W0UbGyIls78qotg83zgbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752800752; c=relaxed/simple;
	bh=/dfK6j4zTemlnLv1uoTWwyCk+z2zrLtM8YVysJ80WJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYlyyY/voOCrnEPHxfNUqWiG93LAX0vhKDt5gG99592OuSIjgBgb1XgegnytsWUWG/nhAyxoeOB40RvHqupBMkaNFc/z+8BRBLBzhTjNsgp23r5U35r9/SJceRqqmg9oXJnyZdUC96GQik5HoYcOCw+zbClN3GlLmxkJ06CujaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRlsFl23; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-749248d06faso1417749b3a.2
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 18:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752800750; x=1753405550; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/dfK6j4zTemlnLv1uoTWwyCk+z2zrLtM8YVysJ80WJ8=;
        b=GRlsFl23QPrpPkB+hMGyk9y2LsJLRq9ZovtQc/FvF7idxd2L+oPzkVPOuxLZLs74lP
         BcGh+6cbqjRguwzhSnjAQh9c/mN9FsMciJhKCHwj9UASY+BOPe3VJmxwIVouOjrfeSHR
         ABoq0/2A9TekXhi565tLLJL3UXp6v6ktTga6/kH+P5/uKBNlp5NT1vI93BVQ6aC850AF
         2Q+lNk4yVFr2kyiGUWBTiZQM8ZNa2KPftP4s92clVCfTqta0PALa0QQfs3q8kvXHkRcQ
         fSqIW2WUCfCcZ1Pov05Zj6fdh9blXvHYiQe9ErD2TTq3kscuek6JR3K3SFK9o6VPgr/E
         km+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752800750; x=1753405550;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dfK6j4zTemlnLv1uoTWwyCk+z2zrLtM8YVysJ80WJ8=;
        b=D4zWwWqfbVyZAn8OLW7OYtJ1QdLoAaGtKU5P4SEPRUt1Ua04YNmjchDSmgYJ5Spujr
         FGVhFKelrtVdZ2CZBB+3uEmlTo6ucYRop0REEdWPX0PdA8xzCgIibGmAXmup2YrJM/xo
         DrBkSn2Um5r6z3ohuwk6tOLPIo7oWuCXdOp+cNUVGKzABY3TlsAqwV3+DsM1q6CtJf5x
         yAmHIsTTSGo4prLU/1hydTepyU1IXZYqfGfGcKV/P3rIIjnNpSFB4+f9oGqO/ip1lzHW
         VqEUv+xjS9ImHmuFlxKrffvwDGu0iKQq1tK7T9yo8jSHrFIPar0h/0Kg0PUZ8XSDOKex
         K7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUIDc0VhlSonkr/62Wde6w2m3d8uYu9esOPlFN+zVT+4rBAhaP9mCsMavKlx23x+D0eboI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYMn9JP7ssQ+IfJfjW7uj+wStUojYTLkqXC6/0+wNX+Y8IeEm
	r6PxRn3wCjyx1CTAFFhCPKpkdtVfmdtc60q6AbIt86ijucBzMc01frhQgyEr4+CD
X-Gm-Gg: ASbGnculQEXPPANNGFgXIrOMswVD/E6jgkZ8e8KlsetEYyzrnjgVc7OgLwECLyFOHun
	p1g5jNsGT4CxFmx0+lyg8Y71+8ILxPIHzxRlsoDb6Z7J1F9vdUnr236qyB5/ZiKJ67AUFudEwZQ
	EY5IW6+ZHc9SUVtnnlt8jlH9LropG5DK1PneUXFQCmGuibp8UzcZ3iW2MHahOJu3u+Mo7AG7NGk
	kC0+biyx/jho3H6El5S+b4q0Wft9fBaXejAHFBwyWoeWz/6SVnWvSHoou+7J1e+rdEjXIBS3q2D
	O/JezZVfqWzCY3+nHqgKzVA9lO3iaisps9QefmMsyFclY2uq3ez39jL+2oeTY69Nvjsof1fWZO/
	hK5FSuc8YyQATyJALwNBVqcwn489tzg==
X-Google-Smtp-Source: AGHT+IGiv/UECixTAijs9o687LN4asRQCqho8g3pFj1nfnVmEcrBVJ2wzVSvPGrN1tdhoXZWh58xNg==
X-Received: by 2002:a05:6a00:1797:b0:74e:c7a3:11be with SMTP id d2e1a72fcca58-75848c18a19mr5885763b3a.5.1752800750430;
        Thu, 17 Jul 2025 18:05:50 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76da69sm160260b3a.115.2025.07.17.18.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 18:05:50 -0700 (PDT)
Message-ID: <a1feb8cd674721024afa5de14e73b518a8258531.camel@gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix handling of BPF arena relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 17 Jul 2025 18:05:47 -0700
In-Reply-To: <20250718001009.610955-1-andrii@kernel.org>
References: <20250718001009.610955-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-17 at 17:10 -0700, Andrii Nakryiko wrote:
> Initial __arean global variable support implementation in libbpf
> contains a bug: it remembers struct bpf_map pointer for arena, which is
> used later on to process relocations. Recording this pointer is
> problematic because map pointers are not stable during ELF relocation
> collection phase, as an array of struct bpf_map's can be reallocated,
> invalidating all the pointers. Libbpf is dealing with similar issues by
> using a stable internal map index, though for BPF arena map specifically
> this approach wasn't used due to an oversight.
>=20
> The resulting behavior is non-deterministic issue which depends on exact
> layout of ELF object file, number of actual maps, etc. We didn't hit
> this until very recently, when this bug started triggering crash in BPF
> CI when validating one of sched-ext BPF programs.
>=20
> The fix is rather straightforward: we just follow an established pattern
> of remembering map index (just like obj->kconfig_map_idx, for example)
> instead of `struct bpf_map *`, and resolving index to a pointer at the
> point where map information is necessary.
>=20
> While at it also add debug-level message for arena-related relocation
> resolution information, which we already have for all other kinds of
> maps.
>=20
> Fixes: 2e7ba4f8fd1f ("libbpf: Recognize __arena global variables.")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Tested using scx jobs failing on CI:
https://github.com/kernel-patches/bpf/actions/runs/16354530864/artifacts/35=
58110958

The change lgtm.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

