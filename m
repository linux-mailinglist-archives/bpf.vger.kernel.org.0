Return-Path: <bpf+bounces-10940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4D47AFD5C
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D59D82843A5
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135FB1CFB7;
	Wed, 27 Sep 2023 07:58:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB91D683;
	Wed, 27 Sep 2023 07:58:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5080126;
	Wed, 27 Sep 2023 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801511; x=1727337511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQldnflb2ClDEwJnCZgJdBGgWR7nOfuEySyZVxba8o0=;
  b=BEtf8Q7zrTFzKf2wiPbxM6JT3wZnKGB2Rb1e6FTyER1vj/o5jfJwelSH
   W6kFgGjvT1CO3IdVgmwDJw91vjPeRFM0vN0fj01TERC95LFNskG85ihxJ
   aHSTdndT25TBJVenqyBEENVXUMdOnTyiHCykJ4M7hJRghBJqEyRpYRQbH
   M6StvnzGjU4DYdyb1/ddXM2GTrY/A6TeBnfrFob9krre3SpjNs7/nW8NI
   b7Y5mqyEl3TXLvE4WM7Wioci4y0xhUltIw4+Y5E1WR0UeNx/j4ZL/CPZv
   2ZTUyv5h749Kd9+coQ833IEk6UQuXrXM/MA3UxtktBCiLgD0B3MpJ4K/J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366818204"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366818204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725714079"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725714079"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2023 00:58:25 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4FEF07EAC3;
	Wed, 27 Sep 2023 08:58:23 +0100 (IST)
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
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesper Dangaard Brouer <jbrouer@redhat.com>
Subject: [RFC bpf-next v2 19/24] net: make vlan_get_tag() return -ENODATA instead of -EINVAL
Date: Wed, 27 Sep 2023 09:51:19 +0200
Message-ID: <20230927075124.23941-20-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927075124.23941-1-larysa.zaremba@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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


