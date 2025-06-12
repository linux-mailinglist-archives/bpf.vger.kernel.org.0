Return-Path: <bpf+bounces-60526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA7DAD7D3F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F59B174095
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80B223719;
	Thu, 12 Jun 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyqhdS9+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925E2253EC
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762926; cv=none; b=QkyG+NogBRLWx4Rrynjw8XCus2mAPD+h42lQag9UYzRa1ixBlRgjIKUpJe+fh15CnMNFgfdkeiNoeey6MIQqfhf2RsEXkVjIzITE9vY+ZbDVGqvpOLWWP8dYC7u7fsukOHpU1wTG53sTvsi0oX+0Kt3UPAuw+S8o/IyDzCGjsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762926; c=relaxed/simple;
	bh=wX92D09gPnySDER2DxxXTCZ4SWqUHA1cHyRm++3mKRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOFhz2QVMZm/z/kcwXBaUasmS8Ox8yv8FqbhCPTeZ26HI1Is4ce7SvDu0G6A30OzMRPp7ZRMe2DnCEnkhqVXfbSzu3LaxJNl9BriX7nfhydg7qINHRe4yNMIOcSy6jdZzuViE2lNYTdR5A9F4zjjtc5RiXHBjA7GbB97nX1MViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyqhdS9+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a53359dea5so931418f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749762922; x=1750367722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX92D09gPnySDER2DxxXTCZ4SWqUHA1cHyRm++3mKRo=;
        b=EyqhdS9+eoS8r0EgrLNLUFUjioRHIpKyc8l+TbAs7KG13Ko8tyV8ehz1p/nEdwuTzF
         dYzTkM0YMF/JT+XDtqPI5v8EvO6Z1VdaqcTXKR+2KwcaxP6j0W8nqpBdvszY3W8Q9d3E
         ApTZ3W4YX2IIc66vwNdYlCiWf8VBr0an/QuHgSTzxkS8BNChTarl2/SkTjsOjme6bL5y
         W5dyGyEcxQ8DlDdblPO0hTVwIHb09WTEZoId428lfvsYcAeyOrlxnwavjOFXYZqPC0CX
         RGzrnL4FVz4r/3XqkhalBjLVBC5CHunoA3McBVe1aZ9mgbmZf3JYfWLL3SfUe+INF4yI
         tt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749762922; x=1750367722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX92D09gPnySDER2DxxXTCZ4SWqUHA1cHyRm++3mKRo=;
        b=a8JlumcQGZmVw+IjTuhejGmbA6tHeu2AWa0R8d1pw7FRn8spJTKKCk6dh3yNtrZVsA
         0R3vt4dPPR94oFSnjM65poSW/jQd296D74xEF5MIqVN33bA8QjuAyNEoCyXI1T2sAhEd
         WZjGL5u5lV3CpHSNQb8c1MZXEjqx/1wb3mHE8cZWwHSDW9PXi85bbhEEyTHH1lMWSfv8
         ANb8SWbn7tZVzQsmhNfuaW+SDsL094gmTAZXI+vHJidn5dPBE54x09Sg9pgGHxnFGQl6
         W8K/BHVvNZ+jQGJILEqOQGBAmhmSZNI/uLWcyraQ7GJF1numPZBfW2kRRQKkpBQ1EJWV
         K9ag==
X-Forwarded-Encrypted: i=1; AJvYcCWlNoMdtn7ji2A6hMXLYapdt5iu7sqg0R6covLn8Zbt/ChnMmUx0ABGT03zO4vYaZMwum8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvSw+AVJJ8jTjK1E5TM2XBoupRLkeo2nc/f8C8y3TMzE8Tsra
	jitmtcgQO1VhhZ5U5omTglcLoDUByTadyOQ+RgKlPmkZE5cRVh6PQ8V7cwj++XMk3/vQYEyyI3f
	NkrO+hKXqkri2dXxCsfvhKrEWnVcrQf4=
X-Gm-Gg: ASbGncuOb1GGojdvJ07SB4f0ts+z8ZF1BhannVSCq3txD52x+erN4r1qcSrHaR4WwWL
	exwsSkadWJej4z57HPN66rDB6SEiGaMWK4pN4dLjU7CD4qmd21x975UqxbhD4Hf6dp7dxGWtSk5
	xq0w3yvg+7t5gGHT2/9x0DkxM8WJJSR1e7b1mwao/SZfVUUcvcs4VzjX3aGXM+IGgp1lpSyrYd
X-Google-Smtp-Source: AGHT+IFSTgxY5eC2r3lInVjinMMPm5pYOl6zjV+DqjPkyVXg5HWgY0OqHrgreQw7VjwNBqOlPO8Xk0voSv+FrwhNfWo=
X-Received: by 2002:a05:6000:26c9:b0:3a4:f435:5801 with SMTP id
 ffacd0b85a97d-3a5686fdcfbmr625227f8f.17.1749762922313; Thu, 12 Jun 2025
 14:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
 <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
 <CAADnVQKNBps+MvPmHG3BGYtNV34ut6L8cF+wCNWCOLTiauuL0g@mail.gmail.com>
 <cbc60943-783e-4444-9d46-3a25e71a6e63@linux.dev> <b35717b7c65a0ee8baba9800dbbb2c9e58c62b32.camel@gmail.com>
In-Reply-To: <b35717b7c65a0ee8baba9800dbbb2c9e58c62b32.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Jun 2025 14:15:11 -0700
X-Gm-Features: AX0GCFtCRel8zrkeWMFFmp0jglC1kEmtJsCWwOEONDplO0hlzeeosobfap6jXek
Message-ID: <CAADnVQKrrEFcUdUvagwSkrCLJSoud4Jv0=CM2rX7p5MYKYOC=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm codes
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:49=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2025-06-12 at 12:29 -0700, Yonghong Song wrote:
>
> [...]
>
> > > Warning in llvm/gcc on imm32 > UINT_MAX is not correct either.
> > > llvm should probably accept 0xffffFFFFdeadbeef as imm32.
> >
> > In llvm, the value is represented as an int64, we probably
> > can just check the upper 32bit must be 0 or 0xffffFFFF.
> > Otherwise, the value is out of range.
>
> I agree with Yonghong, supporting things like 0xffffFFFFdeadbeef and
> rejecting things like 0x8000FFFFdeadbeef would require changes to the
> assembly parser to behave differently for literals of length 8 (signe
> extend them) and >8 (zero extend them), which might be surprising in
> some other ways.

Ok. So what's the summary?
No selftest changes needed and we add a check to llvm
to warn when upper 32 bits !=3D0 and !=3D 0xffffFFFF ?

