Return-Path: <bpf+bounces-19023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD468242D0
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6621C23E93
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64772233C;
	Thu,  4 Jan 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELfDU5Hd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88595224C0;
	Thu,  4 Jan 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a271a28aeb4so59307066b.2;
        Thu, 04 Jan 2024 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704375790; x=1704980590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbeyHQ1rUcqV4dwET8z8R4TsNDpuCB5qN0CZweVYSGU=;
        b=ELfDU5HdutR8Sljse1SORUyrOV6ro+hhJUCE9AK8SgqCbNYGbhhXUZbjP38mxFbhR4
         PF1w7pacnZ/UPw59wPC0mF2QOjIC9iThgshVM/X0/W9nvRlf7oaYRAQm8lnjx9HhhcsJ
         okjFqlZeXQreREtet8ZoEFLYVh90DMUH8pnORmeivOiZYf/aFfgewdQrSKqJi2RQrgQk
         PFmD2c8tqFoZwOlXHQQKBz8v5lnyM53dypKpQ572ZUt+KH7ChzaCwxS7YqVyYR2Se3sg
         j6zwfdPQbnu5inXJGz6Ffas7RqOgXmB5rya90cLAA+G9lVU5ZNfI/02wpNAb1xNYwK6z
         fy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704375790; x=1704980590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbeyHQ1rUcqV4dwET8z8R4TsNDpuCB5qN0CZweVYSGU=;
        b=KTTuYzFfnV2KWaEeRLx682mt6BjKlgAcfb151QrN5ktF3mDjRt+VluWOiiCKrhcZYL
         0WeqP6P9suweGmg8sMVCCE2x2u01acrzdrxtmF3cBSkZhvdZiDyrqA0X8rpdHkOQi2O9
         5JNxvnYBNisVUzB2jlI/7DwoZV0z8P7z3xXnDdph5eNAJ3jLDGos9Kq8dpd4gYheuou5
         KizKVamSoBhbyYSuibXfqCTJBZ1OCorqtGQIXOrUc38VnuQPmf/P8z3Nhx3PQkpiro+p
         ccisk3E4v3OD+K+myOC/hRAwbnb9M8mbWOjd7J7Af/DfM73wdKG5uChuP8mky0+AE5XE
         ydkw==
X-Gm-Message-State: AOJu0YymQ1sCsWYcJcIj12F/0K5UMlGTqt+6FEr5bD5QoFp6hYLYhb6d
	efNrKJdiLgMRM3p86kv8+d0=
X-Google-Smtp-Source: AGHT+IGANj+Sn306j6NLEDqnWaQ9NE+nZrW6j5GCO+fqezjzdxC7lSuQvOPOC/qEkFAz2rGHPZTrvw==
X-Received: by 2002:a17:907:8703:b0:a28:b8a0:20ef with SMTP id qn3-20020a170907870300b00a28b8a020efmr328256ejc.146.1704375789471;
        Thu, 04 Jan 2024 05:43:09 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id gi20-20020a1709070c9400b00a26a25d9205sm13775909ejc.16.2024.01.04.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:43:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jan 2024 14:43:07 +0100
To: Barret Rhoden <brho@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add inline assembly
 helpers to access array elements
Message-ID: <ZZa1668ft4Npd1DA@krava>
References: <20240103185403.610641-1-brho@google.com>
 <20240103185403.610641-3-brho@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103185403.610641-3-brho@google.com>

On Wed, Jan 03, 2024 at 01:53:59PM -0500, Barret Rhoden wrote:

SNIP

> +
> +
> +/* Test that attempting to load a bad program fails. */
> +#define test_bad(PROG) ({						\
> +	struct array_elem_test *skel;					\
> +	int err;							\
> +	skel = array_elem_test__open();					\
> +	if (!ASSERT_OK_PTR(skel, "array_elem_test open"))		\
> +		return;							\
> +	bpf_program__set_autoload(skel->progs.x_bad_ ## PROG, true); 	\
> +	err = array_elem_test__load(skel);				\
> +	ASSERT_ERR(err, "array_elem_test load " # PROG);		\
> +	array_elem_test__destroy(skel);					\
> +})

I wonder we could use the existing RUN_TESTS macro and use tags
in programs like we do for example in progs/test_global_func1.c:

  SEC("tc")
  __failure __msg("combined stack size of 4 calls is 544")
  int global_func1(struct __sk_buff *skb)

jirka


> +
> +void test_test_array_elem(void)
> +{
> +	if (test__start_subtest("array_elem_access_all"))
> +		test_access_all();
> +	if (test__start_subtest("array_elem_oob_access"))
> +		test_oob_access();
> +	if (test__start_subtest("array_elem_access_array_map_infer_sz"))
> +		test_access_array_map_infer_sz();
> +	if (test__start_subtest("array_elem_bad_map_array_access"))
> +		test_bad(map_array_access);
> +	if (test__start_subtest("array_elem_bad_bss_array_access"))
> +		test_bad(bss_array_access);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/array_elem_test.c b/tools/testing/selftests/bpf/progs/array_elem_test.c
> new file mode 100644
> index 000000000000..9d48afc933f0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/array_elem_test.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google LLC. */
> +#include <stdbool.h>
> +#include <linux/types.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int target_pid = 0;
> +
> +#define NR_MAP_ELEMS 100
> +
> +/*
> + * We want to test valid accesses into an array, but we also need to fool the
> + * verifier.  If we just do for (i = 0; i < 100; i++), the verifier knows the
> + * value of i and can tell we're inside the array.
> + *
> + * This "lookup" array is just the values 0, 1, 2..., such that
> + * lookup_indexes[i] == i.  (set by userspace).  But the verifier doesn't know
> + * that.
> + */
> +unsigned int lookup_indexes[NR_MAP_ELEMS];
> +
> +/* Arrays can be in the BSS or inside a map element.  Make sure both work. */
> +int bss_elems[NR_MAP_ELEMS];
> +
> +struct map_array {
> +	int elems[NR_MAP_ELEMS];
> +};
> +
> +/*
> + * This is an ARRAY_MAP of a single struct, and that struct is an array of
> + * elements.  Userspace can mmap the map as if it was just a basic array of
> + * elements.  Though if you make an ARRAY_MAP where the *values* are ints, don't
> + * forget that bpf map elements are rounded up to 8 bytes.
> + *
> + * Once you get the pointer to the base of the inner array, you can access all
> + * of the elements without another bpf_map_lookup_elem(), which is useful if you
> + * are operating on multiple elements while holding a spinlock.
> + */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, int);
> +	__type(value, struct map_array);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +} arraymap SEC(".maps");
> +
> +static struct map_array *get_map_array(void)
> +{
> +	int zero = 0;
> +
> +	return bpf_map_lookup_elem(&arraymap, &zero);
> +}
> +
> +static int *get_map_elems(void)
> +{
> +	struct map_array *arr = get_map_array();
> +
> +	if (!arr)
> +		return NULL;
> +	return arr->elems;
> +}
> +
> +/*
> + * Test that we can access all elements, and that we are accessing the element
> + * we think we are accessing.
> + */
> +static void access_all(void)
> +{
> +	int *map_elems = get_map_elems();
> +	int *x;
> +
> +	for (int i = 0; i < NR_MAP_ELEMS; i++) {
> +		x = bpf_array_elem(map_elems, NR_MAP_ELEMS, lookup_indexes[i]);
> +		if (x)
> +			*x = i;
> +	}
> +
> +	for (int i = 0; i < NR_MAP_ELEMS; i++) {
> +		x = bpf_array_sz_elem(bss_elems, lookup_indexes[i]);
> +		if (x)
> +			*x = i;
> +	}
> +}
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int x_access_all(void *ctx)
> +{
> +	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
> +		return 0;
> +	access_all();
> +	return 0;
> +}
> +
> +/*
> + * Helper for various OOB tests.  An out-of-bound access should be handled like
> + * a lookup failure.  Specifically, the verifier should ensure we do not access
> + * outside the array.  Userspace will check that we didn't access somewhere
> + * inside the array.
> + */
> +static void set_elem_to_1(long idx)
> +{
> +	int *map_elems = get_map_elems();
> +	int *x;
> +
> +	x = bpf_array_elem(map_elems, NR_MAP_ELEMS, idx);
> +	if (x)
> +		*x = 1;
> +	x = bpf_array_sz_elem(bss_elems, idx);
> +	if (x)
> +		*x = 1;
> +}
> +
> +/*
> + * Test various out-of-bounds accesses.
> + */
> +static void oob_access(void)
> +{
> +	set_elem_to_1(NR_MAP_ELEMS + 5);
> +	set_elem_to_1(NR_MAP_ELEMS);
> +	set_elem_to_1(-1);
> +	set_elem_to_1(~0UL);
> +}
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int x_oob_access(void *ctx)
> +{
> +	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
> +		return 0;
> +	oob_access();
> +	return 0;
> +}
> +
> +/*
> + * Test that we can use the ARRAY_SIZE-style helper with an array in a map.
> + *
> + * Note that you cannot infer the size of the array from just a pointer; you
> + * have to use the actual elems[100].  i.e. this will fail and should fail to
> + * compile (-Wsizeof-pointer-div):
> + *
> + *	int *map_elems = get_map_elems();
> + *	x = bpf_array_sz_elem(map_elems, lookup_indexes[i]);
> + */
> +static void access_array_map_infer_sz(void)
> +{
> +	struct map_array *arr = get_map_array();
> +	int *x;
> +
> +	for (int i = 0; i < NR_MAP_ELEMS; i++) {
> +		x = bpf_array_sz_elem(arr->elems, lookup_indexes[i]);
> +		if (x)
> +			*x = i;
> +	}
> +}
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int x_access_array_map_infer_sz(void *ctx)
> +{
> +	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
> +		return 0;
> +	access_array_map_infer_sz();
> +	return 0;
> +}
> +
> +
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int x_bad_map_array_access(void *ctx)
> +{
> +	int *map_elems = get_map_elems();
> +
> +	/*
> +	 * Need to check to promote map_elems from MAP_OR_NULL to MAP so that we
> +	 * fail to load below for the right reason.
> +	 */
> +	if (!map_elems)
> +		return 0;
> +	/* Fail to load: we don't prove our access is inside map_elems[] */
> +	for (int i = 0; i < NR_MAP_ELEMS; i++)
> +		map_elems[lookup_indexes[i]] = i;
> +	return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_nanosleep")
> +int x_bad_bss_array_access(void *ctx)
> +{
> +	/* Fail to load: we don't prove our access is inside bss_elems[] */
> +	for (int i = 0; i < NR_MAP_ELEMS; i++)
> +		bss_elems[lookup_indexes[i]] = i;
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 2fd59970c43a..002bab44cde2 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -135,4 +135,47 @@
>  /* make it look to compiler like value is read and written */
>  #define __sink(expr) asm volatile("" : "+g"(expr))
>  
> +/*
> + * Access an array element within a bound, such that the verifier knows the
> + * access is safe.
> + *
> + * This macro asm is the equivalent of:
> + *
> + *	if (!arr)
> + *		return NULL;
> + *	if (idx >= arr_sz)
> + *		return NULL;
> + *	return &arr[idx];
> + *
> + * The index (___idx below) needs to be a u64, at least for certain versions of
> + * the BPF ISA, since there aren't u32 conditional jumps.
> + */
> +#define bpf_array_elem(arr, arr_sz, idx) ({				\
> +	typeof(&(arr)[0]) ___arr = arr;					\
> +	__u64 ___idx = idx;						\
> +	if (___arr) {							\
> +		asm volatile("if %[__idx] >= %[__bound] goto 1f;	\
> +			      %[__idx] *= %[__size];		\
> +			      %[__arr] += %[__idx];		\
> +			      goto 2f;				\
> +			      1:;				\
> +			      %[__arr] = 0;			\
> +			      2:				\
> +			      "						\
> +			     : [__arr]"+r"(___arr), [__idx]"+r"(___idx)	\
> +			     : [__bound]"r"((arr_sz)),		        \
> +			       [__size]"i"(sizeof(typeof((arr)[0])))	\
> +			     : "cc");					\
> +	}								\
> +	___arr;								\
> +})
> +
> +/*
> + * Convenience wrapper for bpf_array_elem(), where we compute the size of the
> + * array.  Be sure to use an actual array, and not a pointer, just like with the
> + * ARRAY_SIZE macro.
> + */
> +#define bpf_array_sz_elem(arr, idx) \
> +	bpf_array_elem(arr, sizeof(arr) / sizeof((arr)[0]), idx)
> +
>  #endif
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

