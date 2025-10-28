Return-Path: <bpf+bounces-72590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB11C15E8E
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3C64342BA7
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E37341AA0;
	Tue, 28 Oct 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHIDCTun"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7920013A
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669927; cv=none; b=CLfjgNdN/v3bS3qu9M9jo0hQ60gYXHeJZfMrLhwsrAlVuDOwbMB+WBU7VszcZ9yIZCck6tpEvtgNS9Q61TFnkFlO2i6VckvWJZnMvjCpzyXgxSFSK5RAazlqJDiDkLseYvHXxk4tBxI9lBzIp41INkBWOINsj4DHhWx9QsDwbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669927; c=relaxed/simple;
	bh=we7dWev+dyTeCybOlXST9gtiRRywcl7qxWSX7OCQOzE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=II78MYJv1XRU2cJmuhMuA9LRRJHOWoe3n75g2pY4ZcNnv4vK6UszKqC8/RFBV2V2KUhsobknPAx/BMdufeCgwlqk4Mfo96dWQ+JLkAnBo+v2B9cdeGlUevMtQT1pd4+7Q3jnFNp7FgQSCmNXYKUP5hBGSiozcsYEh3GUFsZ26zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHIDCTun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE9AC4CEE7;
	Tue, 28 Oct 2025 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761669927;
	bh=we7dWev+dyTeCybOlXST9gtiRRywcl7qxWSX7OCQOzE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=KHIDCTun6aL6c0tXuxUXppxXyZEi4fNQWdHux98IyCoTqNElWMFNt6D+O2WNAnGUK
	 DbXQ0wmQZmyxiExUaXWB00ln04uNpZ9LrzlpiA+W5JWA4mC2pWS8k8xG3yfy4dnARc
	 gPZqsjWFFprh1YsHjvaJRIcQDEcM+KUaUW3FuK9CLSAlna8/UpQpvFUXJPxEg6T5ax
	 ON5O+4ZezJAl1RW35yRGyT5+d5USAmVYOLgK/VpE5F5grxGKXKKzIftYzSVcufUdMn
	 9IOWeTZkrvObqv+RJr7Y0bKr3xlDqLqcFNgSEltlYM0muChIhkxOv9FQQ5cAOhlFrG
	 xrbDKTCknxRJQ==
Content-Type: multipart/mixed; boundary="===============3825646978135117536=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <478a9790d452e3ab4c846f673e7e6ed1b4cb347adfe9628d0fc71256d7f2edcc@mail.kernel.org>
In-Reply-To: <20251028155709.1265445-3-alan.maguire@oracle.com>
References: <20251028155709.1265445-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Test parsing of (multi-)split BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,acme@kernel.org,ttreyer@meta.com,yonghong.song@linux.dev,song@kernel.org,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,ihor.solodrai@linux.dev,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 16:45:25 +0000 (UTC)

--===============3825646978135117536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 8509f4500fb2dfaec7a383a802dffaf84995c434
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test parsing of (multi-)split BTF

This commit adds test coverage for parsing split BTF data that has been
written to files. It writes raw BTF data to temporary files, parses them
back, and compares the parsed results to the original in-memory BTF.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
> index 3696fb9a0..ee1481c5f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c

[ ... ]

> @@ -123,6 +155,35 @@ static void __test_btf_split(bool multi)
>  "	int uf2;\n"
>  "};\n\n", "c_dump");
>
> +	/* write base, split BTFs to files and ensure parsing succeeds */
> +	if (btf_raw_write(btf1, base_btf_file) != 0)
> +		goto cleanup;
> +	if (btf_raw_write(btf2, split_btf_file) != 0)
> +		goto cleanup;
> +	btf4 = btf__parse(base_btf_file, NULL);
> +	if (!ASSERT_OK_PTR(btf4, "parse_base"))
> +		goto cleanup;
> +	btf5 = btf__parse_split(split_btf_file, btf4);
> +	if (!ASSERT_OK_PTR(btf5, "parse_split"))
> +		goto cleanup;
> +	if (multi) {
> +		if (btf_raw_write(btf3, multisplit_btf_file) != 0)
> +			goto cleanup;
> +		btf6 = btf__parse_split(multisplit_btf_file, btf5);
> +		if (!ASSERT_OK_PTR(btf5, "parse_multisplit"))
                                 ^^^^^

Should this check btf6 instead of btf5? The line above assigns to btf6,
but this assertion checks btf5 which was already validated earlier.
Following the pattern from the btf4 and btf5 checks above, it looks like
this should be checking the newly assigned btf6 pointer.

> +			goto cleanup;
> +	} else {
> +		btf6 = btf5;
> +	}

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `selftests/bpf: Test parsing of (multi-)split BTF`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18881352510

--===============3825646978135117536==--

