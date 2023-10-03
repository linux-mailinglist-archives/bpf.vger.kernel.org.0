Return-Path: <bpf+bounces-11312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF717B7247
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 4E4B91F21465
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77E33D39A;
	Tue,  3 Oct 2023 20:05:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF43D3BE
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:05:46 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561CAC6
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 13:05:45 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5789f2f13fcso919568a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363545; x=1696968345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddjKpJ/j1G+ZcWV9ZUKV5M/PQS+TN4o9oLf/XIDMvT0=;
        b=uMPCL5NRNRfHmw0XX3oC3uxrjJjzU5w36ACc77qsx6DEgFS2+G0aKUW+X9PmyaFm5t
         Jlis7a3/cnJBRpfe2acZYfznbhsfa0wN1Ys9/1Ohckq//ZXhLcPYnkpw6gzJ6d4u1Hne
         BH1RAYfCXZLdB+Lbc7MnXU7N3Z14KjWQHHRoqL4JhM96rITwfaKI28yQe7tWaR1NcQZV
         FHfMwyS9NkH4cK1/WB2Lr/Bsr6z6qU/JxBSRvfjwkGF0HoyuQubJjYac/i6DfEUqE/Af
         aOrmITU7zwoNYasli86XFVY5/dfO16L2tHV6hirY7ktWEjw/hunpZNDof+AmBCRO2MaC
         +D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363545; x=1696968345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddjKpJ/j1G+ZcWV9ZUKV5M/PQS+TN4o9oLf/XIDMvT0=;
        b=qjkNhSAkck6s+1zIdMtc8G3xDeZHfpLQDoNtLpZEm6OTOlM+1LwymU/letO2S1fWav
         IkUYJznOUA5Lawj2MfQPLH16KYOptQIz3mB27mULXm4/eevYVYJUVhI8XKu8ZOA9QtbD
         PR8rpekNnn/ramX7pN2FucVIs8GPViUgNVvGRddc7WZjhVXqkiVBvxag6G9CwCNOmKXV
         XHQTdDdGjTB1cIL+mS/lDe1WrSV1Sddn3DVvumE62bqHQbOboTVTLXzIqLDSwhYugkxy
         3naR35mfbiEIsyb6eL2SZITVCKuGTRrLkj3EuqrZwc0Dpb+JLYs1119BiBhlh0mWiTZ4
         w5Cw==
X-Gm-Message-State: AOJu0YyNMmCNLuwZ3PomLpotvn7dYDLQX5J7jaW4EcIbdIl7146fZlvL
	DsvTWaiU+sNFZoCICRMp6de86hgK3P6dIXLZkifXmN08L13Oa5mS4/T4e6nFWC3GjKGtMDRXOLc
	epSTZS35XjBG35xtWWMFzj1LA2PDX1mUQo6XT/KqYHkoBy/zIjQ==
X-Google-Smtp-Source: AGHT+IHXFrX38JHtyz5X3PE83Rd8dAQVVm4RG96h1vPXKxzvU3mGdy870f7x45uhm+p3usn+E2TiKR4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6d86:0:b0:566:1c6:139b with SMTP id
 i128-20020a636d86000000b0056601c6139bmr2233pgc.8.1696363543796; Tue, 03 Oct
 2023 13:05:43 -0700 (PDT)
Date: Tue,  3 Oct 2023 13:05:22 -0700
In-Reply-To: <20231003200522.1914523-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003200522.1914523-11-sdf@google.com>
Subject: [PATCH bpf-next v3 10/10] xsk: document tx_metadata_len layout
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
2.42.0.582.g8ccd20d70d-goog


