Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB1362905E
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 04:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbiKODD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 22:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbiKODDM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 22:03:12 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D11BE83
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:02:14 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q63-20020a632a42000000b0045724b1dfb9so6735569pgq.3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7Vman8qfNtTZB6r6aTNPGFOv5a3C0qHKKQ3/SbdT4Q=;
        b=FymJYW6y9M1ExpR+i/pawUZZGTmTF6qVEjvG3D1/8zUCPUWXw2bMA5p8qNHGc91uFA
         /YykIRp35jQVikhTm68oyXejSNivjXdoywX6RrBimP+5XCAFEifH5KLnonBtrBKDRthP
         C5XXrW1w1cp+KKNe8Rq2pT1IsqZRM5lMO+Mm1iLJnFT8hSQB0f0/EL6wjMbj3wbCc6M5
         O6HsaRoyDpgDvyV4EzPwe9rCPBG8vJgA+8sWxy3xn3l+Pmf/FybH/DHeFT3/Y9HD5FWs
         Yf2O8cGkGs5Key6LXF6PQYdsN/BcwIk07Qx3BdjMZA6VP1KUJkaNkW/0MMCZpCyNxV+l
         eYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7Vman8qfNtTZB6r6aTNPGFOv5a3C0qHKKQ3/SbdT4Q=;
        b=gHlxS6vV0Us17pJAXo6iea0EECAJitVtcgYLCLyRetZWvvf3aWuiEoQ9XLQfgZJ7AG
         yHUE+/qrjD88foMPhgz3DXpWCj81HDOXeVaQDMg6CfoDyOslNRn+uMOsf0fGThTIjr6x
         eNJP9pgBGFnv//XMA3kVkeflU2koPanBp9EyTV2f7g64rPm4JUCVZvzorKd/xyN7zDwj
         uafmLdmjOObvfn90cRbGW80nkMPu988LvVL7DGnRimawX2hnogX/6CsuU/5Hc6TnVuh6
         pLcLW3HbDu6l/S/E4FDciGAvkAGP8ewzNIX0BO+gslhFWnhZtbYH1cemnFiB4yX/iAGF
         3FGw==
X-Gm-Message-State: ANoB5pnNz7DrmF5xwNoIInE3KhKBIuQBOdIHrmxi1tfTIM/X4Xy5jt5w
        PVln4EU5apkg0YUJRG7jbGS8VsIHYgmh0kxJhnjaHnD8HcVzBRDYlg5kow7wF0PGqpV6/rJb46t
        mcuDVr/uO+PETnrL3+w02loDJo6P2u1He8EYC9fPUO5V9w4IXmg==
X-Google-Smtp-Source: AA0mqf4u0jnBkNNxotR3tKpzg2dGXIoZzslFhUp1GEdXqwEMDbO7AjkbxpbYcglpySoD4gFFeZqqmhI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:8d90:b0:188:537d:78d9 with SMTP id
 v16-20020a1709028d9000b00188537d78d9mr2070479plo.48.1668481333923; Mon, 14
 Nov 2022 19:02:13 -0800 (PST)
Date:   Mon, 14 Nov 2022 19:02:00 -0800
In-Reply-To: <20221115030210.3159213-1-sdf@google.com>
Mime-Version: 1.0
References: <20221115030210.3159213-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221115030210.3159213-2-sdf@google.com>
Subject: [PATCH bpf-next 01/11] bpf: Document XDP RX metadata
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Document all current use-cases and assumptions.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/bpf/xdp-rx-metadata.rst | 109 ++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/bpf/xdp-rx-metadata.rst

diff --git a/Documentation/bpf/xdp-rx-metadata.rst b/Documentation/bpf/xdp-rx-metadata.rst
new file mode 100644
index 000000000000..5ddaaab8de31
--- /dev/null
+++ b/Documentation/bpf/xdp-rx-metadata.rst
@@ -0,0 +1,109 @@
+===============
+XDP RX Metadata
+===============
+
+XDP programs support creating and passing custom metadata via
+``bpf_xdp_adjust_meta``. This metadata can be consumed by the following
+entities:
+
+1. ``AF_XDP`` consumer.
+2. Kernel core stack via ``XDP_PASS``.
+3. Another device via ``bpf_redirect_map``.
+
+General Design
+==============
+
+XDP has access to a set of kfuncs to manipulate the metadata. Every
+device driver implements these kfuncs by generating BPF bytecode
+to parse it out from the hardware descriptors. The set of kfuncs is
+declared in ``include/net/xdp.h`` via ``XDP_METADATA_KFUNC_xxx``.
+
+Currently, the following kfuncs are supported. In the future, as more
+metadata is supported, this set will grow:
+
+- ``bpf_xdp_metadata_rx_timestamp_supported`` returns true/false to
+  indicate whether the device supports RX timestamps in general
+- ``bpf_xdp_metadata_rx_timestamp`` returns packet RX timestamp or 0
+- ``bpf_xdp_metadata_export_to_skb`` prepares metadata layout that
+  the kernel will be able to consume. See ``bpf_redirect_map`` section
+  below for more details.
+
+Within the XDP frame, the metadata layout is as follows::
+
+  +----------+------------------+-----------------+------+
+  | headroom | xdp_skb_metadata | custom metadata | data |
+  +----------+------------------+-----------------+------+
+                                ^                 ^
+                                |                 |
+                      xdp_buff->data_meta   xdp_buff->data
+
+Where ``xdp_skb_metadata`` is the metadata prepared by
+``bpf_xdp_metadata_export_to_skb``. And ``custom metadata``
+is prepared by the BPF program via calls to ``bpf_xdp_adjust_meta``.
+
+Note that ``bpf_xdp_metadata_export_to_skb`` doesn't adjust
+``xdp->data_meta`` pointer. To access the metadata generated
+by ``bpf_xdp_metadata_export_to_skb`` use ``xdp_buf->skb_metadata``.
+
+AF_XDP
+======
+
+``AF_XDP`` use-case implies that there is a contract between the BPF program
+that redirects XDP frames into the ``XSK`` and the final consumer.
+Thus the BPF program manually allocates a fixed number of
+bytes out of metadata via ``bpf_xdp_adjust_meta`` and calls a subset
+of kfuncs to populate it. User-space ``XSK`` consumer, looks
+at ``xsk_umem__get_data() - METADATA_SIZE`` to locate its metadata.
+
+Here is the ``AF_XDP`` consumer layout (note missing ``data_meta`` pointer)::
+
+  +----------+------------------+-----------------+------+
+  | headroom | xdp_skb_metadata | custom metadata | data |
+  +----------+------------------+-----------------+------+
+                                                  ^
+                                                  |
+                                           rx_desc->address
+
+XDP_PASS
+========
+
+This is the path where the packets processed by the XDP program are passed
+into the kernel. The kernel creates ``skb`` out of the ``xdp_buff`` contents.
+Currently, every driver has a custom kernel code to parse the descriptors and
+populate ``skb`` metadata when doing this ``xdp_buff->skb`` conversion.
+In the future, we'd like to support a case where XDP program can override
+some of that metadata.
+
+The plan of record is to make this path similar to ``bpf_redirect_map``
+below where the program would call ``bpf_xdp_metadata_export_to_skb``,
+override the metadata and return ``XDP_PASS``. Additional work in
+the drivers will be required to enable this (for example, to skip
+populating ``skb`` metadata from the descriptors when
+``bpf_xdp_metadata_export_to_skb`` has been called).
+
+bpf_redirect_map
+================
+
+``bpf_redirect_map`` can redirect the frame to a different device.
+In this case we don't know ahead of time whether that final consumer
+will further redirect to an ``XSK`` or pass it to the kernel via ``XDP_PASS``.
+Additionally, the final consumer doesn't have access to the original
+hardware descriptor and can't access any of the original metadata.
+
+To support passing metadata via ``bpf_redirect_map``, there is a
+``bpf_xdp_metadata_export_to_skb`` kfunc that populates a subset
+of metadata into ``xdp_buff``. The layout is defined in
+``struct xdp_skb_metadata``.
+
+Mixing custom metadata and xdp_skb_metadata
+===========================================
+
+For the cases of ``bpf_redirect_map``, where the final consumer isn't
+known ahead of time, the program can store both, custom metadata
+and ``xdp_skb_metadata`` for the kernel consumption.
+
+Current limitation is that the program cannot adjust ``data_meta`` (via
+``bpf_xdp_adjust_meta``) after a call to ``bpf_xdp_metadata_export_to_skb``.
+So it has to, first, prepare its custom metadata layout and only then,
+optionally, store ``xdp_skb_metadata`` via a call to
+``bpf_xdp_metadata_export_to_skb``.
-- 
2.38.1.431.g37b22c650d-goog

