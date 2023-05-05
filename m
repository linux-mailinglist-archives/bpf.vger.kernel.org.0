Return-Path: <bpf+bounces-156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686D16F8B97
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258D92810C4
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1036F101D1;
	Fri,  5 May 2023 21:49:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8319DF71
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:49:10 +0000 (UTC)
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8375BA7
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 14:49:09 -0700 (PDT)
Message-ID: <552cd8ad-e04d-5c96-2b90-36f765bb3298@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1683323347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlZYImk76QDhwU1Mw/e42iqfA3JNjW3CixMBZhtiNmY=;
	b=GJj6LNcsUsuj8eU4Z6oK/eZXbqhT/qQ0ugMB/ceqQeZoK8rtmp6bxgaXiKxlL9SHzP9wno
	o2Y3/Maz3t3K9VapJc2Zd/r6FyzWs3i9G5NX90ylsEv4nD79f7aP0aB1BWb0GcmRuVruUX
	ILwe37VQF/FXAXo1glJDqd1fAoIzOBg=
Date: Fri, 5 May 2023 14:49:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/4] selftests/bpf: Correctly handle optlen >
 4096
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org
References: <20230504184349.3632259-1-sdf@google.com>
 <20230504184349.3632259-4-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230504184349.3632259-4-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/4/23 11:43 AM, Stanislav Fomichev wrote:
> @@ -298,9 +253,8 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
>   void test_sockopt_multi(void)
>   {
>   	int cg_parent = -1, cg_child = -1;
> -	struct bpf_object *obj = NULL;
> +	struct sockopt_multi *obj = NULL;
>   	int sock_fd = -1;
> -	int err = -1;
>   
>   	cg_parent = test__join_cgroup("/parent");
>   	if (!ASSERT_GE(cg_parent, 0, "join_cgroup /parent"))
> @@ -310,13 +264,11 @@ void test_sockopt_multi(void)
>   	if (!ASSERT_GE(cg_child, 0, "join_cgroup /parent/child"))
>   		goto out;
>   
> -	obj = bpf_object__open_file("sockopt_multi.bpf.o", NULL);
> -	if (!ASSERT_OK_PTR(obj, "obj_load"))
> -		goto out;
> +	obj = sockopt_multi__open_and_load();
> +	if (!ASSERT_OK_PTR(obj, "skel-load"))
> +		return;

goto out;

>   
> -	err = bpf_object__load(obj);
> -	if (!ASSERT_OK(err, "obj_load"))
> -		goto out;
> +	obj->bss->page_size = sysconf(_SC_PAGESIZE);
>   
>   	sock_fd = socket(AF_INET, SOCK_STREAM, 0);
>   	if (!ASSERT_GE(sock_fd, 0, "socket"))
> @@ -327,7 +279,7 @@ void test_sockopt_multi(void)
>   
>   out:
>   	close(sock_fd);
> -	bpf_object__close(obj);
> +	sockopt_multi__destroy(obj);
>   	close(cg_child);
>   	close(cg_parent);
>   }


