Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1D68DBD5
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 15:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjBGOkm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 09:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjBGOkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 09:40:16 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2223D902
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 06:38:53 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id w3so16853668qts.7
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 06:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUAkL3bNP347RRBNYsZblLgighof1YBn9pUm9y8+Oqk=;
        b=5Z7udY68kNKCbT5VD1XX52n/Abpr/ViI5MxCV01+TdbxkE7hxLGZC77iAGwdvEg3CE
         4dJkl67vRhbauyU1EtsaYIg0ZuwHxpivfGNuVGeJP3HKI247fAWajxG5lUSGktFOFvNB
         Am20Yo1f6Xg6/vqtbxuoP+r7JynaIMKV/1hvDM+kdHFl4EXoY27XlJXwepOpM6Okr41i
         EC+PBSNafLIhOsNOEGikpNYD9qLoEKtCmKG71B91UaFQMQWhT1l2bTLbDw2hNuQGSPh8
         19jzKvc4rtEA86oSvYAwl0nZD8FBkGDyMfLuKD+x1NO4Ice9wK4RSGnwZflWD+BzSUyB
         pfHg==
X-Gm-Message-State: AO0yUKUFoo6L4RAirHA5oQVRXmgBI0pkndyPGKleRqF3E6OQtCxgu59I
        oRwKXOdE5s/MsmCN6AdHY7Q=
X-Google-Smtp-Source: AK7set9WekcdT7Tm1C9KqXqUtwo7lFnhhiQutHmbw0BRE3HKGmtRU8xlDHwf+JYG/GFV7f/sxP121w==
X-Received: by 2002:ac8:5c8a:0:b0:3b9:da90:ebee with SMTP id r10-20020ac85c8a000000b003b9da90ebeemr5930565qta.30.1675780685806;
        Tue, 07 Feb 2023 06:38:05 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:9bc3])
        by smtp.gmail.com with ESMTPSA id o28-20020ac8429c000000b003b880ef08acsm9528100qtl.35.2023.02.07.06.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:38:05 -0800 (PST)
Date:   Tue, 7 Feb 2023 08:38:09 -0600
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
Subject: Re: [PATCHv3 bpf-next 2/9] selftests/bpf: Move test_progs helpers to
 testing_helpers object
Message-ID: <Y+JiUQFyalc0aV6M@maniforge.lan>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203162336.608323-3-jolsa@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 05:23:29PM +0100, Jiri Olsa wrote:
> Moving test_progs helpers to testing_helpers object so they can be
> used from test_verifier in following changes.
> 
> Also adding missing ifndef header guard to testing_helpers.h header.
> 
> Using stderr instead of env.stderr because un/load_bpf_testmod helpers
> will be used outside test_progs. Also at the point of calling them
> in test_progs the std files are not hijacked yet and stderr is the
> same as env.stderr.

Makes sense. Possibly something to clean up at another time but given
that we were being inconsistent with env.stdout and env.stderr in
load_bpf_testmod() in the first place, this seems totally fine.

Acked-by: David Vernet <void@manifault.com>

Left one question about kern_sync_rcu() below that need not block this
patch series, and can be addressed in a follow-up if it's even relevant.

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
> index 6d5e3022c75f..39ceb6a1bfc6 100644
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
> +	if (!env.list_test_names && load_bpf_testmod(verbose())) {
>  		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
>  		env.has_testmod = false;
>  	}
> @@ -1754,7 +1691,7 @@ int main(int argc, char **argv)
>  	close(env.saved_netns_fd);
>  out:
>  	if (!env.list_test_names && env.has_testmod)
> -		unload_bpf_testmod();
> +		unload_bpf_testmod(verbose());
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
> index 9695318e8132..3a9e7e8e5b14 100644
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
> +void unload_bpf_testmod(bool verbose)
> +{
> +	if (kern_sync_rcu())
> +		fprintf(stderr, "Failed to trigger kernel-side RCU sync!\n");

I realize there's no behavior change here, but out of curiosity, do you
know why we need a synchronize_rcu() here? In general this feels kind of
sketchy, and like something we should just put in bpf_testmod_exit() if
it's really needed for something in the kernel.

> +	if (delete_module("bpf_testmod", 0)) {
> +		if (errno == ENOENT) {
> +			if (verbose)
> +				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
> +			return;
> +		}
> +		fprintf(stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> +		return;
> +	}
> +	if (verbose)
> +		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
> +}
> +
> +int load_bpf_testmod(bool verbose)
> +{
> +	int fd;
> +
> +	/* ensure previous instance of the module is unloaded */
> +	unload_bpf_testmod(verbose);
> +
> +	if (verbose)
> +		fprintf(stdout, "Loading bpf_testmod.ko...\n");
> +
> +	fd = open("bpf_testmod.ko", O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
> +		return -ENOENT;
> +	}
> +	if (finit_module(fd, "", 0)) {
> +		fprintf(stderr, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
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
> index 6ec00bf79cb5..7356474def27 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.h
> +++ b/tools/testing/selftests/bpf/testing_helpers.h
> @@ -1,5 +1,9 @@
>  /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>  /* Copyright (C) 2020 Facebook, Inc. */
> +
> +#ifndef __TESTING_HELPERS_H
> +#define __TESTING_HELPERS_H
> +
>  #include <stdbool.h>
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
> @@ -20,3 +24,9 @@ struct test_filter_set;
>  int parse_test_list(const char *s,
>  		    struct test_filter_set *test_set,
>  		    bool is_glob_pattern);
> +
> +int load_bpf_testmod(bool verbose);
> +void unload_bpf_testmod(bool verbose);
> +int kern_sync_rcu(void);
> +
> +#endif /* __TESTING_HELPERS_H */
> -- 
> 2.39.1
> 
