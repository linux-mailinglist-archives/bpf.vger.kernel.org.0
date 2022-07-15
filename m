Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9557655A
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiGOQhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOQhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 12:37:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240639B84
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 09:37:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h132so4852078pgc.10
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lq8LHq/BGE9Ttv/PU+Y1zlRn2zyw+umgc/uDGtzvvtY=;
        b=cGgc/MkU3EGC7YMXkGQivL7VhkfxCLdAOt+w2XKAAE7mxAQHtj68WXweO1Nzzbz7Lw
         gn547es0+zk40kW/RiNfDM0J3gRiDjjdgClpuzkupsikzcxx8+KvOM+Q1FhPelWgJiQ3
         zbB70GwkqaAXA2Zj2PcAF0WgJnZM4JWqikTKIJcBixxGO4qUjmnX8VlOtCVgxNSqeYdu
         SpBYHLA4GK4vUDD+lKrhd0wOKquC5joTDRe+wuxU0oanu7n1MqMI0Zmjb0m00/3la6sI
         oFpJokP0lwB78Sy8ePwoncRb1S9uvLGcqHfYrcjlquw4EcXxnnQPj4JojBlYlQMo+clD
         73XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lq8LHq/BGE9Ttv/PU+Y1zlRn2zyw+umgc/uDGtzvvtY=;
        b=qXNUt33/80vfcNacQW59FyJpLiuZqAWLKGhsFp8SMnegOkBM3Nmdl9sMaxmwL2KPW/
         l6nJlugPgOcgv2PJCHWDcghaGW7dvN3uN9PWLn++3fyCTXuYoUSgKnuLns8eauKpn02B
         JW65jqAJYsix7+qJxAgivFEgu7bRj+2VyioKriooX5CSjz7XGcPfl2Xs3xEMvoohC81W
         nllvMuFSY/RUBzdpbPv2MZ+pnY6Wa5sORWEZq6rBdJdNDBx7s7vBu64vZwk3HCZFvoqi
         UlqmVOZiVUgAu6nVUX3ndqo7cGjyUwHT3WI0UwhIGD6pZc9JI1SDo3fiu9+7R3gET+5Y
         69NA==
X-Gm-Message-State: AJIora+hZ2c1JKw5d1q7Wpsuk9nrgiTavD2z0aFDPrzRx3wgdPpCskhF
        HG/SkMFthKnFktIFpKTOoa5nyiSw1jDe8oazleTWzw==
X-Google-Smtp-Source: AGRyM1vCZ/OvZk/5dl8k9p/yOmNM7u8UyTGsPTnKBjNCz9c4rf199w/04gmqYQiTiIKiXuucpcG5+5e2+5TrwayQxfs=
X-Received: by 2002:a65:4c0b:0:b0:415:d3a4:44d1 with SMTP id
 u11-20020a654c0b000000b00415d3a444d1mr13139268pgq.191.1657903056623; Fri, 15
 Jul 2022 09:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220715130826.31632-1-donald.hunter@gmail.com>
In-Reply-To: <20220715130826.31632-1-donald.hunter@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 15 Jul 2022 09:37:25 -0700
Message-ID: <CAKH8qBsDZLMB29OONaKYBQn8r=HdVTOxog1vXyRFpV2h=6skcA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, docs: document BPF_MAP_TYPE_HASH and variants
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 15, 2022 at 6:08 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Add documentation for BPF_MAP_TYPE_HASH including kernel version
> introduced, usage and examples. Document BPF_MAP_TYPE_PERCPU_HASH,
> BPF_MAP_TYPE_LRU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH variations.
>
> Note that this file is included in the BPF documentation by the glob in
> Documentation/bpf/maps.rst
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/map_hash.rst | 181 +++++++++++++++++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/bpf/map_hash.rst
>
> diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
> new file mode 100644
> index 000000000000..d9e33152dae5
> --- /dev/null
> +++ b/Documentation/bpf/map_hash.rst
> @@ -0,0 +1,181 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
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
> +allowing for composite keys and values.
> +
> +The kernel is responsible for allocating and freeing key/value pairs, up
> +to the max_entries limit that you specify. Hash maps use pre-allocation
> +of hash table elements by default. The ``BPF_F_NO_PREALLOC`` flag can be
> +used to disable pre-allocation when it is to memory expensive.

nit:
to memory expensive -> too memory expensive?

> +``BPF_MAP_TYPE_PERCPU_HASH`` provides a separate value slot per
> +CPU. The per-cpu values are stored internally in an array.
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
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
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
> +   void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void *key, u32 cpu)
> +
> +The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the
> +value in the hash slot for a specific CPU. Returns value associated with
> +``key`` on ``cpu`` , or ``NULL`` if no entry was found or ``cpu`` is
> +invalid.
> +
> +Concurrency
> +-----------
> +
> +Values stored in ``BPF_MAP_TYPE_HASH`` can be accessed concurrently by
> +programs running on different CPUs.  Since Kernel version 5.1, the BPF
> +infrastructure provides ``struct bpf_spin_lock`` to synchronize access.
> +See ``tools/testing/selftests/bpf/progs/test_spin_lock.c``.
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
> +examples.  The sample code below demonstrates API usage.

I'd still personally prefer if you link to some existing test instead
of having a code sample here. This is the code nobody will keep
healthy here. Why do you think it's beneficial? Why not link to some
test case or some sample?


> +This example shows how to declare an LRU Hash with a struct key and a
> +struct value.
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
> +This example shows how to create or update hash values using atomic
> +instructions:
> +
> +.. code-block:: c
> +
> +    static inline void (__u32 srcip, int bytes)
> +    {
> +            struct key key = {
> +                    .srcip = srcip
> +            };
> +            struct value *value = bpf_map_lookup_elem(&packet_stats, &key);
> +            if (value) {
> +                    __sync_fetch_and_add(&value->packets, 1);
> +                    __sync_fetch_and_add(&value->bytes, bytes);
> +            } else {
> +                    struct value newval = { 1, bytes };
> +                    bpf_map_update_elem(&packet_stats, &key, &newval, BPF_NOEXIST);
> +            }
> +    }
> +
> +Userspace walking the map elements from the map declared above:
> +
> +.. code-block:: c
> +
> +    #include <bpf/libbpf.h>
> +    #include <bpf/bpf.h>
> +
> +    static void walk_hash_elements(int map_fd)
> +    {
> +            struct key *cur_key = NULL;
> +            struct key next_key;
> +            int next;
> +            do {
> +                    // error checking omitted
> +                    next = bpf_map_get_next_key(stats_fd, cur_key, &next_key);
> +                    if (next == -ENOENT)
> +                            break;
> +
> +                    struct in_addr src_addr = {
> +                            .s_addr = next_key.srcip
> +                    };
> +                    struct value value;
> +                    int ret = bpf_map_lookup_elem(stats_fd, &next_key, &value);
> +
> +                    // Use key and value here
> +
> +                    cur_key = &next_key;
> +            } while (next == 0);
> +    }
> --
> 2.35.1
>
