Return-Path: <bpf+bounces-17395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854580C9CC
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94239B21312
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45D3B78F;
	Mon, 11 Dec 2023 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHh9D6WC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F0B4
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:30:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b5155e154so51866795e9.3
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297836; x=1702902636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIWohrhMx9OnsKknAdIgawnRuqnSFWAWz1wjSpmqfF8=;
        b=lHh9D6WC2AyyB1FZAOVVXC6W3NY2T8pqFlH6BcM8FdHcnw7O1xNOimy2CY5Isj7cfl
         /UiuhSXORjuKUb0fytKGrMBXGXqn1NwXuIQJ5OQjotUhvS+QEOYgh0kuk89ES3vfgzVL
         pvjuLXMB2+g54584wMFhgnzrqpiMgX4Psjhrz/bPsJP+s+0FifwyhXBgNjHoxBs02MQD
         J+u5epbuMAwEEjOsw41ii2h9UThhLaOLph+1xITp2UlNiQPhNb0vfxl2f2+9ROH+r0/G
         qiznYqUAeFsEPwc1xXFfyZ7eap8OlJPvUqJtK/sqDfLa0jPME2k0hcmX0Miw2713wKhD
         RO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297836; x=1702902636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIWohrhMx9OnsKknAdIgawnRuqnSFWAWz1wjSpmqfF8=;
        b=FVK/ydt9gKscjf4Wr2Y4eAXlcPnKiCjaTOeJ0IqbKNRK1eKiCNRslHtOVU/fa3ALah
         JNt+MNpT9sP6yndSs9dAAQyh0vFvKQTdoTTily2Hbxz52/wxqg7zMiGzstaF3cNE5Bco
         RZk9AdxHiUHaGm2clopLwp9exs/GH8EN47nhkv3+Eel9J/s3cGHxOP5xniVyV0qeQbwV
         yZhWLMNU6JNz6T1ttq2JrrRZViZKcLo+OgggdMVCh+kMcmTdf+Z2pc6fjDbn8O1DEBEw
         U+ndRFxI6apwvtrT2DlcXjOxu1GxokTITgFoxu0YAlWPPaHBblDFA9LvL0C8eMdhGqMo
         9lcQ==
X-Gm-Message-State: AOJu0Yxwn/TovuUb4E23BVtx4AOe0Kl/eIZQRY/lSNwdBi1CdMjEw4u2
	j1l8OOZBkqD8YwsRA/N0E30=
X-Google-Smtp-Source: AGHT+IGLSBY27xm+VJ26h60drnTr3B3p6YQGYzLWi2kz+VX8n3J2YQSxyWO7STXmWDRZavuweUgq8A==
X-Received: by 2002:a05:600c:1ca7:b0:40c:3742:5a9 with SMTP id k39-20020a05600c1ca700b0040c374205a9mr1863418wms.177.1702297835959;
        Mon, 11 Dec 2023 04:30:35 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b0040b2a52ecaasm15049721wms.2.2023.12.11.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:30:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Dec 2023 13:30:33 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v7 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
Message-ID: <ZXcA6Z3IWVH1xPk_@krava>
References: <20231208185557.8477-1-9erthalion6@gmail.com>
 <20231208185557.8477-3-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208185557.8477-3-9erthalion6@gmail.com>

On Fri, Dec 08, 2023 at 07:55:54PM +0100, Dmitrii Dolgov wrote:
> Verify the fact that only one fentry prog could be attached to another
> fentry, building up an attachment chain of limited size. Use existing
> bpf_testmod as a start of the chain.
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Changes in v5:
>     - Test only one level of attachment
> 
>  .../bpf/prog_tests/recursive_attach.c         | 69 +++++++++++++++++++
>  .../selftests/bpf/progs/fentry_recursive.c    | 19 +++++
>  .../bpf/progs/fentry_recursive_target.c       | 20 ++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> new file mode 100644
> index 000000000000..7248d0661ee9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Red Hat, Inc. */
> +#include <test_progs.h>
> +#include "fentry_recursive.skel.h"
> +#include "fentry_recursive_target.skel.h"
> +#include <bpf/btf.h>
> +#include "bpf/libbpf_internal.h"
> +
> +/*
> + * Test following scenarios:
> + * - attach one fentry progs to another one
> + * - more than one nesting levels are not allowed
> + */
> +void test_recursive_fentry_attach(void)
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
> +		if (i == 0) {
> +			prog = tracing_chain[0]->progs.recursive_attach;
> +			prev_fd = bpf_program__fd(target_skel->progs.test1);
> +			err = bpf_program__set_attach_target(prog, prev_fd, "test1");
> +		} else {
> +			prog = tracing_chain[i]->progs.recursive_attach;

nit, common line, could be placed before the loop

perhaps also the bpf_program__set_attach_target call does not need to be
in the if path, I think it should work with NULL for attach_func_name as
long as we provide attach_prog_fd

I wonder now with just 2 skels the test might be easier to read
without the loop, but I dont have strong opinion about that

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
> diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive.c b/tools/testing/selftests/bpf/progs/fentry_recursive.c
> new file mode 100644
> index 000000000000..1df490230344
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fentry_recursive.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Red Hat, Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u64 test1_result = 0;

there's no reason to keep test1_result in here, please remove

> +
> +/*
> + * Dummy fentry bpf prog for testing fentry attachment chains
> + */
> +SEC("fentry/XXX")
> +int BPF_PROG(recursive_attach, int a)
> +{
> +	test1_result = a == 1;
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> new file mode 100644
> index 000000000000..b6fb8ebd598d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Red Hat, Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u64 test1_result = 0;

ditto

thanks,
jirka

> +
> +/*
> + * Dummy fentry bpf prog for testing fentry attachment chains. It's going to be
> + * a start of the chain.
> + */
> +SEC("fentry/bpf_testmod_fentry_test1")
> +int BPF_PROG(test1, int a)
> +{
> +	test1_result = a == 1;
> +	return 0;
> +}
> -- 
> 2.41.0
> 

