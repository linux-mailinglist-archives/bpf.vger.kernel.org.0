Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A472CA343
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgLAM5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 07:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgLAM5T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 07:57:19 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716EC061A4A
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 04:56:50 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d3so2585347wmb.4
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+e54grMGH+3x/X56AP2qTQeH5OWhU1Fo6l1imoZcFiA=;
        b=q5ZyriwEe3J/eFk8Vn+yKFgDuUFOWx4hX7wSZgVazYXvVWPT1h/fPwARvvxom+tRs5
         7BUB9Te/ks9+jJoPR0KmKVNtpOv6Bw0TGV2swvHt5/QNR/RETRrjVyCbJj8eU4qt9FCm
         f2BIaJQycoZqrWcJQMhddMnfM9Z22ZCbHfC9fqvs6h7JW/aqaHxIZwl9ioFXDQnt4dXz
         UD4+OgmWHZ0niTxzBwFJBRe8yLdeWNQj8Ujw5jYZMjvCy8VgO8ONBqCHzgQp+6APm75v
         pcEzVH7nm3g1i41r07OirPSXj9w2Cm/A4dEKhgDZqHFQ+S+lMhjyiujCItXhZojqQKgU
         DJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+e54grMGH+3x/X56AP2qTQeH5OWhU1Fo6l1imoZcFiA=;
        b=hgP1WAvDBUdhNlrcKbXMlohPQlVITzUK9ZEMw6yd5MotCePO2PC4bKEg3d3zkEZ50w
         KS0ezG79TXqieCxEQUHhiGIwCPZ+Hb+bdj+V4cwb8EYUtk7GhZsiuyMzBPQ5Z1yYTgrl
         HlUhyxKHdSpQMzeN3340Ww8o3/ViwKTRrC0hBPUwc1jb6TTP7xeCpl/K5FNb06TBgJBY
         Bon1z+rzXjuKh3y63ewR1NY0Pi19BUpA2cVa8V1gQRC3ufGuEpzVZfWepHbE3Jam86of
         BgnbmLrUibP9WEVcuLS77H8a2zprA7sNtAxUowPDbWT3RL1R6cLYlgXrDqEavhkxwSxc
         WUcA==
X-Gm-Message-State: AOAM531zRa+dpCc4/TC9DHDWzArnDyHzj+R2a5ddONI3NyDLSAOrEGNc
        bvK0WFb6YxIPbgrXL33uGFt4Gw==
X-Google-Smtp-Source: ABdhPJyuSsCeTIVAfNFzmw/CBCJqCRxgpiA4F6h0YkauNZ7Pp5uLQ32w3lRdBmm+0WLkkGD190K1Qw==
X-Received: by 2002:a1c:f617:: with SMTP id w23mr2595979wmc.52.1606827407331;
        Tue, 01 Dec 2020 04:56:47 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id y130sm3074687wmc.22.2020.12.01.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:56:46 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:56:42 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Add tests for new BPF atomic
 operations
Message-ID: <20201201125642.GH2114905@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-13-jackmanb@google.com>
 <1e1656a9-6f0e-f17e-176c-37d996641e9a@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1656a9-6f0e-f17e-176c-37d996641e9a@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 30, 2020 at 07:55:02PM -0800, Yonghong Song wrote:
> On 11/27/20 9:57 AM, Brendan Jackman wrote:
[...]
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 3d5940cd110d..5eadfd09037d 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -228,6 +228,12 @@ IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
> >   			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
> >   MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> > +# Determine if Clang supports BPF arch v4, and therefore atomics.
> > +CLANG_SUPPORTS_V4=$(if $(findstring v4,$(shell $(CLANG) --target=bpf -mcpu=? 2>&1)),true,)
> > +ifeq ($(CLANG_SUPPORTS_V4),true)
> > +	CFLAGS += -DENABLE_ATOMICS_TESTS
> > +endif
> > +
> >   CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
> >   BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
> >   	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
> > @@ -250,7 +256,9 @@ define CLANG_BPF_BUILD_RULE
> >   	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
> >   	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
> >   		-c $1 -o - || echo "BPF obj compilation failed") | 	\
> > -	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
> > +	$(LLC) -mattr=dwarfris -march=bpf				\
> > +		-mcpu=$(if $(CLANG_SUPPORTS_V4),v4,v3)			\
> > +		$4 -filetype=obj -o $2
> >   endef
> >   # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
> >   define CLANG_NOALU32_BPF_BUILD_RULE
> > @@ -391,7 +399,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
> >   TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
> >   		       $(wildcard progs/btf_dump_test_case_*.c)
> >   TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> > -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> > +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) $(if $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)
> 
> If the compiler indeed supports cpu v4 (i.e., atomic insns),
> -DENABLE_ATOMICS_TESTS will be added to TRUNNER_BPF_FLAGS and
> eventually -DENABLE_ATOMICS_TESTS is also available for
> no-alu32 test and this will cause compilation error.
> 
> I did the following hack to workaround the issue, i.e., only adds
> the definition to default (alu32) test run.
> 
> index 5eadfd09037d..3d1320fd93eb 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -230,9 +230,6 @@ MENDIAN=$(if
> $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> 
>  # Determine if Clang supports BPF arch v4, and therefore atomics.
>  CLANG_SUPPORTS_V4=$(if $(findstring v4,$(shell $(CLANG) --target=bpf
> -mcpu=? 2>&1)),true,)
> -ifeq ($(CLANG_SUPPORTS_V4),true)
> -       CFLAGS += -DENABLE_ATOMICS_TESTS
> -endif
> 
>  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
>  BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)                  \
> @@ -255,6 +252,7 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
>  define CLANG_BPF_BUILD_RULE
>         $(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
>         $(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm                     \
> +               $(if $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)      \
>                 -c $1 -o - || echo "BPF obj compilation failed") |      \
>         $(LLC) -mattr=dwarfris -march=bpf                               \
>                 -mcpu=$(if $(CLANG_SUPPORTS_V4),v4,v3)                  \
> @@ -399,7 +397,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c
> trace_helpers.c      \
>  TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read                          \
>                        $(wildcard progs/btf_dump_test_case_*.c)
>  TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) $(if
> $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)
> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
>  TRUNNER_BPF_LDFLAGS := -mattr=+alu32
>  $(eval $(call DEFINE_TEST_RUNNER,test_progs))

Ah, good point. I think your "hack" actually improves the overall result
anyway since it avoids the akward global mutation of CFLAGS. Thanks!

I wonder if we should actually have Clang define a built-in macro to say
that the atomics are supported?

> > diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> > new file mode 100644
> > index 000000000000..8ecc0392fdf9
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> > @@ -0,0 +1,329 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +
> > +#ifdef ENABLE_ATOMICS_TESTS
> > +
> > +#include "atomics_test.skel.h"
> > +
> > +static void test_add(void)
> [...]
> > +
> > +#endif /* ENABLE_ATOMICS_TESTS */
> > diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
[...]
> > +__u64 xor64_value = (0x110ull << 32);
> > +__u64 xor64_result = 0;
> > +__u32 xor32_value = 0x110;
> > +__u32 xor32_result = 0;
> > +SEC("fentry/bpf_fentry_test1")
> > +int BPF_PROG(xor, int a)
> > +{
> > +	xor64_result = __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
> > +	xor32_result = __sync_fetch_and_xor(&xor32_value, 0x011);
> > +
> > +	return 0;
> > +}
> 
> All above __sync_fetch_and_{add, sub, and, or, xor} produces a return
> value used later. To test atomic_<op> instructions, it will be good if
> you can add some tests which ignores the return value.

Good idea - adding an extra case to each prog. This won't assert that
LLVM is generating "optimal" code (without BPF_FETCH) but we can at
least get some confidence we aren't generating total garbage.
