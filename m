Return-Path: <bpf+bounces-37677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E1695962D
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 09:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CCDB215DA
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395B199FAE;
	Wed, 21 Aug 2024 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qCMDc/pf"
X-Original-To: bpf@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2049.outbound.protection.outlook.com [40.107.117.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0BD1B81A8;
	Wed, 21 Aug 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225860; cv=fail; b=ZCf6+E/av0cl6uVFk5NQvUlIqkAMQJ9kmtwGzxey5p1esxeHtlsSe3LyzeugZO4Ut6Q9U/OoYCiO0YJB7NZzDJfjcTmgR55VUsxaIkJjq6IiFe81YnrOxKG/zWXj2xa8P9aK7RJ03m6jwzoQ/xpKMH0oV3QOk+m/IOGikEHEJBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225860; c=relaxed/simple;
	bh=ehdFlRTOtt2fJld1w9YJzPCrfDO/TUx9/WitM2DzR3E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lxgX2Y9rdd2CmDRzO5Po4kbakk7E05RAUfNGAxcW8OhCAw83fyIiwSacXrqdUW3Gb34KaLzcPFrnaAnKLqKHo2pKxA/qt16ZZI07WXF/wYwVUugMh0xxDwo9SYBTHDgFjKL/lxmPC7CaIUjHK0AvMSBpB98XIb9LgP56G3rtorM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qCMDc/pf; arc=fail smtp.client-ip=40.107.117.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lc197ljSnhiKWXVsVi5KdGFLcyI758G8uJihSrgigkDi0LNid1s/L19dL81surbTj1xX1DjD3RNQHNsYzA/uV/q1bZb8dZAOJk5EWMJXIiPz7rv2TlnQRg+booG7IYsTVdcSPAFWJ54lWoWx/Pa1u1Hom3APybycMAvENEMiGGkcS/wMq2tJCB6v+0NM0TebSnkOw+CLY+85IBoW5OMIVC9UkkzG8OPRWz9W2a79/ZpLS+yBc1ops3c1eQz1CXdKWcJz/JTbqV4zlvdGFqu6PHhzp6gl4yt047CgIeGEI7TH5Tvt1V5x6wP2elveYjmSaGYT7zvcz/w7AinHn+NnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1YXyImqKztB1YrLSrDea9QJDWZxpO9u+GyZi7oG/g0=;
 b=hf65pTHwEkCq74SqVa9YqZZId8I8H5oGERr40DSdeetC2pmifX0BK/HYU5s3pIovpSxzgweHIKQ1047qBh/dQTuyoNoIJfFSgP3MyJJ5wCeXw0+MV7P+G8KE57PXIofOUx0lmp61acgePlRnoN57g5X+/Jn5J8JxLizgvWNs23JhZKk89nU6lwgzgdVHr3b4pfvBPv67SgWFmH1KhnBqBW0vpv/vskMtiy1V0jg8wO5/CW/nIv1MtBPZ+kWZ+eWQ67MSGQxmzQ8QTCHA6GdNvH1fKicOxaw1R+3ZbmgKAIsdwopc5VnvVUKXUqbEt6AkLmrcrZue+TIQjdi/zkrDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1YXyImqKztB1YrLSrDea9QJDWZxpO9u+GyZi7oG/g0=;
 b=qCMDc/pfxaog6MRlwKZHr2vYB5X0ZUzKxegTpk7/UJzgB5wr/wxNb0o+ncY8qkmKfM3fEK1j15KBeRDMx5KiWUUc73aeo6AHV887Z7JYaNFwf3cSni7UOy6bE1Lsx7hKvJ7kA+nAHjNLZmYn+s62i+X1lv4gHumJ0V2lncxj1vRS22PODVDFLlM33GOjgTDf9T2YKZySpCIshLPw3jETbr0+GagPaIdTvnz392rFvcZKXrknnNKOLJkRedINjhgIUbyc85y7lQO2eIZEUuEdWKOpc55bprLMg43RiQNI9ZY1Pu/z2ie8gquLDlrWSGyVIRCeczDYgIBpfdPFji8IHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by SEZPR06MB6458.apcprd06.prod.outlook.com (2603:1096:101:179::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 07:37:33 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 07:37:33 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] net: filter: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Wed, 21 Aug 2024 15:37:08 +0800
Message-Id: <20240821073709.4067177-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::35) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|SEZPR06MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: dad804ab-e3c0-4a78-d0bc-08dcc1b41e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YX5GDYqvKI1mK3Z9v2USGcIErP6rEqCaJWJVCYebx7957cqht60alcQPfD17?=
 =?us-ascii?Q?WCJaRrTCaUrTYjuURhMmOGpIc4h5tY2GLpuLkZGVOpGoBNQfq+Jdy5dtWJSF?=
 =?us-ascii?Q?HQeFilqLIMgozbvM2e2/U71d9ieoWGARuaDKDKEYoxYQxnxl54J2fG/KWDsM?=
 =?us-ascii?Q?4mVt/pZQw9xSV9c3VKUKVeaqgPxM6jmAE4Au4SLHwWZ/PDmI06ctyQvCE6Os?=
 =?us-ascii?Q?u5M07yJGKolEfP/7pgIEuol5a5R0a1XmJ+IAEYPym4gAxi2ZEFhUqD+8iDnD?=
 =?us-ascii?Q?oqPZnMQmcnvczDzJVeXxhNQkGmBVzO9C83uwKBIVW0HBBeUAvyN/yEzMMsxv?=
 =?us-ascii?Q?+josQnER1NQ7NBP4drKEAwxQLunl9F+zT8eb7BGRtR0uyZQiMxvvxbI1ng0A?=
 =?us-ascii?Q?JFZH29J0gtPPhmHSktSUxhViqTzw1Qahw4ftIr3C8aBlxkaV7s24ERquEUwk?=
 =?us-ascii?Q?OnzElzUMUzzJsOpJ0zfxaFkJE4lJ1+4AWxOaHNDwdJ5er7NCcPeRRqTks5kH?=
 =?us-ascii?Q?h4M5srWFupRxYkAoDXl3h1eanpTAUgtBKn8DnAJEGbRYS4EXd5B3XnJTtiFP?=
 =?us-ascii?Q?8UgXJKUAA9YVC8CjWWRdm3lfSmRarvugcLb6UUleIkzem80Jp8E6bv833j7J?=
 =?us-ascii?Q?sDuuegxdpSU/yL64BnQ0ra9vL3nWTmLfIxWo02rdUBvH5W/NfHQiDQQRwDsS?=
 =?us-ascii?Q?fnVBq2np9/L9NiEaF/2M0r+mBKBVFbkwmr4iYHQCrFmZeDwaoVVEJZv2ZoAi?=
 =?us-ascii?Q?oQuv0yoY933vGgbOiPKa4JnOS96bjmXSuOOZuN4YKnkaazqAj3Er3PJkoPzd?=
 =?us-ascii?Q?+W4WMPpXw7obfQLD1QKWHdYPQbNabcv+DvkCxWvxFJ10qRumPK3twLNid5hZ?=
 =?us-ascii?Q?gusnbQVuK9YtPHObbL4L6MJWInakFfk/7avvUlPLQQpWesJQWjo3rFipsi5q?=
 =?us-ascii?Q?YQ9HYUDIM/KC2AxTb6jgM5S8V1U2PgFqVvXtrnmxABpf2/TH+o3PW4TPPACv?=
 =?us-ascii?Q?coT/e9GT9Or/ov3jSMU7LB0xorBM8nSqABP2wK38+EO4b0C2HBFIU4sb5JDu?=
 =?us-ascii?Q?+oE2TZv1CN84Rg6/udmMSGsiNEjZ9dZTU4aRJ/MN2mihGg40swxPHBB2omt+?=
 =?us-ascii?Q?qqZ+fKvH6bgI6WvUWNXpNDsWVp5oug9PZuOMArhrr0VJMzA8DqmZqLPHHo5l?=
 =?us-ascii?Q?9pHCILjlbHJNGDtQALZv5Fy6XPJRWcMhXRrCOvYauO+ltIcSmzrUg4PfO7zJ?=
 =?us-ascii?Q?4ZdGuda7jJebtzydXy6HTkJ+d6RX7p/ngvge/9AXZTFqRIw0Sov+qxSO1l7U?=
 =?us-ascii?Q?PoU7CUvm4FLkGN0s6bYQ1eR9JqGpP70TlG5KJQoz60N3PLxo6tKJOR7TD9l2?=
 =?us-ascii?Q?VGfh1qGMVLTroUklxWagWcEUaPxEfw0pcT3T7eULbJKVIPrLuvJR99RIIgvU?=
 =?us-ascii?Q?l9saFFvOwpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7CKG9yLO2OyH0cx8jNWVN/y4EaOLgyxYVLiyXmpcxTBjQ6NdKSNT2NiwihlQ?=
 =?us-ascii?Q?IlHguh2MemZ5XYtY3tkQ/WvLkGKZScsevAIvadOTZig+CpL6QRLH1el0AjdL?=
 =?us-ascii?Q?2LDMPUCZm2kgo7c5RXxu8FCI7qx6f0V2IvuAns/vcl2OGrVObRJxayuoR5a9?=
 =?us-ascii?Q?vDfxPCu0b6n8QOilAxlROD49ZS190i6+hFKhZtzX6waSB/eWYPHS0WKK6m54?=
 =?us-ascii?Q?V5LQaREDAVe24MB7MV5wzSBfwJzb6dUZklQmQM/Ur68BMzAtMR1WvT9AvEDd?=
 =?us-ascii?Q?BlxD6pj10j7nRwcKDr0nUoZBkgycmm35+TSnXlW0xp+uGqybvD6xkIpS1hkM?=
 =?us-ascii?Q?z02VpQ6ieT6dZbjaMYDevIUpscn6gwqLJ32sKtJYzTIao6NwoAQZ0JHP0AZt?=
 =?us-ascii?Q?nCs/pWQfSBTgK30kmrZ/dAHTwngo0/Dlzw6XeW47mtUyW2lHljoieT0SYoU6?=
 =?us-ascii?Q?Tld0iuSOG85CJzIVF4dMJpIqGRpTomXl+R7JiCXVkYPmv66X3lnxo8rP5F7W?=
 =?us-ascii?Q?jkZ9PiktZEsBVgP0rrKMpEfgmAKGj1nM4+7VcaEMo9neIOoKXQUX0jeLVle3?=
 =?us-ascii?Q?miRCiABCNSSSvT5IStVzsT3SGbeykAkYYvfEiaid4SkNpOI/mn6FFM95d4IL?=
 =?us-ascii?Q?3rTBFPx8UDoUyUVQPYOuv5ZV/Te9M8nYTOseopPFIm2bLO6f02zmZQ8Onham?=
 =?us-ascii?Q?7tdQEFiAzK/vRAyYpweRHqeOguow8r1SxBpKRj9N67ylzD+DuHO4gYnF9coj?=
 =?us-ascii?Q?Yrce8zCnDwdmZ4/AClXJhPbV2E/0OPaRG+UPtjZVaPcBthBMWM7tK6/6EfGP?=
 =?us-ascii?Q?FYNF9TfeRHZoWBjjmOB/weowX3diGWIPVE5S9iRxLEr9QBwIsI6XrmY+0u7r?=
 =?us-ascii?Q?1Zhyq+dVa86SIF0L0s7dekWHYM/qxtDeNTWLCK4ek9euNfPGHOj9aKdHvwgV?=
 =?us-ascii?Q?yN7pGAeo9AVaIUKbtcOkj2SVwpI9wfiVn9YqzlwqhWPq1hLegPLavA+NtxIY?=
 =?us-ascii?Q?OoW52QN43RnQ03gMIaUxMYhtDPh1dJFCo27ihyY5O28AmwnntfI/BiKNHFNP?=
 =?us-ascii?Q?sob6/P2US73sYTxrWx0nlwrKAXxoXEUtZLC1bmlTozcbfdrXNZYd/KCUrsYz?=
 =?us-ascii?Q?6poqWgHTr54lQ93VGpNa0Q1803D8Dnwhl6DtqTyH4bEsh0ZM3ZYlQz+lM7Ck?=
 =?us-ascii?Q?8abI2923ZUecdnnnRVL+lG+m/2fGtPM3oRFWeFU1eFmmUIn7M0OnHiQPU3BT?=
 =?us-ascii?Q?l4V+7HCTNQEdqMfjmykeknxvwfBblJTH4YhoMpgvL8PcuNsS/RKkDevqUUz5?=
 =?us-ascii?Q?hRggFh8/fWMX1ndKuWkOLwFWYHwM0ecX6Ayv4ko0YwIphWGbWKS5V77zyEBt?=
 =?us-ascii?Q?fMgOyo486eZV6PBzjoON6+cCVp4o78gtj1FE4+dFLCt7CPSQxGSw/KrO4N9Z?=
 =?us-ascii?Q?mINwwBZaiF4htzg8aOoTT3dfZoCYF8D/ozCAWR38et1vnzlHoMIs2Ym+Y+4D?=
 =?us-ascii?Q?j6udbevNU8D8ypkM5uNavKnKU8P2QcKZ/Qqy7CkO3pKo+bRpzFIQedxaegek?=
 =?us-ascii?Q?av00vBl+FqtKBCjYCMkFqbsfOx9neoefKaSmsL7o?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad804ab-e3c0-4a78-d0bc-08dcc1b41e6a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:37:32.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+y8LOaahYG8SDRQG8DHz8j0tq8U0FxM6lyaAgDSoHv/N+S/M2jO7YlA14MtDmKKQwXHASEPfExSYWy2AAJGcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6458

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 45ec3dc805b1..eb946d3a9326 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1265,8 +1265,8 @@ static struct bpf_prog *bpf_migrate_filter(struct bpf_prog *fp)
 	 * so we need to keep the user BPF around until the 2nd
 	 * pass. At this time, the user BPF is stored in fp->insns.
 	 */
-	old_prog = kmemdup(fp->insns, old_len * sizeof(struct sock_filter),
-			   GFP_KERNEL | __GFP_NOWARN);
+	old_prog = kmemdup_array(fp->insns, old_len, sizeof(struct sock_filter),
+				 GFP_KERNEL | __GFP_NOWARN);
 	if (!old_prog) {
 		err = -ENOMEM;
 		goto out_err;
-- 
2.34.1


