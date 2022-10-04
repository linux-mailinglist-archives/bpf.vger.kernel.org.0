Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C665F4761
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJDQUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJDQUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8EB3121A;
        Tue,  4 Oct 2022 09:20:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id iv17so9243171wmb.4;
        Tue, 04 Oct 2022 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8LE8W2mqaAM/yoDLOF9MDrdUP87t6ukTakzjHiQS0ng=;
        b=l59jIqVs1PVe7xRCb3OD+i+OXNVXagIwzGy00H4kSsnmO/kUc9U8oq0NDPmb7lsY2+
         UxcmrBm3jZhkNLvuBXtrdVzGNJSmzrQwzp4ZnMt3yujj6Z9g8xyQO5n1rCmsqZO5iaMf
         gLBvvbrgp9UIEIPOClTa6HYiMHo32wHnOI5sZwM3RHKkznndjlK9D0qp0ZmFVM7tWBUD
         VKj7hN7/OOhbWd9l790p3NJjub7SI5ex5M6CvPTA8XiVHVwLz+aubel3g6feGIa6Bink
         8nzD3IDgJc9Z3riMKS0uj3j4x/QULkN6LtRTApfDHaVd8x+1v5ci+o16EPK4iHqp4HJq
         teQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8LE8W2mqaAM/yoDLOF9MDrdUP87t6ukTakzjHiQS0ng=;
        b=bYJAKPYUtcLX5+O+N3bSj/45dNPiLSyp6/RRrIp6LVNkf4BsLlo/vwvddo6FqZnQPh
         Zz5kpP9g/ZYhSIIWqjy1+yC+xQ6x1WISjl6odecyNN/eq7NYhCVBM1iIVZNbQijMC6y4
         IsARVxv91Csu1ldPP3dufUPDJUUmsCzO+TeSlJthFGAVp7y0cEl+0GCyv9PQLIisCfoX
         89mBynmZEuv7O1hARgU08kQMVfrncgLjnxBo1VwG0DQcNiZEjz9TEy3OhTL/+9byZvZ9
         MOl6OD/vQYpZUfCNPJN8srDCnhFZXEjv4EYg1pvZ80M2lI1Fw/R3asUa9BcMcRBCEH3k
         IlMg==
X-Gm-Message-State: ACrzQf2093AqM9MyjBQFZfZYY3F/qZMzzJQHxHbF+QG8cNCKJcNn/fQ6
        G9FMq+wffmypWtkmCZj9Dc9myvgg4GMyzg==
X-Google-Smtp-Source: AMsMyM7UclJoe0JzOzlfw3CfWm+fzKvOaGoFVQn0pF1q9bLjhbUjtTO3Ap41NER4apgfUqhbmjXNew==
X-Received: by 2002:a7b:c4c2:0:b0:3b4:fdc4:6df9 with SMTP id g2-20020a7bc4c2000000b003b4fdc46df9mr374879wmk.123.1664900407437;
        Tue, 04 Oct 2022 09:20:07 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:80f3:87e5:ec43:c70c])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b003bd83d8c0f2sm1245191wma.16.2022.10.04.09.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:06 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk, Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v5 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
Date:   Tue,  4 Oct 2022 17:19:29 +0100
Message-Id: <20221004161929.52609-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221004161929.52609-1-donald.hunter@gmail.com>
References: <20221004161929.52609-1-donald.hunter@gmail.com>
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

From: Dave Tucker <dave@dtucker.co.uk>

Add documentation for the BPF_MAP_TYPE_ARRAY including kernel version
introduced, usage and examples. Also documents BPF_MAP_TYPE_PERCPU_ARRAY
since this is similar.

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/map_array.rst | 217 ++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
new file mode 100644
index 000000000000..5eec4c99fda5
--- /dev/null
+++ b/Documentation/bpf/map_array.rst
@@ -0,0 +1,217 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+================================================
+BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
+================================================
+
+.. note::
+   - ``BPF_MAP_TYPE_ARRAY`` was introduced in kernel version 3.19
+   - ``BPF_MAP_TYPE_PERCPU_ARRAY`` was introduced in version 4.6
+
+``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array
+storage. The key type is an unsigned 32-bit integer (4 bytes) and the map is of
+constant size. All array elements are pre-allocated and zero initialized when
+created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
+CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The maximum
+size of an array, defined in max_entries, is limited to 2^32. The value stored
+can be of any size, however, small values will be rounded up to 8 bytes.
+
+Since kernel 5.5, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by
+setting the flag ``BPF_F_MMAPABLE``. The map definition is page-aligned and
+starts on the first page. Sufficient page-sized and page-aligned blocks of
+memory are allocated to store all array values, starting on the second page,
+which in some cases will result in over-allocation of memory. The benefit of
+using this is increased performance and ease of use since userspace programs
+would not be required to use helper functions to access and mutate data.
+
+Usage
+=====
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
+This helper returns a pointer into the array element, so to avoid data races
+with userspace reading the value, the user must use primitives like
+``__sync_fetch_and_add()`` when updating the value in-place. Access from
+userspace uses the libbpf API of the same name.
+
+.. c:function::
+   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
+
+Array elements can also be added using the ``bpf_map_update_elem()`` helper or
+libbpf API.
+
+``bpf_map_update_elem()`` returns 0 on success, or negative error in case of
+failure.
+
+Since the array is of constant size, ``bpf_map_delete_elem()`` is not supported.
+To clear an array element, you may use ``bpf_map_update_elem()`` to insert a
+zero value to that index.
+
+Per CPU Array
+-------------
+
+Values stored in ``BPF_MAP_TYPE_ARRAY`` can be accessed by multiple programs
+across different CPUs. To restrict storage to a single CPU, you may use a
+``BPF_MAP_TYPE_PERCPU_ARRAY``.
+
+When using a ``BPF_MAP_TYPE_PERCPU_ARRAY`` the ``bpf_map_update_elem()`` and
+``bpf_map_lookup_elem()`` helpers automatically access the hash slot for the
+current CPU.
+
+.. c:function::
+   void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void *key, u32 cpu)
+
+The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the array
+value for a specific CPU. Returns value on success , or ``NULL`` if no entry was
+found or ``cpu`` is invalid.
+
+Concurrency
+-----------
+
+Since kernel version 5.1, the BPF infrastructure provides ``struct bpf_spin_lock``
+to synchronize access.
+
+Examples
+========
+
+Please see the ``tools/testing/selftests/bpf`` directory for functional
+examples. The sample code below demonstrates API usage.
+
+Kernel
+------
+
+This snippet shows how to declare an array in a BPF program.
+
+.. code-block:: c
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_ARRAY);
+            __type(key, u32);
+            __type(value, long);
+            __uint(max_entries, 256);
+    } my_map SEC(".maps");
+
+
+This example shows how to access an array element.
+
+.. code-block:: c
+
+    int bpf_prog(struct __sk_buff *skb)
+    {
+            int index = load_byte(skb,
+                                  ETH_HLEN + offsetof(struct iphdr, protocol));
+            long *value;
+
+            if (skb->pkt_type != PACKET_OUTGOING)
+                    return 0;
+
+            value = bpf_map_lookup_elem(&my_map, &index);
+            if (value)
+                    __sync_fetch_and_add(value, skb->len);
+
+            return 0;
+    }
+
+Userspace
+---------
+
+BPF_MAP_TYPE_ARRAY
+~~~~~~~~~~~~~~~~~~
+
+This example shows array creation, initialisation and lookup from userspace.
+
+.. code-block:: c
+
+    #include <assert.h>
+    #include <bpf/libbpf.h>
+    #include <bpf/bpf.h>
+
+    int main(int argc, char **argv)
+    {
+	    int fd;
+	    int ret = 0;
+	    long value;
+	    __u32 index = 42;
+	    __u32 i;
+
+	    fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "example_array",
+				sizeof(__u32), sizeof(long),
+				256, 0);
+	    if (fd < 0)
+		    return fd;
+
+	    /* fill the map with values from 0-255 */
+	    for (i = 0; i < 256 ; i++) {
+		    value = i;
+		    ret = bpf_map_update_elem(fd, &i, &value, BPF_ANY);
+		    if (ret < 0)
+			    return ret;
+	    }
+
+	    ret = bpf_map_lookup_elem(fd, &index, &value);
+	    if (ret < 0)
+		    return ret;
+
+	    assert(value == 42);
+
+	    return ret;
+    }
+
+BPF_MAP_TYPE_PERCPU_ARRAY
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This example shows per CPU array usage.
+
+.. code-block:: c
+
+    #include <assert.h>
+    #include <bpf/libbpf.h>
+    #include <bpf/bpf.h>
+
+    int main(int argc, char **argv)
+    {
+	    int ncpus = libbpf_num_possible_cpus();
+	    if (ncpus < 0)
+		    return ncpus;
+
+	    int fd;
+	    int ret = 0;
+	    __u32 i, j;
+	    __u32 index = 42;
+	    long v[ncpus], value[ncpus];
+
+	    fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "example_percpu",
+				sizeof(__u32), sizeof(long), 256, 0);
+	    if (fd < 0)
+		    return -1;
+
+	    /* fill the map with values from 0-255 for each cpu */
+	    for (i = 0; i < 256 ; i++) {
+		    for (j = 0; j < ncpus; j++)
+			    v[j] = i;
+		    ret = bpf_map_update_elem(fd, &i, &v, BPF_ANY);
+		    if (ret < 0)
+			    return ret;
+	    }
+
+	    ret = bpf_map_lookup_elem(fd, &index, &value);
+	    if (ret < 0)
+		    return ret;
+
+	    for (j = 0; j < ncpus; j++)
+		    assert(value[j] == 42);
+
+	    return ret;
+    }
+
+Semantics
+=========
+
+As shown in the example above, when accessing a ``BPF_MAP_TYPE_PERCPU_ARRAY``
+in userspace, each value is an array with ``ncpus`` elements.
+
+When calling ``bpf_map_update_elem()`` the flag ``BPF_NOEXIST`` can not be used
+for these maps.
-- 
2.35.1

