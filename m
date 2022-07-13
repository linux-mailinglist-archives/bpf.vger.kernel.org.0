Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426BA574010
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 01:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiGMXaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 19:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiGMXaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 19:30:17 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124E491DC
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:30:17 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f91-20020a17090a706400b001ef890a44e0so175223pjk.9
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3tMHBHSEGkpqSv57nbQsmTiS9I+Zeaov4FGtseRBzH0=;
        b=KzcVs9o6ybHk2CbxYA4wIgX5VUTsOSRfjF6+X6RSEertdAVA/wIJa6ZAZO0s/9pp4q
         19Jqkx6eHuVghSUlCl7KbBsUqOW3TvnkyRT5GdcKRyTCNAosBPywdhcCNqWMfpzqIeQs
         3VvXHl9DyY6IX9jtfQnrJli1eAJ6A0EzXrQuSgFOtoscbX9badHNn2po02hG15YVbVrw
         UR7KHyzKibREgkmqjcySQKwYKmhr5eRnPRi7bLEgyiM1wWOZpmHWmO6w8r9xO1FHuPrU
         spbHga+NlM6Os4+ciVAZ5FT4AJg2qKBdYzFrGHZaKSZcdM6A+MDq9dFgElV69zzdOOQu
         Ac+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3tMHBHSEGkpqSv57nbQsmTiS9I+Zeaov4FGtseRBzH0=;
        b=itbBAlemYYDpZVOU0RGEPMFKSFCbAAVD2uT9M3dQPK06CheNNKzuDyGgdkmZqJ87FP
         lwDwwkS0V1z3VpVtThXRfD8sNU87oCxVLOoREUQIYUD3TD+GEIwELN98TdDnEpxmzFJ/
         gaRf+tkrfp/Fe5YuGl3XuIyFsQzugm2rA67Yhlf4UJWPZyBJqP+o2ZB/3M8xWlShealr
         QoDc0eD1R+qcPeB346ebPcBE8A+Pn2QMo9VXcmi0Jv5Dw8Gc67nAjGGPi0WJgdgXkQRh
         u7ClcQfNoNpmspaWyOyQEBmtlllGh9fUO6DNLe7GItWByJuv1cLx82Nsx3UiAGC6DH9Q
         igUA==
X-Gm-Message-State: AJIora8qdIzvKPvLIVnC1WugVjX9SOK0USfPKRcAcG3FNeSAIb7Fu7v7
        8Djfjl+CwwbYtv2uPhVYgNAZusI=
X-Google-Smtp-Source: AGRyM1u+siN+hD3IeWNUBlRzgszyXkIfKl7nhe36zgbNOGMDb6JZqY4vvPICoOl9GulbflaUNPuroK0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:8343:b0:167:8899:2f92 with SMTP id
 z3-20020a170902834300b0016788992f92mr5492603pln.117.1657755016580; Wed, 13
 Jul 2022 16:30:16 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:30:15 -0700
In-Reply-To: <20220713211612.84782-1-donald.hunter@gmail.com>
Message-Id: <Ys9VhwanEB/T8/Ue@google.com>
Mime-Version: 1.0
References: <20220713211612.84782-1-donald.hunter@gmail.com>
Subject: Re: [PATCH] bpf, docs: document BPF_MAP_TYPE_HASH and variants
From:   sdf@google.com
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/13, Donald Hunter wrote:
> This commit adds documentation for BPF_MAP_TYPE_HASH including kernel
> version introduced, usage and examples. It also documents
> BPF_MAP_TYPE_PERCPU_HASH, BPF_MAP_TYPE_LRU_HASH and
> BPF_MAP_TYPE_LRU_PERCPU_HASH which are similar.

> Note that this file is included in the BPF documentation by the glob in
> Documentation/bpf/maps.rst

> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>   Documentation/bpf/map_hash.rst | 176 +++++++++++++++++++++++++++++++++
>   1 file changed, 176 insertions(+)
>   create mode 100644 Documentation/bpf/map_hash.rst

> diff --git a/Documentation/bpf/map_hash.rst  
> b/Documentation/bpf/map_hash.rst
> new file mode 100644
> index 000000000000..991452e70cc9
> --- /dev/null
> +++ b/Documentation/bpf/map_hash.rst
> @@ -0,0 +1,176 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2021 Red Hat, Inc.
> +
> +===============================================
> +BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
> +===============================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_HASH`` was introduced in kernel version 3.19
> +   - ``BPF_MAP_TYPE_PERCPU_HASH`` was introduced in version 4.6
> +   - Both ``BPF_MAP_TYPE_LRU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
> +     were introduced in version 4.10
> +
> +``BPF_MAP_TYPE_HASH`` and ``BPF_MAP_TYPE_PERCPU_HASH`` provide general
> +purpose hash map storage. Both the key and the value can be structs,
> +allowing for composite keys and values. The maximum number of entries is
> +defined in max_entries and is limited to 2^32. The kernel is responsible

Do we really need to mention 2^32 limit here? It really depends on
the key/value sizes, right?

Instead, might be worth talking about how/when this memory is allocated and
mention BPF_F_NO_PREALLOC?

> +for allocating and freeing key/value pairs, up to the max_entries limit
> +that you specify. ``BPF_MAP_TYPE_PERCPU_HASH`` provides a separate hash
> +table per CPU.
> +
> +Values stored in ``BPF_MAP_TYPE_HASH`` can be accessed concurrently by
> +programs running on different CPUs.  Since Kernel version 5.1, the BPF
> +infrastructure provides ``struct bpf_spin_lock`` to synchronize access.
> +
> +The ``BPF_MAP_TYPE_LRU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
> +variants add LRU semantics to their respective hash tables. An LRU hash
> +will automatically evict the least recently used entries when the hash
> +table reaches capacity. An LRU hash maintains an internal LRU list that
> +is used to select elements for eviction. This internal LRU list is
> +shared across CPUs but it is possible to request a per CPU LRU list with
> +the ``BPF_F_NO_COMMON_LRU`` flag when calling ``bpf_map_create``.
> +
> +Usage
> +=====
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const  
> void *value, u60 flags)

s/u60/u64/

> +
> +Hash entries can be added or updated using the ``bpf_map_update_elem()``
> +helper. This helper replaces existing elements atomically. The ``flags``
> +parameter can be used to control the update behaviour:
> +
> +- ``BPF_ANY`` will create a new element or update an existing element
> +- ``BPF_NOTEXIST`` will create a new element only if one did not already
> +  exist
> +- ``BPF_EXIST`` will update an existing element
> +
> +``bpf_map_update_elem()`` returns 0 on success, or negative error in
> +case of failure.
> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Hash entries can be retrieved using the ``bpf_map_lookup_elem()``
> +helper. This helper returns a pointer to the value associated with
> +``key``, or ``NULL`` if no entry was found.
> +
> +.. c:function::
> +   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
> +
> +Hash entries can be deleted using the ``bpf_map_delete_elem()``
> +helper. This helper will return 0 on success, or negative error in case
> +of failure.
> +
> +Per CPU Hashes
> +--------------
> +
> +For ``BPF_MAP_TYPE_PERCPU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
> +the ``bpf_map_update_elem()`` and ``bpf_map_lookup_elem()`` helpers
> +automatically access the hash slot for the current CPU.
> +
> +.. c:function::
> +   void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void  
> *key, u32 cpu)
> +
> +The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the
> +value in the hash slot for a specific CPU. Returns value associated with
> +``key`` on ``cpu`` , or ``NULL`` if no entry was found or ``cpu`` is
> +invalid.
> +
> +Userspace
> +---------
> +
> +.. c:function::
> +   int bpf_map_get_next_key (int fd, const void *cur_key, void *next_key)
> +
> +In userspace, is possible to iterate through the keys of a hash using
> +the ``bpf_map_get_next_key()`` function. The first key can be fetched by
> +calling ``bpf_map_get_next_key()`` with ``cur_key`` set to
> +``NULL``. Subsequent calls will fetch the next key that follows the
> +current key. ``bpf_map_get_next_key()`` returns 0 on success, -ENOENT if
> +cur_key is the last key in the hash, or negative error in case of
> +failure.
> +
> +Examples
> +========
> +
> +Please see the ``tools/testing/selftests/bpf`` directory for functional
> +examples.  This sample code demonstrates API usage.

[..]

> +Kernel
> +------
> +
> +.. code-block:: c
> +
> +    #include <linux/bpf.h>
> +    #include <bpf/bpf_helpers.h>
> +
> +    struct key {
> +        __u32 srcip;
> +    };
> +
> +    struct value {
> +        __u64 packets;
> +        __u64 bytes;
> +    };
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_LRU_HASH);
> +            __uint(max_entries, 32);
> +            __type(key, struct key);
> +            __type(value, struct value);
> +    } packet_stats SEC(".maps");
> +
> +    static inline void count_by_srcip(__u32 srcip, int bytes)
> +    {
> +            struct key key = {
> +                    .srcip = srcip
> +            };
> +            struct value *value = bpf_map_lookup_elem(&packet_stats,  
> &key);
> +            if (value) {
> +                    __sync_fetch_and_add(&value->packets, 1);
> +                    __sync_fetch_and_add(&value->bytes, bytes);
> +            } else {
> +                    struct value newval = { 1, bytes };
> +                    bpf_map_update_elem(&packet_stats, &key, &newval,  
> BPF_NOEXIST);
> +            }
> +    }
> +
> +Userspace
> +---------
> +
> +.. code-block:: c
> +
> +    #include <bpf/libbpf.h>
> +    #include <bpf/bpf.h>
> +
> +    static void print_values(int map_fd)
> +    {
> +            struct key *cur_key = NULL;
> +            struct key next_key;
> +            int next;
> +            do {
> +                    next = bpf_map_get_next_key(stats_fd, cur_key,  
> &next_key);
> +                    if (next == -ENOENT)
> +                            break;
> +                    if (next < 0) {
> +                            fprintf(stderr, "bpf_map_get_next_key %d  
> returned %s\n", stats_fd, strerror(-next));
> +                            break;
> +                    }
> +
> +                    struct in_addr src_addr = {
> +                            .s_addr = next_key.srcip
> +                    };
> +                    char *src_ip = inet_ntoa(src_addr);
> +
> +                    struct value value;
> +                    int ret = bpf_map_lookup_elem(stats_fd, &next_key,  
> &value);
> +                    if (ret < 0) {
> +                            fprintf(stderr, "Failed to lookup elem with  
> key %s: %s\n", src_ip, strerror(-ret));
> +                            break;
> +                    }
> +                    printf("%s: %lld packets, %lld bytes\n", src_ip,  
> value.packets, value.bytes);
> +                    cur_key = &next_key;
> +            } while (next == 0);
> +    }

Instead of adding c code, maybe add pointers to specific file within
tools/testing/selftests/bpf/progs ? That's what we've done for
prog_cgroup_sockopt; the actual tests are a bit more maintained than
the doc :-)
