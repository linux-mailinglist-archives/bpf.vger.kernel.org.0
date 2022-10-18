Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE4B6032E3
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 20:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJRSzp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 14:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJRSza (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 14:55:30 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE9B9A9D0
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:55:29 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q18-20020aa79832000000b00562d921e30aso8213117pfl.4
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PemP8Qexd6GdI0yAobc9aRiu6GSXY8twzpE5nr8nJpU=;
        b=nj7S24JUC70ORWsILReuYPy6mLHSAQlggiTedXmsQJHNyqx+gm2UX3OwLikV9WeLHl
         dfuRUS92aKwAQuuzTcaPCrpapeW9j0bYEr4z7l4CvtBdzYC+C3/g+5je7m9cqlYsRB7a
         o0LCzm9o00H11Y52kVwladTJgQoklKTFEjtNTom0xJOiqKxI+cARdT5ZBsM1O02WJ60p
         bLhk14WbA8EGH1ZsMXGKo1fr0/KMnP6JdzJ/jiqMG9IcLR96ShH0tGwdu4g863JbC2Ut
         c0VphPcTIGSL27/FNa4pVwGtRzOA81m32uCYwBEU4jHQMvvoXzsJC7Manjh8Qq8YpPZp
         6vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PemP8Qexd6GdI0yAobc9aRiu6GSXY8twzpE5nr8nJpU=;
        b=Vz7Em8FL/VOb9Cbg0+s6I98KW8iaf9PLuD4Wcxjq+n5eiJpJ40IdfGdo+zQgWh3pgs
         FIXacCg1Gi8sXubrHX5AGOy7ELm83jTKqpuJH94lUVYcmSXeN3sdZ2Z13px1krdMoy/h
         00qp3Nw7lYX2fZMzTqMzwGtS7igpQpvs+aDzRUQT2BDDGsjWpuMJQ0XFwKoGYmC9Exsp
         stL+4mcjyzKKAaZlcSAqEbBAAunkggdEXep6Kk255SuFkbllhKZUmzLIZK25LbabPx2F
         bCu2xkZpBCN7qs3ASmMLQ1mkQ2qZVxWYcMmJGuolqX7JVf3/XF9ofI9HbSf1vE5/KHF4
         jg6g==
X-Gm-Message-State: ACrzQf16LUPqLkK8vkLNslBB07BUK3ofIIT9lIxSr8JaP32ZnltpXYjp
        2M2SQEOeIOCvpvEQXKCOmwYF2K8=
X-Google-Smtp-Source: AMsMyM7nf6AtamSzSKxDcAH5J85EpNscD+c8ji9q0JCnU5V3nqess22vH1dzCs02JEEVUZrk1ZLAC7g=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:240d:b0:183:9bab:9c3 with SMTP id
 e13-20020a170903240d00b001839bab09c3mr4532979plo.48.1666119329272; Tue, 18
 Oct 2022 11:55:29 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:55:27 -0700
In-Reply-To: <20221018035646.1294873-4-andrii@kernel.org>
Mime-Version: 1.0
References: <20221018035646.1294873-1-andrii@kernel.org> <20221018035646.1294873-4-andrii@kernel.org>
Message-ID: <Y072n1Yi1Q0CMzCe@google.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: add non-mmapable data section selftest
From:   sdf@google.com
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/17, Andrii Nakryiko wrote:
> Add non-mmapable data section to test_skeleton selftest and make sure it
> really isn't mmapable by trying to mmap() it anyways.

> Also make sure that libbpf doesn't report BPF_F_MMAPABLE flag to users.

> Additional, some more manual testing was performed that this feature
> works as intended.

> Looking at created map through bpftool shows that flags passed to kernel  
> are
> indeed zero:

>    $ bpftool map show
>    ...
>    1782: array  name .data.non_mmapa  flags 0x0
>            key 4B  value 16B  max_entries 1  memlock 4096B
>            btf_id 1169
>            pids test_progs(8311)
>    ...

> Checking BTF uploaded to kernel for this map shows that zero_key and
> zero_value are indeed marked as static, even though zero_key is actually
> original global (but STV_HIDDEN) variable:

>    $ bpftool btf dump id 1169
>    ...
>    [51] VAR 'zero_key' type_id=2, linkage=static
>    [52] VAR 'zero_value' type_id=7, linkage=static
>    ...
>    [62] DATASEC '.data.non_mmapable' size=16 vlen=2
>            type_id=51 offset=0 size=4 (VAR 'zero_key')
>            type_id=52 offset=4 size=12 (VAR 'zero_value')
>    ...

> And original BTF does have zero_key marked as linkage=global:

>    $ bpftool btf dump file test_skeleton.bpf.linked3.o
>    ...
>    [51] VAR 'zero_key' type_id=2, linkage=global
>    [52] VAR 'zero_value' type_id=7, linkage=static
>    ...
>    [62] DATASEC '.data.non_mmapable' size=16 vlen=2
>            type_id=51 offset=0 size=4 (VAR 'zero_key')
>            type_id=52 offset=4 size=12 (VAR 'zero_value')

> Bpftool didn't require any changes at all because it checks whether  
> internal
> map is mmapable already, but just to double-check generated skeleton, we
> see that .data.non_mmapable neither sets mmaped pointer nor has
> a corresponding field in the skeleton:

>    $ grep non_mmapable test_skeleton.skel.h
>                    struct bpf_map *data_non_mmapable;
>            s->maps[7].name = ".data.non_mmapable";
>            s->maps[7].map = &obj->maps.data_non_mmapable;

> But .data.read_mostly has all of those things:

>    $ grep read_mostly test_skeleton.skel.h
>                    struct bpf_map *data_read_mostly;
>            struct test_skeleton__data_read_mostly {
>                    int read_mostly_var;
>            } *data_read_mostly;
>            s->maps[6].name = ".data.read_mostly";
>            s->maps[6].map = &obj->maps.data_read_mostly;
>            s->maps[6].mmaped = (void **)&obj->data_read_mostly;
>            _Static_assert(sizeof(s->data_read_mostly->read_mostly_var) ==  
> 4, "unexpected size of 'read_mostly_var'");

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   .../testing/selftests/bpf/prog_tests/skeleton.c | 11 ++++++++++-
>   .../testing/selftests/bpf/progs/test_skeleton.c | 17 +++++++++++++++++
>   2 files changed, 27 insertions(+), 1 deletion(-)

> diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c  
> b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> index 99dac5292b41..bc6817aee9aa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
> +++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
> @@ -2,6 +2,7 @@
>   /* Copyright (c) 2019 Facebook */

>   #include <test_progs.h>
> +#include <sys/mman.h>

>   struct s {
>   	int a;
> @@ -22,7 +23,8 @@ void test_skeleton(void)
>   	struct test_skeleton__kconfig *kcfg;
>   	const void *elf_bytes;
>   	size_t elf_bytes_sz = 0;
> -	int i;
> +	void *m;
> +	int i, fd;

>   	skel = test_skeleton__open();
>   	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> @@ -124,6 +126,13 @@ void test_skeleton(void)

>   	ASSERT_EQ(bss->huge_arr[ARRAY_SIZE(bss->huge_arr) - 1],  
> 123, "huge_arr");

> +	fd = bpf_map__fd(skel->maps.data_non_mmapable);
> +	m = mmap(NULL, getpagesize(), PROT_READ, MAP_SHARED, fd, 0);
> +	if (!ASSERT_EQ(m, MAP_FAILED, "unexpected_mmap_success"))
> +		munmap(m, getpagesize());
> +
> +	ASSERT_EQ(bpf_map__map_flags(skel->maps.data_non_mmapable),  
> 0, "non_mmap_flags");
> +
>   	elf_bytes = test_skeleton__elf_bytes(&elf_bytes_sz);
>   	ASSERT_OK_PTR(elf_bytes, "elf_bytes");
>   	ASSERT_GE(elf_bytes_sz, 0, "elf_bytes_sz");
> diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c  
> b/tools/testing/selftests/bpf/progs/test_skeleton.c
> index 1a4e93f6d9df..adece9f91f58 100644
> --- a/tools/testing/selftests/bpf/progs/test_skeleton.c
> +++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
> @@ -53,6 +53,20 @@ int out_mostly_var;

>   char huge_arr[16 * 1024 * 1024];

> +/* non-mmapable custom .data section */
> +
> +struct my_value { int x, y, z; };
> +
> +__hidden int zero_key SEC(".data.non_mmapable");
> +static struct my_value zero_value SEC(".data.non_mmapable");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct my_value);
> +	__uint(max_entries, 1);
> +} my_map SEC(".maps");
> +
>   SEC("raw_tp/sys_enter")
>   int handler(const void *ctx)
>   {
> @@ -75,6 +89,9 @@ int handler(const void *ctx)

>   	huge_arr[sizeof(huge_arr) - 1] = 123;

> +	/* make sure zero_key and zero_value are not optimized out */
> +	bpf_map_update_elem(&my_map, &zero_key, &zero_value, BPF_ANY);
> +
>   	return 0;
>   }

> --
> 2.30.2

