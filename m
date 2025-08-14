Return-Path: <bpf+bounces-65632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A89B262B4
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9955C670E
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A87131814F;
	Thu, 14 Aug 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QjBmnK4Y"
X-Original-To: bpf@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255C31813A;
	Thu, 14 Aug 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166888; cv=fail; b=owMRzpdNxnVBWCJjuHIuS6Gh8KgoQwV38AYSzMybBqVhOecOX+86idhmHyV+D/Pgfbl81kcgwGY2+2QuUAXKXIhyRNo3aYzFGZkl2dqGoxk0kj/grA0EcwRGrJFu4jgxyLxX+rCBUnKVWHkYOGBvM8RzNoozPRSUGpyiMlI/nas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166888; c=relaxed/simple;
	bh=HmhflBAc9uwOh6la+j74bY+lEbbbrxHXmxa0rNamqUo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PHoD46XPLwF+8lstbOP3g7W+sRj+IQQagkr+jDaTQMXrkVkhsIaqkr22W1zsS1A+ZS8NUbh61asV/iB6Tqp2LKcxrl/Efvbtbuq2Y5Rgd58kCiWq8Dk/IngiuYqvDf3JgfkxDS+7OdIpg0ZTOCKNA/7OJmuq9vyvEKfsDeLn4Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QjBmnK4Y; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGPF9u8nkh929Hlv/nixvDFBIiWMXyjUJBYhM+B1tB4SEns/9W5mRiu1bprp+6BFnWT789UBLz5gbSLXeWyTZSjZQwc6Y9sfoCnkUbstNoAPbUEHA4rjsHqKSdgb+KQsdPr74b31D5A0em/bxVYzmS4Lo0WHP83c/TP9m+pt2S+gdK/ycWui7h516/3vW+F72+UBX0txXJX3DZbhfij/hOKYrQCgde6OACSgsB7v1wrCz/Q0676c24SW6JQ11bCNjAiVu2pp8RZfiZVcy5tdaCBTsqzIb1iDAfdn33JuCprvxGUOQ5VDJ2c7eliuVmHZCuwN6ouMGNbWNajviMLAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIIQHLGKktRT7Z/twNDfJfNwR2NciMA8B064b7kG3Ps=;
 b=YHDNQyr1z31j/e2+zRT6lejQVLSFk5WMfxuZF1RO4O0DN8oorrXwt8lz7AlRxA23L3Q9qYneUxWpgN8HveBvKL1F8XS2pRmeCU0K/0u/Unn0gI/Yb+0aytVperggYOdKFdv8NqNi1KI/4vfDl7wN0uVejmln7ViqZWG0CBXgXwqHc0PS27NwczM1E3wa5KXzSXro6gpRatFoxiV4oc12IHlXEtXwRHN55NBopdyybg8REN2LymsZDGfuUNNyDVnYLeAlGib9nudsD+jypRgxhoeoLb3oE6EmIgnqx5gPoxyf2Zi80VblaGmngFrWVqkd16K42spfY1JqDcp0KxoE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIIQHLGKktRT7Z/twNDfJfNwR2NciMA8B064b7kG3Ps=;
 b=QjBmnK4YoMtLJ3MrEL7sLPZEs2TK0djl8uKgwfSXHm3+R/uW7I6iKVOCCh2nwaB1Df0yNftWF4M/QPl8VP0vyAgMPC3QeE8zYpTevKnl0j+0Kpy9xRtCWE3xanSmDN+Im2Oj7UUd8i71bfOO4L7Rypl9Mhuy/wgZOhcXCyzFqaZmCNnNUP+U4oiBl5dD+XT/E5ji3phPNJtopnlTXuoASlEDk+NTjXWhqS1n6zSuHL2143fnmGe+keynYlENLfNgRZ2THOd8AHtdfNIRp6X1vpy3cpSPi+DCAUQlZDbaOF+BAvQvyAvd7kfWC/p8G73cyJhs3UPYIdU0mZAsLZaeGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6699.apcprd06.prod.outlook.com (2603:1096:400:45b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Thu, 14 Aug 2025 10:21:21 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 10:21:21 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2 0/3] net: use vmalloc_array() to simplify code
Date: Thu, 14 Aug 2025 18:20:52 +0800
Message-Id: <20250814102100.151942-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd0c37a-5d72-427d-205f-08dddb1c5080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WKSgoiodYdI/QILDhX/iv7sUZfC9PKd5UyfO+Fu2+gw02pX8NtOEsome8Rd9?=
 =?us-ascii?Q?jC3zX7FEIvVeRz/mOhBKq4GUiGDy8+F6DxLK6PMpqsEBQEHSUSN1AFNO5QiX?=
 =?us-ascii?Q?nUDcDZG3IG5fgSz8YLed6aavF6YL8d4M47wHjRUChvLCx5jYT/TJGtkvwSb+?=
 =?us-ascii?Q?SG8CdtUvGYxkSK3CMmDkagTMch2TrIVxbLrfRSyh6/l2dCXWKVrqXKEbq6wB?=
 =?us-ascii?Q?Kbiox0xPS2qUGXwINBNBJVnyykBhRIgDW3AoJ3p8YQZ+9iKsIqvBg9jNW/Jj?=
 =?us-ascii?Q?7wuV0jynLnVKtUfdpH7BfMmSQvmjkGw4zpRfmZ7vyOgyp//GH6OwIERzIyX/?=
 =?us-ascii?Q?FUJdjzXVn3ihRfIYoiZt0Wr/bniXlPWBw3udvW8r+p2zmUDe0kyAbtA/zyTX?=
 =?us-ascii?Q?9mc62ygn0ZwYk6Rw8xm6czEbpRdgAUvk0R/Idfdf/7IgWmxs1GWDkTCGXFs9?=
 =?us-ascii?Q?NlHTw8gtg+HSCjmQ0Gdn+T/bN3+lQ5z8QdQ237Pr8YD96cHjd9+O05Jy12D6?=
 =?us-ascii?Q?p/e7mDazN7cgloKDVj+EyaYG281IbMGq+VtX952mprOlQRWmROsLzFpsV9Z+?=
 =?us-ascii?Q?SzdB68K4kL7Cxb1Onog/+suw767TXMARfSt5w+OXljbmz0jFt+DiRIsjHSno?=
 =?us-ascii?Q?md4lrIHELv6aaublpwUHoOrVVjcWoxtD2IVlKqVt14r6NwsT0XsvdGxkzotb?=
 =?us-ascii?Q?kFp49eyzkreFGuA0ZiFGLk21ldchYBIyvRnp2oiBIzJUZnqGbNRItKWOzOw/?=
 =?us-ascii?Q?uR/jL1gMS8m1gsYakOPgZTIKM+gUqoQpLGg++pvI+aTT4wD89tdDwCGsNMfM?=
 =?us-ascii?Q?7h7cqi7zPbg62X5jo3i7SKo32Xoxz4v580BGOgiD+pV1tXyYHxym7MU1bOdK?=
 =?us-ascii?Q?pZqDWiINXQwaUGR9rFZx56MBEhPS7h7yAirgR0khwrhkMCZ3TdFQ2tAPyiDA?=
 =?us-ascii?Q?F/XNCPPlj8Hd2PaK3LktfJthnxegvHcanrj78EqKUB/rou37PyfOmePULug5?=
 =?us-ascii?Q?TdCux5mJ8PlCDRbjJp14UT9sb27oppYdliwa+VdPb1mmznKcXhIwg27ZO8mu?=
 =?us-ascii?Q?HtkIM1Wz25XJ+fDjVYeJ6gxGhu7/NF5FwZSp5QWmhFUWidrGtT72DYta0A+j?=
 =?us-ascii?Q?n2vPHs44BohV/tYlfFS89Aaj3C8ytjs4DhGv/szJgf/Ch+GUEcqBbNLoDi1I?=
 =?us-ascii?Q?puNmjD8V7uniqxCgbQbuSVyhAwloODQ5dkRhcWJ5HRnTE7Q3EnYMzzJQUJmN?=
 =?us-ascii?Q?/R6iH+oIFKVtDXJopNGlMXJpUcgKdUFfzGmDa4N4Xyl8oaCA7NTlY+YDlNVD?=
 =?us-ascii?Q?fOxCBt1txcaVYAWa6rlBU+Mrr3qg2aqjWPB/3XlSRfx6CUGqWWsvPHp+avVa?=
 =?us-ascii?Q?rdZtosZ8YwkVQFc7mXeKyijTWGI+l7B9HZTXsP8Yodt441YlK6Ca9h4HmK76?=
 =?us-ascii?Q?aHwzznN0Y1QzVfpi16qanwRAAxYxwV4XEUMfoIaSc06xy2wOcf5SAvZIsCbI?=
 =?us-ascii?Q?P2Mo/4e9hXM4o3Ly7puijmNQaWIvvfPuCfi1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9GIP9eTuCMKDpTpt1iyY8EA+zuQbSca/7Zmm14NtN/J5tDANROgheXgsj9p?=
 =?us-ascii?Q?QmyDiysIbm9A4SWiVyVgWcJLEBBnUMkSa6nCpAKpecV/szVMmUc696hwbL9i?=
 =?us-ascii?Q?LsyeX43KISVaVw2SqShEWbOg3IkxI9+R3YiECy/XAbj3BtE5uM3nLvDEGuww?=
 =?us-ascii?Q?jxZAnBUd0NLnbUZfpsOFs5gqWvzNeiyuEnAn5ZG79u0fjegg8Z78mnGJuzf3?=
 =?us-ascii?Q?OfwHJiKD7IsjOWBoYA/D6TxiRJjkLm3O394L5mavCH5ZMqnEjXw4J6xd3TWN?=
 =?us-ascii?Q?sQWy0KrTpw9TiJfw0pv2TTdNEty1VKyIv/05K2MUiDzaV70pQ2oDuhlMYNGG?=
 =?us-ascii?Q?V1n76Np0L6wxPS5lxfrpBpHMtj3j1F030/Q+vk9sTUYfTcjzdKFSrUJTDevt?=
 =?us-ascii?Q?+UOsddKsglTlalpO0CcYK1scqnZuVPQOCuHp60Gtm0HzG2uB1g5ICcC+1Ko3?=
 =?us-ascii?Q?jjXRUgCP3p9bctMtlaOMBkSCte1AIWYS47OTH9NZKOwi/85RgGI+FpfUaVEl?=
 =?us-ascii?Q?jYyMgzDPxP/xod+5rSTWoUS0CZL//wLRQyXE8jE6dDPUIwF9f0HfsQdwmFk9?=
 =?us-ascii?Q?/zxKjuB6AwjUI619Wlk3TKos6lujhKoSZyk1jTPZvAwhIw5JqdzIA53FnZxW?=
 =?us-ascii?Q?DNX1OvzQ4QkMWSNH81k/4/LXVZqEXodmKnCiR3qHfWK09PxPXEGzmxewLNNh?=
 =?us-ascii?Q?qZlXVIdhHlUsnTeQ+28magSuRW6lvJV2UuzgXhaU5Ves6xI8aWaBYlJaCLER?=
 =?us-ascii?Q?/iK++No/eUIkUgUzU7x0CHWb99lMA+8NEymaeTm3mD32q8uQw60WrIMwJajb?=
 =?us-ascii?Q?dCQHUrzmUDBixfIJT+qJqedPOc4BKcdjECp5T+MJeto9VFG1+vx6sLHJlt+P?=
 =?us-ascii?Q?LjJXAVqcOsscG2QeyhwYSPyQd8/aQceg3zjRV6ze9cwNb0BsjWBAsITL2TSf?=
 =?us-ascii?Q?wjBUu8ylaBjkvWlhgIhUGpftgf9L9rwuKqvZOjc7tc4ADzauKDfBWiQZA6tf?=
 =?us-ascii?Q?1oL7KdIWHcYwa1u8bIoTq5DyTdf+cPZ+fQya68ymJQkqn+wyKY4dFOh5fn1u?=
 =?us-ascii?Q?ti8ZRU9DMLlDUImlAKqS2E+7oNfGJCIypnJn514IKytuyfFYJAqLAV/Q6tkb?=
 =?us-ascii?Q?j64P97OIw3/Sd1TbnHfPM8c9A4QZwunh4+So+PjbNNBvfQ5zvHDLzP2ioWmV?=
 =?us-ascii?Q?DGfOUi6kO5rKtiLE8Sfry01L9wVCDazB22YdUwmLKVpXnKbhBUUPoF5y35Pz?=
 =?us-ascii?Q?EiVCEeOHUHJJgMO1Y5spkiCc8pVhvam2srpvfFNvNqaVQ+43Wvy/Jf6FqXC9?=
 =?us-ascii?Q?zHMTRpI4gJddrbTQjHFWb1YBmhi570PBirf3Czk233j3uRhPwx7/O02C60Gj?=
 =?us-ascii?Q?5rakWyYvYBFQ0EOzinEIgxd5OvWXlGRT81UGyN++uxaMx4kLiFSUHPtUNjrl?=
 =?us-ascii?Q?lBrGI5YYXocBjkTkrhY+eikoRcl9bveel4QbT3N/Of2ZA7KmVmmiSMqCeIak?=
 =?us-ascii?Q?xzgR0j8/Awi1GIaJZVsGMmm3zcApmdpVJctMAAraLDmphjU2gqmJYmeRC1Vw?=
 =?us-ascii?Q?QPltslEvuMg80duSDjhsvdekmoWMw9BsqUxv6sa8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd0c37a-5d72-427d-205f-08dddb1c5080
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 10:21:21.4852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0CrABbDoNquB+0HwQwVPw3gmQTCCQcFfPnd4VizEdXWpXSrrbzceBJnuEd7XHCnQLsdJIKS3t+6j3Ked0EEKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6699

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code and maintain consistency with existing kmalloc_array()
usage.

vmalloc_array() is also optimized better, resulting in less instructions
being used [1].

[1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
Changes in v2:
- Submit wireless patches separately and modified the commit message and
  subject prefix.
---
Qianfeng Rong (3):
  eth: intel: use vmalloc_array() to simplify code
  nfp: flower: use vmalloc_array() to simplify code
  ppp: use vmalloc_array() to simplify code

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c     | 2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c         | 8 ++++----
 drivers/net/ethernet/intel/igc/igc_ethtool.c         | 8 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c     | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c         | 6 +++---
 drivers/net/ethernet/netronome/nfp/flower/metadata.c | 4 ++--
 drivers/net/ppp/bsd_comp.c                           | 4 ++--
 7 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.34.1


