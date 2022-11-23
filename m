Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59C76355E3
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 10:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiKWJ0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 04:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbiKWJZu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 04:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC529CD94F
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669195409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxJTXgscTEjZXq9Yj4bOuKdInJp2SrRUFvEsZqu2Ez0=;
        b=Sy9YMV/AlAOfiEFw6JUqSNTlLv3ZTPaLEa4tc/bf+VY+Y6pfPc5Ianc1UT2rJlW01h67BL
        nO22nyYYSla2NjUaUP8QfvmMaiGGBi4NkP26SWtYAkb/KFigzYlU2CqRP4FM1mTSG3D1y4
        fPEuh4Y7I53Kt1YY+l1z9q49AH/0b+8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-1JajjUYDOxu_31GngQLwlg-1; Wed, 23 Nov 2022 04:23:28 -0500
X-MC-Unique: 1JajjUYDOxu_31GngQLwlg-1
Received: by mail-wr1-f72.google.com with SMTP id s1-20020adfa281000000b00241f7467851so9508wra.17
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxJTXgscTEjZXq9Yj4bOuKdInJp2SrRUFvEsZqu2Ez0=;
        b=OCiv0gzVwGZQGXYTeqL9q6/Sm3kDegxO59o/9jX2J3j4belbW1DjmU/IV6iR+RLlUq
         iZMXziBB/b7TPrAvwnmzaaH3pw2QX42r3ZlucSTxOpR7yu7d04ikZcgZGLmqIgvCP4PJ
         y9pEOOvEHY+52ATHtaD42arwG/KFxxPrty0wnBMMPO+5Uc3/MsZBQeCILfPGeXmrwkzk
         hiIzvcy41qbP4lW/dmRH0bQ5H9qDbaH0wq4dI8tqbBur3hwUsHvmT7p2VQ8CYNuaqQ1A
         FXHQhpkxWOCMo8QnwDhT7itwnavAU46Zp6aJbC01F9eNxv52KoPtqIf1sOe9useYSCRG
         bIjg==
X-Gm-Message-State: ANoB5pmD+88zsx7SRgd+fgPylt4jeYZS0GSCx7xZCxaU1tdR3ud8XKj9
        5joGZvyHDgx4f7elR1ZJb7oy7IDNWGHY24n++CqGNU3Qbg9Kn1iRfSCVE3DQh1gyPnoWOlIwEVo
        e34ZJjzWeUaVjYxT3PqBNoq8t1YEndH72xAj7wB8Q+bT3ASU7kJJXx/edeiomaGM=
X-Received: by 2002:a5d:6b45:0:b0:236:7a1c:c41a with SMTP id x5-20020a5d6b45000000b002367a1cc41amr5553766wrw.680.1669195407356;
        Wed, 23 Nov 2022 01:23:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf57A0de8DOQovtNNfh6Uk1F1XYGnqWBBzOdjOEQPLBev3iul8PfgvSmywjpcu4W9T1i77G0lw==
X-Received: by 2002:a5d:6b45:0:b0:236:7a1c:c41a with SMTP id x5-20020a5d6b45000000b002367a1cc41amr5553749wrw.680.1669195407058;
        Wed, 23 Nov 2022 01:23:27 -0800 (PST)
Received: from localhost.localdomain ([78.19.107.254])
        by smtp.gmail.com with ESMTPSA id w19-20020adfbad3000000b00241c6729c2bsm13048855wrg.26.2022.11.23.01.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:23:26 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        akiyks@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v3 2/2] docs: fix sphinx warnings for devmap
Date:   Wed, 23 Nov 2022 09:23:21 +0000
Message-Id: <20221123092321.88558-3-mtahhan@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123092321.88558-1-mtahhan@redhat.com>
References: <20221123092321.88558-1-mtahhan@redhat.com>
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

Sphinx version >=3.1 warns about duplicate function declarations in the
DEVMAP documentation. This is because the function name is the same for
kernel and user space BPF progs but the parameters and return types
they take is what differs. This patch moves from using the ``c:function::``
directive to using the ``code-block:: c`` directive. The patches also fix
the indentation for the text associated with the "new" code block delcarations.
The missing support of c:namespace-push:: and c:namespace-pop:: directives by
helper scripts for kernel documentation prevents using the ``c:function::``
directive with proper namespacing.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 Documentation/bpf/map_devmap.rst | 68 ++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devmap.rst
index f64da348dbfe..927312c7b8c8 100644
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
@@ -56,26 +59,32 @@ lower bits of the ``flags`` argument if the map lookup fails.
 
 More information about redirection can be found :doc:`redirect`
 
-.. c:function::
+bpf_map_lookup_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
 
 Net device entries can be retrieved using the ``bpf_map_lookup_elem()``
 helper.
 
-Userspace
----------
+User space
+----------
 .. note::
     DEVMAP entries can only be updated/deleted from user space and not
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

