Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9638A60545C
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 02:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJTAFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 20:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJTAFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 20:05:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876DB13C3CE;
        Wed, 19 Oct 2022 17:05:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z97so27543171ede.8;
        Wed, 19 Oct 2022 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nlmH6A9hbUfA0KfFR+KYfz6FaVJkXOfdGc8fbB3clvA=;
        b=l0e0ITI9UyTMbwZAqbCLt4D0XC4FyexnHLscnSWKO2BVF4hiflqFQ2eRuhLGSSBtKb
         1wLU8bTCQ0No4saQXAhO9rgB7S57oLPwHZyVZPOGhpRYqfOvokm3n/kPF+iTSqDzqc/r
         hhul+cJzk+Ih4oJIBQdE9aZkKXmNfSqB/AxQxdqGc92Beo6rDwmNodf3d66MB7o8+1Ni
         SmzqoR78XgwWeNPLyatiL32h1p5BEER2IslM9diQ8bM9U/rMnTbb7NDM8iYhoopdTjks
         +C+rfpjNpGoSfuru931U+lQs05tpjjj6TTPvQVKt/+eaSQ4zyRCy+wvbutcDQ3rOqfGS
         tOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlmH6A9hbUfA0KfFR+KYfz6FaVJkXOfdGc8fbB3clvA=;
        b=nRjWyLMx4ElkFndWF0via5sri5sIlKuBVqAkLEP+mWkwysGBdU9uXCNI4LrDrP74Xg
         YYalalqs9p+EC2dEO0A4hzj54w0yQankB+70zbzah4a0mq9oPPS4AmXxyDNZqXf5sWo8
         wnkZEmkm3FVUna3bJ1oadU4iDFAkLNtuDC2BWqptXO6PwA0rXVk5zSg7jruv4YPvPEk0
         m2R0A6YuXnJVJqd3u0H0guj0ZBHr0kOklb2AqLa20xjGhf1mhS+S3ddCF1Q5F7W7JH8k
         NBstL4qujek0euOQsTUJqBf1VqqL3nd7l2f1wXpsCK0NfcSDvy9Akb0qE0aPkw1WQBNc
         uoGA==
X-Gm-Message-State: ACrzQf3A2vCg4te4X7RslJfOz/+yfkBinP0eH7NnMW/cmcNuCboD1dzd
        FFX1yHJ8cnA+QW7MqEp899I+dixIMiZ/oRxJXt+pR7LE
X-Google-Smtp-Source: AMsMyM4yU/RDBlVdKI0XIEucbN+ZrqEble57eMVNEzDB3yeByrj0cGv6PDyzP93Z4coqFitkQYJKdignicyBWRCta7w=
X-Received: by 2002:a05:6402:22ef:b0:458:bfe5:31a3 with SMTP id
 dn15-20020a05640222ef00b00458bfe531a3mr9655696edb.6.1666224343740; Wed, 19
 Oct 2022 17:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221007162755.36677-1-donald.hunter@gmail.com> <20221007162755.36677-2-donald.hunter@gmail.com>
In-Reply-To: <20221007162755.36677-2-donald.hunter@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 17:05:32 -0700
Message-ID: <CAADnVQLRyP2hgvmLubnCdZuPHofQ8CGRiGq_a2FQy_ZzRimiEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        dave@dtucker.co.uk
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

On Fri, Oct 7, 2022 at 9:39 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> From: Dave Tucker <dave@dtucker.co.uk>
>
> Add documentation for the BPF_MAP_TYPE_ARRAY including kernel version
> introduced, usage and examples. Also document BPF_MAP_TYPE_PERCPU_ARRAY
> which is similar.
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/map_array.rst | 232 ++++++++++++++++++++++++++++++++
>  1 file changed, 232 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst
>
> diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
> new file mode 100644
> index 000000000000..c3c56ffe5334
> --- /dev/null
> +++ b/Documentation/bpf/map_array.rst
> @@ -0,0 +1,232 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +================================================
> +BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
> +================================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_ARRAY`` was introduced in kernel version 3.19
> +   - ``BPF_MAP_TYPE_PERCPU_ARRAY`` was introduced in version 4.6
> +
> +``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array
> +storage. The key type is an unsigned 32-bit integer (4 bytes) and the map is
> +of constant size. The size of the array is defined in ``max_entries`` at
> +creation time. All array elements are pre-allocated and zero initialized when
> +created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
> +CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The value
> +stored can be of any size, however, small values will be rounded up to 8
> +bytes.

Actually all values are rounded up to 8.
Maybe we should say that all array elements are aligned to 8
instead of values are rounded?
Because values_size=4 stays as 4 from bpf prog pov.
The progs cannot access bytes 5,6,7,8 though that memory is consumed.

> +
> +Since kernel 5.5, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by
> +setting the flag ``BPF_F_MMAPABLE``. The map definition is page-aligned and
> +starts on the first page. Sufficient page-sized and page-aligned blocks of
> +memory are allocated to store all array values, starting on the second page,
> +which in some cases will result in over-allocation of memory. The benefit of
> +using this is increased performance and ease of use since userspace programs
> +would not be required to use helper functions to access and mutate data.
> +
> +Usage
> +=====
> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
> +This helper returns a pointer into the array element, so to avoid data races
> +with userspace reading the value, the user must use primitives like
> +``__sync_fetch_and_add()`` when updating the value in-place. Access from
> +userspace uses the libbpf API of the same name.
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> +
> +Array elements can also be added using the ``bpf_map_update_elem()`` helper or
> +libbpf API.
> +
> +``bpf_map_update_elem()`` returns 0 on success, or negative error in case of
> +failure.
> +
> +Since the array is of constant size, ``bpf_map_delete_elem()`` is not supported.
> +To clear an array element, you may use ``bpf_map_update_elem()`` to insert a
> +zero value to that index.
> +
> +Per CPU Array
> +-------------
> +
> +Values stored in ``BPF_MAP_TYPE_ARRAY`` can be accessed by multiple programs
> +across different CPUs. To restrict storage to a single CPU, you may use a
> +``BPF_MAP_TYPE_PERCPU_ARRAY``.
> +
> +When using a ``BPF_MAP_TYPE_PERCPU_ARRAY`` the ``bpf_map_update_elem()`` and
> +``bpf_map_lookup_elem()`` helpers automatically access the hash slot for the
> +current CPU.

hash slot?
the copy paste went wrong? :)

> +
> +.. c:function::
> +   void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void *key, u32 cpu)
> +
> +The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the array
> +value for a specific CPU. Returns value on success , or ``NULL`` if no entry was
> +found or ``cpu`` is invalid.
> +
> +Concurrency
> +-----------
> +
> +Since kernel version 5.1, the BPF infrastructure provides ``struct bpf_spin_lock``
> +to synchronize access.
> +
> +Examples
> +========
> +
> +Please see the ``tools/testing/selftests/bpf`` directory for functional
> +examples. The code samples below demonstrate API usage.
> +
> +Kernel BPF
> +----------
> +
> +This snippet shows how to declare an array in a BPF program.
> +
> +.. code-block:: c
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_ARRAY);
> +            __type(key, u32);
> +            __type(value, long);
> +            __uint(max_entries, 256);
> +    } my_map SEC(".maps");
> +
> +
> +This example BPF program shows how to access an array element.
> +
> +.. code-block:: c
> +
> +    int bpf_prog(struct __sk_buff *skb)
> +    {
> +            int index = load_byte(skb,
> +                                  ETH_HLEN + offsetof(struct iphdr, protocol));
> +            long *value;

Please avoid using deprecated instructions like load_byte in examples.

> +
> +            if (skb->pkt_type != PACKET_OUTGOING)
> +                    return 0;
> +
> +            value = bpf_map_lookup_elem(&my_map, &index);
> +            if (value)
> +                    __sync_fetch_and_add(value, skb->len);
> +
> +            return 0;
> +    }
> +
> +Userspace
> +---------
> +
> +BPF_MAP_TYPE_ARRAY
> +~~~~~~~~~~~~~~~~~~
> +
> +This snippet shows how to create an array, using ``bpf_map_create_opts`` to
> +set flags.
> +
> +.. code-block:: c
> +
> +    #include <bpf/libbpf.h>
> +    #include <bpf/bpf.h>
> +
> +    int create_array() {
> +            int fd;
> +            LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);

Add empty line pls.

> +            fd = bpf_map_create(BPF_MAP_TYPE_ARRAY,
> +                                "example_array",       /* name */
> +                                sizeof(__u32),         /* key size */
> +                                sizeof(long),          /* value size */
> +                                256,                   /* max entries */
> +                                &opts);                /* create opts */
> +            return fd;
> +    }
> +
> +This snippet shows how to initialize the elements of an array.
> +
> +.. code-block:: c
> +
> +    int initialize_array(int fd) {
> +            __u32 i;
> +            long value;
> +            int ret;
> +
> +            for (i = 0; i < 256; i++) {
> +                    value = i;
> +                    ret = bpf_map_update_elem(fd, &i, &value, BPF_ANY);
> +                    if (ret < 0)
> +                            return ret;
> +            }
> +
> +            return ret;
> +    }
> +
> +This snippet shows how to retrieve an element value from an array.
> +
> +.. code-block:: c
> +
> +    int lookup(int fd) {
> +            __u32 index = 42;
> +            long value;
> +            int ret = bpf_map_lookup_elem(fd, &index, &value);

Empty line pls.
Or better yet do 'int ret;'
and ret = bpf_map... on a separate line.

> +            if (ret < 0)
> +                    return ret;
> +
> +            /* use value here */
> +            assert(value == 42);
> +
> +            return ret;
> +    }
> +
> +BPF_MAP_TYPE_PERCPU_ARRAY
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This snippet shows how to initialize the elements of a per CPU array.
> +
> +.. code-block:: c
> +
> +    int initialize_array(int fd) {
> +            int ncpus = libbpf_num_possible_cpus();
> +            long values[ncpus];
> +            __u32 i, j;
> +            int ret;
> +
> +            for (i = 0; i < 256 ; i++) {
> +                    for (j = 0; j < ncpus; j++)
> +                            values[j] = i;
> +                    ret = bpf_map_update_elem(fd, &i, &values, BPF_ANY);
> +                    if (ret < 0)
> +                            return ret;
> +            }
> +
> +            return ret;
> +    }
> +
> +This snippet shows how to access the per CPU elements of an array value.
> +
> +.. code-block:: c
> +
> +    int lookup(int fd) {
> +            int ncpus = libbpf_num_possible_cpus();
> +            __u32 index = 42, j;
> +            long values[ncpus];
> +            int ret = bpf_map_lookup_elem(fd, &index, &values);

same here.

> +            if (ret < 0)
> +                    return ret;
> +
> +            for (j = 0; j < ncpus; j++) {
> +                    /* Use per CPU value here */
> +                    assert(values[j] == 42);
> +            }
> +
> +            return ret;
> +    }
> +
> +Semantics
> +=========
> +
> +As shown in the example above, when accessing a ``BPF_MAP_TYPE_PERCPU_ARRAY``
> +in userspace, each value is an array with ``ncpus`` elements.
> +
> +When calling ``bpf_map_update_elem()`` the flag ``BPF_NOEXIST`` can not be used
> +for these maps.
> --
> 2.35.1
>
