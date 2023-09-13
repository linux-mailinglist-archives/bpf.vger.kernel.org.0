Return-Path: <bpf+bounces-9961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3741579F323
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 22:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B241F210BE
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682122EE5;
	Wed, 13 Sep 2023 20:48:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909AE200D9
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 20:48:21 +0000 (UTC)
Received: from out-218.mta0.migadu.com (out-218.mta0.migadu.com [IPv6:2001:41d0:1004:224b::da])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C237D1BCB
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 13:48:20 -0700 (PDT)
Message-ID: <77405214-ae42-d58b-1d40-c639683a0cb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694638098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwREo+am6jJ9+Xq8BZFdvke2FcjINYzH66vqtX+PkMY=;
	b=U6yP+KxVDbx6rtpw5f5CSR3ZoGvmldJXz0NCPIybsjJd+xyoTeZNMYs43/xZA2kbod2YuI
	iZHsYCL/aT/cgd5cQeknemK5X80ETTnnt0pK2hpUt00drdgkbSY60/xpzcdzZey3HW48B+
	pegXznmpHCLY9DTg87bF8nQnqSLSJc0=
Date: Wed, 13 Sep 2023 13:48:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 8/8] selftests/bpf/sockopt: Add io_uring support
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org,
 =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
 Wang Yufen <wangyufen@huawei.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 krisman@suse.de, Andrii Nakryiko <andrii@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20230913152744.2333228-1-leitao@debian.org>
 <20230913152744.2333228-9-leitao@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230913152744.2333228-9-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/13/23 8:27 AM, Breno Leitao wrote:
> Expand the BPF sockopt test to use also check for io_uring
> {g,s}etsockopt commands operations.
> 
> Create infrastructure to run io_uring tests using the mini_liburing
> helpers, so, the {g,s}etsockopt operation could either be called from
> system calls, or, via io_uring.
> 
> Add a 'use_io_uring' parameter to run_test(), to specify if the test
> should be run using io_uring if the parameter is set, or via the regular
> system calls if false.
> 
> Call *all* tests twice, using the regular io_uring path, and the new
> io_uring path.

The bpf CI failed to compile because of missing some newer enum: 
https://github.com/kernel-patches/bpf/actions/runs/6176703557/job/16766325932

An option is to copy the io_uring.h to tools/include/uapi/linux/.


