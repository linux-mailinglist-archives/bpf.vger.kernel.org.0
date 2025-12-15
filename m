Return-Path: <bpf+bounces-76642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AADACBFF03
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 22:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45D83035A7A
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27FB32AAC3;
	Mon, 15 Dec 2025 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqxAgFGm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2B19C566
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833978; cv=none; b=nQG1udUt7O+LgMMd8p92+s5U8/+s7bAf+x6bwfMdD+5+7nLVvAMhP+pYBDiGQX938F/y6SnlD+zr2mJIB1kVN3paQuawGJKx+GYHv41AK6xX7oXmx863fO/8uZV4msaYSQMIpIIukWuSi8oeeXFWBV4ab89ethaVibJqjw5U0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833978; c=relaxed/simple;
	bh=Vmo4CK6lUg41vp55nyBj23DDdZU7G+LU/LnV+5huVHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XsNpSIAhYarMqJeVQN2xZtWtnqbXeCvVr3I/6DhoHyDBeypgV4TQskX8H7EA6yDClOvWPvVQ7wAUwOfxlvE0J45FySbk7W//YZtuygf8FnE0m20REmRpFJxFhhSHH28Ts+/Spq9rdD/v0ejsJQ/ctaxtzPrTu4VmIdnAk8LRnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqxAgFGm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so3123966b3a.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 13:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765833976; x=1766438776; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4hqFsMq4JwH3RIjT9kCVXntDRfnuLw0VueqZieCVY2k=;
        b=iqxAgFGmelHbODn8AAtM66na1W40TdxesP5vvi7LosGmC+5VOAPNL1xI4hv0JUr02L
         G3N7MVWFg04X7AzcL5u7HeRW+KkWKckk9kGAh171xpojc/YKvjqIOdZvKZNKjiwQhZQ0
         RiqCZdOD6dRQ1H2+6aPqpnwAUs22mUVYU/dzG1vktz+yRZjwjE5H4CAWO9KmucneD4ql
         4OtgCsbCjdtzRRirFomI9it+ll2Pu6ReLpz7iMePrlMm3WDEU6MDAaP23XvHnsrLSFuG
         R8C5bIykL+R+KqJJR2LcorZdE2rgPGBj1sm7fyyzbNNWQtwmVR8zAk2TtKzLeR6I14IL
         Qn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765833976; x=1766438776;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hqFsMq4JwH3RIjT9kCVXntDRfnuLw0VueqZieCVY2k=;
        b=CtScqe+gyALkpJsCn7/m/rXuyTFh6x5x3tlui3F15dwgL+35Qps5k+8Iy5jMqtiOHd
         jMHZREHe+Aed6uh43mrzgdFqJuyX4TMDdQq5pHGvqBTAGVb2Rh1Fx6hqao8+h9Qgzg5Y
         QoJ4nSRyulrQ33M+LfT509t6K4shYCDYfJOkgXR2YuM8eD6NV0WnvE8VXMndMsYbY4cT
         udFEau/1zQPmZao0etvJxopXyfoZK1+anGCuzjPRLbe2F4t087bI3I//s8Tm5L0HPNgr
         u3AbsKTeA5KxqYotJM37qTSZi3ZM/G1MQCvCn83SHdIX4geSNY5SMpPLrHaHWUy6iDLw
         mJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTLWO8M3ELS8DtTcIhxcvQbnlUN7fkKkePg9kaG+4mRTt4BEit+wJst+y089GY0l+08SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7MUH8O+ubG35kDzT8lnNTRgT7MZmHQI+oxxVgkfi7e93dYy2
	eou7hu/ps6hQXQjQRrEH2TWv5jUBy9leyfOg8e1zZxQCsvEBS/3BQm/q
X-Gm-Gg: AY/fxX5Wdarep60VJgk1UpsSxKbK4sDL711WDtxXzqbExtd6avWpljhn0e0G2nurI5d
	2iXDdEwCM5vSAGnitUrnI+dhr65EcGA1+mZ6Ii9n7fhbVxSvr7h5Io5sSZAFVrKFIfLbI5i2+Ij
	Plb8bZxAhT+hMEkT4lCwPaJHkr9flIAEIJ4AQfcNbTyt6g+3UFIFQBhks89NRxrjbriCLk1S3Gz
	KP/Savfjay38Yb1lVxB2Q4bJeMjJO4bSJZTA1RyzXZ9jVZ0NF06WrNgueCiTQD8ookknJJV3fmz
	6Vv+w2+vVuUDGP0jBqaP0XLjuFpudIqela3G/WFzq4U8kvj88kOVHRPwbZ6zs3yQL2NO4WPBLuY
	9ocahVo3HcE2OKgWm199mflVLa7B1nUGzwFLmpB6XmgFUP3b97KhZsIrsfiA6BdHKPZICaxqqv2
	NgBiNE9K0d
X-Google-Smtp-Source: AGHT+IG5Fyha+cDexNVMAtuLtpXSnNYRs4Kpg8gpzNMbKBkxnfZ5C/x8BDWdA+yMeWc9IvCrxgY7Vw==
X-Received: by 2002:a05:6a00:b486:b0:7e8:43f5:bd57 with SMTP id d2e1a72fcca58-7f669c8d79bmr11026988b3a.67.1765833975808;
        Mon, 15 Dec 2025 13:26:15 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c585cde0sm13395291b3a.69.2025.12.15.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:26:15 -0800 (PST)
Message-ID: <72f81bb75f843cce56f9d4ec13391fd907ca16d4.camel@gmail.com>
Subject: Re: [PATCH v3 5/5] selftests/bpf: add tests for the arena offset of
 globals
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, yonghong.song@linux.dev
Date: Mon, 15 Dec 2025 13:26:12 -0800
In-Reply-To: <20251215161313.10120-6-emil@etsalapatis.com>
References: <20251215161313.10120-1-emil@etsalapatis.com>
	 <20251215161313.10120-6-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 11:13 -0500, Emil Tsalapatis wrote:
> Add tests for the new libbpf globals arena offset logic. The
> tests cover the case of globals being as large as the arena
> itself, and being smaller than the arena. In that case, the
> data is placed at the end of the arena, and the beginning
> of the arena is free.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |  4 +
>  .../bpf/progs/verifier_arena_globals1.c       | 75 +++++++++++++++++++
>  .../bpf/progs/verifier_arena_globals2.c       | 49 ++++++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_glob=
als1.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_glob=
als2.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 4b4b081b46cc..5829ffd70f8f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -6,6 +6,8 @@
>  #include "verifier_and.skel.h"
>  #include "verifier_arena.skel.h"
>  #include "verifier_arena_large.skel.h"
> +#include "verifier_arena_globals1.skel.h"
> +#include "verifier_arena_globals2.skel.h"
>  #include "verifier_array_access.skel.h"
>  #include "verifier_async_cb_context.skel.h"
>  #include "verifier_basic_stack.skel.h"
> @@ -147,6 +149,8 @@ static void run_tests_aux(const char *skel_name,
>  void test_verifier_and(void)                  { RUN(verifier_and); }
>  void test_verifier_arena(void)                { RUN(verifier_arena); }
>  void test_verifier_arena_large(void)          { RUN(verifier_arena_large=
); }
> +void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globa=
ls1); }
> +void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globa=
ls2); }
>  void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack=
); }
>  void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_wr=
ite); }
>  void test_verifier_bounds(void)               { RUN(verifier_bounds); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c =
b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
> new file mode 100644
> index 000000000000..d998a277e5e7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#define BPF_NO_KFUNC_PROTOTYPES
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_experimental.h"
> +#include "bpf_arena_common.h"
> +#include "bpf_misc.h"
> +
> +#define ARENA_PAGES (1UL<< (32 - 12))
> +#define GLOBAL_PAGES (16)
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, ARENA_PAGES);
> +#ifdef __TARGET_ARCH_arm64
> +	__ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1)=
);
> +#else
> +	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1)=
);
> +#endif
> +} arena SEC(".maps");
> +
> +/*
> + * Global data, to be placed at the end of the arena.
> + */
> +char __arena global_data[GLOBAL_PAGES][PAGE_SIZE];
> +
> +SEC("syscall")
> +__success __retval(0)
> +int check_reserve1(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	__u8 __arena *guard, *globals;
> +	int ret;
> +
> +	guard =3D (void __arena *)arena_base(&arena);
> +	globals =3D (void __arena *)(arena_base(&arena) + (ARENA_PAGES - GLOBAL=
_PAGES) * PAGE_SIZE);
> +
> +	/* Reserve the region we've offset the globals by. */
> +	ret =3D bpf_arena_reserve_pages(&arena, guard, ARENA_PAGES - GLOBAL_PAG=
ES);
> +	if (ret)
> +		return 1;
> +
> +	/* Make sure the globals are in the expected offset. */
> +	ret =3D bpf_arena_reserve_pages(&arena, globals, 1);

In addition to checking that reserving pages succeeds,
do we need to test pages content here?

> +	if (!ret)
> +		return 2;
> +#endif
> +	return 0;
> +}
> +
> +/*
> + * Relocation check by reading directly into the global data w/o using s=
ymbols.
> + */
> +SEC("syscall")
> +__success __retval(0)
> +int check_relocation(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	const u8 magic =3D 0xfa;
> +	u8 __arena *ptr;
> +
> +	global_data[GLOBAL_PAGES - 1][PAGE_SIZE / 2] =3D magic;
> +	ptr =3D (u8 __arena *)((u64)(ARENA_PAGES * PAGE_SIZE - PAGE_SIZE / 2));
> +	if (*ptr !=3D magic)
> +		return 1;
> +
> +#endif
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c =
b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
> new file mode 100644
> index 000000000000..5a6f6bc3b00c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#define BPF_NO_KFUNC_PROTOTYPES
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +#include "bpf_arena_common.h"
> +
> +#define ARENA_PAGES (32)
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, ARENA_PAGES);
> +#ifdef __TARGET_ARCH_arm64
> +	__ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1)=
);
> +#else
> +	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1)=
);
> +#endif
> +} arena SEC(".maps");
> +
> +/*
> + * Fill the entire arena with global data.
> + * The offset into the arena should be 0.
> + */
> +char __arena global_data[PAGE_SIZE][ARENA_PAGES];
                            ^^^^^^^^^

Nit: this is reversed compared to the declaration in the previous test:

  > +/*
  > + * Global data, to be placed at the end of the arena.
  > + */
  > +char __arena global_data[GLOBAL_PAGES][PAGE_SIZE];
                                            ^^^^^^^^^

> +
> +SEC("syscall")
> +__success __retval(0)
> +int check_reserve2(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +	void __arena *guard;
> +	int ret;
> +
> +	guard =3D (void __arena *)arena_base(&arena);
> +
> +	/* Make sure the data at offset 0 case is properly handled. */
> +	ret =3D bpf_arena_reserve_pages(&arena, guard, 1);
> +	if (!ret)
> +		return 1;
> +#endif
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

