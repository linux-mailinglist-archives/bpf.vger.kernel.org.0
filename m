Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687BF633A60
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 11:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiKVKo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 05:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiKVKoB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 05:44:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558727B02
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669113467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0BCDlnZyGDW7YaEJ/TivOn8mKa3/ZKeFN9Ygd4zUWM8=;
        b=FHEMAEz9xpfKp8wiJfWQB9n9bHoAK0lFlMyaceCKl+7TThldd3UIyegtF5Wa5e1Jtz38CN
        3niv5pOCLf2wNzJmkKEm0RApCCQmSqx8WZjxuEun9+oINAunIFlyYFnfse89eKNZv8gKK7
        A47bmFXvvzNpY3JXIkbhHFUWzVkHkrA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-298-YfnJtKt8MziyT3Pj6oCciA-1; Tue, 22 Nov 2022 05:37:46 -0500
X-MC-Unique: YfnJtKt8MziyT3Pj6oCciA-1
Received: by mail-wm1-f69.google.com with SMTP id q12-20020a1ce90c000000b003d00f3fe1e7so2817809wmc.4
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BCDlnZyGDW7YaEJ/TivOn8mKa3/ZKeFN9Ygd4zUWM8=;
        b=JTZeiMs6trYq2AXg9d5gvCTeUUvuR1FjtBen8MZezvAokWRTBz4xPnsnWpCrNcosg2
         +/cT+aXRq8ozEgdCSxf0V8g0YPivCUgtpDEbgAp56zUHQQmbVkWMhoPrJBrJmRXI2wJX
         /TzDLe6hIE16cLh9clQC4t3ie8W+Rm+FJRAhm0nGBEDwCP4wGovz94S0FSvEandS8WKx
         HxtsQaxx7QMWEtgmXJHWHC3gKhC6o6tUG4xF1MbzqhfcijLvmFlZyAgy5v6TbwSRQU8x
         OieIR1ulT/psIQYUq2NJoa8c8hzxX4MX4NJ2vgI0XoK7giEK6LyPPYnLVAgNsSMQtT5t
         ngVA==
X-Gm-Message-State: ANoB5pmhNo2CPEIF80WJKoHVn8XvVjbZ7RgTKIGwFcNHXYZl4aHJg2HH
        tXJ47kFqMTw8/4Z/DgXEQfeYFxQH3jxeH33BhmdGz31dHNqPFBUT43HrR/Fyl0eXBlwwqfZ9CBJ
        0hbWuYWZmTRaVxJpU0/bVr42iph10mY6FXGr4b7JGlnSl4aFDGio1kJsqKT/pSHw=
X-Received: by 2002:adf:e50b:0:b0:240:e14:cfa8 with SMTP id j11-20020adfe50b000000b002400e14cfa8mr13539383wrm.63.1669113465212;
        Tue, 22 Nov 2022 02:37:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5vPa2asJ16s9GJjFoLHtjoFVYznQP3lg4nEMeCfAMG3Ej1SnUt8NrUNlUuRYYX712wqaV0ag==
X-Received: by 2002:adf:e50b:0:b0:240:e14:cfa8 with SMTP id j11-20020adfe50b000000b002400e14cfa8mr13539370wrm.63.1669113464918;
        Tue, 22 Nov 2022 02:37:44 -0800 (PST)
Received: from teaching-eagle.redhat.com ([78.19.107.254])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003c65c9a36dfsm18674438wmo.48.2022.11.22.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:37:44 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        akiyks@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v1 2/2] docs: fix sphinx warnings for devmap
Date:   Tue, 22 Nov 2022 10:37:38 +0000
Message-Id: <20221122103738.65980-3-mtahhan@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122103738.65980-1-mtahhan@redhat.com>
References: <20221122103738.65980-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Sphinx version >=3.3 warns about duplicate function delcarations in the
DEVMAP documentation. This is because the function name is the same for
Kernel and Userspace BPF progs but the parameters and return types
they take is what differs. This patch moves from using the ``c:function::``
directive to using the ``code-block:: c`` directive. The patches also fix
the indentation for the text associated with the "new" code block delcarations.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 Documentation/bpf/map_devmap.rst | 64 ++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devmap.rst
index f64da348dbfe..cdb7c484c425 100644
--- a/Documentation/bpf/map_devmap.rst
+++ b/Documentation/bpf/map_devmap.rst
@@ -29,8 +29,11 @@ Usage
 =====
 Kernel BPF
 ----------
-.. c:function::
-     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
+bpf_redirect_map()
+^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
 
 Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
 For ``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` this map contains
@@ -56,7 +59,10 @@ lower bits of the ``flags`` argument if the map lookup fails.
 
 More information about redirection can be found :doc:`redirect`
 
-.. c:function::
+bpf_map_lookup_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
 
 Net device entries can be retrieved using the ``bpf_map_lookup_elem()``
@@ -69,13 +75,16 @@ Userspace
     from an eBPF program. Trying to call these functions from a kernel eBPF
     program will result in the program failing to load and a verifier warning.
 
-.. c:function::
+bpf_map_update_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
    int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);
 
- Net device entries can be added or updated using the ``bpf_map_update_elem()``
- helper. This helper replaces existing elements atomically. The ``value`` parameter
- can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwards
- compatibility.
+Net device entries can be added or updated using the ``bpf_map_update_elem()``
+helper. This helper replaces existing elements atomically. The ``value`` parameter
+can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwards
+compatibility.
 
  .. code-block:: c
 
@@ -87,35 +96,42 @@ Userspace
         } bpf_prog;
     };
 
- The ``flags`` argument can be one of the following:
-
+The ``flags`` argument can be one of the following:
   - ``BPF_ANY``: Create a new element or update an existing element.
   - ``BPF_NOEXIST``: Create a new element only if it did not exist.
   - ``BPF_EXIST``: Update an existing element.
 
- DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
- to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
- access to both Rx device and Tx device. The  program associated with the ``fd``
- must have type XDP with expected attach type ``xdp_devmap``.
- When a program is associated with a device index, the program is run on an
- ``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
- of how to attach/use xdp_devmap progs can be found in the kernel selftests:
+DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
+to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
+access to both Rx device and Tx device. The  program associated with the ``fd``
+must have type XDP with expected attach type ``xdp_devmap``.
+When a program is associated with a device index, the program is run on an
+``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
+of how to attach/use xdp_devmap progs can be found in the kernel selftests:
 
- - ``tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c``
- - ``tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c``
+- ``tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c``
+- ``tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c``
+
+bpf_map_lookup_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
 
 .. c:function::
    int bpf_map_lookup_elem(int fd, const void *key, void *value);
 
- Net device entries can be retrieved using the ``bpf_map_lookup_elem()``
- helper.
+Net device entries can be retrieved using the ``bpf_map_lookup_elem()``
+helper.
+
+bpf_map_delete_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
 
 .. c:function::
    int bpf_map_delete_elem(int fd, const void *key);
 
- Net device entries can be deleted using the ``bpf_map_delete_elem()``
- helper. This helper will return 0 on success, or negative error in case of
- failure.
+Net device entries can be deleted using the ``bpf_map_delete_elem()``
+helper. This helper will return 0 on success, or negative error in case of
+failure.
 
 Examples
 ========
-- 
2.34.1

