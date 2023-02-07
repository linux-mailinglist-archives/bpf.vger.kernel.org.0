Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B567268DAC2
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 15:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjBGO2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 09:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjBGO2c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 09:28:32 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1925213C
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 06:28:30 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id j9so9194825qvt.0
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 06:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFZzWu2GMXzwVIkYj+SFwzmMMqvEkdKKio2VDM8JvkU=;
        b=4F0dN26UM8WKQU5Bt4mS8R1NktN0DIAqvOHt3fFNpdMTBhe18WK1c7D/aO3HwSkH1y
         KU0+e8IT283mjbOWtz73uqeEsL+xCPMWmCG9DYQX3S+Zcmc6QYRH4PnpEhyVu4K+1vMd
         1FJqn/tnLjRF7i/vCVj0y8k63ifCh6uP6qlhl+Jxbbf3cPhn+T4at0hN2Gdfx5GidCvx
         AJVWJTn2HpLUbHHvJfhkEwnmkkQD+T1LEdeKd8BxuukYg97SuisVHzNCMdN6oqq46POD
         nVQ2KtzhX82PO4bW7GzeLsyFrugeALniZXV2IKgnDlM60vIzv01tENiG/u2N4pX9+ECg
         YgIQ==
X-Gm-Message-State: AO0yUKVUZq1UoYKK0HjFuf/Z2JZkD0kls8WSB9IQuj3vUaffBT8Zlb9u
        NrYipC4QNDyItAGQDrJR5UKJuq78WzYRUZ/G
X-Google-Smtp-Source: AK7set9WR+tFa70JE9Tkak7FGoiPNVVLfRGD8pbf61GfcfGV4aJAuJ69mB7yA+CPtgMkwjglNr4WkQ==
X-Received: by 2002:a05:6214:484:b0:56c:37d:51e with SMTP id pt4-20020a056214048400b0056c037d051emr6395922qvb.22.1675780109695;
        Tue, 07 Feb 2023 06:28:29 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:9bc3])
        by smtp.gmail.com with ESMTPSA id c1-20020a05620a268100b007203bbbbb31sm9807545qkp.47.2023.02.07.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:28:28 -0800 (PST)
Date:   Tue, 7 Feb 2023 08:28:32 -0600
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
Subject: Re: [PATCHv3 bpf-next 1/9] selftests/bpf: Move kfunc exports to
 bpf_testmod/bpf_testmod_kfunc.h
Message-ID: <Y+JgEIwzW7+UkCj9@maniforge.lan>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203162336.608323-2-jolsa@kernel.org>
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

On Fri, Feb 03, 2023 at 05:23:28PM +0100, Jiri Olsa wrote:
> Move all kfunc exports into separate bpf_testmod_kfunc.h header file
> and include it in tests that need it.
> 
> We will move all test kfuncs into bpf_testmod in following change,
> so it's convenient to have declarations in single place.
> 
> The bpf_testmod_kfunc.h is included by both bpf_testmod and bpf
> programs that use test kfuncs.
> 
> As suggested by David, the bpf_testmod_kfunc.h includes vmlinux.h
> and bpf/bpf_helpers.h for bpf programs build, so the declarations
> have proper __ksym attribute and we can resolve all the structs.
> 
> Note in kfunc_call_test_subprog.c we can no longer use the sk_state
> define from bpf_tcp_helpers.h (because it clashed with vmlinux.h)
> and we need to address __sk_common.skc_state field directly.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 41 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/cb_refs.c   |  4 +-
>  .../selftests/bpf/progs/jit_probe_mem.c       |  4 +-
>  .../bpf/progs/kfunc_call_destructive.c        |  3 +-
>  .../selftests/bpf/progs/kfunc_call_fail.c     |  9 +---
>  .../selftests/bpf/progs/kfunc_call_race.c     |  3 +-
>  .../selftests/bpf/progs/kfunc_call_test.c     | 17 +-------
>  .../bpf/progs/kfunc_call_test_subprog.c       |  9 +---
>  tools/testing/selftests/bpf/progs/map_kptr.c  |  6 +--
>  .../selftests/bpf/progs/map_kptr_fail.c       |  5 +--
>  10 files changed, 51 insertions(+), 50 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> new file mode 100644
> index 000000000000..86d94257716a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _BPF_TESTMOD_KFUNC_H
> +#define _BPF_TESTMOD_KFUNC_H
> +
> +#ifndef __KERNEL__
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#else
> +#define __ksym
> +#endif
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
> +extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
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

Feel free to ignore if you disagree, but here and elsewhere, should we
do this:

#include <bpf_testmod/bpf_testmod_kfunc.h>

rather than using #include "bpf_testmod/bpf_testmod_kfunc.h". Doesn't
matter much, but IMO it's just slightly more readable to use the <> to
show that we're relying on -I rather than expecting
bpf_testmod/bpf_testmod_kfunc.h to be found at a path relative to the
progs. #include "bpf_misc.h" makes more sense because it really is
located in the progs/ directory.

Either way:

Acked-by: David Vernet <void@manifault.com>

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
> index 7daa8f5720b9..169fe673bebf 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> @@ -2,22 +2,7 @@
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
> -extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  SEC("tc")
>  int kfunc_call_test4(struct __sk_buff *skb)
> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> index c1fdecabeabf..5bfc8d35f782 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> @@ -1,13 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2021 Facebook */
> -#include <linux/bpf.h>
> -#include <bpf/bpf_helpers.h>
> -#include "bpf_tcp_helpers.h"
> +#include "bpf_testmod/bpf_testmod_kfunc.h"
>  
>  extern const int bpf_prog_active __ksym;
> -extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> -				  __u32 c, __u64 d) __ksym;
> -extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
>  int active_res = -1;
>  int sk_state_res = -1;
>  
> @@ -28,7 +23,7 @@ int __noinline f1(struct __sk_buff *skb)
>  	if (active)
>  		active_res = *active;
>  
> -	sk_state_res = bpf_kfunc_call_test3((struct sock *)sk)->sk_state;
> +	sk_state_res = bpf_kfunc_call_test3((struct sock *)sk)->__sk_common.skc_state;
>  
>  	return (__u32)bpf_kfunc_call_test1((struct sock *)sk, 1, 2, 3, 4);
>  }
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
