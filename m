Return-Path: <bpf+bounces-10833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B37AE342
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 03:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8AA291C20862
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450A6A4C;
	Tue, 26 Sep 2023 01:19:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85732637
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 01:19:11 +0000 (UTC)
Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [IPv6:2001:41d0:203:375::c6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA7101
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 18:19:10 -0700 (PDT)
Message-ID: <6274a121-2d78-5b7e-1774-c193e5653e8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695691148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uThyLZx79d5CpHoy+p/umPWglh4tb4mSSUz9ndl1kl8=;
	b=Ba29KJSu8Ovc2uopgN6xQR2KsDrtZNL5qfzIsc5eqGnUnywSm1V45pn3tOBmYmGLJNJ16S
	SsPPPoiSnCbNJxntZE40Sy736Kk18ovfcJ6Q9VGs5W4nLaMDAEfkgA3kUlpK4tVTexvZSB
	c+8wQPlflPwcZ2VgXNkdjPvW1ekiIfA=
Date: Mon, 25 Sep 2023 18:19:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 11/11] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-12-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-12-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> new file mode 100644
> index 000000000000..8219a477b6d6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +
> +#include "struct_ops_module.skel.h"
> +#include "testing_helpers.h"
> +
> +static void test_regular_load(void)
> +{
> +	struct struct_ops_module *skel;
> +	struct bpf_link *link;
> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	int err;
> +
> +	printf("test_regular_load\n");
> +	skel = struct_ops_module__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
> +		return;
> +	err = struct_ops_module__load(skel);
> +	if (!ASSERT_OK(err, "struct_ops_module_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
> +	ASSERT_OK_PTR(link, "attach_test_mod_1");
> +
> +	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
> +
> +	bpf_link__destroy(link);
> +
> +	struct_ops_module__destroy(skel);
> +
> +	/* Wait for the map to be freed, or we may fail to unload
> +	 * bpf_testmod.
> +	 */
> +	sleep(1);

Instead of sleep(1), please check if something can be reused from 
kern_sync_rcu_tasks_trace() in map_kptr.c such that the wait can be done 
deterministically. If not, waiting for a fexit trace on bpf_struct_ops_map_free 
probably should work also.

