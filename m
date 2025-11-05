Return-Path: <bpf+bounces-73609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB5CC34DF4
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151E5462682
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A4A2FE050;
	Wed,  5 Nov 2025 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuA5fI3s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A322FB09B
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334898; cv=none; b=J27X8hWkZm7ry/7vtzuHSS7kH9seuoF9+EQEfEWBufbUwBpc3xwOrZhWJNvwZuMlGTlC3cmoJ8D0x7o4+xW4ksMSScpwDq0H0jGj9nFQsoQrw7Sxtr8qo5lDJJAuFwObJuKQUbt7WCdGVJjRFWqITb0d9HjtucGap/ssJNTOr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334898; c=relaxed/simple;
	bh=12W3zv8l9J3aM2JFk9SAfq1e+HJwyMuYUPKFjnnH4mA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=T7tr54FebN3brm6txltXwAoufOH8qWLRbO/U1NY/zxAbn5npiQjMDmTJmTBAGEsDLnl4zya5KZW3zmN+vcp1DQ3Xe2FHjQ/futzsqJZGwKrGo1W/gGosP3CIUu0O8jBJ93JpiqR4eUI9CV8rkBmGp8WajxtGL3ONHtToqDGG2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuA5fI3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C151C4CEF8;
	Wed,  5 Nov 2025 09:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334897;
	bh=12W3zv8l9J3aM2JFk9SAfq1e+HJwyMuYUPKFjnnH4mA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VuA5fI3sKU2QIgHSOyHsOFeZtw3yJRZF2k/icor8qaqdJG7ChPtYMKUvmvQz/JwRQ
	 issCXS/7JrjdkLUqbzuDi+5BwTuq7HTssoJglFxGTPQl3llUJj3j1KnT6qUC3unyNj
	 iEZLykeu/4vNsevT1dWOySGPt0ExLGQJJBqzPgptN0ogiCJSim+2FeCnQaeaxZzEdN
	 WdSJtkzoAH7qSpeXgfym5FntclBRsYFpbEee53DkOZFNBBHQcXm9riQHzoPip4cAt8
	 ayXp6MPrC/aKPS9fytTFkcPMccmuhdr2jJac04stiTEsFnmRhI3cFG/h0LHn2gk356
	 1i9s/x9XiRFxg==
Content-Type: multipart/mixed; boundary="===============6219963211263621609=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9f61c0c4ea50e3a25c4433dd5d5702fb1543931e905e689b9a99dd549f3d8aba@mail.kernel.org>
In-Reply-To: <20251105090410.1250500-5-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-5-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v11 bpf-next 04/12] selftests/bpf: add selftests for new insn_array map
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,aspsk@isovalent.com,daniel@iogearbox.net,eddyz87@gmail.com,qmo@kernel.org,yonghong.song@linux.dev
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Nov 2025 09:28:17 +0000 (UTC)

--===============6219963211263621609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> new file mode 100644
> index 000000000..96ee9c998
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c

[ ... ]

> +/* Map can be used only by one BPF program */
> +static void check_no_map_reuse(void)
> +{
> +	struct bpf_insn insns[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int prog_fd = -1, map_fd, extra_fd = -1;
> +	struct bpf_insn_array_value val = {};
> +	int i;
> +
> +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> +		val.orig_off = i;
> +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
> +			goto cleanup;
> +	}
> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto cleanup;
> +
> +	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> +		goto cleanup;
> +
> +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> +		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
> +			goto cleanup;
> +
> +		ASSERT_EQ(val.xlated_off, i, "val should be equal i");
> +	}
> +
> +	extra_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> +	if (!ASSERT_EQ(extra_fd, -EBUSY, "program should have been rejected (extra_fd != -EBUSY)"))
> +		goto cleanup;
> +
> +	/* correctness: check that prog is still loadable without fd_array */
> +	extra_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD): expected no error"))
>                          ^^^^^^^

In check_no_map_reuse(), is it correct to check prog_fd here? The
function just loaded a program into extra_fd, so this check appears
to be validating the wrong variable.

> +		goto cleanup;
> +
> +cleanup:
> +	close(extra_fd);
> +	close(prog_fd);
> +	close(map_fd);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19096860051

--===============6219963211263621609==--

