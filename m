Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3844C68DBF5
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjBGOpw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 09:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjBGOpX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 09:45:23 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B457688
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 06:44:59 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id m16so3406075qvm.4
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 06:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdS1yAveEGuiVbA6qFHiWmjpMpWURG5+WN9+8zY4Kn8=;
        b=iEh7rcwIoGz0xFuS2S9fEDPj+OB06ZsIblumB4qn57SA1RLTHOB4HK+K4Wch3DJsuh
         2xHkX3ndcjkCl1wJ/jduwqfkZYdDv5fWxu7Jt40QOeTEy0ZFlVS8i+JHLGGVV5YVVth8
         CFGhC8g36tonbk/HyYAaKaJ1CG3igsp+xtzTleg7F4FUBcZi5hgdIXYj7KVGYiea9BnX
         jqAzbH/Yg4W/+Busjfj91v1aq52fyTqhob3drrW3fgWfWJfs5eVaqr5P8wer2z2bUOcP
         kGamH2ER+OYWuLzY8G1UL6fmvuBqCK8QkaJHjU68oEfbYVyq2uDSJGkp5jJ0FcTh8XL+
         rDLw==
X-Gm-Message-State: AO0yUKVsOMVH3OEwh1P7TTMkY3qITS1H5ep/tz2eZ0fzw2mHnZosorZ4
        36zYa44JoUlhk5CfUuT0cVA=
X-Google-Smtp-Source: AK7set8Xe5U01JhAuog5FkehyHEUxHLWSubWel3MqAz1+11RmD6w8TKDGpSfScyl4w9Zm1ZSOFmasA==
X-Received: by 2002:a05:6214:21e1:b0:54f:b7e9:182 with SMTP id p1-20020a05621421e100b0054fb7e90182mr5796115qvj.45.1675781098127;
        Tue, 07 Feb 2023 06:44:58 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:9bc3])
        by smtp.gmail.com with ESMTPSA id b9-20020a05620a270900b0071df8b60681sm9575933qkp.94.2023.02.07.06.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:44:57 -0800 (PST)
Date:   Tue, 7 Feb 2023 08:45:01 -0600
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
Subject: Re: [PATCHv3 bpf-next 5/9] selftests/bpf: Use un/load_bpf_testmod
 functions in tests
Message-ID: <Y+Jj7XLhbz4AacIL@maniforge.lan>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203162336.608323-6-jolsa@kernel.org>
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

On Fri, Feb 03, 2023 at 05:23:32PM +0100, Jiri Olsa wrote:
> Now that we have un/load_bpf_testmod helpers in testing_helpers.h,
> we can use it in other tests and save some lines.
> 
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/bpf_mod_race.c   | 34 +++----------------
>  .../selftests/bpf/prog_tests/module_attach.c  | 12 +++----
>  tools/testing/selftests/bpf/testing_helpers.c |  7 ++--
>  tools/testing/selftests/bpf/testing_helpers.h |  2 +-
>  4 files changed, 14 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
> index a4d0cc9d3367..fe2c502e5089 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
> @@ -11,6 +11,7 @@
>  #include "ksym_race.skel.h"
>  #include "bpf_mod_race.skel.h"
>  #include "kfunc_call_race.skel.h"
> +#include "testing_helpers.h"
>  
>  /* This test crafts a race between btf_try_get_module and do_init_module, and
>   * checks whether btf_try_get_module handles the invocation for a well-formed
> @@ -44,35 +45,10 @@ enum bpf_test_state {
>  
>  static _Atomic enum bpf_test_state state = _TS_INVALID;
>  
> -static int sys_finit_module(int fd, const char *param_values, int flags)
> -{
> -	return syscall(__NR_finit_module, fd, param_values, flags);
> -}
> -
> -static int sys_delete_module(const char *name, unsigned int flags)
> -{
> -	return syscall(__NR_delete_module, name, flags);
> -}
> -
> -static int load_module(const char *mod)
> -{
> -	int ret, fd;
> -
> -	fd = open("bpf_testmod.ko", O_RDONLY);
> -	if (fd < 0)
> -		return fd;
> -
> -	ret = sys_finit_module(fd, "", 0);
> -	close(fd);
> -	if (ret < 0)
> -		return ret;
> -	return 0;
> -}
> -
>  static void *load_module_thread(void *p)
>  {
>  
> -	if (!ASSERT_NEQ(load_module("bpf_testmod.ko"), 0, "load_module_thread must fail"))
> +	if (!ASSERT_NEQ(load_bpf_testmod(false), 0, "load_module_thread must fail"))
>  		atomic_store(&state, TS_MODULE_LOAD);
>  	else
>  		atomic_store(&state, TS_MODULE_LOAD_FAIL);
> @@ -124,7 +100,7 @@ static void test_bpf_mod_race_config(const struct test_config *config)
>  	if (!ASSERT_NEQ(fault_addr, MAP_FAILED, "mmap for uffd registration"))
>  		return;
>  
> -	if (!ASSERT_OK(sys_delete_module("bpf_testmod", 0), "unload bpf_testmod"))
> +	if (!ASSERT_OK(unload_bpf_testmod(false), "unload bpf_testmod"))
>  		goto end_mmap;
>  
>  	skel = bpf_mod_race__open();
> @@ -202,8 +178,8 @@ static void test_bpf_mod_race_config(const struct test_config *config)
>  	bpf_mod_race__destroy(skel);
>  	ASSERT_OK(kern_sync_rcu(), "kern_sync_rcu");
>  end_module:
> -	sys_delete_module("bpf_testmod", 0);
> -	ASSERT_OK(load_module("bpf_testmod.ko"), "restore bpf_testmod");
> +	unload_bpf_testmod(false);
> +	ASSERT_OK(load_bpf_testmod(false), "restore bpf_testmod");
>  end_mmap:
>  	munmap(fault_addr, 4096);
>  	atomic_store(&state, _TS_INVALID);
> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> index 7fc01ff490db..f53d658ed080 100644
> --- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> @@ -4,6 +4,7 @@
>  #include <test_progs.h>
>  #include <stdbool.h>
>  #include "test_module_attach.skel.h"
> +#include "testing_helpers.h"
>  
>  static int duration;
>  
> @@ -32,11 +33,6 @@ static int trigger_module_test_writable(int *val)
>  	return 0;
>  }
>  
> -static int delete_module(const char *name, int flags)
> -{
> -	return syscall(__NR_delete_module, name, flags);
> -}
> -
>  void test_module_attach(void)
>  {
>  	const int READ_SZ = 456;
> @@ -93,21 +89,21 @@ void test_module_attach(void)
>  	if (!ASSERT_OK_PTR(link, "attach_fentry"))
>  		goto cleanup;
>  
> -	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
> +	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
>  	bpf_link__destroy(link);
>  
>  	link = bpf_program__attach(skel->progs.handle_fexit);
>  	if (!ASSERT_OK_PTR(link, "attach_fexit"))
>  		goto cleanup;
>  
> -	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
> +	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
>  	bpf_link__destroy(link);
>  
>  	link = bpf_program__attach(skel->progs.kprobe_multi);
>  	if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
>  		goto cleanup;
>  
> -	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
> +	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
>  	bpf_link__destroy(link);
>  
>  cleanup:
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index 3872c36c17d4..030ed157954e 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -241,7 +241,7 @@ static int delete_module(const char *name, int flags)
>  	return syscall(__NR_delete_module, name, flags);
>  }
>  
> -void unload_bpf_testmod(bool verbose)
> +int unload_bpf_testmod(bool verbose)
>  {
>  	if (kern_sync_rcu())
>  		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");

Per my question in [0], I'd be curious to know what the deal is with
this synchronize_rcu(). If it's actually important, it seems like we
should also return an error here if it fails. Otherwise, it should
probably just live in bpf_testmod_exit(). A comment explaining why it's
necessary seems useful regardless of where it is as well.

[0]: https://lore.kernel.org/bpf/Y+JiUQFyalc0aV6M@maniforge.lan/

> @@ -249,13 +249,14 @@ void unload_bpf_testmod(bool verbose)
>  		if (errno == ENOENT) {
>  			if (verbose)
>  				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
> -			return;
> +			return -1;
>  		}
>  		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
> -		return;
> +		return -1;
>  	}
>  	if (verbose)
>  		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
> +	return 0;
>  }
>  
>  int load_bpf_testmod(bool verbose)
> diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
> index 7356474def27..713f8e37163d 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.h
> +++ b/tools/testing/selftests/bpf/testing_helpers.h
> @@ -26,7 +26,7 @@ int parse_test_list(const char *s,
>  		    bool is_glob_pattern);
>  
>  int load_bpf_testmod(bool verbose);
> -void unload_bpf_testmod(bool verbose);
> +int unload_bpf_testmod(bool verbose);
>  int kern_sync_rcu(void);
>  
>  #endif /* __TESTING_HELPERS_H */
> -- 
> 2.39.1
> 
