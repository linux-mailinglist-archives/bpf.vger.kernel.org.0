Return-Path: <bpf+bounces-70942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE57BDBB89
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C80423783
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454A29DB86;
	Tue, 14 Oct 2025 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NspAMDKs"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A0239562
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482913; cv=none; b=BYsSkDbbJwosBSxZKcdu1zh1yUKJzV4AvXIsoIH037BTnyvSbd/HpZf1b1lHcr8ORhgu4j6ld4MHlmimne4qXGwoC+0b3ww2y+Wn2XfqxtXTflvB9yvxg6wjjteJWx0rNI/dOCyqYqz9ZoISttd1Uq5yt8+VPHJeK6vDSm6aBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482913; c=relaxed/simple;
	bh=wtXF9JI4A9SsYOD5xA657f0Zsy4c36XnaeNbznBsgy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kxn5jQ4NRDbZlOwSqzGpzVMtBMreQgopIMM8XXMo5GvXoM4GtheFj4M+C9/WhnJqLQirUA7gBVT2K0gpMbdwZ9WYvkHGivwTT952oIf67FTqKJnMazM52ydlmdeIa9u5/ugFJBl10iOya61vh8BjQQhvwd9Pqg/Xgq9ypHoEPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NspAMDKs; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2053ee20-716a-4e5f-b3a7-b1a08b6c9a1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760482909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRvrtFH7aC3LElbdSgyJkJeMcb1iNRQUTrtYmTuIJPk=;
	b=NspAMDKsAuD2MHHQ8o24wa3VSW0hrwOyDQESiTQagMj46QdJqDY5vwpdqsvHauR9xeut35
	LZyoZ1LPGMuzJ8BJAhJA70v63M7+PMFlgIOu0o895mQdWfO6YyK+pG1ddAYjJoJQl/jWue
	AM+objMX6sIfA59sA9yrYgs4UpLF1NU=
Date: Tue, 14 Oct 2025 16:01:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: make arg_parsing.c more robust to
 crashes
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20251014202037.72922-1-andrii@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251014202037.72922-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/14/25 1:20 PM, Andrii Nakryiko wrote:
> We started getting a crash in BPF CI, which seems to originate from
> test_parse_test_list_file() test and is happening at this line:
> 
>   ASSERT_OK(strcmp("test_with_spaces", set.tests[0].name), "test 0 name");
> 
> One way we can crash there is if set.cnt zero, which is checked for with
> ASSERT_EQ() above, but we proceed after this regardless of the outcome.
> Instead of crashing, we should bail out with test failure early.
> 
> Similarly, if parse_test_list_file() fails, we shouldn't be even looking
> at set, so bail even earlier if ASSERT_OK() fails.
> 
> Fixes: 64276f01dce8 ("selftests/bpf: Test_progs can read test lists from file")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

This patch in combination with another arg_parsing.c fix [1] mitigates
recent BPF CI failures:
https://github.com/kernel-patches/vmtest/actions/runs/18510075579?pr=404

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

[1] https://lore.kernel.org/bpf/20251014080323.1660391-1-higuoxing@gmail.com/


> ---
>  tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> index bb143de68875..fbf0d9c2f58b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> @@ -146,9 +146,12 @@ static void test_parse_test_list_file(void)
>  
>  	init_test_filter_set(&set);
>  
> -	ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file");
> +	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
> +		goto out_fclose;
> +
> +	if (!ASSERT_EQ(set.cnt, 4, "test  count"))
> +		goto out_free_set;
>  
> -	ASSERT_EQ(set.cnt, 4, "test  count");
>  	ASSERT_OK(strcmp("test_with_spaces", set.tests[0].name), "test 0 name");
>  	ASSERT_EQ(set.tests[0].subtest_cnt, 0, "test 0 subtest count");
>  	ASSERT_OK(strcmp("testA", set.tests[1].name), "test 1 name");
> @@ -158,8 +161,8 @@ static void test_parse_test_list_file(void)
>  	ASSERT_OK(strcmp("testB", set.tests[2].name), "test 2 name");
>  	ASSERT_OK(strcmp("testC_no_eof_newline", set.tests[3].name), "test 3 name");
>  
> +out_free_set:
>  	free_test_filter_set(&set);
> -
>  out_fclose:
>  	fclose(fp);
>  out_remove:


