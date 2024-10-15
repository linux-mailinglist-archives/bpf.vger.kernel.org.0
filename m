Return-Path: <bpf+bounces-42054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AF699F065
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002BD1C22E83
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB101DD0D2;
	Tue, 15 Oct 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VM2claxF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBC1B394D;
	Tue, 15 Oct 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004109; cv=none; b=oAnyDaTYG6o06CR93e+PCEejlx3ZIhYaJ69tg/g+2QKnYtU+jIPF9cMmes/Vfk/7SJawFeejimmEhmpTCj+syUZkMnKcPrOdQlKcPd4eZBIVsK7UGVoS/4lECVif500371sZrPBCiMkz9T0D60F3dtWN8FWEihsPoM/MxEyNplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004109; c=relaxed/simple;
	bh=XewhxpeVEIQDvvMf3/opnLigLAaIzO66eIal3rIOj0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ablHPR7fpHKznpLWcV8/aYxxtwlssoAEnLxCy9KdHt3a8lrQJZPW6AQTFh28Z/LhmgFk38/gJx34kVOh/Vax2jU5/U1lT1TBnxDKAfslItlnYlxZ9gXcxIweCOqFQ77lYgP35xILGPA/6tWeuAxmtVbzDRKbpyZsQyvt5WTbU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VM2claxF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004109; x=1760540109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XewhxpeVEIQDvvMf3/opnLigLAaIzO66eIal3rIOj0U=;
  b=VM2claxFY2AqL7418g84GE0zB2CfTboaX7cXda6/I8KteKVV5QJHtDDO
   KcKVwAVTeBkazREGPVb0FI0u8VKsqhYfq3CL2cKYHaWmuvjNvYf9l3Tqz
   oNZTdDzLmnZXNCogHqDXHbD7vb442gsO8/ncIbnYM8QJ9i5jOvq6kO4NA
   q4sCxakx0MLZ5w0ix+exLU44JS88ipQVxHVcTmyi2W3rorGNxJ6H6mQes
   xgYBbBs5rOQ8plekNow5i/9qv2LprA/uwr5otVuRe1ka7L4mH3fB7ZXqa
   lzd1kMlO9LBaBMpiZolcsjut5sclDMeqCgo2s61PoAwM+wqHcP2cMDYKx
   w==;
X-CSE-ConnectionGUID: aN0NVO+9S7aJ3D/hoGonFg==
X-CSE-MsgGUID: H6zwoqSqQ8GEv+qxhu7B8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277626"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277626"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:55:07 -0700
X-CSE-ConnectionGUID: +lxCb1HJQMGoqml9dgcAsw==
X-CSE-MsgGUID: L2R/tE0zSoOmrMjI2zr/6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723137"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:55:04 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 13/18] xsk: allow attaching XSk pool via xdp_rxq_info_reg_mem_model()
Date: Tue, 15 Oct 2024 16:53:45 +0200
Message-ID: <20241015145350.4077765-14-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When you register an XSk pool as XDP Rxq info memory model, you then
need to manually attach it after the registration.
Let the user combine both actions into one by just passing a pointer
to the pool directly to xdp_rxq_info_reg_mem_model(), which will take
care of calling xsk_pool_set_rxq_info(). This looks similar to how a
&page_pool gets registered and reduce repeating driver code.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/xdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9dc103a09b5c..371c26c203b2 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -358,6 +358,9 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 	if (IS_ERR(xdp_alloc))
 		return PTR_ERR(xdp_alloc);
 
+	if (type == MEM_TYPE_XSK_BUFF_POOL && allocator)
+		xsk_pool_set_rxq_info(allocator, xdp_rxq);
+
 	if (trace_mem_connect_enabled() && xdp_alloc)
 		trace_mem_connect(xdp_alloc, xdp_rxq);
 	return 0;
-- 
2.46.2


