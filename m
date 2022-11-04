Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED0561A54A
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKDXBR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKDXBN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:01:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBB63E0BA;
        Fri,  4 Nov 2022 16:01:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so16827413ejb.13;
        Fri, 04 Nov 2022 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mnBGC6ns2QKQUwsYssAlJWYsRWuUiXzRM8wUSXllHeY=;
        b=AetqL+GCSI422/2hCgfq4OKkij9RKW/lJHEtnZQzEoFQsQzeQEKibXavqnXftAnlW4
         I1IE20LMF7RLclidBfU6Rvspd47G4d/CsdXshcIPHgtECQNxukRcNE9JifOPIcUBcseP
         7tF+veaWTNEErB/Q/siVtNrVxEN7a3b7bR6GWl4748nJZzeBKeQzQMTM+xPzOOtmuIy1
         1NDHvcuUsKLiW4wRllKoOpbj9DgazsdWHjTmRLDZXQFqhXeQ2aOQyY0Z6Ht4qVgigBsL
         EjIVH5Behz9OhqNcXlhKRb0mgHnUGHreb+Dd2Ww8Fx8Z9Q4YDAOp3f0aNRY0lFQIFvYf
         XZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnBGC6ns2QKQUwsYssAlJWYsRWuUiXzRM8wUSXllHeY=;
        b=rbshBBZZasceu2AIdgEVTKgYUwToVtTKmJn+6NPmilHAHP0GEeat1ejYqb4+72n1FT
         cYMFOttH09QIW29z0GcR1xUZAAX4hRcjvLzKZpo68Ob/WAyfn4k2sQwMwZFTx3J0aJzq
         BT3mLpHyTfb2cCemnMO+HwGIasYwboH4g98ePxBsPelPwkaeLYMn+EoQfBimJb+64LMT
         iQeOJy+85QG/8m+ixlH5N+DobYZk5/Z/D414n+MvPYT22xYxPeUp8nHQP7TvxfbhWq26
         XGO7ZHQJLxTsvxjFy6g6kn0WvFfPa8OEHz4qRIG8SEQrakWEO93Lc3tyBmiU/2OPlkIA
         kPAA==
X-Gm-Message-State: ACrzQf25+uM7uEUR876MsPzC6VH9zbSGPAdOlI6tE3crqZSchB9Qly+R
        wYeVZn3x1MT6aVAcg+y3NglSOl0w7OHDYABru40=
X-Google-Smtp-Source: AMsMyM7TsBN+QDYqHM6OoAfK4Gq41wUB6NminuI/stPHxMvIX4PzuvKL3z2q/CdIq16MG0QJpX3PWRFCM2TL6zSHNqU=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr36127820ejn.302.1667602871140; Fri, 04
 Nov 2022 16:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221104172140.19762-1-donald.hunter@gmail.com>
In-Reply-To: <20221104172140.19762-1-donald.hunter@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 16:00:59 -0700
Message-ID: <CAEf4BzYpNd_oM6n4eW6UqF5n60xkvTarhbcyCgJSCDFtg1rm4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] docs/bpf: Document BPF map types QUEUE and STACK
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 4, 2022 at 10:21 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Add documentation for BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK,
> including usage and examples.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/map_queue_stack.rst | 119 ++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/bpf/map_queue_stack.rst
>
> diff --git a/Documentation/bpf/map_queue_stack.rst b/Documentation/bpf/map_queue_stack.rst
> new file mode 100644
> index 000000000000..a27e7f573869
> --- /dev/null
> +++ b/Documentation/bpf/map_queue_stack.rst
> @@ -0,0 +1,119 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +=========================================
> +BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK
> +=========================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` were introduced
> +     in kernel version 4.20
> +
> +``BPF_MAP_TYPE_QUEUE`` provides FIFO storage and ``BPF_MAP_TYPE_STACK``
> +provides LIFO storage for BPF programs. These maps support peek, pop and
> +push operations that are exposed to BPF programs through the respective
> +helpers. These operations are exposed to userspace applications using
> +the existing ``bpf`` syscall in the following way:
> +
> +- ``BPF_MAP_LOOKUP_ELEM`` -> peek
> +- ``BPF_MAP_LOOKUP_AND_DELETE_ELEM`` -> pop
> +- ``BPF_MAP_UPDATE_ELEM`` -> push
> +
> +``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` do not support
> +``BPF_F_NO_PREALLOC``.
> +
> +Usage
> +=====
> +
> +Kernel BPF
> +----------
> +
> +.. c:function::
> +   long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
> +
> +An element ``value`` can be added to a queue or stack using the
> +``bpf_map_push_elem()`` helper. If ``flags`` is set to ``BPF_EXIST``
> +then, when the queue or stack is full, the oldest element will be
> +removed to make room for ``value`` to be added. Returns ``0`` on
> +success, or negative error in case of failure.
> +
> +.. c:function::
> +   long bpf_map_peek_elem(struct bpf_map *map, void *value)
> +
> +This helper fetches an element ``value`` from a queue or stack without
> +removing it. Returns ``0`` on success, or negative error in case of
> +failure.
> +
> +.. c:function::
> +   long bpf_map_pop_elem(struct bpf_map *map, void *value)
> +
> +This helper removes an element into ``value`` from a queue or
> +stack. Returns ``0`` on success, or negative error in case of failure.
> +
> +
> +Userspace
> +---------
> +
> +.. c:function::
> +   int bpf_map_update_elem (int fd, const void *key, const void *value, __u64 flags)
> +
> +A userspace program can push ``value`` onto a queue or stack using libbpf's
> +``bpf_map_update_elem`` function. The ``key`` parameter must be set to
> +``NULL`` and ``flags`` must be set to ``BPF_ANY``. Returns ``0`` on
> +success, or negative error in case of failure.
> +
> +.. c:function::
> +   int bpf_map_lookup_elem (int fd, const void *key, void *value)
> +
> +A userspace program can peek at the ``value`` at the head of a queue or stack
> +using the libbpf ``bpf_map_lookup_elem`` function. The ``key`` parameter must be
> +set to ``NULL``.  Returns ``0`` on success, or negative error in case of
> +failure.
> +
> +.. c:function::
> +   int bpf_map_lookup_and_delete_elem (int fd, const void *key, void *value)
> +
> +A userspace program can pop a ``value`` from the head of a queue or stack using
> +the libbpf ``bpf_map_lookup_and_delete_elem`` function. The ``key`` parameter
> +must be set to ``NULL``. Returns ``0`` on success, or negative error in case of
> +failure.
> +
> +Examples
> +========
> +
> +Kernel BPF
> +----------
> +
> +This snippet shows how to declare a queue in a BPF program:
> +
> +.. code-block:: c
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_QUEUE);
> +            __type(value, __u32);
> +            __uint(max_entries, 10);
> +    } queue SEC(".maps");
> +
> +
> +Userspace
> +---------
> +
> +This snippet shows how to use libbpf to create a queue from userspace:

I'd prefer "how to use libbpf's low-level API to create a queue".
Because ideally people use the declarative way shown above, which is
also "use libbpf to create", but is simpler and preserves all the BTF
type information (if map supports it).

> +
> +.. code-block:: c
> +
> +    int create_queue()
> +    {
> +            return bpf_map_create(BPF_MAP_TYPE_QUEUE,
> +                                  "sample_queue", /* name */
> +                                  0,              /* key size, must be zero */
> +                                  sizeof(__u32),  /* value size */
> +                                  10,             /* max entries */
> +                                  0);             /* create options */

NULL, it's a pointer

> +    }
> +
> +
> +References
> +==========
> +
> +https://lwn.net/ml/netdev/153986858555.9127.14517764371945179514.stgit@kernel/
> --
> 2.35.1
>
