Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A216E17DF
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 01:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDMXIK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMXIJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 19:08:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848040C5
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 16:08:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b145b3b03so3080657b3a.1
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681427288; x=1684019288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MALz0m0txvybjB4SLEpHYk1wdYAhSEZKid4Jw56mnBI=;
        b=pdLRcBxmYan2Qzv0f5eMPpU/qaRZaf1b039PFqbxyTEGWjId5srOdiX4U/DYbRK8yR
         Dzx/eZAwlHPbutIikvgqMkM1b7i6HTJAtRh5BHKxm07iVPVNpGsDBoTSHneX4dUjaSO9
         VR0epmSAvJ5Vi2M8S2zR9MZyI0Z7yrz/quNNK10GmeoK35NjBqwFqguXRDdjgKX8YK0n
         ABfEUyl612RiwdwhbTvihKQvIBjE2WCxwpXbFCJ0ou6d/WMvxIEZilejefBLZRETVPQX
         gmAyPCX3ZgHUOHhC6c7p40E3WV8wgN5zWADDX2d1p6KnaYqIDVTC3NWrv/fyDXbO73AT
         6zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427288; x=1684019288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MALz0m0txvybjB4SLEpHYk1wdYAhSEZKid4Jw56mnBI=;
        b=N1rGQ4KmFRy+x6fZBOuzNhYfCyT5or65wJRrjWxa7n3A8F77VMvjYz1DRbjQrZ6hZn
         o5viLedYOC9Ou1AhLqlsploPZuyrOvVDtgk80els9s5aixwWkLOrylEseDh+inMxKoKN
         a8mSQ++eeTE9RBrfay/XM0bqcNcZ1hJ/b2tBJXzmh7vx4lhQwyYk2tMKzrq4YiRZC0OF
         mp0gNqHkHtR9v1+6I8ajOeJsWThANT8Etw++BEwuqoiraS8BYTWhk19QKoOenVidIZq7
         chOCQB7EPbCN5VAx2nhEjseXLAp7PivWFvea8m2whpFsxaPOrb0xwbi6bmOwOVl/a0fF
         w9aw==
X-Gm-Message-State: AAQBX9dmaeja3kvxlkFeSS694TgzovcwZVg5sVk+vgd9/v8S277ylQ4u
        5tKI9MyDQsEAGVYxW4Wnvsw=
X-Google-Smtp-Source: AKy350YYhoksRouvM8LBCzVXmZ155q/sTxRBnqti26T8KNTELDQnDbccVwz4XA2Ys9/f/t+wRYHcTg==
X-Received: by 2002:a05:6a00:1d89:b0:63b:1415:6c15 with SMTP id z9-20020a056a001d8900b0063b14156c15mr8077571pfw.13.1681427287903;
        Thu, 13 Apr 2023 16:08:07 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5f5b])
        by smtp.gmail.com with ESMTPSA id k20-20020aa790d4000000b005a8dd86018dsm1855066pfk.64.2023.04.13.16.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:08:07 -0700 (PDT)
Date:   Thu, 13 Apr 2023 16:08:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 bpf-next 9/9] selftests/bpf: Add refcounted_kptr tests
Message-ID: <20230413230805.kpjefr76emo7pc43@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
 <20230410190753.2012798-10-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410190753.2012798-10-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 10, 2023 at 12:07:53PM -0700, Dave Marchevsky wrote:
> Test refcounted local kptr functionality added in previous patches in
> the series.
> 
> Usecases which pass verification:
> 
> * Add refcounted local kptr to both tree and list. Then, read and -
>   possibly, depending on test variant - delete from tree, then list.
>   * Also test doing read-and-maybe-delete in opposite order
> * Stash a refcounted local kptr in a map_value, then add it to a
>   rbtree. Read from both, possibly deleting after tree read.
> * Add refcounted local kptr to both tree and list. Then, try reading and
>   deleting twice from one of the collections.
> * bpf_refcount_acquire of just-added non-owning ref should work, as
>   should bpf_refcount_acquire of owning ref just out of bpf_obj_new
> 
> Usecases which fail verification:
> 
> * The simple successful bpf_refcount_acquire cases from above should
>   both fail to verify if the newly-acquired owning ref is not dropped
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../bpf/prog_tests/refcounted_kptr.c          |  18 +
>  .../selftests/bpf/progs/refcounted_kptr.c     | 410 ++++++++++++++++++
>  .../bpf/progs/refcounted_kptr_fail.c          |  72 +++
>  3 files changed, 500 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> new file mode 100644
> index 000000000000..2ab23832062d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "refcounted_kptr.skel.h"
> +#include "refcounted_kptr_fail.skel.h"
> +
> +void test_refcounted_kptr(void)
> +{
> +	RUN_TESTS(refcounted_kptr);
> +}
> +
> +void test_refcounted_kptr_fail(void)
> +{
> +	RUN_TESTS(refcounted_kptr_fail);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> new file mode 100644
> index 000000000000..b444e4cb07fb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +struct node_data {
> +	long key;
> +	long list_data;
> +	struct bpf_rb_node r;
> +	struct bpf_list_node l;
> +	struct bpf_refcount ref;
> +};
> +
> +struct map_value {
> +	struct node_data __kptr *node;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct map_value);
> +	__uint(max_entries, 1);
> +} stashed_nodes SEC(".maps");
> +
> +struct node_acquire {
> +	long key;
> +	long data;
> +	struct bpf_rb_node node;
> +	struct bpf_refcount refcount;
> +};
> +
> +#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
> +private(A) struct bpf_spin_lock lock;
> +private(A) struct bpf_rb_root root __contains(node_data, r);
> +private(A) struct bpf_list_head head __contains(node_data, l);
> +
> +private(B) struct bpf_spin_lock alock;
> +private(B) struct bpf_rb_root aroot __contains(node_acquire, node);
> +
> +static bool less(struct bpf_rb_node *node_a, const struct bpf_rb_node *node_b)
> +{
> +	struct node_data *a;
> +	struct node_data *b;
> +
> +	a = container_of(node_a, struct node_data, r);
> +	b = container_of(node_b, struct node_data, r);
> +
> +	return a->key < b->key;
> +}
> +
> +static bool less_a(struct bpf_rb_node *a, const struct bpf_rb_node *b)
> +{
> +	struct node_acquire *node_a;
> +	struct node_acquire *node_b;
> +
> +	node_a = container_of(a, struct node_acquire, node);
> +	node_b = container_of(b, struct node_acquire, node);
> +
> +	return node_a->key < node_b->key;
> +}
> +
> +static __always_inline
> +long __insert_in_tree_and_list(struct bpf_list_head *head,
> +			       struct bpf_rb_root *root,
> +			       struct bpf_spin_lock *lock)
> +{
> +	struct node_data *n, *m;
> +
> +	n = bpf_obj_new(typeof(*n));
> +	if (!n)
> +		return -1;
> +
> +	m = bpf_refcount_acquire(n);
> +	m->key = 123;
> +	m->list_data = 456;
> +
> +	bpf_spin_lock(lock);
> +	if (bpf_rbtree_add(root, &n->r, less)) {
> +		/* Failure to insert - unexpected */
> +		bpf_spin_unlock(lock);
> +		bpf_obj_drop(m);
> +		return -2;
> +	}
> +	bpf_spin_unlock(lock);
> +
> +	bpf_spin_lock(lock);
> +	if (bpf_list_push_front(head, &m->l)) {
> +		/* Failure to insert - unexpected */
> +		bpf_spin_unlock(lock);
> +		return -3;
> +	}
> +	bpf_spin_unlock(lock);
> +	return 0;
> +}
> +
> +static __always_inline
> +long __stash_map_insert_tree(int idx, int val, struct bpf_rb_root *root,
> +			     struct bpf_spin_lock *lock)
> +{
> +	struct map_value *mapval;
> +	struct node_data *n, *m;
> +
> +	mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
> +	if (!mapval)
> +		return -1;
> +
> +	n = bpf_obj_new(typeof(*n));
> +	if (!n)
> +		return -2;
> +
> +	n->key = val;
> +	m = bpf_refcount_acquire(n);
> +
> +	n = bpf_kptr_xchg(&mapval->node, n);
> +	if (n) {
> +		bpf_obj_drop(n);
> +		bpf_obj_drop(m);
> +		return -3;
> +	}
> +
> +	bpf_spin_lock(lock);
> +	if (bpf_rbtree_add(root, &m->r, less)) {
> +		/* Failure to insert - unexpected */
> +		bpf_spin_unlock(lock);
> +		return -4;
> +	}
> +	bpf_spin_unlock(lock);
> +	return 0;
> +}
> +
> +static __always_inline
> +long __read_from_tree(struct bpf_rb_root *root, struct bpf_spin_lock *lock,
> +		      bool remove_from_tree)
> +{
> +	struct bpf_rb_node *rb;
> +	struct node_data *n;
> +	long res = -99;
> +
> +	bpf_spin_lock(lock);
> +
> +	rb = bpf_rbtree_first(root);
> +	if (!rb) {
> +		bpf_spin_unlock(lock);
> +		return -1;
> +	}
> +
> +	n = container_of(rb, struct node_data, r);
> +	res = n->key;
> +
> +	if (!remove_from_tree) {
> +		bpf_spin_unlock(lock);
> +		return res;
> +	}
> +
> +	rb = bpf_rbtree_remove(root, rb);
> +	bpf_spin_unlock(lock);
> +	if (!rb) {
> +		return -2;
> +	}
> +	n = container_of(rb, struct node_data, r);
> +	bpf_obj_drop(n);
> +	return res;
> +}
> +
> +static __always_inline
> +long __read_from_list(struct bpf_list_head *head, struct bpf_spin_lock *lock,
> +		      bool remove_from_list)
> +{
> +	struct bpf_list_node *l;
> +	struct node_data *n;
> +	long res = -99;
> +
> +	bpf_spin_lock(lock);
> +
> +	l = bpf_list_pop_front(head);
> +	if (!l) {
> +		bpf_spin_unlock(lock);
> +		return -1;
> +	}
> +
> +	n = container_of(l, struct node_data, l);
> +	res = n->list_data;
> +
> +	if (!remove_from_list) {
> +		if (bpf_list_push_back(head, &n->l)) {
> +			bpf_spin_unlock(lock);
> +			return -2;
> +		}
> +	}
> +
> +	bpf_spin_unlock(lock);
> +
> +	if (remove_from_list)
> +		bpf_obj_drop(n);
> +	return res;
> +}
> +
> +static __always_inline

Why __always_inline in this 5 helpers?
Will it pass the verifier if __always_inline is replaced with noinline?

> +long __read_from_unstash(int idx)
