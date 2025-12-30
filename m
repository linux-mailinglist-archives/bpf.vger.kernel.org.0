Return-Path: <bpf+bounces-77534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF6CEA801
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 19:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85414303A0B3
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F4322A24;
	Tue, 30 Dec 2025 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9PTwU5Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFAF277017
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767120290; cv=none; b=Z4AbqFaX1cp1cXL8A8jSZiEcNPLKjLWYAZ6M1h5C64q9wzqHT61gt83Xawhmf6BYDDczeiiu0/6WN+CEiaLa6zyiVRYHufs2Ppciy4yZ7IYgMP9kj5rgcXbvF8UY3wwKRIaU92GeO9n7uKhTS4CVZpzPYt1EgkT6IS2WEJoDlKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767120290; c=relaxed/simple;
	bh=nyaBjNraBouhpprwaGgsE8CCPCA36qfk3sJVGVBBq/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VsiZRsyXD9tJeb26X0T2E8FN8a3t5H2vFm+MH4YiiryFwThN2OzEL/dt1yCDyZB7q+dNpse3DpHDGsYQ2XHEo4alik1A7d5KxCMaf05sEE9XXPLhTC3gtJJzbHyL3DUkvHgyJ/4HVGMDJAJTc/6tG8rbDv8oZETcQ/Zw5Hyh04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9PTwU5Z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso8109234b3a.0
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 10:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767120288; x=1767725088; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rVsU17ZwOyYZEriEoc6JeACGdHYJwpiHxu6Q1MZ0RnM=;
        b=d9PTwU5ZOVI7bYUYlWtY0v9O7v9jgIEM2s3CUZGFWzRVJakyMB9Ln8tAqsHSOG4baX
         R8w+ohPja78t/fyjWRal/roL751uAi4NEgD0RHXUf8wyISmr5sEV7rp5qdJY8Qdwim9B
         u/v77lNqwVq11l9xYUYJpLEcRPi40N/lwFKVVtc2phnTQAzdfo7AFJI78If8ERUbSQGc
         UekgXm7kbw8j3SxnYtuildIKjsOkYK7+heZJYzQ8oGBBmdJxD/E6UT4fuQv1NN9kFooy
         fq+1n9UckTIRWwjleomEVGmx81wCYsWNf6Ck5GJ+0hq3qNP+aUST6VWwlWsKxNJvLyHi
         LhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767120288; x=1767725088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVsU17ZwOyYZEriEoc6JeACGdHYJwpiHxu6Q1MZ0RnM=;
        b=nPIdSnGkDTWCnbNWnEc2W01dcBsJGD8FgtLbfICMZSfqytw+ToBH8XSjoGvc2y0S5+
         HWolaXXQ3RnGTFpXJjWiKMxbdVxj9pmQKX+EdBQIDvXdNN4vYvdF4qNfUaEk1k9pi3Pt
         t+xxYVgOch+6WuD9lKFgAUJ+JN1Wh1jbNpnLJXR5X+A7qdSQ8RmiKTH2x5ZC2WSnqaHE
         qQAy1Xu0IE0rSTrW2JP1qWSseYrsC+XtTjtxakogsIOux74nmGBAKJxfYnkwakXbGbnY
         B8qE6js/zIIFFNHIZDnpOsACuKUJ55tiStVvy9112sTe/p6YiHRQytiJ8ZGr6xGbCz4Q
         DvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVGoT8FSoWJlEgsCc9QogTzs9BDt0wtvJEOudXGcx3o25XMiSxTm3A6sP95kluY+ElhQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ffsEeGqu4riZeB5MJbF4Z41dDcNU7OFOEo8rdhWH2+kgwUiU
	pE+ZQhFR9e5EkUbPSUk2bTVfj7JFLYrLrZ8JPxtJ69OzxGlmzyHwFFWv
X-Gm-Gg: AY/fxX6zmm6bfqSkwlbZWVczjeTeddvJykYzN2mh2Z5Z64l2IxeeRTWRDICLKrJJZTc
	L2Dn8GYkJa9xn7ZU/HOEELuCoU7i6obYhpaBA4qlvzuJ25qWb6al+F+F/DBnVJxDmpXdXAQx5QK
	b0UkUgOB9J8tUOV5a/PQwSk8mKKo+4bDlF+SKlZ0Rvt+7ncfUZD7NWOo2XoXW4hnR6yLAVE7CyC
	llxjlhdqN36GlW58mXgehFC9vebrk60QksKnMLMTkQ7o3sW7YvPo1zIrToTB7TGdpMf2aiadkpF
	6aZbnTI6tGFBbFyeZWt8rNecgseD3Qj+6C8qerySw4B8ohnBp/NAcYuSNKJFQRI3fI4QeiSRUvu
	8XGOsv5G7JRZQwG2py76PCMhhLB12uRIMv8FLYHcyzDJGMC5HMOfJiwIwbzNef+7bHtFOudrYKC
	WXjqm4/urB
X-Google-Smtp-Source: AGHT+IHmSFc/px3pkbAxMtU5GFCYG3aBR+ZkmdZ7h7l14y8bFqbUxOjJghuzuMxxvFqsyWr2o3FpVg==
X-Received: by 2002:a05:6a20:3943:b0:366:5c80:d5a2 with SMTP id adf61e73a8af0-376aa5f6218mr31835329637.75.1767120287950;
        Tue, 30 Dec 2025 10:44:47 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbca5fsm33838163a91.11.2025.12.30.10.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:44:47 -0800 (PST)
Message-ID: <95c33c1d3dc961011ce91411ccb0682323d0f407.camel@gmail.com>
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers
 print
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mahe Tardy <mahe.tardy@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend	 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Paul Chaignon	 <paul.chaignon@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Tue, 30 Dec 2025 10:44:44 -0800
In-Reply-To: <CAADnVQLDfmLSuvXJFLHM=tOfViSvwPBUyGGZN8OhDP5dRy1_NQ@mail.gmail.com>
References: <20251222185813.150505-1-mahe.tardy@gmail.com>
	 <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>
	 <aUprAOkSFgHyUMfB@gmail.com>
	 <4eec6b7605d007c6f906bf9a4cd95f2423781b0a.camel@gmail.com>
	 <CAADnVQLsJeSjwFVE=gcnVzh7HftDqZJM+xByr2cD6TRmTRGLsA@mail.gmail.com>
	 <62ba00524aa7afd5e1f76a5a2f4c06899bf2dd64.camel@gmail.com>
	 <CAADnVQLDfmLSuvXJFLHM=tOfViSvwPBUyGGZN8OhDP5dRy1_NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-30 at 10:06 -0800, Alexei Starovoitov wrote:
> On Mon, Dec 29, 2025 at 5:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2025-12-29 at 16:42 -0800, Alexei Starovoitov wrote:
> >=20
> > [...]
> >=20
> > > > Imo, it would be indeed more interesting to print where checkpoint
> > > > match had been attempted and why it failed, e.g. as I do in [1].
> > > > Here is a sample:
> > > >=20
> > > >   cache miss at (140, 5389): frame=3D1, reg=3D0, spi=3D-1, loop=3D0=
 (cur: 1) vs (old: P0)
> > > >   from 5387 to 5389: frame1: R0=3D1 R1=3D0xffffffff ...
> > > >=20
> > > > However, in the current form it slows down log level 2 output
> > > > significantly (~5 times). Okay for my debugging purposes but is not
> > > > good for upstream submission.
> > > >=20
> > > > Thanks,
> > > > Eduard.
> > > >=20
> > > > [1] https://github.com/kernel-patches/bpf/commit/65fcd66d03ad9d6979=
df79628e569b90563d5368
> > >=20
> > > bpf_print_stack_state() refactor can land.
> > > While the rest potentially bpfvv can do.
> > > With log_level=3D=3D2 all the previous paths through particular instr=
uction
> > > will be in the log earlier, so I can imagine clicking on an insn
> > > and it will show current and all previous seen states.
> > > The verifier heuristic will drop some of them, so it will show more
> > > than actually known during the verification, but that's probably ok
> > > for debugging to see why states don't converge.
> > > bpfvv can make it easier to see the difference too instead of
> > > "frame=3D1, reg=3D0, spi=3D-1, loop=3D0 (cur: 1) vs (old: P0)"
> > > which is not easy to understand.
> > > Only after reading the diff I realized that reg R0 is the one
> > > that caused a mismatch.
> >=20
> > In theory this can be handled in post-processing completely,
> > however I'd expect mirroring states-equal logic in bpfvv
> > (or any other tool) to be error prone. Which is very undesirable when
> > you are debugging. To make post-processing simpler I'd print:
> > - state id upon state creation
> > - state ids upon cache miss + register or spi number.
> >=20
> > This way post-processing tool would only need to collect register
> > values for state ids in question.
>=20
> that will make post processing easier, but print on every miss
> will greatly increase log_level=3D2 size, right ?

Here are some stats for pyperf180:

| Experiment                                  | Log   | Log  |
| Kind                                        | Lines | Size |
|---------------------------------------------+-------+------|
| Print cache hits, misses and diffing values | 626K  | 88M  |
| Print cache misses and diffing values       | 618K  | 88M  |
| Print cache misses                          | 618K  | 87M  |
| Default level 2 log                         | 577K  | 85M  |

By "cache hit", "cache miss", "cache miss and diffing values" I mean
printing lines like:

  cache hit at (44677): loop=3D0
  cache miss at (36030): frame=3D0, reg=3D7, spi=3D-1, loop=3D0
  cache miss at (36030): frame=3D0, reg=3D7, spi=3D-1, loop=3D0 (cur: scala=
r(id=3D3618)) vs (old: Pscalar(id=3D3258,umin=3D1))

Didn't try printing message at each new state creation.

> and whole new concept of state ids just to make a post processing
> better. I'm not convinced it's worth doing.

That might be true.
But we do need some instrument to help debugging 1M instructions situation.

