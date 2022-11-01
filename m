Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80845614AC9
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 13:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKAMeR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 08:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiKAMeQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 08:34:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6EF26;
        Tue,  1 Nov 2022 05:34:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l14so19925733wrw.2;
        Tue, 01 Nov 2022 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjQ2+2Dd7Wt9JpCWi7FI72fBzrc23t8j6V+OZAjd8mc=;
        b=bftfDF+8YdnsA+I9rwp7bLD+GozHgxWyNlTsR96LGUqtFk9mkp/BmeP38KTQiRyrGz
         d6x5xAzFN7a68T5eskxH0I0JsI4CEgV8t5Rl3XeLUmlv6C2D/TdXGQlp0iFWD8q95nT/
         M0MCTWRpH3HcDgT1+kWz1t4kv7khMpbzDeiJTfWGIxCh8GK9D3bE6wAWtDYBzbJjFBNV
         z1258NvrTUXeyTooUEXXypvIOUPv5k4dWDKeKDABje9Up6jhP/cITWzBsDMpZvRLPMWv
         rO2b3PUmaQ0SrFdCltN9rAdvEulBxrcHK89kf0GwUd3ADMKp5tSpwVrzaYetA7gsXmO2
         xM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjQ2+2Dd7Wt9JpCWi7FI72fBzrc23t8j6V+OZAjd8mc=;
        b=ddTnc2GAZ9xNQ0LG7UieoOJHVS8CJk2I4PU+eWL6dmED13cUBiWF73dW0IIwipsjgQ
         ElbLvuF113fEoXsjExV9/1CcN0xLerlgCeBSsUFwXm5PV+pirRUj983RT7RuvoVWKU/F
         +0KrThqkWB5Qdp/o4E9BOkk1SojeEjpYH+RpXAQc9vP5mjRJt92aEIUUqVWYLTJAZbf0
         fNHrAjUy/aV6s4XU9UAbD+/FiI1BWvCJCAC/214wD3B2hvj8ltkKq1KTZcPNauuZCvOH
         U8eOI/vxLDJs9WX02alIbVs32SPDS8ixhviQrPin41iVIcKkBxTRgOGHe8J8X1jyZz08
         bY5A==
X-Gm-Message-State: ACrzQf2SQPUQnERm7bjMm0XzRV/TEOAh5D/s6QqJp43jkThFwK+T7FyD
        eDkcwkdx4JrnsaI5im8CuQzm0nFaK37jVg==
X-Google-Smtp-Source: AMsMyM7DcPLNjgQxYdVzhBDYs+5W5kDGljiFu4hzAxuSOX9TjSfCDJVPOYdYPKy5SVpWD2B8j4jO1A==
X-Received: by 2002:a05:6000:1683:b0:230:d0b5:72c9 with SMTP id y3-20020a056000168300b00230d0b572c9mr12025875wrd.336.1667306053013;
        Tue, 01 Nov 2022 05:34:13 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1575:dcd7:a83c:38b])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003cf5ec79bf9sm10408858wmb.40.2022.11.01.05.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:34:12 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] bpf, docs: Document BPF_MAP_TYPE_BLOOM_FILTER
Date:   Tue,  1 Nov 2022 12:34:08 +0000
Message-Id: <20221101123408.26276-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
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
 Documentation/bpf/map_bloom_filter.rst | 158 +++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/bpf/map_bloom_filter.rst

diff --git a/Documentation/bpf/map_bloom_filter.rst b/Documentation/bpf/map_bloom_filter.rst
new file mode 100644
index 000000000000..923930084367
--- /dev/null
+++ b/Documentation/bpf/map_bloom_filter.rst
@@ -0,0 +1,158 @@
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
+.. c:function::
+   long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
+
+A ``value`` can be added to a bloom filter using the
+``bpf_map_push_elem()`` helper. The ``flags`` parameter must be set to
+``BPF_ANY`` when adding an entry to the bloom filter. This helper
+returns ``0`` on success, or negative error in case of failure.
+
+.. c:function::
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
+.. c:function::
+   int bpf_map_update_elem (int fd, const void *key, const void *value, __u64 flags)
+
+A userspace program can add a ``value`` to a bloom filter using libbpf's
+``bpf_map_update_elem`` function. The ``key`` parameter must be set to
+``NULL`` and ``flags`` must be set to ``BPF_ANY``. Returns ``0`` on
+success, or negative error in case of failure.
+
+.. c:function::
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
2.35.1

