Return-Path: <bpf+bounces-56314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA21A95406
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 18:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FD016F9F4
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA21E0DE4;
	Mon, 21 Apr 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="BGUQecGR"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936D2F3E;
	Mon, 21 Apr 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252990; cv=fail; b=JUdwk8koM2S6jkghjK/8jtzLrIDjxefjWIz8h9d/Pamm6QBFQ4lBd3E9MxMw48Mwxpqf+LzWlosUKMNNdDdnwvE2rkzd76uWkgMrrs+tZmcZ/dOHkEQC+2wCn4ag95dFK1SJB8cn70VgqXzOJCJpcoguRORFPbnpxKEV+vzWfqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252990; c=relaxed/simple;
	bh=vleF8E3hielBKKGuv/nTkoLWxwzW113bRORfDOSHwww=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iIZQcsBzpJkWxAoUgn+u5qm8QVYAaVC7WtR18cClwG3AcMNJcqFaCSZ34wJrhSriH8KpZE3SgQBXMDsikXDD8igiJwL1eqZyXgj1ERwxueMA0jgIsvuJA0IuxCiicp5iZ8hmPajK4uQ4vpQ8YRQ9A78mM8twKP2ldOo3V2AE3Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=BGUQecGR; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEpuMdAWrAPqjXO0wwlhWE0cAZj2kNau1D4c4aTcl6wAe2KFklmvMSDyCvPv2N+32OQtiOEG0fhMa2nUkWCesp1NRjPC+scItA8XtRGXHnmpRcH4TzPFbADvBQSeWquq9p/X1y/URqsaAoh3Gld6aYFhtL5jWM3YEP4V60tA3XYxXnAQKXCkPJT1XuDjXLyvI45Sr0f9cNDvrXXGmuFaY9lKgUtaD8l3IoRSqME9kybU7pAkfpjziweECe6CpVaGlWtTpYdm8kb9I/J1th5BV4IoqMYQgxXs0E06tCNBySs2dbUlmZyxtcKVD/tjCvQZlEarNrilNm4PNgDVmkhCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euFQnk2xA2QdcHwjlxsa0gqqKR9p2sd9USMrY2Y2KlM=;
 b=SjHxyM5g6fDbDcrqsMqqOVVIvfjl4bUxvpR4Ui2MvhA7aBx/ckcBpxIL4aQsJh9FQXdIyD2OCYDG7ILQu8BhPdrk//EJoRtbonR+uNhJy7jsIjylS2poFAvOPEQGPJC7tM8+5FYX7aXG2Kyn0Wq/3JBQl+WeRa+tOL5zX2GgUUySwiavv+QZzD56WhLTvWqjEUC8C9qF5XqUXvCCdbtykodj/ntk8YccTqC85CE2qsoI9MIvTbZB/2JLRzBup2qCGmwXLcSoiLCD6AbyLPbzAQPZ4K+rAEm7pt5QUid5+MkkYaVNwooPtV4Hg7RL0B5aWEf1wEEf4R0oZeS0zl90SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euFQnk2xA2QdcHwjlxsa0gqqKR9p2sd9USMrY2Y2KlM=;
 b=BGUQecGRxubrgH5W5a+gsLcqmyEaXdnm6nmyfjwAWtGb6MvI8SRGzHdvJb3/O2dVoDTJ0DBiDLcIZ8LbOFA8IWcKGZzUBmQIS5aMHo/VdyJKsrv1XsMV7ui1A9cdhI/91+Ms1YP5fePJkQdYP9UrtVw64imWTf0pks+04IG2jleXT6k9ZMpsvzRXQEjvlmbGJjZUZw8qqK7p3gTwr4a/mpbBSzJEjJ3IIQCHfxizD8F6DqMK/MdYJ/xBvEWKBObMzNN2+ScCh5jBewS8dYqZliDUj5twHGOp1ylFAzX4ze0w6T9eCC0G3lkjBPqJMaSxNDo55VHwKj0tzU+bqizaYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by DM4PR03MB6109.namprd03.prod.outlook.com (2603:10b6:5:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 21 Apr
 2025 16:29:46 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 16:29:46 +0000
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
Subject: [PATCH net-next v4 0/2] Refactoring designware VLAN code. 
Date: Tue, 22 Apr 2025 00:29:28 +0800
Message-Id: <20250421162930.10237-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|DM4PR03MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddc0d57-7467-49d3-015b-08dd80f1b9da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9VP3jT8EYiTDJ51OK1Xa14nTFca+Y04nrHCGBjf9qiWwfKwICkLBSyi+pwL?=
 =?us-ascii?Q?P8T5ebB2v+ui2TW4nsd90Ms3YwvGKMpgy4Z2WqqjOSfqe1snxvgnPgJi4cVi?=
 =?us-ascii?Q?TuyldvyHBRzD4TNHpmD2PwKfbWxLLmFJ8eT4HzOXz5xoGz9QGBXyWxgoEuKi?=
 =?us-ascii?Q?phkAZyeefYKgU1Xi07APDJ+5yRO9F15rSN3EtptJaKqtuU2XUllV75rUXlW/?=
 =?us-ascii?Q?qM8EN3Bu6BDDffFDka/qeqB1AF1ev+Wu1kszhlSklPkb7BvrubJ2fqKZvUhw?=
 =?us-ascii?Q?e+CE9uflRSw0Ntp5PqArojzjPpnMi4JFSauoY0qhAHjv0ws1IRwxZHbs0/1z?=
 =?us-ascii?Q?p52Fxb3G5lhz+byRjgzULzNts4pNMxgWg8FeTynTBuPUoiTPiQfr7ayOZMsq?=
 =?us-ascii?Q?c6KVJjcmOEHKup9ZiNOpZJYfP2nz/+tzjSgo9fnouZzugbpgxvYeDVmBnfH1?=
 =?us-ascii?Q?tQTgCzkDAQB8JyxWX1g8a0lu8+UghoX6FrdBe43PMjXmDJ7KwUGf+mWIfIZI?=
 =?us-ascii?Q?EpXTcw/KkizZaYI5DRObMX3cgeRSkbbySooC9SdO8vLZ/n0JnDMt2lH4P/MT?=
 =?us-ascii?Q?4wOcG5N0ZGR7woJvaOz1CVkQXi0GyztlE5gT2jU6M50Pc5uIPgO5felP8voG?=
 =?us-ascii?Q?o2vBuJxD6TzBXqA6aIRcPDBW7LfkE0gICIAizkHsfY/A2+I8fAQeCSkqU1xo?=
 =?us-ascii?Q?3vIe2LO/PTOvThXugp9pgI7TPfSOQINUj4YeJWktPF7MS5ezlxGFpCn9rIhf?=
 =?us-ascii?Q?zh/j1F1SxhiSZCs+d5ydBIUIos2LAd9Y5P+t+wgYZYSMQ6vh5EfyeUyMd+b3?=
 =?us-ascii?Q?lkOi8woyG9/IEdkKVierIcQiYa1raoFhTdASHLnnvb2xK9ZfdBiV+oqIhb16?=
 =?us-ascii?Q?WpD5K/eTACIYkIY4JKoxdQ1B+OhmIy84uhHLXnswEgKok+BqmzzvFe0dCgyG?=
 =?us-ascii?Q?GpE0mCrIK21dct8wV1x9NSxjBzw8qlABgcO9PfBwEqWLx3fvZI7mtPfOJGR3?=
 =?us-ascii?Q?FVKI6CdGJ4xpyeUFxKiqA4rrgyZexk2E3XbVQBMMYouRVXBLbeS4rpyWeZro?=
 =?us-ascii?Q?hRMxxODu9TpuW3IOoGqG7p9PJK4YknG5ZVRUAO/isM1YLGmAFYtdO7azCgXG?=
 =?us-ascii?Q?9HE4fY+s4u6gErBq1wn++sW+rC0517NBziS9lfTtHKRKCWz3MQs1WPfBXCI2?=
 =?us-ascii?Q?E24QNJEgqx1fzjfkkx8yFWkW51XbkomH7r6cfWyRm26CGV6Nw2Z12S+lxmso?=
 =?us-ascii?Q?Dy4otgpDX09tS/K/1slQhtDpj/qnrt48NiwbQ0qUA0xEKPHkbcAz1ogR8up9?=
 =?us-ascii?Q?wJbymwmu/c/vkdKJn+FSMxtMO5+Bz+FQfiI+Q5RmWnO8TXRLbOmpFo8swbOy?=
 =?us-ascii?Q?l1vn0Ac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pT/zPhqIDMqQAbQmDDmlfrNlWTJ7+W7Rftgc92vOYSFSC7rd/dczdOZ4jSHJ?=
 =?us-ascii?Q?nsvhfNBDKUSUBhOUsl+w4Vr/MA5oZxP8CgNj77+b7JPSA5aX7PoltdZKRhsw?=
 =?us-ascii?Q?RnI8tWuLrKvamoLHvR7MGkdatNe+7nqSC+Sfzh9vS0jwgtmXtT8ajqx0wXlk?=
 =?us-ascii?Q?17q7TNI2Kyof7yLxRou/yl9y9aCaRS85oRrw5XBCfUWgxn1fJXN4PXY7tu+7?=
 =?us-ascii?Q?nplk/9SqZBQNM41kJQuj0rP1yVONUgXkVIWBOkEDA2o6H1LzFv1YeajewEn8?=
 =?us-ascii?Q?ojLwT7q/zI/4iMLPZA7S9YN83ZpLmgfFDabG1TcF2+X8DVS+E/r20s/kMmZR?=
 =?us-ascii?Q?iYIXgviNUrtDOtbne2tBCLJILbU0Zvb8j41RS3B9DOgHxrTXzF9CK7eyTpl0?=
 =?us-ascii?Q?oWYNjTJASbxB3TlH1JFA11HdFys/EMFsYziMaUSAebmasZL/D8RDAOuaDEQQ?=
 =?us-ascii?Q?74i2N8zNj1palWAQV1WQZ0AkSORQ+H8Hf9+lmi0kUT3km3c8ERlCnmxfaHse?=
 =?us-ascii?Q?tThrihF5KrB4Wv4/xRgutmn/CHOqqDL+mpzQOnFbIqHx4WZ5DbRf9NwKbydS?=
 =?us-ascii?Q?SEqVjbJqIOhBxKMd3VwiwYTtEBELOr2OS3102fzdWzuuXjCe9SOJypV+4dbt?=
 =?us-ascii?Q?q+CDuhgbUTyCWUqzMlurtRw55Coxhg9UtPCtnRKHzafpaAqBdHuH9wES5xQJ?=
 =?us-ascii?Q?1JMCR+sTTmB6X6PBhcsrGTMD7MU4d8q+9sS0oLga4LO2inic5YciLPccTm2x?=
 =?us-ascii?Q?dfU1Ct8dOmaXv3ljwIe7bAQY9drJZN0EDUm3jIkuSI1M5Dz4OVfM0G1Lm4Pn?=
 =?us-ascii?Q?+dSW93Ebxqsfaiobc+C9nF3PjCNk7ohWYoDLoy5cZuv3O3WB8NMCbBWKZou/?=
 =?us-ascii?Q?R+cA0lhY7Fs4Y/lnyb6PgEndiommZuA4vjTdWX3tl6HLYx7twDyFVLBvMXfV?=
 =?us-ascii?Q?4NhYILllrsCRoBE3umzeczu437AgefhQpOrewHHRC7K2xwGopPHL92LOabV0?=
 =?us-ascii?Q?fnl2XrVfIlHG5TlRbDUDvlY8+mPAKa5psHK1FVhvIblgSBPMdBoOrGA8m27H?=
 =?us-ascii?Q?bZ0TMZv6qniDVgQOOn3k4drH/jb3x5G7kYOwTlIOMKUXZKQKT4uxQBEOIdxQ?=
 =?us-ascii?Q?xhyMnT7tbFtt0z6gr49dwAG2UHtR04vCTC/HAH0qx3+43yUc0sCe3Q8HLr6U?=
 =?us-ascii?Q?SjeJmSgAlPChwnyarXOiiZCSeH4hMG2aKTkue7ncfOhuT3plcFOLLOu44rU5?=
 =?us-ascii?Q?1faYm7T4h7DooudWYUhsAkbXVwBan9omR94ve36LxgEVwS2F91POWXNwXBho?=
 =?us-ascii?Q?YF9+r76Mvwg410eovXYHt6PiQMi2RKKOuNmM6JD5Kz8wu2CFi8mDcKsp1OXJ?=
 =?us-ascii?Q?tLszkrtuxKeFVbMKygltXJ3OLdOIYo9LOeP9mzTmMQ1ahCG363CneNmAdsaX?=
 =?us-ascii?Q?DV/oP1g2yJKGDUWsCgygYZuePmONyzEbvS+p7iv5hHDPmcysYhcTBfjHf893?=
 =?us-ascii?Q?vwUsbLN4AKRNOnjHexWWBJa3CyBK2UdVMVCBrQLc0c+R2c+szQbvQyHhtKlF?=
 =?us-ascii?Q?b49LV5WDKwS+HUNHOZJ3wVEPVeqRrQPT/hWxkQCh?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddc0d57-7467-49d3-015b-08dd80f1b9da
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 16:29:45.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUIUqAU3AcpABY//4z1UbIJQPeJFaYG10IGS6UKaUHnVr9xpBk0qCRTjqlRVyaApba4tvwc4zwg/gj1zB842Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6109

Refactoring designware VLAN code and introducing support for
hardware-accelerated VLAN stripping for dwxgmac2 IP,
the current patch set consists of two key changes:

1) Refactoring VLAN Functions:
The first change involves moving common VLAN-related functions
of the DesignWare Ethernet MAC into a dedicated file, stmmac_vlan.c.
This refactoring aims to improve code organization and maintainability
by centralizing VLAN handling logic.

2) Enabling VLAN for 10G Ethernet MAC IP:
The second change enables VLAN support specifically
for the 10G Ethernet MAC IP. This enhancement leverages
the hardware capabilities of the to perform VLAN stripping,

Changes from previous submmited patches.
v4:
a) Updated the commit message to explain the descriptors
behaviour on different hardware.

b) Updated the perfect_match variable with the correct
byte order.

v3:
Seperating the VLAN functionality into common code:
https://lore.kernel.org/lkml/
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

Boon Khai Ng (2):
  net: stmmac: Refactor VLAN implementation
  net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  40 ---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 295 +-----------------
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  25 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  89 +-----
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  18 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  61 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 294 +++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.h |  63 ++++
 12 files changed, 434 insertions(+), 464 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h

-- 
2.25.1


