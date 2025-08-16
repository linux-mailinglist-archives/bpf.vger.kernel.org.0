Return-Path: <bpf+bounces-65810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BCB28C31
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 11:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7777BBFEB
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275923D298;
	Sat, 16 Aug 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="B6iHOyIM"
X-Original-To: bpf@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012031.outbound.protection.outlook.com [40.107.75.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7B145B3F;
	Sat, 16 Aug 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335256; cv=fail; b=quYgHU3jtm1abIqaJdyN0+xxwqjZ6tCHtDSU51hJXnczY1c+bVjKKo62opv4LuP7cL/GMsXo/AA/aS64DHYKJf+4hj6u1sCjc+UTiXnoZ8YxCKiwrrIW6ceuRIhPQuC+nSqA+avIvAE1geQup512sle9Sd9OB/aBI+8SETJUvl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335256; c=relaxed/simple;
	bh=co+4qBMXs5ly/Smu5hk0hPNPrO4nm1XUJpVNPnzPSM4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lHy5w3IuJpnn/oIlNsMkdxmYz0Q0duWWuY1q/oDUS6qT5dyyV8WCqqdGkYlyWUbzTbH26sESKTZgAfFd3JJna6G+fHV4tXomTOTc3Sgg2YOy9267A730wpq7xPNUhqLji4+y21upVmD6xJF8dx3Crwcy5wZ2x6U/qo5Sf9slUFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=B6iHOyIM; arc=fail smtp.client-ip=40.107.75.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Al+E2nLfgI/f6Y7IRPgMiEKoDCkAvSQUZXXOyzSbu4byYC/W1H0M/lusHoWaVZr+cQ/Qf1wyKMJe4y7PRATRVPc8ucwehvqt/pi/Vvm0PvOgWFeoiVsspM83PF9rV9u00jXTy6j2BvA9hGvWPi/DbedjDKu/J7Nj26wW8nuOMiHr134DURXOuVWUp6aVEKrYUSZd3ftiGSrLI/HlIk2SWE+eyxGVQbdoK7ooQ4SUP9ElUYxh1BG5A4aJx09U+SVVCFVv7dlhPtDzHwlSw8S/qpE8/nqZleegss3WAaMOyHYChmGtnBz2m86UXmgfFqFcSs1hR9YOW0Qi4Yp6+QuNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvmLG1uszWqxssGtmXBcaLFZ2LG5+7gvDAaSZ59+H9A=;
 b=gVWDCk1j0U+8SUghoJUJuPFFrvX3QLphU6GwaIdYHxEaLEYPYYlSq9zuBV9HC7KVAF/7fbAGAlJV40yIchc+2LFA1bDfidF7H5joxMejfwzQaW50tIWn9qyu9g83tgtkTpwTTvtvAu2UkK4yrxkJ0iVpsqBLFfqVPuhNwO03x507IB68VHQO5ZoyDvit5zvI8eaJ7aMsttqJIAt75/wlA4w4Sd15KssaG66neTepJg3aCG1MmlD0cOSgqdEs0bv+j1L546gGrFiFnQ6lUdqWkulKGBPC45PyTTG0dKCZLuHNoLQkSzvfxejadi2izAbk41+xKf5/Mk4vjY2xtyaEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvmLG1uszWqxssGtmXBcaLFZ2LG5+7gvDAaSZ59+H9A=;
 b=B6iHOyIMt7wsYopkOuZXLLop1Xzwk7sjhbi81mDlYmRc8Pr2WcO7AN1ZaHuZBLBlqQjPV7wbqBcwHDQZ0mBrD3JHXlfpjhPkjUfiecGAVrSi4tEPRzZDeWAdWpZj8mDfVDyAu9hrleiXFbP27YHb0zKb+BIplIpNzPJCaYpeVuwTzNNGmlNoDC4sH6akCgvs3Bxl8KQWGIgDs7d6aTRwrk/umuxVOhdWaRz+mWvhHaSutmzEgFKVgDcS+uZg3O7bEWEHBDyefxWuWv6tIas75TNq2DRvy1kj0sQWv5ie7Sgvmmt7rHdhFsqAWIE56rEwPiy3uzMC1AR3XiAR53G+/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6305.apcprd06.prod.outlook.com (2603:1096:400:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sat, 16 Aug
 2025 09:07:30 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 09:07:30 +0000
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
	Qianfeng Rong <rongqianfeng@vivo.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH v3 0/3] net: use vmalloc_array() to simplify code
Date: Sat, 16 Aug 2025 17:06:51 +0800
Message-Id: <20250816090659.117699-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: cfc53278-0a19-4a47-e551-08dddca45442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fuwL8+4NJn8AzyXn3X/G4BEUPU5j9Wq6dbZUUE+dBdg6Q34wmfqry1vyvWoK?=
 =?us-ascii?Q?FtSfYd14Az81d51RhuJty4P6GiSeOvcUuh232icT8NvBitOmR9sQuJK+Alnm?=
 =?us-ascii?Q?wtA1X1AYf5P1fFYOJQn4pj6fUa+ppXFmBqz/fxHy8Hv+gV5BG3BaAcDg3O/4?=
 =?us-ascii?Q?gWbIvf2lQomRMKKqQJPYWvlEtcQ1BqX65tsLjabMO+kVSCGM4zCVuiOOB1s4?=
 =?us-ascii?Q?0d0KnnKSy9FfxkxqJOHK7AGq9mRs3NadijHlhGs5IddcvIl+EhiWx3cbQLA+?=
 =?us-ascii?Q?DXdUcnOPBhNF24buTPVaPhsmIaTjzbH5qyTOvNiXtq6IWTsdSZiN9gWnmG2Q?=
 =?us-ascii?Q?KygdckGsOPcXUSCgS1fqeGdVYFmxcTWXVQ5QD2b2H6C/f7J8biCRCp+cXhnS?=
 =?us-ascii?Q?hOOfsr/no2ddx+/mx41Bj7p0VXcQIbuj9hML320VHBkZNfhWbsXXLva5B+bs?=
 =?us-ascii?Q?6OHqDLEUqsqzEIbv8aReE6h0LHqV0vk8qATsBItx95lyL/wQeFy1Y75fNwd3?=
 =?us-ascii?Q?i/4FrvyXxtQDTVLxN2N0p87/zMYsyCgE/aLX/p4CyXxx41wonLvqQ+vsF7aX?=
 =?us-ascii?Q?QKn6eTK9cvlXMiXRIaAC8JgKqTnhTN4PQ4S2QGHJXjfenpyzL7qCur7+Yx0/?=
 =?us-ascii?Q?JjOvOizQKWftg9TgXG7kxO0F0GCEpazjnAB+wv8A7yQoMsNTtinZnT4icP2h?=
 =?us-ascii?Q?LF0nzZXDefkOwBx0MfWPEK6FwMJs59qkLj2ZDwX20biZoZjF8ND4lZ2c/dM8?=
 =?us-ascii?Q?VFBo7CdrCo32j9Im9fi5gVG1CSE7qX8SOXbi0T0i3m/2Xf1F86PJpV9tN2Ta?=
 =?us-ascii?Q?QDKl5nVU6t6SDgZgYy1nHNU6k1mGjbDEGX8teEOHuzoEfcpgD03q2buoQD51?=
 =?us-ascii?Q?BKrzKa4V1a6IIZHUDWa/u+e+TCmZ+yq8FcFKlVLQ4hyPGCkWuMtWAoKxnbvk?=
 =?us-ascii?Q?ncmtBD0i86n6N9meAh+rwYzKjsnuPXCtmy0ZdLSwhs266c6r7i2fPZsW5qWW?=
 =?us-ascii?Q?qXIoVFoM6xyM2vK9E+pYPe0wP03SCpmQVBd+Rvn6a94fL+77Popyo1b/Wkyw?=
 =?us-ascii?Q?tTIUS0f7czhX+XeeHE7aA08qEG/8EdXabCLA7ypNQZ1RJjtFMsT+qxh13PzG?=
 =?us-ascii?Q?y7ixc8pKXGSWStgbhr62ohwNEKX4kRIpr0BXIe5ok0JxTkeyO1Jwd9IsWnG3?=
 =?us-ascii?Q?X9Z5WG0WJvDE7Gu5j21D4t/cnDrbJweFmNkNb8Y/oiMYd4h3tlF967lRzkHk?=
 =?us-ascii?Q?7vvkolbV5H9l7qD7l6tz5N6ejS+wY/ft+A8K3qdQc9Bu8VvGfbkitea/L/Bj?=
 =?us-ascii?Q?AL5IJZEygvZr9gOg3FgM8NWvBOgEQxDC3m76Z6QEm81Yg0O/UQ1dopy9oc9K?=
 =?us-ascii?Q?1bgFAcP3OUmoF2J3eK/XRx74VWsBoQRuzDBgYzd1tArJmg2Iv3TPuLB90PZN?=
 =?us-ascii?Q?Po3TEWHS+oMlPzfAl6tvXHWHdLukFvywBbERWolXCo2DWjZ67hMhRGVPp0Sw?=
 =?us-ascii?Q?umuT1r408SO9/7U6kWDVHnR4Vg3qEb62r98j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wWXamHka9enul8X8GGDt9KItRBbav91f3Y9dx4KOBP6l5L7VbE9vHf1G6nmN?=
 =?us-ascii?Q?GLeBvWKJM923GxTJAlsGRcSf1v60bq37lCIoIGCrHskM39drAHHcoey0hyqE?=
 =?us-ascii?Q?zt5if6ZdeD0YPIvrWPpuFhRBlHnfFnb3r5fVxB80KG9y5l7qOQnRYpBeSvel?=
 =?us-ascii?Q?dRESN/CKOpGjuc03llCNw+z9QNqkfNZCqyGAi86m2lbREVUeiIJb2eMddk9w?=
 =?us-ascii?Q?ogcJhdzDNJ6rpIbvXajI6yV/OY8REI4hPjRKdruOUf8/T8r0BXfVMs6QW4vF?=
 =?us-ascii?Q?tW5rdQ/oXdTfZ51J2vbSeqz/KaP5uhqpCgq5ZW8Tee6r9JJ7Iq7CRkm05kak?=
 =?us-ascii?Q?o19dh8wNt6T5/ePeRNEVdSxktz4BNaOyhkVlh5A/kH0fVT4SZrDgBSBNclp6?=
 =?us-ascii?Q?t64w9qdpads9kdknjmW4aarLytz0YP24U1Rxd1MnMusTZmizR1uGZq1GLguU?=
 =?us-ascii?Q?Uafl2wt/rd8Vp+QeKK9h6WZv0cuSMauhywYhl1C8bH8IpReeAa2uCD5B3Kwn?=
 =?us-ascii?Q?hLJfjwXhgrlT8v/naRzSZ243oixIxDlbY2qfdeuan8Xj3QEV8UNc1kasgCgX?=
 =?us-ascii?Q?Ij8djW6tua+S6rzIXxJfqvZRNlhRgYHpmb1Nf3vbrPN21/dowNR2dBswRYiD?=
 =?us-ascii?Q?/V8+rcU579kcI9gQdMxoIxmbgs9OE+IYM4kY2VcmOmoKW9hvHd+v40HrknOu?=
 =?us-ascii?Q?39MW7As4668DjTpcR+aNUi6VEY8HpksWUOGf68yp1bN9NrftWrBbLwVeIQLe?=
 =?us-ascii?Q?2V6yD1Elo1ARqJr6XMDLhYah0zo6CymIz59i6ouRzJHeyPF58i/OfHEpuM28?=
 =?us-ascii?Q?m7DeVISz5rrjepY5uK2nbEj55/2QUhjSlE5c/U5LEuCNNiQr6Y+yBgvep3Sh?=
 =?us-ascii?Q?d3S03I5PJjUrH97tFqOfaOi34zyyz8e6wR5xdo8afUijMDrVTY9iLfVLmXtx?=
 =?us-ascii?Q?T72npPJrYOYaGoJCpjaY3s3UNjxIaSxcJD/89sPxAZfi9MaQeqVJJjrR6m5b?=
 =?us-ascii?Q?+DNhA/4E219TStjglDo2T00xxP9lSWRwWnGxx0DdKaxcKTwQy6YEB/2VMBE8?=
 =?us-ascii?Q?iD/ogyHSVsbDecBWziiE8RxkfJ9iEKsPZp/t5QABqGug/Cvko/BIzufUuuHR?=
 =?us-ascii?Q?xR4ocXvynxnDzz56oWdDzAvt/Ed8a6P74mjD21Iy09KwW7IqXW6dxDuMuzl7?=
 =?us-ascii?Q?kV2hFs25ToXFAdz450pfuso4s1kJwkbjZcdeQb4joWpHwFLzxZ6HjMrkTT9v?=
 =?us-ascii?Q?46iBFjUGhwpfZCpabY7lMu0z/8sPZm/g6GN//HvuyD4LI7PPgpK5qpersOnX?=
 =?us-ascii?Q?TNAylXOPBetOivUed25PdcHubdPZGiqifk9gyqFCe05XYTFOd9yqar6B08Jw?=
 =?us-ascii?Q?rjGb+EnMo2DvXjGrc2MKuUaBNonOWv6xLCH4whGjGdiPK9fL+6Qn1D8gHaJX?=
 =?us-ascii?Q?aJKzyl8imROLKYRddl40ACzbgeKs5RK9DNfw4g++0HEbD796IRE5cZzAz938?=
 =?us-ascii?Q?QqZVOObenALePNmzOrX5+dd/j+kFTUEAwEI3QJ/anrcdiiyD/0UYCYCFkbm8?=
 =?us-ascii?Q?Dlb0TRYYPgaehxDcycprv0J0uKgwoO/wntiL82r6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc53278-0a19-4a47-e551-08dddca45442
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 09:07:30.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woSPbfn/ORB6P33UDJmedcB4i2RAGoWdsve8hOvbbbgrI/UsM2bpNUrkdE7YIDvpcdtciO65JOfW43Ja0f44Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6305

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code and maintain consistency with existing kmalloc_array()
usage.

vmalloc_array() is also optimized better, resulting in less instructions
being used [1].

[1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Submit wireless patches separately and modified the commit message
    and subject prefix.
v3: Fix -Wcalloc-transposed-args warning in nfp_flower_metadata_init()
    by correcting argument order in vmalloc_array() calls (swap count
    and sizeof arguments).
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


