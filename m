Return-Path: <bpf+bounces-58239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C7CAB770C
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 22:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DB89E19F1
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D2296160;
	Wed, 14 May 2025 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GEd0cZXh"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5818D620;
	Wed, 14 May 2025 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254661; cv=fail; b=ZVij6NNDQkJSDVW/uFbkYPSSRDwaUplVf303btAQGaQDne96LQhp8ET//P+pBdRsbOUwp073L0JyqCDvnC0RmFft4hpztzAI4GHzCSAFVXPNerRjYoqpHOd+mw8dfdj/qYhv/+QlNoUusb20CorePtnU7ftMmELtrgzC/ie7ntk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254661; c=relaxed/simple;
	bh=rn8SG94OryjRFEbs9vhmWNUop141RpmCuxyWtE92jag=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aVnI/T1cAvfoMmNMHFvOFSUyd9sDUv9MIOjmngPm5c1eFOvJq+LLNPIasybQG2uU3wWQU7ff4z1hSgbrDq1M1gcOnq1unCXPec05F9KPxfxlbyfnewz27IlRn/py9jt1GGSFjrWv3rZc66WtV659RtQQ+jbZf2TDpKxxX8Pz9Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GEd0cZXh; arc=fail smtp.client-ip=40.107.220.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKrLvx+drq6zzO99sOi9I+N3i+uK39rCckfMY2uNwuKLpDR5uZE4mLCv51jdP2M7b8Zir4SS9GZRLoIHXz6SERe2AzgY0rugfgpsoSzEljqRJZQV2KkyeV8MwL+RuAb2Byu/Ocz/FcnrcN6NFHOIPkrnrXxy2mYD5vkt7468Ob54eksBa5aG/PjmdyfSz7+DTC8ksHm1XITCOkLvpO9oS6e2Rj/qMrKFde7CDGrmONwfyCxB3DAyadnbTm6x8HBY8QRaMuXbKQxfjOL7sMMM19sWGFY3Um8v6LyZ32sSxKraODCu8T53hocSyIZXPUGSYbkx3Nz2kEkJoMkzo83Lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocnMhGeucWy7hvTdivHoX7fXj64JRi0p1AywjRoEhAs=;
 b=kRqsVGjM1/U2WTdggWnFbWpaSQkMMI2A7vXizBlGXu6b82JwKTYe8tYeJuROvMPLeVWrxRTuLEByB0Zroloxdxbgxz4hPCqcN3YWTwjzIZfkl/9e8mllGlh+z15tKvejMUNPB2FhZ0fzelX8phFejq4TOe0Qk0JPFI9mAHYoqlZbxVomGtBC4KfXrsZ8uv8uAARj/27wVW0jcGz7Zxwdia3eZTACohh8r+IU0qvyvHCIcq2xGAdJaJfPgbg4ngD+DfUe7eDS2Sd5hA4ptjUDl4dtBLZpSKmTmb78YYEv5hnjLFKezyY72laCAUdFXQ3v4287wdaBkJmXl4dbj4PTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocnMhGeucWy7hvTdivHoX7fXj64JRi0p1AywjRoEhAs=;
 b=GEd0cZXhYBUCZrXAdezoal4JiUURXFpn7aYHgIEfVLu8NS26ZDFVU8/3hNH/0+ojHF3y3SvA+Ex7dWHiM4bT8GsizpePKlrNk3JB7DqSVmvBhOti16RkQW833CLT/YEyofTtJzCsftOpp2qNfilOMPeWnY+V4sv6i7FuAMTmNx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16)
 by DM4PR21MB3059.namprd21.prod.outlook.com (2603:10b6:8:5f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.14; Wed, 14 May 2025 20:30:56 +0000
Received: from DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::7a3a:a395:66:b992]) by DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::7a3a:a395:66:b992%6]) with mapi id 15.20.8769.001; Wed, 14 May 2025
 20:30:56 +0000
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
	kotaranov@microsoft.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v4] net: mana: Add handler for hardware servicing events
Date: Wed, 14 May 2025 13:30:37 -0700
Message-Id: <1747254637-3537-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To DM6PR21MB1451.namprd21.prod.outlook.com
 (2603:10b6:5:25c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1451:EE_|DM4PR21MB3059:EE_
X-MS-Office365-Filtering-Correlation-Id: 0908609d-0678-4761-8dac-08dd93263a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGwMBdjeqSjDzFywCBNinURw1YUqgF5FIP3XrUSWsvcb8pe1XbZ1RIOqHzXP?=
 =?us-ascii?Q?e8ntsoWa0Dpdsg3G8azBEc8qMfGscBoCKjkA0AA0pM38O85qFWXKZaS8nnRb?=
 =?us-ascii?Q?W60Ci056h7n0WpjJk2UN9tizjRuFsfRvfl813VyWZfgrc/tdE4T9mRiD+fbs?=
 =?us-ascii?Q?rg5QON/oyJR7mtVnMLXHJP4X01QjYDvUQkhRBdnV5pHphP9zxATcq0umGMoK?=
 =?us-ascii?Q?ydjETJhjQuN9Kfs5hDZl6m/bJWN+Ecvkrb3GwxJck/DijntqltmhT+LJMrYf?=
 =?us-ascii?Q?hvsR0OsHf+tCetWNWTpme8gBaNHN0Hl6ymFcCRzF+Y1Ifq7lteDRwtPlnCNP?=
 =?us-ascii?Q?GcNYPPwbBlra+X+ksEjvB+0ZUKntjAj/zS6NXdlI7PC3ssM7XV1Hg8Af1eZx?=
 =?us-ascii?Q?Dw7OnY0StIR7ACs2MMaLvYJMTobrLk/YN2BsyXAVfiKhch7bFurzkT41px96?=
 =?us-ascii?Q?R74FftULKOI9TWfQopTWT0KYCgVsowi/hcTl8utpIzGQsojilpFDhUEN8Uek?=
 =?us-ascii?Q?dzkvTYmyoTi0Zm2FuZCaqSfPWnMnocsaF/4ZHE1g4WG36/KHC5A1c890jwt3?=
 =?us-ascii?Q?an2z9mP+/5v4IJU6S2Nhdi6fcJ6H+ud9KS98xxepA6QQVORjy54OAj9iVUQA?=
 =?us-ascii?Q?aayTfDMEc8ZneidCIa1Muj2hBcBhd8rppEtx6NiBH7WmI1v+75E0vZnhH5yY?=
 =?us-ascii?Q?VCkeS9Xp0/COJk8NLV6cglIqVD1WpkSMuwBkA3mPzCRTDHqneq2ngwxeBgv/?=
 =?us-ascii?Q?Q6HvS57GZsYz3FRb2Seklx9q0HZVKAevVqs3t+STDvjK1SStiBSbZQcLvsQA?=
 =?us-ascii?Q?2l6yQdoD6H0LNjD8GmEa2cmC7AQ7W3l1/GwPs/BJks3wyvnX30iZNU16x5is?=
 =?us-ascii?Q?AVJyleJLgqn+j/6tiBmwpAQT1tQikg4rpdRQGSyGKJkK28egjpa2Fa4tRcsD?=
 =?us-ascii?Q?CE+h3E0WTixX8j2DwnFIfUjrdkwWVMzJW7yptsYnz2ZqqdRFVTeqmzTFLNhk?=
 =?us-ascii?Q?mAlwCHJGyOI0MZvNHA46qBkllcI70rMkADJvgtYwc9i/59MvJg1ui8STKxYl?=
 =?us-ascii?Q?9PDtIkD5Hr4tm+zHWUxajwPSj1+lnzn7vQfWy0NsnyW4IU0gAXfRItx5cx2s?=
 =?us-ascii?Q?1dfUVTYSrC/0+K7+sOVr8RKn66qskc5g9AqVDy8a+IgyhTj4fGQ7S3QX/bP4?=
 =?us-ascii?Q?F/bq6e4Fs4EnQu7FmiwituoNOscodrJMSgjnMicHKJLeqk1lnpBWWjxNlynz?=
 =?us-ascii?Q?1ZOqCpNgqt0vBasi0oLlAFyFbkkp+/dR88L1/0GFc080eJsFzS86bM5fmknk?=
 =?us-ascii?Q?g+SponhgVO6s0iD2YMerz3D7OHahINVrn4tHUpLjrxxXjNu6i2SUMXyJ07qI?=
 =?us-ascii?Q?zr/+wsn5+Vajz7Tno9XWb8SxbeFMv5MNDgn97j3CLnVZQACUdistCKMdOSKv?=
 =?us-ascii?Q?X8yEc3iKIDNtl4cjm+eB12xuuvOqEOmK5CtTGQzX9xarf9muqCRdsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1451.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VFaNXop2p5KH9BsHGJJh22vHKqxUFlGOaHeweoNtTHUPEuRj8kP7u+eTxWrs?=
 =?us-ascii?Q?isA2O+dhSwR3Xl0pjKCvUWWenW5d3hzVBN122gefLeX9xHh/T/wug2jyQtEZ?=
 =?us-ascii?Q?D7IaVH7Izc02WfgKywnqIrLPj0zCHUsH3Ul6Yqls5fap++pVLyZsqtF1t8a6?=
 =?us-ascii?Q?lxI1Mg0k1sXMckV27kXJBmi8Mvxxp8GCFl4Xe4IKoGteXaFzZbR7VIoquNha?=
 =?us-ascii?Q?XgMKhNP4c7AUBmyhoHDAI8bUieU+n2pPJFcOfNjstM47SatJC+P+3UXVRtBk?=
 =?us-ascii?Q?YlDUm8L+8VMH9b7ooEDn7uCnhFzrCEew8qoXAAH5V+NjJJ33xnFl30BuGhdN?=
 =?us-ascii?Q?3saz4G2NcNaSPLjT5jueBBwZ1JqAz/cMMfeXA2r2nVGuKtzEDBfMedNxAkm/?=
 =?us-ascii?Q?n8+eBpzbO0eBDzJ37ajGwrTCFAQR82NpRYi+pSmZ/iQ/1GGAcCxP//hG6wGH?=
 =?us-ascii?Q?Pqbw/+zkYjPT2exKaITzcd3sazcnPQSrXCvNHjAtmdKIikRyQCJl6ZWgmDf7?=
 =?us-ascii?Q?6hM5Oj0M7U9rnX9OQfzqx+V4zrE5ji163F975bLlim1O4tWX8qnUlb70lNlH?=
 =?us-ascii?Q?oorwKMaz1Pkmm8cS5dz9pm6kgfmt9cUsJfYUSGVqgigYho2bOV/ZcBBlv+Jn?=
 =?us-ascii?Q?PVm6hgFUfMvN6CgHgv/4L7KYBQpiPx3EDKcDWbtAwElFgSzkJtKASxdkN8eP?=
 =?us-ascii?Q?QvdMVGGT+x5voCZ/0cD2oDN9hqNraouCczmFFIWpxk2gxDnf214GmN0TzafO?=
 =?us-ascii?Q?81zVZK8ZnPF4zV0X9wTI82AH8GlUDpiKfr8LWFwecW3uCbplQMxcphilNC5m?=
 =?us-ascii?Q?ScrpfSR+NnZS1XTwIjv0f03D9goQfuFUlcJYU1uX712HnWRiLeMT7cDB8/jP?=
 =?us-ascii?Q?H3k25ndJjAe9iSnaxN0xIZ1fvvj+8MtOvk4Ezmn3Xj7fXOV2yT7SgP/7wsdc?=
 =?us-ascii?Q?vslOoZiiiMRPECT+Jlkf5qZ0C70z7L9la1ieW8ZZYedUKimrEhPfZdnRqvLd?=
 =?us-ascii?Q?v6RCuSrY7B7cubdo5YM/rX4R/e5/xc/tI/m5+4K8m33EH8dQRckIvvvhiDYr?=
 =?us-ascii?Q?jjsAB4skhfUwPYMNGZJ4RdIotBQWD65yXYvshAeSatTKm194CAzJmfdBcTPa?=
 =?us-ascii?Q?xk11cOT4OGz/qOVu06Nlsi1xG9TZe1a8pmBJncYvHGkzgLXlqdwmn8E+H9sl?=
 =?us-ascii?Q?iHizJ/X7NGzxU2PoCSnRgUSOKL1YeKVtcsISq25pRoACM7zjqOH8cQ12KIvo?=
 =?us-ascii?Q?R1qtk+EHZi9YUC4P14N6W0elDnb1fJB+E0kV6ZVO30anUTU4OKEvr27l3YNA?=
 =?us-ascii?Q?sT778FLCkQi06/AuXsWPuhHpu34eH8OyvijU6skItFru+g7Bb5rYAA+9LafM?=
 =?us-ascii?Q?Q69bEI8/knvdUgdEkcJbPvLebPasudexwfs3HtZUYomAv5lr5Mmm29P8lNa4?=
 =?us-ascii?Q?DCcrtJnhNd6FMLZV7WsjoAY0FFGyQW3CsCKVsuIR7PiQ2Qwok5hOxm1XGAZC?=
 =?us-ascii?Q?LMriFvkL5mYXY/h5vzS4qi4+5EJlfSYx9PVBdLZtTda5GiLF3MZRZQMQMo6k?=
 =?us-ascii?Q?xmeMmEYs6iaTGpFrzEuUCeFEq2hU4ZomWNBuoHWG?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0908609d-0678-4761-8dac-08dd93263a68
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1451.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 20:30:56.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sheANfBLWyQNCH7Qz8iyG7xAMjRkx5+/GLFxd954WkaT87IifWsTv+MYCf9EbBTG+UPvBURa8Em3KE2bY9kZYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3059

To collaborate with hardware servicing events, upon receiving the special
EQE notification from the HW channel, remove the devices on this bus.
Then, after a waiting period based on the device specs, rescan the parent
bus to recover the devices.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v4:
Renamed EQE type 135 to GDMA_EQE_HWC_RESET_REQUEST, since there can
be multiple cases of this reset request.

v3:
Updated for checkpatch warnings as suggested by Simon Horman.

v2:
Added dev_dbg for service type as suggested by Shradha Gupta.
Added driver cap bit.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 64 +++++++++++++++++++
 include/net/mana/gdma.h                       | 11 +++-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4ffaf7588885..08b8297e1800 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -352,11 +352,55 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
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
+	struct mana_serv_work *mns_wk;
+	struct pci_bus *bus, *parent;
+	struct pci_dev *pdev;
+
+	mns_wk = container_of(w, struct mana_serv_work, serv_work);
+	pdev = mns_wk->pdev;
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
@@ -400,6 +444,26 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		eq->eq.callback(eq->eq.context, eq, &event);
 		break;
 
+	case GDMA_EQE_HWC_FPGA_RECONFIG:
+	case GDMA_EQE_HWC_RESET_REQUEST:
+		dev_dbg(gc->dev, "Recv MANA service type:%d\n", type);
+
+		if (gc->in_service) {
+			dev_info(gc->dev, "Already in service\n");
+			break;
+		}
+
+		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
+		if (!mns_wk)
+			break;
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
index 228603bf03f2..23ca45d207ba 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -58,8 +58,9 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
 	GDMA_EQE_HWC_INIT_DATA		= 130,
 	GDMA_EQE_HWC_INIT_DONE		= 131,
-	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
+	GDMA_EQE_HWC_FPGA_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
+	GDMA_EQE_HWC_RESET_REQUEST	= 135,
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


