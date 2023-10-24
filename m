Return-Path: <bpf+bounces-13098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEF67D45ED
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 05:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAB9B20EDA
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 03:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE55673;
	Tue, 24 Oct 2023 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xeCU9FUK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F823A6
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 03:28:33 +0000 (UTC)
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A183
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 20:28:31 -0700 (PDT)
Message-ID: <0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698118109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fvextBqAqP7MtW5YqhYrMlGtzS9D2lHRuhU2o1fRKMM=;
	b=xeCU9FUK0o+eESj+4RG20o15X/2aPBvnjwYW+dJh5lq5NhFZeiZX/B7EXUX9tX6e2MYDlz
	2Wr1jQb2OwypvCulURHq/N3Oq+tozXh+mZQE7LRtbsZZLiQeGCf4fwqXuNpHaZyit9rnqg
	+HNw9g5QsgDx1bFyL27fkN1BU2isqhA=
Date: Mon, 23 Oct 2023 20:28:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: bpf: add malloc failures checks in bpf_iter
Content-Language: en-GB
To: Yuran Pereira <yuran.pereira@hotmail.com>, shuah@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, brauner@kernel.org, iii@linux.ibm.com, kuifeng@meta.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <DB3PR10MB683506E8DCCB073A2B75BB10E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DB3PR10MB683506E8DCCB073A2B75BB10E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/23/23 7:59 PM, Yuran Pereira wrote:
> Since some malloc calls in bpf_iter may at times fail,
> this patch adds the appropriate fail checks, and ensures that
> any previously allocated resource is appropriately destroyed
> before returning the function.
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 1f02168103dd..6d47ea9211a4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -878,6 +878,11 @@ static void test_bpf_percpu_hash_map(void)
>   
>   	skel->rodata->num_cpus = bpf_num_possible_cpus();
>   	val = malloc(8 * bpf_num_possible_cpus());
> +	if (CHECK(!val, "malloc", "memory allocation failed: %s",
> +				strerror(errno))) {
> +		bpf_iter_bpf_percpu_hash_map__destroy(skel);
> +		return;
> +	}


Could you use !ASSERT_OK_PTR(...) instead of CHECK? bpf selftest
prefers to use ASSERT_* series of macros instead of CHECK.
In the above example, printing out strerror is not required,
see some other examples in the same folder.

Also bpf_iter.c has some other usages of CHECK macro.
Since you are touching this file, could you convert all
CHECK macros to ASSERT_* macros?

Basically you need two patches:
   patch 1: convert existing CHECK macros to ASSERT_* macros in bpf_iter.c.
            this should not check any functionality except error messages.
   patch 2: your patch with ASSERT_* macros.

You can use the following as your subject line:
   [PATCH bpf-next] selftests/bpf: Add malloc failure checks in bpf_iter

>   
>   	err = bpf_iter_bpf_percpu_hash_map__load(skel);
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
> @@ -1057,6 +1062,11 @@ static void test_bpf_percpu_array_map(void)
>   
>   	skel->rodata->num_cpus = bpf_num_possible_cpus();
>   	val = malloc(8 * bpf_num_possible_cpus());
> +	if (CHECK(!val, "malloc", "memory allocation failed: %s",
> +				strerror(errno))) {
> +		bpf_iter_bpf_percpu_hash_map__destroy(skel);
> +		return;
> +	}
>   
>   	err = bpf_iter_bpf_percpu_array_map__load(skel);
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))

