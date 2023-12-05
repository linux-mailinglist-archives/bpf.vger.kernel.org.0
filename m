Return-Path: <bpf+bounces-16803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B8806060
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D89A28205D
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4AB6F624;
	Tue,  5 Dec 2023 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="detlpUDz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9518B;
	Tue,  5 Dec 2023 13:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810688; x=1733346688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQldnflb2ClDEwJnCZgJdBGgWR7nOfuEySyZVxba8o0=;
  b=detlpUDz3hz7iUaiA4wS9428hqS1g2RrNmhHKx3WcEqL/OhH8/UFtcy3
   Tu2nO6qj/kd7oMSGOw9C8+7zFEVKL2M49sNJRZzo94rgxFMdqJVNq+cQ9
   eMKlHvHrGzEzWq7P1ix6iiw/p1oF00OzOQjxBI8XNASkVXk2H781IbWYk
   CtQc0AMAe7SkcSy1DFpQkKLAA5dNgHqLYuZLcMdSUBcsU9ZVOkbCkwvxk
   kliMB6vLBAnNlnVzSHBdDXFzZ+GxBpMZBjx5CvGDvN06idAYkPYPwckxC
   JdiMjbgKqYwxy7DzRycCrXCbat5NQA+lCodJAoKOytYpnXuMmzBI/LqIz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373421984"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="373421984"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:11:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774757880"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="774757880"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2023 13:11:21 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 15F253433E;
	Tue,  5 Dec 2023 21:11:19 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesper Dangaard Brouer <jbrouer@redhat.com>
Subject: [PATCH bpf-next v8 13/18] net: make vlan_get_tag() return -ENODATA instead of -EINVAL
Date: Tue,  5 Dec 2023 22:08:42 +0100
Message-ID: <20231205210847.28460-14-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205210847.28460-1-larysa.zaremba@intel.com>
References: <20231205210847.28460-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vlan_hwaccel_get_tag() is used in veth XDP hints implementation,
its return value (-EINVAL if skb is not VLAN tagged) is passed to bpf code,
but XDP hints specification requires drivers to return -ENODATA, if a hint
cannot be provided for a particular packet.

Solve this inconsistency by changing error return value of
__vlan_hwaccel_get_tag() from -EINVAL to -ENODATA, do the same thing to
__vlan_get_tag(), because this function is supposed to follow the same
convention. This, in turn, makes -ENODATA the only non-zero value
vlan_get_tag() can return. We can do this with no side effects, because
none of the users of the 3 above-mentioned functions rely on the exact
value.

Suggested-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 include/linux/if_vlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 3028af87716e..c1645c86eed9 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -540,7 +540,7 @@ static inline int __vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
 	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
 
 	if (!eth_type_vlan(veth->h_vlan_proto))
-		return -EINVAL;
+		return -ENODATA;
 
 	*vlan_tci = ntohs(veth->h_vlan_TCI);
 	return 0;
@@ -561,7 +561,7 @@ static inline int __vlan_hwaccel_get_tag(const struct sk_buff *skb,
 		return 0;
 	} else {
 		*vlan_tci = 0;
-		return -EINVAL;
+		return -ENODATA;
 	}
 }
 
-- 
2.41.0


