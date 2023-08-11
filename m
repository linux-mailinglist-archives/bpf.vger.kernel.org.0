Return-Path: <bpf+bounces-7583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D177948B
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D282824A6
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A29219CD;
	Fri, 11 Aug 2023 16:20:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0D219C3;
	Fri, 11 Aug 2023 16:20:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D192;
	Fri, 11 Aug 2023 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691770851; x=1723306851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/l4ImFgQY9C8qg58vokr2tT+bEZqAhep1YO4JisYsQ=;
  b=f2rqMPS9G2WaDSLaE/RAO6rdpFzuOTbIi4xqqA6SSzmmniuADc0xcEuC
   5CZD8heNiQ9Vs2p/mkTDprCRiUTmJvMKglp8QMK56Fg1o596MWX87DGCC
   10giN0L0cQ3MoPTSNiHpMFX0Bo8nAJAWbo8NJulOgxDWXWlc53MZJLJL2
   8RBInbOBLk5KIDHCUsehf8URSobLFke0SMXhUTl/OnRnlZ/xipCo5XqI2
   2v1b2Fqz+YvYfAh2NwYJsADYAXu7oTDv/9spm71ThwMmudVPcQoTaAyYZ
   Zfzyk0WX+VQHzJZ7IV0Q3LpRkD4mb45ajd5YtbDd7HXe+at1SZkyzqzG0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351314814"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="351314814"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 09:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="906501059"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="906501059"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2023 09:20:45 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A9ACE33BC6;
	Fri, 11 Aug 2023 17:20:43 +0100 (IST)
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
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Jesper Dangaard Brouer <jbrouer@redhat.com>
Subject: [PATCH bpf-next v5 18/21] net: make vlan_get_tag() return -ENODATA instead of -EINVAL
Date: Fri, 11 Aug 2023 18:15:06 +0200
Message-ID: <20230811161509.19722-19-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811161509.19722-1-larysa.zaremba@intel.com>
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


