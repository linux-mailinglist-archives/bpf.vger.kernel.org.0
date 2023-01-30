Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F6B68148B
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 16:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbjA3PQS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 10:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjA3PQL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 10:16:11 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9451D3C2A8
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 07:15:52 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id w3so1636181qts.7
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 07:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kK8fJsna3WwGbShzjG8gz+UJBghGkGBaiOGaF27hDDQ=;
        b=tRPXTTKF1E8laTTwqfutvVp1V/MsvLDuZOfonmUp9zmQqTWLssFwoJKXbMZijThz8J
         Mnedup5GE42BXYZMYDeEX83ZRCYWzmfKtt8TyBo5K50qr52uUM8ooaPKaj1NnU7v9LTz
         pLm+r+fkRpcoZm8Cn7wrXWx23Wo48imJIDqAhXANUANFl572JykpSq954Rd76tnrkTJL
         MksWjHoAqawgK2ZCv6s0Z11JESUyHnsuVeiA8OJB7GKAgKWsVRKLkf4w+AeYlwb0/r2r
         YMatDgh6u4ZV1b8Dsh2XaK5YhIOxreHoTtACW57vJKoyVgcXAKe7UdihErWSS7MFHPAs
         yftw==
X-Gm-Message-State: AO0yUKVp5rNfQWinTf6tBp2Tadm89BUYmTjs13gzMxr8nvqOd5H/GFS+
        iHrBr/w9arMWwDhXxXyX3u0fWV4mRqlTspzO
X-Google-Smtp-Source: AK7set/mfr9llrh6BHpb/1p/WwTmyiWhEKzIGYFfJIQwHAhpw/vzo2e//P5H0FrJ4lHQIEXK52B8gw==
X-Received: by 2002:a05:622a:178f:b0:3b8:5dfe:ef3 with SMTP id s15-20020a05622a178f00b003b85dfe0ef3mr9693360qtk.68.1675091730041;
        Mon, 30 Jan 2023 07:15:30 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id o8-20020ac80248000000b003b64f1b1f40sm8160264qtg.40.2023.01.30.07.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:15:29 -0800 (PST)
Date:   Mon, 30 Jan 2023 09:15:26 -0600
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
Subject: Re: [PATCHv2 bpf-next 1/7] selftests/bpf: Move kfunc exports to
 bpf_testmod/bpf_testmod_kfunc.h
Message-ID: <Y9ffDhMXSD0De5K3@maniforge>
References: <20230130085540.410638-1-jolsa@kernel.org>
 <20230130085540.410638-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130085540.410638-2-jolsa@kernel.org>
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

On Mon, Jan 30, 2023 at 09:55:34AM +0100, Jiri Olsa wrote:
> Move all kfunc exports into separate header file and include it
> in tests that need it.
> 
> We will move all test kfuncs into bpf_testmod in following change,
> so it's convenient to have declarations in single place.

Nice, good call.

> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 92 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/cb_refs.c   |  4 +-
>  .../selftests/bpf/progs/jit_probe_mem.c       |  4 +-
>  .../bpf/progs/kfunc_call_destructive.c        |  3 +-
>  .../selftests/bpf/progs/kfunc_call_fail.c     |  9 +-
>  .../selftests/bpf/progs/kfunc_call_race.c     |  3 +-
>  .../selftests/bpf/progs/kfunc_call_test.c     | 16 +---
>  .../bpf/progs/kfunc_call_test_subprog.c       | 17 +++-
>  tools/testing/selftests/bpf/progs/map_kptr.c  |  6 +-
>  .../selftests/bpf/progs/map_kptr_fail.c       |  5 +-
>  10 files changed, 114 insertions(+), 45 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> new file mode 100644
> index 000000000000..164cbae2b0d7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h

Should we update the selftests Makefile to rebuild progs when the testmod
changes? Something like:

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e79039726173..ed0fb32aa855 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -438,6 +438,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:                             \
                     $(TRUNNER_BPF_PROGS_DIR)/%.c                       \
                     $(TRUNNER_BPF_PROGS_DIR)/*.h                       \
                     $$(INCLUDE_DIR)/vmlinux.h                          \
+              $(OUTPUT)/bpf_testmod.ko                               \
                     $(wildcard $(BPFDIR)/bpf_*.h)                      \
                     $(wildcard $(BPFDIR)/*.bpf.h)                      \
                     | $(TRUNNER_OUTPUT) $$(BPFOBJ)

> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _BPF_TESTMOD_KFUNC_H
> +#define _BPF_TESTMOD_KFUNC_H
> +
> +#ifndef __ksym
> +#define __ksym __attribute__((section(".ksyms")))
> +#endif

What about doing something like this:

#ifndef __KERNEL__
#include <vmlinux.h>
#include <bpf/bpf_helpers.h>
#else
#define __ksym
#endif

Thoughts?

> +
> +struct prog_test_pass1 {
> +	int x0;
> +	struct {
> +		int x1;
> +		struct {
> +			int x2;
> +			struct {
> +				int x3;
> +			};
> +		};
> +	};
> +};
> +
> +struct prog_test_pass2 {
> +	int len;
> +	short arr1[4];
> +	struct {
> +		char arr2[4];
> +		unsigned long arr3[8];
> +	} x;
> +};
> +
> +struct prog_test_fail1 {
> +	void *p;
> +	int x;
> +};
> +
> +struct prog_test_fail2 {
> +	int x8;
> +	struct prog_test_pass1 x;
> +};
> +
> +struct prog_test_fail3 {
> +	int len;
> +	char arr1[2];
> +	char arr2[];
> +};
> +
> +struct prog_test_member1 {
> +	int a;
> +};
> +
> +struct prog_test_member {
> +	struct prog_test_member1 m;
> +	int c;
> +};
> +
> +struct prog_test_ref_kfunc {
> +	int a;
> +	int b;
> +	struct prog_test_member memb;
> +	struct prog_test_ref_kfunc *next;
> +	refcount_t cnt;
> +};
> +
> +extern struct prog_test_ref_kfunc *
> +bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
> +extern struct prog_test_ref_kfunc *
> +bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
> +extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> +
> +extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
> +extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
> +extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> +extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> +extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
> +
> +extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
> +
> +extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> +				__u32 c, __u64 d) __ksym;
> +extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
> +extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
> +extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
> +
> +extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
> +extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
> +extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> +extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
> +
> +extern void bpf_kfunc_call_test_destructive(void) __ksym;

nit: Can we remove extern from all of these function signatures? Doesn't
really matter much to leave it there, but given that the keyword does
nothing for functions it feels unnecessary / noisy.

> +
> +#endif /* _BPF_TESTMOD_KFUNC_H */
> diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
> index 7653df1bc787..823901c1b839 100644
> --- a/tools/testing/selftests/bpf/progs/cb_refs.c
> +++ b/tools/testing/selftests/bpf/progs/cb_refs.c
> @@ -2,6 +2,7 @@
>  #include <vmlinux.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  struct map_value {
>  	struct prog_test_ref_kfunc __kptr_ref *ptr;
> @@ -14,9 +15,6 @@ struct {
>  	__uint(max_entries, 16);
>  } array_map SEC(".maps");
>  
> -extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
> -extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> -
>  static __noinline int cb1(void *map, void *key, void *value, void *ctx)
>  {
>  	void *p = *(void **)ctx;
> diff --git a/tools/testing/selftests/bpf/progs/jit_probe_mem.c b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
> index 2d2e61470794..96207f126054 100644
> --- a/tools/testing/selftests/bpf/progs/jit_probe_mem.c
> +++ b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
> @@ -3,13 +3,11 @@
>  #include <vmlinux.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  static struct prog_test_ref_kfunc __kptr_ref *v;
>  long total_sum = -1;
>  
> -extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
> -extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> -
>  SEC("tc")
>  int test_jit_probe_mem(struct __sk_buff *ctx)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c b/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
> index 767472bc5a97..6a9b13a79ae8 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
> @@ -1,8 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
> -
> -extern void bpf_kfunc_call_test_destructive(void) __ksym;
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  SEC("tc")
>  int kfunc_destructive_test(void)
> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
> index b98313d391c6..e857d1c4cf5b 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
> @@ -2,14 +2,7 @@
>  /* Copyright (c) 2021 Facebook */
>  #include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
> -
> -extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
> -extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> -extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
> -extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
> -extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> -extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> -extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  struct syscall_test_args {
>  	__u8 data[16];
> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_race.c b/tools/testing/selftests/bpf/progs/kfunc_call_race.c
> index 4e8fed75a4e0..a9558e434611 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_race.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_race.c
> @@ -1,8 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
> -
> -extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  SEC("tc")
>  int kfunc_call_fail(struct __sk_buff *ctx)
> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> index d91c58d06d38..d2fe17e2b433 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> @@ -2,21 +2,7 @@
>  /* Copyright (c) 2021 Facebook */
>  #include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
> -
> -extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
> -extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
> -extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> -				  __u32 c, __u64 d) __ksym;
> -
> -extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
> -extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> -extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
> -extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
> -extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> -extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
> -extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
> -extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
> -extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  SEC("tc")
>  int kfunc_call_test4(struct __sk_buff *skb)
> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> index c1fdecabeabf..f74c78bb5efd 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> @@ -4,10 +4,21 @@
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_tcp_helpers.h"
>  
> +/*
> + * We can't include vmlinux.h, because it conflicts with bpf_tcp_helpers.h,
> + * but we need refcount_t typedef for bpf_testmod_kfunc.h.
> + * Adding it directly.
> + */
> +typedef struct {
> +	int counter;
> +} atomic_t;
> +typedef struct refcount_struct {
> +	atomic_t refs;
> +} refcount_t;

Meh, this is kind of unfortunate, but OK, not the end of the world.
Don't really see an easy way to resolve these types of typedef / include
spaghetti issues in a general way.

As an alternative, it looks like this also works:

diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
index f74c78bb5efd..7b3472ebc445 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
@@ -1,21 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include <linux/bpf.h>
+#include <linux/types.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
-
-/*
- * We can't include vmlinux.h, because it conflicts with bpf_tcp_helpers.h,
- * but we need refcount_t typedef for bpf_testmod_kfunc.h.
- * Adding it directly.
- */
-typedef struct {
-   int counter;
-} atomic_t;
-typedef struct refcount_struct {
-   atomic_t refs;
-} refcount_t;
-
+#include <vmlinux.h>
 #include "bpf_testmod/bpf_testmod_kfunc.h"

 extern const int bpf_prog_active __ksym;
@@ -39,7 +26,7 @@ int __noinline f1(struct __sk_buff *skb)
        if (active)
                active_res = *active;

-   sk_state_res = bpf_kfunc_call_test3((struct sock *)sk)->sk_state;
+ sk_state_res = bpf_kfunc_call_test3((struct sock *)sk)->__sk_common.skc_state;

        return (__u32)bpf_kfunc_call_test1((struct sock *)sk, 1, 2, 3, 4);
 }

Thoughts?

> +
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
> +
>  extern const int bpf_prog_active __ksym;
> -extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> -				  __u32 c, __u64 d) __ksym;
> -extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
>  int active_res = -1;
>  int sk_state_res = -1;
>  
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
> index eb8217803493..d53474f5b05b 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr.c
> @@ -2,6 +2,7 @@
>  #include <vmlinux.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_helpers.h>
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  struct map_value {
>  	struct prog_test_ref_kfunc __kptr *unref_ptr;
> @@ -57,11 +58,6 @@ DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, hash_map, hash_of_hash_maps);
>  DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, hash_malloc_map, hash_of_hash_malloc_maps);
>  DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, lru_hash_map, hash_of_lru_hash_maps);
>  
> -extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
> -extern struct prog_test_ref_kfunc *
> -bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
> -extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> -
>  static void test_kptr_unref(struct map_value *v)
>  {
>  	struct prog_test_ref_kfunc *p;
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> index 760e41e1a632..1358a7c9e399 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -4,6 +4,7 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_core_read.h>
>  #include "bpf_misc.h"
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  struct map_value {
>  	char buf[8];
> @@ -19,10 +20,6 @@ struct array_map {
>  	__uint(max_entries, 1);
>  } array_map SEC(".maps");
>  
> -extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
> -extern struct prog_test_ref_kfunc *
> -bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
> -
>  SEC("?tc")
>  __failure __msg("kptr access size must be BPF_DW")
>  int size_not_bpf_dw(struct __sk_buff *ctx)
> -- 
> 2.39.1
> 
