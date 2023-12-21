Return-Path: <bpf+bounces-18553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15B81BDE1
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 19:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6C91F22C18
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251D964A86;
	Thu, 21 Dec 2023 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce+05KGr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9964A80
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c2308faedso12087405e9.1
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 10:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703181744; x=1703786544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gvXN0NHtG/1lJwpiS8SYhodcmqjSBIq30TbPaGEuA5E=;
        b=ce+05KGrX8cK3rEyHSlJasangXbMf4blGGq98/bPLra9jF39S5pimb6CVdzOK2S8p6
         ISzgx/KfyyCtPt5tHsZjWzB7yvEBOQdOrvoUsRXUopYgRXo9zoGD6NZvsUoeU4cwkAAQ
         kia0DCxT3aD2bNJU8vk2hM7qXdOMZ2UHXY3umfvPwPymEhPPDmJlJnuJ9ZyO68Sydw2A
         oWyrsDwZjN55tQ0UKxv9AHW5IjmB2iDbQoeIuD+lK0cjEdSUnOTLQmUEBj3yghhJDaoG
         Xfn4kMKJ84emZYyIvORArUTEnRmPEz6X6JnG4tjzUIQuTE+gO9zW9Hgb9IDGDx90/q8n
         i+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181744; x=1703786544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvXN0NHtG/1lJwpiS8SYhodcmqjSBIq30TbPaGEuA5E=;
        b=IZGldErBuUxY/bn/RgeORFOaOjhWim2oy1mwkERHIpooPv9/D12SwLLBj52PEDTS1A
         VvoxpnRbJ/2aJ3Irh97XhIDp6vV8EYH9kBM/q/+5XwIWldtVxS5SFkTP6lx8JZpokYYt
         q3PTMwGCF2NRnW7BZKpo7UT6ut8WsRmxB2qZK603ikevfMQ9g+WoeXau5PDCG31CNmp6
         QNWaEjb5hA5nTGBj6mhOaQXhw1C9XrlTlcgsdaDECcM35jCKjvoC0wmJW5uMSW2qprOX
         UBqm+XcAgO9uYto6dRxK4vZtRieNLk3vY5CNyDvssCACnoct2RTxHza0sbqxV9HsYkgy
         6EJw==
X-Gm-Message-State: AOJu0YyNS4rxVnmFJqSGbRnJHR+rzFXhbBBm0y9iRNyEXQUCB2SHu7zx
	q+2Q/c8IhiINK9Bhqrq6lN0=
X-Google-Smtp-Source: AGHT+IGcN3UasxFG1PsGG5OJ7SpzDCVPSGY2hdGBTRoWwlb86kdtoI7cY/txRM19Dih6W3WU8WuAPw==
X-Received: by 2002:a05:600c:1f13:b0:40d:347c:67e0 with SMTP id bd19-20020a05600c1f1300b0040d347c67e0mr46779wmb.109.1703181743919;
        Thu, 21 Dec 2023 10:02:23 -0800 (PST)
Received: from krava (cst-prg-70-88.cust.vodafone.cz. [46.135.70.88])
        by smtp.gmail.com with ESMTPSA id az1-20020a05600c600100b0040b5517ae31sm12169700wmb.6.2023.12.21.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:02:23 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Dec 2023 19:02:18 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v10 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
Message-ID: <ZYR9qqKNheExCCIP@krava>
References: <20231220180422.8375-1-9erthalion6@gmail.com>
 <20231220180422.8375-3-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220180422.8375-3-9erthalion6@gmail.com>

On Wed, Dec 20, 2023 at 07:04:17PM +0100, Dmitrii Dolgov wrote:
> Verify the fact that only one fentry prog could be attached to another
> fentry, building up an attachment chain of limited size. Use existing
> bpf_testmod as a start of the chain.
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Changes in v10:
>     - Add tests for loading tracing progs without attaching, and
>       detaching tracing progs.
> 
> Changes in v8:
>     - Cleanup test bpf progs and the content of first/second condition
>       in the loop.
> 
> Changes in v5:
>     - Test only one level of attachment
> 
>  .../bpf/prog_tests/recursive_attach.c         | 192 ++++++++++++++++++
>  .../selftests/bpf/progs/fentry_recursive.c    |  16 ++
>  .../bpf/progs/fentry_recursive_target.c       |  17 ++
>  3 files changed, 225 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> new file mode 100644
> index 000000000000..4b46dc358925
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Red Hat, Inc. */
> +#include <test_progs.h>
> +#include "fentry_recursive.skel.h"
> +#include "fentry_recursive_target.skel.h"
> +#include <bpf/btf.h>
> +#include "bpf/libbpf_internal.h"
> +
> +/*
> + * Test that recursive attachment of tracing progs with more than one nesting
> + * level is not possible. Create a chain of attachment, verify that the last
> + * prog will fail.
> + */
> +void test_recursive_fentry_attach(void)
> +{

please use subtests for multiple tests in one object,
check for example the test_kprobe_multi_test

jirka

> +	struct fentry_recursive_target *target_skel = NULL;
> +	struct fentry_recursive *tracing_chain[2] = {};
> +	struct bpf_program *prog;
> +	int prev_fd, err;
> +
> +	target_skel = fentry_recursive_target__open_and_load();
> +	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
> +		goto close_prog;
> +
> +	/* Create an attachment chain with two fentry progs */
> +	for (int i = 0; i < 2; i++) {
> +		tracing_chain[i] = fentry_recursive__open();
> +		if (!ASSERT_OK_PTR(tracing_chain[i], "fentry_recursive__open"))
> +			goto close_prog;
> +
> +		/*
> +		 * The first prog in the chain is going to be attached to the target
> +		 * fentry program, the second one to the previous in the chain.
> +		 */
> +		prog = tracing_chain[i]->progs.recursive_attach;
> +		if (i == 0) {
> +			prev_fd = bpf_program__fd(target_skel->progs.test1);
> +			err = bpf_program__set_attach_target(prog, prev_fd, "test1");
> +		} else {
> +			prev_fd = bpf_program__fd(tracing_chain[i-1]->progs.recursive_attach);
> +			err = bpf_program__set_attach_target(prog, prev_fd, "recursive_attach");
> +		}
> +
> +		if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +			goto close_prog;
> +
> +		err = fentry_recursive__load(tracing_chain[i]);
> +		/* The first attach should succeed, the second fail */
> +		if (i == 0) {
> +			if (!ASSERT_OK(err, "fentry_recursive__load"))
> +				goto close_prog;
> +
> +			err = fentry_recursive__attach(tracing_chain[i]);
> +			if (!ASSERT_OK(err, "fentry_recursive__attach"))
> +				goto close_prog;
> +		} else {
> +			if (!ASSERT_ERR(err, "fentry_recursive__load"))
> +				goto close_prog;
> +		}
> +	}
> +
> +close_prog:
> +	fentry_recursive_target__destroy(target_skel);
> +	for (int i = 0; i < 2; i++) {
> +		if (tracing_chain[i])
> +			fentry_recursive__destroy(tracing_chain[i]);
> +	}
> +}
> +
> +/*
> + * Test that recursive loading of tracing progs with more than one nesting
> + * level is not possible either. Identical to the previous one, but without
> + * fentry attach.
> + */
> +void test_recursive_fentry_load(void)
> +{
> +	struct fentry_recursive_target *target_skel = NULL;
> +	struct fentry_recursive *tracing_chain[2] = {};
> +	struct bpf_program *prog;
> +	int prev_fd, err;
> +
> +	target_skel = fentry_recursive_target__open_and_load();
> +	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
> +		goto close_prog;
> +
> +	/* Create an attachment chain with two fentry progs */
> +	for (int i = 0; i < 2; i++) {
> +		tracing_chain[i] = fentry_recursive__open();
> +		if (!ASSERT_OK_PTR(tracing_chain[i], "fentry_recursive__open"))
> +			goto close_prog;
> +
> +		/*
> +		 * The first prog in the chain is going to be attached to the target
> +		 * fentry program, the second one to the previous in the chain.
> +		 */
> +		prog = tracing_chain[i]->progs.recursive_attach;
> +		if (i == 0) {
> +			prev_fd = bpf_program__fd(target_skel->progs.test1);
> +			err = bpf_program__set_attach_target(prog, prev_fd, "test1");
> +		} else {
> +			prev_fd = bpf_program__fd(tracing_chain[i-1]->progs.recursive_attach);
> +			err = bpf_program__set_attach_target(prog, prev_fd, "recursive_attach");
> +		}
> +
> +		if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +			goto close_prog;
> +
> +		err = fentry_recursive__load(tracing_chain[i]);
> +		/* The first attach should succeed, the second fail */
> +		if (i == 0) {
> +			if (!ASSERT_OK(err, "fentry_recursive__load"))
> +				goto close_prog;
> +		} else {
> +			if (!ASSERT_ERR(err, "fentry_recursive__load"))
> +				goto close_prog;
> +		}
> +	}
> +
> +close_prog:
> +	fentry_recursive_target__destroy(target_skel);
> +	for (int i = 0; i < 2; i++) {
> +		if (tracing_chain[i])
> +			fentry_recursive__destroy(tracing_chain[i]);
> +	}
> +}
> +
> +/*
> + * Test that attach_tracing_prog flag will be set throughout the whole
> + * lifecycle of an fentry prog, independently from whether it's detached.
> + */
> +void test_recursive_fentry_detach(void)
> +{
> +	struct fentry_recursive_target *target_skel = NULL;
> +	struct fentry_recursive *tracing_chain[2] = {};
> +	struct bpf_program *prog;
> +	int prev_fd, err;
> +
> +	/* Load the target fentry */
> +	target_skel = fentry_recursive_target__open_and_load();
> +	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
> +		goto close_prog;
> +
> +	/* Create an attachment chain with two fentry progs */
> +	for (int i = 0; i < 2; i++) {
> +		tracing_chain[i] = fentry_recursive__open();
> +		if (!ASSERT_OK_PTR(tracing_chain[i], "fentry_recursive__open"))
> +			goto close_prog;
> +
> +		/*
> +		 * The first prog in the chain is going to be attached to the target
> +		 * fentry program, the second one to the previous in the chain.
> +		 */
> +		prog = tracing_chain[i]->progs.recursive_attach;
> +		if (i == 0) {
> +			prev_fd = bpf_program__fd(target_skel->progs.test1);
> +			err = bpf_program__set_attach_target(prog, prev_fd, "test1");
> +		} else {
> +			prev_fd = bpf_program__fd(tracing_chain[i-1]->progs.recursive_attach);
> +			err = bpf_program__set_attach_target(prog, prev_fd, "recursive_attach");
> +		}
> +
> +		if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +			goto close_prog;
> +
> +		err = fentry_recursive__load(tracing_chain[i]);
> +		/* The first attach should succeed, the second fail */
> +		if (i == 0) {
> +			if (!ASSERT_OK(err, "fentry_recursive__load"))
> +				goto close_prog;
> +
> +			err = fentry_recursive__attach(tracing_chain[i]);
> +			if (!ASSERT_OK(err, "fentry_recursive__attach"))
> +				goto close_prog;
> +
> +			/*
> +			 * Flag attach_tracing_prog should still be set, preventing
> +			 * attachment of the following prog.
> +			 */
> +			fentry_recursive__detach(tracing_chain[i]);
> +		} else {
> +			if (!ASSERT_ERR(err, "fentry_recursive__load"))
> +				goto close_prog;
> +		}
> +	}
> +
> +close_prog:
> +	fentry_recursive_target__destroy(target_skel);
> +	for (int i = 0; i < 2; i++) {
> +		if (tracing_chain[i])
> +			fentry_recursive__destroy(tracing_chain[i]);
> +	}
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive.c b/tools/testing/selftests/bpf/progs/fentry_recursive.c
> new file mode 100644
> index 000000000000..b9e4d35ac597
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fentry_recursive.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Red Hat, Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +/*
> + * Dummy fentry bpf prog for testing fentry attachment chains
> + */
> +SEC("fentry/XXX")
> +int BPF_PROG(recursive_attach, int a)
> +{
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> new file mode 100644
> index 000000000000..6e0b5c716f8e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Red Hat, Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +/*
> + * Dummy fentry bpf prog for testing fentry attachment chains. It's going to be
> + * a start of the chain.
> + */
> +SEC("fentry/bpf_testmod_fentry_test1")
> +int BPF_PROG(test1, int a)
> +{
> +	return 0;
> +}
> -- 
> 2.41.0
> 

