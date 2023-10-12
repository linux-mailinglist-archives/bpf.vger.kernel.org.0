Return-Path: <bpf+bounces-12047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF97C73C0
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 19:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B661E1C2116D
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FE32C9C;
	Thu, 12 Oct 2023 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7n5Ca/p"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332E2B76E;
	Thu, 12 Oct 2023 17:12:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B3B7;
	Thu, 12 Oct 2023 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697130753; x=1728666753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQldnflb2ClDEwJnCZgJdBGgWR7nOfuEySyZVxba8o0=;
  b=d7n5Ca/pbw6bGXOGKwlM1WwDSWOGLVIp+I0u1hKh7bpMeUNH9f3q7F2Q
   Lkr/z40hwNUKYUiGVIE1IOJPisNu29Tb9bXpp1au0CnezpCcxXWdhcrdd
   BIkiAgHPHyIm0dNXp46+cSwXt4xE0TnCucU5TCQL7OAO/RGAu+BNJAupS
   g6eEwYtpNoPSNAv8zhk5xnIG+05Qhsnx6K5MSCs/Rx0K38Cl26gP1DfFC
   gmeaZHiFVk2bAeazRvl78BmJ0SjWUP8IKyJVLFGQeyGugSzmXnAbtjBdn
   KPHpGeecMWaY/18uhfLJLQHH3gpZenoHHyJS9ntDHz1og6dsXDVGSAb9S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="451471773"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="451471773"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="747960082"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="747960082"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 12 Oct 2023 10:12:25 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2CD4F33E8C;
	Thu, 12 Oct 2023 18:12:23 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesper Dangaard Brouer <jbrouer@redhat.com>
Subject: [PATCH bpf-next v6 13/18] net: make vlan_get_tag() return -ENODATA instead of -EINVAL
Date: Thu, 12 Oct 2023 19:05:19 +0200
Message-ID: <20231012170524.21085-14-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012170524.21085-1-larysa.zaremba@intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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


