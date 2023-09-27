Return-Path: <bpf+bounces-10989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A662A7B0EF3
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 00:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 075342821B9
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8D1C2AE;
	Wed, 27 Sep 2023 22:36:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7D3C24
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 22:36:33 +0000 (UTC)
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [91.218.175.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF85FB
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 15:36:21 -0700 (PDT)
Message-ID: <9b5c95e7-24e0-1e74-125b-331fc4437460@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695854179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXEIccVFxoI0i+jOrCELaT2SDnRlOnQnZ35cPBLGjY4=;
	b=lZjhoLGTvFN2YGymbUJbKRUqBjdSiB5zgaaD0O/lmPEai3BkfqLB97KI8CSIA0+ggO9Fiz
	n6qgFZIKyOUJaXNHYvxff3KMS6Gk8PLSJXy9p9+Kf/aOYgEWdZr8pyqC4c8aN/iHmVd1eA
	op6eXbpezixSnqnIyTcm3ruqJMaXGms=
Date: Wed, 27 Sep 2023 15:36:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: Add tests for cgroup unix
 socket address hooks
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
 <20230926202753.1482200-10-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230926202753.1482200-10-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/26/23 1:27 PM, Daan De Meyer wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
> new file mode 100644
> index 000000000000..f173a5665547
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
> @@ -0,0 +1,614 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <sys/un.h>
> +
> +#include "test_progs.h"
> +
> +#include "connectun_prog.skel.h"
> +#include "sendmsgun_prog.skel.h"
> +#include "recvmsgun_prog.skel.h"
> +#include "getsocknameun_prog.skel.h"
> +#include "getpeernameun_prog.skel.h"
> +#include "network_helpers.h"
> +
> +#define SERVUN_ADDRESS         "bpf_cgroup_unix_test"
> +#define SERVUN_REWRITE_ADDRESS "bpf_cgroup_unix_test_rewrite"
> +#define SRCUN_ADDRESS	       "bpf_cgroup_unix_test_src"
> +
> +enum sock_addr_test_type {
> +	SOCK_ADDR_TEST_BIND,
> +	SOCK_ADDR_TEST_CONNECT,
> +	SOCK_ADDR_TEST_SENDMSG,
> +	SOCK_ADDR_TEST_RECVMSG,
> +	SOCK_ADDR_TEST_GETSOCKNAME,
> +	SOCK_ADDR_TEST_GETPEERNAME,
> +};
> +
> +struct sock_addr_test;

This forward declaration should not be needed.

Others look good.

