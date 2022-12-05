Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BA3643605
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 21:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLEUtW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 15:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiLEUtW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 15:49:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C429345
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 12:49:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 125-20020a1c0283000000b003d076ee89d6so10162993wmc.0
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 12:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6c5kZ4mbENkzBajeiqQsMs+/WZSSRlXswkFG94va0s=;
        b=lZEDTQTQzEH9xXupx1IeHKR8TK17X04FtfbC2pWuVZ4kiS4ejTjJtv8dAcF7qJ2u1Z
         ekwgG6lN1WfYig87kLe0lesEjblRbbORjMq6i3B1X/Hnm8Xd0g0XC+wOqSmGMtXpR3Kf
         /EWPNcrS2Y9dg92IwOf66FOr9CBiC4kVY9MveNaZ/cMSB8GT2OPLuB//IknmtKyqSjEs
         kplq+lay4aaX60CQHJ5HC7NsGc1Z39ap8PoEeKgOdgWK/tS6l2/If8r85JDtfcJlpLC5
         C+AJB6oq1pAgMExjIS9+AXWvRduttsAi3yWvjJhGsLACm+I1uCfv8tg5AuwqHmtgFZ2b
         lyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6c5kZ4mbENkzBajeiqQsMs+/WZSSRlXswkFG94va0s=;
        b=P01bqVlI2vpatF5ciFeyZuKG+Dx0Hai/cxLdSd/89spkQQg2iv4QeM5ymaKwosJstZ
         62ecQaSLV8IuHfhZswmvwmgAwdrByBYXybFyyCqsnjAzkWrnzRwRmuEZ672TSbWLj6Uy
         dNYPYTSfpSsHxLMSI6Ei23WmXV1+xMr9tDy0rukfomDHWmNJ47JloVAxAQeP7Mga+BCp
         juEf6uNvJdsaAsmYQOEObnHwMTlxpCZnP9M4Jll/VzdmEyIDpqe3J0LSl+/jKS4ZmLuk
         hGml6mlE3Vyop3t1IfTCea7MBhBU4dDOtWIpfo/LvXDiAZrxAUGxQzmvRmNFZ/3SdCIK
         K+lA==
X-Gm-Message-State: ANoB5plPmAYBnv8ql7XTIsA86CWJ4uTtac92KJN2BpuaJfmT2IvHuumC
        2E5ylCPqWOcpQ/pL1g4HzAk=
X-Google-Smtp-Source: AA0mqf6IzbaVPcxS3GTQejrUpn/hkcmFHjIik3ibKLsq7yyTPir3AN77txyg3X00SnT8rXpbLlfrPQ==
X-Received: by 2002:a05:600c:19cc:b0:3cf:7bdd:e014 with SMTP id u12-20020a05600c19cc00b003cf7bdde014mr55819765wmq.1.1670273359413;
        Mon, 05 Dec 2022 12:49:19 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l11-20020a1ced0b000000b003b3307fb98fsm18079514wmh.24.2022.12.05.12.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:49:18 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 5 Dec 2022 21:49:16 +0100
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf/selftests: Test fentry attachment to
 shadowed functions
Message-ID: <Y45ZTDBNR/NiWMPn@krava>
References: <cover.1670249590.git.vmalik@redhat.com>
 <db2560ea17db7c207a4de31fb84f0ccd5435245f.1670249590.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db2560ea17db7c207a4de31fb84f0ccd5435245f.1670249590.git.vmalik@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 05, 2022 at 04:26:06PM +0100, Viktor Malik wrote:
> Adds a new test that tries to attach a program to fentry of two
> functions of the same name, one located in vmlinux and the other in
> bpf_testmod.
> 
> To avoid conflicts with existing tests, a new function
> "bpf_fentry_shadow_test" was created both in vmlinux and in bpf_testmod.
> 
> The previous commit fixed a bug which caused this test to fail. The
> verifier would always use the vmlinux function's address as the target
> trampoline address, hence trying to attach two programs to the same
> trampoline.

hi
looks good, few nits below

> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  net/bpf/test_run.c                            |   5 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   7 +
>  .../bpf/prog_tests/module_attach_shadow.c     | 124 ++++++++++++++++++
>  3 files changed, 136 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 6094ef7cffcd..71e36a85573b 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -536,6 +536,11 @@ int noinline bpf_modify_return_test(int a, int *b)
>  	return a + *b;
>  }
>  
> +int noinline bpf_fentry_shadow_test(int a)
> +{
> +	return a + 1;
> +}
> +
>  u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
>  {
>  	return a + b + c + d;
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 5085fea3cac5..d23127a5ec68 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -229,6 +229,13 @@ static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
>  	.set   = &bpf_testmod_check_kfunc_ids,
>  };
>  
> +noinline int bpf_fentry_shadow_test(int a)
> +{
> +	return a + 2;
> +}
> +EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
> +ALLOW_ERROR_INJECTION(bpf_fentry_shadow_test, ERRNO);

why marked as ALLOW_ERROR_INJECTION?

> +
>  extern int bpf_fentry_test1(int a);
>  
>  static int bpf_testmod_init(void)
> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
> new file mode 100644
> index 000000000000..bf511e61ec1f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Red Hat */
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "bpf/libbpf_internal.h"
> +#include "cgroup_helpers.h"
> +
> +static const char *module_name = "bpf_testmod";
> +static const char *symbol_name = "bpf_fentry_shadow_test";
> +
> +int get_bpf_testmod_btf_fd(void)

should be static?

> +{
> +	struct bpf_btf_info info;
> +	char name[64];
> +	__u32 id = 0, len;
> +	int err, fd;
> +
> +	while (true) {
> +		err = bpf_btf_get_next_id(id, &id);
> +		if (err) {
> +			log_err("failed to iterate BTF objects");
> +			return err;
> +		}
> +
> +		fd = bpf_btf_get_fd_by_id(id);
> +		if (fd < 0) {

I was checking how's libbpf doing this and found load_module_btfs,
which seems similar.. and it has one additional check in here:

                        if (errno == ENOENT)
                                continue; /* expected race: BTF was unloaded */

I guess it's not likely, but it's better to have it


SNIP

> +	btf_id[0] = btf__find_by_name_kind(vmlinux_btf, symbol_name, BTF_KIND_FUNC);
> +	if (!ASSERT_GT(btf_id[0], 0, "btf_find_by_name"))
> +		goto out;
> +
> +	btf_id[1] = btf__find_by_name_kind(mod_btf, symbol_name, BTF_KIND_FUNC);
> +	if (!ASSERT_GT(btf_id[1], 0, "btf_find_by_name"))
> +		goto out;
> +
> +	for (i = 0; i < 2; i++) {
> +		load_opts.attach_btf_id = btf_id[i];
> +		load_opts.attach_btf_obj_fd = btf_fd[i];
> +		prog_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
> +					   trace_program,
> +					   sizeof(trace_program) / sizeof(struct bpf_insn),
> +					   &load_opts);
> +		if (!ASSERT_GE(prog_fd[i], 0, "bpf_prog_load"))
> +			goto out;
> +
> +		link_fd[i] = bpf_link_create(prog_fd[i], 0, BPF_TRACE_FENTRY, NULL);
> +		if (!ASSERT_GE(link_fd[i], 0, "bpf_link_create"))
> +			goto out;

so IIUC the issue is that without the previous fix this will create
2 separate trampolines pointing to single address.. and we can have
just one trampoline for address.. so the 2nd trampoline update will
fail, because the trampoline location is already changed/taken ?

could you please put some description like that in the comment or
changelog?

thanks,
jirka

> +	}
> +
> +	err = bpf_prog_test_run_opts(prog_fd[0], &test_opts);
> +	ASSERT_OK(err, "running test");
> +
> +out:
> +	if (vmlinux_btf)
> +		btf__free(vmlinux_btf);
> +	if (mod_btf)
> +		btf__free(mod_btf);
> +	for (i = 0; i < 2; i++) {
> +		if (btf_fd[i])
> +			close(btf_fd[i]);
> +		if (prog_fd[i])
> +			close(prog_fd[i]);
> +		if (link_fd[i])
> +			close(link_fd[i]);
> +	}
> +}
> -- 
> 2.38.1
> 
