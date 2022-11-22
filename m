Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E883634402
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 19:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKVSvn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 13:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKVSvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 13:51:39 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33FC8C088;
        Tue, 22 Nov 2022 10:51:38 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-381662c78a9so153316207b3.7;
        Tue, 22 Nov 2022 10:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wyYgmoIn4HeZSR+/9M9uztkOd4c5KXqHcnsSYgkR+8w=;
        b=aPirDBEttAay4C76ks7d7AQhtMu6dKJZ6ZCrrKyhQy7YV3HRfstxKO6q0HnjHRXU+D
         WmVsOmYdDcfbPVNgIsTQ1+6MXvv97LnFZ1V7KxFb8uLwHUbOvYhqoyZPi8BNlybsX4pW
         xa7C9iNm7jWtxPA8CDOl80gvfaY7iJ35t/b49b51TBbf2ATkCsdI5dyDCH9V57LleqvN
         YiwkG5ygDWG4pXX9M9ehe2zQD1Br9213yO6Dd8nmaf7jZpPIXv/GLCSF/xNN/qOwk0Qa
         /9VxVHDPS8YCM2PUhzu2Yp2BA4kFrNAgzRPjelDfb0BspWtmXAz+TtEA+cz/79GWZUKa
         IChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyYgmoIn4HeZSR+/9M9uztkOd4c5KXqHcnsSYgkR+8w=;
        b=nUCzfVCGjGQxWR2p1VWrypLRmbOzszVBFyg2gBi3FaMCe0DJnqTN3GVIHP49N+XTXd
         ZbWQWqqpkkGXmHHKWrzo8ara7s8QIJkvCF8QFYlMX9H06mh89tUoR7uWTKWbqXikr8bO
         c4HwNrKa5n7ab15AtenI3U06DtEiveiBl8Wr51C3gauqkd4Q9iK9iekZnduH1Ebq89Oj
         qsmyO6lK1gNlqHWfZKL3uOPWXpC1elfU0Q6Hb2MoJL06RQ/gG9oPtP2tOVqo+fMx4wqG
         2iRxkikRXlFtaDXY50kVKjKV2A2m4ydruqD9yD0LNWF3koPZUcw2k8saFBR/mtaisxQw
         LgEA==
X-Gm-Message-State: ANoB5pkoEhrUnym95W9MKcA6/s+VSp0OYRQMgPC2TSIUsab0pKslSz3z
        Jpdoer24YfWEW3FVzA+2qCWC/cicGww/JewVPNk=
X-Google-Smtp-Source: AA0mqf4FERlBTL3zfu5OABQHUAUGtC3ui1J2Y9XTioHK6ycBziaWHmygdyt8U4qg8jrAOD9+MK6UdB4q5CPYyCTCkNQ=
X-Received: by 2002:a81:8391:0:b0:36d:fd11:5478 with SMTP id
 t139-20020a818391000000b0036dfd115478mr22982669ywf.28.1669143097995; Tue, 22
 Nov 2022 10:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20221122140824.89305-1-donald.hunter@gmail.com>
In-Reply-To: <20221122140824.89305-1-donald.hunter@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 22 Nov 2022 10:51:26 -0800
Message-ID: <CAJnrk1Yg9kF=OehLwcm+3ZeRQBCiSW6AEhS97gxA=R99XREQ-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, docs: Document BPF_MAP_TYPE_BLOOM_FILTER
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

On Tue, Nov 22, 2022 at 6:13 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Add documentation for BPF_MAP_TYPE_BLOOM_FILTER including
> kernel BPF helper usage, userspace usage and examples.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

LGTM. Thanks for adding this.

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
> v1 -> v2:
> - Fix sphinx warnings for sphinx >= 3.1
>
>  Documentation/bpf/map_bloom_filter.rst | 174 +++++++++++++++++++++++++
>  1 file changed, 174 insertions(+)
>  create mode 100644 Documentation/bpf/map_bloom_filter.rst
>
> diff --git a/Documentation/bpf/map_bloom_filter.rst b/Documentation/bpf/map_bloom_filter.rst
> new file mode 100644
> index 000000000000..b96fd5f13e1f
> --- /dev/null
> +++ b/Documentation/bpf/map_bloom_filter.rst
> @@ -0,0 +1,174 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +=========================
> +BPF_MAP_TYPE_BLOOM_FILTER
> +=========================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_BLOOM_FILTER`` was introduced in kernel version 5.16
> +
> +``BPF_MAP_TYPE_BLOOM_FILTER`` provides a BPF bloom filter map. Bloom
> +filters are a space-efficient probabilistic data structure used to
> +quickly test whether an element exists in a set. In a bloom filter,
> +false positives are possible whereas false negatives are not.
> +
> +The bloom filter map does not have keys, only values. When the bloom
> +filter map is created, it must be created with a ``key_size`` of 0.  The
> +bloom filter map supports two operations:
> +
> +- push: adding an element to the map
> +- peek: determining whether an element is present in the map
> +
> +BPF programs must use ``bpf_map_push_elem`` to add an element to the
> +bloom filter map and ``bpf_map_peek_elem`` to query the map. These
> +operations are exposed to userspace applications using the existing
> +``bpf`` syscall in the following way:
> +
> +- ``BPF_MAP_UPDATE_ELEM`` -> push
> +- ``BPF_MAP_LOOKUP_ELEM`` -> peek
> +
> +The ``max_entries`` size that is specified at map creation time is used
> +to approximate a reasonable bitmap size for the bloom filter, and is not
> +otherwise strictly enforced. If the user wishes to insert more entries
> +into the bloom filter than ``max_entries``, this may lead to a higher
> +false positive rate.
> +
> +The number of hashes to use for the bloom filter is configurable using
> +the lower 4 bits of ``map_extra`` in ``union bpf_attr`` at map creation
> +time. If no number is specified, the default used will be 5 hash
> +functions. In general, using more hashes decreases both the false
> +positive rate and the speed of a lookup.
> +
> +It is not possible to delete elements from a bloom filter map. A bloom
> +filter map may be used as an inner map. The user is responsible for
> +synchronising concurrent updates and lookups to ensure no false negative
> +lookups occur.
> +
> +Usage
> +=====
> +
> +Kernel BPF
> +----------
> +
> +bpf_map_push_elem()
> +~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
> +
> +A ``value`` can be added to a bloom filter using the
> +``bpf_map_push_elem()`` helper. The ``flags`` parameter must be set to
> +``BPF_ANY`` when adding an entry to the bloom filter. This helper
> +returns ``0`` on success, or negative error in case of failure.
> +
> +bpf_map_peek_elem()
> +~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   long bpf_map_peek_elem(struct bpf_map *map, void *value)
> +
> +The ``bpf_map_peek_elem()`` helper is used to determine whether
> +``value`` is present in the bloom filter map. This helper returns ``0``
> +if ``value`` is probably present in the map, or ``-ENOENT`` if ``value``
> +is definitely not present in the map.
> +
> +Userspace
> +---------
> +
> +bpf_map_update_elem()
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   int bpf_map_update_elem (int fd, const void *key, const void *value, __u64 flags)
> +
> +A userspace program can add a ``value`` to a bloom filter using libbpf's
> +``bpf_map_update_elem`` function. The ``key`` parameter must be set to
> +``NULL`` and ``flags`` must be set to ``BPF_ANY``. Returns ``0`` on
> +success, or negative error in case of failure.
> +
> +bpf_map_lookup_elem()
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   int bpf_map_lookup_elem (int fd, const void *key, void *value)
> +
> +A userspace program can determine the presence of ``value`` in a bloom
> +filter using libbpf's ``bpf_map_lookup_elem`` function. The ``key``
> +parameter must be set to ``NULL``. Returns ``0`` if ``value`` is
> +probably present in the map, or ``-ENOENT`` if ``value`` is definitely
> +not present in the map.
> +
> +Examples
> +========
> +
> +Kernel BPF
> +----------
> +
> +This snippet shows how to declare a bloom filter in a BPF program:
> +
> +.. code-block:: c
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_BLOOM_FILTER);
> +            __type(value, __u32);
> +            __uint(max_entries, 1000);
> +            __uint(map_extra, 3);
> +    } bloom_filter SEC(".maps");
> +
> +This snippet shows how to determine presence of a value in a bloom
> +filter in a BPF program:
> +
> +.. code-block:: c
> +
> +    void *lookup(__u32 key)
> +    {
> +            if (bpf_map_peek_elem(&bloom_filter, &key) == 0) {
> +                    /* Verify not a false positive and fetch an associated
> +                     * value using a secondary lookup, e.g. in a hash table
> +                     */
> +                    return bpf_map_lookup_elem(&hash_table, &key);
> +            }
> +            return 0;
> +    }
> +
> +Userspace
> +---------
> +
> +This snippet shows how to use libbpf to create a bloom filter map from
> +userspace:
> +
> +.. code-block:: c
> +
> +    int create_bloom()
> +    {
> +            LIBBPF_OPTS(bpf_map_create_opts, opts,
> +                        .map_extra = 3);             /* number of hashes */
> +
> +            return bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER,
> +                                  "ipv6_bloom",      /* name */
> +                                  0,                 /* key size, must be zero */
> +                                  sizeof(ipv6_addr), /* value size */
> +                                  10000,             /* max entries */
> +                                  &opts);            /* create options */
> +    }
> +
> +This snippet shows how to add an element to a bloom filter from
> +userspace:
> +
> +.. code-block:: c
> +
> +    int add_element(__u32 value)
> +    {
> +            return bpf_map_update_elem(bloom_fd, 0, &value, BPF_ANY);

nit: the second arg is a pointer so I think "NULL" (instead of 0) is
the convention?

It might also be useful to demonstrate how to get bloom_fd (eg using
bpf_map__fd helper).

> +    }
> +
> +
> +References
> +==========
> +
> +https://lwn.net/ml/bpf/20210831225005.2762202-1-joannekoong@fb.com/
> --
> 2.38.1
>
