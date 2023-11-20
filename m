Return-Path: <bpf+bounces-15406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AED37F1E6A
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009231F2629E
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F6237174;
	Mon, 20 Nov 2023 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka6RxnIi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EACD
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 12:57:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f7abbb8b4so3213531f8f.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 12:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700513837; x=1701118637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOQMbxlbRheQmWRiHPYmfN9nU0/AiYmWe4ZxHIvLFEY=;
        b=Ka6RxnIizfKG5kMGxf8CNYyiuBiyAWLsh94ifrhxTO66zTMzYkgBKVxcpSWHDnEx5d
         QJUqcJfoKB6n0RCKIqr8dhGfznKdSaWODsvtWTmmJr5+2SJH4B8r0SjhfCl9Ht0CkqRw
         FRlzzS1cGeFjEDqUzemonYgRz+rsL0tu2NwvjhThTr0ggcgVzZ2qa7napGRs5TDAdS1c
         gJ+qnC1QQUvTQ+p1mbInJWTcpSVINksrau7R6A3vxR9W0C8OIe1MXZkO8p3HdW12K6Oq
         iYxmDbrpWdP4+3fi+USR4XXocxLfGtbj5JbcgBrnSjOYWQyD6zV1Y3yYNORRQ8BHXNWO
         +YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700513837; x=1701118637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOQMbxlbRheQmWRiHPYmfN9nU0/AiYmWe4ZxHIvLFEY=;
        b=prA+jDqhPhrZDS0+zM6OJS3ZzSjQdVMBSuYWI42ZZhs8YOh2rhZpQPBZeXDtPKZ7Du
         24lq+fM1YpyG4jcfteCVzX20BzzxJkRcD0u7O2KJtQkrUANisI8r7IXWLQsqQc6QpzHR
         A62dj4TiBcUVP6ZD+wjtONQ01X22J2v97FhhzUootivzHEWiej55x8RKNDDu3gzSjX17
         c7maLRwj8uMH+s6q4JBXzKUWvKm+8qleEBHOZ7Yn/mxEJdNIp4lv7bhOlralBMm+melV
         XcB3GSxAFLgR8ZzMZ3EIXdInMzlNLMmkrBWvJJKJIoi1yxKNRKFyIzcpNEt2HoJWsf4j
         P6QQ==
X-Gm-Message-State: AOJu0Yx/1nL8mEk9p4MIV8A+Up1pqC+MIHTO80+L+Mf51xGI5q6ns1/P
	GGhT8DRFI46KLN5ENEphTdALFVlGi6ONDAaQ/ow=
X-Google-Smtp-Source: AGHT+IGOd3XDN3NPJCzTVotZ+H+U+d6ICtY0/4yGvWcPpSWxY8HvJF6yBa03/jgawGEMn93P83VfaxpxKrhxVAVIXvg=
X-Received: by 2002:a5d:5849:0:b0:332:cb12:16d2 with SMTP id
 i9-20020a5d5849000000b00332cb1216d2mr1230141wrf.67.1700513836978; Mon, 20 Nov
 2023 12:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120180452.145849-1-andrii@kernel.org>
In-Reply-To: <20231120180452.145849-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Nov 2023 12:57:05 -0800
Message-ID: <CAADnVQKYAD98i-An+KZoTxxxCAJyypMythA+Q-NnGVNfOkq_Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: reduce verboseness of reg_bounds
 selftest logs
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 10:05=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Reduce verboseness of test_progs' output in reg_bounds set of tests with
> two changes.
>
> First, instead of each different operator (<, <=3D, >, ...) being it's ow=
n
> subtest, combine all different ops for the same (x, y, init_t, cond_t)
> values into single subtest. Instead of getting 6 subtests, we get one
> generic one, e.g.:
>
>   #192/53  reg_bounds_crafted/(s64)[0xffffffffffffffff; 0] (s64)<op> 0xff=
ffffff00000000:OK
>
> Second, for random generated test cases, treat all of them as a single
> test to eliminate very verbose output with random values in them. So now
> we'll just get one line per each combination of (init_t, cond_t),
> instead of 6 x 25 =3D 150 subtests before this change:
>
>   #225     reg_bounds_rand_consts_s32_s32:OK
>
> Given we reduce verboseness so much, it makes sense to do a bit more
> random testing, so we also bump default number of random tests to 100,
> up from 25. This doesn't increase runtime significantly, especially in
> parallelized mode.
>
> With all the above changes we still make sure that we have all the
> information necessary for reproducing test case if it happens to fail.
> That includes reporting random seed and specific operator that is
> failing. Those will only be printed to console if related test/subtest
> fails, so it doesn't have any added verboseness implications.

Thanks for the quick fix. Applied.

I also noticed:
#200     reg_bounds_gen_consts_s64_u64:SKIP
#201     reg_bounds_gen_consts_u32_s32:SKIP
#202     reg_bounds_gen_consts_u32_s64:SKIP
#203     reg_bounds_gen_consts_u32_u32:SKIP
#204     reg_bounds_gen_consts_u32_u64:SKIP

what is the reason for SKIP ?

