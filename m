Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD54C5FAE2F
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJKIN0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJKINQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 04:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545918A1C6
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665475992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEg7RdYXtmRiuEncVrnSP1mNHXGZ3TfxjtkeK/MBbwM=;
        b=Ac72C2z5v5WfAKNa/ETLcnAU7SAGU4fjtdP1Icuo/u95eFDqinfUjPWC45Gws9Z40boxLX
        gEDO2YTmSF7b62wN/vpAhMAbqkb06cq11mWbseisU4mBXvS3Hy21i5RgyhJZBFYwg6N5tT
        D7H6edTRRlwKPPI6LQeV5LVajbfz3/A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-EQowxkpEML2R1_yDESZSXw-1; Tue, 11 Oct 2022 04:13:11 -0400
X-MC-Unique: EQowxkpEML2R1_yDESZSXw-1
Received: by mail-qv1-f70.google.com with SMTP id y2-20020a0ce802000000b004b1ce1c4a70so7477810qvn.9
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 01:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEg7RdYXtmRiuEncVrnSP1mNHXGZ3TfxjtkeK/MBbwM=;
        b=n1aIVmJJvxpeUQZ+ezYAbAoBeeaQ1UO38MX8Yn0vpPEGOTVxmTTRRmsvFhkGZErQ+R
         8ZyXBpALR/bOFazDqqwcdE0ooCwkLGMH/8uN3OoV5gPTfD78LqCNr/0ZDCRfTUIKLANO
         nr/Byg0+LXtM+QDj/hKtOU9U0eX+5K13ub8DqCrvleALsYPVHjQE0Gs7mzG9mPYUQ0Ha
         sjn1PsO+2iYJyZ5l8HVUpXnbOwCEd2S7xwRid7xVpPhpgqQrHL0HIVcKLXwInPAv5jci
         QAfhApba+vWE1pKG5bTO8eZbL8hOeuvJ0tjc5uapV7bO+bftEAV5msUseWAMpZ3xw6pC
         zEGw==
X-Gm-Message-State: ACrzQf1u9P/5zkR+CrtpaJvzlGM0q+YJ+tZhrsq88n7cALa9aMp/Cmmj
        pHFmL34FKsgemaAQaSW8jHUIIvpgVJ5x5j0NsUDsmUW9C+iTjG9iPCN4T7SE8vWlx9MZSVrUKkc
        U6Xn4f19n82JWMQXH+lPaRGpggNNQfmmIBHYyyCZe6RqEb2DOtmYvGV1+QDzhYHY=
X-Received: by 2002:a37:b906:0:b0:6ce:4076:9859 with SMTP id j6-20020a37b906000000b006ce40769859mr15726787qkf.580.1665475990298;
        Tue, 11 Oct 2022 01:13:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Po/4tvHy/Kl+S5HR98VqMzCkZcNBAx7+wScCszP+UtkZOakCGmlMmJGAliOYjviOBvxUSJg==
X-Received: by 2002:a37:b906:0:b0:6ce:4076:9859 with SMTP id j6-20020a37b906000000b006ce40769859mr15726775qkf.580.1665475989924;
        Tue, 11 Oct 2022 01:13:09 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006bb82221013sm12383261qkl.0.2022.10.11.01.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 01:13:09 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH v1 1/1] doc: BPF_MAP_TYPE_DEVMAP, BPF_MAP_TYPE_DEVMAP_HASH
Date:   Tue, 11 Oct 2022 05:08:46 -0400
Message-Id: <20221011090846.752622-2-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011090846.752622-1-mtahhan@redhat.com>
References: <20221011090846.752622-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Add documentation for BPF_MAP_TYPE_DEVMAP and
BPF_MAP_TYPE_DEVMAP_HASH including kernel version
introduced, usage and examples.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 Documentation/bpf/map_devmap.rst | 231 +++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 Documentation/bpf/map_devmap.rst

diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devmap.rst
new file mode 100644
index 000000000000..ecd2b7b951cc
--- /dev/null
+++ b/Documentation/bpf/map_devmap.rst
@@ -0,0 +1,231 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+=================================================
+BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_DEVMAP_HASH
+=================================================
+
+.. note::
+   - ``BPF_MAP_TYPE_DEVMAP`` was introduced in kernel version 4.14
+   - ``BPF_MAP_TYPE_DEVMAP_HASH`` was introduced in kernel version 5.4
+
+``BPF_MAP_TYPE_DEVMAP`` is a BPF map, primarily used as a backend map for the XDP
+BPF helper call ``bpf_redirect_map()``. It's backed by an array that uses the key as
+the index to lookup a reference to a net device. The user provides <``key``/ ``ifindex``>
+pairs to update the map with new net devices.
+
+``BPF_MAP_TYPE_DEVMAP_HASH`` is also a backend map for ``bpf_redirect_map()``.
+It's backed by a hash table that uses the ``ifindex`` as the key to lookup a reference
+to a net device. As it's a hash map, it allows for densely packing the net devices
+(compared with the sparsely packed ``BPF_MAP_TYPE_DEVMAP``). The user provides
+<``key``/ ``struct bpf_devmap_val``> pairs to update the map with new net devices.
+
+The setup and packet enqueue/send code is shared between the two types of
+devmap; only the lookup and insertion is different.
+
+XDP_REDIRECT
+============
+
+XDP_REDIRECT works by a three-step process, implemented as follows:
+
+1. The ``bpf_redirect()`` and ``bpf_redirect_map()`` helpers will lookup the
+   target of the redirect and store it (along with some other metadata) in a
+   per-CPU ``struct bpf_redirect_info``. This is where the maps above come into
+   play.
+
+2. When the program returns the ``XDP_REDIRECT`` return code, the driver will
+   call ``xdp_do_redirect()`` which will use the information in ``struct
+   bpf_redirect_info`` to actually enqueue the frame into a map type-specific
+   bulk queue structure.
+
+3. Before exiting its NAPI poll loop, the driver will call ``xdp_do_flush()``,
+   which will flush all the different bulk queues, thus completing the
+   redirect.
+
+Pointers to the map entries will be kept around for this whole sequence of
+steps, protected by RCU. However, there is no top-level ``rcu_read_lock()`` in
+the core code; instead, the RCU protection relies on everything happening
+inside a single NAPI poll sequence, which means it's between a pair of calls
+to ``local_bh_disable()`` / ``local_bh_enable()``.
+
+The map entries are marked as ``__rcu`` and the map code makes sure to dereference
+those pointers with ``rcu_dereference_check()`` in a way that works for both
+sections that to hold an ``rcu_read_lock()`` and sections that are called from
+NAPI without a separate ``rcu_read_lock()``. The code below does not use RCU
+annotations, but relies on those in the map code.
+
+.. note::
+    ``XDP_REDIRECT`` is not fully supported yet for xdp frags since not all XDP
+    capable drivers can map a non-linear ``xdp_frame`` in ``ndo_xdp_xmit``.
+
+Usage
+=====
+
+.. c:function::
+   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
+
+ Net device entries can be added or updated using the ``bpf_map_update_elem()``
+ helper. This helper replaces existing elements atomically. The ``flags``
+ parameter can be used to control the update behaviour:
+
+ - ``BPF_ANY`` will create a new element or update an existing element
+ - ``BPF_NOEXIST`` will create a new element only if one did not already
+   exist
+ - ``BPF_EXIST`` will update an existing element
+
+ ``bpf_map_update_elem()`` returns 0 on success, or negative error in
+ case of failure.
+
+ The value parameter is of type ``struct bpf_devmap_val``:
+
+ .. code-block:: c
+
+    struct bpf_devmap_val {
+        __u32 ifindex;   /* device index */
+        union {
+            int   fd;  /* prog fd on map write */
+            __u32 id;  /* prog id on map read */
+        } bpf_prog;
+    };
+
+ DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
+ to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
+ access to both Rx device and Tx device. The  program associated with the ``fd``
+ must have type XDP with expected attach type ``xdp_devmap``.
+ When a program is associated with a device index, the program is run on an
+ ``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
+ of how to attach/use xdp_devmap progs can be found in the kernel selftests:
+
+ - test_xdp_with_devmap_helpers_
+ - xdp_devmap_attach_
+
+.. _xdp_devmap_attach: https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+.. _test_xdp_with_devmap_helpers: https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+ net device entries can be retrieved using the ``bpf_map_lookup_elem()``
+ helper. This helper returns a pointer to the value associated with ``key``, or
+ ``NULL`` if no entry was found.
+
+.. c:function::
+   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
+
+ net device entries can be deleted using the ``bpf_map_delete_elem()``
+ helper. This helper will return 0 on success, or negative error in case of
+ failure.
+
+.. c:function::
+     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
+
+ Redirect the packet to the endpoint referenced by map at index ``key``.
+ For ``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` this map contains
+ references to net devices (for forwarding packets through other ports).
+
+ The lower two bits of *flags* are used as the return code if the map lookup
+ fails. This is so that the return value can be one of the XDP program return
+ codes up to ``XDP_TX``, as chosen by the caller. The higher bits of ``flags``
+ can be set to ``BPF_F_BROADCAST`` or ``BPF_F_EXCLUDE_INGRESS`` as defined
+ below.
+
+ With ``BPF_F_BROADCAST`` the packet will be broadcast to all the interfaces
+ in the map, with ``BPF_F_EXCLUDE_INGRESS`` the ingress interface will be excluded
+ from the broadcast.
+
+ This helper will return ``XDP_REDIRECT`` on success, or the value of the two
+ lower bits of the *flags* argument if the map lookup fails.
+
+Examples
+========
+
+Kernel BPF
+----------
+
+The following code snippet shows how to declare a ``BPF_MAP_TYPE_DEVMAP``
+called tx_port.
+
+.. code-block:: c
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_DEVMAP);
+        __uint(key_size, sizeof(int));
+        __uint(value_size, sizeof(int));
+        __uint(max_entries, 256);
+    } tx_port SEC(".maps");
+
+The following code snippet shows how to declare a ``BPF_MAP_TYPE_DEVMAP_HASH``
+called forward_map.
+
+.. code-block:: c
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
+        __uint(key_size, sizeof(int));
+        __uint(value_size, sizeof(struct bpf_devmap_val));
+        __uint(max_entries, 32);
+    } forward_map SEC(".maps");
+
+The following code snippet shows a simple xdp_redirect_map program.
+
+.. code-block:: c
+
+    SEC("xdp")
+    int xdp_redirect_map_func(struct xdp_md *ctx)
+    {
+        void *data_end = (void *)(long)ctx->data_end;
+        void *data = (void *)(long)ctx->data;
+        int action = XDP_PASS;
+        int index = ctx->ingress_ifindex;
+
+        action = bpf_redirect_map(&tx_port, index, BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
+
+    out:
+        return action;
+    }
+
+
+User space
+----------
+
+The following code snippet shows how to update a devmap called ``tx_port``.
+
+.. code-block:: c
+
+    int update_devmap(int ifindex, int redirect_ifindex)
+    {
+        int ret = -1;
+
+        ret = bpf_map_update_elem(bpf_map__fd(tx_port), &ifindex, &redirect_ifindex, 0);
+        if (ret < 0) {
+            fprintf(stderr, "Failed to update devmap_ value: %s\n",
+                strerror(errno));
+        }
+
+        return ret;
+    }
+
+The following code snippet shows how to update a hash_devmap called ``forward_map``.
+
+.. code-block:: c
+
+    int update_devmap(int ifindex, int redirect_ifindex)
+    {
+        struct bpf_devmap_val devmap_val;
+        int ret = -1;
+
+        devmap_val.ifindex = redirect_ifindex;
+        ret = bpf_map_update_elem(bpf_map__fd(forward_map), &ifindex, &devmap_val, 0);
+        if (ret < 0) {
+            fprintf(stderr, "Failed to update devmap_ value: %s\n",
+                strerror(errno));
+        }
+        return ret;
+    }
+
+References
+===========
+
+- https://lwn.net/Articles/728146/
+- https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=6f9d451ab1a33728adb72d7ff66a7b374d665176
+- https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4106
-- 
2.35.3

