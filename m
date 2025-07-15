Return-Path: <bpf+bounces-63301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D87CB05285
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 09:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB3A4A724A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E82727F7;
	Tue, 15 Jul 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5bWZrNa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76626F478;
	Tue, 15 Jul 2025 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563741; cv=none; b=kpXW3UxySfinsoUGjR78q7bulE1f1DZH+t0qB1LeRU8b+uhdf+YrcK32IXhlVCrl9oeCHOd36zWC4iR8py0/1O430oanVknIcsQ0DOqAllKu8j9RLW0andlhy2f7aV6rPXpMNlJwQzAsEzoNCZLZQLS5XjFbOu3K8EhP9W/1T/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563741; c=relaxed/simple;
	bh=66XFHTlp/vLtCpVft2/nBl04cFbKoI8kcWKDesGdOEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lTy/ggFCXmbCGXKOZXW3xJeqsOH/RtjEKAhkUxIbtm+PXMYW5/EuLxshyLtsIgli+DiarqMGB0jI8HooRUFtegpAOCtP1k7v76yn2MJlGEcD2+CblgptLdGU8gVGvNwofiIxJ6gqFWhB9+vyV4442vH9vCD1FekNOfvD1MBWwBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5bWZrNa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752563740; x=1784099740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=66XFHTlp/vLtCpVft2/nBl04cFbKoI8kcWKDesGdOEQ=;
  b=l5bWZrNa0njdriL2m/+9rSIR/4fq6BVyvF293cGYIRATyuj6cypdDcUn
   Tl2tqV0/hnk7Wyj0oK4J1bWbrrAs+ZY4D/WZ4yQqiCr7aKgnJNqJ8N2qV
   TQY/bp2dnrkUmfxmWW+mqwuiSHkFdGc0LIGF0laBQ/T0S9WQyyQiev2eG
   RSA0Y0MpXWq/YEzEGOpjONx+COp6VPiAcj37rBX89uqe7gAK1YvOeuVsJ
   S4VWpaG5BbcVnN3DERjwLiiXtX8/I/dRmkM/Zdcs8azK8x9rkXMHH4SyN
   tTUx0vUxzqyovWrN2MbHd71H5N7b4g2w7jV/mf5wdAw7UZnm8q/LEMel7
   g==;
X-CSE-ConnectionGUID: dgq2UFbaTx2XxRaw9v5qyg==
X-CSE-MsgGUID: vrWH766zSq2CD5X/dZz7bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58427976"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58427976"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:15:36 -0700
X-CSE-ConnectionGUID: Pv1ZxgCOTJONF08bK+CveQ==
X-CSE-MsgGUID: j90nGgMtTZuXn4FtKbEdaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="188155495"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jul 2025 00:15:32 -0700
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next,v4 1/1] doc: clarify XDP Rx metadata handling and driver requirements
Date: Tue, 15 Jul 2025 15:15:02 +0800
Message-Id: <20250715071502.3503440-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improves the documentation for XDP Rx metadata handling, especially for
AF_XDP use cases. It clarifies that drivers must remove any device-reserved
metadata from the data_meta area before passing the frame to the XDP
program.

Besides, expand the explanation of how userspace and BPF programs should
coordinate the use of METADATA_SIZE, and adds a detailed diagram to
illustrate pointer adjustments and metadata layout.

Additional, describe the requirements and constraints enforced by
bpf_xdp_adjust_meta().

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---

V4:
  - update the documentation to indicate that drivers are expected to copy
    any device-reserved metadata from the metadata area (Jakub)
  - remove selftest tool changes.

V3: https://lore.kernel.org/netdev/20250702165757.3278625-1-yoong.siang.song@intel.com/
  - update doc and commit msg accordingly.

V2: https://lore.kernel.org/netdev/20250702030349.3275368-1-yoong.siang.song@intel.com/
  - unconditionally do bpf_xdp_adjust_meta with -XDP_METADATA_SIZE (Stanislav)

V1: https://lore.kernel.org/netdev/20250701042940.3272325-1-yoong.siang.song@intel.com/
---
 Documentation/networking/xdp-rx-metadata.rst | 47 ++++++++++++++------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index a6e0ece18be5..2e067eb6c5d6 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -49,7 +49,10 @@ as follows::
              |                 |
    xdp_buff->data_meta   xdp_buff->data
 
-An XDP program can store individual metadata items into this ``data_meta``
+Certain devices may utilize the ``data_meta`` area for specific purposes.
+Drivers for these devices must move any hardware-related metadata out from the
+``data_meta`` area before presenting the frame to the XDP program. This ensures
+that the XDP program can store individual metadata items into this ``data_meta``
 area in whichever format it chooses. Later consumers of the metadata
 will have to agree on the format by some out of band contract (like for
 the AF_XDP use case, see below).
@@ -63,18 +66,36 @@ the final consumer. Thus the BPF program manually allocates a fixed number of
 bytes out of metadata via ``bpf_xdp_adjust_meta`` and calls a subset
 of kfuncs to populate it. The userspace ``XSK`` consumer computes
 ``xsk_umem__get_data() - METADATA_SIZE`` to locate that metadata.
-Note, ``xsk_umem__get_data`` is defined in ``libxdp`` and
-``METADATA_SIZE`` is an application-specific constant (``AF_XDP`` receive
-descriptor does _not_ explicitly carry the size of the metadata).
-
-Here is the ``AF_XDP`` consumer layout (note missing ``data_meta`` pointer)::
-
-  +----------+-----------------+------+
-  | headroom | custom metadata | data |
-  +----------+-----------------+------+
-                               ^
-                               |
-                        rx_desc->address
+Note, ``xsk_umem__get_data`` is defined in ``libxdp`` and ``METADATA_SIZE`` is
+an application-specific constant. Since the ``AF_XDP`` receive descriptor does
+_not_ explicitly carry the size of the metadata, it is the responsibility of the
+driver to copy any device-reserved metadata out from the metadata area and
+ensure that ``xdp_buff->data_meta`` is set equal to ``xdp_buff->data`` before a
+BPF program is executed. This is necessary so that, after the BPF program
+adjusts the metadata area, the consumer can reliably retrieve the metadata
+address using ``METADATA_SIZE`` offset.
+
+The following diagram shows how custom metadata is positioned relative to the
+packet data and how pointers are adjusted for metadata access (note the absence
+of the ``data_meta`` pointer in ``xdp_desc``)::
+
+              |<-- bpf_xdp_adjust_meta(xdp_buff, -METADATA_SIZE) --|
+  new xdp_buff->data_meta                              old xdp_buff->data_meta
+              |                                                    |
+              |                                            xdp_buff->data
+              |                                                    |
+   +----------+----------------------------------------------------+------+
+   | headroom |                  custom metadata                   | data |
+   +----------+----------------------------------------------------+------+
+              |                                                    |
+              |                                            xdp_desc->addr
+              |<------ xsk_umem__get_data() - METADATA_SIZE -------|
+
+``bpf_xdp_adjust_meta`` ensures that ``METADATA_SIZE`` is aligned to 4 bytes,
+does not exceed 252 bytes, and leaves sufficient space for building the
+xdp_frame. If these conditions are not met, it returns a negative error. In this
+case, the BPF program should not proceed to populate data into the ``data_meta``
+area.
 
 XDP_PASS
 ========
-- 
2.34.1


