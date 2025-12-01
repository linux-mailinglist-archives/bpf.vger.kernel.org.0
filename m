Return-Path: <bpf+bounces-75829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DCCC98D2F
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 20:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527F23A5200
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8596246BB9;
	Mon,  1 Dec 2025 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+yNRVJj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25C245019
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616624; cv=none; b=stPAPk/I+2LYJ2fmHh6+nWG6XG3KQ43EfpH2GiPQQBBKpKJQrWPzCR5uUWokwT77QEpCFvjY3DxM039auA0VuIVOhnvQABenqC0goE4tBQTXRkXm8fKF89HyT5zdE2NpRnTEtiZCIF6OyBrKTpbfNnI1qWc57b0N3MzjQ9d2TBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616624; c=relaxed/simple;
	bh=lNk43apg7AFNGLzXw14VhSY2OU5GiJ0VzJmGRc3lljY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSeYP19AXTxx/HZJaW28p/asKXIrGF0kc0q5A4ZoeUUBLngt/07UVnctgLFyBLhJL/MwM6UL04zjvflm1tRcvyiFM4BwXBkKRAQLCzoGC3DzmzL1qDD3DHP8UqC/ni6P9fIIFKXXEPQ5m6VxsKShIcGE3iEanmaeSYGUeWbTky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+yNRVJj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b735e278fa1so177630266b.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764616621; x=1765221421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nL1ek/sF4svl8idObYnvvFBp1pJ9SdL29UX5xP7uR4w=;
        b=y+yNRVJjeIUf/+IEpUMHT3s0GQdTzqJStrkfqe7fzmLPLz0dS3L+DMKELoZVnRIppW
         CZQtYeAyOPWFagurv6+RlOR+SBaU4LIxpTSXP05qUJVE3efKsIquPIeDCqTQlH0bsE6C
         69tLO3685eYKJ1qkUJ71MF6o5qvPckX9bCYA+lNsOIl/Il0ezzXJdyCyRAjO0IhG8o+v
         cKtgRIroEOFCrx4JvMVBej8FrHB3Fu46sayjA8GMFCkhZQcQI8rh/kFuZH5mS4du9GBN
         JBtcZyzSWOcx6D5Mp8wkPFj2Ic6Hua4OurYJk87Lr9Ovpt9iX3lu+RwZS3BZNjUp9/VW
         4gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764616621; x=1765221421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL1ek/sF4svl8idObYnvvFBp1pJ9SdL29UX5xP7uR4w=;
        b=frs0kHW7i4OStX7b87PgfxkSJBrHKW0HTHVgvAa1ywWoHMA41B5uYVHTzWAcYTddxV
         yxm8+kdSvM9jv96+GebxT7Puu9ht0jTE121BJtBTblKC7vI+k2g4mGIfn1/XmWOyrcMD
         f6+IFwHbIOcWxDa6K7fni1faLzkYqtGCogqk7MhY9hgmofeAPtZ9qO/o5L/G9MQ78Ayx
         hlAZHJevfzD9FmKb4MKPSq9YGbD/qUiRJ8HvfGF4oB+xo1yENo9yP9hTBd5N6m6uXeIh
         8euw2yED3pt8h1W5bIAHWqcpMmtV5Nd9gFK7PCflwRBeaKFvvlYU91sW8aujqG2LIqY2
         JYog==
X-Forwarded-Encrypted: i=1; AJvYcCUFCzBanXg7E0hb2BOoCbIyDhao7nzLRCfIL02euY0mcPBRzWSy1WPNz3GmaPB9DJzHkK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVxjc2pwwxDleriv4nDO/CmEoL8+/p/oVi0fyBXyryJkkD47j
	1/IuWkMhN69TW84r41TP7COLFjBcq/ZJhG0jwVfu4Xhx31oIqob68ESrFqN5XXVSJQ==
X-Gm-Gg: ASbGncsudUq8CpPUdlHH8Zvl15PNIFuclQZZq++xwxqksxPR/UTDNgXyqdRTRx3EGYa
	NnVtHabbmC+OMWrGuBAJlT4F/BsRnvSUOh3qaio2D28q9mkiyEf3VnHHtYLr1UO2Kvl3HWHB0ix
	009wlLgfDUk+XzJ2Ji73UcNoDfCez8SEzdMAMgHlS2ubtZivVwRsYHdiNSe0QLhwqBio7kUBbY5
	ymM+4XIL0DBWwGX+ofWJhu71jVB/4rskU/MCSDkmrM8BaFWQfJKh6R6np4/JsB+A6FIGx6wI5pl
	2mG53Be4nDpu7sSWGmljeT1nflwlpxCvWf6nK3iH82HIuLJmSKW+NItxnZwB0usijsp0swnjK3x
	8Z0xeU4PqqZooKORV/cP0i66GYdrtlxnenoiVXTha3zoH5XNZvkcK87poGoNAfQtiJfAGkABzHl
	RHN2gbLffKif5TmuOLSqSB44+N/p5xkrvtD2ZvORzyovEvvXM8ocLUsU+16zY=
X-Google-Smtp-Source: AGHT+IHEnW+KAQVBRRWo/sP1tuQq4+YuSexSYvAgD3ZQW+Uk1hhu0eSXu61P0LbdLU0EfCdTk/o99w==
X-Received: by 2002:a17:906:7311:b0:b72:af1f:af7d with SMTP id a640c23a62f3a-b76c55f402cmr3192681366b.29.1764616620584;
        Mon, 01 Dec 2025 11:17:00 -0800 (PST)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f516a6c1sm1285135766b.13.2025.12.01.11.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 11:17:00 -0800 (PST)
Date: Mon, 1 Dec 2025 19:16:56 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Shuran Liu <electronlsr@gmail.com>
Cc: song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Zesen Liu <ftyg@live.com>, Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: add regression test for
 bpf_d_path()
Message-ID: <aS3pqFCze_gmYq0y@google.com>
References: <20251201143813.5212-1-electronlsr@gmail.com>
 <20251201143813.5212-3-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201143813.5212-3-electronlsr@gmail.com>

On Mon, Dec 01, 2025 at 10:38:13PM +0800, Shuran Liu wrote:
> Add a simple LSM BPF program and a corresponding test_progs test case
> to exercise bpf_d_path() and ensure that prefix comparisons on the
> returned path keep working.
> 
n> The LSM program hooks bprm_check_security, calls bpf_d_path() on the
> binary being executed, and compares the returned path against the
> "/tmp/" prefix. The result is recorded in an array map.
> 
> The user space test runs /tmp/bpf_d_path_test (copied from /bin/true)
> and checks that the BPF program records a successful prefix match.
> 
> Without the preceding fix to bpf_d_path()'s helper prototype, the
> test can fail due to the verifier incorrectly assuming that the
> buffer contents are unchanged across the helper call and misoptimizing
> the program. With the fix applied, the test passes.
> 
> Co-developed-by: Zesen Liu <ftyg@live.com>
> Signed-off-by: Zesen Liu <ftyg@live.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/d_path_lsm.c     | 27 ++++++++++++
>  .../selftests/bpf/progs/d_path_lsm.bpf.c      | 43 +++++++++++++++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
>  create mode 100644 tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path_lsm.c b/tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
> new file mode 100644
> index 000000000000..92aad744ed12
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path_lsm.c

I don't see why adding yet another new bpf_d_path() related test to
prog_tests is warranted here. Why not simply incorporate this
additional test case into the preexisting bpf_d_path() related
prog_tests source file i.e. tools/testing/selftests/bpf/d_path.c?

> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <test_progs.h>
> +#include "d_path_lsm.skel.h"
> +
> +void test_d_path_lsm(void)
> +{
> +	struct d_path_lsm *skel = NULL;
> +	int err, map_fd, key = 0, val = 0;
> +
> +	skel = d_path_lsm__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	err = d_path_lsm__attach(skel);
> +	if (!ASSERT_OK(err, "attach"))
> +		goto out;
> +
> +	system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
> +	system("/tmp/bpf_d_path_test >/dev/null 2>&1");
> +
> +	map_fd = bpf_map__fd(skel->maps.result);
> +	err = bpf_map_lookup_elem(map_fd, &key, &val);
> +	ASSERT_OK(err, "lookup_result");
> +	ASSERT_EQ(val, 1, "prefix_match");
> +out:
> +	d_path_lsm__destroy(skel);
> +}
>
> diff --git a/tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c b/tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c
> new file mode 100644
> index 000000000000..36f9ff37e817
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char LICENSE[] SEC("license") = "GPL";
> +
> +#define FILENAME_MAX_SIZE 256
> +#define TARGET_DIR "/tmp/"
> +#define TARGET_DIR_LEN 5
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, int);
> +	__type(value, int);
> +} result SEC(".maps");
> +
> +SEC("lsm/bprm_check_security")
> +int BPF_PROG(d_path_lsm_prog, struct linux_binprm *bprm)
> +{
> +	char path[FILENAME_MAX_SIZE] = {};
> +	long len;
> +	int key = 0;
> +	int val = 0;
> +
> +	len = bpf_d_path(&bprm->file->f_path, path, sizeof(path));
> +	if (len < 0)
> +		return 0;
> +
> +#pragma unroll
> +	for (int i = 0; i < TARGET_DIR_LEN; i++) {
> +		if ((u8)path[i] != (u8)TARGET_DIR[i]) {
> +			val = -1; /* mismatch */
> +			bpf_map_update_elem(&result, &key, &val, BPF_ANY);
> +			return 0;
> +		}
> +	}
> +
> +	val = 1; /* prefix match */
> +	bpf_map_update_elem(&result, &key, &val, BPF_ANY);
> +	return 0;

Will this not flake, like, maybe a lot? Mismatches are being reported
for every non-matched prefix. Meaning, other threads that are racing
alongside your system(3) invocations and going through
security_bprm_check() could very well reset your BPF_MAP_TYPE_ARRAY
element value back to -1 before your userspace code even has a chance
to assert it? Perhaps you can make this test a little more
deterministic by filtering by the expected PID?

