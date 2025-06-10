Return-Path: <bpf+bounces-60212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47EAD4049
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD1F18942EE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA87245020;
	Tue, 10 Jun 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="liGWDznj"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56224394B
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575836; cv=none; b=pADwA51OzolRyCnXFYA7SgJP4DwAj1sBiwt2o9Cox/qotnwUmH7hihylBJNLXNzqZWz3fWApbr9YX5q/wVcA0TiOi6ScXN+x6DuBVuN7h1KYp8cJm860EblEa3t6oIJHGegSIopOtnCRF48ioIbW/7Xg5gmfXynW45Zub5SwQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575836; c=relaxed/simple;
	bh=7qWvqWj2EPLfEU+9olEuqM3aOuZT6KWZE0lgk7JeiA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGCBsAGvjlbFUw6zvO4kF+iheqhyl3qnVYgHne9A89BH8h8Bd6BSiKDjHKDBRuC4su083D71PD8G5ZN11QjF3jcpcqYvordXWVYCLAwZdgWOpvS5yu3aLOu3ZEzQDATc81l5uAwpZr+JSVVVdvzuyCffuNo3f1vnQ8ZV2jj+lZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=liGWDznj; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <32cb1c74-4a15-491b-90b0-6c2fdf07dbb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749575821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6TLYW+X+ICRdTEemlhyxVV2i9XawqfMflRijJ5ErnI=;
	b=liGWDznjsQnZfLpkxO80cgofTbJIluw5YkqYn3LOMjUkDS6Cc/lgdz5QYubeluHK1gfl1w
	OYvcnObecHhkbw6WXGUTf1sW+AbmjjUyD0utX3oi2mwJhcRnnu6RTDzQkumwVHtGgwaEC1
	QuaXoip0XSi1hYKg1Z89iFSZyX+h47w=
Date: Tue, 10 Jun 2025 10:16:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] selftests/bpf: Convert test_sysctl to prog_tests
Content-Language: en-GB
To: Jerome Marchand <jmarchan@redhat.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20250527165412.533335-1-jmarchan@redhat.com>
 <20250610091933.717824-1-jmarchan@redhat.com>
 <20250610091933.717824-3-jmarchan@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250610091933.717824-3-jmarchan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/10/25 2:19 AM, Jerome Marchand wrote:
> Convert test_sysctl test to prog_tests with minimal change to the
> tests themselves.
>
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> ---
>   tools/testing/selftests/bpf/.gitignore        |  1 -
>   tools/testing/selftests/bpf/Makefile          |  5 ++-
>   .../bpf/{ => prog_tests}/test_sysctl.c        | 32 ++++---------------
>   3 files changed, 9 insertions(+), 29 deletions(-)
>   rename tools/testing/selftests/bpf/{ => prog_tests}/test_sysctl.c (98%)
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index e2a2c46c008b1..3d8378972d26c 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -21,7 +21,6 @@ test_lirc_mode2_user
>   flow_dissector_load
>   test_tcpnotify_user
>   test_libbpf
> -test_sysctl
>   xdping
>   test_cpp
>   *.d
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 66bb50356be08..53dc08d905bd1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -70,7 +70,7 @@ endif
>   # Order correspond to 'make run_tests' order
>   TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
>   	test_sockmap \
> -	test_tcpnotify_user test_sysctl \
> +	test_tcpnotify_user \
>   	test_progs-no_alu32
>   TEST_INST_SUBDIRS := no_alu32
>   
> @@ -215,7 +215,7 @@ ifeq ($(VMLINUX_BTF),)
>   $(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
>   endif
>   
> -# Define simple and short `make test_progs`, `make test_sysctl`, etc targets
> +# Define simple and short `make test_progs`, `make test_maps`, etc targets
>   # to build individual tests.
>   # NOTE: Semicolon at the end is critical to override lib.mk's default static
>   # rule for binaries.
> @@ -324,7 +324,6 @@ NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
>   $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>   $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
>   $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> -$(OUTPUT)/test_sysctl: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>   $(OUTPUT)/test_tag: $(TESTING_HELPERS)
>   $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
>   $(OUTPUT)/xdping: $(TESTING_HELPERS)
> diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
> similarity index 98%
> rename from tools/testing/selftests/bpf/test_sysctl.c
> rename to tools/testing/selftests/bpf/prog_tests/test_sysctl.c
> index bcdbd27f22f08..049671361f8fa 100644
> --- a/tools/testing/selftests/bpf/test_sysctl.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_sysctl.c
> @@ -1,22 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (c) 2019 Facebook
>   
> -#include <fcntl.h>
> -#include <stdint.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -
> -#include <linux/filter.h>
> -
> -#include <bpf/bpf.h>
> -#include <bpf/libbpf.h>
> -
> -#include <bpf/bpf_endian.h>
> -#include "bpf_util.h"
> +#include "test_progs.h"
>   #include "cgroup_helpers.h"
> -#include "testing_helpers.h"
>   
>   #define CG_PATH			"/foo"
>   #define MAX_INSNS		512
> @@ -1608,26 +1594,22 @@ static int run_tests(int cgfd)
>   	return fails ? -1 : 0;
>   }
>   
> -int main(int argc, char **argv)
> +void test_sysctl(void)
>   {
>   	int cgfd = -1;

-1 is not needed.

> -	int err = 0;
>   
>   	cgfd = cgroup_setup_and_join(CG_PATH);
> -	if (cgfd < 0)
> -		goto err;
> +	if (CHECK_FAIL(cgfd < 0))

Use ASSERT* macros. For example, if (!ASSERT_OK_FD(cgfd, "create cgroup"))

> +		goto out;
>   
>   	/* Use libbpf 1.0 API mode */
>   	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);

This is not needed.

>   
> -	if (run_tests(cgfd))
> -		goto err;
> +	if (CHECK_FAIL(run_tests(cgfd)))

if (!ASSERT_OK(run_tests(cgfd), "run_tests"))

> +		goto out;
>   
> -	goto out;
> -err:
> -	err = -1;
>   out:
>   	close(cgfd);
>   	cleanup_cgroup_environment();
> -	return err;
> +	return;
>   }

