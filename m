Return-Path: <bpf+bounces-65564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE79DB255FE
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4345A4B4C
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4952E54D8;
	Wed, 13 Aug 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4c3GhO+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84321638A;
	Wed, 13 Aug 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122047; cv=none; b=KEo7itvNe7go6AN/K/seSj4eefLG40rEVmKoiTt/APF628T9d/1ZNEL+uYXZLoSkNenHeg7+gtA5cHpKQ3MY+e9khHcMHYahWlQ78RgXGe8yjalAEo1i/1BupIPZT2wX3t2BL1TREL7Vj1wWy4CN46oVpdjPqDQBpkGJtqfDWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122047; c=relaxed/simple;
	bh=So1m5XNHLPh0KJT8Nvu8Kob8CvgE2+aOTblmJpvwVVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSEqOyW10wkqQ2ldp7wQ0fDAEzRSVgqAu+khwqati0F2JceguaGfFjzZyxv/65cM+tG9xFfX5MuTsxxB3zZwQy+J0B8vtOXZwNtWuz9TE2maNAnUGt5twZ39HhkuQvsEGEkYjo4klJOCOkoR4Sj29/uKRg4O4DYkH7WEnOzRSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4c3GhO+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so278373b3a.2;
        Wed, 13 Aug 2025 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755122045; x=1755726845; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9C72+kbIBMg6hiXrX828guCpvIhcyhY0LqzSmQ9Jldg=;
        b=l4c3GhO+jaaxzwyaKKzC++F85jJtmM5xjC8ezEEOSd5W8EcXEGvO9RZsRWJ0DQIxCo
         SJ3bndaUainSU67DhAgdcbMPG70Rkoi7F5OuHYnnsjiI0WTUrxCyQwbOdB16BouE60NL
         Zx+o+Ngdch2RA6v9PeKCaqfqsyWScT8LgJbCcbSoF4A8ptGcqQ0lZGUqFQQSQ5LCDQpz
         zC17MmXBnCTpSQNbYi9EkVti/eNfhbpPM8N2Qz4hhLXx7BrBE3tKs0lHBQZV1u1bvnns
         //bus1MglsOd54iEfdu0x4KBPWKUduYNec/3v41UTFdgHdPx3PV2CKJo1yXaXDF2laQ5
         T1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122045; x=1755726845;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9C72+kbIBMg6hiXrX828guCpvIhcyhY0LqzSmQ9Jldg=;
        b=U4awyOHzNj76CP6C2jhXST6ilHxNd4abR6okS8hXLSz/i7NOyGJJSz96oJlTvHvi0Z
         GuAKX/2Bz7ePLNoWn+rYiD+2ltbyn8MNHG9svK5KZ8oQXocif/ocNW5Ofa+xZuUguqk9
         V0OHUWrfJ4dAcRd/fh/xm/wH+c5Y7Re7usfv2ncgQP2W3E1zR3xm8GmuTSyKb0wp1laM
         tqATacqxpTVUKSVqzg1zeKrmL6aGpj6DP7ZR9FNBu3aMlRfdlVhqiOr8+ESmlh4HQMH+
         Kiijn83eX3ijlyTipzpn+wKbaAHqHC5dK7s20ASMv3fxE6/mBCUHNK90GBB2qPYBx+eB
         mDPg==
X-Forwarded-Encrypted: i=1; AJvYcCWeAwpp8o/nw93AEnHOdhc7zE8hqKVi5xCB3yevPkcvXRUE4ljQgYmo/IkwFDYxI1S4MS82PZxtvxrCpRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMEXwWYk+GcqizzKVloSgNZHGZc8TYuH/1EQQ0J8fNoU27GQ2
	IJ15X0Pd9F6Pps+71kop9K/8TSI8khU4n0wW5PEgH1S7tqYtIdXHBJqNyO+JQDLq
X-Gm-Gg: ASbGnctfCGPVsg6jD4Wc4qTg1Tt/BYn2VMs9cRtHL5dz0+rDrPJ6BIpRSfuvRYdsmHv
	H9pLPgG7EX0gFdR5YJoI7a0QJIaKTS5l3gGdr3o28YoGtHhzQEES2y80d3CeWJd9jqeDVQEZBk3
	5+PIxNElZdhfb2XyRaYXEHuXDLPYY974LbhJSgeU+7YOAcavwqGmBT8RONDWk+MCMrOHls6s4ky
	uv+KFy+VnZRVL+aB+alxlf0NzBuHeR+QaAvr3GRpNmlj3ua1YpbXU7W8bjCH5VjtBFZ6m7nJ0uL
	X5BMgxjWObVAmwtXg4Rk88bDTkj8t2VxSn5uo4nwPzQWO/42TFrXaCHUsGXQxLlSWmt7K4np3Nq
	gp8SJAoiAx9OhK47FkBeuJcxBSzbU
X-Google-Smtp-Source: AGHT+IEWfcOdLVa8DHMou2guKHyeT/pXLIvDPhLGtPz2FAUTAGaSHw3F6jdOt2BZ/hU7VJZwkF8jyQ==
X-Received: by 2002:a05:6a20:72a3:b0:240:1204:dd2 with SMTP id adf61e73a8af0-240bd1f7448mr661973637.26.1755122044837;
        Wed, 13 Aug 2025 14:54:04 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::e47? ([2620:10d:c090:600::1:f146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b42963250d2sm13647635a12.7.2025.08.13.14.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:54:04 -0700 (PDT)
Message-ID: <cb4a9baeaa71e6512366267006907bf6608cca72.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] bpf: add test for DEVMAP reuse
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yureka Lilian <yuka@yuka.dev>, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 Aug 2025 14:54:01 -0700
In-Reply-To: <20250813200912.3523279-3-yuka@yuka.dev>
References: <20250813200912.3523279-1-yuka@yuka.dev>
	 <20250813200912.3523279-3-yuka@yuka.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 22:09 +0200, Yureka Lilian wrote:
> The test covers basic re-use of a pinned DEVMAP map,
> with both matching and mismatching parameters.
>=20
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> ---

Thank you for adding the test case, please find a few comments below.

>  .../bpf/prog_tests/pinning_devmap_reuse.c     | 68 +++++++++++++++++++
>  .../selftests/bpf/progs/test_pinning_devmap.c | 20 ++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_devmap=
_reuse.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_devmap=
.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.=
c b/tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
> new file mode 100644
> index 000000000..06befb03b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <test_progs.h>
> +
> +void test_pinning_devmap_reuse(void)
> +{
> +	const char *pinpath1 =3D "/sys/fs/bpf/pinmap1";
> +	const char *pinpath2 =3D "/sys/fs/bpf/pinmap2";
> +	const char *file =3D "./test_pinning_devmap.bpf.o";
> +	struct bpf_object *obj1 =3D NULL, *obj2 =3D NULL;
> +	int err;
> +	__u32 duration =3D 0;
> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +
> +	/* load the object a first time */
> +	obj1 =3D bpf_object__open_file(file, NULL);

The test can be simplified by including test_pinning_devmap.skel.h and
calling test_pinning_devmap__open_and_load(), thus avoiding separate
calls to open_file and load.

> +	err =3D libbpf_get_error(obj1);
> +	if (CHECK(err, "first open", "err %d\n", err)) {
> +		obj1 =3D NULL;
> +		goto out;
> +	}
> +	err =3D bpf_object__load(obj1);
> +	if (CHECK(err, "first load", "err %d\n", err))

Please don't use CHECK in new tests.

> +		goto out;
> +
> +	/* load the object a second time, re-using the pinned map */
> +	obj2 =3D bpf_object__open_file(file, NULL);
> +	if (CHECK(err, "second open", "err %d\n", err)) {
> +		obj2 =3D NULL;
> +		goto out;
> +	}
> +	err =3D bpf_object__load(obj2);
> +	if (CHECK(err, "second load", "err %d\n", err))
> +		goto out;
> +
> +	/* we can close the reference safely without
> +	 * the map's refcount falling to 0
> +	 */
> +	bpf_object__close(obj1);
> +	obj1 =3D NULL;
> +
> +	/* now, swap the pins */
> +	err =3D renameat2(0, pinpath1, 0, pinpath2, RENAME_EXCHANGE);
> +	if (CHECK(err, "swap pins", "err %d\n", err))
> +		goto out;
> +
> +	/* load the object again, this time the re-use should fail */
> +	obj1 =3D bpf_object__open_file(file, NULL);
> +	err =3D libbpf_get_error(obj1);
> +	if (CHECK(err, "third open", "err %d\n", err)) {
> +		obj1 =3D NULL;
> +		goto out;
> +	}
> +	err =3D bpf_object__load(obj1);
> +	if (CHECK(err !=3D -EINVAL, "param mismatch load", "err %d\n", err))
> +		goto out;
> +
> +out:
> +	unlink(pinpath1);
> +	unlink(pinpath2);
> +	if (obj1)
> +		bpf_object__close(obj1);

Nit: bpf_object__close() can handle NULLs.

> +	if (obj2)
> +		bpf_object__close(obj2);
> +}

[...]

