Return-Path: <bpf+bounces-17965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB6681423A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 08:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44197282E6A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF56D27E;
	Fri, 15 Dec 2023 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J8eKniA1"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BC2D2E2
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <83daf2e3-6e2e-45f2-9a54-32fac1c98cde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702624668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcH0345c04t/6jutxGNEeby8BHLaRQ7hzlU2LNtq5fM=;
	b=J8eKniA1czd4rl0XtauzsNM0Dk0iB5YXCy3V23O6fjTRzngSk0qbkLax+66HTZrq6p08oa
	eiMfG3iRIt6o02ewUApf03fyV3ETVsIuqAYuTnaVNGoKKA14DZayl4d3ye8BBqUmu0wOiX
	kmJjhgDAdf6kXlCmUUt8S7/0Hie45s4=
Date: Thu, 14 Dec 2023 23:17:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 13/14] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-14-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231209002709.535966-14-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> new file mode 100644
> index 000000000000..55a4c6ed92aa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <time.h>
> +
> +#include "struct_ops_module.skel.h"
> +#include "testmod_unload.skel.h"
> +
> +static void test_regular_load(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	struct struct_ops_module *skel;
> +	struct testmod_unload *skel_unload;
> +	struct bpf_link *link_map_free = NULL;
> +	struct bpf_link *link;
> +	int err, i;
> +
> +	skel = struct_ops_module__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
> +		return;
> +
> +	err = struct_ops_module__load(skel);
> +	if (!ASSERT_OK(err, "struct_ops_module_load"))
> +		goto cleanup;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
> +	ASSERT_OK_PTR(link, "attach_test_mod_1");
> +
> +	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
> +	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
> +
> +	bpf_link__destroy(link);
> +
> +cleanup:
> +	skel_unload = testmod_unload__open_and_load();
> +
> +	if (ASSERT_OK_PTR(skel_unload, "testmod_unload_open"))
> +		link_map_free = bpf_program__attach(skel_unload->progs.trace_map_free);
> +	struct_ops_module__destroy(skel);
> +
> +	if (!ASSERT_OK_PTR(link_map_free, "create_link_map_free"))
> +		return;
> +
> +	/* Wait for the struct_ops map to be freed. Struct_ops maps hold a
> +	 * refcount to the module btf. And, this function unloads and then
> +	 * loads bpf_testmod. Without waiting the map to be freed, the next
> +	 * test may fail to unload the bpf_testmod module since the map is
> +	 * still holding a refcnt to the module.
> +	 */
> +	for (i = 0; i < 10; i++) {
> +		if (skel_unload->bss->bpf_testmod_put)
> +			break;
> +		usleep(100000);
> +	}
> +	ASSERT_EQ(skel_unload->bss->bpf_testmod_put, 1, "map_free");
> +
> +	bpf_link__destroy(link_map_free);
> +	testmod_unload__destroy(skel_unload);
> +}
> +
> +static void test_load_without_module(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	struct struct_ops_module *skel;
> +	int err;
> +
> +	err = unload_bpf_testmod(false);
> +	if (!ASSERT_OK(err, "unload_bpf_testmod"))
> +		return;
> +
> +	skel = struct_ops_module__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
> +		goto cleanup;
> +	err = struct_ops_module__load(skel);

Both the module btf and the .ko itself are gone from the kernel now?
This is basically testing libbpf cannot find 'struct bpf_testmod_ops' from the 
running kernel?

How about create another struct_ops_module_notfound.c bpf program:
SEC(".struct_ops.link")
struct bpf_testmod_ops_notfound testmod_1 = {
	.test_1 = (void *)test_1,
	.test_2 = (void *)test_2,
};

and avoid the usleep() wait and the unload_bpf_testmod()?

> +	ASSERT_ERR(err, "struct_ops_module_load");
> +
> +	struct_ops_module__destroy(skel);
> +
> +cleanup:
> +	/* Without this, the next test may fail */
> +	load_bpf_testmod(false);
> +}
> +
> +void serial_test_struct_ops_module(void)
> +{
> +	if (test__start_subtest("regular_load"))
> +		test_regular_load();
> +
> +	if (test__start_subtest("load_without_module"))
> +		test_load_without_module();
> +}
> +



