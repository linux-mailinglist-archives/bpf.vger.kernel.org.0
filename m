Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9EF610CFB
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 11:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJ1JXH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 05:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJ1JXG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 05:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408DD1C6BE2
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666948927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5P/LL6n+AFbg9otfZiL41bboBVYLpgB4u6EYlg8Zxhc=;
        b=Fqjb1bcvJCjmw2nhUrw+8NHjTXYGmu0k2dEFyGlN4hKro8TJd5x1lhdeGWr6GG0emHu0cC
        sL+53Ni8Ok8f5MAwcDWXkexAY9Y7Hy168khx0WqjdvFfkTDy1L10G1tEVQnxUUrTgnwmpq
        fCs1e/A5trHh+F8VSuYAP1PIaxmGbNk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-cWoveRWZPIOcHg5_PCGX4g-1; Fri, 28 Oct 2022 05:22:05 -0400
X-MC-Unique: cWoveRWZPIOcHg5_PCGX4g-1
Received: by mail-ed1-f72.google.com with SMTP id z15-20020a05640240cf00b00461b253c220so2919413edb.3
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 02:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5P/LL6n+AFbg9otfZiL41bboBVYLpgB4u6EYlg8Zxhc=;
        b=pjwlYYVvpcjkDyFpkzvR5m4aKJDWbVh/eml9XKLDnu2xwV5TfHGTlLnlxjcNqHBbqA
         02t+Nl2HRHYsX5+Hgay+mlBio//KMFI0jyk7bYyeoGwbADsWKAoiS6TIHcr+twpkbGhp
         vcR9iTroMFdHNFtQY8GNhyank1LMYMBG4RHjCRnkfHI1GtPFGMRntnYBvvhgLTQ0WzFw
         b4GcI3JBaY6vBovG85hK6u9Ep5aJCK8ix5JH8Hj/IrEih0Ze2Ow54Y4VASHx/+hiilVh
         3MBGHn0UfNijDELbdlOYMgyCY8YXHFT+BBckC90/8ibf82zRDU+2pr3XallpqnLk+nxQ
         /PEw==
X-Gm-Message-State: ACrzQf1vfACBCxU61X0YAyNyP+Bo+6+p6niF1JgYpS8SdlwWT2pdEmSc
        HM1zdSvgR3BpD8Jt8BJGHJEpa98L0gnjBqJywXeakkOEs76bRddCHbUNrRexxk910+7RcClzq1s
        T6AayUNGlR5GB
X-Received: by 2002:a17:907:7d8e:b0:78d:ed30:643b with SMTP id oz14-20020a1709077d8e00b0078ded30643bmr45428653ejc.253.1666948924618;
        Fri, 28 Oct 2022 02:22:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4j/2fPa3s0HO+qy5YZC0lCKZmYPkr+Pw/cCwWJMHHSd+ww3jdyGEU+d3BUFhvzeqvKuGu4lg==
X-Received: by 2002:a17:907:7d8e:b0:78d:ed30:643b with SMTP id oz14-20020a1709077d8e00b0078ded30643bmr45428634ejc.253.1666948924316;
        Fri, 28 Oct 2022 02:22:04 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id ky9-20020a170907778900b00781dbdb292asm1928013ejc.155.2022.10.28.02.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 02:22:03 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <ea8948ed-a995-68bc-2d6e-57945f0d5249@redhat.com>
Date:   Fri, 28 Oct 2022 11:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Cc:     brouer@redhat.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH bpf-next v1] Document BPF_MAP_TYPE_LPM_TRIE
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221026100232.49181-1-donald.hunter@gmail.com>
In-Reply-To: <20221026100232.49181-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 26/10/2022 12.02, Donald Hunter wrote:
> Add documentation for BPF_MAP_TYPE_LPM_TRIE including kernel
> BPF helper usage, userspace usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>   Documentation/bpf/map_lpm_trie.rst | 179 +++++++++++++++++++++++++++++
>   1 file changed, 179 insertions(+)
>   create mode 100644 Documentation/bpf/map_lpm_trie.rst

LGTM

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

(no comments below, but kept it for others comment on)

> diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
> new file mode 100644
> index 000000000000..d57c967d11d0
> --- /dev/null
> +++ b/Documentation/bpf/map_lpm_trie.rst
> @@ -0,0 +1,179 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +=====================
> +BPF_MAP_TYPE_LPM_TRIE
> +=====================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_LPM_TRIE`` was introduced in kernel version 4.11
> +
> +``BPF_MAP_TYPE_LPM_TRIE`` provides a longest prefix match algorithm that
> +can be used to match IP addresses to a stored set of prefixes.
> +Internally, data is stored in an unbalanced trie of nodes that uses
> +``prefixlen,data`` pairs as its keys. The ``data`` is interpreted in
> +network byte order, i.e. big endian, so ``data[0]`` stores the most
> +significant byte.
> +
> +LPM tries may be created with a maximum prefix length that is a multiple
> +of 8, in the range from 8 to 2048. The key used for lookup and update
> +operations is a ``struct bpf_lpm_trie_key``, extended by
> +``max_prefixlen/8`` bytes.
> +
> +- For IPv4 addresses the data length is 4 bytes
> +- For IPv6 addresses the data length is 16 bytes
> +
> +The value type stored in the LPM trie can be any user defined type.
> +
> +.. note::
> +   When creating a map of type ``BPF_MAP_TYPE_LPM_TRIE`` you must set the
> +   ``BPF_F_NO_PREALLOC`` flag.
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
> +The longest prefix entry for a given data value can be found using the
> +``bpf_map_lookup_elem()`` helper. This helper returns a pointer to the
> +value associated with the longest matching ``key``, or ``NULL`` if no
> +entry was found.
> +
> +The ``key`` should have ``prefixlen`` set to ``max_prefixlen`` when
> +performing longest prefix lookups. For example, when searching for the
> +longest prefix match for an IPv4 address, ``prefixlen`` should be set to
> +``32``.
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> +
> +Prefix entries can be added or updated using the ``bpf_map_update_elem()``
> +helper. This helper replaces existing elements atomically.
> +
> +``bpf_map_update_elem()`` returns ``0`` on success, or negative error in
> +case of failure.
> +
> + .. note::
> +    The flags parameter must be one of BPF_ANY, BPF_NOEXIST or BPF_EXIST,
> +    but the value is ignored, giving BPF_ANY semantics.
> +
> +.. c:function::
> +   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
> +
> +Prefix entries can be deleted using the ``bpf_map_delete_elem()``
> +helper. This helper will return 0 on success, or negative error in case
> +of failure.
> +
> +Userspace
> +---------
> +
> +Access from userspace uses libbpf APIs with the same names as above, with
> +the map identified by ``fd``.
> +
> +.. c:function::
> +   int bpf_map_get_next_key (int fd, const void *cur_key, void *next_key)
> +
> +A userspace program can iterate through the entries in an LPM trie using
> +libbpf's ``bpf_map_get_next_key()`` function. The first key can be
> +fetched by calling ``bpf_map_get_next_key()`` with ``cur_key`` set to
> +``NULL``. Subsequent calls will fetch the next key that follows the
> +current key. ``bpf_map_get_next_key()`` returns ``0`` on success,
> +``-ENOENT`` if cur_key is the last key in the hash, or negative error in
> +case of failure.
> +
> +``bpf_map_get_next_key()`` will iterate through the LPM trie elements
> +from leftmost leaf first. This means that iteration will return more
> +specific keys before less specific ones.
> +
> +Examples
> +========
> +
> +Please see ``tools/samples/bpf/xdp_router_ipv4_user.c`` and
> +``xdp_router_ipv4.bpf.c`` for a functional example. The code snippets
> +below demonstrates API usage.
> +
> +Kernel BPF
> +----------
> +
> +The following BPF code snippet shows how to declare a new LPM trie for IPv4
> +address prefixes:
> +
> +.. code-block:: c
> +
> +    #include <linux/bpf.h>
> +    #include <bpf/bpf_helpers.h>
> +
> +    struct ipv4_lpm_key {
> +            __u32 prefixlen;
> +            __u32 data;
> +    };
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_LPM_TRIE);
> +            __type(key, struct ipv4_lpm_key);
> +            __type(value, __u32);
> +            __uint(map_flags, BPF_F_NO_PREALLOC);
> +            __uint(max_entries, 255);
> +    } ipv4_lpm_map SEC(".maps");
> +
> +The following BPF code snippet shows how to lookup by IPv4 address:
> +
> +.. code-block:: c
> +
> +    void *lookup(__u32 ipaddr)
> +    {
> +            struct ipv4_lpm_key key = {
> +                    .prefixlen = 32,
> +                    .data = ipaddr
> +            };
> +
> +            return bpf_map_lookup_elem(&ipv4_lpm_map, &key);
> +    }
> +
> +Userspace
> +---------
> +
> +The following snippet shows how to insert an IPv4 prefix entry into an LPM trie:
> +
> +.. code-block:: c
> +
> +    int add_prefix_entry(int lpm_fd, __u32 addr, __u32 prefixlen, struct value *value)
> +    {
> +            struct ipv4_lpm_key ipv4_key = {
> +                    .prefixlen = prefixlen,
> +                    .data = addr
> +            };
> +            return bpf_map_update_elem(lpm_fd, &ipv4_key, value, BPF_ANY);
> +    }
> +
> +The following snippet shows a userspace program walking through LPM trie
> +entries:
> +
> +.. code-block:: c
> +
> +    #include <bpf/libbpf.h>
> +    #include <bpf/bpf.h>
> +
> +    void iterate_lpm_trie(int map_fd)
> +    {
> +            struct ipv4_lpm_key *cur_key = NULL;
> +            struct ipv4_lpm_key next_key;
> +            struct value value;
> +            int err;
> +
> +            for (;;) {
> +                    err = bpf_map_get_next_key(map_fd, cur_key, &next_key);
> +                    if (err)
> +                            break;
> +
> +                    bpf_map_lookup_elem(map_fd, &next_key, &value);
> +
> +                    /* Use key and value here */
> +
> +                    cur_key = &next_key;
> +            }
> +    }

