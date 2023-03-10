Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426136B5184
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 21:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCJUNC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 15:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjCJUNB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 15:13:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49259C7
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 12:12:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso11048773pjb.2
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 12:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678479175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/UDvt3n4Dinow42PUqI+KwQ/prFII7giLtC/GNgvwE=;
        b=O6x7D3mwker/F5A52qjtSnN4g2NY1K+z85Z/icwnW8L7faaOdHpvlq7S+GeaWPyF/q
         6nj0ATGWFSw6T+g0KDwEDahwC45YEWl7Fzk086m//k5YV4hgUQYZHAMjYE8k1EUeJR+9
         JcIulTF/W7DQ1RxcauxIJcu5Y6NJ3FqnhI9cKIKk3nIcU25lZ1PVNj0Vu8J2/VzP3OYj
         /6CNCoF9m1rGEVzCcpIWbzbVsQYA+9bbChdK+rwaG0DcH4fNb0EAVUoFegxB1kygiro9
         Nou+8yhdz3k+c+qsDideLs+W+FDFB1fS2rHZD9cgMh1g9gmib7vkU1DmvnIKIaDnRw28
         Bjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678479175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/UDvt3n4Dinow42PUqI+KwQ/prFII7giLtC/GNgvwE=;
        b=fcNSNa9+ujpoXIq30qhb6v0TEhiUTFp3KozR2xY7xyoP+MOQw7l+/kWG3Zoe3Tc/1a
         qM1yjMGv0hY0RMgikYsI0x4n3vC+O9ZvtaoTVWmVyWbCRqDzlbfXhJxu5JFQ3P/MqqoK
         ZgZH7poJsRo/b4XSO/XaXr+wABUqhXoaLu+usSRsmX7TeJmeY95y3dfdY6GziV6NfHWV
         0u2pnaulNRmw4z3qdqBqmieaX/XIj3pdm7W5AopbcmpZDhlxK8Av+b/qiYuQaBXgnQUd
         ae6DDvcWuFIWkQR/G9OCvmGvdW+X84KmO8AZLHv6oTZuyrM3eQTjFLv25TRZsApw3tS1
         tcEQ==
X-Gm-Message-State: AO0yUKVztbQe8hxtcZMFST3kkyqch1RGh59qMXKByyBgQ3yG1hu7fFLA
        N1/dwI1dSqFh/gu06I9PjnY=
X-Google-Smtp-Source: AK7set/QlZFB+Vw2CjSKghfCcH2serekT+UaBD+eCOCEno6HrARzIvbFVdEtA2M7nX9s6ljwMrGCVA==
X-Received: by 2002:a17:903:120b:b0:19e:82aa:dc8a with SMTP id l11-20020a170903120b00b0019e82aadc8amr30942354plh.22.1678479175060;
        Fri, 10 Mar 2023 12:12:55 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:5c0c])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b0019e60c645b1sm327521plg.305.2023.03.10.12.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:12:54 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:12:52 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, tj@kernel.org
Subject: Re: [PATCH v1 bpf-next 6/6] selftests/bpf: Add local kptr stashing
 test
Message-ID: <20230310201252.rwh3xu5e5s6udyhu@macbook-pro-6.dhcp.thefacebook.com>
References: <20230309180111.1618459-1-davemarchevsky@fb.com>
 <20230309180111.1618459-7-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309180111.1618459-7-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 09, 2023 at 10:01:11AM -0800, Dave Marchevsky wrote:
> Add a new selftest, local_kptr_stash, which uses bpf_kptr_xchg to stash
> a bpf_obj_new-allocated object in a map.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../bpf/prog_tests/local_kptr_stash.c         | 33 +++++++
>  .../selftests/bpf/progs/local_kptr_stash.c    | 85 +++++++++++++++++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
>  create mode 100644 tools/testing/selftests/bpf/progs/local_kptr_stash.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c b/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
> new file mode 100644
> index 000000000000..98353e602741
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "local_kptr_stash.skel.h"
> +static void test_local_kptr_stash_simple(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		    .data_in = &pkt_v4,
> +		    .data_size_in = sizeof(pkt_v4),
> +		    .repeat = 1,
> +	);
> +	struct local_kptr_stash *skel;
> +	int ret;
> +
> +	skel = local_kptr_stash__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "local_kptr_stash__open_and_load"))
> +		return;
> +
> +	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.stash_rb_node), &opts);
> +	ASSERT_OK(ret, "local_kptr_stash_add_nodes run");
> +	ASSERT_OK(opts.retval, "local_kptr_stash_add_nodes retval");
> +
> +	local_kptr_stash__destroy(skel);
> +}
> +
> +void test_local_kptr_stash_success(void)
> +{
> +	if (test__start_subtest("rbtree_add_nodes"))
> +		test_local_kptr_stash_simple();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> new file mode 100644
> index 000000000000..df7b419f3dc3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_experimental.h"
> +
> +struct node_data {
> +	long key;
> +	long data;
> +	struct bpf_rb_node node;
> +};
> +
> +struct map_value {
> +	struct prog_test_ref_kfunc *not_kptr;
> +	struct prog_test_ref_kfunc __kptr *val;
> +	struct node_data __kptr *node;
> +};
> +
> +/* This is necessary so that LLVM generates BTF for node_data struct
> + * If it's not included, a fwd reference for node_data will be generated but
> + * no struct. Example BTF of "node" field in map_value when not included:
> + *
> + * [10] PTR '(anon)' type_id=35
> + * [34] FWD 'node_data' fwd_kind=struct
> + * [35] TYPE_TAG 'kptr_ref' type_id=34
> + *
> + * (with no node_data struct defined)
> + * Had to do the same w/ bpf_kfunc_call_test_release below
> + */
> +struct node_data *just_here_because_btf_bug;
> +
> +extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> +
> +struct {
> +        __uint(type, BPF_MAP_TYPE_ARRAY);
> +        __type(key, int);
> +        __type(value, struct map_value);
> +        __uint(max_entries, 1);
> +} some_nodes SEC(".maps");
> +
> +SEC("tc")
> +long stash_rb_node(void *ctx)
> +{
> +	struct map_value *mapval;
> +	struct node_data *res;
> +	int key = 0;
> +
> +	res = bpf_obj_new(typeof(*res));
> +	if (!res)
> +		return 1;
> +	res->key = 42;
> +
> +	mapval = bpf_map_lookup_elem(&some_nodes, &key);
> +	if (!mapval) {
> +		bpf_obj_drop(res);
> +		return 1;
> +	}
> +
> +	res = bpf_kptr_xchg(&mapval->node, res);
> +	if (res)
> +		bpf_obj_drop(res);

May be add another tc prog with 2nd bpf_prog_test_run_opts that does:
res = bpf_kptr_xchg(&mapval->node, NULL);
and bpf_obj_drop-s it for real?

The first stash_rb_node() can allocate two objs into key=0 and key=1
the 2nd prog can bpf_kptr_xchg only one of them,
so we test both dtor on map free and explicit xchg+obj_drop.

wdyt?
