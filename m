Return-Path: <bpf+bounces-76762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3ECC512D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D5D530393DC
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E885324716;
	Tue, 16 Dec 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRCLpaRc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AC3A1E60
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916006; cv=none; b=aLS/rWL6eufNLwcMdqt9QKgMUwRR0XdZ0ZxEzQrR6q4a+tEMJnsUf+mpE5JFGWlG7HNbh41l5VuNO1Nu2KlINe18ox+jNuVCiYnfRZmImsC0+pUzvpn3vCmAQi+H2M0LndyYYLsiz8Z77q0yHLPv2CZwzAssrbUtwwd3q602wR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916006; c=relaxed/simple;
	bh=n3cLAahIHNY8hnxaB2IOtxIMxX8AsuKLvqqJWkcfUE4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+k086vH/M0/aZgE3WftqEBeLzSFd2rOODngRfWtmxTnr8zispXzYfoWnbNoum9B0XKAKQFH7V3Z3ZitEy/bgz2J0pXUPZ97U3pRLcJ3oPfPRYUj+jegFqGBxJpV1VGyjwKb0xKhnz4jVgovMUTWpaLiJgTSS8pwDKu6BEl0nIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRCLpaRc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34ca40c1213so1837146a91.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 12:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765916004; x=1766520804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qveI+dX8P2r9fEY5X0SCk5v3GAbGrMIkl93/L4Kg26o=;
        b=IRCLpaRccv+AZgzDYjV4ZcTkZ9sWvpSc5o3let99LYl0txHAo8vc7shgH+LZknT/i9
         TRyHUfR3caU9LTdQjt90GL5xB7Hg9MZR+7TojMl6qxvbu2uqTAWUrWp6Uk149LLjsYYh
         kIeWJhvSyAOu9g90RiWc+7E2O96GqpdlBivUCdxO7mjgfVNfEdj48JTVzuakv6CZ9+//
         JI3qF5RJNjHtHJQz4Ibez8OPgOW/GyVFbZq6V2Ypp8M8C5Vjy/bE82YF3VylBOr0MJvf
         X1ueGQ61SHHdkuD3au7anPApi5X5nauZZCM6jMjW6erSd0GH6GRn9MpJXWkBBVV02bTL
         EeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765916004; x=1766520804;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qveI+dX8P2r9fEY5X0SCk5v3GAbGrMIkl93/L4Kg26o=;
        b=BSGIU5nNZ5RDICq51KjI1i8rNjD2KjZUA0TYMvykhl02VLPc7y0QRRfMXxNL/6MnxL
         KNLjP+vYDNeRWdxWQ7BGa0Hx5bME8D1+l3vmo+r8dJiDiHZdi4wcQ7bf133Hxf7dzjq1
         DV7n43FDFkrCeTf8ZZWqF1dUiOaZreRpaINXrnytsPIdxaFQvps63tHOW4SXMRXFWtQ1
         DwspOQhxGuBTE6hMDvJLV3mUG9K1dJnIuyI033+nziG+uFwuZ3pA8fs7f+7XsWdwGB/r
         jszl7pNmq9yGYjG8Zj1IBC0Vuu3NwxBlVv0vCxI7mZFjLnS9eNiyyDwXebknQqEzw5jh
         s34g==
X-Forwarded-Encrypted: i=1; AJvYcCV6VE7vphAGNSynxsnceWjQSjwoIkpZWqK0CY0fLd3GvvgV/KNTgGY0GTa/RUS79YvpTWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuvPr1M6QjTxjgSDATKhgSSTmDd/4vyvS60WgncH1h9MYHXKc0
	Za47q39jM3+bDgM0j+a3H5xLt5g4APLlEHAVGu2jgtAij7BQ9WSl0uxv
X-Gm-Gg: AY/fxX7FEBgg84yaLv8fRlzwdmk8j5aZuTFk/zSFPNbkNQi7zF+Ks1v/n6FZe3n8Ffc
	0ENMWhzdPoUZdA661tFlsAMReB75zRbu11wjUxJxaMMgxSGVGQczZcRZJ59OaZ4RYnnDBwe3NJV
	vQJYbIAstX821mBetAsyF12JsAJyMeqFcxQiTqdNrLMxFUNDdIFmsHfXPPRBkcrCSWpG7AGeSgC
	GWehPOOBUTqZKyOosQb3j3Toym27QjTaQI6TgJmGTzc6QOVfTQea5XJRwerAzDO95HU70S3tlnI
	1NVfOzPgQ+qS53cIUde1UJy8CXWQsuLha70OKAWx0o3v+Q0h0WC5v7ZIoVZ9QKTt2cXdr7RkbPn
	cSQzQf8gEoQtUXo29h4GJm8mQggXhK8T3Y6jv7dUsyYcfDY6/JS/8cfvY50IwQ0LiC6P7Kj2kVB
	Yw8XKDJCkw
X-Google-Smtp-Source: AGHT+IFaBZL32WweVVYKZdHojloQufh1T7BEjnU5gc55HHTfwGNPUX/9MLKWyH/A2SbWWK33Jq/YuQ==
X-Received: by 2002:a17:90b:2d83:b0:34a:aa7b:1af8 with SMTP id 98e67ed59e1d1-34abe4a2b9emr11060867a91.32.1765916003833;
        Tue, 16 Dec 2025 12:13:23 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cfda399f3sm280810a91.17.2025.12.16.12.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 12:13:23 -0800 (PST)
Message-ID: <4edb0de3c4eb13d276df8741c663e398ddde5708.camel@gmail.com>
Subject: Re: [PATCH v3 2/5] bpf/verifier: do not limit maximum direct offset
 into arena map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, yonghong.song@linux.dev
Date: Tue, 16 Dec 2025 12:13:20 -0800
In-Reply-To: <DEZTEJOJ7WF2.1VFDHK28XKO4A@etsalapatis.com>
References: <20251215161313.10120-1-emil@etsalapatis.com>
	 <20251215161313.10120-3-emil@etsalapatis.com>
	 <0720a98e6a73ee6298d73b2c64a08f47a4337007.camel@gmail.com>
	 <DEZTEJOJ7WF2.1VFDHK28XKO4A@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 12:25 -0500, Emil Tsalapatis wrote:
> On Mon Dec 15, 2025 at 3:19 PM EST, Eduard Zingerman wrote:
> > On Mon, 2025-12-15 at 11:13 -0500, Emil Tsalapatis wrote:
> > > The verifier currently limits direct offsets into a map to 512MiB
> > > to avoid overflow during pointer arithmetic. However, this prevents
> > > arena maps from using direct addressing instructions to access data
> > > at the end of > 512MiB arena maps. This is necessary when moving
> > > arena globals to the end of the arena instead of the front.
> > >
> > > Refactor the verifier code to remove the offset calculation during
> > > direct value access calculations. This is possible because the only
> > > two map types that implement .map_direct_value_addr() are arrays and
> > > arenas, and they both do their own internal checks to ensure the
> > > offset is within bounds.
> >
> > Nit: instruction array map also implements it (bpf_insn_array.c).
> >
> > >
> > > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > > ---
> >
> > I double checked implementations for all 3 map types and confirm that
> > the above is correct. Also, I commented out the range checks in kernel
> > implementations (as in the attached patch), and no tests seem to fail.
> > Do we need to extend selftests?
>
> I forgot to address a couple selftest errors from this patch in this vers=
ion,
> but after fixing them for v4 and applying the attached patch I am getting=
 a
> couple failures - direct map access tests #332, #334, #336, #337, #338, #=
345.

Uh-oh, sorry, I forgot about test_verifier binary.

> #332 (write test 7) is an unexpected load success, while the rest are abo=
ut a
> mismatch in the error message. Maybe the test wasn't being marked as an
> unexpected success because I hadn't fixed it up?

For me it shows:

  #332/p direct map access, write test 7 FAIL
  Unexpected verifier log!
  EXP: direct value offset of 4294967295 is not allowed
  RES:
  FAIL
  Unexpected error message!
          EXP: direct value offset of 4294967295 is not allowed
          RES: invalid access to map value pointer, value_size=3D48 off=3D4=
294967295

So, seem to be an expected behavior given your changes?

