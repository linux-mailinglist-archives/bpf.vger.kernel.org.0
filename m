Return-Path: <bpf+bounces-72534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE741C15017
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D430434CDB9
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8F23ABBD;
	Tue, 28 Oct 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QmMIlMNQ"
X-Original-To: bpf@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013051.outbound.protection.outlook.com [40.107.44.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED934233704;
	Tue, 28 Oct 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659875; cv=fail; b=OoVyLbAc9OzGSzRkqRp0PniOI/HCdD03oB3bW4dR9iE8WjP4qFe4aMgey4PgG7ChKTSSlstG6AnMb4ktdldF5bFNRqf+4RH4TpSUylY78ThgtlCDGsv2tUBFYlYJ44TnAXiktSXZxncl2lhp7i7ikG6hT7YzJgrkdt9+axHBAAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659875; c=relaxed/simple;
	bh=SMOnU3TWg0kweuQGnHIie6DL4u3nahJKs2uLIWV9KtA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uHMR+7tW0TzD00PBXOr8lmQvAV3NP+3OVQDf2Q2my50x8aSyztUcwCTlIXRd0lsZUyFoEYwcAXpddS2p64LdalX31Yv09KnjHF6XifC6Fs5FD4LUysiqJThtYxpxl+2rS76VqviVM12rjmR0YoIG+VHSdbw/UDQIy3mStM9sCzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QmMIlMNQ; arc=fail smtp.client-ip=40.107.44.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfWZbw5r+h6rEeneU+0cT112H6eOmNdKe5xQEqQxh8RAU+wMCb/A8muFfd2VyofcCTxwDTrEYCt0Cmb/sqid35wzfFHoRqv0aFvEhV8S82KesK9eB0VoFtIisXr/aMP/0Usw0+0Hw4xCzOlhwm2NJjz6ImZbpxY8Qn/+VmkgNQz3QW42KJvKRfdgvTDd3IMWOF2Z/+M5+1gDBbcmESHIyk+qeYNqFRxS6mLJkmtD6mT/Ch1MlNXJ/erf3dcV+/sESA8M+F59y82S/Xi1wCthAbEKA9PJvJ93CPEHnBeWd8vStW75+haxjdutqqKD6VwdWTbA5bXHifQmeRzMUIYw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9MZmGsI/uDBwsu/AAeTfs4AxE7RbFMkuxtotOEfP8o=;
 b=MTmazUspVM+xHdhjBRz2fnlNaTFOFP1tP/s9Ih4+AJ+QbnOAahqzoGYn92artTvyD28Z7AHyIVyE2MobYtiIiZXEakOa6EdsLGcvM2ZddciH71BPdp9Z37Ovk3es+vOCuJ75EBAch7Ju5K0OgLaoMbrQP45plSmasT7uU7gGyCbp8Hu77aPpAIzgh4DKDaAXhSVVZFaS7osokwmEVWBsqkolKHx1PwKzDTElOtFJ2xFcsMGS7rPThAL/A9Yyf7pttkD2egx8z1qFuRo0o8LoCin6tLrK+O4WWPT+RvpKGo4ZQxV3egTliX4A1XWlid/Ww11fBynu2jPFyoSn9rO0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9MZmGsI/uDBwsu/AAeTfs4AxE7RbFMkuxtotOEfP8o=;
 b=QmMIlMNQ3diX7gzT90VP2+u1gkk0Y+WcFzr3WqqBEMBoH1j8EcFHnI5+SxlPhQkKbDsJml2UMQ+NDrz/mb1j4W6qAUai/+fFU73Ojyhd0YSpEpaHYli3vkFBJ4t9yOugWnlH8ue/5ph0TrcPe94FFSKZwZtmqw837mBB9ZiZ9Lip9dkxS4PnjatUW2jS9zz/syLJYiIHhtUJrLv3schp8JKgut/qwKo8eEUKginGJBXO+UmFyaYycQIeKjUVzt8YgNWjOjnxSd7qYXgHLAdJ3Yu8hqNQ7yzKMIe6VJq38imHUyhzvpvw9RpzrQorx8yzqsNyrGvflffjuq34PuoO8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB7055.apcprd06.prod.outlook.com (2603:1096:990:6e::14)
 by SEZPR06MB6668.apcprd06.prod.outlook.com (2603:1096:101:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 13:57:47 +0000
Received: from JH0PR06MB7055.apcprd06.prod.outlook.com
 ([fe80::df0:e58f:7ef8:5a8d]) by JH0PR06MB7055.apcprd06.prod.outlook.com
 ([fe80::df0:e58f:7ef8:5a8d%7]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 13:57:47 +0000
From: Bixuan Cui <cuibixuan@vivo.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	cuibixuan@vivo.com
Subject: [PATCH bpf-next] libbpf: Ignore the modules that failed to load BTF object
Date: Tue, 28 Oct 2025 06:57:32 -0700
Message-Id: <20251028135732.6489-1-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To JH0PR06MB7055.apcprd06.prod.outlook.com
 (2603:1096:990:6e::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB7055:EE_|SEZPR06MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9081c0fd-9714-4d61-ded5-08de1629f9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fQh+aEoBkhHwwQ22PUzHzA51Ho6+S/5D7x9+24UzOrobQORgVoPmTcDj1FRG?=
 =?us-ascii?Q?/O++TotR8YCqGPOd3QXol1TaAMZZjfKlEx4YzMIQwUFUUeHDA1pEA4CZE/s7?=
 =?us-ascii?Q?DYuWQTu48olh3TSebRzliZBhXtw5zuVvNZitAFwJQZaAmv3Y1smU8D7ONVmL?=
 =?us-ascii?Q?n2nuxiTmXP7o+/6QqvWlP6/keuGo1iCdAVCECagG0nifZw/NpZBgkTehkNgx?=
 =?us-ascii?Q?rEqPA9ZLKbuTt63FiXrV46SaAgwjbRvqWb6FrgRAVYumyrZLmVtpi/DqGAN3?=
 =?us-ascii?Q?3Z9bf8Dri1qEraul24qKKrRveCW27wvu9LNCutVRsJZr3XN60PGcGJnvNAtz?=
 =?us-ascii?Q?iBPMkbCNAPtCwwqyEvZE8lvjgXYaz/H1WIhANpY2VNCE99YTpb8So1MbnnF2?=
 =?us-ascii?Q?SsWBQNSt1f6IcG2211e1s/3tqFVWYCQYK141n2XH7WxMzctGkUlC/rjJwd7b?=
 =?us-ascii?Q?3tGwO5LSc0IDS9gDxNRi6w5S38S8SZ2IIF7rnjlxZQSEY1UZqUQ/BO7bGXca?=
 =?us-ascii?Q?L+5QXxpVrKQmUBRnQo8+xlg0I5AiRKsbriTkzi6u/NYYYSP3sIV/4TMKbnO/?=
 =?us-ascii?Q?XbHUfE/B4RzSpAxdWv2qk0i7fcred3OqYge/xuckXqQWElQhJGGa1VPdsMWJ?=
 =?us-ascii?Q?oFzpFPUwdDf7JK114LryZO4/LTCK80k9oRcYhZ9Toi4D9KNPdFJ13aT21VqW?=
 =?us-ascii?Q?kaVYJSeK88cBirsrqjJlMymRTq/zOwn4JshYEq2GMIZstZXGYAbjcTstjhZd?=
 =?us-ascii?Q?3qoVUqA/xQbncl1kQZR9VI/olCDd/IHCir1e7VBXbru29OgR928x25Nya8Hg?=
 =?us-ascii?Q?a8NNgwXWH1k4CwQjyKE3Dxhf/4iWUp/GXbWTwqjuPlUoBhR/diJfxUDKkBnz?=
 =?us-ascii?Q?ZXr/B6bqD5arKsbGYcJh4N2itewt+2Pxdto2hwFH6g3iBeObCXrSgviaaKDh?=
 =?us-ascii?Q?hR5j5qe0y9NaHOtjLf2xdjg7CdnaG7tPb62Wkku1OhtcYZ1jbKeB95CzlAZK?=
 =?us-ascii?Q?IwW9NV8J9mXKfszaNfe9kbZM2Uu9EUmFWKEUk8pa91wuoL51V4xOMQZ2Bwkv?=
 =?us-ascii?Q?qyGmIJqqdJV7bAWQeAQcd6ff7Okc5N+tqgznYb2ndDQmKDQFrN4lFheNJGzH?=
 =?us-ascii?Q?Y0pNe2QnTwCi7LcnL/2mOry9QGiSGGCBsNjlk9Ukvgc/6ueoKMKVsQXKhdvO?=
 =?us-ascii?Q?Zv+23QQ4fE9QE5ll44R7niz12PdO+s3bDknZSangSig41UHMgpIsW4cpsNtf?=
 =?us-ascii?Q?4PK4Gv5k0y10lr8laUIaAuUr51pf3h6jLQB2uTpcdhRZxVXBtNMF32CR0iVk?=
 =?us-ascii?Q?HWL87zofMolcM2UusHyyFA9YONokHSrZsjSIkKz8z01Vr2+sGl3cEYxQZzwO?=
 =?us-ascii?Q?MscPNtRwcyvOo61SYg+JJSdWUryA3COJFBWNin5xNkin7gXrrssZ0uPgkjAY?=
 =?us-ascii?Q?3tqX4nyoDdzk+UKmXIitFFZEd2COBe/NyUslm+pAbs7wnmJnnehbd7jT0Gr0?=
 =?us-ascii?Q?EWBf71eAWJjalW+4wEmUmogjgrmiOs7lhpQ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB7055.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yK4SzwgrKlsJi9W5An5vaYrmZ/e+aZ8s+jzkAm0e3eAaGlKi0J7OBnsh3CzV?=
 =?us-ascii?Q?hgjWf2/IDv3YWSpwIC0pKeW3TZd0+es2x/lkNu6Qop/IwMJ+K4bgPZoozJTz?=
 =?us-ascii?Q?izkKYqGcGr5/CPOIk3IipR0PcVzmahyCTC1KCL2OIJxMWIxNQjuNW4LYVHmq?=
 =?us-ascii?Q?kUVa0cPOV+CMsWbiU+6oIUFHMFPVb/PHtj7DJvk/1FSnaM8xjV9TZ5cDSESJ?=
 =?us-ascii?Q?AKOa8DHxQCoscSUBKH3Hv2KVmn4P+9zIbvUNnweBgRg4oOURmhFU3lBEC38m?=
 =?us-ascii?Q?vNrEph/mBI+2DIFsMLTFTgyBmcQ1vCSvHM9u+SasQXMinGcQ2o35hzfRKA2j?=
 =?us-ascii?Q?RNTNi41pcFld+sfZhm+Ms9yFznpdeaNwfUOpbVh55rAfICW0gHrUmHzyTevN?=
 =?us-ascii?Q?+5ZjaPW9yEdhbSCCwuBkoHXFFjrtf0pM4eI7MMJg3UokAU9VRsSMIVLtms/n?=
 =?us-ascii?Q?eBf15MuwILXBhYUfS2R8reudMaMZp7/PAHDzNCH9C1W9gPZ3AzrrF3MJxHga?=
 =?us-ascii?Q?ihJJEhItwTKCekuzlFiYYCHarEiUXg3B1CdPAMZvMOiRrGV10aGW2X1oy5Z7?=
 =?us-ascii?Q?Tvn5MGK4IOZ4GtOuJjoI+xyUlZkHLAcUr+W5XO49uiigoXs/zqhwf7jrDuri?=
 =?us-ascii?Q?0HAxsRRv480g4gGZUmSI59gq7sWgryk8ehoDZj12Kby2y5wLscyOLjO1Zpho?=
 =?us-ascii?Q?hKwQUyKS4dzlv/pRga4neya6c+gm0IB5RIoRo8Cvfp4RNudr3+ubOkE14hXy?=
 =?us-ascii?Q?fM2YiRxfK6tLcwIs8uKCjPktOxpLpk2gcHFdLhLYEGPPr07fmq1jllsSOiur?=
 =?us-ascii?Q?bQwuF7QSMU7n8IXDlINzdBGFqz9xODZ7wzMQ1flLuHwheIJfiAkNj6rsELuX?=
 =?us-ascii?Q?FvBKoH40K+ToVPojUYSVKd9tE3Eb3sApYyOZvB8bLXMMHPi3dDQvv3nUkXGb?=
 =?us-ascii?Q?Z7d+Sc8kaE6Oyi9eUwhrPOlDgXuvYeNeuSqa2MsTRTl7alVOH3IM/cu+eJtj?=
 =?us-ascii?Q?zREYHKTcXE6OsTlULT9zgAr+znZ+NF5Ka8XCclyuqoiROlhiHVhl0ksY1oVv?=
 =?us-ascii?Q?jUUuBUmRycFsBWEcH2k2Irzqttp4O4fYgP9l0SyRXiRO0hu5hxinlS7tE19c?=
 =?us-ascii?Q?1zae6LT6Z3Tjb6KahaGERUSNfyYO3Ub7TdE//QuBOgG7FABpC9ZwhMcEqPs7?=
 =?us-ascii?Q?bkp1uTeCQkwozWcLZnDAHha28JFsk7yHk8rGAKsh5a9UTJ3SK6no2RL2FRNh?=
 =?us-ascii?Q?H3MfVzj5aGcBSRvZRwmcgt8ckgUmEU9+qb1r9UebZmJTdgSJ4JALngU4JLxq?=
 =?us-ascii?Q?9RNCoXOD72GWULMDShG3/CJrdfkizAJwlAE+mX09RDXvgJij8/f+hDnErkgu?=
 =?us-ascii?Q?uOoErwuQZ9QxCIAsnWleTYrIWJ8lGpaPImx5ILpUG/tJ1r29DxTI3BmGykWk?=
 =?us-ascii?Q?N73dHunTGoFM3jAYO1jjMqT++GftTXEzCbwr5n0I6XuqVWm1agrHAMwnaJaU?=
 =?us-ascii?Q?FbPJ+9ykOG8dg4JUV9sckUkSiBoJIS/3b9Pom2FLWr9SHmWn1nFiFViv5KDv?=
 =?us-ascii?Q?lC7lbFq1Bb+Cl4lbCmLX3kbPeoQKW/dy3wuN5dNK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9081c0fd-9714-4d61-ded5-08de1629f9a0
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB7055.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:57:47.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pSs0Plu4UrlNOuTzsIGVkwgUMx0pHNUzVbs28WIviNsCS9T3S1Lv8YLXoPpPPMW7RXPloi0nex41OAhwbIjxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6668

Register kfunc in self-developed module but run error in other modules:
    libbpf: btf: type [164451]: referenced type [164446] is not FUNC_PROTO
    libbpf: failed to load module [syscon_reboot_mode]'s BTF object #2: -22

It is usually skipping the error does not affect the search for the next module.

Then ignoring the failed modules, load the bpf process:
    libbpf: btf: type [164451]: referenced type [164446] is not FUNC_PROTO
    libbpf: failed to load module [syscon_reboot_mode]'s BTF object #3: -22
    libbpf: extern (func ksym) 'bpf_kfunc': resolved to bpf_module [164442]
    ...

Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
---
 tools/lib/bpf/libbpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 711173acbcef..0fa0d89da068 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5702,7 +5702,8 @@ static int load_module_btfs(struct bpf_object *obj)
 		if (err) {
 			pr_warn("failed to load module [%s]'s BTF object #%d: %d\n",
 				name, id, err);
-			goto err_out;
+			close(fd);
+			continue;
 		}

 		err = libbpf_ensure_mem((void **)&obj->btf_modules, &obj->btf_module_cap,
--
2.39.0


