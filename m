Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A828C4DB4AB
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357174AbiCPPQL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 11:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357238AbiCPPPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 11:15:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7581149F3A
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 08:14:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e5b04a061cso8289687b3.2
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V4bHZijQgEznuUks8NHrP2jey0PKU7DgD1oQp2BjnAw=;
        b=fMdGv6AlMW+tMTsp85O/kLqBMk9ZZW758IB7+MXYEk+Pak5G/wP8x1sknr5ZrQJNtK
         Nkdxr88LIRNpTtlgTEPEMEE+2yp1b/7M03CAhbwlCrcr1Y7TdF+5VFQZzP5o9YgHVZDE
         rocqP7Zb344371CmAp/OPQ7s+dTLKbHTR1pWRy+WQ7/VQZwOjdPPfOTG1N+ihMusqw4L
         qWvLevXZBZ+i2Ey6yWZs3GtJNxZH1g78wjuGzGnphfQ8bXGhO2zl4bAv1zp5vuCOkq55
         eemFuSaL+/bh9TO9tIcVUpP1BLhotOQaKgxzwkF0j73DeAxbhNDfRf3GA9F3TqGmpPSa
         nmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V4bHZijQgEznuUks8NHrP2jey0PKU7DgD1oQp2BjnAw=;
        b=jRZaWxWPYUSO5a/b6EMUb+1M76utkvoSLrcIRWGO/f6j60LGaR1ZH+XVWCfi20IuKG
         e3E+Q6BHDrmAW/EVeekbxDftDtOuKvU9de8hg9NyWJdGo68uJy3XL29K3Jve4gbXBOve
         Py1gLHNVjXsQ+RUmDBM2AvET09GHdb396NZXErb2cRK0WXBYK7ins4FX2l/UknOjIdJO
         j8t4fIYuIn5hqHV7ZH7MzWJjEELSlJB+Q9w6unX38tvQa4W3lMCHYXwar8EfcEPfYMA5
         69G7QbYyOACtvcAaDf8D+9cYLAsRe6sZMA62Rd9DVLcaFfEsOoaAa7i/J1uYiuNMb1Qr
         //lw==
X-Gm-Message-State: AOAM531N+LKgI3AsoAwSzPkz9r3Qva9+MK9GKAouir8zDTZ/FcqN9oGT
        /p/XbjO8Ukr0H9y7oj5K0zM1hYs=
X-Google-Smtp-Source: ABdhPJw4T0QQhf4bT1kJxMfQVEO4NUx6e8CvykghFQ7bJiAPXCNktag/hlGlXbrSHXalnRXrBvM2fcM=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:7b90:b9e5:45d7:73d1])
 (user=sdf job=sendgmr) by 2002:a25:7493:0:b0:628:7593:edcc with SMTP id
 p141-20020a257493000000b006287593edccmr294284ybc.621.1647443644308; Wed, 16
 Mar 2022 08:14:04 -0700 (PDT)
Date:   Wed, 16 Mar 2022 08:14:02 -0700
In-Reply-To: <20220316014900.2258022-1-kafai@fb.com>
Message-Id: <YjH+usi73AlX/6Sn@google.com>
Mime-Version: 1.0
References: <20220316014841.2255248-1-kafai@fb.com> <20220316014900.2258022-1-kafai@fb.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: selftests: Remove libcap usage from test_progs
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/15, Martin KaFai Lau wrote:
> This patch removes the libcap usage from test_progs.
> bind_perm.c is the only user.  cap_*_effective() helpers added in the
> earlier patch are directly used instead.

> No other selftest binary is using libcap, so '-lcap' is also removed
> from the Makefile.

> Cc: Stanislav Fomichev <sdf@google.com>

LGTM!

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |  5 ++-
>   .../selftests/bpf/prog_tests/bind_perm.c      | 45 ++++---------------
>   2 files changed, 12 insertions(+), 38 deletions(-)

> diff --git a/tools/testing/selftests/bpf/Makefile  
> b/tools/testing/selftests/bpf/Makefile
> index 1c6e55740019..11f5883636c3 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -25,7 +25,7 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS)  
> $(SAN_CFLAGS)	\
>   	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
>   	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>   LDFLAGS += $(SAN_CFLAGS)
> -LDLIBS += -lcap -lelf -lz -lrt -lpthread
> +LDLIBS += -lelf -lz -lrt -lpthread

>   # Silence some warnings when compiled with clang
>   ifneq ($(LLVM),)
> @@ -480,7 +480,8 @@ TRUNNER_TESTS_DIR := prog_tests
>   TRUNNER_BPF_PROGS_DIR := progs
>   TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
>   			 network_helpers.c testing_helpers.c		\
> -			 btf_helpers.c flow_dissector_load.h
> +			 btf_helpers.c flow_dissector_load.h		\
> +			 cap_helpers.c
>   TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
>   		       ima_setup.sh					\
>   		       $(wildcard progs/btf_dump_test_case_*.c)
> diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c  
> b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
> index eac71fbb24ce..6562b5fdcf1e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bind_perm.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
> @@ -4,9 +4,10 @@
>   #include <stdlib.h>
>   #include <sys/types.h>
>   #include <sys/socket.h>
> -#include <sys/capability.h>
> +#include <linux/capability.h>

>   #include "test_progs.h"
> +#include "cap_helpers.h"
>   #include "bind_perm.skel.h"

>   static int duration;
> @@ -49,41 +50,11 @@ void try_bind(int family, int port, int  
> expected_errno)
>   		close(fd);
>   }

> -bool cap_net_bind_service(cap_flag_value_t flag)
> -{
> -	const cap_value_t cap_net_bind_service = CAP_NET_BIND_SERVICE;
> -	cap_flag_value_t original_value;
> -	bool was_effective = false;
> -	cap_t caps;
> -
> -	caps = cap_get_proc();
> -	if (CHECK(!caps, "cap_get_proc", "errno %d", errno))
> -		goto free_caps;
> -
> -	if (CHECK(cap_get_flag(caps, CAP_NET_BIND_SERVICE, CAP_EFFECTIVE,
> -			       &original_value),
> -		  "cap_get_flag", "errno %d", errno))
> -		goto free_caps;
> -
> -	was_effective = (original_value == CAP_SET);
> -
> -	if (CHECK(cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_net_bind_service,
> -			       flag),
> -		  "cap_set_flag", "errno %d", errno))
> -		goto free_caps;
> -
> -	if (CHECK(cap_set_proc(caps), "cap_set_proc", "errno %d", errno))
> -		goto free_caps;
> -
> -free_caps:
> -	CHECK(cap_free(caps), "cap_free", "errno %d", errno);
> -	return was_effective;
> -}
> -
>   void test_bind_perm(void)
>   {
> -	bool cap_was_effective;
> +	const __u64 net_bind_svc_cap = 1ULL << CAP_NET_BIND_SERVICE;
>   	struct bind_perm *skel;
> +	__u64 old_caps = 0;
>   	int cgroup_fd;

>   	if (create_netns())
> @@ -105,7 +76,8 @@ void test_bind_perm(void)
>   	if (!ASSERT_OK_PTR(skel, "bind_v6_prog"))
>   		goto close_skeleton;

> -	cap_was_effective = cap_net_bind_service(CAP_CLEAR);
> +	ASSERT_OK(cap_disable_effective(net_bind_svc_cap, &old_caps),
> +		  "cap_disable_effective");

>   	try_bind(AF_INET, 110, EACCES);
>   	try_bind(AF_INET6, 110, EACCES);
> @@ -113,8 +85,9 @@ void test_bind_perm(void)
>   	try_bind(AF_INET, 111, 0);
>   	try_bind(AF_INET6, 111, 0);

> -	if (cap_was_effective)
> -		cap_net_bind_service(CAP_SET);
> +	if (old_caps & net_bind_svc_cap)
> +		ASSERT_OK(cap_enable_effective(net_bind_svc_cap, NULL),
> +			  "cap_enable_effective");

>   close_skeleton:
>   	bind_perm__destroy(skel);
> --
> 2.30.2

