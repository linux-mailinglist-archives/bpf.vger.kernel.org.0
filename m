Return-Path: <bpf+bounces-77641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50227CEC816
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA5D3013940
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8630BF59;
	Wed, 31 Dec 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOkwg9O2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232930BBBC
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210276; cv=none; b=W77lsPwQmED+3oxV44FB0WL1p9eHShYytp97jhez+Rr4bpC4ID4/LnvSt6dTwzAi1I1Xv85Yob8L8LnrkH3Rupeq/vGDkHAiDo8Iphk+39hbwhc8F5yIqD62wAlauwJny2yfopRVrBn/RLLw1XhL0XYhDaDVXckdakHiRyWvT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210276; c=relaxed/simple;
	bh=ITv3OowTDTvKsCLvMsSzLCoIm1dYPkwmOKQhv8auRrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gsh2aXL+u5dxEvXeXHpAW0Kvqq0CuOU7SXE1TQ2GOc6YH+fql8oScVDXkIc0U12phHtVBoAkL0NWPOxpOrRRlLVtn9HG0GekKeFoJ2tB7yQ+j438AnELp783SZCIuw9sdKTP8D36C7kVg3rrbeoIhvB19sZF1FzveiYy+2H6cME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOkwg9O2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c213f7690so8914490a91.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767210274; x=1767815074; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ITv3OowTDTvKsCLvMsSzLCoIm1dYPkwmOKQhv8auRrs=;
        b=OOkwg9O2m1xqoDhiMMUgJLoQ6DYV5Iuh0gQKNJUI6of+cCaEfQx0YG6fh7Ljc3PzJP
         vYsZv2GNAPzhMhtZMtNNg81PRZgKg7yJ3ajXr8qKiyIJaysver/oIvckLEUZFbf+SxdY
         dSIr64Te8XS2PaWxRivDsi10/N4DGlk9gdiuCvQpBDv0Hzky/Wy0Hyg4UDBASjhzNjEm
         wfNQNwxPx8Nsa1Trg/l++mjUtbdIPSXN094DMqfUjobR3vHePYCj6IONeCnbe2mLX1j5
         wqsTyocwl15nOrfWpJtCFHe6jp7lg1Gs5DHcNuLCYUmhIhnZ+RQDNjLWeGcrORvdJgDT
         VnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210274; x=1767815074;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITv3OowTDTvKsCLvMsSzLCoIm1dYPkwmOKQhv8auRrs=;
        b=G1c1pUXUNau/Y1JWx3MUTdP32zyChR9GDGk0TorJGqW6r5kEq7qyprzWQWtxTafP8M
         TducTlMI/saoShI4/Yj0aRgA4QFWPx6cfAt/cuVzGeSx4CCy6Z82g5KS6R8kVddMJpsU
         cg/ew2HTVRaiPYRlmf+P3RvgMXm7ZSffz6IriYUJNRkSKnz5xtU0kV3vNgPnHxCQEhYY
         /Mo+TsGAW2+hV4GRYKvIKuW3yas/ZYdV3Yz2tS7psMEecV5j42ivDsgYhA3BzGDYxmig
         SdaUA1oQfzEu7vdDqltgACEhuAyERQnLEeZxRV3NqZRgnUBSXtjLD40zbz/BcBrYmtW/
         EEAQ==
X-Gm-Message-State: AOJu0YxkC76bQzog55pYIkHMkK2XyTptH05cZkLMEKotfmdSPbt7IhK0
	v9eb4nhqqZTDp0RWB/gYwYec4YpDlxutRqrY5HLf2HeFqXEoCQ3rDkVk
X-Gm-Gg: AY/fxX75JPWXro8RjbMEREA6VV9o+MKdaHuh0Fr7bvL/qtkCZ07F7YQskwxWKf9ABF+
	ivGVR7o0gm17B0ZTIbohJ8VtgXkTAY9Zb2qQd7UJjjpz9G9IAIqJfut6p3TxQJ4HxYhM8NT593L
	K+fUr20tYhoFAyeTTwnmpkTFKXz8KLwRUXdXqw9azrcKtBWZ+t5ar0C2kkTnM1PT/spI12JwHj6
	9NLMSZTtpiBbQ59a4SnN+tmlJb/44GAJormFJfolEs7JarccuWG4ypfmJj99KQsE9fsK0GR5qf8
	dg8IWP1vphE21l5Ej1p26d+ac7blkanZ/lYuuo+7d2KP7VzK+MAcjhETDfqlrujdINx9empv/Zl
	cYPpwGBaKH5e1RFZDdd5fTAWJjqGSbO+iOp/dmwo5YBD3KV4lbY36g2mFkIzRqUig9Uf1hSNmr4
	va2zl7EiET
X-Google-Smtp-Source: AGHT+IGKBUrTC9Z8NHskVEKNe8gjYUYCu0s0hM1dhmz5T1slgQPlyqzQ2s6WefjikyalSKExq7lyBg==
X-Received: by 2002:a17:90b:134d:b0:34c:aba2:dd95 with SMTP id 98e67ed59e1d1-34e921c700emr33727072a91.26.1767210273922;
        Wed, 31 Dec 2025 11:44:33 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9223aab0sm33670599a91.13.2025.12.31.11.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:44:33 -0800 (PST)
Message-ID: <8944ddc867831bf2e5c6d9275618f9c56c61395c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 6/9] selftests: bpf: fix
 test_kfunc_dynptr_param
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, 	kernel-team@meta.com
Date: Wed, 31 Dec 2025 11:44:30 -0800
In-Reply-To: <CANk7y0hXxYsmgMY9km1ivtt-Bd3=tbjf4+vra5y_5M66srEh_A@mail.gmail.com>
References: <20251231171118.1174007-1-puranjay@kernel.org>
	 <20251231171118.1174007-7-puranjay@kernel.org>
	 <138667689e511652194fd98ad0e20d71f7738234.camel@gmail.com>
	 <CANk7y0hXxYsmgMY9km1ivtt-Bd3=tbjf4+vra5y_5M66srEh_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 19:39 +0000, Puranjay Mohan wrote:
> On Wed, Dec 31, 2025 at 7:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> > > As verifier now assumes that all kfuncs only takes trusted pointer
> > > arguments, passing 0 (NULL) to a kfunc that doesn't mark the argument=
 as
> > > __nullable or __opt will be rejected with a failure message of: Possi=
bly
> > > NULL pointer passed to trusted arg<n>
> > >=20
> > > Pass a non-null value to the kfunc to test the expected failure mode.
> > >=20
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > ---
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > Unrelated to this patch-set:
> > what do you think about merging __nullable and __opt?
>=20
>=20
> Yes, I think we should only have __nullable, because that is how
> programmers are used to think about functions, just pass NULL if it is
> unused. But I will see what the verifier expects differently from
> these two and send a patch to merge them.

Ack, thank you.
After cursory examination seems doable to me.
__nullable was introduced [1] after __opt, but mailing list discussion
does not mention __opt at all.

[1] https://lore.kernel.org/all/20231018061746.111364-7-zhouchuyi@bytedance=
.com/T/#u

