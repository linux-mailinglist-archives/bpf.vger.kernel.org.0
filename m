Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8B611ED3
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 02:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ2AzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 20:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ2AzE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 20:55:04 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E872501BA;
        Fri, 28 Oct 2022 17:55:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 128so6224301pga.1;
        Fri, 28 Oct 2022 17:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6L/XIpfLrrDquO6tCF0u0f6mLrqaV8V+i33a188p3w=;
        b=WdAeeTs94ndz0EV/BqPFJ9hkWGkj+K4NynGm9YtsDtRS+0hKeBrPdDlaBzIpRTywuZ
         jgynnDr74VMQwx/wMYPcGa1xGcEuDKg+Qsm8gQ+NV757NJNO2GG7nhMchHUEwCzrkm0/
         J6GVf+TQE/3sY6PGuA1Z2V7pjGI3jVuP8AGhRIqP0IHVDXpTSWycBdDxvelKd6yDDCEK
         uoC0KdoZJF5eDN709BQaIgI/Te3ydz63EIyQLWT88hJ0MoKwlmvF/IZaA35T0wrv4s12
         xbS57yETj0ASDuEZ7CNod334EkcSYG4Rh/DTTamOQ9tTZd9X19hO9mphKMKJDN6s1LiC
         bqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H6L/XIpfLrrDquO6tCF0u0f6mLrqaV8V+i33a188p3w=;
        b=0eyhxglmq407w54DWnVRf6z2hmEObGAz7AxW/NUuX9CYJAThwX2whFj6aHP4B8brLm
         7DRcpQAe6DqBTVgsPpk9lBARsHS75/6TRagc87r/HkhXEIcSD52YRPZStorD9cfuDaR1
         bZOlI6jRfhtKgogRIhP2MZ82g9rEzrLCNjcZXiI6lpPvbXudd/jgA/CwvG9WLbu84Jll
         iWN/oFSPX3hOYAQJUPDwkFWs2Jy2moaEbkQeg25Kass/an6rzeoe3bC1NLWGrukn1Hq2
         08aViVow+RbcCmHxW8FutiANpMhejKs6Dy/EX10kSvEMmwR1NYz/wY8atBBKFZDKW4AF
         njrw==
X-Gm-Message-State: ACrzQf0MCgJq4JWHOWeM9vQMzkICYgdJscjCPCaplD00f/IGcJHxwexw
        bsUsnFDTwjs4g4upSlTJkSnq2evFjAxYdQ==
X-Google-Smtp-Source: AMsMyM7Rsw63W6Y8Xiyd7uO+8P4cOl4E/sS3LicmgqwThuevMr6mxPY9oduYLLUgJRRbSD568AalJA==
X-Received: by 2002:a62:1d52:0:b0:56b:f472:55e7 with SMTP id d79-20020a621d52000000b0056bf47255e7mr2187708pfd.63.1667004901440;
        Fri, 28 Oct 2022 17:55:01 -0700 (PDT)
Received: from localhost ([98.97.41.13])
        by smtp.gmail.com with ESMTPSA id o68-20020a62cd47000000b0056283e2bdbdsm64656pfg.138.2022.10.28.17.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 17:55:00 -0700 (PDT)
Date:   Fri, 28 Oct 2022 17:54:59 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Donald Hunter <donald.hunter@gmail.com>
Message-ID: <635c79e315b77_b1ba20836@john.notmuch>
In-Reply-To: <20221026100232.49181-1-donald.hunter@gmail.com>
References: <20221026100232.49181-1-donald.hunter@gmail.com>
Subject: RE: [PATCH bpf-next v1] Document BPF_MAP_TYPE_LPM_TRIE
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Donald Hunter wrote:
> Add documentation for BPF_MAP_TYPE_LPM_TRIE including kernel
> BPF helper usage, userspace usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/map_lpm_trie.rst | 179 +++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
>  create mode 100644 Documentation/bpf/map_lpm_trie.rst
> 
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

The map ops lookup, update, delete and below userspace are pretty generic to
all map types. How about moving those into a generic file about maps? Maybe
./Documentation/bpf/mpas.rst? Then perhaps there is a way to link to
them from here.

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

So I tihnk none of this is specific to LPM tries.

> +
> +Examples
> +========
> +
> +Please see ``tools/samples/bpf/xdp_router_ipv4_user.c`` and

I wouldn't link to samples. Can we link to a selftest? Maybe move the
xdp_router_ipv4_user into a selftest otherwise no one ensures it is
always working.

> +``xdp_router_ipv4.bpf.c`` for a functional example. The code snippets
> +below demonstrates API usage.
> +
> +Kernel BPF
> +----------

rest lgtm. Thanks for working on docs.
