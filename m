Return-Path: <bpf+bounces-57631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A191AAD649
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3DF9861ED
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C192144C3;
	Wed,  7 May 2025 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="XRzchT4t"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045D214217;
	Wed,  7 May 2025 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599941; cv=fail; b=OmlvXAIdNs8zMYjgPzmyPo/mACBWwiUO13s+hzvtXuUJI8F/yE/keDk0sQTFYqlFwmy0m6jVdfuXnP8qid+BNXJc4yKSTYsHI6PjYkd3OpOEylIhLlXOGeAyNmozJNGYc3vVrJEu7gnI6JB8Yr56sX6KF4DE94cXKCa4R0bTqws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599941; c=relaxed/simple;
	bh=5WYEEeXTJyGvVBFMzZR1kt3koOaSxAEAsA9E4VT9KBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OK18QvLyPHbHTCCmeANS2X8E9lI0zNfdiIPwKk4cOYxDm/RebnQCekeFpRCNNNGapZCZ7H68kWgaiN/pG/XnbHQKDEHgnOnSYfbFBbSYNZWGu+zKC/D1Apq0Nww0E7lcD1fCR0ngJGsyuP/9Pcgz8GFlM/Gpg8GWFSwftfDiMOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=XRzchT4t; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyIFctOjcXogZhPLbt6kTeohEmcq+gQxSR3gfuSO8cZL2v3tu4agLdARrCFHtANpFTuinf4W+iGAKcHjSV+RObb3JdO7Vcuh7B1SrPWE56UNBsmwukfsSUBgnaPh4Ikl0F90iikWiukNuFmw+Uiqg+/cdHspcJpgleOzBS2NkYnLfrSarDZ2vd8QYyjN73j38IrgGLJVdnpVN/fLmI3gS9rhILIiktsU9BBstLX1mdUwqtxZRBwkriJy49HzTzksaPHVsrYgSWFLeOEqhfVN89vjU8O70Z8/N7MOTXdJjbZac8YPa8QH8O9bz5e2n5SBksEFj0d8e7UGxoLs/g1QsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqReom5hZ/8LVDziapk45dvFZsGty4TR4Bhf3oiO5UQ=;
 b=AtusZ4MM85iBsrGKt4qyJXas/RyYxgoBAijqip0eesgZz6kd2ojT85qDv0pGLcpbOU9/v4JvwTMIJiiPgKv9ACJhEUhh8ynbUpLfJpjldZcfAQr9tvP7z8cRzjbh2CpEtxBeLWTkzlSZVdldXmUlblxazeStsszULKkjaF2Frv9bTGpyGHmlj/Lkt2/Tw/b/gK1k47kJlQG/ys7xpMsKn4wiSxwC4eQEEF8bFjg1WIshBK2mLHsBK+ZODDsgURKGKnR7gOe57kEV6HWMwVjVGCGMw4bDsjy3Omi6bxQKwG+QvaMtkGnQ1a/fq5DQm+QpxlKBnBhoCaBh8hTG2L7B0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqReom5hZ/8LVDziapk45dvFZsGty4TR4Bhf3oiO5UQ=;
 b=XRzchT4tLlFdnM6KHu5BEAcJN5MVBdILdnLeCxuqAOFxRl0fB+OdFg3H9I+9YjK1ZVqHuK+4yq711+/eJhungYqKxKdlOQclfq0uPNMfLs9DOo5LpMpVbbJ1wpks300/SO6Moouc3qRKtAIHeEDHrrbnop+n1ckrahSVBZgyRxxYzVuEfu8qGMPo90BXxnWtORoxM/DMX/upntvC+M8PMte88I++FONMqjT6wT6J+H25/4ioYgA1c5yATo9J39oiOn/zcZGtS1JA9r6K3YsbJJ3kurexNflootTVeTE0WXejOHbHrWzSz4uF2ak7RP95lmE6y3rj/3vGx+QOedQF2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by MN2PR03MB5088.namprd03.prod.outlook.com (2603:10b6:208:1b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 06:38:52 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 06:38:52 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH net-next v5 2/3] net: stmmac: stmmac_vlan: rename VLAN functions and symbol to generic symbol.
Date: Wed,  7 May 2025 14:38:11 +0800
Message-Id: <20250507063812.34000-3-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250507063812.34000-1-boon.khai.ng@altera.com>
References: <20250507063812.34000-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|MN2PR03MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: 82449e1e-5fee-4c44-4d05-08dd8d31d512
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1xsh3P0D8BdU6YSykc6Aj1mrml3ycRuF7F90KZPj7292AQhgrAY9B2dTyl8Z?=
 =?us-ascii?Q?7SBmIlavjmZsgLiFClxsp2s2/k0Ao/9p/Yem3aXanZWCdzHe7genj2ejpDSu?=
 =?us-ascii?Q?vD37K2q6epK+4kt0Dk6uPEaOrjFTowYSDpmYknal0UrPebkpZu0tmtxhB7rD?=
 =?us-ascii?Q?40zr1PIx5I0+RiGuBi6+TxjeHGrZstS5rv1pkiKS+BqG22hw0eliAmAusxXD?=
 =?us-ascii?Q?W7iZZb8UKMkuV9cRkINyHD5oPEhAlyG9AVZ2ijwqNTLIR+xmTHq/obuO6k6Y?=
 =?us-ascii?Q?C8PkX59ChEO41z24JRIlY08hS0PULyiyjC8DaNjwQvx4c0UaDCken+GBtIYY?=
 =?us-ascii?Q?pq4RHnYW4MADz5Lq4YKUEeh+T/jVmRcRd+f7Oe+hq97EWRoOpnC0P6T+t1nZ?=
 =?us-ascii?Q?HGG2UOI2zC2Sdk95732ohBX74jIdkDv8nWCDx06x/hK7DYCRzIfIE33yC10t?=
 =?us-ascii?Q?Us+t7u9/EaF6KJ65Grv2R28NvZXfsrkq+Ys+YBDKP1rYaXvLqxOLB7f+/d8i?=
 =?us-ascii?Q?XJZtSUb28NRwLs6s33EireexFVRhOH7/6jt/WTR0Yprho2JdlLcgtOtu4waZ?=
 =?us-ascii?Q?VC0ph1HdFkHU37xDMmVbQZGkIR8OcH4Yz+xG7Z0FZsDmNJqOnNDcDD1j2Oph?=
 =?us-ascii?Q?Wj53/NSzjwE8I+ocSdrG41ILq3wWQ9zgm6nIxZ1YZ4dftbAgN1fgMQSttiTt?=
 =?us-ascii?Q?y6yGeIYr3S6bw8H6b9MQB6eTjwkG5XD663TRwFDbUlsafQJPaSlqPdwiGm11?=
 =?us-ascii?Q?UwEo98YknWUrAkciNJ6WTBo1h3lVDifSf5mA/qRgUX/wAGQOooG9korzcrqV?=
 =?us-ascii?Q?CnqFgnA2ptjoLF4by/sbO3o6CWm1gY3f1S69BAVkphrsOmlHKVyS0F1EH/66?=
 =?us-ascii?Q?yv7DJWL4AftHmZW0F+6mS74fTOJCUb9ypJcQobdlkILK50qJxaOcOa5U/ynH?=
 =?us-ascii?Q?5lq6Y+FD1QEbp1mWFkWdW+LoHcq5ITxyPYt2c6HJsh9AoxRe9MiquVksHvnC?=
 =?us-ascii?Q?6ir9Z+ZMi1ti4eM9j0YW8h6IE7TiR0B0aluBaavZLNVaAEz/+HZK8jo3s06V?=
 =?us-ascii?Q?MUcqJ2aEEuaGtEDKPjW1c0wugqXVnaxwlOOzIm7AdzJAsQ18SameFWTZYkQs?=
 =?us-ascii?Q?FnBTfj3OirLLHmZCnOrZpio5ImwIsS6i37G9CQ5iNz7lTvStkrdlDCQH0VW2?=
 =?us-ascii?Q?dUmJZOcnO3agSTgPkSdnReVPPUsquLBO/kp8RbrhcgtFoNVqFl9hgej3IjVA?=
 =?us-ascii?Q?QsEogdGswd5IcszIjmbJIQLp5UmruuqFDwPaY0PTALt9AdBNvgQOob+aTjc4?=
 =?us-ascii?Q?z2SL2m63B14SLvcw5IBYmu/tynqiqUgnMJ9GLBxAt7Zl2B7R+l7ZaeYXQFBA?=
 =?us-ascii?Q?AY1ZHHxg7zxcXgI5kaSd7DzZWpB5wKw3BQLeHzmQWmwt4d/CyEDNJRY8PY9w?=
 =?us-ascii?Q?IZeGQAZ4Utk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHIngOypBJ1JMtOs3ZrqFE71ruFMcIAYTj/c47v6iP4zT50y4g1LPXf8xC+N?=
 =?us-ascii?Q?8zeaFbuTBAkOe0+DL0jZ9waH7Ei9NXdGKnIeSWUUohuEw+V/mQ76/hSxGHFU?=
 =?us-ascii?Q?7jyhCRFPYRYjrSYIStEq/JuQLM/CgKRMP2mn5QKxJUW0xDb7xj1ha+ebX+Dg?=
 =?us-ascii?Q?CNYpy69tdwh6qVIImnJp63i+Tf3HsakpyPuxJGTTQ1W7zfLtEqCIfzYee8EH?=
 =?us-ascii?Q?Cxg/goY0j5y5gfmtrpBuW+vPnAEh1bZQsaNRP5aolnejs8YqWKqc++fBbFdL?=
 =?us-ascii?Q?vkIKTiagcyPmsCV5yTFdA8/sxeu2ASyRAc6cKj7zRW18iNMz3A8iAlO9wkx3?=
 =?us-ascii?Q?rZQl3idLOqj1o+HWoB68OXqCdrG3q5/TfpO7eU0HsE5t7Eguf7kZjuQBvxpS?=
 =?us-ascii?Q?NyPeg8bQHbKh8hqqf/QObkrBfUWdZY6DJ5XxaoPMUmOGRu45s+aUThTOx7KN?=
 =?us-ascii?Q?wW8Ej/LugfK2J2Eq6hqDQmkE4iqX/SbXVZvwaUJX6tPBAttblnVvCAbT2y/C?=
 =?us-ascii?Q?Ch+FxY0FmpZf3IJaPMSl1QZagrjg7n5SiJtXuOW75mVEYXpeOmY6MtmBVQbR?=
 =?us-ascii?Q?rXEIgBnaZJ7OiDPrP3Zsdv0aPgVY5MIVp4Ry1FpSHB5JrxSQ1ZqBK/ljBX1b?=
 =?us-ascii?Q?FoXkbqiQVDG1+YEEjX2F4peZTqDoCgmZyTMpfG7sQubv4nLgcfp6+eub2jAP?=
 =?us-ascii?Q?UG0AmONYgvtdyU9P68xoH3B9fFciZNVMzK8sYm/8lUb8G/TxT5ReFLhUPDYY?=
 =?us-ascii?Q?fTnqBKmgyR8yencXPhP3dulAXZrV1uRlWTPIfM4XlkKfiGopdBcHS8hc6Zat?=
 =?us-ascii?Q?7MeMCNGGXNYijxmJYs5FeTfJjoHM9gbSjnPB8PWXVsih6HZi0N7u/hrUIM0F?=
 =?us-ascii?Q?mlADvlpSOsVyAFdNUTNQWGR3Onxec9Lzd3los7n6RGe3nbIe4XU1cPcYWiC4?=
 =?us-ascii?Q?V1Lvgu5rIxh2n38FG5AZ2DMafaFvtkAXZ6ZCQMlthKGKnrMwwE+kTHg/Sg7x?=
 =?us-ascii?Q?V5GBSd4n9h1fkuH/8G6KVNLedjkhyZ+q8Ww3xxKHsvyU1trPLM7Lb2k35Kdq?=
 =?us-ascii?Q?ggpyEGS9c/K/XIXLtHp9slTNQclvX/MwbtlYsTPblvyqU0VVAr83wzO1OzH5?=
 =?us-ascii?Q?YqyX6oP/UHGI+6yRQOnybOewhQpuq6GAwTvqsynowRBYnhuZDUORHxdDcoFs?=
 =?us-ascii?Q?3pFwKsfrYCb3brJ/Yl91OlTUXoApCtRCxyXK/HbLe6IdrgJjsKNdjJ02du0h?=
 =?us-ascii?Q?yCRkRw10OHiyc+Wjo0evjo7d01UW+zFJ7NvfC+QlYDuxDSXjBtfHD8fBotTO?=
 =?us-ascii?Q?PiPX6+uLSarliA1MHzw1ii6gtxP6CVRPoVXXXHoFft2oeFT1PN3PQBHAVTkP?=
 =?us-ascii?Q?tqpa1+M/T5+tX2nUucBW8ecCFUdlM5aOsNMamAtGQUTmEnPqtUQMNN3WPHFS?=
 =?us-ascii?Q?Hb9EcCcEAEyfhW4vyM4RHA8WeFjTHLGAy168pS4eBgk8b3tauUdkXue9NHTU?=
 =?us-ascii?Q?6T8m6V74koX6L853Z/WzXCs0GQ8YFI/YpZy94cCmBwXePtohwiA/Ie/X69gp?=
 =?us-ascii?Q?VeHuO4mfbDwx0fELkujJPZj3PdlZPu6P9VXPukmO6iVUx5FuR7+XThVdXRgT?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82449e1e-5fee-4c44-4d05-08dd8d31d512
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 06:38:52.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fe79rJzeIfzbQep9Q+e/sbCngB5d2VeHQEy8wxtXJ7GRZvmNq4oWsj05HZWLQ9Agm/evRyOaTiUuVIxyciHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5088

With the VLAN handling code decoupled from dwmac4 and dwxgmac2 and
consolidated in stmmac_vlan.c, functions and symbols are renamed to
use a generic prefix. This change improves code clarity and
maintainability by reflecting the shared nature of the VLAN logic,
facilitating future enhancements or reuse without being tied to
specific MAC implementations.

No functional changes are introduced in this patch.

Note: The dwxgmac2_update_vlan_hash function is not combined due
to minor differences in setting the VTFE bit. A separate fix patch
will be submitted to align its behavior with the dwmac4 driver.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +-
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 273 ++++++++----------
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.h |  88 +++---
 4 files changed, 161 insertions(+), 210 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 55f9614cd6a4..9c2549d4100f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1077,7 +1077,7 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->mii.reg_mask = GENMASK(20, 16);
 	mac->mii.clk_csr_shift = 8;
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
-	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
+	mac->num_vlan = stmmac_get_num_vlan(priv->ioaddr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index d801cd40b529..99635b37044a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -177,7 +177,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac4_ops,
-		.vlan = &dwmac4_vlan_ops,
+		.vlan = &dwmac_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
@@ -200,7 +200,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac410_ops,
-		.vlan = &dwmac410_vlan_ops,
+		.vlan = &dwmac_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
@@ -223,7 +223,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac410_ops,
-		.vlan = &dwmac410_vlan_ops,
+		.vlan = &dwmac_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
@@ -246,7 +246,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac510_ops,
-		.vlan = &dwmac510_vlan_ops,
+		.vlan = &dwmac_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index c84d92174de7..c66233f2c697 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -7,21 +7,21 @@
 #include "stmmac.h"
 #include "stmmac_vlan.h"
 
-static void dwmac4_write_single_vlan(struct net_device *dev, u16 vid)
+static void vlan_write_single(struct net_device *dev, u16 vid)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
 	u32 val;
 
-	val = readl(ioaddr + GMAC_VLAN_TAG);
-	val &= ~GMAC_VLAN_TAG_VID;
-	val |= GMAC_VLAN_TAG_ETV | vid;
+	val = readl(ioaddr + VLAN_TAG);
+	val &= ~VLAN_TAG_VID;
+	val |= VLAN_TAG_ETV | vid;
 
-	writel(val, ioaddr + GMAC_VLAN_TAG);
+	writel(val, ioaddr + VLAN_TAG);
 }
 
-static int dwmac4_write_vlan_filter(struct net_device *dev,
-				    struct mac_device_info *hw,
-				    u8 index, u32 data)
+static int vlan_write_filter(struct net_device *dev,
+			     struct mac_device_info *hw,
+			     u8 index, u32 data)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
 	int ret;
@@ -30,18 +30,18 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,
 	if (index >= hw->num_vlan)
 		return -EINVAL;
 
-	writel(data, ioaddr + GMAC_VLAN_TAG_DATA);
+	writel(data, ioaddr + VLAN_TAG_DATA);
 
-	val = readl(ioaddr + GMAC_VLAN_TAG);
-	val &= ~(GMAC_VLAN_TAG_CTRL_OFS_MASK |
-		GMAC_VLAN_TAG_CTRL_CT |
-		GMAC_VLAN_TAG_CTRL_OB);
-	val |= (index << GMAC_VLAN_TAG_CTRL_OFS_SHIFT) | GMAC_VLAN_TAG_CTRL_OB;
+	val = readl(ioaddr + VLAN_TAG);
+	val &= ~(VLAN_TAG_CTRL_OFS_MASK |
+		VLAN_TAG_CTRL_CT |
+		VLAN_TAG_CTRL_OB);
+	val |= (index << VLAN_TAG_CTRL_OFS_SHIFT) | VLAN_TAG_CTRL_OB;
 
-	writel(val, ioaddr + GMAC_VLAN_TAG);
+	writel(val, ioaddr + VLAN_TAG);
 
-	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
-				 !(val & GMAC_VLAN_TAG_CTRL_OB),
+	ret = readl_poll_timeout(ioaddr + VLAN_TAG, val,
+				 !(val & VLAN_TAG_CTRL_OB),
 				 1000, 500000);
 	if (ret) {
 		netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
@@ -51,9 +51,9 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,
 	return 0;
 }
 
-static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
-				      struct mac_device_info *hw,
-				      __be16 proto, u16 vid)
+static int vlan_add_hw_rx_fltr(struct net_device *dev,
+			       struct mac_device_info *hw,
+			       __be16 proto, u16 vid)
 {
 	int index = -1;
 	u32 val = 0;
@@ -70,24 +70,24 @@ static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
 			return -EPERM;
 		}
 
-		if (hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) {
+		if (hw->vlan_filter[0] & VLAN_TAG_VID) {
 			netdev_err(dev, "Only single VLAN ID supported\n");
 			return -EPERM;
 		}
 
 		hw->vlan_filter[0] = vid;
-		dwmac4_write_single_vlan(dev, vid);
+		vlan_write_single(dev, vid);
 
 		return 0;
 	}
 
 	/* Extended Rx VLAN Filter Enable */
-	val |= GMAC_VLAN_TAG_DATA_ETV | GMAC_VLAN_TAG_DATA_VEN | vid;
+	val |= VLAN_TAG_DATA_ETV | VLAN_TAG_DATA_VEN | vid;
 
 	for (i = 0; i < hw->num_vlan; i++) {
 		if (hw->vlan_filter[i] == val)
 			return 0;
-		else if (!(hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VEN))
+		else if (!(hw->vlan_filter[i] & VLAN_TAG_DATA_VEN))
 			index = i;
 	}
 
@@ -97,7 +97,7 @@ static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
 		return -EPERM;
 	}
 
-	ret = dwmac4_write_vlan_filter(dev, hw, index, val);
+	ret = vlan_write_filter(dev, hw, index, val);
 
 	if (!ret)
 		hw->vlan_filter[index] = val;
@@ -105,25 +105,25 @@ static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
 	return ret;
 }
 
-static int dwmac4_del_hw_vlan_rx_fltr(struct net_device *dev,
-				      struct mac_device_info *hw,
-				      __be16 proto, u16 vid)
+static int vlan_del_hw_rx_fltr(struct net_device *dev,
+			       struct mac_device_info *hw,
+			       __be16 proto, u16 vid)
 {
 	int i, ret = 0;
 
 	/* Single Rx VLAN Filter */
 	if (hw->num_vlan == 1) {
-		if ((hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) == vid) {
+		if ((hw->vlan_filter[0] & VLAN_TAG_VID) == vid) {
 			hw->vlan_filter[0] = 0;
-			dwmac4_write_single_vlan(dev, 0);
+			vlan_write_single(dev, 0);
 		}
 		return 0;
 	}
 
 	/* Extended Rx VLAN Filter Enable */
 	for (i = 0; i < hw->num_vlan; i++) {
-		if ((hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VID) == vid) {
-			ret = dwmac4_write_vlan_filter(dev, hw, i, 0);
+		if ((hw->vlan_filter[i] & VLAN_TAG_DATA_VID) == vid) {
+			ret = vlan_write_filter(dev, hw, i, 0);
 
 			if (!ret)
 				hw->vlan_filter[i] = 0;
@@ -135,8 +135,8 @@ static int dwmac4_del_hw_vlan_rx_fltr(struct net_device *dev,
 	return ret;
 }
 
-static void dwmac4_restore_hw_vlan_rx_fltr(struct net_device *dev,
-					   struct mac_device_info *hw)
+static void vlan_restore_hw_rx_fltr(struct net_device *dev,
+				    struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
@@ -146,80 +146,80 @@ static void dwmac4_restore_hw_vlan_rx_fltr(struct net_device *dev,
 
 	/* Single Rx VLAN Filter */
 	if (hw->num_vlan == 1) {
-		dwmac4_write_single_vlan(dev, hw->vlan_filter[0]);
+		vlan_write_single(dev, hw->vlan_filter[0]);
 		return;
 	}
 
 	/* Extended Rx VLAN Filter Enable */
 	for (i = 0; i < hw->num_vlan; i++) {
-		if (hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VEN) {
+		if (hw->vlan_filter[i] & VLAN_TAG_DATA_VEN) {
 			val = hw->vlan_filter[i];
-			dwmac4_write_vlan_filter(dev, hw, i, val);
+			vlan_write_filter(dev, hw, i, val);
 		}
 	}
 
-	hash = readl(ioaddr + GMAC_VLAN_HASH_TABLE);
-	if (hash & GMAC_VLAN_VLHT) {
-		value = readl(ioaddr + GMAC_VLAN_TAG);
-		value |= GMAC_VLAN_VTHM;
-		writel(value, ioaddr + GMAC_VLAN_TAG);
+	hash = readl(ioaddr + VLAN_HASH_TABLE);
+	if (hash & VLAN_VLHT) {
+		value = readl(ioaddr + VLAN_TAG);
+		value |= VLAN_VTHM;
+		writel(value, ioaddr + VLAN_TAG);
 	}
 }
 
-static void dwmac4_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				    u16 perfect_match, bool is_double)
+static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
+			     u16 perfect_match, bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
-	writel(hash, ioaddr + GMAC_VLAN_HASH_TABLE);
+	writel(hash, ioaddr + VLAN_HASH_TABLE);
 
-	value = readl(ioaddr + GMAC_VLAN_TAG);
+	value = readl(ioaddr + VLAN_TAG);
 
 	if (hash) {
-		value |= GMAC_VLAN_VTHM | GMAC_VLAN_ETV;
+		value |= VLAN_VTHM | VLAN_ETV;
 		if (is_double) {
-			value |= GMAC_VLAN_EDVLP;
-			value |= GMAC_VLAN_ESVL;
-			value |= GMAC_VLAN_DOVLTC;
+			value |= VLAN_EDVLP;
+			value |= VLAN_ESVL;
+			value |= VLAN_DOVLTC;
 		}
 
-		writel(value, ioaddr + GMAC_VLAN_TAG);
+		writel(value, ioaddr + VLAN_TAG);
 	} else if (perfect_match) {
-		u32 value = GMAC_VLAN_ETV;
+		u32 value = VLAN_ETV;
 
 		if (is_double) {
-			value |= GMAC_VLAN_EDVLP;
-			value |= GMAC_VLAN_ESVL;
-			value |= GMAC_VLAN_DOVLTC;
+			value |= VLAN_EDVLP;
+			value |= VLAN_ESVL;
+			value |= VLAN_DOVLTC;
 		}
 
-		writel(value | perfect_match, ioaddr + GMAC_VLAN_TAG);
+		writel(value | perfect_match, ioaddr + VLAN_TAG);
 	} else {
-		value &= ~(GMAC_VLAN_VTHM | GMAC_VLAN_ETV);
-		value &= ~(GMAC_VLAN_EDVLP | GMAC_VLAN_ESVL);
-		value &= ~GMAC_VLAN_DOVLTC;
-		value &= ~GMAC_VLAN_VID;
+		value &= ~(VLAN_VTHM | VLAN_ETV);
+		value &= ~(VLAN_EDVLP | VLAN_ESVL);
+		value &= ~VLAN_DOVLTC;
+		value &= ~VLAN_VID;
 
-		writel(value, ioaddr + GMAC_VLAN_TAG);
+		writel(value, ioaddr + VLAN_TAG);
 	}
 }
 
-static void dwmac4_enable_vlan(struct mac_device_info *hw, u32 type)
+static void vlan_enable(struct mac_device_info *hw, u32 type)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
-	value = readl(ioaddr + GMAC_VLAN_INCL);
-	value |= GMAC_VLAN_VLTI;
-	value |= GMAC_VLAN_CSVL; /* Only use SVLAN */
-	value &= ~GMAC_VLAN_VLC;
-	value |= (type << GMAC_VLAN_VLC_SHIFT) & GMAC_VLAN_VLC;
-	writel(value, ioaddr + GMAC_VLAN_INCL);
+	value = readl(ioaddr + VLAN_INCL);
+	value |= VLAN_VLTI;
+	value |= VLAN_CSVL; /* Only use SVLAN */
+	value &= ~VLAN_VLC;
+	value |= (type << VLAN_VLC_SHIFT) & VLAN_VLC;
+	writel(value, ioaddr + VLAN_INCL);
 }
 
-static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
-			      struct dma_desc *rx_desc, struct sk_buff *skb)
+static void vlan_rx_hw(struct mac_device_info *hw,
+		       struct dma_desc *rx_desc, struct sk_buff *skb)
 {
 	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
 		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
@@ -228,23 +228,23 @@ static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
 	}
 }
 
-static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
+static void vlan_set_hw_mode(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value = readl(ioaddr + GMAC_VLAN_TAG);
+	u32 value = readl(ioaddr + VLAN_TAG);
 
-	value &= ~GMAC_VLAN_TAG_CTRL_EVLS_MASK;
+	value &= ~VLAN_TAG_CTRL_EVLS_MASK;
 
 	if (hw->hw_vlan_en)
 		/* Always strip VLAN on Receive */
-		value |= GMAC_VLAN_TAG_STRIP_ALL;
+		value |= VLAN_TAG_STRIP_ALL;
 	else
 		/* Do not strip VLAN on Receive */
-		value |= GMAC_VLAN_TAG_STRIP_NONE;
+		value |= VLAN_TAG_STRIP_NONE;
 
 	/* Enable outer VLAN Tag in Rx DMA descriptor */
-	value |= GMAC_VLAN_TAG_CTRL_EVLRXS;
-	writel(value, ioaddr + GMAC_VLAN_TAG);
+	value |= VLAN_TAG_CTRL_EVLRXS;
+	writel(value, ioaddr + VLAN_TAG);
 }
 
 static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
@@ -252,7 +252,7 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 {
 	void __iomem *ioaddr = hw->pcsr;
 
-	writel(hash, ioaddr + XGMAC_VLAN_HASH_TABLE);
+	writel(hash, ioaddr + VLAN_HASH_TABLE);
 
 	if (hash) {
 		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
@@ -261,21 +261,21 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 		writel(value, ioaddr + XGMAC_PACKET_FILTER);
 
-		value = readl(ioaddr + XGMAC_VLAN_TAG);
+		value = readl(ioaddr + VLAN_TAG);
 
-		value |= XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV;
+		value |= VLAN_VTHM | VLAN_ETV;
 		if (is_double) {
-			value |= XGMAC_VLAN_EDVLP;
-			value |= XGMAC_VLAN_ESVL;
-			value |= XGMAC_VLAN_DOVLTC;
+			value |= VLAN_EDVLP;
+			value |= VLAN_ESVL;
+			value |= VLAN_DOVLTC;
 		} else {
-			value &= ~XGMAC_VLAN_EDVLP;
-			value &= ~XGMAC_VLAN_ESVL;
-			value &= ~XGMAC_VLAN_DOVLTC;
+			value &= ~VLAN_EDVLP;
+			value &= ~VLAN_ESVL;
+			value &= ~VLAN_DOVLTC;
 		}
 
-		value &= ~XGMAC_VLAN_VID;
-		writel(value, ioaddr + XGMAC_VLAN_TAG);
+		value &= ~VLAN_VID;
+		writel(value, ioaddr + VLAN_TAG);
 	} else if (perfect_match) {
 		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
 
@@ -283,22 +283,22 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 		writel(value, ioaddr + XGMAC_PACKET_FILTER);
 
-		value = readl(ioaddr + XGMAC_VLAN_TAG);
+		value = readl(ioaddr + VLAN_TAG);
 
-		value &= ~XGMAC_VLAN_VTHM;
-		value |= XGMAC_VLAN_ETV;
+		value &= ~VLAN_VTHM;
+		value |= VLAN_ETV;
 		if (is_double) {
-			value |= XGMAC_VLAN_EDVLP;
-			value |= XGMAC_VLAN_ESVL;
-			value |= XGMAC_VLAN_DOVLTC;
+			value |= VLAN_EDVLP;
+			value |= VLAN_ESVL;
+			value |= VLAN_DOVLTC;
 		} else {
-			value &= ~XGMAC_VLAN_EDVLP;
-			value &= ~XGMAC_VLAN_ESVL;
-			value &= ~XGMAC_VLAN_DOVLTC;
+			value &= ~VLAN_EDVLP;
+			value &= ~VLAN_ESVL;
+			value &= ~VLAN_DOVLTC;
 		}
 
-		value &= ~XGMAC_VLAN_VID;
-		writel(value | perfect_match, ioaddr + XGMAC_VLAN_TAG);
+		value &= ~VLAN_VID;
+		writel(value | perfect_match, ioaddr + VLAN_TAG);
 	} else {
 		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
 
@@ -306,76 +306,43 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 		writel(value, ioaddr + XGMAC_PACKET_FILTER);
 
-		value = readl(ioaddr + XGMAC_VLAN_TAG);
+		value = readl(ioaddr + VLAN_TAG);
 
-		value &= ~(XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV);
-		value &= ~(XGMAC_VLAN_EDVLP | XGMAC_VLAN_ESVL);
-		value &= ~XGMAC_VLAN_DOVLTC;
-		value &= ~XGMAC_VLAN_VID;
+		value &= ~(VLAN_VTHM | VLAN_ETV);
+		value &= ~(VLAN_EDVLP | VLAN_ESVL);
+		value &= ~VLAN_DOVLTC;
+		value &= ~VLAN_VID;
 
-		writel(value, ioaddr + XGMAC_VLAN_TAG);
+		writel(value, ioaddr + VLAN_TAG);
 	}
 }
 
-static void dwxgmac2_enable_vlan(struct mac_device_info *hw, u32 type)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	value = readl(ioaddr + XGMAC_VLAN_INCL);
-	value |= XGMAC_VLAN_VLTI;
-	value |= XGMAC_VLAN_CSVL; /* Only use SVLAN */
-	value &= ~XGMAC_VLAN_VLC;
-	value |= (type << XGMAC_VLAN_VLC_SHIFT) & XGMAC_VLAN_VLC;
-	writel(value, ioaddr + XGMAC_VLAN_INCL);
-}
-
-const struct stmmac_vlan_ops dwmac4_vlan_ops = {
-	.update_vlan_hash = dwmac4_update_vlan_hash,
-	.enable_vlan = dwmac4_enable_vlan,
-	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
-	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
-	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
-	.rx_hw_vlan = dwmac4_rx_hw_vlan,
-	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
-};
-
-const struct stmmac_vlan_ops dwmac410_vlan_ops = {
-	.update_vlan_hash = dwmac4_update_vlan_hash,
-	.enable_vlan = dwmac4_enable_vlan,
-	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
-	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
-	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
-	.rx_hw_vlan = dwmac4_rx_hw_vlan,
-	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
-};
-
-const struct stmmac_vlan_ops dwmac510_vlan_ops = {
-	.update_vlan_hash = dwmac4_update_vlan_hash,
-	.enable_vlan = dwmac4_enable_vlan,
-	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
-	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
-	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
-	.rx_hw_vlan = dwmac4_rx_hw_vlan,
-	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
+const struct stmmac_vlan_ops dwmac_vlan_ops = {
+	.update_vlan_hash = vlan_update_hash,
+	.enable_vlan = vlan_enable,
+	.add_hw_vlan_rx_fltr = vlan_add_hw_rx_fltr,
+	.del_hw_vlan_rx_fltr = vlan_del_hw_rx_fltr,
+	.restore_hw_vlan_rx_fltr = vlan_restore_hw_rx_fltr,
+	.rx_hw_vlan = vlan_rx_hw,
+	.set_hw_vlan_mode = vlan_set_hw_mode,
 };
 
-const struct stmmac_vlan_ops dwxgmac210_vlan_ops = {
+const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
 	.update_vlan_hash = dwxgmac2_update_vlan_hash,
-	.enable_vlan = dwxgmac2_enable_vlan,
+	.enable_vlan = vlan_enable,
 };
 
-const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
+const struct stmmac_vlan_ops dwxgmac210_vlan_ops = {
 	.update_vlan_hash = dwxgmac2_update_vlan_hash,
-	.enable_vlan = dwxgmac2_enable_vlan,
+	.enable_vlan = vlan_enable,
 };
 
-u32 dwmac4_get_num_vlan(void __iomem *ioaddr)
+u32 stmmac_get_num_vlan(void __iomem *ioaddr)
 {
 	u32 val, num_vlan;
 
-	val = readl(ioaddr + GMAC_HW_FEATURE3);
-	switch (val & GMAC_HW_FEAT_NRVF) {
+	val = readl(ioaddr + HW_FEATURE3);
+	switch (val & VLAN_HW_FEAT_NRVF) {
 	case 0:
 		num_vlan = 1;
 		break;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
index c318e58110ce..c24f89a9049b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
@@ -8,73 +8,57 @@
 #define __STMMAC_VLAN_H__
 
 #include <linux/bitfield.h>
-#include "dwmac4.h"
 #include "dwxgmac2.h"
 
-/* DWMAC4 Setting */
-#define GMAC_VLAN_TAG			0x00000050
-#define GMAC_VLAN_TAG_DATA		0x00000054
-#define GMAC_VLAN_HASH_TABLE		0x00000058
-#define GMAC_VLAN_INCL			0x00000060
+#define VLAN_TAG			0x00000050
+#define VLAN_TAG_DATA			0x00000054
+#define VLAN_HASH_TABLE			0x00000058
+#define VLAN_INCL			0x00000060
 
 /* MAC VLAN */
-#define GMAC_VLAN_EDVLP			BIT(26)
-#define GMAC_VLAN_VTHM			BIT(25)
-#define GMAC_VLAN_DOVLTC		BIT(20)
-#define GMAC_VLAN_ESVL			BIT(18)
-#define GMAC_VLAN_ETV			BIT(16)
-#define GMAC_VLAN_VID			GENMASK(15, 0)
-#define GMAC_VLAN_VLTI			BIT(20)
-#define GMAC_VLAN_CSVL			BIT(19)
-#define GMAC_VLAN_VLC			GENMASK(17, 16)
-#define GMAC_VLAN_VLC_SHIFT		16
-#define GMAC_VLAN_VLHT			GENMASK(15, 0)
+#define VLAN_EDVLP			BIT(26)
+#define VLAN_VTHM			BIT(25)
+#define VLAN_DOVLTC			BIT(20)
+#define VLAN_ESVL			BIT(18)
+#define VLAN_ETV			BIT(16)
+#define VLAN_VID			GENMASK(15, 0)
+#define VLAN_VLTI			BIT(20)
+#define VLAN_CSVL			BIT(19)
+#define VLAN_VLC			GENMASK(17, 16)
+#define VLAN_VLC_SHIFT			16
+#define VLAN_VLHT			GENMASK(15, 0)
 
 /* MAC VLAN Tag */
-#define GMAC_VLAN_TAG_VID		GENMASK(15, 0)
-#define GMAC_VLAN_TAG_ETV		BIT(16)
+#define VLAN_TAG_VID			GENMASK(15, 0)
+#define VLAN_TAG_ETV			BIT(16)
 
 /* MAC VLAN Tag Control */
-#define GMAC_VLAN_TAG_CTRL_OB		BIT(0)
-#define GMAC_VLAN_TAG_CTRL_CT		BIT(1)
-#define GMAC_VLAN_TAG_CTRL_OFS_MASK	GENMASK(6, 2)
-#define GMAC_VLAN_TAG_CTRL_OFS_SHIFT	2
-#define GMAC_VLAN_TAG_CTRL_EVLS_MASK	GENMASK(22, 21)
-#define GMAC_VLAN_TAG_CTRL_EVLS_SHIFT	21
-#define GMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)
+#define VLAN_TAG_CTRL_OB		BIT(0)
+#define VLAN_TAG_CTRL_CT		BIT(1)
+#define VLAN_TAG_CTRL_OFS_MASK		GENMASK(6, 2)
+#define VLAN_TAG_CTRL_OFS_SHIFT		2
+#define VLAN_TAG_CTRL_EVLS_MASK		GENMASK(22, 21)
+#define VLAN_TAG_CTRL_EVLS_SHIFT	21
+#define VLAN_TAG_CTRL_EVLRXS		BIT(24)
 
-#define GMAC_VLAN_TAG_STRIP_NONE	(0x0 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-#define GMAC_VLAN_TAG_STRIP_PASS	(0x1 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-#define GMAC_VLAN_TAG_STRIP_FAIL	(0x2 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-#define GMAC_VLAN_TAG_STRIP_ALL		(0x3 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define VLAN_TAG_STRIP_NONE		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x0)
+#define VLAN_TAG_STRIP_PASS		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x1)
+#define VLAN_TAG_STRIP_FAIL		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x2)
+#define VLAN_TAG_STRIP_ALL		FIELD_PREP(VLAN_TAG_CTRL_EVLS_MASK, 0x3)
 
 /* MAC VLAN Tag Data/Filter */
-#define GMAC_VLAN_TAG_DATA_VID		GENMASK(15, 0)
-#define GMAC_VLAN_TAG_DATA_VEN		BIT(16)
-#define GMAC_VLAN_TAG_DATA_ETV		BIT(17)
+#define VLAN_TAG_DATA_VID		GENMASK(15, 0)
+#define VLAN_TAG_DATA_VEN		BIT(16)
+#define VLAN_TAG_DATA_ETV		BIT(17)
 
-/* DWXGMAC Setting */
-#define XGMAC_VLAN_TAG			0x00000050
-#define XGMAC_VLAN_EDVLP		BIT(26)
-#define XGMAC_VLAN_VTHM			BIT(25)
-#define XGMAC_VLAN_DOVLTC		BIT(20)
-#define XGMAC_VLAN_ESVL			BIT(18)
-#define XGMAC_VLAN_ETV			BIT(16)
-#define XGMAC_VLAN_VID			GENMASK(15, 0)
-#define XGMAC_VLAN_HASH_TABLE		0x00000058
-#define XGMAC_VLAN_INCL			0x00000060
-#define XGMAC_VLAN_VLTI			BIT(20)
-#define XGMAC_VLAN_CSVL			BIT(19)
-#define XGMAC_VLAN_VLC			GENMASK(17, 16)
-#define XGMAC_VLAN_VLC_SHIFT		16
-#define XGMAC_FILTER_VTFE		BIT(16)
+/* MAC VLAN HW FEAT */
+#define HW_FEATURE3			0x00000128
+#define VLAN_HW_FEAT_NRVF		GENMASK(2, 0)
 
-extern const struct stmmac_vlan_ops dwmac4_vlan_ops;
-extern const struct stmmac_vlan_ops dwmac410_vlan_ops;
-extern const struct stmmac_vlan_ops dwmac510_vlan_ops;
+extern const struct stmmac_vlan_ops dwmac_vlan_ops;
 extern const struct stmmac_vlan_ops dwxgmac210_vlan_ops;
 extern const struct stmmac_vlan_ops dwxlgmac2_vlan_ops;
 
-u32 dwmac4_get_num_vlan(void __iomem *ioaddr);
+u32 stmmac_get_num_vlan(void __iomem *ioaddr);
 
 #endif /* __STMMAC_VLAN_H__ */
-- 
2.25.1


