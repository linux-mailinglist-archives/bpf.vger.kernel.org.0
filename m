Return-Path: <bpf+bounces-61167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B3AE1B08
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 14:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CE91C20495
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576A28B417;
	Fri, 20 Jun 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeJDd1y8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AEB28A41E
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422816; cv=none; b=BseHRKHND5Ccp+IyjcS3/gXl7+PfUNK98qkdPsxb8yoF9E+L6AWHqcJAjxf3vKzM/d6oryYOZ/8p5VvmPqkCyeWJcn6/r8N6QnnL45Sey0id8X8eeZJmoCixaFHGckETdal/2Kk9nuFSZF7RkY4c45peRPvtEiZE64rf323SqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422816; c=relaxed/simple;
	bh=/wvyHhPlc3hyTWI7QMLlyk47G10VrXSIt7+4QfqTBpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNuBkxeoSNN64xXou1klc/dCVJARVzyJhTNPvZ1FhqGEobScdwNYlWtkqGbVGIVT5GoLC40bo7ejwbqCaN7CLj77VsfBEG8MWIHhZ0qf5oiiQW9u4853d4FvjYaxYhKU0STLgxpJ76IHqbaor2gTYBlJcWTZkHAFmJoS5jp9sO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeJDd1y8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750422813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6X3/FNHRQG3hAl04vw2HAZMbBdbLJoVfk9igk1Mu60=;
	b=QeJDd1y8gliVg71IDzDiEF4SA4N5aJ559lQr/p/nlkWxocF1hjPDtogAP/YL4MM4ZASAvb
	i5s6OE4qnwyALCsVznZQSZ0wyKYAOhs+L5SpuTNy9XWwwfkruNn/epbnA17pzoOvInF9Tz
	G+/0+wCGwgp/guc0HeBtgGYSZYYFDPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-2VHndjnMPhORZopoWEfLNg-1; Fri, 20 Jun 2025 08:33:31 -0400
X-MC-Unique: 2VHndjnMPhORZopoWEfLNg-1
X-Mimecast-MFC-AGG-ID: 2VHndjnMPhORZopoWEfLNg_1750422811
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4536962204aso143595e9.3
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 05:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750422810; x=1751027610;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6X3/FNHRQG3hAl04vw2HAZMbBdbLJoVfk9igk1Mu60=;
        b=o3LMgZGLzBLArHwJrWdk/q+nOFPtQkK4PAUqfl/qiffxKjCBUuqyThZFCjPE2kKTMR
         BwPNMdDiEPHhln7EYqatB3T39WuQCmSoJX7hCsQcaJ2eNjtyTk7gh5HERiDchxkZcGPB
         pyGddzcGAoGLiGQF/oCoXOitpPq+jcDp9Qzufgn9bE/ITQuJvwXiTyVXvUWGIVj3pA0F
         MEr+Ixp6q//u9eNDPsgAY9GNdBzy6gEUW6FFkp9zN7Z7LFpEkkVwTFfyT9dmakoNWCKE
         4GpWtqBvWbGBXvVy/O289z/VHYhqhNAuzp2RL+gm/V9yWSOkPiWL3Ii48qS4PCiPK8DB
         WW1Q==
X-Gm-Message-State: AOJu0YzUG7+qUjpCUzt4zZS9QzqPx/roxWuV4nsOeuxk3JChZ978piTM
	MaRUjZbk+KjT2y1KEtGCGhb8nGok/fd2lggjD+dZASYcgw51KPkUSah9POILfvAnb/2aVdCPnfz
	Xz188Husv8U3iDKzrMKJlER565oi+IXLC+dE74AaWXH0aZ6V7w+D+vRb2bRaTvLcxsDZ/Mgwhfy
	QEaKKih/MVyo6XxJSLLRAM+0MQ3eo5BBX8Vd770dY=
X-Gm-Gg: ASbGncv9nrdhiXGsB/qFbK2vHqXsSQkpd86qxHP5RCp4XzQR3Da+bvhglfFWfmkWqEx
	Rd/jDg8NkIF9GpaseB5yfYPWr02/FHkmkPsKCPOyve48m3d9qpFtx/V70U49jjihXFviDKs9J6k
	DEb4coRwcuqa22NlAwMgpXXt2GjWvBTAgmdAZrYP6QOTzys9uCwYWXPrUkqP7uYEMDO+jqf68m1
	bH5b4z6HZvGpg8SvNoIhQ4h4DPhEM92f0C6oq5QGQi9lPNJle5vaq38vIo3EmSLiFGVKz7NXaLt
	Qx/k8lMWI+F73ALLKGPjGkoUsiNRtXUciFdoVz0iGzLNvWOml8Q=
X-Received: by 2002:a05:600c:1e8b:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-453653a3984mr26118495e9.4.1750422809947;
        Fri, 20 Jun 2025 05:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+/mYPzjbOjONfoXKdsoS7bYjrLxXYF7q9rGAxyO0DBB91oapwk55sIaTgXoQH/MTUoQBjqw==
X-Received: by 2002:a05:600c:1e8b:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-453653a3984mr26118035e9.4.1750422809365;
        Fri, 20 Jun 2025 05:33:29 -0700 (PDT)
Received: from [192.168.1.108] (ip73.213-181-144.pegonet.sk. [213.181.144.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c40dsm1994142f8f.65.2025.06.20.05.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 05:33:28 -0700 (PDT)
Message-ID: <fdbb8caa-77f6-4143-ad0b-4f32d9e6d8e6@redhat.com>
Date: Fri, 20 Jun 2025 14:33:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add tests for string
 kfuncs
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1750402154.git.vmalik@redhat.com>
 <17543560f4a1e269aec6596e72fe3fff8ef1dd2e.1750402154.git.vmalik@redhat.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <17543560f4a1e269aec6596e72fe3fff8ef1dd2e.1750402154.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 13:52, Viktor Malik wrote:
> Add both positive and negative tests cases using string kfuncs added in
> the previous patches.
> 
> Positive tests check that the functions work as expected.
> 
> Negative tests pass various incorrect strings to the kfuncs and check
> for the expected error codes:
>   -E2BIG  when passing too long strings
>   -EFAULT when trying to read inaccessible kernel memory
>   -ERANGE when passing userspace pointers on arches with non-overlapping
>           address spaces
> 
> A majority of the tests use the RUN_TESTS helper which executes BPF
> programs with BPF_PROG_TEST_RUN and check for the expected return value.
> An exception to this are tests for long strings as we need to memset the
> long string from userspace (at least I haven't found an ergonomic way to
> memset it from a BPF program), which cannot be done using the RUN_TESTS
> infrastructure.
> 
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  .../selftests/bpf/prog_tests/string_kfuncs.c  | 63 +++++++++++++++
>  .../bpf/progs/string_kfuncs_failure1.c        | 77 +++++++++++++++++++
>  .../bpf/progs/string_kfuncs_failure2.c        | 21 +++++
>  .../bpf/progs/string_kfuncs_success.c         | 35 +++++++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
>  create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>  create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
>  create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> new file mode 100644
> index 000000000000..39322f1649ea
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025 Red Hat, Inc.*/
> +#include <test_progs.h>
> +#include "string_kfuncs_success.skel.h"
> +#include "string_kfuncs_failure1.skel.h"
> +#include "string_kfuncs_failure2.skel.h"
> +#include <sys/mman.h>
> +
> +static const char * const string_kfuncs[] = {
> +	"strcmp",
> +	"strchr",
> +	"strchrnul",
> +	"strnchr",
> +	"strrchr",
> +	"strlen",
> +	"strnlen",
> +	"strspn",
> +	"strcspn",
> +	"strstr",
> +	"strnstr",
> +};
> +
> +void run_too_long_tests(void)
> +{
> +	struct string_kfuncs_failure2 *skel;
> +	struct bpf_program *prog;
> +	char test_name[256];
> +	int err, i;
> +
> +	skel = string_kfuncs_failure2__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "string_kfuncs_failure2__open_and_load"))
> +		return;
> +
> +	memset(skel->bss->long_str, 'a', sizeof(skel->bss->long_str));
> +
> +	for (i = 0; i < ARRAY_SIZE(string_kfuncs); i++) {
> +		sprintf(test_name, "test_%s_too_long", string_kfuncs[i]);
> +		if (!test__start_subtest(test_name))
> +			continue;
> +
> +		prog = bpf_object__find_program_by_name(skel->obj, test_name);
> +		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +			goto cleanup;
> +
> +		LIBBPF_OPTS(bpf_test_run_opts, topts);
> +		err = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
> +		if (!ASSERT_OK(err, "bpf_prog_test_run"))
> +			goto cleanup;
> +
> +		ASSERT_EQ(topts.retval, -E2BIG, "reading too long string fails with -E2BIG");
> +	}
> +
> +cleanup:
> +	string_kfuncs_failure2__destroy(skel);
> +}
> +
> +void test_string_kfuncs(void)
> +{
> +	RUN_TESTS(string_kfuncs_success);
> +	RUN_TESTS(string_kfuncs_failure1);
> +
> +	run_too_long_tests();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> new file mode 100644
> index 000000000000..7f03bdafd98f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025 Red Hat, Inc.*/
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <linux/limits.h>
> +#include "bpf_misc.h"
> +#include "errno.h"
> +
> +char *user_ptr = (char *)1;
> +char *invalid_kern_ptr = (char *)-1;
> +
> +/* When passing userspace pointers, the error code differs based on arch:
> + *   -ERANGE on arches with non-overlapping address spaces
> + *   -EFAULT on other arches
> + */
> +#if defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_loongarch) || \
> +    defined(__TARGET_ARCH_powerpc) || defined(__TARGET_ARCH_x86)
> +#define USER_PTR_ERR -ERANGE
> +#else
> +#define USER_PTR_ERR -EFAULT
> +#endif
> +
> +/* Passing NULL to string kfuncs (treated as a userspace ptr) */
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return bpf_strcmp(NULL, "hello"); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strrchr_null(void *ctx) { return bpf_strrchr(NULL, 'a'); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strlen_null(void *ctx) { return bpf_strlen(NULL); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strnlen_null(void *ctx) { return bpf_strnlen(NULL, 1); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strspn_null1(void *ctx) { return bpf_strspn(NULL, "hello"); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strspn_null2(void *ctx) { return bpf_strspn("hello", NULL); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcspn_null1(void *ctx) { return bpf_strcspn(NULL, "hello"); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcspn_null2(void *ctx) { return bpf_strcspn("hello", NULL); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strstr_null1(void *ctx) { return bpf_strstr(NULL, "hello"); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strstr_null2(void *ctx) { return bpf_strstr("hello", NULL); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return bpf_strnstr(NULL, "hello", 1); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
> +
> +/* Passing userspace ptr to string kfuncs */
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strrchr_user_ptr(void *ctx) { return bpf_strrchr(user_ptr, 'a'); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strlen_user_ptr(void *ctx) { return bpf_strlen(user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strnlen_user_ptr(void *ctx) { return bpf_strnlen(user_ptr, 1); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strspn_user_ptr1(void *ctx) { return bpf_strspn(user_ptr, "hello"); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strspn_user_ptr2(void *ctx) { return bpf_strspn("hello", user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcspn_user_ptr1(void *ctx) { return bpf_strcspn(user_ptr, "hello"); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcspn_user_ptr2(void *ctx) { return bpf_strcspn("hello", user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strstr_user_ptr1(void *ctx) { return bpf_strstr(user_ptr, "hello"); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strstr_user_ptr2(void *ctx) { return bpf_strstr("hello", user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr1(void *ctx) { return bpf_strnstr(user_ptr, "hello", 1); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }

For some reason, these tests are failing on s390x. I'll investigate.

Sorry for yet another faulty revision.

Viktor

> +
> +/* Passing invalid kernel ptr to string kfuncs should always return -EFAULT */
> +SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return bpf_strcmp(invalid_kern_ptr, "hello"); }
> +SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
> +SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
> +SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
> +SEC("syscall") __retval(-EFAULT) int test_strrchr_pagefault(void *ctx) { return bpf_strrchr(invalid_kern_ptr, 'a'); }
> +SEC("syscall") __retval(-EFAULT) int test_strlen_pagefault(void *ctx) { return bpf_strlen(invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strnlen_pagefault(void *ctx) { return bpf_strnlen(invalid_kern_ptr, 1); }
> +SEC("syscall") __retval(-EFAULT) int test_strspn_pagefault1(void *ctx) { return bpf_strspn(invalid_kern_ptr, "hello"); }
> +SEC("syscall") __retval(-EFAULT) int test_strspn_pagefault2(void *ctx) { return bpf_strspn("hello", invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strcspn_pagefault1(void *ctx) { return bpf_strcspn(invalid_kern_ptr, "hello"); }
> +SEC("syscall") __retval(-EFAULT) int test_strcspn_pagefault2(void *ctx) { return bpf_strcspn("hello", invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strstr_pagefault1(void *ctx) { return bpf_strstr(invalid_kern_ptr, "hello"); }
> +SEC("syscall") __retval(-EFAULT) int test_strstr_pagefault2(void *ctx) { return bpf_strstr("hello", invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault1(void *ctx) { return bpf_strnstr(invalid_kern_ptr, "hello", 1); }
> +SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault2(void *ctx) { return bpf_strnstr("hello", invalid_kern_ptr, 1); }
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> new file mode 100644
> index 000000000000..685d221d8aa0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025 Red Hat, Inc.*/
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <linux/limits.h>
> +
> +char long_str[XATTR_SIZE_MAX + 1];
> +
> +SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
> +SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
> +SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
> +SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
> +SEC("syscall") int test_strrchr_too_long(void *ctx) { return bpf_strrchr(long_str, 'b'); }
> +SEC("syscall") int test_strlen_too_long(void *ctx) { return bpf_strlen(long_str); }
> +SEC("syscall") int test_strnlen_too_long(void *ctx) { return bpf_strnlen(long_str, sizeof(long_str)); }
> +SEC("syscall") int test_strspn_too_long(void *ctx) { return bpf_strspn(long_str, "a"); }
> +SEC("syscall") int test_strcspn_too_long(void *ctx) { return bpf_strcspn(long_str, "b"); }
> +SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str, "hello"); }
> +SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> new file mode 100644
> index 000000000000..d0e94921e811
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025 Red Hat, Inc.*/
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char str[] = "hello world";
> +
> +#define __test(retval) SEC("syscall") __success __retval(retval)
> +
> +/* Functional tests */
> +__test(0) int test_strcmp_eq(void *ctx) { return bpf_strcmp(str, "hello world"); }
> +__test(1) int test_strcmp_neq(void *ctx) { return bpf_strcmp(str, "hello"); }
> +__test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
> +__test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
> +__test(-1) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }
> +__test(1) int test_strchrnul_found(void *ctx) { return bpf_strchrnul(str, 'e'); }
> +__test(11) int test_strchrnul_notfound(void *ctx) { return bpf_strchrnul(str, 'x'); }
> +__test(1) int test_strnchr_found(void *ctx) { return bpf_strnchr(str, 5, 'e'); }
> +__test(11) int test_strnchr_null(void *ctx) { return bpf_strnchr(str, 12, '\0'); }
> +__test(-1) int test_strnchr_notfound(void *ctx) { return bpf_strnchr(str, 5, 'w'); }
> +__test(9) int test_strrchr_found(void *ctx) { return bpf_strrchr(str, 'l'); }
> +__test(-1) int test_strrchr_notfound(void *ctx) { return bpf_strrchr(str, 'x'); }
> +__test(11) int test_strlen(void *ctx) { return bpf_strlen(str); }
> +__test(11) int test_strnlen(void *ctx) { return bpf_strnlen(str, 12); }
> +__test(5) int test_strspn(void *ctx) { return bpf_strspn(str, "ehlo"); }
> +__test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
> +__test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "world"); }
> +__test(-1) int test_strstr_notfound(void *ctx) { return bpf_strstr(str, "hi"); }
> +__test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, ""); }
> +__test(0) int test_strnstr_found(void *ctx) { return bpf_strnstr(str, "hello", 6); }
> +__test(-1) int test_strnstr_notfound(void *ctx) { return bpf_strnstr(str, "hi", 10); }
> +__test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, "", 1); }
> +
> +char _license[] SEC("license") = "GPL";


