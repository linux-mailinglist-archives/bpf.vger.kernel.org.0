Return-Path: <bpf+bounces-12721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C07D00F4
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FF3282258
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BE938DE4;
	Thu, 19 Oct 2023 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxfdhkMF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A1C3B7A2
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 17:50:08 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DAC11D
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:50:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8d9dcdd2bso16990387b3.2
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737806; x=1698342606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPwWKJwDsC2YehI3kbqO9vkbp5bLVw0qzVyvRYEEyrk=;
        b=XxfdhkMF+ighU8tuZqEy2r5YJaYkJ7teRpTHYaWBa8NkY9OTRxnRj5+BNZ0+Pa3u43
         hwvQQyZJsAEPOudUWbfEtitKEZV4aBgG2wMXUpiJTVuNnosncuiQ6Zlr7s8s1aMKw3Us
         wTXbOXgnva7OHU2EcsK3aZLIQgjdEk8rNvSoP72RV+DLb5KmHb5zQlhRx0HrK4zy5gaY
         pD2En36CLMSxjs2oSJgBIy7x6mrQAMFr4YFFyviopUzYVh9gKPoVCfQ8U8NAX6zQKOnX
         1AMftV6gPNjIi/CT95F/hvSxadcf+3ZxqZfw8HiuygyBDlUtZ1oJoh6ZLhyBnN7OqIA2
         bjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737806; x=1698342606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPwWKJwDsC2YehI3kbqO9vkbp5bLVw0qzVyvRYEEyrk=;
        b=JqdumDh2nH/mGpmNgxd9h4ue1Wdzx6xCQUoUt5Zd8NkMKw0tZLTYpKl7MihNOvqTXx
         eSSbs9OQCbu6lBhkpWgrz869vqlewkhfv0hPaPg4bVdal+F1lp7pC/ze5CdbRVWEM41x
         JKi3NeIENLgaIOWtY7GXelVczJA/aXx66D+qWCzXbLlwmPjkpbG0qmicuLreSTIg2APh
         VefOSUc7HWoWRR0vWKREbuw0hn95aMdju+KkGHBGB7wZ+XK6vp9HqHwAT4nvms5FnXBp
         phepuV2s4en070GI8LobTs0q26mP5cXYdM+AzSMwO1KNFLalD/bpUD1tTUBXB9hsFvk1
         OSPQ==
X-Gm-Message-State: AOJu0YzfKKXAoMX96Ug9jPrjZRwtDFXLWQj+i1b1usjpTmDMU3IhFpGS
	67sLU0GgXeSzCu4fJqBjm9Wq18tITnFuUNoXyxOv7swRlF0+5D2zT09PQ2d47vkt/V68ebr4wyP
	OeWMAJXcDsoeUo74N/wbKrdwmHwb0yJS+P62FYIN9bERgfA9kZw==
X-Google-Smtp-Source: AGHT+IFZV5ghtzBMWXEbUT8RZK3/uvitsmQ/T8gHLg0h3ipUNE+ychR+MJ+lpb6PGz1g/dJdb2GUgUk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:dbcb:0:b0:5a7:b9b0:d23f with SMTP id
 d194-20020a0ddbcb000000b005a7b9b0d23fmr67605ywe.6.1697737806274; Thu, 19 Oct
 2023 10:50:06 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:44 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-12-sdf@google.com>
Subject: [PATCH bpf-next v4 11/11] xsk: Document tx_metadata_len layout
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
index 2ffc5ad10295..f3c2566d6cad 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -122,6 +122,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
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
2.42.0.655.g421f12c284-goog


