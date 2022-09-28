Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D785ED76B
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 10:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiI1IPr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiI1IOk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 04:14:40 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2179.outbound.protection.outlook.com [40.92.62.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A7926F0
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 01:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXLl0B9DMH408/yqfLRqLv2167FuxnukRcEYq9Ht/fgrQZ5XF4mGERg8NGoBD3Y9rbovMTv6UPnwj8hcEBp2AN7pK03SZc0uhIy8P1EFHgVs67dl5dODyYI69oKaDXnjr7dJuvmzP6zZUMsGahxF7E7r/zORmuq831H6btNyW0HI6c+poILmaRKJE649CT1metRfZtgrK9g4KvcYY5HjUjL59N2vXyytT/038PUw5HVmNG6FJ1xL+PRUnb7W2lV9Oywvtr7nNJCl1g7sUFFAamGJJ2m+nPleDRCjRk+Hi3M2OInR309qFQOr3IjSPkzpEUKfaWx+zhjVhmRvvNc09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wePPD4qJcSp+mxjHTndjA1aGiCNU2q5+oYdrxsDivA=;
 b=df21JUHQ66NkBK0Z/xDvpNk2UhEXnOjGCDWDhBlJeYXH5Hm0VFpiHBpM/TrztqINyL6ecitB1SYqKN1euqvxQTlPLqZ+6skCjL5kVn+mKr+rLTMsaYc9WnT8oKDfwAx2wgfHfsx0ti5GuQQo5DIoly/wWyFWA72u2SlbAVRFmJ8U8Lvf84J5pgobGHB8ODOJvlL23HcXo909X5Q4DM65P+DYFOg0P8wfYTj/tOotVROWNn39gAyMMQnPl1oX8+vXegZoMRbPiZD23Cww2ZfqHRymMVbTCfbm4Y8GZ4gzKg2BOkpo/pBkn0dnz8OBKeU6F+JP5aL449ZsmdRSRxGbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wePPD4qJcSp+mxjHTndjA1aGiCNU2q5+oYdrxsDivA=;
 b=lkZbDRWboUKM3RinEFh4f4SABLMwp96GJUNyWhhrqCfm6hN2h0LllmfhG5dFbUJigEoL/+ULq59zA1zE9eyqVV3aPNxsbks5HsxUg73jm41/kFIxGhHUrElQeWtV7dGhkB3fkOLHg6BiAsT0JR/QwsfQgdkzfldTTQiM0jtUolY36oKDyQV/TgK4INZPmXtDC2Fp9Gf81diguKqhFbRApvngfQlKrnMwGdwpNKJsKl4+RUCNGyjpavX8R2+UihWQhKmd/q2paT9Dnu4TCsithplqPeDvZ3XZmDBYA+NorFryixOZ6qNCX8SNsgLogR0ILZJCi57gQS1rQ9+0IbdUnA==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 SY6P282MB3943.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1d7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Wed, 28 Sep 2022 08:14:32 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::549a:65d7:eae8:3983]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::549a:65d7:eae8:3983%7]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 08:14:32 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     quentin@isovalent.com
Cc:     bpf@vger.kernel.org, Tianyi Liu <i.pear@outlook.com>
Subject: [PATCH v2] bpftool: Fix error message of strerror
Date:   Wed, 28 Sep 2022 16:09:32 +0800
Message-ID: <SY4P282MB1084AD9CD84A920F08DF83E29D549@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bK8hZrl4+twDVatS9ESbTejAKC88PYyx0BIl6r4xI/lnCbLwWZOqjQ==]
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20220928080932.1456867-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|SY6P282MB3943:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbaefd4-dc04-4ca7-6631-08daa1297940
X-MS-Exchange-SLBlob-MailProps: ZLYX9kf+sFYZRJuE9Nv631LMiEgNb1ZKKj4PYAvPtcynu0Hra/Ljnj2q6P0szow9mY7eQspRYQtc2Z2Df/OVInaRRcIV+xBNx3FE6r6+EDheqnVmpXJ7iVB54zyfzcUVlPKF+9vUaPEogFzAByccGdvBJfUyz55EOE08EFtUsWnEPTW9K15y+jZNuO34YPOlafZo2EvOGNv7RtiIncysJoRmPYO+lGgjht/QPLomHyAIcncpsFHweGqW8R2Lcp61xijA7b6s6AKmeSKBqQqyAlbmJ6hiPsK7Zlm00TP5/UNEVlV5YnIaj7KzwTwplz+ny2fuiffJTwhOUgZZR+OmM+KMOf2ubj4/9ro4S5YM1raQv5UfFFcYDYIPYNso+V6U1oziiTebhNZvSGD/1GXCIwb00A75Z5ejBJp0sYS40VrsIMO6TZJ1mSHi+9Nll2+IqhUXu8JJcI5j11Ppt34zESJG8/gDG08DnGEIsBwbqQ4+6FoMuScuk/R4v6K27s3BOlSTu/jZlPgMcTbVEBfhQsyORLBnyjucat76apSmlVRCbUvAzfDJXSTJIQQDMQqlhofdOFtLnh88Z6yWqnSfTB6lkXNGSllwLEf5H/VryqDmobpkzsUAW5cyctq1ylL/PkoPbEgpP2C4wFbBG2Jf6DU75U+6kQZNmsmFAG6r9UMzzaAQeMdnPrr1g1QF3t27SYU+/6SO86lUh5wcV+tFpgUuwNzhYRsThjvpz3oPGr4MptVXhOLj774f5Lnw7HoKWDz2VJZO7Thw7mlGDXc9vJtqjV2t2LHECpHK3dwCIZkGquPLwVV2mg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZq+j2N83KvH8k7n86fzGqgW0NcsjVoa27HfcN4oxaFYIr2LlpiXnkVhq6CZAigAbCsb1i4TeSBPcvy0FW4U6CMQXmGvoq6MfXQh8z5HNtVeg0sW5sow6DolMgkRtUmJV8JA5Psym6rTBNugRqE7uJfZB+aijG7HxuysWiKFZtG0Th1TBuwo5KukboKf/bkEXwOHyFHhBng7n6LzDoAj9RPRrEtOpWBG3ltrng5tzeweFHCO2ehlCpPchxO/EYqvFgTEN9TK2q8jhWWgwhuJUadLAXVK2Qzq1OojJTG+Rfab7w5PaxPZuKjytaG9NrnhDvlyxcH3AKioEO9nzp57POuwSpnheBqd5l6y5AAvPwEiRdWOS9AmE0llpoPMmx0pd7BPivMDhC418hEP4gQGnExpDvi4ZkNHHBXa7bTt3+EX/L2Dm34Pu92vAucaotTQUsnN5NIsQ6uUROZuezYPLq6k8rm4jz63A3Zn/CCKf+x3XNUd8xRq13+ELEUiC5XNveeIdMFZIMy0Pumd2qhAsH2+y+rvPZT8aZzOlw1GI1ooXSCClIqSOu0mHdUWbtMYI/4o9TH1IZGFqpGKzgvKRTFh5WTqBZJFN45xvQpPs4DRzn9u0y+1Y9Orsr5hjnqJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uH8oRpkM803Q2DRZxc/BgZs5GHMCp4wQLQ5LEwhsp2HV4p24QJ/EH8T5Uyle?=
 =?us-ascii?Q?Z6LGoX10yEpTBjoJqHv3T82GyqE3BB+W/WT6fRXSPGQmxOmfWe530+YSc7Dd?=
 =?us-ascii?Q?gDxkkuAxCPy1CGGfZPxwFunlSgR+PWQNwMZJtIWfno1s0EX1XJvzNNMaboFx?=
 =?us-ascii?Q?jZpAUCcg2z5XmQDJpgDHlm27xHpmUADek8/qP0+ItOboWj8MVh/q4Ja6qjB8?=
 =?us-ascii?Q?SSyEyQOOHRlaTmA9fWnX3Yofa4btaSqF1G420lrG9OKnni7yiukSzrXS/xC0?=
 =?us-ascii?Q?TBtppJcjRC67+e9i7+e1R01Pi0ZXbYInXBxdeiiyM1bYnhNMRNpw/DPY2RrG?=
 =?us-ascii?Q?WnC240jQ4MiYPsrtNph87YIraUW5/L5uDOqPkNOWIy761Vm+4B0lZ1vNmz0q?=
 =?us-ascii?Q?H0DmtcDtw6dOMkYzRKnlhqSrFUBWX1GvnX5P7SRkwsbdA+BP5oDWPwzqBSr3?=
 =?us-ascii?Q?fn776nrOks8KWitiAlJirqhDppgqCL/zPvRghXymF9qyMfX8mj2CLFY2FIVt?=
 =?us-ascii?Q?12YNJt4HS+pCHToooX0xXPxOfPgbYvXABkFzSL7JdNOJDBYqtNvkHd2QY7gJ?=
 =?us-ascii?Q?DPAPdtHf1bVZ8IYbcMi7x3ll8K9A6/58DzFM/t2DzJvschxknc9XW8cr4NhF?=
 =?us-ascii?Q?C6bOLVMTE+PU1Wf+AthfoU4x4SCcbIhtJ4SyRSue8gd7iPVA0hPCmUc333cb?=
 =?us-ascii?Q?GMoAwq3s07sB33qvzubcJzELbv3FUomWRTQunyc6ITrUYwLLF2oplURR0qyG?=
 =?us-ascii?Q?gBUm8LHrCitRdQ8FW/G+/di/gfOao0VQELzms63L7zF7UhmlaqaV2G/h34kt?=
 =?us-ascii?Q?VyeC/xuoF0JspsVYmTGKFiQAA1jc6gRSwTkmxEom+7tMUmydXSQz2W7dewf2?=
 =?us-ascii?Q?7Dy+G6WbzrPAG7Uo4wjIaL63lg/5jkoFqTiJ+MbWT5GmxBqhVDSK3CVjqcHD?=
 =?us-ascii?Q?AKCf940wwhuwuXCWwh7JHsG1xCv9A7FA5u/yGLBB4R0BJm6Ps0qxr5ssEbx6?=
 =?us-ascii?Q?/I+VNSLQeozWPxwyDxm9JSPiMkd6huU7YxRrYnokmm+VkUy8s7rcDu/DhjQn?=
 =?us-ascii?Q?TDtz/qj86C7QRiQBYoVsrPDglHQqqrmXgHXphQ2lLDSzkUCpMqk0iFGq8XqN?=
 =?us-ascii?Q?//Jdm4AzERnRUibe9B+k7UbSvROe87+wjFme2tX26KtV29zb43nryQEvwYes?=
 =?us-ascii?Q?C6V7mbHo8IRlg9xmiC81EkERpn4cJql/m0FErvBOuFkxSdC8ErrD1bjvC87s?=
 =?us-ascii?Q?xaz6omswtLTxzZkGhUdj29CVFtgxhpGMl8VN5MKbw2KjUtscoeZk+jN0ME9i?=
 =?us-ascii?Q?JX8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbaefd4-dc04-4ca7-6631-08daa1297940
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 08:14:32.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3943
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

strerror() expects a positive errno, however variable err will never be
positive when an error occurs. This causes bpftool to output too many
"unknown error", even a simple "file not exist" error can not get an
accurate message.

This patch fixed all "strerror(err)" patterns in bpftool.
Specially in btf.c#L823, hashmap__append() is an internal function of
libbpf and will not change errno, so there's a little difference.
Some libbpf_get_error() calls are kept for return values.

Changes since v1: https://lore.kernel.org/bpf/SY4P282MB1084B61CD8671DFA395AA8579D539@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM/
Check directly for NULL values instead of calling libbpf_get_error().

Signed-off-by: Tianyi Liu <i.pear@outlook.com>
---
 tools/bpf/bpftool/btf.c           | 11 +++++------
 tools/bpf/bpftool/gen.c           |  4 ++--
 tools/bpf/bpftool/map_perf_ring.c |  7 +++----
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 0744bd115..933177bdd 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -640,10 +640,9 @@ static int do_dump(int argc, char **argv)
 
 		btf = btf__parse_split(*argv, base ?: base_btf);
 		err = libbpf_get_error(btf);
-		if (err) {
-			btf = NULL;
+		if (!btf) {
 			p_err("failed to load BTF from %s: %s",
-			      *argv, strerror(err));
+			      *argv, strerror(errno));
 			goto done;
 		}
 		NEXT_ARG();
@@ -688,8 +687,8 @@ static int do_dump(int argc, char **argv)
 
 		btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
 		err = libbpf_get_error(btf);
-		if (err) {
-			p_err("get btf by id (%u): %s", btf_id, strerror(err));
+		if (!btf) {
+			p_err("get btf by id (%u): %s", btf_id, strerror(errno));
 			goto done;
 		}
 	}
@@ -825,7 +824,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 				      u32_as_hash_field(id));
 		if (err) {
 			p_err("failed to append entry to hashmap for BTF ID %u, object ID %u: %s",
-			      btf_id, id, strerror(errno));
+			      btf_id, id, strerror(-err));
 			goto err_free;
 		}
 	}
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 7070dcffa..cf8b4e525 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1594,14 +1594,14 @@ static int do_object(int argc, char **argv)
 
 		err = bpf_linker__add_file(linker, file, NULL);
 		if (err) {
-			p_err("failed to link '%s': %s (%d)", file, strerror(err), err);
+			p_err("failed to link '%s': %s (%d)", file, strerror(errno), errno);
 			goto out;
 		}
 	}
 
 	err = bpf_linker__finalize(linker);
 	if (err) {
-		p_err("failed to finalize ELF file: %s (%d)", strerror(err), err);
+		p_err("failed to finalize ELF file: %s (%d)", strerror(errno), errno);
 		goto out;
 	}
 
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index 6b0c41015..309d5a1e6 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -195,10 +195,9 @@ int do_event_pipe(int argc, char **argv)
 	opts.map_keys = &ctx.idx;
 	pb = perf_buffer__new_raw(map_fd, MMAP_PAGE_CNT, &perf_attr,
 				  print_bpf_output, &ctx, &opts);
-	err = libbpf_get_error(pb);
-	if (err) {
+	if (!pb) {
 		p_err("failed to create perf buffer: %s (%d)",
-		      strerror(err), err);
+		      strerror(errno), errno);
 		goto err_close_map;
 	}
 
@@ -213,7 +212,7 @@ int do_event_pipe(int argc, char **argv)
 		err = perf_buffer__poll(pb, 200);
 		if (err < 0 && err != -EINTR) {
 			p_err("perf buffer polling failed: %s (%d)",
-			      strerror(err), err);
+			      strerror(errno), errno);
 			goto err_close_pb;
 		}
 	}
-- 
2.37.3

