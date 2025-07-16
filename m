Return-Path: <bpf+bounces-63447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51387B07A5D
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9380D7BC164
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121A42F5335;
	Wed, 16 Jul 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8wMdVTq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66E2F5312;
	Wed, 16 Jul 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680966; cv=none; b=NuGUOz8Hje6Z0WhD+ImsTtGIyAAP7wa0unT6v+eG/NWVcRLSUAgJy2i68CY03ShbYOSXnRfiH42sGgb89h6O/2f4aykp5NAlXHsJ6VxUOJY+Avqk1driY1f02R3zPjt6Zxe+TOuRqWCYFMpF3XRgAmgVNUsA7eAyvgrBPbv3CaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680966; c=relaxed/simple;
	bh=RmjJ8ux4f5kXwmsl4LK45y8R8eheEBrE47ECmLkQPCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEZ2GW+1qey0nqOe+TL0fXzu+ZEhlWtrhSoHPs3N8BRU5dMuTCCokpsh/O8vCiGKX49B6ue9iLNRCssGyL7v1BQreJvO/5vht3V2HEluNCsHC74uvR+vm2yCUdW4W3Qq5+Lsz0D9MWrHAhBHjReu6yF5QGWFtDas9n/ishpZJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8wMdVTq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752680964; x=1784216964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RmjJ8ux4f5kXwmsl4LK45y8R8eheEBrE47ECmLkQPCU=;
  b=f8wMdVTqcmYTWs2bY8NaUjF//oM9BRgDsjy2QTbneJkuC7BRDugIfksx
   k9cTTKmByy8KIdNTrSIzARCa79ILlU0TT0mIje/en4BUOQ1kOgTTv8yBo
   iDnZRdamskClPgzWjPdZguPhH3tZGiU2EFuO5niZLAHnmqAq3Cn5nO3yh
   Tx4DugGqPDqoBqTGHpXD3KWpNHekV9c1k94IWurgzVZRbMb0AKx7DwF+0
   a5z+r1/mH5Q8UUxuKR8cyRa6XXvX/73xiz2QHxAvqdnRAPMQq4u5xX0LE
   gro6FfDKSZ1NqY8hugcnZn30D3fb6A+yMlqRU8oTOqyrjznpgII+/Vw4Z
   A==;
X-CSE-ConnectionGUID: 4owGjBf2TYmurCgjL62FGA==
X-CSE-MsgGUID: BTXI4P2BQsWUq27sbr5QIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54872787"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54872787"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 08:49:19 -0700
X-CSE-ConnectionGUID: oXzX1PNYQOy5qHA8vJ4qjA==
X-CSE-MsgGUID: 2V1YzkHhQaWS3uS0xiZGEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="162089063"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by orviesa004.jf.intel.com with ESMTP; 16 Jul 2025 08:49:15 -0700
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
Subject: [PATCH bpf-next,v5 1/1] doc: xdp: clarify driver implementation for XDP Rx metadata
Date: Wed, 16 Jul 2025 23:48:46 +0800
Message-Id: <20250716154846.3513575-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify that drivers must remove device-reserved metadata from the
data_meta area before passing frames to XDP programs.

Additionally, expand the explanation of how userspace and BPF programs
should coordinate the use of METADATA_SIZE, and add a detailed diagram
to illustrate pointer adjustments and metadata layout.

Also describe the requirements and constraints enforced by
bpf_xdp_adjust_meta().

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
V5:
  - create a new section called 'Driver implementation' (Stanislav)
  - reword 'utilize the data_meta area' to 'prepend metadata to received packets' (Jakub)

V4: https://lore.kernel.org/netdev/20250715071502.3503440-1-yoong.siang.song@intel.com/
  - update the documentation to indicate that drivers are expected to copy
    any device-reserved metadata from the metadata area (Jakub)
  - remove selftest tool changes.

V3: https://lore.kernel.org/netdev/20250702165757.3278625-1-yoong.siang.song@intel.com/
  - update doc and commit msg accordingly.

V2: https://lore.kernel.org/netdev/20250702030349.3275368-1-yoong.siang.song@intel.com/
  - unconditionally do bpf_xdp_adjust_meta with -XDP_METADATA_SIZE (Stanislav)

V1: https://lore.kernel.org/netdev/20250701042940.3272325-1-yoong.siang.song@intel.com/
---
 Documentation/networking/xdp-rx-metadata.rst | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index a6e0ece18be5..ce96f4c99505 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -120,6 +120,39 @@ It is possible to query which kfunc the particular netdev implements via
 netlink. See ``xdp-rx-metadata-features`` attribute set in
 ``Documentation/netlink/specs/netdev.yaml``.
 
+Driver Implementation
+=====================
+
+Certain devices may prepend metadata to received packets. However, as of now,
+``AF_XDP`` lacks the ability to communicate the size of the ``data_meta`` area
+to the consumer. Therefore, it is the responsibility of the driver to copy any
+device-reserved metadata out from the metadata area and ensure that
+``xdp_buff->data_meta`` is pointing to ``xdp_buff->data`` before presenting the
+frame to the XDP program. This is necessary so that, after the XDP program
+adjusts the metadata area, the consumer can reliably retrieve the metadata
+address using ``METADATA_SIZE`` offset.
+
+The following diagram shows how custom metadata is positioned relative to the
+packet data and how pointers are adjusted for metadata access::
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
+
 Example
 =======
 
-- 
2.34.1


