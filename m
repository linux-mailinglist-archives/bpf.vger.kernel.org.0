Return-Path: <bpf+bounces-50747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A50A2BB01
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 07:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26563A7E9C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 06:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0F21AB6C8;
	Fri,  7 Feb 2025 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m/yl3USG"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F313176FB0
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908272; cv=none; b=uXodVvi7ub6l8rSovO+9nlh/4VBhtZkLPDhvmx+AO85ziS/prZODJizOX6HUTjDfyB9RuGBiN4V6WFgqtQRkuUez7OPy5evZb9ifWezL7uH9XyA83xJLG5GivS17+Zty9q4J5kwqshGueWiLtJ1N4DAaj/dOeE5DOpnCQ7PuVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908272; c=relaxed/simple;
	bh=me3r634hb1lYNk273S3Z9pLt9FrNm6dScu+Ncv6skuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdkLWJEjl/3Sxf5WZCYdTlSXBO6kEuFOOdgjLm2MWCElugNSqw9anCBzsPFSr67ALGUiDXwDp/fTMDgfI0fcZr6cP0/fO5UkrBaEOlsr80rX3Qvz9m2N/wdGr/2ljHGVyAHxZvaKSthz+YljhA3MJ+ffJOxLpSnWmxoycm6ecws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m/yl3USG; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b348ab7-7378-40bc-98e7-98eb1377f9c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738908253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kj+5iZXbniePrmRu1hVwpnOzPx+raFyDx6ea5ukUze4=;
	b=m/yl3USGeWS7hKL0QAZvR66b4HW6bA2Bf9vzho7eUY/4En1Aq1is2r5m21vU0AwQ2MR4g9
	jq5EjclPOzKjL+U77zf+A2suP+dNT7jYDJhgkcusrmWZjgBC74vHCnUt/aqvTeeofqXqFF
	TSPJRHfbfe0Y0TcRw1NVFZwBlFJGLPc=
Date: Thu, 6 Feb 2025 22:04:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: changes_pkt_data: correct the 'main'
 error
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
 <20250204023946.16031-2-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250204023946.16031-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/3/25 6:39 PM, Jason Xing wrote:
> When compiling the selftests, the following error is printed out:
> selftests/bpf/prog_tests/changes_pkt_data.c: In function ‘test_aux’:
> selftests/bpf/prog_tests/changes_pkt_data.c:22:27: error: ‘main’ is usually a function [-Werror=main]
>    struct changes_pkt_data *main = NULL;

The bpf CI has been testing this piece with different compilers. I also don't 
see it in my environment. How to reproduce it and which compiler?

> Fix it by replacing with 'main_data'.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/changes_pkt_data.c      | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
> index 7526de379081..b5c9031ec470 100644
> --- a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
> +++ b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
> @@ -19,7 +19,7 @@ static void test_aux(const char *main_prog_name,
>   	struct bpf_program *freplace_prog = NULL;
>   	struct bpf_program *main_prog = NULL;
>   	LIBBPF_OPTS(bpf_object_open_opts, opts);
> -	struct changes_pkt_data *main = NULL;
> +	struct changes_pkt_data *main_data = NULL;
>   	char log[16*1024];
>   	int err;
>   
> @@ -27,14 +27,14 @@ static void test_aux(const char *main_prog_name,
>   	opts.kernel_log_size = sizeof(log);
>   	if (env.verbosity >= VERBOSE_SUPER)
>   		opts.kernel_log_level = 1 | 2 | 4;
> -	main = changes_pkt_data__open_opts(&opts);
> -	if (!ASSERT_OK_PTR(main, "changes_pkt_data__open"))
> +	main_data = changes_pkt_data__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(main_data, "changes_pkt_data__open"))
>   		goto out;
> -	main_prog = bpf_object__find_program_by_name(main->obj, main_prog_name);
> +	main_prog = bpf_object__find_program_by_name(main_data->obj, main_prog_name);
>   	if (!ASSERT_OK_PTR(main_prog, "main_prog"))
>   		goto out;
>   	bpf_program__set_autoload(main_prog, true);
> -	err = changes_pkt_data__load(main);
> +	err = changes_pkt_data__load(main_data);
>   	print_verifier_log(log);
>   	if (!ASSERT_OK(err, "changes_pkt_data__load"))
>   		goto out;
> @@ -60,7 +60,7 @@ static void test_aux(const char *main_prog_name,
>   
>   out:
>   	changes_pkt_data_freplace__destroy(freplace);
> -	changes_pkt_data__destroy(main);
> +	changes_pkt_data__destroy(main_data);
>   }
>   
>   /* There are two global subprograms in both changes_pkt_data.skel.h:


