Return-Path: <bpf+bounces-15971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7A7FA98F
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF64B21178
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC3A3EA8E;
	Mon, 27 Nov 2023 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OscE3gt4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFFCD6D
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:33 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cd6a86a898so52729067b3.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111812; x=1701716612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zp0NfVT6k+O+cDddTZy09JqchV8tKkVXuv7rsNqmLRk=;
        b=OscE3gt4+csTDYj2aCvRlzNko3HlRLpX8E/IdycxO/jCWsv4HJUU/ca7gqew1cL9/j
         jPRIsGULNg1pDBeewZ4wtsPZmWBLXSJQiHPJlzIXGajvKj/prnVWe959Eedf6UYELnGK
         o+splSS4zVl0R+8la3tp0bTAEaCWqwHE2IaWQEWs+H7yZdY/83STRrM6nHYg1R2V6Xpu
         4E1BwhZ7a3/1maIOH2Omj9lDfxPApicM2iQpI2yJR7+0RBCW4pv7QTDSWU0QdxDDRykb
         Ku2QSZZpXomAbOysagoXH4MqufKOzWyPuHDfGWApEsJucH5hfkqS/5XefVto0dGVKFu+
         zfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111812; x=1701716612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp0NfVT6k+O+cDddTZy09JqchV8tKkVXuv7rsNqmLRk=;
        b=LJrVTjkUColzB923wtm1rBB2rTBc9CYpG8oBdrxrloudahc/kNhqtZU3MeQLpkzhgn
         D8BSYMNW4cL3PH4Jh1QRB8kyGX+rQWD5Ha6+kX2MwPDEvqCbXRvbiMfGqNakixtDpgVN
         Lx903X9tQpJUX7JyTRnFV8VDuQsB15VYSBuPjOEiZs4nddMHmmb+JIBF0lgCB2V79Vn4
         d9QbOpdmO4rkEZu2vs2CICvZm4AUf9WiWHSaFkXx09kBlY2JHx4TjBVrIDW7Sziu6H/l
         ViOBh20v9rJamCTfuD+/xWTtb6IcPInn43kEcfWIIg4OBjVOIWT+kN+aqeIaHTFxpyYO
         Xwhg==
X-Gm-Message-State: AOJu0YziarDkezXRiGcwsh54qbOg0nZkAWiFH9uoG86c8Z1BwZzjc5S7
	sCY3ZGf6XV6GId0V/EItNrpvpiucJmFp2rpIhBxDGDBbVdZccXexOMUQ8luDs7MfFR8AXnJEJoI
	6MCLY5deNmbDHPRrLttTGKkR0wQwq/l/tAVWvFG9khUkIdNuXdw==
X-Google-Smtp-Source: AGHT+IFD35ro+x7PheJe+DmDJlu2/a0Hzt5yVOIeVEMuqqZBdyVEqsELGNDZNdlVsxO3j8SPEB5mPXE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:844:b0:5cb:d84d:218c with SMTP id
 bz4-20020a05690c084400b005cbd84d218cmr415973ywb.0.1701111812437; Mon, 27 Nov
 2023 11:03:32 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:12 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-7-sdf@google.com>
Subject: [PATCH bpf-next v6 06/13] xsk: Document tx_metadata_len layout
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
 Documentation/networking/xdp-rx-metadata.rst |  2 +
 Documentation/networking/xsk-tx-metadata.rst | 70 ++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 Documentation/networking/xsk-tx-metadata.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 683eb42309cc..a297a894b366 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -123,6 +123,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
    xfrm_sync
    xfrm_sysctl
    xdp-rx-metadata
+   xsk-tx-metadata
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index 205696780b78..e3e9420fd817 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===============
 XDP RX Metadata
 ===============
diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
new file mode 100644
index 000000000000..4f376560b23f
--- /dev/null
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -0,0 +1,70 @@
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
+- ``XDP_TXMD_FLAGS_TIMESTAMP``: requests the device to put transmission
+  timestamp into ``tx_timestamp`` field of ``union xsk_tx_metadata``.
+- ``XDP_TXMD_FLAGS_CHECKSUM``: requests the device to calculate L4
+  checksum. ``csum_start`` specifies byte offset of where the checksumming
+  should start and ``csum_offset`` specifies byte offset where the
+  device should store the computed checksum.
+
+Besides the flags above, in order to trigger the offloads, the first
+packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
+bit in the ``options`` field. Also note that in a multi-buffer packet
+only the first chunk should carry the metadata.
+
+Querying Device Capabilities
+============================
+
+Every devices exports its offloads capabilities via netlink netdev family.
+Refer to ``xsk-flags`` features bitmask in
+``Documentation/netlink/specs/netdev.yaml``.
+
+- ``tx-timestamp``: device supports ``XDP_TXMD_FLAGS_TIMESTAMP``
+- ``tx-checksum``: device supports ``XDP_TXMD_FLAGS_CHECKSUM``
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
2.43.0.rc1.413.gea7ed67945-goog


