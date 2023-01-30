Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB0B681F78
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 00:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjA3XQu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 18:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjA3XQt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 18:16:49 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A8166FB
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 15:16:46 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gr7so12068795ejb.5
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 15:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0r4j1zpaDYC7RBHPvNUIVC7bpbYyIZ5zslupMyD00I=;
        b=mfEcZpTQcJf9w12v9CucXUtwwo3CDVZhhbLCjB58VkN2p8Jq609hukZmpxa4CV90nZ
         ssxryHJqMorZ3W2CRiYEie8Ud04Gq2+QKQZdelCv6QjjKRfI4xg/8XukbjL9XU6a2HuN
         V7hCIK+yq/Af3q4Hywz++GcB2LjCB1OeiMOUDyIQHNmOVfCFCPGL/7eLUp8zyuWaXTN9
         r/mfwmAtMFZ2h32ISy5odxCSBX1G81eSuIil7+HKxvHPRK4K2lpF/wvAAHGjsOP4BeX7
         UAMwr9FPsqB2mfwInoOzmm+fj8NsAcofqhi4xujfIffAtD4NR/I6IYDMNZC31LC35p1p
         nPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0r4j1zpaDYC7RBHPvNUIVC7bpbYyIZ5zslupMyD00I=;
        b=7Ese0eoIQ7fhAkg6gbwjqCjYXGbmiIqkqF+EVmz1OWimkGVri1X0gG5nwsN04tXUFc
         eIlCxV+qvItg69VXG/f6yqoJbugjIocRfM2BimHjvAG41NuMEbfKhOGMNCoLzz90Wmr4
         Z6kCOikSQgu3MgDH7L2GZe4WYIZkiUhQGn57+l7vHa6wRJezFLIcRI4ZNbd3orsiIcbu
         KeJya9+Rj8VYHfyvF/Yl3jIUO8jI1gcIQykNc06hyE8tVJbzygI3BA8bWGWlzAeEg/U2
         M+glXoo4e+8sA+TIuMTnhmllNV7stfVcY+zhw8L2CYnLPaZWjFPLC7VvnwDPTOJ231Rm
         jVkQ==
X-Gm-Message-State: AO0yUKWZleygPh/Z+jQnQEABwND4CeKcvU1VaEuCsmhN6QrZtjOFl7p4
        11kqMOZAJ+wQHZKWDmK4a4o=
X-Google-Smtp-Source: AK7set97e1RTAnjwb1ZpaYzKheaU8YRZqWku2M5mKddGI/gBEMDwi+ei+EH/G4dtKw2rP/0A79OjWQ==
X-Received: by 2002:a17:906:69c6:b0:884:b467:ae4a with SMTP id g6-20020a17090669c600b00884b467ae4amr8904271ejs.64.1675120605244;
        Mon, 30 Jan 2023 15:16:45 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906762200b0087851a76573sm7661665ejn.74.2023.01.30.15.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:16:44 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 31 Jan 2023 00:16:42 +0100
To:     David Vernet <void@manifault.com>
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
Message-ID: <Y9hP2lwYJo/UJ8gF@krava>
References: <20230130085540.410638-1-jolsa@kernel.org>
 <20230130085540.410638-2-jolsa@kernel.org>
 <Y9ffDhMXSD0De5K3@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ffDhMXSD0De5K3@maniforge>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 09:15:26AM -0600, David Vernet wrote:
> On Mon, Jan 30, 2023 at 09:55:34AM +0100, Jiri Olsa wrote:
> > Move all kfunc exports into separate header file and include it
> > in tests that need it.
> > 
> > We will move all test kfuncs into bpf_testmod in following change,
> > so it's convenient to have declarations in single place.
> 
> Nice, good call.
> 
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 92 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/cb_refs.c   |  4 +-
> >  .../selftests/bpf/progs/jit_probe_mem.c       |  4 +-
> >  .../bpf/progs/kfunc_call_destructive.c        |  3 +-
> >  .../selftests/bpf/progs/kfunc_call_fail.c     |  9 +-
> >  .../selftests/bpf/progs/kfunc_call_race.c     |  3 +-
> >  .../selftests/bpf/progs/kfunc_call_test.c     | 16 +---
> >  .../bpf/progs/kfunc_call_test_subprog.c       | 17 +++-
> >  tools/testing/selftests/bpf/progs/map_kptr.c  |  6 +-
> >  .../selftests/bpf/progs/map_kptr_fail.c       |  5 +-
> >  10 files changed, 114 insertions(+), 45 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> > new file mode 100644
> > index 000000000000..164cbae2b0d7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> 
> Should we update the selftests Makefile to rebuild progs when the testmod
> changes? Something like:
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e79039726173..ed0fb32aa855 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -438,6 +438,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:                             \
>                      $(TRUNNER_BPF_PROGS_DIR)/%.c                       \
>                      $(TRUNNER_BPF_PROGS_DIR)/*.h                       \
>                      $$(INCLUDE_DIR)/vmlinux.h                          \
> +              $(OUTPUT)/bpf_testmod.ko                               \
>                      $(wildcard $(BPFDIR)/bpf_*.h)                      \
>                      $(wildcard $(BPFDIR)/*.bpf.h)                      \
>                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)

ok, looks good will add it

> 
> > @@ -0,0 +1,92 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _BPF_TESTMOD_KFUNC_H
> > +#define _BPF_TESTMOD_KFUNC_H
> > +
> > +#ifndef __ksym
> > +#define __ksym __attribute__((section(".ksyms")))
> > +#endif
> 
> What about doing something like this:
> 
> #ifndef __KERNEL__
> #include <vmlinux.h>
> #include <bpf/bpf_helpers.h>
> #else
> #define __ksym
> #endif
> 
> Thoughts?

that goes nicely along with the solution for extra typedef you suggested below

SNIP

> > +extern struct prog_test_ref_kfunc *
> > +bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
> > +extern struct prog_test_ref_kfunc *
> > +bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
> > +extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> > +
> > +extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
> > +extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
> > +extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> > +extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> > +extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
> > +
> > +extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
> > +
> > +extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> > +				__u32 c, __u64 d) __ksym;
> > +extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
> > +extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
> > +extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
> > +
> > +extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
> > +extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
> > +extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> > +extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
> > +
> > +extern void bpf_kfunc_call_test_destructive(void) __ksym;
> 
> nit: Can we remove extern from all of these function signatures? Doesn't
> really matter much to leave it there, but given that the keyword does
> nothing for functions it feels unnecessary / noisy.

np, I can remove it

SNIP

> > diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> > index c1fdecabeabf..f74c78bb5efd 100644
> > --- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> > +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> > @@ -4,10 +4,21 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include "bpf_tcp_helpers.h"
> >  
> > +/*
> > + * We can't include vmlinux.h, because it conflicts with bpf_tcp_helpers.h,
> > + * but we need refcount_t typedef for bpf_testmod_kfunc.h.
> > + * Adding it directly.
> > + */
> > +typedef struct {
> > +	int counter;
> > +} atomic_t;
> > +typedef struct refcount_struct {
> > +	atomic_t refs;
> > +} refcount_t;
> 
> Meh, this is kind of unfortunate, but OK, not the end of the world.
> Don't really see an easy way to resolve these types of typedef / include
> spaghetti issues in a general way.
> 
> As an alternative, it looks like this also works:
> 
> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> index f74c78bb5efd..7b3472ebc445 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
> @@ -1,21 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2021 Facebook */
> -#include <linux/bpf.h>
> +#include <linux/types.h>
>  #include <bpf/bpf_helpers.h>
> -#include "bpf_tcp_helpers.h"
> -
> -/*
> - * We can't include vmlinux.h, because it conflicts with bpf_tcp_helpers.h,
> - * but we need refcount_t typedef for bpf_testmod_kfunc.h.
> - * Adding it directly.
> - */
> -typedef struct {
> -   int counter;
> -} atomic_t;
> -typedef struct refcount_struct {
> -   atomic_t refs;
> -} refcount_t;
> -
> +#include <vmlinux.h>
>  #include "bpf_testmod/bpf_testmod_kfunc.h"
> 
>  extern const int bpf_prog_active __ksym;
> @@ -39,7 +26,7 @@ int __noinline f1(struct __sk_buff *skb)
>         if (active)
>                 active_res = *active;
> 
> -   sk_state_res = bpf_kfunc_call_test3((struct sock *)sk)->sk_state;
> + sk_state_res = bpf_kfunc_call_test3((struct sock *)sk)->__sk_common.skc_state;

great, I was wondering why the sock type was different when I was trying similar fix,
that looks much better, will try that

thanks,
jirka
