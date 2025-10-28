Return-Path: <bpf+bounces-72650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED78C1757E
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C2A3BF468
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434C035502B;
	Tue, 28 Oct 2025 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T51hn/Xi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD52BCF4A
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693929; cv=none; b=fJBev0/SD49fvdugn+VW6myHNz6wlmcz6tznTMhN3U8lce1slDRm3m9asi3jVy0iEqMhxbNln49CwzCI3PXe5GJk9sEWsetSkgtM85yDoyWkkRH99X3woH3FoSivhUU07GFS1T70HwjG5lTt27+bVe7S7+joSZFz7jtrJIR9QgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693929; c=relaxed/simple;
	bh=/HfAwFCCRSHDSpFgmiMDUQOgM8GS5JpZbQTm5obqEY4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ceZeYECw1/8OY81QMNQ1B3fpcEfzbOks2+ZFkllxIEzXlyiHX8fCTtqJBrhid8hin2v9rdvJx23XPjxkr7+HbwoFB4Zh5HuWmWWM+kb5M4a4cJcrkAjv5FR/U22sDkGHYF0NZ028ofaDTtEmUpU1HAubTrqa+CqScDWko//hq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T51hn/Xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB013C4CEE7;
	Tue, 28 Oct 2025 23:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761693929;
	bh=/HfAwFCCRSHDSpFgmiMDUQOgM8GS5JpZbQTm5obqEY4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=T51hn/XilNNxJ83HG2tdsIqXbZSy/8Ppts/2idFd/0abaehyAua8bt2XQt4SJ+vZk
	 TUCbeQlYXiRYlb02hmvh8/207xzbA8cw+Hq7AuEBBTOkGUxLFYnYR7tCHaWoIc7mzD
	 nsOo9y1oQ54nUzVtm5kRUD60H4TVySO+YLt25O1+F/i31Jp8eIT8vpny82SVGfVbby
	 WROS/H/qbNKv+f///nabr2bfzIakY5BeSHHOwZcA+jA2SUy02ybePyDoPudr2X39hP
	 43B5mMNUjI9V4Y4MEAgAlL6CQCUQUharBU2bIQbNiQthEXhWhCV1Cd7dAybih8EwYW
	 /0t6QoNmvyKMQ==
Content-Type: multipart/mixed; boundary="===============8249526173726576367=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f41705b65cd398234052e965943ab9dedf7f78fbed66d1b6e385a0e58db81c2b@mail.kernel.org>
In-Reply-To: <20251028225544.1312356-3-alan.maguire@oracle.com>
References: <20251028225544.1312356-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Test parsing of (multi-)split BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,acme@kernel.org,ttreyer@meta.com,yonghong.song@linux.dev,song@kernel.org,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,ihor.solodrai@linux.dev,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 23:25:27 +0000 (UTC)

--===============8249526173726576367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 9da54f1ee8589391857dcb28c0dbc65a8e6632ea
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test parsing of (multi-)split BTF

This patch adds a test that writes raw BTF data to files, parses it
back, and compares the parsed BTF to the original to verify correctness
of the BTF parsing code.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
> index 3696fb9a0..b07a91ff2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c

[ ... ]

> @@ -123,6 +157,38 @@ static void __test_btf_split(bool multi)
>  "	int uf2;\n"
>  "};\n\n", "c_dump");
>
> +	/* write base, split BTFs to files and ensure parsing succeeds */
> +	base_btf_sz = btf_raw_write(btf1, base_btf_file);
> +	if (base_btf_sz < 0)
> +		goto cleanup;
> +	split_btf_sz = btf_raw_write(btf2, split_btf_file);
> +	if (split_btf_sz < 0)
> +		goto cleanup;
> +	btf4 = btf__parse(base_btf_file, NULL);
> +	if (!ASSERT_OK_PTR(btf4, "parse_base"))
> +		goto cleanup;
> +	btf5 = btf__parse_split(split_btf_file, btf4);
> +	if (!ASSERT_OK_PTR(btf5, "parse_split"))
> +		goto cleanup;
> +	if (multi) {
> +		multisplit_btf_sz = btf_raw_write(btf3, multisplit_btf_file);
> +		if (multisplit_btf_sz < 0)
> +			goto cleanup;
> +		btf6 = btf__parse_split(multisplit_btf_file, btf5);
> +		if (!ASSERT_OK_PTR(btf6, "parse_multisplit"))
> +			goto cleanup;
> +	} else {
> +		btf6 = btf5;
> +	}
> +
> +	/* compare parsed to original BTF */
> +	for (i = 1; i < btf__type_cnt(btf6); i++) {
> +		t = btf__type_by_id(btf6, i);
> +		ot = btf__type_by_id(btf3, i);
> +		if (!ASSERT_EQ(memcmp(t, ot, sizeof(*ot)), 0, "cmp_parsed_orig_btf"))
> +			goto cleanup;
> +	}
> +

Can btf__type_by_id return NULL here in the comparison loop? The loop
iterates based on btf6's type count, but accesses types in both btf6
and btf3. If btf6 has more types than btf3 (indicating a parsing bug),
then btf__type_by_id(btf3, i) will return NULL when i exceeds btf3's
type count, leading to a NULL dereference in memcmp.

Other btf__type_by_id calls in this function (see earlier uses) check
the return value with ASSERT_OK_PTR before dereferencing. Should this
code either verify the type counts match first, or check these return
values to maintain consistency with the rest of the function?

>  cleanup:
> 	if (dump_buf_file)
> 		fclose(dump_buf_file);

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `selftests/bpf: Test parsing of (multi-)split BTF`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18891682588

--===============8249526173726576367==--

