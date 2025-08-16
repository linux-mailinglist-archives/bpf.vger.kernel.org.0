Return-Path: <bpf+bounces-65811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE2B28C34
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 11:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC621CE530A
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C47C23F431;
	Sat, 16 Aug 2025 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RP8kNLR8"
X-Original-To: bpf@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013011.outbound.protection.outlook.com [40.107.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463623C4ED;
	Sat, 16 Aug 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335260; cv=fail; b=Jc/1BzdK7n5Jd0fww2opY3eL/BD/oPdaByDNweTaw8o+umUT73FYMiYbqgwpQyMW0W3ThPz2Ix/Sa2+GSFr9mzde++3t6uhF3EBJrecMtlvXFd8AlIX4nfml0hAMGRV00A/JKpjVS4Cp5HzR8sdjIJix+qAZt9giDqHIGeQf9+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335260; c=relaxed/simple;
	bh=kJPJMkWzZzzZcq3vkCpbMM0iFc4NppCaV5ytkwyLO3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLayICw6Y8LfPieI8HzwJTOqCSGTQSuaCYOikSiArLKZl+1+DDB8/jlvOGbMtRCtha1ABeDw4AKszXy0kikG9dsm1vb/+PGJ1wgjoDGmJXJ7cb9fzHi8CsY2n6hYvUrsTzCKrsg5bHFSNt4Y4PEALAGEhG3t9p59EU0htGjRNnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RP8kNLR8; arc=fail smtp.client-ip=40.107.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkbzlXrikdc50gpOgnv63Uk8d2/QqTlHstlaol4kZGs8Dq785Su4lPOemMt2o4bvmqF3ucr771P/HS833g+zPMouVbgNy0siyXMbgkWmen2EU+Hm31/CQJfXQ/BgLX63HYhM3zpS8byA9ClPu+a+bS+nPp8R8WTrvrJwC87qwJN+rDHtLASXk7YJz9LZugXVApG0SkYME6X2EIBpr8+8q4MA0TmdJOmuHYsTwcZmQiMmPffzrV+5+PypRQZ1ewtTelOEMpmBJeik6d4ATkxwMKvdG33btPgnWH3b08ScLJUjDPzoGGsQm2KusoZ8081IqVpv4b4qv767pujLfjOtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2liQkiX/KIuvsiX7koHtKXkDODVdZEljZLOru9ZkYtQ=;
 b=FPnHi8Axn/d70ZiOcSbjfNSVQsOC8uFipgy2gBgJ2qfkUK+W4rx+7GaPHlqRefr4FH6gbKDYdKC8Fkya7ftNhZc2BSAUF1w/5xs2wOdnYj5Kv+sirCtdnf5PpZfplanW10/kYk6ZjtWAHbxK2tD3vjQQWcbtqpSfcTPpiRWyQcf+dBGinL6NsVbbPj1WAVhBhbDFYDd6yxSPIhUr3cgRjzPpo4eChS/Qb9w5Chh0fsclBV4fXg4h/qj1e598s7eA23vbCwlOHl5dNV7KgG6JWa9X9bFTBRkS55AzAZHFhEjxSh5/ENJRvV4jFfV5FcR4XYATOaEOm6eBRHHUzveHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2liQkiX/KIuvsiX7koHtKXkDODVdZEljZLOru9ZkYtQ=;
 b=RP8kNLR89vGdF7SlRGUXjeaw2dqNdWp8jUx/O9jIZjCPAvyBdQivRWAgySShZl3ljouqNJWEnx170NYcn/kIR/gBa+X6aRbK/kFxSOXNXmY4mz+rAnuVTQbiIRu5DCsOFyrh9OG0xgjBoptuLfh1cne4nBQ54UmdFa1d8R4tqIwkxvd2lREMZFqjmTUMA410wz2CzlOI0Aj3E0EC7DVW7QaEtgeL/1TTo2Gs+x2BENQek0Z6Bi6WDKMxAhO3KrgMGX2lOKXJjzKJBNVWr0hKkLogzcIp3kBJ1Ey1fQaqNYonj9SROWj4mMNZ6HE28GKDEp4jMlqp/g9BH0Zbva4Tdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6305.apcprd06.prod.outlook.com (2603:1096:400:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sat, 16 Aug
 2025 09:07:35 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 09:07:35 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v3 1/3] eth: intel: use vmalloc_array() to simplify code
Date: Sat, 16 Aug 2025 17:06:52 +0800
Message-Id: <20250816090659.117699-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816090659.117699-1-rongqianfeng@vivo.com>
References: <20250816090659.117699-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::22) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 043cd369-46bf-47ad-7e8f-08dddca4574d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eg/mIORl2TTQ1dnBsSLZYDJuzK7hTt5n5fMZ56EbhIfb9Xn2HrQBW9zjL3bn?=
 =?us-ascii?Q?Qm89GLL+K3iHrkVKGCqQmDbOyTXDbtqgeCwGLDBIXjtt2XSqQjQ5cByOUkI5?=
 =?us-ascii?Q?k+2Rwy+u+nWYf/5nwO6WDw9mzjVAIyZEkcOAGSOGlcAWo1lkp0wjKhygEoVS?=
 =?us-ascii?Q?meANn+vscQSIcOlCcFQm24gIFh1MxjAoDM3eiRt3MTbhsEM0JfY5QOi4pGKc?=
 =?us-ascii?Q?fT0befj1Au51R9LpqTn8xrU5v65Y2KlzFRDR7MCHtBN9VimTy3nNmAqsQY9c?=
 =?us-ascii?Q?IyZRWwAiTuqxUIVPGHTELCMK5hhP7DBRd6vbxFT6LgLDLzEPqhhg7Q7XV2SM?=
 =?us-ascii?Q?nVIsJ5nk+x8z8VW0F3XgBMb9rQkI6LuocikJIjxqPDEy0cjptaBP1PImuKJK?=
 =?us-ascii?Q?1P2djx9hnHLx1SGC5NuFjet7o9OogZZPjtdlFkX22l2bw+/xwngkItdVfkQ+?=
 =?us-ascii?Q?7DCUbsnIV002cWzpnUCQKlMfAuoaPgxTTuk8+zrJR4t/jAqO1bSShTgjC0VN?=
 =?us-ascii?Q?5UDev3B9HoTa06d5zf36411A40bNPJRzgztaNj5Fs9ZUKUxzRuwHu8d6anfr?=
 =?us-ascii?Q?AFJDlArD6WE+sh/0ZpQXAJ2pnX9eE9PaiwleeIC6lMFwEHfq2PlA0ZSA9v5G?=
 =?us-ascii?Q?NlH//49RevMMqQkr1oCcU+NkFm8Xg4m39OUifTgRAZA1GSeP9zJZ1bdlr9Vn?=
 =?us-ascii?Q?Gg6/j65Dd0dB/FQgFf496cy6KCNGkhfhyfe7CttobXFrTX+6CewrzsS1ogSt?=
 =?us-ascii?Q?ZJnUBj8WCzW0SiVcTSpohqu4/lFo+AZNXvuaruxZsR/YSs5uT/OEp6K3FtaE?=
 =?us-ascii?Q?KCfP2VeJJfmJtHgpuAP2D8XruBuFLxfzJoA6zUxsAhMSFH0YJQ+5reks46WL?=
 =?us-ascii?Q?cyLsqN0RT0v8wL3riaCfSg59+6ld1HSNRgMdNvS7rq10c2IuSqZ2fVmJ8pWz?=
 =?us-ascii?Q?NhS2rtRcSEThUt+A9XP7Omg85eslpJGZqPJObzFEAiOZekUBnxjekPd2SEjb?=
 =?us-ascii?Q?ca/f0dgJ4+LMOVlf0WVHxHUd0pgOIaX600KiQBYU9h1ljby0M6Uv0pg7oBuQ?=
 =?us-ascii?Q?iwpzl7ugjkxzHDgDJGEBNOBVzwfEumiIIZ9Pb1MoD0iF51Q/wIadCrc0zL3G?=
 =?us-ascii?Q?jsJhGTIIAcP2NfIdKh5BmiM1RF8O9iFUIaUpn0uaZGVcuXQ0MI9hGbsakxxe?=
 =?us-ascii?Q?vV40MvPt7itIcIkeAKxYW/erwsdgGETqxbe8KVlGihCp3sYuTj/xscm2b33K?=
 =?us-ascii?Q?RwRzG09XJBEZvY+oxCavVBEIZqwQ0IcApfKnwPK4faI0nedrZToRcKcmTTEl?=
 =?us-ascii?Q?nJaBjlWQBWwlxpWdOuVCX27V8pJx9FaAroEvjB0EVBbFaTfapX4vNsi6HXzw?=
 =?us-ascii?Q?VkWdCO67egZFec2snzhfIzX2cf8b+kYhgAeGr05Cxh91fg2JNnmYsX15UWLk?=
 =?us-ascii?Q?0JwU1sgcVpEkMzpNt/RjafKPWiyszT6I58wRKuKo5aXug6a2ywDAxH6v75PF?=
 =?us-ascii?Q?13OdsCXtGayZMmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5xcAOxVDwjwoRmBQmmdl88VmMsfjQBROAV7XUHd7NOKT6wBFfLI6jM577cB?=
 =?us-ascii?Q?e+tPCGOYNXN+orLW9sL3C2JbHcc1TQhYVLkO/fTiF9gxUC0ONiLitWI4yFO+?=
 =?us-ascii?Q?xQlEiPWTS5HOHnqSf4tEp7sVvyPJhWykLTDtjD+8ZASzQ2xMimF0odP8n3CM?=
 =?us-ascii?Q?6diG7gX8xDj3HJ6vtirL6/UzaPIv2UAcWU9bAmyXFxGZxkB4qJcmBP5u2hdr?=
 =?us-ascii?Q?XEYc9+O/6UwSUEFH6pqcaY96PDZJEr0TuhHzbdnVrqkapzAU2hBa99+c215D?=
 =?us-ascii?Q?jXRIC0bJOikbnd32c810Y54H+n6xp1vcYdqTTowsAD4R3ntK/7u0pjzlqMdM?=
 =?us-ascii?Q?o2pYgBcuwoDDhzZO2Lqnu/FAS1+MZZ/7bmN18CqfJZhNCIOZq570g2rcGAfY?=
 =?us-ascii?Q?TLg+QyAOGNLgCT09NLU8cYjyi+akHfXyhU2XLuiwEuVh+GggSSc+X9hSW90L?=
 =?us-ascii?Q?Zm61MjJ3WN0LI/O2XZBaoG4z+PTwGlYvgJjnR0fablRWRvW1/uPIBOwZ5bCz?=
 =?us-ascii?Q?TeNCBpzF0uWwWOQtfP4k+/o72ZiMv6mEwU+snm9Vn/0+SAfpIKBsckryo7Q1?=
 =?us-ascii?Q?h5HPwsobB3MIlxYxyiXc1Z4Ot3Lf1ESZ0b38ql81rXgYtxFCNFU2T2Zqdshh?=
 =?us-ascii?Q?2iehk6/mRE4oF0Xuhj8gH7mYBoQgfqGVVm2hp2CgVHIeQr27tDTkS7iyQ51L?=
 =?us-ascii?Q?MZ1kYYltbQxqt1pGOEHcbiaP65KmS0go0bDLrSEReCIRGm/9m92Q/YTAMPIX?=
 =?us-ascii?Q?nAeVQAJeFECIxs4Gfb8S41S/MBfFmSIRcCMbvgE5yIgIlwr4F2Ty9vWpDGUt?=
 =?us-ascii?Q?qc3n8SWqbadpefuUCso4RRO/fwWGs7ZvIYd3tziO0q7qFd7taZ0pvKk50Gyv?=
 =?us-ascii?Q?2ZDFoO2PeDbeIuZcJun3QzMSQFYID4RnyhgquHm1CqEiaP1kNVvoebzvjteD?=
 =?us-ascii?Q?fJvW4LYhZgF88YAwE6Sj4LNHv90q1/VNnvekVjyju7391o1KdUfipd3S6IeI?=
 =?us-ascii?Q?2GlBS5ogByvPVPP/NmMleeJK3FA3eErenCCycafSZ0+8DvtAR9INY17bx+xP?=
 =?us-ascii?Q?5up51q8/AQybQpUIHXRdssRjRuEadO/Y5LfB0C8QyTYYuCYu0AbQfJNgPS5E?=
 =?us-ascii?Q?KkeC0LWI+S1uc7UBcYR/+wS559aCVi910yEseVnBnbO/flzlajxBMboNLzZm?=
 =?us-ascii?Q?2MknzPaT3y5izKIrkkT3DFv9iWsbewBDNh+HaudzVK7dw2rm5nCuN1AKkbw6?=
 =?us-ascii?Q?9KsWgoSiePBjHWPtomt8pfZMFgOrW5kLVMWoPwj1bkhx4H/yMxyb86lyxCX4?=
 =?us-ascii?Q?33Pn+7fDV82rl7nEVc0ikafLJazsryrd2Jmb9yV0nyES2esadpL4dc2MLAAK?=
 =?us-ascii?Q?qIaT+qAKitkDo6ZWK4n0iWhMk+OUFW42uHxdzcIXd1DB3xxm0hiA61OEhp6N?=
 =?us-ascii?Q?z56sCpVDEgZk2OTSACWcVb194NGJu13tuA9mis8htnEVw/W7yLOeY5PAs1oq?=
 =?us-ascii?Q?pfiJYdaqYJNcdMb8RCTwP97DXU4SVivuDm8chhINA4ECTMrhHb2nwsUcFXSk?=
 =?us-ascii?Q?b+SYBS/9HfsgDl25IQ4jk/FVGj/U8wTk7xbXOIAR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043cd369-46bf-47ad-7e8f-08dddca4574d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 09:07:35.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTO/41//RzN/457HQK0uG5hP807stxs5FLegoIv+q6BWhkqAcX8A7mT/HTpl+t1I+lcVja6nLiCJp11CmcUPcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6305

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code and maintain consistency with existing kmalloc_array()
usage.

vmalloc_array() is also optimized better, resulting in less instructions
being used.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c     | 8 ++++----
 drivers/net/ethernet/intel/igc/igc_ethtool.c     | 8 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c     | 6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 1954a04460d1..bf2029144c1d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -560,7 +560,7 @@ static int fm10k_set_ringparam(struct net_device *netdev,
 
 	/* allocate temporary buffer to store rings in */
 	i = max_t(int, interface->num_tx_queues, interface->num_rx_queues);
-	temp_ring = vmalloc(array_size(i, sizeof(struct fm10k_ring)));
+	temp_ring = vmalloc_array(i, sizeof(struct fm10k_ring));
 
 	if (!temp_ring) {
 		err = -ENOMEM;
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 92ef33459aec..51d5cb6599ed 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -920,11 +920,11 @@ static int igb_set_ringparam(struct net_device *netdev,
 	}
 
 	if (adapter->num_tx_queues > adapter->num_rx_queues)
-		temp_ring = vmalloc(array_size(sizeof(struct igb_ring),
-					       adapter->num_tx_queues));
+		temp_ring = vmalloc_array(adapter->num_tx_queues,
+					  sizeof(struct igb_ring));
 	else
-		temp_ring = vmalloc(array_size(sizeof(struct igb_ring),
-					       adapter->num_rx_queues));
+		temp_ring = vmalloc_array(adapter->num_rx_queues,
+					  sizeof(struct igb_ring));
 
 	if (!temp_ring) {
 		err = -ENOMEM;
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index ecb35b693ce5..f3e7218ba6f3 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -627,11 +627,11 @@ igc_ethtool_set_ringparam(struct net_device *netdev,
 	}
 
 	if (adapter->num_tx_queues > adapter->num_rx_queues)
-		temp_ring = vmalloc(array_size(sizeof(struct igc_ring),
-					       adapter->num_tx_queues));
+		temp_ring = vmalloc_array(adapter->num_tx_queues,
+					  sizeof(struct igc_ring));
 	else
-		temp_ring = vmalloc(array_size(sizeof(struct igc_ring),
-					       adapter->num_rx_queues));
+		temp_ring = vmalloc_array(adapter->num_rx_queues,
+					  sizeof(struct igc_ring));
 
 	if (!temp_ring) {
 		err = -ENOMEM;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 25c3a09ad7f1..2c5d774f1ec1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1278,7 +1278,7 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
 	/* allocate temporary buffer to store rings in */
 	i = max_t(int, adapter->num_tx_queues + adapter->num_xdp_queues,
 		  adapter->num_rx_queues);
-	temp_ring = vmalloc(array_size(i, sizeof(struct ixgbe_ring)));
+	temp_ring = vmalloc_array(i, sizeof(struct ixgbe_ring));
 
 	if (!temp_ring) {
 		err = -ENOMEM;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 7ac53171b041..bebad564188e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -276,9 +276,9 @@ static int ixgbevf_set_ringparam(struct net_device *netdev,
 	}
 
 	if (new_tx_count != adapter->tx_ring_count) {
-		tx_ring = vmalloc(array_size(sizeof(*tx_ring),
-					     adapter->num_tx_queues +
-						adapter->num_xdp_queues));
+		tx_ring = vmalloc_array(adapter->num_tx_queues +
+					adapter->num_xdp_queues,
+					sizeof(*tx_ring));
 		if (!tx_ring) {
 			err = -ENOMEM;
 			goto clear_reset;
-- 
2.34.1


