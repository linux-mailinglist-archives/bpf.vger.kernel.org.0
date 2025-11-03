Return-Path: <bpf+bounces-73394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4834BC2E788
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 00:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C79EC4EF687
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDB226158B;
	Mon,  3 Nov 2025 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQtbANao"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C317F2FF64B;
	Mon,  3 Nov 2025 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213656; cv=none; b=Oera7EOfWZ/YV79H0enVmpSKsi0eo2xsukbta77XD92R25tiMHNrfyd1SIoFZ0iuSRCsoL7Wwl+uyz3aUmPwEFvOD57zXOC8kTU/49dCNlSMLJkPvIl0U/0+CVhcXt1pgRmNFMU+9ZFMUlfbRiqMmY6IAiCgOxr88u5mHe2+e08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213656; c=relaxed/simple;
	bh=VdvddqtpogZKg9XBNza6P5sdkLqSdZog9S1/vtqRRvI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NFGwRgADKjRM9rzAuoZ1JFtQaUE8tPToPbK4mHt+B9nlso+e3sUxI4JS4+a28Xb6Y4aB94LcXE9Q/laRPfb2tQDMKL6XSFnMl4Sj8L8Yri/qHgaHppy7MDPA54/+etUI6nymvdkFteeVVwVlDf6P8/SkBs8dfL+VKtnF8jW6lKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQtbANao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D892C4CEE7;
	Mon,  3 Nov 2025 23:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762213656;
	bh=VdvddqtpogZKg9XBNza6P5sdkLqSdZog9S1/vtqRRvI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VQtbANaomt8qEDtbDEBQwtTGNSO9llKxmBYGbN2TXYv90YQCzJ2myVDIkNyylx230
	 9f1v/5BS9TMlJsu4XLAEwklb8H6T/7cAzqp9JS589paoDKCsCAxRxw0+1XPDYk7lrn
	 z6R+C0vcm/tGDgJplCnNG0IHxiD+pl36rVVx4Nifd/8ldI4pAFfvESYQBZJu50choY
	 GYuFMC38208r5nr9oxAc9I/nwJYzaN+EYCKK9b3s+JBfLQ3R1YznOGPKy8cyTR0cnM
	 MqZvAwNUDQ6OVCiIEXN8mBFoW5FQDy4eo6GM9lxs45KsvT43R9dukorGfgF7LjJIMI
	 5oSVwRE5e0K/Q==
Content-Type: multipart/mixed; boundary="===============4563891708210814071=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0fc522195058f867d14c8a652b6b698d03751d0d179fcffdf20a44bf4293039a@mail.kernel.org>
In-Reply-To: <20251103220924.36371-5-jolsa@kernel.org>
References: <20251103220924.36371-5-jolsa@kernel.org>
Subject: Re: [PATCHv2 4/4] selftests/bpf: Add stacktrace ips test for raw_tp
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,mhiramat@kernel.org,rostedt@goodmis.org,jpoimboe@kernel.org
Cc: peterz@infradead.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,x86@kernel.org,yhs@fb.com,songliubraving@fb.com,andrii@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Nov 2025 23:47:36 +0000 (UTC)

--===============4563891708210814071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
> index 6fca459ba..282a068d2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
> @@ -84,12 +84,58 @@ static void test_stacktrace_ips_kprobe_multi(bool retprobe)
>  	stacktrace_ips__destroy(skel);
>  }
>
> +static void test_stacktrace_ips_raw_tp(void)
> +{

[ ... ]

> +	/* get bpf program address */
> +	info.jited_ksyms = ptr_to_u64(&bpf_prog_ksym);
> +	info.nr_jited_ksyms = 1;
> +	err = bpf_prog_get_info_by_fd(bpf_program__fd(skel->progs.rawtp_test),
> +				      &info, &info_len);
> +	if (ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> +		goto cleanup;
             ^^^^^^^^^^^^^^

Is the error check inverted in test_stacktrace_ips_raw_tp()?

The ASSERT_OK macro returns true when err == 0 (success), so the code
jumps to cleanup on success and continues on failure. Comparing with
test_stacktrace_ips_kprobe_multi() at line 70, the pattern should be:

  if (!ASSERT_OK_PTR(...))
      goto cleanup;

With the current code, bpf_prog_get_info_by_fd() success skips the test
(trigger_module_test_read and check_stacktrace_ips), while failure
continues with invalid bpf_prog_ksym data.

> +
> +	trigger_module_test_read(1);
> +
> +	load_kallsyms();
> +
> +	check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 2,
> +			     bpf_prog_ksym,
> +			     ksym_get_addr("bpf_trace_run2"));
> +
> +cleanup:
> +	stacktrace_ips__destroy(skel);
> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19051288274

--===============4563891708210814071==--

