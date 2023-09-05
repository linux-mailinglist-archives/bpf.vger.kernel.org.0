Return-Path: <bpf+bounces-9279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E2792F7B
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 22:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960151C20929
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 20:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB866DF56;
	Tue,  5 Sep 2023 20:07:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A9DF44
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 20:07:17 +0000 (UTC)
Received: from out-228.mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6F59C
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 13:07:13 -0700 (PDT)
Message-ID: <1cdcd246-fe16-20d2-3f2d-a3e1204de325@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693944432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fwyi+AaCfi+6F/uAZQEblMsKt47lRW3QDeivafXWgc=;
	b=A0iYOYWDgb+Mqha13+oOmuLrq13sYYYnGjlEgOr9WzcONoA4CYGLkMvqKVFAmGWWwnF/jo
	MRXRmo24lF7bbWOsgVD7cux9jTatCuDVIpVY/2HWrN4h0EP7YWZeo2G6R4dXrTcFIKWEIl
	5LaOk6wc5EOorO8mvisxZs8OrggjF7Y=
Date: Tue, 5 Sep 2023 13:07:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 9/9] selftests/bpf: Add tests for cgroup unix
 socket address hooks
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
 <20230831153455.1867110-10-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230831153455.1867110-10-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/23 8:34 AM, Daan De Meyer wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
> new file mode 100644
> index 000000000000..07941dd48efb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
> @@ -0,0 +1,461 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <sys/un.h>
> +
> +#include "test_progs.h"
> +
> +#include "bindun_prog.skel.h"
> +#include "connectun_prog.skel.h"
> +#include "sendmsgun_prog.skel.h"
> +#include "recvmsgun_prog.skel.h"
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

Tests are also needed for cgroup/get{sock,peer}nameun.


