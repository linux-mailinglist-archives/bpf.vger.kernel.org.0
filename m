Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653AA58B057
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 21:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbiHETYG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 15:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbiHETYD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 15:24:03 -0400
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332046717E;
        Fri,  5 Aug 2022 12:24:00 -0700 (PDT)
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
        by mx07-0057a101.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275JBPjX015217;
        Fri, 5 Aug 2022 21:20:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=12052020;
 bh=qUVyOM8ZbJXuR7I4XxQ00/jzZhstTj0MGA/CSTUhe14=;
 b=upI0D1oMNdFTOjDaOZ1WQunJvSdcne9R+uvN3JW48aTCIJsSRTW4Juga2Iu8DB1+NCbX
 RrJ5ugp4ENG/6kbSa9mrbtrf3cD9O+1168//t12IJNlztERmjgzgSxAglsgpz+d73+Za
 Iyn62Tjqc7WyyLs8mC5uXkGedvGgAQExvnH6mXVAopSJsFSkVg8d7O3Gm3fXQKZi0RyC
 oeROANXeRQDH1lyf4FlA+SDayZyGkLJtomDyufrkpWbqIjo/gNxBKytlURixN+MIwVuK
 g+1KORFaOkO2tx8xvoFUXMJAJQDNlSDBbnR45QlS7i+YrWd7GVs1Nn6kfCNlswEosiXo 3w== 
Received: from mail.beijerelectronics.com ([195.67.87.131])
        by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 3hr3tdsntp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Aug 2022 21:20:18 +0200
Received: from Orpheus.nch.westermo.com (172.29.100.2) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17; Fri, 5 Aug 2022 21:20:15 +0200
From:   Matthias May <matthias.may@westermo.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <roopa@nvidia.com>,
        <eng.alaamohamedsoliman.am@gmail.com>, <bigeasy@linutronix.de>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <roid@nvidia.com>,
        <maord@nvidia.com>, <lariel@nvidia.com>, <vladbu@nvidia.com>,
        <cmi@nvidia.com>, <gnault@redhat.com>, <yoshfuji@linux-ipv6.org>,
        <dsahern@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <nicolas.dichtel@6wind.com>, <eyal.birger@gmail.com>,
        <jesse@nicira.com>, <linville@tuxdriver.com>,
        <daniel@iogearbox.net>, <hadarh@mellanox.com>,
        <ogerlitz@mellanox.com>, <willemb@google.com>,
        <martin.varghese@nokia.com>,
        Matthias May <matthias.may@westermo.com>
Subject: [PATCH v3 net 3/4] mlx5: do not use RT_TOS for IPv6 flowlabel
Date:   Fri, 5 Aug 2022 21:19:05 +0200
Message-ID: <20220805191906.9323-4-matthias.may@westermo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805191906.9323-1-matthias.may@westermo.com>
References: <20220805191906.9323-1-matthias.may@westermo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.29.100.2]
X-ClientProxiedBy: wsevst-s0023.westermo.com (192.168.130.120) To
 EX01GLOBAL.beijerelectronics.com (10.101.10.25)
X-Proofpoint-GUID: C9xbPar2GVj89GpUD_VoSA0oODIXM_hl
X-Proofpoint-ORIG-GUID: C9xbPar2GVj89GpUD_VoSA0oODIXM_hl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

According to Guillaume Nault RT_TOS should never be used for IPv6.

Quote:
RT_TOS() is an old macro used to interprete IPv4 TOS as described in
the obsolete RFC 1349. It's conceptually wrong to use it even in IPv4
code, although, given the current state of the code, most of the
existing calls have no consequence.

But using RT_TOS() in IPv6 code is always a bug: IPv6 never had a "TOS"
field to be interpreted the RFC 1349 way. There's no historical
compatibility to worry about.

Fixes: ce99f6b97fcd ("net/mlx5e: Support SRIOV TC encapsulation offloads for IPv6 tunnels")
Acked-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Matthias May <matthias.may@westermo.com>
---
v1 -> v2:
 - Fix spacing of "Fixes" tag.
 - Add missing CCs
v2 -> v3:
 - Add the info from the cover to the actual patch message (Guillaume Nault)
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index d87bbb0be7c8..e6f64d890fb3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -506,7 +506,7 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 	int err;
 
 	attr.ttl = tun_key->ttl;
-	attr.fl.fl6.flowlabel = ip6_make_flowinfo(RT_TOS(tun_key->tos), tun_key->label);
+	attr.fl.fl6.flowlabel = ip6_make_flowinfo(tun_key->tos, tun_key->label);
 	attr.fl.fl6.daddr = tun_key->u.ipv6.dst;
 	attr.fl.fl6.saddr = tun_key->u.ipv6.src;
 
@@ -620,7 +620,7 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 
 	attr.ttl = tun_key->ttl;
 
-	attr.fl.fl6.flowlabel = ip6_make_flowinfo(RT_TOS(tun_key->tos), tun_key->label);
+	attr.fl.fl6.flowlabel = ip6_make_flowinfo(tun_key->tos, tun_key->label);
 	attr.fl.fl6.daddr = tun_key->u.ipv6.dst;
 	attr.fl.fl6.saddr = tun_key->u.ipv6.src;
 
-- 
2.35.1

