Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE39B624FEE
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 02:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiKKBxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 20:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiKKBxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 20:53:01 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A2A2528A;
        Thu, 10 Nov 2022 17:52:59 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 130so3653722pfu.8;
        Thu, 10 Nov 2022 17:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSves6T2VscWWVfh6E8+PPSabNuOENMRhg8aD/xuOJI=;
        b=MN2B+jgYSSwtyAoXyTtQE8FH37n8+Yi3AMPSQdoJxvC/2EYIwJuKdHZzN3OW1W/8NR
         5R7D6RYCCCyPZV07YlhcOJuDkH1lxG7Ewxe0pzQBhIiD1DW5nomtPOjb39lOnsnzbvoC
         9guodIhgS7u417xTKHy9AUWneNLjaydqc8ywMFK6XBFOUONZJKm1R/zn9dB+J7xyK2+S
         IllTeu/gPD+oH9vtn2S2/EIuO9T7l7uhLWlEJ0eKYDV0pM5TiX499XHV3RSK5OufeXqa
         4hSLYjRwlJvW7AfkLXDRxBVs6k0hzjwvjrc25EMkctYCdvYkpy24sWaFZQHlc+2wwj+/
         4D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSves6T2VscWWVfh6E8+PPSabNuOENMRhg8aD/xuOJI=;
        b=Uqh8/vDhJqgPn/Pnn7pruCJkPcy35KX1G5pO2F16ODUDQ2VCPmlK+AqBLkXAeykVne
         tdyUGFXGcuD3OPhjuQGRXZ0LcUCumdmcnkX4SwJfbLZghsD388GyyfosUGUWXzXlftxx
         z2V4GETfHlobu3QL3WSObgvkSaEjouAjufV0RbGs7YDIpKUo1VwS9P7Bct62i9E6Izlq
         UNUlNyZ/eNtwcJ3bE9PHJrbfEu6KiPTl6dpPuqckPeFaiTPnplevbEclibHtiB1jSKY8
         ZOZ0wNdLEZavv7QObxsSjzAc4L+ZkFoV2EAfBPRruGVX/FcbhavajRns/RGeatbvtiHI
         CBRg==
X-Gm-Message-State: ANoB5pn1RQngNGqybNEdt29TyUUwCUpiK+/yzB4q/y70IncUC6rXPJ7u
        KyE+rE0zB8sLnHvIiL8Jbfg=
X-Google-Smtp-Source: AA0mqf4gyN3+xq0NKaNr5gcq0OievfcRKCJuoURukb8+QtTCH5pwjx4XHnX/rI2G0jI1hVdqRBYOQA==
X-Received: by 2002:a05:6a00:1a43:b0:562:5f71:d188 with SMTP id h3-20020a056a001a4300b005625f71d188mr316476pfv.57.1668131579227;
        Thu, 10 Nov 2022 17:52:59 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b001766a3b2a26sm353188plg.105.2022.11.10.17.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 17:52:58 -0800 (PST)
Message-ID: <a19ed399-0dfd-4d2a-be9d-e39445ab470c@gmail.com>
Date:   Fri, 11 Nov 2022 08:52:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v10 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Tucker <dave@dtucker.co.uk>,
        Maryam Tahhan <mtahhan@redhat.com>
References: <20221109174604.31673-1-donald.hunter@gmail.com>
 <20221109174604.31673-2-donald.hunter@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221109174604.31673-2-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/10/22 00:46, Donald Hunter wrote:
> From: Dave Tucker <dave@dtucker.co.uk>
> 
> Add documentation for the BPF_MAP_TYPE_ARRAY including kernel version
> introduced, usage and examples. Also document BPF_MAP_TYPE_PERCPU_ARRAY
> which is similar.
> 
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> Co-developed-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Reviewed-by: Maryam Tahhan <mtahhan@redhat.com>
> ---
>  Documentation/bpf/map_array.rst | 250 ++++++++++++++++++++++++++++++++
>  1 file changed, 250 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst
> 
> diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
> new file mode 100644
> index 000000000000..97bb80333254
> --- /dev/null
> +++ b/Documentation/bpf/map_array.rst
> @@ -0,0 +1,250 @@
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
> +
> +Kernel BPF
> +----------
> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
> +This helper returns a pointer into the array element, so to avoid data races
> +with userspace reading the value, the user must use primitives like
> +``__sync_fetch_and_add()`` when updating the value in-place.
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> +
> +Array elements can be updated using the ``bpf_map_update_elem()`` helper.
> +
> +``bpf_map_update_elem()`` returns 0 on success, or negative error in case of
> +failure.
> +
> +Since the array is of constant size, ``bpf_map_delete_elem()`` is not supported.
> +To clear an array element, you may use ``bpf_map_update_elem()`` to insert a
> +zero value to that index.
> +
> +Per CPU Array
> +~~~~~~~~~~~~~
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
> +Userspace
> +---------
> +
> +Access from userspace uses libbpf APIs with the same names as above, with
> +the map identified by its ``fd``.
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

LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

