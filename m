Return-Path: <bpf+bounces-70461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2618FBBFD47
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B810D4E6835
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E941643B;
	Tue,  7 Oct 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2j5bYAO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79DB34BA44
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795571; cv=none; b=R9HnxIY5rZEqMk6uIq6LAtON2ZUYPfYNFF5OfGQt01ErvW1WU+hiyKZOloe7t5HOXetCo1Tg4lLqOksplO4OrOIztQy5MOT/Tp8Gb+wmLAfB9SO9yNMIjjK3q8CyKOJUp0balCd4ZgbI+wEm/T2IdvANuCKHGyAHmIr+pkkF3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795571; c=relaxed/simple;
	bh=QkUM17RIWIWT2WqGHpap897QMNt5vpXsfzPR5YiMYt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArSfrw0PKX07u0PdmRJG4t+6YGgHoVGLFk/1gi0xpLwyaYPBQxMx+6TUJniFlqKGjdKkXEUSOeyqDOoXjEKo5QZguIrTIPnACNc60pYEcVqRz5pBFb6ZObBZA8AhH2rtJxVEYblzeaGacp5xACDGUSzIUCecRN6rgvRr/UpPjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2j5bYAO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so6590770a91.3
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 17:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759795569; x=1760400369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fv2ng8VVbInmm75tiW7IcKlbkfdGHIMIbrXtd3o/uVw=;
        b=i2j5bYAO0mT+ssncNIkxvBXbRKqjXefeNrhlmTJDPFY/YGDd/q/K2QWGo2ncuXT/ID
         rgxfLyFYFv5tDp0ThqNn2Gp3FXj/eNE849HWOT0FnSIrwFnoyJEx2c33wvBJTsqwO4Wl
         s9n8qtX4+g2+XXHeXF3fVqO1/nEbFJ9D32KUBa38Q3+J/EQJWd4FpKKjttiUEWvQNbUK
         GycH9FUoqjrcqCiw0779lw7n4rzMehgvyYiascRLUd+FCUAeYSuSDMyc8IR1xa0Axff7
         aayjEyrVqDRQMQ0puXYDbxm35H5hRhagSFmLyG0sdhiiJcfUsJU9Jas12kA0P2or457k
         pLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795569; x=1760400369;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fv2ng8VVbInmm75tiW7IcKlbkfdGHIMIbrXtd3o/uVw=;
        b=WH8cCnVyQsOYqVktJZFLr2/ILLgHUY6engKzfVjV08kyDbgVBKnbsEFHczmNMmopsv
         OpUshvsA/rFaTCXNeRCmT/OJG5X45BsSERpZ+YYx1NfaKC2fHuP5A0SvRDvUND2nZ8LH
         yfO2mZi2w9+MtALJBJ3rUlnAzFluk1wpWmC/PDx4sV1fEcNn/NPpE9noiEFDZA23XLXW
         1qpIRSiVkB+082+WaAFxUlaEXl7HZIb5mNAZd285y4GTr5DtwjLAAvnMHmHLUNRsKuP8
         IlRyolA4OG9/XeCkWvz0MIJVePl4Yu7bT3+9HuxxKlGmo9PjhbtUEYKxa8wzCKnuYqAN
         2yJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX377tCSwyA20cdlGhTeqvOBHt6wVTntHhoW1vwo0yN+19EfSLbPqGXZvj3IYC5Tfoi7pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pUr55ZBxhYZX0+qmYd/9nW5Gvnz0AhxKd8lY6CYk3jSRsRF2
	0z/u06S3oArVclamvU62Eeci6Eiev4viHja9snvpaJ5ZB+eAXZT022Aq
X-Gm-Gg: ASbGnctWHbWd9QY2vEW23tiy+0GpLJpK4ZBP9dOAR567En8aT5qRnu56gfczlvktDJS
	CSNSUbeXg8gm2Cp40gGUqSsrfrVTwHrv3TghbicC0YCWqQt7lQUon0qZuDp7Q8OdUdEjSKboWZQ
	8f45kUFI6GUPFsJgxRjL6VVwtUxeBUgLxP77jWkWWHvacvKTy2exGqu8reAvXJyDthIo+g9RdgP
	/iU9oU2H5Za3Usc15D8XBYxzhQ1EU5ZMsxojTGvZLZkiHy5ZQE8sdQgW265goBqjWO1C5z4d+oh
	e1an4jwGA7sm2dATd6IRqlpOOWys45ZdCbi7SiwdHNNI6SRKtr4YTtWeXa06+6gwVYcFUfkHHos
	+eyv4ouveNCjHEONy7eFng36wYB7ZDGHfXgl5gKLg/q879arXMTOBn4DfyLSR7IVik7s0QRECcH
	889clZnrA=
X-Google-Smtp-Source: AGHT+IGVcAQqfvJtbeGJjlJMUGHB1kjldPE0NTxxD48aLJmvPrbIUSxvWeuDaPPKTRtaEZQrqchf6Q==
X-Received: by 2002:a17:90b:33c7:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-339c27351dfmr19475185a91.15.1759795568831;
        Mon, 06 Oct 2025 17:06:08 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:d60a:adc8:135e:572b? ([2620:10d:c090:500::5:b20b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff26f8sm17948848a91.13.2025.10.06.17.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 17:06:08 -0700 (PDT)
Message-ID: <21daea3f9f53737ceb5de24f96b6e5fb9b6fca1d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: add bpf_wq tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 06 Oct 2025 17:06:07 -0700
In-Reply-To: <20251006200237.252611-2-mykyta.yatsenko5@gmail.com>
References: <20251006200237.252611-1-mykyta.yatsenko5@gmail.com>
	 <20251006200237.252611-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 21:02 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Add bpf_wq selftests to verify:
>  * BPF program using non-constant offset of struct bpf_wq is rejected
>  * BPF program using map with no BTF for storing struct bpf_wq is
>  rejected
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Both tests fail w/o fix in the first patch.
Tbh, I think leaving `test_bad_wq_off` and dropping
`test_failure_map_no_btf` is fine.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

