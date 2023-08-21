Return-Path: <bpf+bounces-8188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1DF783425
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44977280F7E
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 20:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28F911CB3;
	Mon, 21 Aug 2023 20:59:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A011737
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:59:27 +0000 (UTC)
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02302C7
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 13:59:25 -0700 (PDT)
Message-ID: <59278e71-3a88-5da9-b46e-9992987d258d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692651564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fe40UAqHy2mSuHq32lY+2IGEBxta1jrbqGlWmnXdHbg=;
	b=N5I0skx59JzXu2baJXbF38imzDjl43wA/zkHuZpM2JUs8BsEU+frZFEWx4uCLnx9NBL6qc
	INNWA6aXZMMOVEGHPE3PnqS+69ABvQNoDFOaldOjkRxc4p9eMOsl2Zs34xzX4ncdXfQhW4
	8Xjh+GYHPKguFsHq3g5NFCJKbi5wEkI=
Date: Mon, 21 Aug 2023 13:59:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 9/9] selftests/bpf/sockopt: Add io_uring support
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, krisman@suse.de, Wang Yufen <wangyufen@huawei.com>,
 =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, Andrii Nakryiko <andrii@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20230817145554.892543-1-leitao@debian.org>
 <20230817145554.892543-10-leitao@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230817145554.892543-10-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/23 7:55 AM, Breno Leitao wrote:
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 538df8fb8c42..4da04242b848 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -362,6 +362,7 @@ CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
>   
>   $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
>   $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
> +$(OUTPUT)/test_progs.o: CFLAGS += -I../../../include/

This is the tools/include? Is it really needed? iirc, some of the prog_tests/*.c 
has already been using files from tools/include.

>   
>   $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
>   $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> index 9e6a5e3ed4de..4693ad8bfe8f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <test_progs.h>
> +#include <io_uring/mini_liburing.h>
>   #include "cgroup_helpers.h"
>   
>   static char bpf_log_buf[4096];
> @@ -38,6 +39,7 @@ static struct sockopt_test {
>   	socklen_t			get_optlen_ret;
>   
>   	enum sockopt_test_error		error;
> +	bool				io_uring_support;
>   } tests[] = {
>   
>   	/* ==================== getsockopt ====================  */
> @@ -53,6 +55,7 @@ static struct sockopt_test {
>   		.attach_type = BPF_CGROUP_GETSOCKOPT,
>   		.expected_attach_type = 0,
>   		.error = DENY_LOAD,
> +		.io_uring_support = true,

DENY_LOAD probably won't be an intersting test. The set/getsockopt won't be called.

The existing test does not seem to have SOL_SOCKET for getsockopt also.

> -static int run_test(int cgroup_fd, struct sockopt_test *test)
> +/* Core function that handles io_uring ring initialization,
> + * sending SQE with sockopt command and waiting for the CQE.
> + */
> +static int uring_sockopt(int op, int fd, int level, int optname,
> +			 const void *optval, socklen_t optlen)
> +{
> +	struct io_uring_cqe *cqe;
> +	struct io_uring_sqe *sqe;
> +	struct io_uring ring;
> +	int err;
> +
> +	err = io_uring_queue_init(1, &ring, 0);
> +	if (err) {
> +		log_err("Failed to initialize io_uring ring");
> +		return err;
> +	}
> +
> +	sqe = io_uring_get_sqe(&ring);
> +	if (!sqe) {
> +		log_err("Failed to get an SQE");
> +		return -1;

No need to io_uring_queue_exit() on the error path?


> +	}
> +
> +	io_uring_prep_cmd(sqe, op, fd, level, optname, optval, optlen);
> +
> +	err = io_uring_submit(&ring);
> +	if (err != 1) {
> +		log_err("Failed to submit SQE");

Use ASSERT_* instead.

Regarding how to land this set,
it will be useful to have the selftest running in the bpf CI. While there is 
iouring changes, some of the changes is in bpf and/or netdev also. eg. Patch 3 
already has a conflict with the net-next and bpf-next tree because of a recent 
commit in socket.c on Aug 9.

May be Alexi and Daniel can advise how was similar patch managed before ?



