Return-Path: <bpf+bounces-75850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901FEC99A78
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 01:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3186E3A52CA
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 00:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6723A156678;
	Tue,  2 Dec 2025 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT7yOzko"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48F22097;
	Tue,  2 Dec 2025 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764635710; cv=none; b=L8vSIZxnuGmFx321KVOJCIq+laQNxBIFiNN5b3zlpPuJNRkcM3IQOUxirp1n1hu1pObmGFnhIEU93p7AdTIrJWZjG7h/JItLu2hIrjpo83CFY96T1UrWKDe2JzQpslDTJobbABFj8cuTHoBJkVnNKgCdeem9tzqlYSMEXvnvoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764635710; c=relaxed/simple;
	bh=hbPKmzuyFuSskmPDGHoi/1ZNfeCLCD+gKKUSlj3wpqU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FTRNwrUWPts4Hk18UHSnrGGqD/Rm/1mgJoyFzB3rpn44ZRX78blrLTSVa5ejl427sbfl8Qr0oi4W+oW0eH4o6fWU/bcdAiBe/WwNvLi/4Bp/51VOl+TTwtYT8/gIRLbIPuTeU/YStq1uEf2w1l/97H69wIpabEZBVCOhPWl+s2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT7yOzko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDE9C4CEF1;
	Tue,  2 Dec 2025 00:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764635709;
	bh=hbPKmzuyFuSskmPDGHoi/1ZNfeCLCD+gKKUSlj3wpqU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MT7yOzkooKJpEkgsd7yfvMbY9rAdPW+fBB2QPeF+JDR2sOqWeYRI3UoFjaGwrj7SZ
	 f6xOpiH/cM9/kbBf3JihEWOs8Vn8hwMAblCBHFCLBwcHfcoL6HskCNuLaD4RBUu4fF
	 IyU4+Di9H2CFQv2Rw0sAShsPPyks1ywlionMzniJpnLmHsDJJKgTFw4Eeb1jYwYU9s
	 1+urqAC/ibK2OAnj5eZXQIdIzaFyVJebgs/t5UWkVdE22qQ/VvR05U16IY+JoJ2ZzL
	 7Kfr1WyPMTCSQdYqDq5k7YxNikY3nV4jlkon0SCL4wRdv0du/qWBMD8+Xa50+X48kM
	 mxCMLgFLaAn8A==
Content-Type: multipart/mixed; boundary="===============1706672173071555033=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d396eeba7daf48c871d9690857c060e4080489c5f5da9841ca186c6442bc205b@mail.kernel.org>
In-Reply-To: <20251202001822.2769330-2-ameryhung@gmail.com>
References: <20251202001822.2769330-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test using cgroup storage in a tail call callee program
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Dec 2025 00:35:08 +0000 (UTC)

--===============1706672173071555033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index 0ab36503c..e4a5287f1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c

[ ... ]

> @@ -1648,6 +1649,28 @@ static void test_tailcall_bpf2bpf_freplace(void)
>  	tc_bpf2bpf__destroy(tc_skel);
>  }
>
> +/*
> + * test_tail_call_cgrp_storage makes sure that callee programs cannot
> + * use cgroup storage
> + */
> +static void test_tailcall_cgrp_storage(void)
> +{
> +	int err, prog_fd, prog_array_fd, key = 0;
> +	struct tailcall_cgrp_storage *skel;
> +
> +	skel = tailcall_cgrp_storage__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open_and_load"))
> +		return;
> +
> +	prog_fd = bpf_program__fd(skel->progs.callee_prog);
> +	prog_array_fd = bpf_map__fd(skel->maps.prog_array);
                     ^^^^

Should the return values of bpf_program__fd() and bpf_map__fd() be
checked before use? Other tests in this file validate these return
values (see test_tailcall_1 and similar tests which check for < 0).

Without checking, if either function returns a negative error value,
bpf_map_update_elem() could fail for the wrong reason (invalid FD),
and ASSERT_ERR would still pass, potentially masking issues with the
actual kernel restriction being tested.

> +
> +	err = bpf_map_update_elem(prog_array_fd, &key, &prog_fd, BPF_ANY);
> +	ASSERT_ERR(err, "bpf_map_update_elem");
> +
> +	tailcall_cgrp_storage__destroy(skel);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19842130628

--===============1706672173071555033==--

