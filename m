Return-Path: <bpf+bounces-71362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C0BEFE3B
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E2F189D6E5
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE452EA474;
	Mon, 20 Oct 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVZ9iUnl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F02EA72C
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948393; cv=none; b=eYIsYqgV0mtcDwO7iYynIP8nKsrbgK2j3NzmCCjFAddNJJLewgyxsz9tjs6JQuhHvHw7Qv3HpBeUzPD2Xyyusw9eXfo8CVkj8GQIWYlKo4S7drddstB6g/Ekw7bGOVfleFQX52/hUbW26B+3J1AbAESAsaWZNDVHLKaIfa0q/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948393; c=relaxed/simple;
	bh=S9UDMbWilPhdpfJwIjrQRamIzFyU9QD+ikxKlb0Oz8k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej/6rmNO4oU3kL/aJylqTxd8jWES0RvXtdTpY2Pyx74Hptup9MIrpqlU/Gkk/+stYU49rqX9fX/mkFF2O7V8S2QKjziVJZg/Z8a7z4YNB97waIt4f8rrHegbBsldAj1v3/M99tTKoBczKoQh+H7QanP84KYOkEPtAuSEmrUaOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVZ9iUnl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so21654115e9.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948390; x=1761553190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oVCb1IezkGjRWpLaVOS0OWSE2fmBa+Fn1PR1cAjcc/Q=;
        b=bVZ9iUnldHZyholn32ZBdwQ5q63nZfV4CZBTcmun6SnylwJAoVevsOPEbON3m8A9ZN
         4NK4QDvWabkDtnIHXZpg6XPSMW2HHq3+7BJ8T8JzCLawP1VEYT6F8vFIS35r5cI+7yp1
         cM1u/ZbP8KjIDW2c8ciNMy3ZBpqGfnYYVhvsGO7nDvEeXPO3orPKZDBCocgXU+yGuwRf
         2h+X2m8aTnZofw+Zww5k3azv5NCd/kEsvZMATVMg0TNRGHhBLrFBWbcMEcGuTHLUkhT4
         BSK28K5VKPhov24DP4boUdw4HgMLj6SFEv5LokavJbbdHQAPwAaXwXFuGDGtZwgRSqX5
         6f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948390; x=1761553190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVCb1IezkGjRWpLaVOS0OWSE2fmBa+Fn1PR1cAjcc/Q=;
        b=rPY1J6/kp2hv+QmFGf0DLTaV4jSq3JYe83zJw0SaJUgxacVWBtddbiww53Li6sDvt+
         djG4TsAyJnwW+L/hh0Se19Pe2uB23q+EKgI6PNuTSVYGeekYhfHGnbrAmmBjbyhUHe5c
         2wjKbc5lZXtNDN3jO/5vnE82ZWkCuXidRqZQ5pD93N+wKfJB9Sw0oPvMOeSit3af7APl
         W/9A4TAIcQ1lMcwr0g1fukLhx/63rCwygzPb3MRgJq8wWBdH0q+jGl2q6z1cO/NqKojY
         eIPFehpMAimMW+YTQtCTwr1KPYBpIHy+LhwrwPVS9z8PPRKUKZmOhfdcvv/NVMrj8qB9
         S7xA==
X-Forwarded-Encrypted: i=1; AJvYcCX2LpagsLGFm/wNuvOQt2jTzLyU76R/2xOgjGEeRAaIxwo44UwOBuDwuJtN9JnW6t2EDo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmukNJ/JTx9/7W0kFvbzqfRrcd7DYHz/KcaT0fc/Mt87jrg6j
	kM3A9eWkTGfMWI73Zs23Vb7Ez23kM8k1h7srWwsw3TSnhw8Wws7z8hi6
X-Gm-Gg: ASbGncugTm5+irvJ6D4mYzA68fcSOoCr9OmxQVRXOtvSMFiGo+bsmHqIqU8GCvHik1t
	aGyA0DdMvvd0JWvQN/PwMzbReyWCOy+DrqOzhae1C6ys6pa1W37wk/3LcdB+o410Tcg9iUro0M+
	PTA59UqMPkhKFOWrN3Dk+Q0tH0Fp2pRHc+oVVNtQGmog2ytCw3Sh2MFc+oZMajqNm1WzuWDuZIq
	NraRPFeoTmoySSZ80cqlCUhHiVnGj6cGqDbhG5EGeMK4zQbWvIuHiympjEMulUr0vOxyr56sj3U
	IqjPRRUKv2TysAVhYvVJIMXlDlpKERN2QiHovSdpIcYnM0aQXpvclOKe+sWcgN5ZAYlZwtkBemN
	TB6IhW1+wsNKvC6XxtFnvGquhSZ673A8adWLOTHW4wfgWmMiH1xAbmqhATWTX
X-Google-Smtp-Source: AGHT+IEXZFrAVjWLOtNUPtFNYd/eiqI5y9E0oS07a02DP0cVokTgitLvFo7ntPqbG7MXVqYU7Eyhaw==
X-Received: by 2002:a05:600c:870b:b0:471:9da:5252 with SMTP id 5b1f17b1804b1-47117919c1cmr93063265e9.29.1760948389780;
        Mon, 20 Oct 2025 01:19:49 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c91sm216979455e9.11.2025.10.20.01.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:19:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Oct 2025 10:19:47 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 5/5] selftests/bpf: add testcases for
 tracing session
Message-ID: <aPXwo0puQI3t0CXC@krava>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-6-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018142124.783206-6-dongml2@chinatelecom.cn>

On Sat, Oct 18, 2025 at 10:21:24PM +0800, Menglong Dong wrote:

SNIP

> +static void test_fsession_reattach(void)
> +{
> +	struct fsession_test *skel = NULL;
> +	int err, prog_fd;
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +
> +	skel = fsession_test__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
> +		goto cleanup;
> +
> +	/* First attach */
> +	err = fsession_test__attach(skel);
> +	if (!ASSERT_OK(err, "fsession_first_attach"))
> +		goto cleanup;
> +
> +	/* Trigger test function calls */
> +	prog_fd = bpf_program__fd(skel->progs.test1);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	if (!ASSERT_OK(err, "test_run_opts err"))
> +		return;

goto cleanup

> +	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> +		return;

goto cleanup

> +
> +	/* Verify first call */
> +	ASSERT_EQ(skel->bss->test1_entry_called, 1, "test1_entry_first");
> +	ASSERT_EQ(skel->bss->test1_exit_called, 1, "test1_exit_first");
> +
> +	/* Detach */
> +	fsession_test__detach(skel);
> +
> +	/* Reset counters */
> +	memset(skel->bss, 0, sizeof(*skel->bss));
> +
> +	/* Second attach */
> +	err = fsession_test__attach(skel);
> +	if (!ASSERT_OK(err, "fsession_second_attach"))
> +		goto cleanup;
> +
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +	if (!ASSERT_OK(err, "test_run_opts err"))
> +		return;

goto cleanup

> +	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> +		return;

goto cleanup

> +
> +	/* Verify second call */
> +	ASSERT_EQ(skel->bss->test1_entry_called, 1, "test1_entry_second");
> +	ASSERT_EQ(skel->bss->test1_exit_called, 1, "test1_exit_second");
> +
> +cleanup:
> +	fsession_test__destroy(skel);
> +}
> +
> +void test_fsession_test(void)
> +{
> +#if !defined(__x86_64__)
> +	test__skip();
> +	return;
> +#endif
> +	if (test__start_subtest("fsession_basic"))
> +		test_fsession_basic();
> +	if (test__start_subtest("fsession_reattach"))
> +		test_fsession_reattach();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
> new file mode 100644
> index 000000000000..cce2b32f7c2c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 ChinaTelecom */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u64 test1_entry_result = 0;
> +__u64 test1_exit_result = 0;
> +__u64 test1_entry_called = 0;
> +__u64 test1_exit_called = 0;
> +
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test1, int a)
> +{

I guess we can access return argument directly but it makes sense only
for exit session program, or we could use bpf_get_func_ret

jirka


> +	bool is_exit = bpf_tracing_is_exit(ctx);
> +
> +	if (!is_exit) {
> +		/* This is entry */
> +		test1_entry_called = 1;
> +		test1_entry_result = a == 1;
> +		return 0; /* Return 0 to allow exit to be called */
> +	}
> +
> +	/* This is exit */
> +	test1_exit_called = 1;
> +	test1_exit_result = a == 1;
> +	return 0;
> +}
> +
> +__u64 test2_entry_result = 0;
> +__u64 test2_exit_result = 0;
> +__u64 test2_entry_called = 0;
> +__u64 test2_exit_called = 0;
> +

SNIP

