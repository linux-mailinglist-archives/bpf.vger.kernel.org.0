Return-Path: <bpf+bounces-13096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EE57D45C4
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 04:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE691F22541
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC82100;
	Tue, 24 Oct 2023 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RmXb5K2j"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6B1863
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 02:59:35 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2078.outbound.protection.outlook.com [40.92.74.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0510F9;
	Mon, 23 Oct 2023 19:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiTROiK6uzfRMdIBjw34LzM4MMVTM2ifULaHSXHHMtoLS6S9NpvJuDq8tle4ufdsHreMS8iT1u9NTjma78MobFzK3ylPvRdnWjtgKORLQAua3DAX3dgM15RXhx/D7rpIwuVYwy5abifftqsDMgnekWIBwGhN9G8o1yOsnDrAVUPRVVJDSD+uQHNSmMoDrXIcfyx2LS5fDtzKNd1j0rFGnw9EvI9IK2yZa0ty3nBMVPVDzIjxtBba4qgAbGZI9jCzG0rBt5sBl/kvfUU90JN9zvv3MGFm28MBKROjoJG1O402kSWceez8M6rkAzcmTCIUV7IIIpR5jV/+0VEqzfUB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtWsDE84lR9Is+aUu93GOgpI3K4wGmsLX48CuTFyAb4=;
 b=oeyoaEjR4ZbmejNXNvo/M9fesccce1oQsxosg/3FNf/IGxIBLf5MXwp37cb1BkUORiqlzIJPyHhfQzrSGH1aATxpmBqFalby97b2LeCDYeqEyz2ZpGIYk3+vSeagohr+ElOatiQTGttFnSgNOswiKG71US6a1SKxbqchiB/w36Eue606xil662T2qb17CxpJXleCW7zrmPbUtwgboaehRADFXW1NqG8sDg40qVC/OPY44Cs2JesOkrD1zAJokzoANiW4O6UidlGYLpvcKUuoUrsMBsv10T8HkAVC+qJhfJpN45LJFuTuSnPj/ykOdtwjzTu9oyswg8bm74YqgnwToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtWsDE84lR9Is+aUu93GOgpI3K4wGmsLX48CuTFyAb4=;
 b=RmXb5K2jo0QZ7vDYOZcJENTEJOdij9nOBqGt0RA3OQXFU1rc3jISRs1+5DDS7NpZtJfgK0CQXe+Wa7BrS5BoauHsU3+Qf08uaAeMTh9G5N+lmD1WcIVvNtHYFvwtG7/7tcWS1XHasiiJ6XDdI5WK9yGLCrB8Jo+vt+TBUrIeU6XUa22FaNqlKhPvT3DsEQnZ4LvR7brVs7L2UH10tNohZDbqU/6A3ygE8VkPlsJqlCfQNs9VGL5/N51yQDUzunLIoALxeF0+cUhSm79mMZzAjDWLw3bf8K4Ian7XTSaefY9MkyAT1399/xcnjYQDA29lKNKgvzYztqtRU0+1G1wX2Q==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by PR3PR10MB3850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 02:59:24 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 02:59:24 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: shuah@kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	brauner@kernel.org,
	iii@linux.ibm.com,
	kuifeng@meta.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: bpf: add malloc failures checks in bpf_iter
Date: Tue, 24 Oct 2023 08:29:00 +0530
Message-ID:
 <DB3PR10MB683506E8DCCB073A2B75BB10E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2DOCFPwZTuxG3ujoTJnPUBxWqihi07WL]
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID:
 <20231024025900.1020211-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|PR3PR10MB3850:EE_
X-MS-Office365-Filtering-Correlation-Id: 965f957c-9547-499a-7599-08dbd43d3a61
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/EIPC+vnzgkazWnVQd/vumHyP38qMxUdRUCzpq8S/30kOYsMQkMyX/Rm5GX8IJ3R2/p/m3cb2HL9AtLOLMZMMIaNzsjTPXmpkGM3GKBkWHEhI6X265KnCrX+qSBZdHIHg6B+19bNY4FAiFXXftTn6gBAcab5DfrGQP5cvBIpN6nGznqDta3piX7sXARb1q/M7jKAT5eZLpQqJ82vsXn+UL1Q8huYY3kZTgWY9JnpfnEeDxGM9Xw5WyHN297EI0SiGbv8reSydO93dqnQRY4Q1xnB/V1T8RDOUabe0XFNzqnBrIPkTWRa6fpJDwhF4QXBl8OVV5/aIw8gVYcGNuSmORVqrAsaGOmGXhnTuKsQi1bppYxP1KmKsglDgPB86x+j9aEqElkd677kjtxROLusX1IqvAS+jmZCE5JcQz59RqhLVI7KxVQnwHtGPsGjkYaWojPKbNJ/WiEmb5H9nxoeCZHNyQ3vH17WVyP9KJ3+JQltggluLqStz+VfRzMH1clZsDLE1/hVhblhSFpmSbWXzW0iczdsGUTW9u/01I/5BagrEug4rZ5+RSp77iwivrBaztqsz9r+HK6+KePEU8eXqIJ9dBl3rh8S5cPl6wEiQLy1X+Trglze2+CegPaxgF9/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HLeemc2di5QwegVBakrmvZtLi+u/8jaG7gB06HZkQUDBWBJONUCFwdsvRg0W?=
 =?us-ascii?Q?eLAraSO2zE2zya+3N7DgUhjMNGDIuFAnGemkJLznkJwEQFZRbNgJv3kKBAy8?=
 =?us-ascii?Q?slEfYDu/TAQ9J4snPKQnZx7AEeHvmCoNnHBWDlPnMsvfAtdWPn55T/hvXNCl?=
 =?us-ascii?Q?wrZY7HfUt1loIcaPEbMy7kjs1mZ5roS0CLZ3d7EmoEMw1oq7szBwT5r6cm5O?=
 =?us-ascii?Q?jshuU2+CI0otBnunyfT8Ll4/bQINRssrvdyQOrJNUNnq8ojK1lblN9QtYn3B?=
 =?us-ascii?Q?ohAmHOhYV9tCaHi+EIoJSvQhe2jaGT44frI8sCJ+3STuKdKmy40vZW+3RLYZ?=
 =?us-ascii?Q?Bh6McYVP62T8YmfT9axg0pRpC6m+xY4sR01DgRJj17vjss0uuyMT+E75z8YZ?=
 =?us-ascii?Q?JJwVkTIKUtd3goKQxWliH3X/UabtYDEX+qyJSFZ8pIdwYniDKVSwDTOoB7ti?=
 =?us-ascii?Q?8JNBdtl539Dj4/fsJmFkMmOzIO5d/fRi1IWVHWUylaYRNAuVc2WZWNpDeQnj?=
 =?us-ascii?Q?opUao0q9D54hciNU9VTxm2VLirCOZNRllZr7XJpphL/E3mrGJq0mgJVTj4ev?=
 =?us-ascii?Q?ezisO63PPFPBXGyuQcPZIaIg7wUI2k8Ewasm97geev4BKsSVY3F/dCb8rgdD?=
 =?us-ascii?Q?YOw2+A/fUcpS4vyp2TOk5wm3vYoUVbut1ROTQzoz+o7PMvXTC8ewB1YETREG?=
 =?us-ascii?Q?l4SKg2s73EjenRE/UvKt0St8e0NEfH0BWITvru0NTo2TbFrD71CputTjuq86?=
 =?us-ascii?Q?5lHxliGt6DuFFrux2V2fIm3Bxa41ry0TEc4CDfIdcELDQ6Z7+kSb6fcc/urr?=
 =?us-ascii?Q?P6Au+FgcswdAOJehmIZ/5YluMV1rlCAo7IZcDj7d4w8ZUjdwZrwLCZzYdiyq?=
 =?us-ascii?Q?rZg7Ks8gL2YqMNMXd/UwEeloYadruJ89j66v0+Mosm02XEd9i0Myy1HgZPug?=
 =?us-ascii?Q?j6ueyiRkfQlR6Mq3Um1xByf4TbOqadqnhpyTiuPABdxMUbPUmf/tQ0xvQmRy?=
 =?us-ascii?Q?qgY4uOAG/Tj8rM14+t+k4a02zW6J1To+Q6M8YeR6vMAfUz+q5rbzNdt8NsnR?=
 =?us-ascii?Q?PQdC++x8Fvjc+2mg2LHxIy2sRgD1zgnXv76jqkAEOmV3chhznJf3mI67T1zg?=
 =?us-ascii?Q?c24ZzJD1QLmSMeJQTnlkyTcLtOmJv2KIqpK+jOmkzp+pIlPfVh5UA8DlvIs/?=
 =?us-ascii?Q?lLhr90qZaeORSm6pdqdoFwu/IimSWyv31OZU2t4MoNUHBSKVSx38AQAZcO8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 965f957c-9547-499a-7599-08dbd43d3a61
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 02:59:24.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3850

Since some malloc calls in bpf_iter may at times fail,
this patch adds the appropriate fail checks, and ensures that
any previously allocated resource is appropriately destroyed
before returning the function.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..6d47ea9211a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -878,6 +878,11 @@ static void test_bpf_percpu_hash_map(void)
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
+	if (CHECK(!val, "malloc", "memory allocation failed: %s",
+				strerror(errno))) {
+		bpf_iter_bpf_percpu_hash_map__destroy(skel);
+		return;
+	}
 
 	err = bpf_iter_bpf_percpu_hash_map__load(skel);
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
@@ -1057,6 +1062,11 @@ static void test_bpf_percpu_array_map(void)
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
+	if (CHECK(!val, "malloc", "memory allocation failed: %s",
+				strerror(errno))) {
+		bpf_iter_bpf_percpu_hash_map__destroy(skel);
+		return;
+	}
 
 	err = bpf_iter_bpf_percpu_array_map__load(skel);
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))
-- 
2.25.1


