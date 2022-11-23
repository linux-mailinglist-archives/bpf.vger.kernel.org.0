Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E663553C
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 10:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiKWJQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 04:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiKWJQT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 04:16:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68726107E62
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669194927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oRXRsO8/e/+wD/x2i3+RJoWx0WjJz2M9yYxlaD5dpSA=;
        b=c+joJQdCIPcAUkFo2o9LKqlNNWg++OTqGnJGfRQVwtGnzF7r+vpUllPsZNwbx1YrK29ZSJ
        kaWu3gTgAWIx0NLfqqfDcez3LwpLdqb3QWvG+9TRK2JevT5Pf6f7kjmGRR8Xw78rSbO0/u
        jOl5mTc/LFZNjQ2cVRz1r6lHVoqGegc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-29-P9ErqwqiPlK_TnLqJ__KbQ-1; Wed, 23 Nov 2022 04:15:26 -0500
X-MC-Unique: P9ErqwqiPlK_TnLqJ__KbQ-1
Received: by mail-wm1-f69.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so9355121wmh.1
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRXRsO8/e/+wD/x2i3+RJoWx0WjJz2M9yYxlaD5dpSA=;
        b=6jD/1FY0BDzJEy0ds82yZQs4gJg66zEDLkWNrwsdzlBZbxpeAvUoTxMYgr9Enh4S9g
         G8H+o0TTYNkgdak+XxDJtWTDgAZRLP7BU1Bupyz2kHYHwJ1ozU0XkwY4RL09ZZtxzJNo
         iYDtav/SfZ7SXs5JZkPEbrv6L/Svg3WyTKgdcsZAadX11WWLq88DyDHHLxzcoBdF8wb5
         jSiz01yozDmMSNDi3BaOFwC744G8W88abyyZbbzb1AF/wr/RVqVbcWTRZqt+YKivO62T
         gvaxhYXolw/VpXGuy9EKgsy7cqY1k6it7LTXZfPUTKpmiY261GN57G+rnjaUnuUTUuKd
         o9Rg==
X-Gm-Message-State: ANoB5pk9IQOPhZbAxHCu2dbJlU6hqjMagvy5ILLo3GmODPIH1lVNkdOt
        dsQwQ0b9+5NyjgeFiQzcwJKxpBiLnIvVi1tfl7FQgNXvZDQEvySNfLJ9ZJ7JqCWudXFZ/NDFVtg
        yEjj5iHq4WD0A6exmZoC2Y23HdsuQTmckjFSKTJPNblG+DI9hn+zd2MBICCFoevI=
X-Received: by 2002:adf:ef0c:0:b0:241:e4cc:f03d with SMTP id e12-20020adfef0c000000b00241e4ccf03dmr3882693wro.43.1669194925152;
        Wed, 23 Nov 2022 01:15:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf78YyUnqWUmXurkk9eBK0p6XvhtGOBou0NH1pECyUrbB8XshQZzNOF44CUDFcWuiTYX0y3Y3w==
X-Received: by 2002:adf:ef0c:0:b0:241:e4cc:f03d with SMTP id e12-20020adfef0c000000b00241e4ccf03dmr3882667wro.43.1669194924859;
        Wed, 23 Nov 2022 01:15:24 -0800 (PST)
Received: from localhost.localdomain ([78.19.107.254])
        by smtp.gmail.com with ESMTPSA id r13-20020a056000014d00b0024165454262sm16008369wrx.11.2022.11.23.01.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:15:24 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        akiyks@gmail.com, Maryam Tahhan <mtahhan@redhat.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 1/2] docs: fix sphinx warnings for cpumap
Date:   Wed, 23 Nov 2022 09:15:19 +0000
Message-Id: <20221123091520.87289-2-mtahhan@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123091520.87289-1-mtahhan@redhat.com>
References: <20221123091520.87289-1-mtahhan@redhat.com>
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

Sphinx version >=3.3 warns about duplicate function declarations in the
CPUMAP documentation. This is because the function name is the same for
kernel and user space BPF progs but the parameters and return types
they take is what differs. This patch moves from using the ``c:function::``
directive to using the ``code-block:: c`` directive. The patches also fix
the indentation for the text associated with the "new" code block delcarations.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
Acked-by: David Vernet <void@manifault.com>
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

