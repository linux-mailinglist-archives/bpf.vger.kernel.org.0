Return-Path: <bpf+bounces-57957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 298CBAB202F
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 01:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25E3984DEA
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E9F264627;
	Fri,  9 May 2025 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bHQzl/Hv"
X-Original-To: bpf@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022118.outbound.protection.outlook.com [40.107.200.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666421CA16;
	Fri,  9 May 2025 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746832619; cv=fail; b=g+r+acJuCR31vX2ISyhgFW5CzPvqYb0OY2xiLp0wropPSjSl8kmCd7nuH2RECEqBL2cLibpjWDKZamoOzpatVq+45Agr8Hibp3pbQKjLf/GeWS7ITu2t1JS3CWC0cs6lIUaobHxQFn+/1xY/G4vEIp+bn7LwLP+iDDcSYyQR7Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746832619; c=relaxed/simple;
	bh=6mUjM5UUjbnqoorvjMLSPHSV3sBNSgZWJSV4cMQfMTc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Xwh5mcnW8cyMbX7fDM5aFLIRryBx69Oon/2Pg+KD+hx7H3Dz0Xg1gJhtGplQWwQFBv67rM8bEUBU5quCH/jFuuveqmWFvP6GyvJnHtPJfKfKJ+si2u/kOe24z/FQymQu0ZOsKFVrFzAITQvgwsq3cRcQ1VMXCGAWz7AAhVewVVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bHQzl/Hv; arc=fail smtp.client-ip=40.107.200.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab91HxN6ivLyTxKwDsRjN+v3puAdMvHfKu7Yv09F+kgdeFjQ6Q9ARvHH1hrWK9IVcZutBNeaENrcuj+h/DcYpeS0yURfn2HchfZJQvPfdb9rlhGzqyuEcb2+f2yvCpbdP3t5vrBQ0QWeRFu/XjyhwKyAHlaCJjKqKfh6vltlTkGMWy+7wWegVO0D8tffJcRpnWAgoMnOIdDZ4ILv4HFnkFiRy0lhqXEqTS/gb4CLjiTGE0AOG697sqvLPENe8V8jVvPtnlVKCyaxbRoWmArVVEZzI5KMBVmRNYsO0eF2h3GHfGm4wksfqAQY9yyIEOznCONfbhV7nMIHZgmcmvp9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arHAuQwpVRYFSw9NtPZBF37vWGUSUTlok9w21J12c/4=;
 b=yr+YQB4FwUGJhZY0hCEL6MQ9HEH53Qn1uFZ9s2wgmAU7u4B2VHNEzKrmG/9jnKu+M1q+zStekNPVDA1SkMP1yVU2+2mC9jh8GqCKGm8dpVoGQlTqJSjcrPbbAD0C3xevqyy1dE1rcjZydkp9lT7jnlAhqNJWUqRtWDYYIvIJAUd7BpT682qKEo74y3zQe83l06XScd4CwMLWmjnSiQeNEARbqm+KhyS2Evnbad242TVq8Q8kDA3pmQ3gr/N/QGt+x95SdkLFxly3AxC2lYZoF3LTbOJXMXz9Tbln49YzS84IM5cfNaJ91wlQtK6OxRL/yGEh4Zr+Nu4IuaDL+8JioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arHAuQwpVRYFSw9NtPZBF37vWGUSUTlok9w21J12c/4=;
 b=bHQzl/HvN3iXOO7GHqHZgdwVQzSJanmX4nxOdadwrxyKlit3YmIotgf7ufNyDQVtQFlLOtscRZlT2tEE5cvmjTUlO6i3lCKhh3dwriaSppBWnhc0Qiz2y+AhfnvOxiqd0PQfIJk+xs6ESGphe6BBh1iKijiOsYrkS413D+9ELr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SJ0PR21MB2069.namprd21.prod.outlook.com (2603:10b6:a03:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Fri, 9 May
 2025 23:16:54 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%7]) with mapi id 15.20.8722.018; Fri, 9 May 2025
 23:16:53 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v2] net: mana: Add handler for hardware servicing events
Date: Fri,  9 May 2025 16:16:43 -0700
Message-Id: <1746832603-4340-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ0PR21MB2069:EE_
X-MS-Office365-Filtering-Correlation-Id: 1147d8a4-bb2b-49df-15c7-08dd8f4f95dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCOD8oMefpnh30BRg9RlCFtFpQ/sXDHV3XquJdRR2HlnprwEwxUSGmFdUIFv?=
 =?us-ascii?Q?+GT0zzi66fwVmLkhS82jveEBdmByxx1OP/lBXNjQzWXNDpFjbfPmQPKgWGIJ?=
 =?us-ascii?Q?6ibAydUsNg0mElbAiveNVmmt0/cPNXehNoT+pTc0yGPAll5MqKjZPO8cgeIp?=
 =?us-ascii?Q?a5yaeE0p+FycxADYw199Swbeb+iuzEKabrrnly+0gjZ6yrxQbf5CsVVM/Roo?=
 =?us-ascii?Q?nP2TTJnolk9UUloU4T9nUjzhAg91S9nUMW0rQUdqTR+E62INkemxejJa9ZLH?=
 =?us-ascii?Q?7by77gGQeU+CHi9spMfjA3RRIqKAVKkJxOmltw0m8fagY589dCSACmTqZveR?=
 =?us-ascii?Q?j1N9WnWy0F8d16Fo97PEzj0TZBRaqC4px+uKbBCDMCVZbeQNGaQgngKpZIEL?=
 =?us-ascii?Q?D+bbTqlBEBMp/FmiiWEoTj8FnGqJa0o6zi6dBUHNtXKr12zabIX1dvMnt4kE?=
 =?us-ascii?Q?Fax7tbQQZyh8A5KKpXpst3Kw0MVFe7Hz0c6k68nZ3X9ucMaD36f+gBVA1XpP?=
 =?us-ascii?Q?stpABisE+eSXWC20khpPU14V2vTxdj6a67R6eZ0V/uMjXzDv2Dtp7pHkks91?=
 =?us-ascii?Q?jPnW1V/W6Nr6tz19Cy3J0zC6c6xqlJeBFDYLSswHxjz0o2hx8u9j2Q0W6an2?=
 =?us-ascii?Q?r8oYNKPI0CgXHT+llvVfjAdAm+M/YsvQZ3GW6rXip4QIpMNqYZigxu0Bu4Bw?=
 =?us-ascii?Q?FGI1Nc7xMQQ1UDoeyX44sHxiTm4niD3KMmjOynkJiSWyOyaZUbzx3bdrHrYp?=
 =?us-ascii?Q?6A5fOm34/xSGgel8A8BbJSZOtCezMwMpzZkj6r15uHSFXTpkLzPpsJk4T070?=
 =?us-ascii?Q?xDSxVnhGgAHmJxCguds7dJLQKDIxbwbMUg5JohWZsFCF1ZZHxSXcnS3tcmyr?=
 =?us-ascii?Q?ODnDkh2Nhs2PNXP4h2Fxe74bih+Kxjv+Plzp+TTQVhWdAVKs5PFU9bKwZ53x?=
 =?us-ascii?Q?L5n+MK4Fad/i/twd8w/UmVqaW7VWmH1/gtAh09MMKtRDcCiblx9N3OdoFQrd?=
 =?us-ascii?Q?spmwZbGd0vdJhuBKmB2XqxQvOBNI5yH/SCB6YxTrTAYmumeVz+9w90tkGNzQ?=
 =?us-ascii?Q?Hft9IJXhhpFwHZlX6U+6bzR/VMhKKyf+13/EjHhedyFPDQhA82w+OMQkx1Kc?=
 =?us-ascii?Q?FwiN14pXTOX9SioI3cXbqMB+uY7jdu5pgIYLAESe1Irf4hlbXpP9LYfwxJ2C?=
 =?us-ascii?Q?WE0NQqt127BRXtXi4E2cx3MzKb8n1sD8tGIMYGc0xZKRrvXH48VD24THYXJr?=
 =?us-ascii?Q?NehmBCYT19Uk2QWawbg6dXHlP4XyqysYuOTfOLaExHOMU1qgvHtU3xUEMBC6?=
 =?us-ascii?Q?K+7Z/N3YqxMWiKm28iDeyI17Pz29XEm7HwmSvnRryrS2qb9AxzzvLuyko7yb?=
 =?us-ascii?Q?YkAybkhvqSXBTPy2SviBgi+po4TQDHGOFdvMZvlkCq6lrK7G+JBZvEuKSDmH?=
 =?us-ascii?Q?egeDiiPKUn+Hoe12Atm6s6dw4GJt/NJGAZdi23eVj8VkIyENhoSkdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ViCjiSyyZPcLAfjgLs0BC4I0NQ4vV7gcNld+6LB/r3NDdtf2O9d3C0thwx+J?=
 =?us-ascii?Q?XjZcCfgNVgeGBix+yGngkQCWAryleTqW3vbf4qHSK0vf8lM3M/PKYLrB+M9O?=
 =?us-ascii?Q?Mf+aM1itGSi6pKQxv7pxdlC4Le0eGVaWk7e4bgZiek52GJ12xnt1ATJmd3fb?=
 =?us-ascii?Q?6UAsVp69m1+gJzC2GCtm2ovfkoGUy/lyN1+uu/WGRGT6MRl6b5QP4Wjelf00?=
 =?us-ascii?Q?m2LDj5Z+dc3nD65myHhako97n0pFPV73vnO6SAkD8WLc+KESjXwAx8Cpf9u3?=
 =?us-ascii?Q?lZtGpQuGqI0JmRVP14K3YypnY83TSv5dN78EUsT6xboPHD11HLXNdtbu6zeS?=
 =?us-ascii?Q?aBQsTO90GDhN3/ptJiLQkPFkIMbNgSE68UZq2fqrpf6Nj+UEgQ4I9wEzykGu?=
 =?us-ascii?Q?xkKeas0GlUctlkx4FmxyHVgaI3F8UdYIFaQ9b0fDYXThMAt12bm9RC7VD4g6?=
 =?us-ascii?Q?IcoWc70EjcU1I/AD9W/sHK1AbaZ+nFVVtO21BSwIF5/LAu1zJptNc5fen83e?=
 =?us-ascii?Q?N+knlWS5U+BuASjI4+G+VOuIjM8SqKKHxpoI7ZAkDQoJysiXBvCOChHp0M9I?=
 =?us-ascii?Q?1v6kngnoi6YY6Rmc7da5gzXj8KntzFAHX/S+8mewCYhu1jInB5LBUOfjZ75z?=
 =?us-ascii?Q?iI/28KV35im063+oiE31cYwLNqumLwoFCTQg2swowMDQBj/KbXHka/9itZFg?=
 =?us-ascii?Q?4BrhwVbToZMpaElc28ZW+vcsCtEBnsg0ZS6CJxOdWLibXZM0AXu+B5gbUNuv?=
 =?us-ascii?Q?zCOlcN2aBKPA07Swv/5Dbcj5woTMXAVqT0B22jzuiCMoCAP8guefI8v3A+ux?=
 =?us-ascii?Q?QGc5nxRuk8LH9oOYGXC1BfjqCsLNCNjPAWz4Pbcc/7mFjizrGfVJYgQuDQ5x?=
 =?us-ascii?Q?Pl8wKSFzqZNm4TcbjZhv7K7LVS1p1GM2Ioj/h+jgI5ZTkVVDjZPDIsPI8+/X?=
 =?us-ascii?Q?cggo6NXkwaR7Fj20aLxwgVCbLHM+IYGP+AhZO27cndCp4JdUMH6lWtQ8Ql/n?=
 =?us-ascii?Q?aVKcXQ8K9IrgsZDSICnecYhI8j0+n5NxE09wHb8pqzmFkcD3ORwPmINCj39B?=
 =?us-ascii?Q?xSLnUEcbsbVT5OEuE/CAOii677gcM9o0+SW/zdH6y1rh35htfBMHdWXH/I4e?=
 =?us-ascii?Q?g6EkHwe76Al2J3WBvuQkSmyZw0M/wVLDrhBsJhYCf9QZMaEKJc9/hspFhhG5?=
 =?us-ascii?Q?2dIBSBtTGiMNzGq9hDSW1/zwMdgpJGZcEQYwTcPeFLcCpEiCV4BC7P3GijYe?=
 =?us-ascii?Q?2pbmhEHRlYYmzCKEPJXjr8DfCil70tq4xtXGExHbcOJftGYeYRTHH9NN+6SP?=
 =?us-ascii?Q?JH8ULYwnV2f6qeK3IVkeyctFCjtQkkrA3G8pejN21rBnrX6v3HN6GE0Rg8yv?=
 =?us-ascii?Q?yVan52JTaiC9O+ahnR0RI83uIvNUVnJpQEAIGQs6RaOzzyQgqQL2jI54jGHL?=
 =?us-ascii?Q?JhU1isX7/Q3stvqI0Py0doyacTE+2xz2zQ1+o9lEyYABVUf0E9f3z3bpTTyg?=
 =?us-ascii?Q?CaOuIhE/HIH2EqVhowU/9T4V6GtYUtpczZnamf688tw74dgItRS6x2OyKPE4?=
 =?us-ascii?Q?fxkApwi28kSVmQG1yAXwDImOFyGNEBeQ1o1fcv08?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1147d8a4-bb2b-49df-15c7-08dd8f4f95dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 23:16:53.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4MCVWOFdv9gAQzId1UZVTepbqxGnVyAkVuIfr8kFKeUR9nA5lGegCvduCMxng32XH8VzkvD8va3znX5mMjouA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2069

To collaborate with hardware servicing events, upon receiving the special
EQE notification from the HW channel, remove the devices on this bus.
Then, after a waiting period based on the device specs, rescan the parent
bus to recover the devices.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v2: 
Added dev_dbg for service type as suggested by Shradha Gupta.
Added driver cap bit.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 63 +++++++++++++++++++
 include/net/mana/gdma.h                       | 11 +++-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4ffaf7588885..cf82c9a36c8e 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -352,11 +352,52 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
 }
 EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
 
+#define MANA_SERVICE_PERIOD 10
+
+struct mana_serv_work {
+	struct work_struct serv_work;
+	struct pci_dev *pdev;
+};
+
+static void mana_serv_func(struct work_struct *w)
+{
+	struct mana_serv_work *mns_wk = container_of(w, struct mana_serv_work, serv_work);
+	struct pci_dev *pdev = mns_wk->pdev;
+	struct pci_bus *bus, *parent;
+
+	if (!pdev)
+		goto out;
+
+	bus = pdev->bus;
+	if (!bus) {
+		dev_err(&pdev->dev, "MANA service: no bus\n");
+		goto out;
+	}
+
+	parent = bus->parent;
+	if (!parent) {
+		dev_err(&pdev->dev, "MANA service: no parent bus\n");
+		goto out;
+	}
+
+	pci_stop_and_remove_bus_device_locked(bus->self);
+
+	msleep(MANA_SERVICE_PERIOD * 1000);
+
+	pci_lock_rescan_remove();
+	pci_rescan_bus(parent);
+	pci_unlock_rescan_remove();
+
+out:
+	kfree(mns_wk);
+}
+
 static void mana_gd_process_eqe(struct gdma_queue *eq)
 {
 	u32 head = eq->head % (eq->queue_size / GDMA_EQE_SIZE);
 	struct gdma_context *gc = eq->gdma_dev->gdma_context;
 	struct gdma_eqe *eq_eqe_ptr = eq->queue_mem_ptr;
+	struct mana_serv_work *mns_wk;
 	union gdma_eqe_info eqe_info;
 	enum gdma_eqe_type type;
 	struct gdma_event event;
@@ -400,6 +441,28 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		eq->eq.callback(eq->eq.context, eq, &event);
 		break;
 
+	case GDMA_EQE_HWC_FPGA_RECONFIG:
+	case GDMA_EQE_HWC_SOCMANA_CRASH:
+		dev_dbg(gc->dev, "Recv MANA service type:%d\n", type);
+
+		if (gc->in_service) {
+			dev_info(gc->dev, "Already in service\n");
+			break;
+		}
+
+		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
+		if (!mns_wk) {
+			dev_err(gc->dev, "Fail to alloc mana_serv_work\n");
+			break;
+		}
+
+		dev_info(gc->dev, "Start MANA service type:%d\n", type);
+		gc->in_service = true;
+		mns_wk->pdev = to_pci_dev(gc->dev);
+		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
+		schedule_work(&mns_wk->serv_work);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 228603bf03f2..d0fbc9c64cc8 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -58,8 +58,9 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
 	GDMA_EQE_HWC_INIT_DATA		= 130,
 	GDMA_EQE_HWC_INIT_DONE		= 131,
-	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
+	GDMA_EQE_HWC_FPGA_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
+	GDMA_EQE_HWC_SOCMANA_CRASH	= 135,
 	GDMA_EQE_RNIC_QP_FATAL		= 176,
 };
 
@@ -388,6 +389,8 @@ struct gdma_context {
 	u32			test_event_eq_id;
 
 	bool			is_pf;
+	bool			in_service;
+
 	phys_addr_t		bar0_pa;
 	void __iomem		*bar0_va;
 	void __iomem		*shm_base;
@@ -558,12 +561,16 @@ enum {
 /* Driver can handle holes (zeros) in the device list */
 #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
 
+/* Driver can self reset on EQE notification */
+#define GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE BIT(14)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
 	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
-	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
+	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.34.1


