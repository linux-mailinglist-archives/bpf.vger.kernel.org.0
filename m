Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C894760CE10
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 15:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiJYN5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiJYN5w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 09:57:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2735317EF36
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 06:57:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f27so2125887eje.1
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brouer-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+BqBnXL4AB7nK0cnTn3zcpDOUQqQWreX2HuiBe/uik=;
        b=4gFu6mKW8Fl7EwPW4SfBgWyEMqkb/g1aOmIP0cDMC9yaZcrll9xFoW4YfM8m2NQEH5
         5AKL0wzJsngDwOuekoWUdKjR8vTRabmhiXyF66eFrOXKKs9xEMr+4oRxr1MQb52lXQ4w
         dQJe2tFuQIvDUc+zyJ1MYpGxfwdSgDBSZnySxpX3z9tkzOy5RwNjP7jb0ETWC5ua1XAF
         ctpxxuzgjj5onKKhXWFXwdAYYkrXXTGui55FVsPBohoNFz/HEdZ1AldSgvEPk4OggBr2
         sDi+o2Ij2iW3ZIkvFjLAzc19zgje5eTA9rEF2egKTXD14kYPkgwLG/+vwuvY/Vms3nn6
         KB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+BqBnXL4AB7nK0cnTn3zcpDOUQqQWreX2HuiBe/uik=;
        b=oYF8+m1QohM12MvXXpQEnjc07F+iCqk189qD5E41O5TdaZYuGPc6JOx67MLWNu1d7G
         rlR5LqyG7zFXpRZCq3QI0Ycr3q7djE0vi1RDZYTyMTakXQQNgCrc7NFGM1G+DBSuPj2B
         GQk3FmVhOaHRUEJ981ltF10MxqO1oZZpoecWqG8nZltqLF8Vbod7JLciFWeyQcqO+i7J
         MpDSbMj6dpvDqZEIOlBkw19kEJszkdOah2etsI6J3grkJooxJtm5V7lnWZc5Xy34gd1D
         YIxxsCJo6TFgZep96gfhWqua8Dk3vRnaosIoY096ORsNB44W3mU/MaKxCK6TFvDovv2G
         cTAA==
X-Gm-Message-State: ACrzQf2xK4JA5d9MUAwF7gBab3ws7XCjrpFamgC9tqi+ZHYIe/GOzVRo
        W3VfGAfTCOH+34qPoF/8DzgFxg==
X-Google-Smtp-Source: AMsMyM7RCM+nrTgn/6kJIAP3AurC89ZOLnqBs+1+qO0xhUzXvoNOcD7HDB9ndcPteuMAPqCotSybbA==
X-Received: by 2002:a17:907:daa:b0:78d:9bc9:7d7a with SMTP id go42-20020a1709070daa00b0078d9bc97d7amr31831064ejc.567.1666706269611;
        Tue, 25 Oct 2022 06:57:49 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090611cb00b007877ad05b32sm1413710eja.208.2022.10.25.06.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:57:48 -0700 (PDT)
Message-ID: <5cd2d8ee-a0aa-070f-17c8-dacd816f0927@brouer.com>
Date:   Tue, 25 Oct 2022 15:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Cc:     brouer@redhat.com, dave@dtucker.co.uk,
        Toke Hoiland Jorgensen <toke@redhat.com>
Subject: Re: [PATCH bpf-next v8 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221021142259.18093-1-donald.hunter@gmail.com>
 <20221021142259.18093-2-donald.hunter@gmail.com>
From:   "Jesper D. Brouer" <netdev@brouer.com>
In-Reply-To: <20221021142259.18093-2-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 21/10/2022 16.22, Donald Hunter wrote:
> From: Dave Tucker <dave@dtucker.co.uk>
> 
> Add documentation for the BPF_MAP_TYPE_ARRAY including kernel version
> introduced, usage and examples. Also document BPF_MAP_TYPE_PERCPU_ARRAY
> which is similar.
> 
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>   Documentation/bpf/map_array.rst | 243 ++++++++++++++++++++++++++++++++
>   1 file changed, 243 insertions(+)
>   create mode 100644 Documentation/bpf/map_array.rst
> 
> diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
> new file mode 100644
> index 000000000000..3acc5a294428
> --- /dev/null
> +++ b/Documentation/bpf/map_array.rst
> @@ -0,0 +1,243 @@
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
> +stored can be of any size, however, all array elements are aligned to 8
> +bytes.
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

Can we make it more clear, that below refers to usage from BPF programs.
E.g. changing title "Usage" to something else, or create a sub-section.
Below we have subsections "Kernel BPF" and "Userspace", do set aside
kernel-side and userspace API users.

Sorry for bringing this up so late (v8), but I think it is important
that the documentation makes it easy for the reader to quickly grasp
which section is BPF-prog code and which is userspace libbpf APIs.
IMHO this should then be consistent across out docs.

> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
> +This helper returns a pointer into the array element, so to avoid data races
> +with userspace reading the value, the user must use primitives like
> +``__sync_fetch_and_add()`` when updating the value in-place. Access from
> +userspace uses the libbpf API of the same name >

When reading last sentence, the read will of-cause realize this was BPF
kernel-side code, as it reference userspace API (have same name).

--Jesper

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
> +``bpf_map_lookup_elem()`` helpers automatically access the slot for the current
> +CPU.
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
> +            struct iphdr ip;
> +            int index;
> +            long *value;
> +
> +            if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip, sizeof(ip)) < 0)
> +                    return 0;
> +
> +            index = ip.protocol;
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
> +    int create_array()
> +    {
> +            int fd;
> +            LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
> +
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
> +    int initialize_array(int fd)
> +    {
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
> +    int lookup(int fd)
> +    {
> +            __u32 index = 42;
> +            long value;
> +            int ret;
> +
> +            ret = bpf_map_lookup_elem(fd, &index, &value);
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
> +    int initialize_array(int fd)
> +    {
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
> +    int lookup(int fd)
> +    {
> +            int ncpus = libbpf_num_possible_cpus();
> +            __u32 index = 42, j;
> +            long values[ncpus];
> +            int ret;
> +
> +            ret = bpf_map_lookup_elem(fd, &index, &values);
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
