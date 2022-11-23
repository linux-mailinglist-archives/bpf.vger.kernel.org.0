Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33D66355FF
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 10:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiKWJ0I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 04:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbiKWJZn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 04:25:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C5ACB68D
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669195408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yLOEntxgW6XZDyPBSZpGTGqsmFIOMyaDB+Wq8jX2tM=;
        b=GDC3DEpt9ff3RRE9UJiMqblPRpiF+WRD9cY6f0GOblJWlCVAYORhjuwW33cOA2rwtzAKG5
        z/QNbJhRWnEcSfUpQLag1OJyYoNi2YvjaOkw2ha+u4F6eSkKjlICOCGkseXxXdQkGEx0L7
        8YGi5sAY66dFEg02KJ9S6A3WN/LMRUQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-VaMIBlPIOiuwyKdI_27F0A-1; Wed, 23 Nov 2022 04:23:27 -0500
X-MC-Unique: VaMIBlPIOiuwyKdI_27F0A-1
Received: by mail-wr1-f69.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso4723920wra.1
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yLOEntxgW6XZDyPBSZpGTGqsmFIOMyaDB+Wq8jX2tM=;
        b=7+0fJ1v0H7MTvENiLwIFStvAeJlGzPzLUh83Lz5jZOXvor+S20ZsfKaWIVvnwfJnqV
         A8hklq6RUP8OihJBp9PNOAaqCVgAhT/IqCDnFRwq9fNQnGPOcjWRb6VThs5lSlqpWL66
         Sk5JHDeCQoMS38pxtHsqQKMyDpxHWNqXjTotpptQoy6jh9i9yA0aBWMcuU9O84LUkzcR
         Ospxo0lJVOExdIMjuhEGGxlUFfwAIg6/5W2kd7Om19ZNpzzzBFklb2Wx813KNjAFzTNz
         ceHwOOd02mpOtwIwzWbtq5Fcu0AXvxuVR+VsT0T2CmgWWeFjF5xhLcnsPyHkgNiA7z3E
         e+3g==
X-Gm-Message-State: ANoB5pmPQRYwzoF+OPysshkzqL3KChYsnaMrCg9GBzWLZlYr30YabMIh
        RMileqUgGgllqZi9LqZOD+O0+fB785ndUGt1ONmG7PxW/J5/8jjmr+nQlmHYltL5pTrYPGVTUve
        w+Z2usBuMkLRkevfFzI/Iz0f5mc/9c+nR4dw2YIAPN4uCBYcrQqa9XeCf2N4KtD0=
X-Received: by 2002:a5d:6049:0:b0:22e:32f8:ca31 with SMTP id j9-20020a5d6049000000b0022e32f8ca31mr4897907wrt.247.1669195405639;
        Wed, 23 Nov 2022 01:23:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4BwqRdNZX+Siq0GkuoQda8Ng+mNqdCeZka/q3m7zL5BjbLY0O/Wo+kzZDJhWYqpzj/iLIUMA==
X-Received: by 2002:a5d:6049:0:b0:22e:32f8:ca31 with SMTP id j9-20020a5d6049000000b0022e32f8ca31mr4897882wrt.247.1669195405363;
        Wed, 23 Nov 2022 01:23:25 -0800 (PST)
Received: from localhost.localdomain ([78.19.107.254])
        by smtp.gmail.com with ESMTPSA id w19-20020adfbad3000000b00241c6729c2bsm13048855wrg.26.2022.11.23.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:23:24 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        akiyks@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v3 1/2] docs: fix sphinx warnings for cpumap
Date:   Wed, 23 Nov 2022 09:23:20 +0000
Message-Id: <20221123092321.88558-2-mtahhan@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123092321.88558-1-mtahhan@redhat.com>
References: <20221123092321.88558-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Sphinx version >=3.1 warns about duplicate function declarations in the
CPUMAP documentation. This is because the function name is the same for
kernel and user space BPF progs but the parameters and return types
they take is what differs. This patch moves from using the ``c:function::``
directive to using the ``code-block:: c`` directive. The patches also fix
the indentation for the text associated with the "new" code block delcarations.
The missing support of c:namespace-push:: and c:namespace-pop:: directives by
helper scripts for kernel documentation prevents using the ``c:function::``
directive with proper namespacing.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 Documentation/bpf/map_cpumap.rst | 56 +++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
index 61a797a86342..923cfc8ab51f 100644
--- a/Documentation/bpf/map_cpumap.rst
+++ b/Documentation/bpf/map_cpumap.rst
@@ -30,29 +30,35 @@ Usage
 
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
 
-Userspace
----------
+User space
+----------
 .. note::
     CPUMAP entries can only be updated/looked up/deleted from user space and not
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
@@ -141,8 +153,8 @@ The following code snippet shows how to declare a ``BPF_MAP_TYPE_CPUMAP`` called
         return bpf_redirect_map(&cpu_map, cpu_dest, 0);
     }
 
-Userspace
----------
+User space
+----------
 
 The following code snippet shows how to dynamically set the max_entries for a
 CPUMAP to the max number of cpus available on the system.
-- 
2.34.1

