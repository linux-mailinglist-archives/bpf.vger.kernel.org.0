Return-Path: <bpf+bounces-7394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930977765D2
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F98281DA4
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11021DDFA;
	Wed,  9 Aug 2023 16:54:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F801DDF3
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:54:38 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92271FCC
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:54:37 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c04f5827eso96270a12.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691600077; x=1692204877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJoavCGKjXu9UnlxQ5IcBXvgyyUeMKP0A11XWYAQ1ew=;
        b=kvSg/9Hek343JKZCf21rk4DCwQuEINE4swLbHVXptGH1QbLiEU81hPKASxUg7udt1x
         2C7CQMXUfTSzdtNB5+uZ+PBzqH5cAL8wEPwYzssAE0/KHM/UQ8hetp31o21667mVymXg
         BZQqV0K0IzD9L3BUrn3NR8dxoZxpkswXGxwsRe3lFKOPZyR4Gt38HUJHMSPRKrkbcvLy
         FeYOEP1p5F61yz+spNhYnAwzWh0oFEh4rLEVja8VoWkcXpkPxBpzb6rPg2W+iEFh83Fm
         py3M1GYi5IdrB+U8Hnjqsmq87Vwjnh550dwrYqIrw2UUXBhLUyfctBgi+hwQvD511pph
         tzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600077; x=1692204877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJoavCGKjXu9UnlxQ5IcBXvgyyUeMKP0A11XWYAQ1ew=;
        b=l8NqnmZ7yX3LB6kb6FEtUprtKtZjwwHIHZqCv427BpY7Ja/VLxRA5rbM6xSlyHHzk7
         iTVw9BoTvKo9loDRIfuoxr0c7Y1OpYjnPx2hgVg/b9OHQQMYoJjBZZfwGeDN9FOWgo3G
         vZF6oCCpiLW017jSWaQYNYyzoDHcqQpbE3Vb/xIy5JlXAcxTmsrsmpgCBe7/lhggN9Yx
         GUBXxN7msTQLT3EfzPLcF9nL4f6S3tCmCG2GIO5dFWq4pUIoYLw0aLcCsVURBUKtIpln
         rlFWST6EcLKKQClo8/pHNrHwMKAQTDTz6FezeV4yyuEbyzKpvYloK+qYyHMFmzTEUGSU
         a+ug==
X-Gm-Message-State: AOJu0YwWxhkvMkOcR4DDkrfDhxl/GgoWrWTfUaUc8X9VaZDaE44q4wlN
	ibKDXyLcEO1scWCOfCvH/+BUYYRhyzgt5iO9whxk2hm31EzZUe4KYNBDQg89pJ0yB3oGBkoYCFS
	0aCy9quE0uzxB9W0y4qw7Ov0U/Cm54XB3XPq7RFMwSFtlpUF6KQ==
X-Google-Smtp-Source: AGHT+IHkfEo/CuHLYJIBUJRCQ7P11C7kKQOtUR2S1XofX6DHMVaQijoivra6RCsunqQCuHo0nFrNLiM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3e07:0:b0:553:3ba2:f36 with SMTP id
 l7-20020a633e07000000b005533ba20f36mr331443pga.9.1691600077041; Wed, 09 Aug
 2023 09:54:37 -0700 (PDT)
Date: Wed,  9 Aug 2023 09:54:18 -0700
In-Reply-To: <20230809165418.2831456-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809165418.2831456-10-sdf@google.com>
Subject: [PATCH bpf-next 9/9] xsk: document XDP_TX_METADATA_LEN layout
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
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
 Documentation/networking/xsk-tx-metadata.rst | 75 ++++++++++++++++++++
 2 files changed, 76 insertions(+)
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
index 000000000000..41600f08f794
--- /dev/null
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -0,0 +1,75 @@
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
+The headroom for the metadata is reserved via ``setsockopt(fd, SOL_XDP,
+XDP_TX_METADATA_LEN, &len, 4)``. The metadata layout is a fixed UAPI,
+refer to ``struct xsk_tx_metadata`` in ``include/uapi/linux/if_xdp.h``.
+IOW, the ``len`` variable above should contain
+``sizeof(struct xsk_tx_metadata)``.
+
+The headroom and the metadata itself should be located right before
+``xdp_desc->addr`` in the umem frame. Within a frame, the metadata
+layout is as follows::
+
+         XDP_TX_METADATA_LEN
+     /                         \
+    +-----------------+---------+----------------------------+
+    | xsk_tx_metadata | padding |          payload           |
+    +-----------------+---------+----------------------------+
+                                ^
+                                |
+                          xdp_desc->addr
+
+An AF_XDP applications can request headrooms larger than ``sizeof(struct
+xsk_tx_metadata)``. The kernel will ignore the padding (and will still
+use ``xdp_desc->addr - XDP_TX_METADATA_LEN`` to locate
+the ``xsk_tx_metadata``). The application is expected to zero-out
+the metadata flags for the frames that shouldn't use any offloads.
+
+The flags field enables the particular offload:
+
+- ``XDP_TX_METADATA_TIMESTAMP``: requests the device to put transmission
+  timestamp into ``tx_timestamp`` field of ``struct xsk_tx_metadata``.
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
2.41.0.640.ga95def55d0-goog


