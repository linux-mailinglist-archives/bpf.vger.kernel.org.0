Return-Path: <bpf+bounces-10085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B57A0F95
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E380128229F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11827EC6;
	Thu, 14 Sep 2023 21:05:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD127716
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:05:13 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0892701
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:13 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26d50941f68so1300648a91.1
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725513; x=1695330313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=13spL0Rm0ZGXcXIcH5DSZIzgePO9nUsV+W7OjRfRCTw=;
        b=z7o/7zN8ak/Mld6rjv1ajnGeVLErVL+p+yv/QSP5nA1cEZBJX0JPt6vvWzrkSTjCdn
         KQxLb1UuB2y8bv6rr+u8ArI0ORPPYyJIZ/O+MdMHUDydYDEKbgcuNG/R7oSXQg7MMS/Q
         NHy7GQGog0qzu0JAd5TQVZa0hqjBa64XAKk6uuuQ7jles/2pakDfzbyQU8Ql6x0CYSUl
         +fH4Sre+DiyJ0vC9de0UkobSPE4UdnvUp1NIT4g5b1RPnAZnPBUSzXu3KUpQr6Mqwtz6
         DLYRJ1eLuYKiUA+PRrYt7aQfbD6JrM3m8XN0x86L0ysFwafhmE7QZamgZr5BDghX7JBz
         3Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725513; x=1695330313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13spL0Rm0ZGXcXIcH5DSZIzgePO9nUsV+W7OjRfRCTw=;
        b=cxYp027IZHbRTTpSzf2VPZiJo7i07N8bdsSPJRcsVIiEJLMJ9XUGzedJNGhvM+1sUL
         LOezwyH37i6XdJomBIlM5ihbeVWHTMUu8mS4OsdlMPX/RfbagvtDSn395pel+sQjMMfq
         ObsDmfASf7wPPW8xJe8kMP+P4FHdoaA1pldVlvvrSTEXLcWz71JriaEsPE3rq3LFCETH
         epjZI7hJuMxMj3bT8ayjWgStqFFZRBeZbl5zUG3J9kcYzLk71Dbz5uvJl4J3RMz2TmC8
         PIqrWbCbjWXp+xhK7Ly5Dso7uIaMMHSMn9uxv8KK0chjhMXt4ROyd/hiDNRx09e+fFuG
         Hztw==
X-Gm-Message-State: AOJu0YweWiSZsOAgWeitK6qCkn0FfCDCCS47opCeOnlPzaqcpQCk0dk4
	wDRgz5+jlBAGf7H9uCdziXXKvoPKwKdLHgTrtsp/WIEYFqgp4vS/JR91cTQ3Za/m2DYW5gHuOlI
	GaW8RxJjmsk273zLqYjBkY8JhAJQHBsMCrnR7M0mOHSy1noEGug==
X-Google-Smtp-Source: AGHT+IEMN2hG9dtM5YRRKewCpdKoIKPR7ONPikbZ6FD/09kibOLr5RACjhIMih7flqe4lTNsti13Q60=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:df8a:b0:271:df39:2332 with SMTP id
 p10-20020a17090adf8a00b00271df392332mr165599pjv.9.1694725512346; Thu, 14 Sep
 2023 14:05:12 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:52 -0700
In-Reply-To: <20230914210452.2588884-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-10-sdf@google.com>
Subject: [PATCH bpf-next v2 9/9] xsk: document tx_metadata_len layout
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

- how to use
- how to query features
- pointers to the examples

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/networking/index.rst           |  1 +
 Documentation/networking/xsk-tx-metadata.rst | 77 ++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 5b75c3f7a137..9b2accb48df7 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -123,6 +123,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
    xfrm_sync
    xfrm_sysctl
    xdp-rx-metadata
+   xsk-tx-metadata
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
new file mode 100644
index 000000000000..b7289f06745c
--- /dev/null
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -0,0 +1,77 @@
+==================
+AF_XDP TX Metadata
+==================
+
+This document describes how to enable offloads when transmitting packets
+via :doc:`af_xdp`. Refer to :doc:`xdp-rx-metadata` on how to access similar
+metadata on the receive side.
+
+General Design
+==============
+
+The headroom for the metadata is reserved via ``tx_metadata_len`` in
+``struct xdp_umem_reg``. The metadata length is therefore the same for
+every socket that shares the same umem. The metadata layout is a fixed UAPI,
+refer to ``union xsk_tx_metadata`` in ``include/uapi/linux/if_xdp.h``.
+Thus, generally, the ``tx_metadata_len`` field above should contain
+``sizeof(union xsk_tx_metadata)``.
+
+The headroom and the metadata itself should be located right before
+``xdp_desc->addr`` in the umem frame. Within a frame, the metadata
+layout is as follows::
+
+           tx_metadata_len
+     /                         \
+    +-----------------+---------+----------------------------+
+    | xsk_tx_metadata | padding |          payload           |
+    +-----------------+---------+----------------------------+
+                                ^
+                                |
+                          xdp_desc->addr
+
+An AF_XDP application can request headrooms larger than ``sizeof(struct
+xsk_tx_metadata)``. The kernel will ignore the padding (and will still
+use ``xdp_desc->addr - tx_metadata_len`` to locate
+the ``xsk_tx_metadata``). For the frames that shouldn't carry
+any metadata (i.e., the ones that don't have ``XDP_TX_METADATA`` option),
+the metadata area is ignored by the kernel as well.
+
+The flags field enables the particular offload:
+
+- ``XDP_TX_METADATA_TIMESTAMP``: requests the device to put transmission
+  timestamp into ``tx_timestamp`` field of ``union xsk_tx_metadata``.
+- ``XDP_TX_METADATA_CHECKSUM``: requests the device to calculate L4
+  checksum. ``csum_start`` specifies byte offset of there the checksumming
+  should start and ``csum_offset`` specifies byte offset where the
+  device should store the computed checksum.
+- ``XDP_TX_METADATA_CHECKSUM_SW``: requests checksum calculation to
+  be done in software; this mode works only in ``XSK_COPY`` mode and
+  is mostly intended for testing. Do not enable this option, it
+  will negatively affect performance.
+
+Besides the flags above, in order to trigger the offloads, the first
+packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
+bit in the ``options`` field. Also not that in a multi-buffer packet
+only the first chunk should carry the metadata.
+
+Querying Device Capabilities
+============================
+
+Every devices exports its offloads capabilities via netlink netdev family.
+Refer to ``xsk-flags`` features bitmask in
+``Documentation/netlink/specs/netdev.yaml``.
+
+- ``tx-timestamp``: device supports ``XDP_TX_METADATA_TIMESTAMP``
+- ``tx-checksum``: device supports ``XDP_TX_METADATA_CHECKSUM``
+
+Note that every devices supports ``XDP_TX_METADATA_CHECKSUM_SW`` when
+running in ``XSK_COPY`` mode.
+
+See ``tools/net/ynl/samples/netdev.c`` on how to query this information.
+
+Example
+=======
+
+See ``tools/testing/selftests/bpf/xdp_hw_metadata.c`` for an example
+program that handles TX metadata. Also see https://github.com/fomichev/xskgen
+for a more bare-bones example.
-- 
2.42.0.459.ge4e396fd5e-goog


