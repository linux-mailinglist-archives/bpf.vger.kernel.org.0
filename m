Return-Path: <bpf+bounces-3937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C3B74685F
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 06:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A081C20A78
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 04:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2C806;
	Tue,  4 Jul 2023 04:30:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F27EE
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 04:30:00 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8625FB;
	Mon,  3 Jul 2023 21:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx5FJHLT2QEVeObFcVHtlr70+WflSxPgAOAsl1nq2is0rQhKi61prlWWYDKrS0O7gniG8rspbqbhvifrQrCSMdQzv6J/YW/vzseUOt1YSuN3L1Ipci0yHyYHQFFLsYnqJywPp0rmaIbQ39oE+4R8aKbfgshhcixXHonP94agtgZpyN8rwQGE4eX+FvK7OQsSyj5jV+irJUzZCNW46aFse9+oFdW8Q88aMxxILoSos2TfiVXnGLHZdmULnTtqcrK2o0DDgrdBebHLDK3VYLoeCCJB8K8UMlXhrrdcxtxbo9v0b/IzjGOZKC6wqXrd4iTtFVHDp096TrLEDd5K0OE6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0ZTHLG/KYFWfNgGH4DXvAQWu1NqLiwthLi1OO+a5jo=;
 b=Uj00KSTimcK1gbHdVIMjvroQ8mpeumcwVMcROgNfQQnN+1ypLLVht5KAkymAkEZh3Y6hqOoFkKzB1SfCXezgHyKZ9ElICTQatCHU7YwT6w59l/K+/OOEkttgXYNHUxkneAX8+uEpoAJ6tSSYe9MGS6sjkgto56JfoZtGq4SamDxKshPZLn9yGgiTCtV3fJYk/cr8u0Wg/lq1QcWLHgCV6HrQBDyByR46rt5Sr1Ocb0m1Kj4JCo0oEGVDX73ZBiPxT0i0Mju+/S8AMbqJ2a+PGCe2DIDFjMjLf92WZbsZRlXmpyx0xYWKF1Ped4flWpm4zONM2VvEE6nj9ZuD/RnJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0ZTHLG/KYFWfNgGH4DXvAQWu1NqLiwthLi1OO+a5jo=;
 b=WLdA+4zP4z4YI7FaZqdsHDOeGHrDTR1qKUqulDWkPaB+/PwnUIp0Eb5s5bfdKdOFd/8nwObmDitow9bn+C10k5a9Kff1kryK4zRMYB02wrCtJHdRgDEKI70hJnoE/3O91EFmzB8bSixc0fkJRBEFPMqa5l/sdizcmAotfOjVuNw2Tbb5BLZ9H9xJ7u/M/THHwDDllHei1+3U2xJq6fqT7URV+srKXRqcfCNVYuSSpUcv0ADEmuMlPTe3tkokyvFG1KRyUEUrDuXuKYa4M6+5MSxvEWa+i+e0bizW+bdh6F+0i7dp0RjuB5zAN3rfwgLw+Z8KhY3qmbf9SYq1JF6LXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEYPR06MB6729.apcprd06.prod.outlook.com (2603:1096:101:16b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 04:29:52 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 04:29:52 +0000
From: Minjie Du <duminjie@vivo.com>
To: Markus.Elfring@web.de,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	sfr@canb.auug.org.au,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Minjie Du <duminjie@vivo.com>
Subject: [PATCH v3] um: vector: Replace undo_user_init in old code with out_free_netdev
Date: Tue,  4 Jul 2023 12:29:42 +0800
Message-Id: <20230704042942.3984-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEYPR06MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 471a884e-e11a-4809-8dab-08db7c474f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MwH5vRAHj+2uQmL3Unck9MDjyrQtZ5260cI803r283fuV6hR/atejaZMytoAXcBmunNGk30onVpukbBVyvT7PGXtWIJB6PFo6atxkErUj5NZy0qabIlYg0mNDwicIVycvv5520NkmjByEVM/K0gA2J+ChTYFSBzLxEV1Y8oh6iDzd1IsxTT4V/crTUJUSHncNoIpQF+o3E0WEF0HKUSu7vSSCno5XkvL5fV0UXelH6mWjIHuI06xUJwE3i6qXzNEtf/g8ow6gAztQ7wzkvSYWA/LeYBMjSXa/e3gCsF6omZHxmZoCA9juzL6/ByC+kbBQ+4Nwom/KDBObcyt86/1wY49xhDRGlKyKq2h8E+0lP8ukJ8SPTlhmNYE9YHVPeMgd00iN3I8OXsZyp5eXj0f0JaP99qdRFO0j2r3LAJJ/K48rVZFViFymK/i8UjWoKDwrZQa09o0v6X9EN7VtyyLJXCEmEgigciH2Phvu0CoEun5PTc7TuRvoYd8H6z6J+2qOEixQxSOFT24pMABgc5C2OGlHSVM6fZQ2qu79U1Z1ibzs5qC8rJSjdvrYBTaR+IZDkczVZpGAe0mWtfCrohrzUlPqYuwhGGeNr3I8CyqJnc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(2906002)(83380400001)(86362001)(107886003)(38100700002)(38350700002)(2616005)(5660300002)(66556008)(8936002)(8676002)(66476007)(66946007)(36756003)(41300700001)(316002)(4326008)(52116002)(6506007)(186003)(26005)(1076003)(6666004)(478600001)(6512007)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cHqO9fX9+walb23uwPG/dOwqnyZVgyrzXJjAEMtDJNlah2w0g4GJ4o/MMVzU?=
 =?us-ascii?Q?5GEoEh2/ANf2ahNo+VbMFHbsxjLNzWKi6DP2piJNbqDOtWSQf2AOIQVbFjsY?=
 =?us-ascii?Q?NhFbjhoBDPkMuiU7Ub1RX81xxM+4n9Hm42SMeBChzHZiuZGWKXTcBUwv7/Rp?=
 =?us-ascii?Q?yaIEzpKaXLtVRShdyph3u7xYCsLUlyYJ9qkKScw1tN5I+tUxe21WOMnkY77+?=
 =?us-ascii?Q?93C7GPd+ZG3EAWhE3wPnuySANXk34JJht8JcrTt6vpiMsUg5ZX+ymuTVlErd?=
 =?us-ascii?Q?0TmmU1kcyVeq5RBISFLkiKMpJSSZdabIxnzOL6RhnOOX5eQgihYLoXrkhBhV?=
 =?us-ascii?Q?0ITn04rbO1TFmVlig9kJ/axLeA6VbTfWBdTfnPidpe/2sgmRbhRNR/0JaI8V?=
 =?us-ascii?Q?U9Wzql1e4vGwtK5drNO1Zu5u0oG0UxCD/vrqol4wnWaQEWkPNMRw8lFVf5iX?=
 =?us-ascii?Q?OClwyuCcqVuM91IlJjcmRRPK36xO77S9Nz7gA8DbPOlChScjUIUfqD9y1y3N?=
 =?us-ascii?Q?1aQrTGM394h8kF2qCw5Af5c3aqVn2ZZS/E5+Np/ktE94kwQ00NC0tb+1wTBc?=
 =?us-ascii?Q?dCuDnCpRytQso/gqYSMrvzkNb0cACDjQniak7FrQ9nE+sO3rzb78jzS3I78Y?=
 =?us-ascii?Q?3++ETSGBQrOnzejx/Sety6aVuoSQdVnT4sf/NrTRwmyog0S3uUrpr8HUKkW3?=
 =?us-ascii?Q?1NDRNT9iBgZkmVSfFx0+PYjyQA+ae2ya5pSgjvKbYhLKzREeaUj3/OFAqKNQ?=
 =?us-ascii?Q?KJkAnFNRZbI1YdfPbg8wWa5h5VFAPu+fwDULGmYBeoFypAsqZ6Vr8JHqUtvC?=
 =?us-ascii?Q?TwA21zkNZaxskRZryHnac/EC+oJAkPCq6y7L9kahPSTAsOrWG4OpH6INcuJa?=
 =?us-ascii?Q?Y2YnST5c+HnUhjXJHlcmCwZ6y3PfG7mJstNcJRgTn5DGLD1OeLeYQj2Rk4v5?=
 =?us-ascii?Q?p8VgRROfPQNlrHssXorROTfmNeIJci3L8YIQTQ4Hkjwqz5q0NbCTYiUbz5PD?=
 =?us-ascii?Q?HeIoUvkADnTHgBY592ZChP5LPevwy8tzqif0pfMMeuYm+5J58ccII4WYYLWx?=
 =?us-ascii?Q?9bheBv2St5+rMHg/TZZBH04VxFnw+SCYaOElrGXGK4epe3j01B3Z9YwKuYI2?=
 =?us-ascii?Q?ottQOrXGUF0OBP+kU+FAeWN4VOLJkdRkvBeS5Gapk7zCEMcb2xyRpnZJnWld?=
 =?us-ascii?Q?IjUKBgUYVphMu70jt3Uk/iF8RNP+lCvJs0qn+0AULyq3ThxNDyt1JslL+79+?=
 =?us-ascii?Q?rQPdKn5NS3GgFLF7+mnO4fvE0I8ddLHAxm7IL0gaEeV2SHvALdPOPN1Lv5Oy?=
 =?us-ascii?Q?Xa/6ZW8QUEa9vpEYWCOoKI2M5VIi00qPGNwtD69l9JVtTE5wE0ynS1SsolfH?=
 =?us-ascii?Q?ObCPSbzF+l+oa3PArDlwDd+nm3IJb/uKlGANsD/2ZaKoRwqWkXLB+A1j0jHB?=
 =?us-ascii?Q?FMMoXw8LO53IwaSFCdPDlXVIWiS2+M+VpdzLyuMVSh9+YsJTWTgPeTTjav0I?=
 =?us-ascii?Q?E9dmrTitY6e72nh+5OsKRLXqNWhb/U9Db3IJ4t1Ye7wf/jxOkhfjK1kGL9OH?=
 =?us-ascii?Q?mvDq1H8k51kPs31zJVnns9F9F3cdgL9f3Z5NW2Za?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471a884e-e11a-4809-8dab-08db7c474f56
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 04:29:52.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gU/t4RpnJnRF71m4wXxN0Jehp+Y/NGcaydvljlNP1d5aeGRGjABamB5j4mqKnyTh1XXNXp9xc50+spmgeZ3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for your response and suggestions,
I made some mistakes. This is a resubmitted patch.
I got some errors with my local repository,
so I lost the commit SHA-1 ID.
Fixes: ("drivers: use free_netdev before return in vector_eth_configure()")
Please check this link to see previous replies.
Link: https://lore.kernel.org/all/8854675f-99e7-314e-c986-8dc954ee4a27@web.de/

This patch make out_free_netdev replace undo_user_init,
fix etherdev leak in error return path.


Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 arch/um/drivers/vector_kern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb29..7ae6ab8df 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1646,7 +1646,7 @@ static void vector_eth_configure(
 	err = register_netdevice(dev);
 	rtnl_unlock();
 	if (err)
-		goto out_undo_user_init;
+		goto out_free_netdev;
 
 	spin_lock(&vector_devices_lock);
 	list_add(&device->list, &vector_devices);
@@ -1654,8 +1654,6 @@ static void vector_eth_configure(
 
 	return;
 
-out_undo_user_init:
-	return;
 out_free_netdev:
 	free_netdev(dev);
 out_free_device:
-- 
2.39.0


