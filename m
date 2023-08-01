Return-Path: <bpf+bounces-6574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E29C76B833
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7C31C20EFD
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2A74DC87;
	Tue,  1 Aug 2023 15:03:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF824DC64;
	Tue,  1 Aug 2023 15:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8CAC433C8;
	Tue,  1 Aug 2023 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690902190;
	bh=GiTJrXK18Hf7JC/NN63VbVrZqz6m5Mt87YaCCE2Kras=;
	h=From:To:Cc:Subject:Date:From;
	b=GbnjVZfsyD+ZTwfKhOPI7Eiy+YHOeoIx68o/1/CElqyruzLDcXSZpSbT6qKOChI7f
	 3P6aIc51SqA4j5oceeXwpAvX541FvpbFm6NqVARzDYQLAWbk50hT44l4s789wz2JFI
	 FrfbFrj6mTS3bx4PNO8GHUkVovysLIKl9fVRCO02XzEskDrld0BNi4ZFBoZgonfm9N
	 TFzS8kuReBYN0Dj+FJbIMpHLW2eFRwgKOUDnvVNjExhzX2Rm4s6M7pFFHQlvgqe9uX
	 4YqdgcQ3oTmjpa4A8PNY3UE52yObqfmh/CE4WjIekv69BsvZhQzaR8+wp82Hbsxji/
	 n5ApBF52jzYJw==
From: Arnd Bergmann <arnd@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] netfilter: bpf_link: avoid unused-function warning
Date: Tue,  1 Aug 2023 17:02:41 +0200
Message-Id: <20230801150304.1980987-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added function is unused in some random configurations:

net/netfilter/nf_bpf_link.c:32:1: error: 'get_proto_defrag_hook' defined but not used [-Werror=unused-function]
   32 | get_proto_defrag_hook(struct bpf_nf_link *link,
      | ^~~~~~~~~~~~~~~~~~~~~

Change the preprocessor conditionals to if() checks that the
compiler can understand to avoid the warning.

Fixes: 91721c2d02d3a ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/netfilter/nf_bpf_link.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 8fe594bbc7e24..6028fd4c1ab4c 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -74,24 +74,26 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 	const struct nf_defrag_hook __maybe_unused *hook;
 
 	switch (link->hook_ops.pf) {
-#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
 	case NFPROTO_IPV4:
+		if (!IS_ENABLED(CONFIG_NF_DEFRAG_IPV4))
+			return -EAFNOSUPPORT;
+
 		hook = get_proto_defrag_hook(link, nf_defrag_v4_hook, "nf_defrag_ipv4");
 		if (IS_ERR(hook))
 			return PTR_ERR(hook);
 
 		link->defrag_hook = hook;
 		return 0;
-#endif
-#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
 	case NFPROTO_IPV6:
+		if (!IS_ENABLED(CONFIG_NF_DEFRAG_IPV6))
+			return -EAFNOSUPPORT;
+
 		hook = get_proto_defrag_hook(link, nf_defrag_v6_hook, "nf_defrag_ipv6");
 		if (IS_ERR(hook))
 			return PTR_ERR(hook);
 
 		link->defrag_hook = hook;
 		return 0;
-#endif
 	default:
 		return -EAFNOSUPPORT;
 	}
-- 
2.39.2


