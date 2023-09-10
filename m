Return-Path: <bpf+bounces-9608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEFE799D91
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980981C20856
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606923D0;
	Sun, 10 Sep 2023 09:53:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9EA49
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 09:53:14 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29407CCD
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 02:53:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so37113665e9.1
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 02:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694339590; x=1694944390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUG94auQHlvGu6nQ/AL21rjXOsnd8OWnJRzVGuY9kbk=;
        b=O0w3D0kofqsNh/JCxdJF8x23VhUFUPjWhZj6DNa3y7d0+kCWBoLBznjqGAftSqD84e
         y4CnPv+1EJQX0h950odOTwTLkRrH7DEz6LQVMWEcT4EZSr5J6qsCWdMP0XWSBih51XBA
         /jNOraBcttustq9A0OQe5OdS9FjRXKyv3SfteJaS8Mbg/eW8iBBZBiBsqANs8DaONuZR
         CobxwgMg8WoYPCke66G4JV+LQLD/87zdEgKXkYFNTGy3W633LwwhMSXzTvSRKtTWywKh
         RNuYuXVdRsYWl5r8mNXFeUkRVqjyY/4gCKGyACmRwZEbF909fgvKLKImdSFSXZhfMgYf
         yKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694339590; x=1694944390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUG94auQHlvGu6nQ/AL21rjXOsnd8OWnJRzVGuY9kbk=;
        b=uwCNEqQKdcYlhWRECyLJHmHBCNzVQ6Asf+7jBMftob+rpzOSNhdtZyCaLANT0/hs/Z
         PJlWVZqA1YFMryp7owpBjLeKsFTbynDvJxhDzN6xa1HpoLPU/gCP6LOEMXUguSR/OKec
         84kXdn4ANM7dNvPPsw673XgjDLPJJ0/iD5xOZUEpnp0OntfmlrT5r0De3BVjynfyllVk
         uLNlzX8G9e1jwXZmu0PN5bOxBMM/6B1t57fCA5KzQS4SFkqujSB6KUkMxBbLnS2gC8GN
         eC+0YSBK19ZmM8cz+mlYnvJJcCHEYEy9Lu4MIDCI9KoG1sloslBRZC30/WWtX6+sLpEN
         bF0w==
X-Gm-Message-State: AOJu0Ywp+d/4aEW+y+6enjnCF69Xfgdv7QyfQuDLOecA/ENKjOuP2pL4
	ZKSkamv5uyOt1qAN4XIblQesLLCsEjg=
X-Google-Smtp-Source: AGHT+IE/U+Vlu94CgkwCPkdW2K9Z/xXRcGz4mL99ZoXvx4hXbXNVOsVI/OobqWM8YJ8qQCMcOE+MbA==
X-Received: by 2002:a1c:4c1a:0:b0:3fa:8db4:91ec with SMTP id z26-20020a1c4c1a000000b003fa8db491ecmr5549467wmf.10.1694339589870;
        Sun, 10 Sep 2023 02:53:09 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcd0b000000b003fee53feab5sm6790463wmj.10.2023.09.10.02.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 02:53:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 10 Sep 2023 11:53:07 +0200
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, alan.maguire@oracle.com, olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for symbol
 versioning for uprobe
Message-ID: <ZP2SA0ZWhh8t820l@krava>
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
 <20230905151257.729192-4-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905151257.729192-4-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 03:12:57PM +0000, Hengqi Chen wrote:
> This exercises the newly added dynsym symbol versioning logics.
> Now we accept symbols in form of func, func@LIB_VERSION or
> func@@LIB_VERSION.
> 
> The test rely on liburandom_read.so. For liburandom_read.so, we have:
> 
>     $ nm -D liburandom_read.so
>                      w __cxa_finalize@GLIBC_2.17
>                      w __gmon_start__
>                      w _ITM_deregisterTMCloneTable
>                      w _ITM_registerTMCloneTable
>     0000000000000000 A LIBURANDOM_READ_1.0.0
>     0000000000000000 A LIBURANDOM_READ_2.0.0
>     000000000000081c T urandlib_api@@LIBURANDOM_READ_2.0.0
>     0000000000000814 T urandlib_api@LIBURANDOM_READ_1.0.0
>     0000000000000824 T urandlib_api_sameoffset@LIBURANDOM_READ_1.0.0
>     0000000000000824 T urandlib_api_sameoffset@@LIBURANDOM_READ_2.0.0
>     000000000000082c T urandlib_read_without_sema@@LIBURANDOM_READ_1.0.0
>     00000000000007c4 T urandlib_read_with_sema@@LIBURANDOM_READ_1.0.0
>     0000000000011018 D urandlib_read_with_sema_semaphore@@LIBURANDOM_READ_1.0.0
> 
> For `urandlib_api`, specifying `urandlib_api` will cause a conflict because
> there are two symbols named urandlib_api and both are global bind.
> For `urandlib_api_sameoffset`, there are also two symbols in the .so, but
> both are at the same offset and essentially they refer to the same function
> so no conflict.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

one nit below, but looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  tools/testing/selftests/bpf/Makefile          |  5 +-
>  .../testing/selftests/bpf/liburandom_read.map | 15 +++
>  .../testing/selftests/bpf/prog_tests/uprobe.c | 95 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_uprobe.c | 61 ++++++++++++
>  tools/testing/selftests/bpf/urandom_read.c    |  9 ++
>  .../testing/selftests/bpf/urandom_read_lib1.c | 41 ++++++++
>  6 files changed, 224 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/liburandom_read.map
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_uprobe.c
> 

SNIP

> +void test_uprobe(void)
> +{
> +	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> +	struct test_uprobe *skel;
> +	FILE *urand_pipe = NULL;
> +	int urand_pid = 0, err;
> +
> +	skel = test_uprobe__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	urand_pipe = urand_spawn(&urand_pid);
> +	if (!ASSERT_OK_PTR(urand_pipe, "urand_spawn"))
> +		goto cleanup;
> +
> +	skel->bss->my_pid = urand_pid;
> +
> +	/* Manual attach uprobe to urandlib_api
> +	 * There are two `urandlib_api` symbols in .dynsym section:
> +	 *   - urandlib_api@LIBURANDOM_READ_1.0.0
> +	 *   - urandlib_api@LIBURANDOM_READ_1.0.0

nit, should that be version 2.0.0?               ^

> +	 * Both are global bind and would cause a conflict if user
> +	 * specify the symbol name without a version suffix
> +	 */
> +	uprobe_opts.func_name = "urandlib_api";
> +	skel->links.test4 = bpf_program__attach_uprobe_opts(skel->progs.test4,
> +							    urand_pid,
> +							    "./liburandom_read.so",
> +							    0 /* offset */,
> +							    &uprobe_opts);
> +	if (!ASSERT_ERR_PTR(skel->links.test4, "urandlib_api_attach_conflict"))
> +		goto cleanup;
> +
> +	uprobe_opts.func_name = "urandlib_api@LIBURANDOM_READ_1.0.0";
> +	skel->links.test4 = bpf_program__attach_uprobe_opts(skel->progs.test4,
> +							    urand_pid,
> +							    "./liburandom_read.so",
> +							    0 /* offset */,
> +							    &uprobe_opts);
> +	if (!ASSERT_OK_PTR(skel->links.test4, "urandlib_api_attach_ok"))
> +		goto cleanup;
> +
> +	/* Auto attach 3 uprobes to urandlib_api_sameoffset */
> +	err = test_uprobe__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	/* trigger urandom_read */
> +	ASSERT_OK(urand_trigger(&urand_pipe), "urand_exit_code");
> +
> +	ASSERT_EQ(skel->bss->test1_result, 1, "urandlib_api_sameoffset");
> +	ASSERT_EQ(skel->bss->test2_result, 1, "urandlib_api_sameoffset@v1");
> +	ASSERT_EQ(skel->bss->test3_result, 1, "urandlib_api_sameoffset@@v2");
> +	ASSERT_EQ(skel->bss->test4_result, 1, "urandlib_api");
> +
> +cleanup:
> +	if (urand_pipe)
> +		pclose(urand_pipe);
> +	test_uprobe__destroy(skel);
> +}

SNIP

