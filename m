Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5446AAC70
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 21:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCDUeM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 15:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDUeL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 15:34:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF409F95E
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 12:34:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y2so6065628pjg.3
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBWYJ9cccJ3buRMK87gXZFlOydGdM/1HFmCbUG4kdkI=;
        b=INvDp6KamV2jsgKddQY19FyJTqkFQ7KX8PcBykHke74K0kLc6HkHwg/dWWRd0QCbu7
         YGCBKBqIwh6sh49OJw3u8qIEcCWyfsoOOyCyk1fyhsEtw2i8BFpy0f+2+Flizxqx9lA4
         NbdPUWZI7dvT0Ku6YJZANiBmtwlQrMoCh8nanbYWzL20I+6j/pNQv1G5dua3cil2bCYt
         mLLYVCOUHexK6LynAHo5A6Rcv8XRInyVSpRVaQm42ZeyaOjcu51DA/RbVJ4FIQdnCtxc
         DeGTs2Q1U504jCWtMtexTqGwpqRH/M6WIPK8RaCokH3uw7ZcFNCIE9YIuAF7i6zLZLKd
         um9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBWYJ9cccJ3buRMK87gXZFlOydGdM/1HFmCbUG4kdkI=;
        b=BZ8e3EUqX6Gv7n8gwk4iYBts/99y6me4frj+CTUt+Q8sg7+YXhJjH3/Y6hT35zXdX5
         CKosJixiZrue8xxKyH2zyV0MVx1cH02qhF08dac392xsMGu0B7JlTKSAOZUncWjZQ19t
         f3OPFxRKbus53JwF0NcgnFog5/Sis99MuVKhTtb2/waRSr8wb5FuW6awyueLNjDxz1ir
         yvOX5Xuoash4vglv+pZUPra3RUm/ZGN7V9CKpYUAuZ2kBXbfL8QWrS72WF3f9ADiBvvX
         ErewHRD65PDCwdDijLpXeY7ULEPj+VPJlbf8NFQ3PsEdKgZnaAX+XUUplAwNi8mr5dtn
         4niA==
X-Gm-Message-State: AO0yUKVFwv3Bhv1xdiqsrtlrtGYbxotAig0gx85MFdluhyzdHpRp4kq1
        AnH/EqYwLDoDoFcHJhpjNqQ=
X-Google-Smtp-Source: AK7set/oqLfs4f1+/rpU7GPhtv12SWAZeCWfEnH7zwk0fZ3OM1GhnSAl3mZ1CpSZZxxgfuwrrBfCig==
X-Received: by 2002:a17:902:eb92:b0:19d:31d:1e4f with SMTP id q18-20020a170902eb9200b0019d031d1e4fmr5472739plg.34.1677962049341;
        Sat, 04 Mar 2023 12:34:09 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:59fc])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902694500b0019aafc42328sm3716372plt.153.2023.03.04.12.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 12:34:08 -0800 (PST)
Date:   Sat, 4 Mar 2023 12:34:06 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 15/17] selftests/bpf: add bpf_for_each(),
 bpf_for(), and bpf_repeat() macros
Message-ID: <20230304203406.ynvl5hmmekvo42uj@MacBook-Pro-6.local>
References: <20230302235015.2044271-1-andrii@kernel.org>
 <20230302235015.2044271-16-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302235015.2044271-16-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 02, 2023 at 03:50:13PM -0800, Andrii Nakryiko wrote:
> Add bpf_for_each(), bpf_for() and bpf_repeat() macros that make writing
> open-coded iterator-based loops much more convenient and natural. These
> macro utilize cleanup attribute to ensure proper destruction of the
> iterator and thanks to that manage to provide an ergonomic very close to
> C language for construct. Typical integer loop would look like:
> 
>   int i;
>   int arr[N];
> 
>   bpf_for(i, 0, N) {
>   /* verifier will know that i >= 0 && i < N, so could be used to
>    * directly access array elements with no extra checks
>    */
>    arr[i] = i;
>   }
> 
> bpf_repeat() is very similar, but it doesn't expose iteration number and
> is mean as a simple "repeat action N times":
> 
>   bpf_repeat(N) { /* whatever */ }
> 
> Note that break and continue inside the {} block work as expected.
> 
> bpf_for_each() is a generalization over any kind of BPF open-coded
> iterator allowing to use for-each-like approach instead of calling
> low-level bpf_iter_<type>_{new,next,destroy}() APIs explicitly. E.g.:
> 
>   struct cgroup *cg;
> 
>   bpf_for_each(cgroup, cg, some, input, args) {
>       /* do something with each cg */
>   }
> 
> Would call (right now hypothetical) bpf_iter_cgroup_{new,next,destroy}()
> functions to form a loop over cgroups, where `some, input, args` are
> passed verbatim into constructor as
> bpf_iter_cgroup_new(&it, some, input, args).
> 
> As a demonstration, add pyperf variant based on bpf_for() loop.
> 
> Also clean up few tests that either included bpf_misc.h header
> unnecessarily from user-space or included it before any common types are
> defined.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../bpf/prog_tests/bpf_verif_scale.c          |  6 ++
>  .../bpf/prog_tests/uprobe_autoattach.c        |  1 -
>  tools/testing/selftests/bpf/progs/bpf_misc.h  | 76 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/lsm.c       |  4 +-
>  tools/testing/selftests/bpf/progs/pyperf.h    | 14 +++-
>  .../selftests/bpf/progs/pyperf600_iter.c      |  7 ++
>  .../selftests/bpf/progs/pyperf600_nounroll.c  |  3 -
>  7 files changed, 101 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_iter.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> index 5ca252823294..731c343897d8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> @@ -144,6 +144,12 @@ void test_verif_scale_pyperf600_nounroll()
>  	scale_test("pyperf600_nounroll.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
>  }
>  
> +void test_verif_scale_pyperf600_iter()
> +{
> +	/* open-coded BPF iterator version */
> +	scale_test("pyperf600_iter.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
> +}
> +
>  void test_verif_scale_loop1()
>  {
>  	scale_test("loop1.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> index 6558c857e620..d5b3377aa33c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
> @@ -3,7 +3,6 @@
>  
>  #include <test_progs.h>
>  #include "test_uprobe_autoattach.skel.h"
> -#include "progs/bpf_misc.h"
>  
>  /* uprobe attach point */
>  static noinline int autoattach_trigger_func(int arg1, int arg2, int arg3,
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index f704885aa534..08a791f307a6 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -75,5 +75,81 @@
>  #define FUNC_REG_ARG_CNT 5
>  #endif
>  
> +struct bpf_iter;
> +
> +extern int bpf_iter_num_new(struct bpf_iter *it__uninit, int start, int end) __ksym;
> +extern int *bpf_iter_num_next(struct bpf_iter *it) __ksym;
> +extern void bpf_iter_num_destroy(struct bpf_iter *it) __ksym;
> +
> +#ifndef bpf_for_each
> +/* bpf_for_each(iter_kind, elem, args...) provides generic construct for using BPF
> + * open-coded iterators without having to write mundane explicit low-level
> + * loop. Instead, it provides for()-like generic construct that can be used
> + * pretty naturally. E.g., for some hypothetical cgroup iterator, you'd write:
> + *
> + * struct cgroup *cg, *parent_cg = <...>;
> + *
> + * bpf_for_each(cgroup, cg, parent_cg, CG_ITER_CHILDREN) {
> + *     bpf_printk("Child cgroup id = %d", cg->cgroup_id);
> + *     if (cg->cgroup_id == 123)
> + *         break;
> + * }
> + *
> + * I.e., it looks almost like high-level for each loop in other languages,
> + * supports continue/break, and is verifiable by BPF verifier.
> + *
> + * For iterating integers, the difference betwen bpf_for_each(num, i, N, M)
> + * and bpf_for(i, N, M) is in that bpf_for() provides additional proof to
> + * verifier that i is in [N, M) range, and in bpf_for_each() case i is `int
> + * *`, not just `int`. So for integers bpf_for() is more convenient.
> + */
> +#define bpf_for_each(type, cur, args...) for (						  \
> +	/* initialize and define destructor */						  \
> +	struct bpf_iter ___it __attribute__((cleanup(bpf_iter_##type##_destroy))),	  \

We should probably say somewhere that it requires C99 with some flag that allows
declaring variables inside the loop.

Also what are the rules for attr(cleanup()).
When does it get called?
My understanding that the visibility of ___it is only within for() body.
So when the prog does:
bpf_for(i, 0, 10) sum += i;
bpf_for(i, 0, 10) sum += i;

the compiler should generate bpf_iter_num_destroy right after each bpf_for() ?
Or will it group them at the end of function body and destroy all iterators ?
Will compiler reuse the stack space used by ___it in case there are multiple bpf_for-s ?

> +	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */	  \
> +			*___p = (bpf_iter_##type##_new(&___it, ##args),		  \
> +	/* this is a workaround for Clang bug: it currently doesn't emit BTF */		  \
> +	/* for bpf_iter_##type##_destroy when used from cleanup() attribute */		  \
> +				(void)bpf_iter_##type##_destroy, (void *)0);		  \
> +	/* iteration and termination check */						  \
> +	((cur = bpf_iter_##type##_next(&___it)));					  \
> +	/* nothing here  */								  \
> +)
> +#endif /* bpf_for_each */
> +
> +#ifndef bpf_for
> +/* bpf_for(i, start, end) proves to verifier that i is in [start, end) */
> +#define bpf_for(i, start, end) for (							  \
> +	/* initialize and define destructor */						  \
> +	struct bpf_iter ___it __attribute__((cleanup(bpf_iter_num_destroy))),		  \
> +	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */	  \
> +			*___p = (bpf_iter_num_new(&___it, (start), (end)),		  \
> +	/* this is a workaround for Clang bug: it currently doesn't emit BTF */		  \
> +	/* for bpf_iter_num_destroy when used from cleanup() attribute */		  \
> +				(void)bpf_iter_num_destroy, (void *)0);			  \
> +	({										  \
> +		/* iteration step */							  \
> +		int *___t = bpf_iter_num_next(&___it);					  \
> +		/* termination and bounds check */					  \
> +		(___t && ((i) = *___t, i >= (start) && i < (end)));			  \

The i >= (start) && i < (end) is necessary to make sure that the verifier
tightens the range of 'i' inside the body of the loop and
when the program does arr[i] access the verifier will know that 'i' is within bounds, right?

In such case should we add __builtin_constant_p() check for 'start' and 'end' ?
int arr[100];
if (var < 100)
  bpf_for(i, 0, global_var) sum += arr[i];
will fail the verifier and the users might complain of dumb verifier.

Also if start and end are variables they potentially can change between bpf_iter_num_new()
and in each iteration of the loop.
__builtin_constant_p() might be too restrictive.
May be read start/end once, at least?

> +	});										  \
> +	/* nothing here  */								  \
> +)
> +#endif /* bpf_for */
> +
