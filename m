Return-Path: <bpf+bounces-58706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A86AC0158
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 02:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D4A1B6341A
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 00:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121FD12B94;
	Thu, 22 May 2025 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hOJGpoWQ"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022125.outbound.protection.outlook.com [52.101.43.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292EA50;
	Thu, 22 May 2025 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747873368; cv=fail; b=AvpABkuSiwd/EB/cS8J7QRVKHOc7x9Hw16zRFwbEv5PZfh4aybA/blyMNg1xXXmVIl0rriKutmJ8QPq8KL1KswFHUGAno3z9ArUN4b4rGpHb9Jm6qbsHusTpr6zlYx2BW/d+409k8x/YKrVRJJ6CfGpS5hgJfA906kEXxKPK3Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747873368; c=relaxed/simple;
	bh=Ju/15Cmmg0PsH41xyC1YzraQjeo85diTURllwH3DFI0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gkQsLeigBbrkTK4WqHWiJVpcictHOMXYvOO68zOMoO5ZWKgUyzm03CfBtZHSRf+KVy7p+sIF0FlUyrl/gMCfLfYM8CbSIGNdCUK74r3KOsxq6xyx+1w+S8XfKTiV/IRnABy/81XIVVFQr+0AH08VvxkonZTblD2npfcHYAx3VmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hOJGpoWQ; arc=fail smtp.client-ip=52.101.43.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl6SOD9KdtKor5/Alv98yIb23/QhTgjhhYZQvBPcs1wXZWQuoHTVmgk40YKdBHG3aiE3C3sSa0xCiLyp6JLDh1R7cvmUerSr5eBV/D5DEJjxVHTduq0hGAqB9TcppRVjLgJczqjeaYC/ocd70UvR2ORECtMDij3MSvuJiJWdXduF39adIHgdSynyOgjkd+e4XFQ4yEKdZ0L6uWZlPhL7j+2Q6zxv8ip9R4afLpfJwDIVNss0Nj1zyLi4NYbpsdrIOhND71Maoqmf21aV06+JH6nr/rus+qVC/QSKJTayfUO5Iy//X/C5dzKjen2huD0ow9c2FohOvba52bwGDAJ16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3XWxBX5ttpvehZ4CQmrOTEokgdD+fQf0kcgFwXsVeI=;
 b=d9hzfMWUw0GvROzmY/RA7edpB+fs/+bS8wlTnZY1hVl5Y1rXzo1nQRuVv5NmjuH3M0vLPVJWeC/xxi8+PTQyadVFEmbRxwkoiLjfXiVXxlw5i5R5eo9W2aMDD8Sgzbg2tOVYJtt/xoKwAl4+XrcLzS6tYTIT39UI48Q2TqMWTJBYS5xIVr610sodgAoKjltB6bwKoKLZnZBmrHGzBPMZFaJcjCYD+aHaNLwk5P/4GYQ1XezC4suD/8oKQLbi3pGHf6WZr1j8QT4XJOq4TBBSeYigbdIy8r3C/aAlFp5UjmbYk5dSCaPyPbWJlBLwlpUwt9Qz5OLLQxC+AxcJ7frXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3XWxBX5ttpvehZ4CQmrOTEokgdD+fQf0kcgFwXsVeI=;
 b=hOJGpoWQlXvThgUfUijLmqbW5uGzo6KzDQeHSUqGC7IRgQc6AfpMuN7gd+BFDTs0bfs465bSXgkkFbEYEGrLwZQCHbOrwQp3m5pfr4S+q/QScaQMQMqtOQMkLKKK3/oafwdw/K66uKRq3PnH3cXRAGaNYYmtUQHJaP+ML3IcN+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MN0PR21MB3606.namprd21.prod.outlook.com (2603:10b6:208:3d1::17)
 by BL1PR21MB3355.namprd21.prod.outlook.com (2603:10b6:208:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.5; Thu, 22 May
 2025 00:22:42 +0000
Received: from MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::5120:641f:e060:2dc4]) by MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::5120:641f:e060:2dc4%4]) with mapi id 15.20.8769.001; Thu, 22 May 2025
 00:22:42 +0000
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
Subject: [PATCH net-next,v5] net: mana: Add handler for hardware servicing events
Date: Wed, 21 May 2025 17:22:23 -0700
Message-Id: <1747873343-3118-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To MN0PR21MB3606.namprd21.prod.outlook.com
 (2603:10b6:208:3d1::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR21MB3606:EE_|BL1PR21MB3355:EE_
X-MS-Office365-Filtering-Correlation-Id: e09eb63e-e119-4331-dbca-08dd98c6c3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wNJIMkRuGeJvSIhTABsU9TmbM9wEaKfl96KFsNtCc0FYe3U4hWtHCaDrAz6c?=
 =?us-ascii?Q?AgABBtUdAXTnJfu+IKbIsqjUSnQ12a78O0NRCEf0TYdNOGBsi6r3HXzLn6vr?=
 =?us-ascii?Q?o5uR/5y3bEE+iBPdAcU0/6dsM6aOMlhE7XWuVh0JJlMMT9SjWy3X0QXEn8um?=
 =?us-ascii?Q?tbaaN3CPd6TLE9QTzHdzVWoncwE8K518LgzC6AIIhdBQKLpoYOlJUuKbcpjC?=
 =?us-ascii?Q?W0p3JLMjzD4HTuMYW+qIhcpiZZNz5N230Cs4H+b7ky5GZs9rWhTLuNTM9YBP?=
 =?us-ascii?Q?DPYtwrtnazq2k+rbpMgT4MLp0PVnstVWCmk6vOpbk3WazYF89TFUeN2Kf3p0?=
 =?us-ascii?Q?NMA72OM6MnstJgZ3lP5nVgN/G/UgQmO0QncP6+k5Z8bXAVHy5buyoNjW0dCi?=
 =?us-ascii?Q?tij/2FdfoBJLIuGvl2LFewZOdCXmCBu7bknmYq5GqkAnckwwTVZQJoFOsRPG?=
 =?us-ascii?Q?LvjfK/eTmTJVffHcQn+OJobfnX5GbI/MloVPEcYbSK9b5/6RnufTo2VCekko?=
 =?us-ascii?Q?2h6ieBl93+oq58x81i/LFr3W0pf4Ct5+fNSmPu8XFta6rWLaK01yIbK/wAHx?=
 =?us-ascii?Q?mT4ix4NIec7FIsZwqTr2OrB4CL3IhnwtQFqgqAaAg/FmxvBmsI0Edn8p7ETz?=
 =?us-ascii?Q?2UerIcO3xjZK4B5y/khUlNN8WPt4PZtth1MyxpgRACeGV0I742bAQgVKjosG?=
 =?us-ascii?Q?vWRvpl7oeOjuWldHMjS7tw4Q2Tm63IXphh7oSqCawOjsqJDV6IqJ7PPXd/by?=
 =?us-ascii?Q?p53WBsp9KVksnnm+J5GWoduyygw5kp50b22Yk6sTxSmR4LZQZOLCBeQ9mpeH?=
 =?us-ascii?Q?bVP8zeH3uA+l3Ume3fiiz8T4wLrzrnYVgDRDU7xeGNnwAp4O6JCGNfcKc1ks?=
 =?us-ascii?Q?cQ3rVHFlKV1dRiGYykvfXJNJrEAZY3THHCkpmxZTUdBcdY1lVqEuYhlK+E56?=
 =?us-ascii?Q?akoU3xHQ5oJt1xeeG4fbcZkYRZwCVL20nGZi+JXNjPPs3VvnkHIRhoJhLOAP?=
 =?us-ascii?Q?OcamvLWR2hC1YPHABr3A09gCiESaztWI5Icaf9MmV2XjfL4tgii7AeEI6pfR?=
 =?us-ascii?Q?t5dSx9uWN4+zk91D7wKlmuT1rT9rm9o3mzJLytKQ+HQEEoKlG5ubR4KPKJUe?=
 =?us-ascii?Q?LYVv23El74oWQb8rUB3H+OXRi4r6qNO2B8q5i6fqqohlPj9R+4iFzYiXdIYG?=
 =?us-ascii?Q?Y7/y1n7gF3kxjhkzNF/FhrlO+zefYeI4Fqu9dw5uuprAwQt6HW4sWtks/RFD?=
 =?us-ascii?Q?LZahQtMcKwX+67je4E+huOZyUCkzKkyguSy7GhIGMJx1NAiIPm5OXIUCBdF0?=
 =?us-ascii?Q?w5hUJRZlyRdbyQ4tF4iSyUpZCPmqDmeC6I2Jdsb0HJlNgecxNifyGY1GpH5T?=
 =?us-ascii?Q?cqS1vycgiR4zqfaN+ZmemWgD6kRkdO5LZb9wcMRpSRFzvDC+S2/76e2chkgg?=
 =?us-ascii?Q?sQRUbNjdhpML3rmAEuLK+Mhtz+RRCAP6yyBBO1kCGZ4E9kih8a6xQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3606.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c1KBcN0TTnWDprQ7ju5bmLiUpwUaJ2QDrueDBPpJEoEJyMgwCZNU1AuPaiaN?=
 =?us-ascii?Q?RdRJ7crBM693+QzE3Je77N6eddSA26wsfmHFXQ8uNEqoFhTX46YoJyO7o1Xx?=
 =?us-ascii?Q?Q7G58KbHJDrlfjAgh2BP/ufpomtsJ/UhtA3crjdgyCOcjjGV67scxnvLAd+2?=
 =?us-ascii?Q?hTAXjl3eo1A1MXJRyeAPKv+wOLbqVqDHDYUntE2+rXGYy762ndW4fopGW5md?=
 =?us-ascii?Q?4Qyo6n5yKYQRwBrbG7nt0W9QdRi5M5LiMPzZ8x5ZCj5ovCumS0wEiNNvHVqT?=
 =?us-ascii?Q?C1bzRqiVHqaveEUzchMB72BE9QFVXGOOSbwIFWBwUIYD1vYMqlvBZbpCpynD?=
 =?us-ascii?Q?IGFW+jNGJW+K5tbtb+ILZ/fEHDq3KgriE+sw1+f3PWETpsNw5dgDD1JchbVx?=
 =?us-ascii?Q?/8y4bDmobSq82yencM5VdqtshM93HB+CfC66szKUSPqQPKi4qN3vrF4eT9Tu?=
 =?us-ascii?Q?7VVrnmKFempVYM5nBE3M9YzU/uZaDnkSR3WLB2ZQKA8Qd7o/q9YZGYDTmn90?=
 =?us-ascii?Q?JndJVZPkKeom/fJivDcs+XhU3dq4whqioRWx/oXdqjpZzyTrvtdrZAm85Bnt?=
 =?us-ascii?Q?7NYfoTegB/SeT+SJOVjSSNdK9gS+Biu+YQw3Vzq4LO5A3br0YwfewxDyOhCs?=
 =?us-ascii?Q?xlfE6XBwjjENyaKlQ8oIpD2EQne1iLDyEJdikfuCtWif2T4r7BDm3LjfcR/m?=
 =?us-ascii?Q?1+ub3yCNSVeGuqXlTT6QN/Tpa4oneWINXYc8/PmPUmZdJTFgnGRn4VhpjekV?=
 =?us-ascii?Q?bAy89Uvik+aMNfdiA+tLwKDXVjkNQk630E1wUhcuC+hp31P3DM+zZ+lQHou4?=
 =?us-ascii?Q?Tsyou+jMaG7S6iQ7Hi7yevTqxn8yV0VB6gIyWUnjGyxsDnuqsAnPmiQidneq?=
 =?us-ascii?Q?Osb3wRNaX6KFfK4ZAHXPFC90e7MMSESYCRT1FsHOF6o6wNoo8Jd7lglIK5Is?=
 =?us-ascii?Q?3i1lceUF4kohCjmTuTnDwjMx8WYlPLpBxJPwuTGn0Ue3DXpS6GMqlK1TYP2f?=
 =?us-ascii?Q?VfuZhXfs/E0rq3CRemS3JQdUtER/NP01vyoz04jB94bnGBuoH7D9sDK2UxCU?=
 =?us-ascii?Q?E3dPkfF8S2q0S60FCwg4EeOXQjUjrEAzwbrS7GvwHMV8J1hxBih2bu5mqAxK?=
 =?us-ascii?Q?QPZ50tzJSV8ixpZh7MJOYVzTUZekxqyR9TGJJ7rCqaKQhdSdBimDz9TGLV8X?=
 =?us-ascii?Q?zidjt40+9eGlQvBtl1GcPTQqoAoVNMYr7zXg8rNTRyzYj+iSQlG/6F+4FQ9O?=
 =?us-ascii?Q?O+BU5UYxc27I4DXEAsATlmxOdCtiWO3nzccXUSckpFWZ+Emc8WjnNMNno1QX?=
 =?us-ascii?Q?/6hNIXT5e+vVnByet2Eak3D4F2lSp29G6ocqnembO1ncjGR9oWdkaMxBBqtz?=
 =?us-ascii?Q?eVi2/9mSASJNsbwuV3P0atiVj1u3t9vub25PLj0FTDHhmu0R1t9wc3CHJFJ6?=
 =?us-ascii?Q?ZauZxk/EBsN+lo3js4WCSXYVOoNQxdONGjv4TMMV4H6/OEPsq98cKzdSPITx?=
 =?us-ascii?Q?CEgtfaLMu30IqZfaWGVSH+r0Sx0FKqMlU4YBlpEMxEwuYLgdc8lhonSBNDp3?=
 =?us-ascii?Q?Pz56BvpCw8WLG8R+rtSSuzdD6FQwAsvUMxRXgqF1?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09eb63e-e119-4331-dbca-08dd98c6c3fe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3606.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 00:22:42.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qc4cpGbK30k8nB+aPkWVDTKIv5ZdzaWCz7qJgE23jt2XtbXN6r+zaYDzFjstkFDJifEa6GaivzY4Z/MAb6AELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3355

To collaborate with hardware servicing events, upon receiving the special
EQE notification from the HW channel, remove the devices on this bus.
Then, after a waiting period based on the device specs, rescan the parent
bus to recover the devices.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v5:
Get refcnt of the pdev struct to avoid removal before running the work
as suggested by Jakub Kicinski.

v4:
Renamed EQE type 135 to GDMA_EQE_HWC_RESET_REQUEST, since there can
be multiple cases of this reset request.

v3:
Updated for checkpatch warnings as suggested by Simon Horman.

v2:
Added dev_dbg for service type as suggested by Shradha Gupta.
Added driver cap bit.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 75 +++++++++++++++++++
 include/net/mana/gdma.h                       | 10 ++-
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4ffaf7588885..1091f233d8ad 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -352,11 +352,59 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
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
+	pci_lock_rescan_remove();
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
+	pci_stop_and_remove_bus_device(bus->self);
+
+	msleep(MANA_SERVICE_PERIOD * 1000);
+
+	pci_rescan_bus(parent);
+
+out:
+	pci_unlock_rescan_remove();
+
+	pci_dev_put(pdev);
+	kfree(mns_wk);
+	module_put(THIS_MODULE);
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
@@ -400,6 +448,33 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		eq->eq.callback(eq->eq.context, eq, &event);
 		break;
 
+	case GDMA_EQE_HWC_FPGA_RECONFIG:
+		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
+
+		if (gc->in_service) {
+			dev_info(gc->dev, "Already in service\n");
+			break;
+		}
+
+		if (!try_module_get(THIS_MODULE)) {
+			dev_info(gc->dev, "Module is unloading\n");
+			break;
+		}
+
+		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
+		if (!mns_wk) {
+			module_put(THIS_MODULE);
+			break;
+		}
+
+		dev_info(gc->dev, "Start MANA service type:%d\n", type);
+		gc->in_service = true;
+		mns_wk->pdev = to_pci_dev(gc->dev);
+		pci_dev_get(mns_wk->pdev);
+		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
+		schedule_work(&mns_wk->serv_work);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 228603bf03f2..150ab3610869 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -58,7 +58,7 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
 	GDMA_EQE_HWC_INIT_DATA		= 130,
 	GDMA_EQE_HWC_INIT_DONE		= 131,
-	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
+	GDMA_EQE_HWC_FPGA_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
 	GDMA_EQE_RNIC_QP_FATAL		= 176,
 };
@@ -388,6 +388,8 @@ struct gdma_context {
 	u32			test_event_eq_id;
 
 	bool			is_pf;
+	bool			in_service;
+
 	phys_addr_t		bar0_pa;
 	void __iomem		*bar0_va;
 	void __iomem		*shm_base;
@@ -558,12 +560,16 @@ enum {
 /* Driver can handle holes (zeros) in the device list */
 #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
 
+/* Driver can self reset on FPGA Reconfig EQE notification */
+#define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
 	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
-	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.34.1


