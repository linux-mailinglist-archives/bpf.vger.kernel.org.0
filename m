Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EE5633A5F
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 11:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiKVKo2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 05:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiKVKoB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 05:44:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DBA23BEF
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669113467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+4gJYDnQvTuS/31lYB/e4/AodAkPbxTauMPJtMr03Q=;
        b=ZliFbYjs+/2qB+F2KP9tLjWHtKGr8M8ejonM7UieCUlwC3vxkj7RTwvHa3nxq+E0X1/4ov
        +4rpcK3h5Ii8kfC8UnyBSmUAuIRNuVVtGr0/r0+DSCx+e2MJdvwlyGTeXLbey6AAyV8QxM
        LOp5cD1r+QOeHHOtxhjcAGi0pSHvqIs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-T108CTNjNLqA8wXXBgIIIw-1; Tue, 22 Nov 2022 05:37:45 -0500
X-MC-Unique: T108CTNjNLqA8wXXBgIIIw-1
Received: by mail-wm1-f70.google.com with SMTP id c126-20020a1c3584000000b003cfffcf7c1aso8547637wma.0
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+4gJYDnQvTuS/31lYB/e4/AodAkPbxTauMPJtMr03Q=;
        b=i0ZpIbCTb4EbhO1rmKXYh6HnpGvbAvrtpoZoX7jl7/CPZppRD0LJG4Hn27r3AACVrE
         An3OS0tCb9C+7hs1xyrn14JwjZiRFjzbxY9jfs49jdvRzIhK+T4KpRNUWNRbgxrGNMF+
         u60goY1Nq2uT9B6E2RkNMayknNZB32lqT9PelWzjejwQcYG6Dd1M9dpQeXXCnIQ9q7P0
         DVZtanRO1No4kDHkiYY+Pjd0hAlEBdv3Gu/vxnauQePg9tvzyzlQGCroRNHiAHfyuB00
         m0h3rh396fO4sU9KqEBH7yJVQ5smocLIIft3z8CAJe6MFV1k2Gyg/IwviaQlck+HPOQI
         bsqQ==
X-Gm-Message-State: ANoB5pn6AlBVx8uIDPeMCHmhZDvON/CZn++9uysEeei1HatZ86MHgU2H
        P3eYFT3nKuHpOYpAPQDefSqcrZBs0+wTR5R3Dmpbcz7QTp9++OVZ/gfEql089CEUrfEQZRnPGX3
        8v9+n3NumsRgmhRmfZCntYbnG8Ey+OV3UbaeE0FWEAUWXRo5ouF0LhtmRgVY+iw8=
X-Received: by 2002:a05:600c:4f92:b0:3cf:e87a:8068 with SMTP id n18-20020a05600c4f9200b003cfe87a8068mr9603572wmq.3.1669113463720;
        Tue, 22 Nov 2022 02:37:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Ab8h51KNcYx1KMRerv4pVPNWsPhdy90oxEI7wCRvozraqNMuP3TQujOLw162yul2tIKLrjQ==
X-Received: by 2002:a05:600c:4f92:b0:3cf:e87a:8068 with SMTP id n18-20020a05600c4f9200b003cfe87a8068mr9603540wmq.3.1669113463345;
        Tue, 22 Nov 2022 02:37:43 -0800 (PST)
Received: from teaching-eagle.redhat.com ([78.19.107.254])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003c65c9a36dfsm18674438wmo.48.2022.11.22.02.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:37:42 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        akiyks@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v1 1/2] docs: fix sphinx warnings for cpumap
Date:   Tue, 22 Nov 2022 10:37:37 +0000
Message-Id: <20221122103738.65980-2-mtahhan@redhat.com>
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
CPUMAP documentation. This is because the function name is the same for
Kernel and Userspace BPF progs but the parameters and return types
they take is what differs. This patch moves from using the ``c:function::``
directive to using the ``code-block:: c`` directive. The patches also fix
the indentation for the text associated with the "new" code block delcarations.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 Documentation/bpf/map_cpumap.rst | 48 ++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
index 61a797a86342..e8d9f7abf26a 100644
--- a/Documentation/bpf/map_cpumap.rst
+++ b/Documentation/bpf/map_cpumap.rst
@@ -30,15 +30,18 @@ Usage
 
 Kernel BPF
 ----------
-.. c:function::
+bpf_redirect_map()
+^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
      long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
 
- Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
- For ``BPF_MAP_TYPE_CPUMAP`` this map contains references to CPUs.
+Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
+For ``BPF_MAP_TYPE_CPUMAP`` this map contains references to CPUs.
 
- The lower two bits of ``flags`` are used as the return code if the map lookup
- fails. This is so that the return value can be one of the XDP program return
- codes up to ``XDP_TX``, as chosen by the caller.
+The lower two bits of ``flags`` are used as the return code if the map lookup
+fails. This is so that the return value can be one of the XDP program return
+codes up to ``XDP_TX``, as chosen by the caller.
 
 Userspace
 ---------
@@ -47,12 +50,15 @@ Userspace
     from an eBPF program. Trying to call these functions from a kernel eBPF
     program will result in the program failing to load and a verifier warning.
 
-.. c:function::
+bpf_map_update_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
     int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);
 
- CPU entries can be added or updated using the ``bpf_map_update_elem()``
- helper. This helper replaces existing elements atomically. The ``value`` parameter
- can be ``struct bpf_cpumap_val``.
+CPU entries can be added or updated using the ``bpf_map_update_elem()``
+helper. This helper replaces existing elements atomically. The ``value`` parameter
+can be ``struct bpf_cpumap_val``.
 
  .. code-block:: c
 
@@ -64,23 +70,29 @@ Userspace
         } bpf_prog;
     };
 
- The flags argument can be one of the following:
+The flags argument can be one of the following:
   - BPF_ANY: Create a new element or update an existing element.
   - BPF_NOEXIST: Create a new element only if it did not exist.
   - BPF_EXIST: Update an existing element.
 
-.. c:function::
+bpf_map_lookup_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
     int bpf_map_lookup_elem(int fd, const void *key, void *value);
 
- CPU entries can be retrieved using the ``bpf_map_lookup_elem()``
- helper.
+CPU entries can be retrieved using the ``bpf_map_lookup_elem()``
+helper.
+
+bpf_map_delete_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
 
-.. c:function::
     int bpf_map_delete_elem(int fd, const void *key);
 
- CPU entries can be deleted using the ``bpf_map_delete_elem()``
- helper. This helper will return 0 on success, or negative error in case of
- failure.
+CPU entries can be deleted using the ``bpf_map_delete_elem()``
+helper. This helper will return 0 on success, or negative error in case of
+failure.
 
 Examples
 ========
-- 
2.34.1

