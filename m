Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0764633E91
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 15:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiKVOLS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiKVOLA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 09:11:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9152CC8D;
        Tue, 22 Nov 2022 06:10:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z4so10299972wrr.3;
        Tue, 22 Nov 2022 06:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2sxIMALN/jhAgeTyHOyVZJuD3alMnqSzP+eykVYVtQ=;
        b=TmSTQdGRgXfA19BTGoTn31F++Na6tUYPeVbjhIwBzeVX0LZ+F3CC3I0piMXG8DDDre
         9vveTuZys31wOl0wwRxaSH26yOc1SFbEk9GPFlpiAc2H/WbWixK7HE6wxVVi3T5Gusn4
         7arJVAyGnHHn7I4nrhlseUy2Sidij00Z4Nr5NH+B0OvA6j0wjlU95i06sbZhuHUqS1ix
         ayF9CArPmNTTX32Vfs1VJl6gRO1FD0zN2XcsatfDWgvacVxwjQsFFEqozzZjCD7bMt7d
         A5JwdHxfqU+C6nXwFAEU0UGnyH1jU8kwgfpBv2tX7er6PCEM4Eb5XmCochE9GZbJjZQo
         2Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2sxIMALN/jhAgeTyHOyVZJuD3alMnqSzP+eykVYVtQ=;
        b=T3C44hCauu0RlPI4FZ2/mgnS9fUBwuzeCzpDhIXWqRdTLV+pbsmflPtTlimWT+S+BW
         opEPfxk/K0M+Fe9JyOv1PD2t9yMC8vUWlcCfT4QE8zM5NpeR7uZHNPzOSx4PQLvQJ3b/
         JBEPbA5lJWRwQmuq20pbzGWKciW+nmrMiOy1KtJBVbviN4FtWP/i/OAbBIsmH5t/ODht
         iWb+st0spXLVhsT9p2xOehI9KLtnFRDtfDuFXYTRSw6qsXuwFONBruakrqDxSYM7k/MV
         b4nSmaIMR2F66A04S5Q0WJcX9cO0zEbWVYxRNdfyHCvfBf9ClB7IkbyzSQvabhruLs76
         j6Dg==
X-Gm-Message-State: ANoB5pkGhyBhDwsfIbpNgoeBGEiq6xEv6DrKcomMxEBvPE7sGt8xM4OW
        xQYmA9/Iz3BCbRLDi+2+oxBheB6J4X9qpg==
X-Google-Smtp-Source: AA0mqf5anA48MSpp2rcykGtBfXwPOv2BN5tX5Xn68Bg+uzHZskS35OxENBzK5NQXtIQ+HWYD1uc0pw==
X-Received: by 2002:adf:f086:0:b0:22e:3725:8acc with SMTP id n6-20020adff086000000b0022e37258accmr6216318wro.330.1669126210228;
        Tue, 22 Nov 2022 06:10:10 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:986c:3a9f:58a6:a738])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003b497138093sm19530441wmb.47.2022.11.22.06.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:10:09 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2] bpf, docs: Document BPF_MAP_TYPE_BLOOM_FILTER
Date:   Tue, 22 Nov 2022 14:08:24 +0000
Message-Id: <20221122140824.89305-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add documentation for BPF_MAP_TYPE_BLOOM_FILTER including
kernel BPF helper usage, userspace usage and examples.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
v1 -> v2:
- Fix sphinx warnings for sphinx >= 3.1

 Documentation/bpf/map_bloom_filter.rst | 174 +++++++++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 Documentation/bpf/map_bloom_filter.rst

diff --git a/Documentation/bpf/map_bloom_filter.rst b/Documentation/bpf/map_bloom_filter.rst
new file mode 100644
index 000000000000..b96fd5f13e1f
--- /dev/null
+++ b/Documentation/bpf/map_bloom_filter.rst
@@ -0,0 +1,174 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+=========================
+BPF_MAP_TYPE_BLOOM_FILTER
+=========================
+
+.. note::
+   - ``BPF_MAP_TYPE_BLOOM_FILTER`` was introduced in kernel version 5.16
+
+``BPF_MAP_TYPE_BLOOM_FILTER`` provides a BPF bloom filter map. Bloom
+filters are a space-efficient probabilistic data structure used to
+quickly test whether an element exists in a set. In a bloom filter,
+false positives are possible whereas false negatives are not.
+
+The bloom filter map does not have keys, only values. When the bloom
+filter map is created, it must be created with a ``key_size`` of 0.  The
+bloom filter map supports two operations:
+
+- push: adding an element to the map
+- peek: determining whether an element is present in the map
+
+BPF programs must use ``bpf_map_push_elem`` to add an element to the
+bloom filter map and ``bpf_map_peek_elem`` to query the map. These
+operations are exposed to userspace applications using the existing
+``bpf`` syscall in the following way:
+
+- ``BPF_MAP_UPDATE_ELEM`` -> push
+- ``BPF_MAP_LOOKUP_ELEM`` -> peek
+
+The ``max_entries`` size that is specified at map creation time is used
+to approximate a reasonable bitmap size for the bloom filter, and is not
+otherwise strictly enforced. If the user wishes to insert more entries
+into the bloom filter than ``max_entries``, this may lead to a higher
+false positive rate.
+
+The number of hashes to use for the bloom filter is configurable using
+the lower 4 bits of ``map_extra`` in ``union bpf_attr`` at map creation
+time. If no number is specified, the default used will be 5 hash
+functions. In general, using more hashes decreases both the false
+positive rate and the speed of a lookup.
+
+It is not possible to delete elements from a bloom filter map. A bloom
+filter map may be used as an inner map. The user is responsible for
+synchronising concurrent updates and lookups to ensure no false negative
+lookups occur.
+
+Usage
+=====
+
+Kernel BPF
+----------
+
+bpf_map_push_elem()
+~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
+
+A ``value`` can be added to a bloom filter using the
+``bpf_map_push_elem()`` helper. The ``flags`` parameter must be set to
+``BPF_ANY`` when adding an entry to the bloom filter. This helper
+returns ``0`` on success, or negative error in case of failure.
+
+bpf_map_peek_elem()
+~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   long bpf_map_peek_elem(struct bpf_map *map, void *value)
+
+The ``bpf_map_peek_elem()`` helper is used to determine whether
+``value`` is present in the bloom filter map. This helper returns ``0``
+if ``value`` is probably present in the map, or ``-ENOENT`` if ``value``
+is definitely not present in the map.
+
+Userspace
+---------
+
+bpf_map_update_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   int bpf_map_update_elem (int fd, const void *key, const void *value, __u64 flags)
+
+A userspace program can add a ``value`` to a bloom filter using libbpf's
+``bpf_map_update_elem`` function. The ``key`` parameter must be set to
+``NULL`` and ``flags`` must be set to ``BPF_ANY``. Returns ``0`` on
+success, or negative error in case of failure.
+
+bpf_map_lookup_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   int bpf_map_lookup_elem (int fd, const void *key, void *value)
+
+A userspace program can determine the presence of ``value`` in a bloom
+filter using libbpf's ``bpf_map_lookup_elem`` function. The ``key``
+parameter must be set to ``NULL``. Returns ``0`` if ``value`` is
+probably present in the map, or ``-ENOENT`` if ``value`` is definitely
+not present in the map.
+
+Examples
+========
+
+Kernel BPF
+----------
+
+This snippet shows how to declare a bloom filter in a BPF program:
+
+.. code-block:: c
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_BLOOM_FILTER);
+            __type(value, __u32);
+            __uint(max_entries, 1000);
+            __uint(map_extra, 3);
+    } bloom_filter SEC(".maps");
+
+This snippet shows how to determine presence of a value in a bloom
+filter in a BPF program:
+
+.. code-block:: c
+
+    void *lookup(__u32 key)
+    {
+            if (bpf_map_peek_elem(&bloom_filter, &key) == 0) {
+                    /* Verify not a false positive and fetch an associated
+                     * value using a secondary lookup, e.g. in a hash table
+                     */
+                    return bpf_map_lookup_elem(&hash_table, &key);
+            }
+            return 0;
+    }
+
+Userspace
+---------
+
+This snippet shows how to use libbpf to create a bloom filter map from
+userspace:
+
+.. code-block:: c
+
+    int create_bloom()
+    {
+            LIBBPF_OPTS(bpf_map_create_opts, opts,
+                        .map_extra = 3);             /* number of hashes */
+
+            return bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER,
+                                  "ipv6_bloom",      /* name */
+                                  0,                 /* key size, must be zero */
+                                  sizeof(ipv6_addr), /* value size */
+                                  10000,             /* max entries */
+                                  &opts);            /* create options */
+    }
+
+This snippet shows how to add an element to a bloom filter from
+userspace:
+
+.. code-block:: c
+
+    int add_element(__u32 value)
+    {
+            return bpf_map_update_elem(bloom_fd, 0, &value, BPF_ANY);
+    }
+
+
+References
+==========
+
+https://lwn.net/ml/bpf/20210831225005.2762202-1-joannekoong@fb.com/
-- 
2.38.1

