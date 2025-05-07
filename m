Return-Path: <bpf+bounces-57630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C5AAD644
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613801B68BFC
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E463A2135B8;
	Wed,  7 May 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Lr8stW/l"
X-Original-To: bpf@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97F2116E7;
	Wed,  7 May 2025 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599936; cv=fail; b=CZcE0Kpc8BmLFTAX2rZaxN+oFgRgef+WTf/4pmX91XoYsfc/j5LhRbwCwj0PiaJ/qySnb8pyK0m6q3D/3uJLnXaX/RhAN8IXiAZv+B2LXMZl4zKsEV3PEB4nM2UniEHHzUOlDqx4OVf7ONyBaUjvm/Hid665TWFH02gU5cZmluE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599936; c=relaxed/simple;
	bh=a0L0PtEmWIJfiiYUMxVsqLrtmh1QAgjBAwTfrJR3UD4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nIc6WqeXzd8y6nVRJYSAK8aJSUCJXQ1TFKvD33e5l7rPF33vPpWnE/+nRwqPsK4XCFxmfKM8RxVboqVivx02vo5AB8KE0J1jEjbEwlnRtuzKuJkPUaUVXvsFHNJq+xUzpHg1VkjJzucYldknGyvze1sjFfjDd8bfywycugXFbv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Lr8stW/l; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rxjy9DU8dHrQuNYGc/dLZzKQSkyVeiVaLli1RUd7Y3XM6nV+7F7nCSBuzsRPJ7i+dQMUjJZjkuTe/miHE812hrULcF7CkW8r2LMk2JSepPGfdtfGU8ulIJCQvlnPqAaG2PXfeGRFyUMnjgFN7AORiO1S+x1kFdekvcS8m0qe1rO2iGTD+kMzT1ARdHF/2DVjM9juGMAzxOg0NuwflhVBubyFbfJ/rXDKnDCvmo5vr/0imuatEQ44qr06DAyaVDpURlQcV6UgWqvxlahMhW/GhSeudaSe7H2GomjTTLX8fmjc2A6JxElZuG9UyynBRTCPTXk5tXPaVga4AHjm2GEzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNxjzMym31Dkt5m0qKaKtv36Zob1B2C5xUffWxlYWqY=;
 b=jV3QO3W3h06+CvcKZ1UBpbW27pAmwduTlex9G1pNK8SkrpH2+AIdfMRVe2Tu8j01ZBnljv/73cRCbBCul5+jj+ktNWDKd0IJkKUPCnhG2zxdm5BB9Tae5ZqbmAERmMMTXNdeh9c6BcLot0ojK3ipu+0eBXJZbVUQMUIUVdU1fPJbaVSXPbw4/iqFN1z+zoob9MO9Js5nqe6AZjwgYX0AT6VabTET+Nhh+ol3JBrvFJweAq3QMoYOxbv23Q4KTqQsM6Tyc54dGi9ecLn+9bGezVeOCyF7cpBQSJyD7prmTYNT10xSEcK+c4dio8QvSVpmnHATyrO0rpxEUKWP9U6PlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNxjzMym31Dkt5m0qKaKtv36Zob1B2C5xUffWxlYWqY=;
 b=Lr8stW/lDkf1yUjkn2cFnL7AFLyY+lW9ulCgy7SFEaiX5duRhzK0IYrmO/slZqsf4QbNE/bP0F8UvbH4lmDGFoiF0qqDS1lJZudUSj2FphjcX2JGDNI3Pvp/HXQQxDV9rpq7vB6KdlcgzYk0GN+5ydLFs4zKqgFy+Mhi8YGL+FxX1orc0S7kNsv+7sRUeuxOb+mo7e5dxoKoGQTerpSpRTpQb+GcrigXoLlfcHxk7wvBH4pLv9LlZiO8txK41JoVDWi+g7J+ywWgj2xYe1LF1bxaQcVfMbFE/pphOyTKF7XAhRe1doTmK3+fKmrebMd0YsFFPjrMkJ+Irq0hm5FH+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by MN2PR03MB5088.namprd03.prod.outlook.com (2603:10b6:208:1b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 06:38:33 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 06:38:32 +0000
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
Subject: [PATCH net-next v5 0/3] Refactoring designware VLAN code. 
Date: Wed,  7 May 2025 14:38:09 +0800
Message-Id: <20250507063812.34000-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 1fa56f71-27e7-4af6-ca70-08dd8d31c923
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y+JW40tgzDps5bmw/z5X0DzqJfcULlrgvORutdLxOllnXFlJgvAEHxpiFZn1?=
 =?us-ascii?Q?5dgKVr1t+vN+2xK4upukVUJZbU2d6mG54GPuko659XscTO5mkDaduldyM5ta?=
 =?us-ascii?Q?MFAywO3ohbqo98SK37CFDOxLCviOREGyciX+KaBVAIutpvaPEnfPcUe+qKTS?=
 =?us-ascii?Q?CjO4e4DMncE4beQ3+SSvgK+1nNpwvysmNHcE/doAHfv2+pEHNFhjzOBCZHdD?=
 =?us-ascii?Q?XHaa52AOCp061mQiREhIhDYsyZfokG0zhq/ybkqjJ5RwCnD3WwBNhqDeTVY5?=
 =?us-ascii?Q?Fw4q/7/Qk8aFg8mVolBmWYMWA6u4VQtDuYJDPJ+KMDk7cMMDonwYQ7RnBUK1?=
 =?us-ascii?Q?PwkwkmLzdlVnzenTE/8dYdo7mvlQwrige0IrVQPx6xjeqRQ/xQp4d3ZohvDl?=
 =?us-ascii?Q?ZrIYM7ENcrNAg3eiB4Ty9yCcNyazJviq7Tiw4N0o27QOLlLe7vTZVh9ac/nb?=
 =?us-ascii?Q?oahZkCgUBpIGZJ63FvBMdj/FdATgJR4K0F48NNX/PtO6PtwN5Q5sxCGKNv++?=
 =?us-ascii?Q?TqoQY/YgEyH7iOo9Q8XLUq4wvkr/CVGoivypqBUwVNVgOkrtyMcR7diwmAes?=
 =?us-ascii?Q?AmIYJ6+f90cITHrVrU1fjjTSfN5ahgUpf57rA5v6F8mAFnvVkvTCmJum61Ld?=
 =?us-ascii?Q?tnV4qi6vBcqvjul5qwcQ8ZZP3PTfCkcFwNYzKotlRJ5kIHBT/5+iikVfeyWD?=
 =?us-ascii?Q?RNAW9Bw/RcGtA3MCBlfAFC9iSflF4VLHz38nx8bDjolpu8XzbNb/NxvWZUYE?=
 =?us-ascii?Q?n+OwEQkk9wtojLDlTAaXHhGx9m2zviEG4kbjTgTXTYusA3G6POuc/J/MEDh4?=
 =?us-ascii?Q?NsS2dekutFGk+WFqkNE2ZY3rgvzCdeKpf1w/JFxsZzzJAzm4K1Bj+nV723EY?=
 =?us-ascii?Q?WoHB19wUSoJPdPYvq1sNp6AuTbI9cWdbh0Oqib3pxXgzBOSWn9WhtEVpvlD1?=
 =?us-ascii?Q?IJyHgjq1Q4Smb6wqUuq/n984LxKF89+kKocwJuJode25HBeCdmg2SjYSw9R/?=
 =?us-ascii?Q?XXBYAtyeL2rXdI4GNsoJ79DCcgiWY/guQYaH7RwQcKmqqqC5HKksoUUNyLlB?=
 =?us-ascii?Q?PgoQDPhabcyGFUENe50Wp+oWqldTmGeheHQJgkzJLjS5bd47bKKm7SvShjX1?=
 =?us-ascii?Q?BRDy+jUdGEYyUon3QLWjRtRgFmTGxLW2dQw4nLxDoF41cs6qnwS0JZ3X/N76?=
 =?us-ascii?Q?xgH42TevFESZziLWyoFlPIj4Y4fbWV3nCm7TtMTk1Av9+Fgvw9Cyhp5uQWMG?=
 =?us-ascii?Q?FQePuxmJEabwv9ZaW8FaXlrOTbtJv226GLIy2OS6wZMHHmUAKn0K009nZUMw?=
 =?us-ascii?Q?A/I7jO+Xc5eD5XqYJAZUqtnVkUfBg3NaRlIAdaHVzpW5FrviCkAOP6g6YUVO?=
 =?us-ascii?Q?Oh2FuV8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VXeVpM8jq5nLjC4S3FCNEPUT1I4CHznFm78NzBYPHXhhrzf/+PrMmv7MUqwh?=
 =?us-ascii?Q?nRTyk56bihA7tDbosGVQVqcWLyurocUaEBYnDk1gHASo9zq7DBh3ndTQo9Dl?=
 =?us-ascii?Q?J61ZIELCAFQo/tq+F46aYgxIvX8qs0NttsY0BcHH3Ob9MuTQWi7L6LA3rlx1?=
 =?us-ascii?Q?fP+eK5zaGylo43CsAgd9rTC9Ps7dziX202bTkYDlv0wWdpkt/3oYUrONQqNA?=
 =?us-ascii?Q?F0boD3qvcF/MPIF7oq62pKEbz624IWpAl2xeBhD3zUnQKjpBmgP7BcTbNzMV?=
 =?us-ascii?Q?fUiLkV8SNAwN1//FqnSWVZjrK3pVsLCCfFA8OWFdgTJ7Qw6L8YejZMeRFMOY?=
 =?us-ascii?Q?A5G3PLAJvJaXHcLI82g41lHMVdKaaNk4ZVXIWQHVVXhbQGDPceKW4jSNzCtw?=
 =?us-ascii?Q?5YM781XHWd9TtAhTvYbVjwDczzLZ2Aek+kVrMdV1P4755BAdiked4ljUaX6E?=
 =?us-ascii?Q?zUtMbJPjVveyY6508r584Dd/9okTsdDE3sPGTHeFt3i3kpMnthvT6MRk34KN?=
 =?us-ascii?Q?kuWsb+ZuclgmgYNjTTv+f0LRKFGOop+2Ecjmj5lGP/oxcFYRFnoeNQ8LEB2p?=
 =?us-ascii?Q?JdO11Rjz+ocSAM0E0ryvBPkP096F7FFwkphTqD/lE8aCs++kRnESmv87RjRm?=
 =?us-ascii?Q?7NmgfT84MjjQ4noyqYdBsKDHOHvVfIw6sXYLUshOXquWkWGeiHMxfPG/wuEZ?=
 =?us-ascii?Q?vW0NbhFpkgpinDEkT6C5T0zpMcyZ7Er1zB/4mpQEgx/yXSriQylTKZBQ5n1j?=
 =?us-ascii?Q?kXuVlUQS2su74Ed55BY6qptfYCEfP229lhXGHsc7cvgwNPtdtooM9Wl4YnnG?=
 =?us-ascii?Q?A9ZYNo7vhH08G6BnmaRK2zLlw384V3C7UWS9/sB4NiGf/JKiZ5SJ6fV1daaR?=
 =?us-ascii?Q?YrV4kMifAR77jASAgpd1AoebGnkxtXvBx2irQL3sCxdPvIRadKR9+bBlCIlL?=
 =?us-ascii?Q?b3m/u2K/Qub6vmt56bMjXlVta4IK66FzfY2oNQWFk6b5HnLo0+NK0Po+vtoK?=
 =?us-ascii?Q?wopqr+CUT5kz7tRIvV3GMKG51c3Cts1XfmnxNRnG84Ux/X4v+zAvSAH0LliM?=
 =?us-ascii?Q?P3nhjBlMKi+jly09CKpZOWhsffudvQo5sTo6SvvKGDicl9XfQ7llwTsH3com?=
 =?us-ascii?Q?oGJ5aRjNEMZG40N5gyW5vAHiQU+zdIGknFlAowTEZuKLUeLVGYs0FQAEuyyk?=
 =?us-ascii?Q?dDiXV0Mnj+ol+bE4WzNsvfqe6YYEXmxZPzIllmmaQ8AABpqRF0wsFTBpqbtG?=
 =?us-ascii?Q?BUyhWp9s7qlGBZ/O8Tpj1AO2fzu5MQd900s3FOlDJR73WmfkIN2LREKs4xaq?=
 =?us-ascii?Q?OEBhaXFx/4lkF9wXfYSTVVwQ0zCgyc01k5rF55v+JtYJ+CQBXhEC36+UOAqs?=
 =?us-ascii?Q?xNEPNHYfIeMDbEMnW/ILsYZTkL7mJ3T2YbdvIZJ80ssy8Jk5O1c5NJkHEsaj?=
 =?us-ascii?Q?4GfbhS7BuAHyl859L8RdJTc7s8kzgmlcebV2QI/gmuifUz+CyveZ41QwM0i+?=
 =?us-ascii?Q?iGlVtAD2Y15EsMwn0xdxIa+X/lR/dqlzife6aIYgSwkBiwWOEkHe+C9MIwaS?=
 =?us-ascii?Q?ETXSoBrMtRdQdUcAWvnLkY0hRmkkpPC1vAqJqwxCIcISd+rsjU9QV48yB3ZP?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa56f71-27e7-4af6-ca70-08dd8d31c923
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 06:38:32.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImrEv9ujmNZY/JgrMxGit2OSgHq7UIThP8I3AOXTcvTOF+tS4pFxDUfwn6gkvwtGXLcaxRjfYlQ/mDyNdyftlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5088

Refactoring designware VLAN code and introducing support for
hardware-accelerated VLAN stripping for dwxgmac2 IP,
the current patch set consists of two key changes:

1) Refactoring VLAN Functions:
The first change involves moving common VLAN-related functions
of the DesignWare Ethernet MAC into a dedicated file, stmmac_vlan.c.
This refactoring aims to improve code organization and maintainability
by centralizing VLAN handling logic.

2) Renaming all the functions, symbols and macro into more
generic name and consolidate the same function pointer into one.

3) Enabling VLAN for 10G Ethernet MAC IP:
The second change enables VLAN support specifically
for the 10G Ethernet MAC IP. This enhancement leverages
the hardware capabilities of the to perform VLAN stripping,

Changes from previous submmited patches.
v5:
a) Divided the refactor patch in to two patches,
first patch is to move the code into the separate file
and second patch to update the symbol name

b) get the dwmac4 vlan function up to date and port to
stmmac_vlan.c

c) remove the inline function in function pointer and
use only static function defeination.

d) Remove the outer parenthese that is not needed
on the 1 line return statement.

v4:
a) Updated the commit message to explain the descriptors
behaviour on different hardware.

b) Updated the perfect_match variable with the correct
byte order.
Link: https://lore.kernel.org/lkml/
20250421162930.10237-1-boon.khai.ng@altera.com/

v3:
Seperating the VLAN functionality into common code:
Link: https://lore.kernel.org/lkml/
20250408081354.25881-1-boon.khai.ng@altera.com

v2:
The hardware VLAN enablement switch was detached from the
device tree source (DTS). Instead, the hardware VLAN enablement
is now dynamically determined in stmmac_main.c based on the
currently running IP.
Link: https://lore.kernel.org/lkml/BL3PR11MB5748AC693D9D61FB56DB7313C1F32
@BL3PR11MB5748.namprd11.prod.outlook.com/

v1:
The initial submission introduced hardware VLAN support for the
10G Ethernet MAC IP.
Link: https://lore.kernel.org/netdev/DM8PR11MB5751E5388AEFCFB80BCB483FC13FA
@DM8PR11MB5751.namprd11.prod.outlook.com/

Boon Khai Ng (3):
  net: stmmac: Refactor VLAN implementation
  net: stmmac: stmmac_vlan: rename VLAN functions and symbol to generic
    symbol.
  net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  40 --
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 295 +-------------
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  25 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  89 +----
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  18 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   9 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  62 +--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 374 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.h |  64 +++
 12 files changed, 517 insertions(+), 464 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h

-- 
2.25.1


