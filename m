Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1804C6814E8
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 16:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbjA3PXW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 10:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbjA3PXV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 10:23:21 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8B5256
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 07:23:20 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id s4so10301964qtx.6
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 07:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MraxqRQ68LFHUX1McL+nlN1S1rrmkgDdTIiOGxV452w=;
        b=3OfFLoKFSY8NGLZIrkmg5qndGuNjDvObgvREs6j/1fELboa3ZGK9H/UdTruu9nHAFz
         VtSYexRAfHQ+T/G+tAg94ChfM9yXusE21rK3GkTOJvEMjmryNGjq7RsklW1jrnygAaIw
         t7V8CmJkqhcy1OR2TRajLVJRvF6vFcWZebjNmQejrhAf+57cHyT2LgyQenozWkDNT4N/
         g/UIWmtRGW23dW7+eLImJrC4XrreoB2snqnr1d0+8QD64naGcJHSONfGRp8FbIxJh31c
         7RhMj93itJEYI4HL+shVSQWQ/whKKLAod6k8GXT6vOx3A8YJr3R3RHoHGb3PuPJGnjIz
         aa2A==
X-Gm-Message-State: AO0yUKVE9+lQ/QK5RWqF1ofkotCh8d1zjw6Vg3Jzct9I74UwPYZfyjGc
        ozzj3ex1SGxbefCixiAIgsU=
X-Google-Smtp-Source: AK7set8hbdOOc0yFa9BdbEQ39FY5elaqXuTAUjAJfbwKn3eahF9IxU+KQK71jAoxDXa+4pXyZa4gRg==
X-Received: by 2002:a05:622a:c9:b0:3b8:6bef:61c5 with SMTP id p9-20020a05622a00c900b003b86bef61c5mr5148161qtw.63.1675092199374;
        Mon, 30 Jan 2023 07:23:19 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a140900b0071c9eea2056sm3807492qkj.14.2023.01.30.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:23:19 -0800 (PST)
Date:   Mon, 30 Jan 2023 09:23:16 -0600
From:   David Vernet <void@manifault.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCHv2 bpf-next 2/7] selftests/bpf: Move test_progs helpers to
 testing_helpers object
Message-ID: <Y9fg5ErTG2xaYlV8@maniforge>
References: <20230130085540.410638-1-jolsa@kernel.org>
 <20230130085540.410638-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130085540.410638-3-jolsa@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 09:55:35AM +0100, Jiri Olsa wrote:
> Moving test_progs helpers to testing_helpers object so they can be
> used from test_verifier in following changes.
> 
> Also adding missing ifndef header guard to testing_helpers.h header.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/test_progs.c      | 67 +------------------
>  tools/testing/selftests/bpf/test_progs.h      |  1 -
>  tools/testing/selftests/bpf/testing_helpers.c | 63 +++++++++++++++++
>  tools/testing/selftests/bpf/testing_helpers.h | 10 +++
>  4 files changed, 75 insertions(+), 66 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 6d5e3022c75f..a150c35516ef 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -11,7 +11,6 @@
>  #include <signal.h>
>  #include <string.h>
>  #include <execinfo.h> /* backtrace */
> -#include <linux/membarrier.h>
>  #include <sys/sysinfo.h> /* get_nprocs */
>  #include <netinet/in.h>
>  #include <sys/select.h>
> @@ -616,68 +615,6 @@ int extract_build_id(char *build_id, size_t size)
>  	return -1;
>  }
>  
> -static int finit_module(int fd, const char *param_values, int flags)
> -{
> -	return syscall(__NR_finit_module, fd, param_values, flags);
> -}
> -
> -static int delete_module(const char *name, int flags)
> -{
> -	return syscall(__NR_delete_module, name, flags);
> -}
> -
> -/*
> - * Trigger synchronize_rcu() in kernel.
> - */
> -int kern_sync_rcu(void)
> -{
> -	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
> -}
> -
> -static void unload_bpf_testmod(void)
> -{
> -	if (kern_sync_rcu())
> -		fprintf(env.stderr, "Failed to trigger kernel-side RCU sync!\n");
> -	if (delete_module("bpf_testmod", 0)) {
> -		if (errno == ENOENT) {
> -			if (verbose())
> -				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
> -			return;
> -		}
> -		fprintf(env.stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> -		return;
> -	}
> -	if (verbose())
> -		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
> -}
> -
> -static int load_bpf_testmod(void)
> -{
> -	int fd;
> -
> -	/* ensure previous instance of the module is unloaded */
> -	unload_bpf_testmod();
> -
> -	if (verbose())
> -		fprintf(stdout, "Loading bpf_testmod.ko...\n");
> -
> -	fd = open("bpf_testmod.ko", O_RDONLY);
> -	if (fd < 0) {
> -		fprintf(env.stderr, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
> -		return -ENOENT;
> -	}
> -	if (finit_module(fd, "", 0)) {
> -		fprintf(env.stderr, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
> -		close(fd);
> -		return -EINVAL;
> -	}
> -	close(fd);
> -
> -	if (verbose())
> -		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
> -	return 0;
> -}
> -
>  /* extern declarations for test funcs */
>  #define DEFINE_TEST(name)				\
>  	extern void test_##name(void) __weak;		\
> @@ -1655,7 +1592,7 @@ int main(int argc, char **argv)
>  	env.stderr = stderr;
>  
>  	env.has_testmod = true;
> -	if (!env.list_test_names && load_bpf_testmod()) {
> +	if (!env.list_test_names && load_bpf_testmod(env.stderr, verbose())) {
>  		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
>  		env.has_testmod = false;
>  	}
> @@ -1754,7 +1691,7 @@ int main(int argc, char **argv)
>  	close(env.saved_netns_fd);
>  out:
>  	if (!env.list_test_names && env.has_testmod)
> -		unload_bpf_testmod();
> +		unload_bpf_testmod(env.stderr, verbose());
>  
>  	free_test_selector(&env.test_selector);
>  	free_test_selector(&env.subtest_selector);
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index d5d51ec97ec8..b9dac3c32712 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -390,7 +390,6 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
>  int compare_map_keys(int map1_fd, int map2_fd);
>  int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
>  int extract_build_id(char *build_id, size_t size);
> -int kern_sync_rcu(void);
>  int trigger_module_test_read(int read_sz);
>  int trigger_module_test_write(int write_sz);
>  int write_sysctl(const char *sysctl, const char *value);
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index 9695318e8132..c0eb54bf08b3 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -8,6 +8,7 @@
>  #include <bpf/libbpf.h>
>  #include "test_progs.h"
>  #include "testing_helpers.h"
> +#include <linux/membarrier.h>
>  
>  int parse_num_list(const char *s, bool **num_set, int *num_set_len)
>  {
> @@ -229,3 +230,65 @@ int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
>  
>  	return bpf_prog_load(type, NULL, license, insns, insns_cnt, &opts);
>  }
> +
> +static int finit_module(int fd, const char *param_values, int flags)
> +{
> +	return syscall(__NR_finit_module, fd, param_values, flags);
> +}
> +
> +static int delete_module(const char *name, int flags)
> +{
> +	return syscall(__NR_delete_module, name, flags);
> +}
> +
> +void unload_bpf_testmod(FILE *err, bool verbose)

Maybe you should pass a const struct test_env * here and in
load_bpf_testmod() instead?  Technically it also has a FILE *stdout, so
to be consistent we should probably also pass that to the fprintf()
calls on the success path.

> +{
> +	if (kern_sync_rcu())
> +		fprintf(err, "Failed to trigger kernel-side RCU sync!\n");
> +	if (delete_module("bpf_testmod", 0)) {
> +		if (errno == ENOENT) {
> +			if (verbose)
> +				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
> +			return;
> +		}
> +		fprintf(err, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> +		return;
> +	}
> +	if (verbose)
> +		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
> +}
> +
> +int load_bpf_testmod(FILE *err, bool verbose)
> +{
> +	int fd;
> +
> +	/* ensure previous instance of the module is unloaded */
> +	unload_bpf_testmod(err, verbose);
> +
> +	if (verbose)
> +		fprintf(stdout, "Loading bpf_testmod.ko...\n");
> +
> +	fd = open("bpf_testmod.ko", O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(err, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
> +		return -ENOENT;
> +	}
> +	if (finit_module(fd, "", 0)) {
> +		fprintf(err, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
> +		close(fd);
> +		return -EINVAL;
> +	}
> +	close(fd);
> +
> +	if (verbose)
> +		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
> +	return 0;
> +}
> +
> +/*
> + * Trigger synchronize_rcu() in kernel.
> + */
> +int kern_sync_rcu(void)
> +{
> +	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
> +}
> diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
> index 6ec00bf79cb5..2f80ca5b5f54 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.h
> +++ b/tools/testing/selftests/bpf/testing_helpers.h
> @@ -1,5 +1,9 @@
>  /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>  /* Copyright (C) 2020 Facebook, Inc. */
> +
> +#ifndef __TRACING_HELPERS_H
> +#define __TRACING_HELPERS_H

s/__TRACING/__TESTING here and below

> +
>  #include <stdbool.h>
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
> @@ -20,3 +24,9 @@ struct test_filter_set;
>  int parse_test_list(const char *s,
>  		    struct test_filter_set *test_set,
>  		    bool is_glob_pattern);
> +
> +int load_bpf_testmod(FILE *err, bool verbose);
> +void unload_bpf_testmod(FILE *err, bool verbose);
> +int kern_sync_rcu(void);
> +
> +#endif /* __TRACING_HELPERS_H */
> -- 
> 2.39.1
> 
