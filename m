Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21766916E5
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 03:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBJCxa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 21:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBJCx3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 21:53:29 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC46721D9
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 18:53:07 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n2so2657353pfo.3
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 18:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bH/dJzIHQeqznx0DMiaQOwVtw9g6fo/kpWt7R29Xnm0=;
        b=Rajo0lQ/AG08xpRyliquDcwnKlo+MK8t7VwxF2Ns8cRNROOhh7lGImowsgiESzN7L1
         4GFvvbe5IG3NaBVpYDEzF3K1cQS/mU7cHB5jxzCDtrt3Sw9Ilpm1oUKgx5nVJhE+bscc
         ifj9ZdwVq7yGbjIxIVB3ogS7Z5pfjTvAQS54kEo8NS5Lta8yuvfZr1haAJjwvoWVkqdZ
         IH+PHkWoPnNv4h0zbXzGB5grwvO+g1UaVppm6sNNLEJkaWigNIqax1splHuKSHbpmMiD
         lx7G9QPbw5KgyJa897ZgyfvwSoA+MNVn0pzkZsj9dKSwi5XY7ApSpMGE5J4dtJH1OcYV
         0MXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH/dJzIHQeqznx0DMiaQOwVtw9g6fo/kpWt7R29Xnm0=;
        b=MwR3BR6KPsVy2gIfJelLlJ8mNmMYjDZ2jDxvTshdvG8EZG+zmqhqDoXoe9q/AVl3Cp
         SmVZxjpnVp1aKZrEkBeFxsB3AkCcI0Hq7f6WHWEyGwYpwuGByBpCWmLQkbqulGXz5C/5
         ZuhW0FldGbHLQHQ3Co0shcFbwtE9fMb5aNbtL+2/f1ifFDtV8DOyf8Aji9A6lavBCEKT
         nN/OLpT3Uc+LDEMRQYwX2VoYxI6P681JFSX2cDc7it6iuR2vR3IspbhpIeSFnra0ClMw
         o7mv8YE+J5YK3p0pVgNWSNYOabP7FJTcEyWp+MKVyHRMOrE4aiz1/shZSeQrC7H7viQK
         WJ2A==
X-Gm-Message-State: AO0yUKVNsMjxn3z2JFdBwTg55nS4DTI14P8eakV7R+nFPxv/VdbY12dr
        Vn7fFFf//aL1MuFvbo1Zzis=
X-Google-Smtp-Source: AK7set+41kGEVkDV7/7CMdjeRuPm9OoUzl8sE9ue/UEeyX1ATfpDx9mac8WsbJXRDrIFZikyDO+tTw==
X-Received: by 2002:aa7:942e:0:b0:59b:3ee7:690a with SMTP id y14-20020aa7942e000000b0059b3ee7690amr10151131pfo.13.1675997582362;
        Thu, 09 Feb 2023 18:53:02 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:c6db])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78119000000b00581ad007a9fsm2124810pfi.153.2023.02.09.18.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 18:53:01 -0800 (PST)
Date:   Thu, 9 Feb 2023 18:52:59 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 10/11] selftests/bpf: Add rbtree selftests
Message-ID: <20230210025259.wo47znyqmtgpksoe@MacBook-Pro-6.local>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-11-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209174144.3280955-11-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 09, 2023 at 09:41:43AM -0800, Dave Marchevsky wrote:
> This patch adds selftests exercising the logic changed/added in the
> previous patches in the series. A variety of successful and unsuccessful
> rbtree usages are validated:
> 
> Success:
>   * Add some nodes, let map_value bpf_rbtree_root destructor clean them
>     up
>   * Add some nodes, remove one using the non-owning ref leftover by
>     successful rbtree_add() call
>   * Add some nodes, remove one using the non-owning ref returned by
>     rbtree_first() call
> 
> Failure:
>   * BTF where bpf_rb_root owns bpf_list_node should fail to load
>   * BTF where node of type X is added to tree containing nodes of type Y
>     should fail to load
>   * No calling rbtree api functions in 'less' callback for rbtree_add
>   * No releasing lock in 'less' callback for rbtree_add
>   * No removing a node which hasn't been added to any tree
>   * No adding a node which has already been added to a tree
>   * No escaping of non-owning references past their lock's
>     critical section
>   * No escaping of non-owning references past other invalidation points
>     (rbtree_remove)
> 
> These tests mostly focus on rbtree-specific additions, but some of the
> failure cases revalidate scenarios common to both linked_list and rbtree
> which are covered in the former's tests. Better to be a bit redundant in
> case linked_list and rbtree semantics deviate over time.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../testing/selftests/bpf/prog_tests/rbtree.c | 184 +++++++++++
>  tools/testing/selftests/bpf/progs/rbtree.c    | 176 +++++++++++
>  .../progs/rbtree_btf_fail__add_wrong_type.c   |  52 +++
>  .../progs/rbtree_btf_fail__wrong_node_type.c  |  49 +++
>  .../testing/selftests/bpf/progs/rbtree_fail.c | 296 ++++++++++++++++++
>  5 files changed, 757 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rbtree.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rbtree_btf_fail__add_wrong_type.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rbtree_btf_fail__wrong_node_type.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rbtree_fail.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree.c b/tools/testing/selftests/bpf/prog_tests/rbtree.c
> new file mode 100644
> index 000000000000..733db8d79a2d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rbtree.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "rbtree.skel.h"
> +#include "rbtree_fail.skel.h"
> +#include "rbtree_btf_fail__wrong_node_type.skel.h"
> +#include "rbtree_btf_fail__add_wrong_type.skel.h"
> +
> +static char log_buf[1024 * 1024];
> +
> +static struct {
> +	const char *prog_name;
> +	const char *err_msg;
> +} rbtree_fail_tests[] = {
> +	{"rbtree_api_nolock_add", "bpf_spin_lock at off=16 must be held for bpf_rb_root"},
> +	{"rbtree_api_nolock_remove", "bpf_spin_lock at off=16 must be held for bpf_rb_root"},
> +	{"rbtree_api_nolock_first", "bpf_spin_lock at off=16 must be held for bpf_rb_root"},
> +
> +	/* Specific failure string for these three isn't very important, but it shouldn't be
> +	 * possible to call rbtree api func from within add() callback
> +	 */
> +	{"rbtree_api_add_bad_cb_bad_fn_call_add", "allocated object must be referenced"},
> +	{"rbtree_api_add_bad_cb_bad_fn_call_remove", "rbtree_remove not allowed in rbtree cb"},
> +	{"rbtree_api_add_bad_cb_bad_fn_call_first_unlock_after",
> +	 "can't spin_{lock,unlock} in rbtree cb"},
> +
> +	{"rbtree_api_remove_unadded_node", "rbtree_remove node input must be non-owning ref"},
> +	{"rbtree_api_add_to_multiple_trees", "allocated object must be referenced"},
> +	{"rbtree_api_add_release_unlock_escape", "arg#1 expected pointer to allocated object"},
> +	{"rbtree_api_first_release_unlock_escape", "arg#1 expected pointer to allocated object"},
> +	{"rbtree_api_remove_no_drop", "Unreleased reference id=2 alloc_insn=11"},
> +	{"rbtree_api_release_aliasing", "arg#1 expected pointer to allocated object"},

Please convert the fail tests to RUN_TESTS() and __failure __msg() framework.
The success tests can stay as-is, since the runner checks the return values
and we don't have this feature yet in RUN_TESTS().
We probably should add such feature, but that's orthogonal and not a blocker for this set.
