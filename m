Return-Path: <bpf+bounces-76663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D7CC09A0
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C38BE3016FA6
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A02E6CC5;
	Tue, 16 Dec 2025 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="XEn5H2dE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9A19DF62
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765852106; cv=none; b=fKvQbNlQnKe8A26ud3zooDs+R+YLM/jYMREcPai/YB6pmZKkQrnecovHKr5rMAIQvyQzrtGw+oKJCM3mFGU9u4c3yvAG5sXQKz0GVbR6cvixEyWaS6qOJ47RzNd9TU4kziNaR5jI10CA2Xf1bRIyLvg14iguE0cCxIaDmG2Mgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765852106; c=relaxed/simple;
	bh=gjBHG+AoPHYt1V00c14bprdRMfeXePkh/fD4vNTBb8E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=U/FD+TA3Q44YfQ/3f9NW1jPFIXKl5YdFnLwytLpSffb377/kYawsT6qV1CKz6cNF2mRg4bWUtaG43wxCCMLdrwokJ7UjnhZGNY5nVJ41WmvFjhYNxPv25y3k8DJ4KGnVXH/xgeoPYEZu9DJHVlOSrBfqp1OSmFyses7WSNbt9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=XEn5H2dE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4f1b1948ffaso30613021cf.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 18:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765852103; x=1766456903; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pddlQDOSkstTtJIJ31ANtsUnxMTXfVEOzTjmHipw5VU=;
        b=XEn5H2dEry2lwKyxND7RqlRBfaJyGbnKNC9E1J9QMBTl8FMVls9SfP7B+bBCmQ/mJP
         N7I4yeRcrG0qbhWugaypJbcdOElrpppjF6XYc9GYMi7xkRl6eVKqmtiIaGHCVZsWeO9Y
         6QASAgqST5jdAyUo+4o/dpvWnP3CnP0Ip6SifyVA5igSBByMxhb+VExz/M6Hagc0BAzC
         bvEFolFcuczBRTkDw6gLckBU7vNgAdMA073AkGPS6SEdKh68al5fxBQHTrPHi+ew9OO5
         EyVmN9M1PZo1o3gsuk8PpXpA6SMyPW9wQo4+/tntLjd7rfDSgapNqNfS8azNiR9zKD7b
         hSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765852103; x=1766456903;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pddlQDOSkstTtJIJ31ANtsUnxMTXfVEOzTjmHipw5VU=;
        b=kDRjVFILAJieKVB8D5fWMaYfilQJgQh9pj8UhQBU/wwQ1o1hUf0XLowpiom6yzseMH
         VdFj5VBliuOzCjAaeWxRU3soeueJcNG9TgQjTnXkX/J410gs80yClWKm+oqEuApS917C
         FVCJ29HXn0BmUabX0dpb1LIa02Fq21JvD5M1Uq0KL2Id3yn4jYeTPgQqZGHxfIopBDUH
         sw3M4KHwvNIPN1oh23JpjQZy4w1dSP8zAodsC37DocJlxgU5IgsLn+Biic9dXYVn2Enz
         H6joshhsd9f8ALHuRHo7nVSQNGE5XwdAt3h+nu8aYmYfX6uWUW+UKTM/enPL4jPiRjqx
         IIsg==
X-Forwarded-Encrypted: i=1; AJvYcCWgzHlo9CCrBisuVTUDaEqAU58EKDR6CZdFJLZk1oN3ezxvIiRFvGhscdEaK7PSG8ir0rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4O/YRmipLHoHd3ef8VOfWO7GIX2+4F5FQHwAhFoYr2l1Dl2aX
	udkHWE4VZ4qlPOod0xOK4Owi03Ic3MuBzWUVqUsg/BpLmFXq0G8Gy2mM83atqvMHdV0=
X-Gm-Gg: AY/fxX6S9zuiofE2XN25W1P9LBeOYXXqGO/ZlvH5wRqDigSf1M3bM85FRxloRXFg/qH
	4qkxbpMsXQtGHZ4DulHm3G1I7YzmrGz6TRF6nwg8vnoSFzF7l2FNwQqfAdbL+GqBfo0V/XDDL3W
	9/+hcd05F9OKBjv23d01QKNVLFRV1FIYQFBT5mOw3NWmjaTGvU1aXTGlX+w/8WpaK1M86LY1cXY
	m8H7s2hNQ3SWuMJwH8jBJmo/XskUzUwaazTRrY3Lhy14xo+r5qjxt3fdLHSUyy1YgnotjICP62B
	28ZBK18AV63w1SW8pvm7LbE7uNyUoBLz4NoRufD1+Bp1sQLIDuXXbb1sWG/rMZeRDd2cZfQFKdC
	NttjySYVhI39EcJkqpiTHdhUeojwqhgfRl/puEiog1CPrNsuo+2+ckgVATu/xqn8LAOQ7WJB+tN
	DRsBDxA1HxrRA=
X-Google-Smtp-Source: AGHT+IElEyE4Qm0F5Yr2b07xBbk3zHWDODL/RKD4ZYCHenoAilz/SXspck9hInS/Ef/Pc09vq6TFsw==
X-Received: by 2002:a05:622a:5812:b0:4ed:6303:ea79 with SMTP id d75a77b69052e-4f1d05dcfd0mr185393981cf.54.1765852102698;
        Mon, 15 Dec 2025 18:28:22 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345b16cb5sm6897981cf.5.2025.12.15.18.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 18:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 21:28:20 -0500
Message-Id: <DEZABS0M7H8J.2C3X2O5VO8S2Q@etsalapatis.com>
Subject: Re: [PATCH v3 5/5] selftests/bpf: add tests for the arena offset of
 globals
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <memxor@gmail.com>, <yonghong.song@linux.dev>
X-Mailer: aerc 0.20.1
References: <20251215161313.10120-1-emil@etsalapatis.com>
 <20251215161313.10120-6-emil@etsalapatis.com>
 <72f81bb75f843cce56f9d4ec13391fd907ca16d4.camel@gmail.com>
In-Reply-To: <72f81bb75f843cce56f9d4ec13391fd907ca16d4.camel@gmail.com>

On Mon Dec 15, 2025 at 4:26 PM EST, Eduard Zingerman wrote:
> On Mon, 2025-12-15 at 11:13 -0500, Emil Tsalapatis wrote:
>> Add tests for the new libbpf globals arena offset logic. The
>> tests cover the case of globals being as large as the arena
>> itself, and being smaller than the arena. In that case, the
>> data is placed at the end of the arena, and the beginning
>> of the arena is free.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  .../selftests/bpf/prog_tests/verifier.c       |  4 +
>>  .../bpf/progs/verifier_arena_globals1.c       | 75 +++++++++++++++++++
>>  .../bpf/progs/verifier_arena_globals2.c       | 49 ++++++++++++
>>  3 files changed, 128 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_glo=
bals1.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_glo=
bals2.c
>>=20
>> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/t=
esting/selftests/bpf/prog_tests/verifier.c
>> index 4b4b081b46cc..5829ffd70f8f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> @@ -6,6 +6,8 @@
>>  #include "verifier_and.skel.h"
>>  #include "verifier_arena.skel.h"
>>  #include "verifier_arena_large.skel.h"
>> +#include "verifier_arena_globals1.skel.h"
>> +#include "verifier_arena_globals2.skel.h"
>>  #include "verifier_array_access.skel.h"
>>  #include "verifier_async_cb_context.skel.h"
>>  #include "verifier_basic_stack.skel.h"
>> @@ -147,6 +149,8 @@ static void run_tests_aux(const char *skel_name,
>>  void test_verifier_and(void)                  { RUN(verifier_and); }
>>  void test_verifier_arena(void)                { RUN(verifier_arena); }
>>  void test_verifier_arena_large(void)          { RUN(verifier_arena_larg=
e); }
>> +void test_verifier_arena_globals1(void)       { RUN(verifier_arena_glob=
als1); }
>> +void test_verifier_arena_globals2(void)       { RUN(verifier_arena_glob=
als2); }
>>  void test_verifier_basic_stack(void)          { RUN(verifier_basic_stac=
k); }
>>  void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_w=
rite); }
>>  void test_verifier_bounds(void)               { RUN(verifier_bounds); }
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c=
 b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
>> new file mode 100644
>> index 000000000000..d998a277e5e7
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +
>> +#define BPF_NO_KFUNC_PROTOTYPES
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "bpf_experimental.h"
>> +#include "bpf_arena_common.h"
>> +#include "bpf_misc.h"
>> +
>> +#define ARENA_PAGES (1UL<< (32 - 12))
>> +#define GLOBAL_PAGES (16)
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARENA);
>> +	__uint(map_flags, BPF_F_MMAPABLE);
>> +	__uint(max_entries, ARENA_PAGES);
>> +#ifdef __TARGET_ARCH_arm64
>> +	__ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1=
));
>> +#else
>> +	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1=
));
>> +#endif
>> +} arena SEC(".maps");
>> +
>> +/*
>> + * Global data, to be placed at the end of the arena.
>> + */
>> +char __arena global_data[GLOBAL_PAGES][PAGE_SIZE];
>> +
>> +SEC("syscall")
>> +__success __retval(0)
>> +int check_reserve1(void *ctx)
>> +{
>> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>> +	__u8 __arena *guard, *globals;
>> +	int ret;
>> +
>> +	guard =3D (void __arena *)arena_base(&arena);
>> +	globals =3D (void __arena *)(arena_base(&arena) + (ARENA_PAGES - GLOBA=
L_PAGES) * PAGE_SIZE);
>> +
>> +	/* Reserve the region we've offset the globals by. */
>> +	ret =3D bpf_arena_reserve_pages(&arena, guard, ARENA_PAGES - GLOBAL_PA=
GES);
>> +	if (ret)
>> +		return 1;
>> +
>> +	/* Make sure the globals are in the expected offset. */
>> +	ret =3D bpf_arena_reserve_pages(&arena, globals, 1);
>
> In addition to checking that reserving pages succeeds,
> do we need to test pages content here?
>

For sure, I will make sure the arena globals are writable.

>> +	if (!ret)
>> +		return 2;
>> +#endif
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Relocation check by reading directly into the global data w/o using =
symbols.
>> + */
>> +SEC("syscall")
>> +__success __retval(0)
>> +int check_relocation(void *ctx)
>> +{
>> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>> +	const u8 magic =3D 0xfa;
>> +	u8 __arena *ptr;
>> +
>> +	global_data[GLOBAL_PAGES - 1][PAGE_SIZE / 2] =3D magic;
>> +	ptr =3D (u8 __arena *)((u64)(ARENA_PAGES * PAGE_SIZE - PAGE_SIZE / 2))=
;
>> +	if (*ptr !=3D magic)
>> +		return 1;
>> +
>> +#endif
>> +	return 0;
>> +}
>> +
>> +char _license[] SEC("license") =3D "GPL";
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c=
 b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
>> new file mode 100644
>> index 000000000000..5a6f6bc3b00c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +
>> +#define BPF_NO_KFUNC_PROTOTYPES
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "bpf_misc.h"
>> +#include "bpf_experimental.h"
>> +#include "bpf_arena_common.h"
>> +
>> +#define ARENA_PAGES (32)
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARENA);
>> +	__uint(map_flags, BPF_F_MMAPABLE);
>> +	__uint(max_entries, ARENA_PAGES);
>> +#ifdef __TARGET_ARCH_arm64
>> +	__ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1=
));
>> +#else
>> +	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1=
));
>> +#endif
>> +} arena SEC(".maps");
>> +
>> +/*
>> + * Fill the entire arena with global data.
>> + * The offset into the arena should be 0.
>> + */
>> +char __arena global_data[PAGE_SIZE][ARENA_PAGES];
>                             ^^^^^^^^^
>
> Nit: this is reversed compared to the declaration in the previous test:
>
>   > +/*
>   > + * Global data, to be placed at the end of the arena.
>   > + */
>   > +char __arena global_data[GLOBAL_PAGES][PAGE_SIZE];
>                                             ^^^^^^^^^
>

Ack, will fix.

>> +
>> +SEC("syscall")
>> +__success __retval(0)
>> +int check_reserve2(void *ctx)
>> +{
>> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>> +	void __arena *guard;
>> +	int ret;
>> +
>> +	guard =3D (void __arena *)arena_base(&arena);
>> +
>> +	/* Make sure the data at offset 0 case is properly handled. */
>> +	ret =3D bpf_arena_reserve_pages(&arena, guard, 1);
>> +	if (!ret)
>> +		return 1;
>> +#endif
>> +	return 0;
>> +}
>> +
>> +char _license[] SEC("license") =3D "GPL";


