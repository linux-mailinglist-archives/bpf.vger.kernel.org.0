Return-Path: <bpf+bounces-43440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04019B55EC
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05D9284391
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB8120B1EC;
	Tue, 29 Oct 2024 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f/HxgFnX"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2063.outbound.protection.outlook.com [40.92.58.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6BA20B1EA;
	Tue, 29 Oct 2024 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241824; cv=fail; b=EAIDYif7s/EbSCIxYTPKP8zKJ1TLYf2qD07rFyflTqS4MweMEl+stN3FoSuuEGgU5BvsJ40lLJfv1ohVCFpTbWBFvuXVLFMxLYi3bapuQNYCD+YBDiT/AQQgxTU0X7nzmX4CWzDYkppJ8SGENpBUSIa2rd+HTXjfcJnzjSfnvOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241824; c=relaxed/simple;
	bh=dx0ybxqUrlzgqwmQ0ztItlfqUEB1SRgoqUxNidJDbjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PFwspKd38ewPI5FJn+OiSjEUKyBUcpmk9pwLy3oz9BxKba2ZXicGvi72oDnQp6X5H9PRNhTxtb5vGqBajcu7iD42C1eZkNsgH4DS/pKkaEopRpLpss5VqdQ+ecDnmIM6ygXZaxb2xgKMYoXtcJe4Okikk4zP936sl7+6LEHF/n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f/HxgFnX; arc=fail smtp.client-ip=40.92.58.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNkj3OO275E52hCaMII1mtFiwVdA7mtWYcFtu1/hFwxSP6b6ABm/v7vmh3QI4e9gZjt7in/FTSPvHKhUXUexIH6oIR0nsvx3cr4ZzHcc2jA9HL/W5laO83CKu7TCec15ITWEy+SBIQ1smFFNWdrsCmyRQgEpF/QJictlcYEpAqzGI406eKWZ7LckK1jNgBX7xMU63pCQYVHNJ1vRxcaqPs5/9s9c21m958+dyp3bF/9rh+Om0EPMxPliDkJ+U7Esf9xYfaGv4+pJkTpXeEsFYdwfDBI0bMjk/1wYZIDKFqXiOyXfsA0u1+5KbbEU4HX+Wj8qHJTTiH9IOO1qIffoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9pxNH/v7o/ozsnWjwtaN8YP8vTDpkqyZeoksCF/+G8=;
 b=qVy694ZjHb99PgFZPnKfxLlERAR82AgcEkrgknK9CXHQSmCPl3jG+HvFZ4oYQZq0N7OY7TolkKom18vZ4XvsQ0xM1YIMyTY/y1q2XD1EE8em5ctKqkypQP9qcjzrTqpK9KUx2RhljS7R3QRc9/lyDrUOVDZU4rj3ckR0HSobn6nhk6qhiCOCPVHG03McImEWL+nPCWaZqa9dwF9BgneIGSP7+OqGi062jYrdl8cWOKCktsqn4wI3cdmjGL9RZsUfU11lZelTH/sY46s/N0VU5FAmVR/wj+mxXiXvcZiBgWLXQcLplEnpQLsOYnc7Na3rzDofgVZXkOgcyoTGSVZl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9pxNH/v7o/ozsnWjwtaN8YP8vTDpkqyZeoksCF/+G8=;
 b=f/HxgFnXb5OtpV1+HxqFvV3Ui3r/vkzb8KdsP3oRl0l8JyfsMYqugxvEbp2sw9SmTUE1MNAFQt/1e050IS9FnS2+6oD0p+BSHdI5qK65AVSwSIg6RKIARrxn6HApVoRJEjJKq6+M/FtDBmIJg5gkTCVGJaehwf5H6I0of2iUO9PgzrGVKKwkzbDXP0tdpTA5l4RwKMXtSMsWtXLOsq9DzMgxahfvOglUejtSZFmHEYk6dP/RS/swTiYtE6LeB4awJFVxWEfO16ZePcmTDwphIHt16ugNB8XFqmd4eqSWMX3tnJQGoZvsTjWv5yD7ZLB/fGEfh7tcUe1ErG7rEZokiw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM0PR03MB6130.eurprd03.prod.outlook.com (2603:10a6:20b:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 22:43:39 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 22:43:38 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf/crib: Add struct file related CRIB kfuncs
Date: Tue, 29 Oct 2024 22:39:42 +0000
Message-ID:
 <AM6PR03MB5848E0E4F94741A4D5A09E48994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB584801332A1D31C21D23CC19994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB584801332A1D31C21D23CC19994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241029223943.119979-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM0PR03MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c575fe1-6237-42a9-7e70-08dcf86b2170
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|5072599009|15080799006|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LTat2fHjVh4uQ5c6Znr8Vbdx6j0nZBze1hFlFzTswHd9mPNhgRLdBFediVCt?=
 =?us-ascii?Q?cZVTJ0vA8aOAftJFaqMRkXgQMc0kMlDstLrC4txDR5lpj4ExKM2ZFfnZOzg2?=
 =?us-ascii?Q?aAF+MPUDT22560nPO1UwrE99NJREdV65gPX8AzAJ1piQhYTv9ho6829/jFpS?=
 =?us-ascii?Q?0Pk0dQ8FOe71Kv52Vp2C2B4zgNHRGXVQvwThnNZnbUeneqf33/G2irZzIaft?=
 =?us-ascii?Q?SVLqspwZmwCf9jXkZ2YnsxQpQCLjBDr+Lv0FXnPOCrr3EOZwMu9bV55saWgU?=
 =?us-ascii?Q?TjAEpHfVMsvXbp1JKD4A/fjEXaVUoMQFKD9SM3OjDXRuxioIFkUluHgzzBwn?=
 =?us-ascii?Q?gdl+KYfV6CFPcgaLR6H/BgdAmk3sJErDAxM5P3WBV4gpOf/9pp+IUz9iY74G?=
 =?us-ascii?Q?CrEgQTdpu0rSUq/D4JOouGbjneE3ju0InVHipsqCz4acxPqBcVK9hlOqwq7e?=
 =?us-ascii?Q?LcJoE6m8WLadjWGzWWnZI5o9xa8QMkIkubcFYnmpyGGjWsZndQbaL8rZ/SWl?=
 =?us-ascii?Q?byNRxlwjYnQkleGJ/hnHQBwQ0X41K/UG9HPjLDj8bASaY3K9Qtvi0AKeBK8z?=
 =?us-ascii?Q?/w3G0NZDJ9lb5ObK1JuJLneAygDL4DHOf5BCMk6l+/JKk/fNxQgKrKOSV/k3?=
 =?us-ascii?Q?WOidESPNY3BDd2xdaCfD4KDpWV4NqYY6v225D4aFVkPxSH25YB73W20KZGjt?=
 =?us-ascii?Q?2mYy96zzls/cCzk5NlLXnrBt5lGTbq8LAZulDTg6PnaYVTRgHDruivPQ6Zx8?=
 =?us-ascii?Q?E5Ic1OU5CHhZN6HdBeB1NU1YHq6KvjpUIVmJLvMN0BAGexX02URMydFOswid?=
 =?us-ascii?Q?l2iqWayjEq1zqJ9M4lhDxqoLs9BJsL44FX9Tr8VWQpnJ61nlcF2XCHxU9hri?=
 =?us-ascii?Q?7QkleNea+NvQZ4BwRBw6iAw/VApl4H5aX2/DDeB9F1wl/zI4rITZoOM8LSs8?=
 =?us-ascii?Q?dure4NPJHfUhi5MhGey9/uSlcBG43bmfDtENBR3uwxKiTghVKp7z7nkwUbrU?=
 =?us-ascii?Q?DyjFWgJ3RBcuFtx4vuZt/gCqlg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TlwYLArzJue03ZlHh9YRFZVoJOS0bIgalsO+v14512oo8lJQ7nv24rliIMpi?=
 =?us-ascii?Q?Kxxitp+ESQC7gdplJnSN2vuHB0Bm9Vfwevjk+5XH8C/f+zfoUkgqBBdvbbu8?=
 =?us-ascii?Q?Hf8nL8YyHfeP/pqt6zKmO6//veTU4xqy1YvNwawPOL5FIgeAt7x35Sn26vhe?=
 =?us-ascii?Q?bJfi8nqN3lR7CW2m1dQeusUCa9uc2bhhDptRy/wmSmXBlHTUBEPvmdHimVeV?=
 =?us-ascii?Q?fHn4BqXfsMaarhao9Qlu7rlMyxtPiKv0/ehypsxacVuTKArunXEoKKwYEaeu?=
 =?us-ascii?Q?TfJJh4zEVI2b4jcqnkq39hNstIeonqn0m7axnXgimhlt66dlzQpoPwaByd5O?=
 =?us-ascii?Q?+xHmUJ0CG7IoC1WyM/nnQEfW9/6tvKuw8sy1nyZWMRB9yGSAYB2GtReo5f6S?=
 =?us-ascii?Q?OuGk0f599mMSzFohfEsGLtJdADCVNBWWSkvxjAbLRivzsAMRlMIRXkIrFVvs?=
 =?us-ascii?Q?CY9gULRTz9Rtu+3DjVuYi7BRl9Cf+7tdBgeZ1hs2ODA9zhkIeR0dru54bz2g?=
 =?us-ascii?Q?IKjz65h0reoS5srvlPLP0UBbY77F3yuAKu4rzzxdcak/72IDYZyI5/UArNpx?=
 =?us-ascii?Q?w2QSi3nLYxSOpxOvROz7jlzHT0MQNa4zWwS8DOo0CP2yBNxR7va/bsLTPZlP?=
 =?us-ascii?Q?8v7lqsDRoiuC9uHtJMZqb8ywNrDGNfYYJCTKerUE3FhJMC2niuGAHonsvr/H?=
 =?us-ascii?Q?30GU3YJGbrbuiFpdBeBzzDZaYnOAGmtQomMGHBE3eP2OyTCNc7gvKRFRM8jF?=
 =?us-ascii?Q?MpxJldqi60NU8cHuKby2MeoFslFnuG8RF22uLuUFaOnrMWV0SMWeJJejvu53?=
 =?us-ascii?Q?OA0RxIWPkHvfZQd3XR7BIcGmOpdUNv23xVXfC0EOYvQI5U1v3NDQoblBGnLX?=
 =?us-ascii?Q?uU8LIs2s6B29xfsryPwhXSuVAcXEiHzk9/0JjNWjqa5sGScOETXF6UGsOqic?=
 =?us-ascii?Q?vuMzyiM3U8CGW7XHkxhR1xxQAuAK9dXWTlV4tjcRlVvP0xqSyJ7DpJbgtXhy?=
 =?us-ascii?Q?0b9RBiwPqW0bsVt1U/FlWOz3uT2bJE8atXninsYGoBH2WLxnvtJGJ60gJlrf?=
 =?us-ascii?Q?aU/7B/WDfqGCQwBj61ApPCj40zkofxEXTOK+CiS4g8x2Kyi175YXgTM4luz5?=
 =?us-ascii?Q?Xnbc8v3rMf13cUjzdXR1CvqhkFJRAvdkG7LU8CIEkc62YnZZntuIAXjk7syU?=
 =?us-ascii?Q?MQwtRHp1TukMrWnvSM1IAuMNhjEEYjNWGliIh4642RAglY/6HmPSkiI3asUY?=
 =?us-ascii?Q?WNC/SA8yW127HXjXWnhm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c575fe1-6237-42a9-7e70-08dcf86b2170
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:43:38.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6130

This patch adds struct file related CRIB kfuncs.

bpf_fget_task() is used to get a pointer to the struct file
corresponding to the task file descriptor. Note that this function
acquires a reference to struct file.

bpf_get_file_ops_type() is used to determine what exactly this file
is based on the file operations, such as socket, eventfd, timerfd,
pipe, etc, in order to perform different checkpoint/restore processing
for different file types. This function currently has only one return
value, FILE_OPS_UNKNOWN, but will increase with the file types that
CRIB supports for checkpoint/restore.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/crib/crib.c  |  4 ++++
 kernel/bpf/crib/files.c | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
index e6536ee9a845..78ddd19d5693 100644
--- a/kernel/bpf/crib/crib.c
+++ b/kernel/bpf/crib/crib.c
@@ -14,6 +14,10 @@ BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
 BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
 
+BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_file_ops_type, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static const struct btf_kfunc_id_set bpf_crib_kfunc_set = {
diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
index ececf150303f..8e0e29877359 100644
--- a/kernel/bpf/crib/files.c
+++ b/kernel/bpf/crib/files.c
@@ -5,6 +5,14 @@
 #include <linux/fdtable.h>
 #include <linux/net.h>
 
+/**
+ * This enum will grow with the file types that CRIB supports for
+ * checkpoint/restore.
+ */
+enum {
+	FILE_OPS_UNKNOWN = 0
+};
+
 struct bpf_iter_task_file {
 	__u64 __opaque[3];
 } __aligned(8);
@@ -102,4 +110,40 @@ __bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
 		fput(kit->file);
 }
 
+/**
+ * bpf_fget_task() - Get a pointer to the struct file corresponding to
+ * the task file descriptor
+ *
+ * Note that this function acquires a reference to struct file.
+ *
+ * @task: the specified struct task_struct
+ * @fd: the file descriptor
+ *
+ * @returns the corresponding struct file pointer if found,
+ * otherwise returns NULL
+ */
+__bpf_kfunc struct file *bpf_fget_task(struct task_struct *task, unsigned int fd)
+{
+	struct file *file;
+
+	file = fget_task(task, fd);
+	return file;
+}
+
+/**
+ * bpf_get_file_ops_type() - Determine what exactly this file is based on
+ * the file operations, such as socket, eventfd, timerfd, pipe, etc
+ *
+ * This function will grow with the file types that CRIB supports for
+ * checkpoint/restore.
+ *
+ * @file: a pointer to the struct file
+ *
+ * @returns the file operations type
+ */
+__bpf_kfunc unsigned int bpf_get_file_ops_type(struct file *file)
+{
+	return FILE_OPS_UNKNOWN;
+}
+
 __bpf_kfunc_end_defs();
-- 
2.39.5


