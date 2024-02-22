Return-Path: <bpf+bounces-22529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBAA86044C
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 22:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E421F22FE2
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB217175E;
	Thu, 22 Feb 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iqvVpcMM"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882710A05
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635811; cv=none; b=P8MTB/vCRx6dE9dbwxJD8D1KSXrlj77xzsmmx0GhnZm26HnmvwSkud8cGcEckc9JxRsdSyA/lytOBelrW0VrUi8q5Ok/mCOB9Ox3lmk0GBVbfNydL5kQUro0wYfWkgHITesT7AHmcMjPPn9BRSh5N5CVtjaQKG69CBag9lQoGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635811; c=relaxed/simple;
	bh=lgVH9n5KSDDkAogk5o2CTLe2kc3l5QXU7N1XdM/Ql4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQa1mg2PvrigIXsk2wfx+lL4E3kw8zolHPr31+j0HTHeAUUaL0MTpQsfNgLRYhrwNbXWqkjBkGXppio+5by4trjgtN0KSwiY0OzC65d7L39Zn8ahtKmDR1wo/7Lm/SofpqBaD5W+muC3tL1EOv3jpce1wU2SqtLXesiHUCWvJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iqvVpcMM; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a926464-5819-440e-b558-901b6cd70788@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708635807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnVSx+UwXODNNNwTxpZJLugX3ufH5On6pQRIiSWlZsU=;
	b=iqvVpcMMZ1CRI9f8gkS8cHKIvonM73AgDM/aScTRuf02FXnGpVNHQ8nehwL9z2b9ykDr5f
	6d4FJQ7TU8gmw2Q8dDfYcf/ETF/01rbeSCJSOB5OnV3l5AcdugPYj2mJ7Tu7+7P0866sDP
	HqBQhjuz9SHNmj40zPNgMXdgIPt87fk=
Date: Thu, 22 Feb 2024 13:03:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Test case for lacking CFI
 stub functions.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240222021105.1180475-1-thinker.li@gmail.com>
 <20240222021105.1180475-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240222021105.1180475-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/21/24 6:11 PM, thinker.li@gmail.com wrote:
> +static struct bpf_test_no_cfi_ops __bpf_test_no_cfi_ops = {
> +	.fn_1 = bpf_test_no_cfi_ops__fn_1,
> +	.fn_2 = bpf_test_no_cfi_ops__fn_2,
> +};
> +
> +static struct bpf_struct_ops bpf_bpf_test_no_cif_ops = {

nit. I shortened this to test_no_cif_ops.

> +	.verifier_ops = &dummy_verifier_ops,
> +	.init = dummy_init,
> +	.init_member = dummy_init_member,
> +	.reg = dummy_reg,
> +	.unreg = dummy_unreg,
> +	.name = "bpf_test_no_cfi_ops",
> +	.owner = THIS_MODULE,
> +};
> +
> +static int bpf_test_no_cfi_init(void)
> +{
> +	int ret;
> +
> +	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
> +				      bpf_test_no_cfi_ops);
> +	if (!ret)
> +		return -EINVAL;
> +
> +	bpf_bpf_test_no_cif_ops.cfi_stubs = &__bpf_test_no_cfi_ops;
> +	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
> +				      bpf_test_no_cfi_ops);
> +	return ret;
> +}
> +
> +static void bpf_test_no_cfi_exit(void)
> +{
> +}
> +
> +module_init(bpf_test_no_cfi_init);
> +module_exit(bpf_test_no_cfi_exit);
> +
> +MODULE_AUTHOR("Kuifeng Lee");
> +MODULE_DESCRIPTION("BPF no cfi_stubs test module");
> +MODULE_LICENSE("Dual BSD/GPL");
> +
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
> new file mode 100644
> index 000000000000..f16d4dcccacf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <testing_helpers.h>
> +
> +static void load_bpf_test_no_cfi(void)
> +{
> +	int fd;
> +	int err;
> +
> +	fd = open("bpf_test_no_cfi.ko", O_RDONLY);
> +	if (!ASSERT_GT(fd, 0, "open")) {
> +		close(fd);

Removed close(fd) here. Also fixed the above ASSERT_GT test. Applied.

The patchwork has picked up the submitter name as "Thinker Lee". I fixed that up 
this time for the cover letter (the merge commit). Not sure where it came from 
and could be due to the nameless sender "from" in the email.

Please write the full name when sending out patch, e.g. "git send-email 
--from="Kui-Feng Lee <thinker.li@gmail.com>" ..."



> +		return;
> +	}
> +
> +	/* The module will try to register a struct_ops type without
> +	 *  cfi_stubs and with cfi_stubs.
> +	 *
> +	 * The one without cfi_stub should fail. The module will be loaded
> +	 * successfully only if the result of the registration is as
> +	 * expected, or it fails.
> +	 */
> +	err = finit_module(fd, "", 0);
> +	close(fd);
> +	if (!ASSERT_OK(err, "finit_module"))
> +		return;
> +
> +	err = delete_module("bpf_test_no_cfi", 0);
> +	ASSERT_OK(err, "delete_module");
> +}
> +


