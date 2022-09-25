Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53295E9450
	for <lists+bpf@lfdr.de>; Sun, 25 Sep 2022 18:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiIYQTd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 12:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiIYQTb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 12:19:31 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2155.outbound.protection.outlook.com [40.92.62.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5202CDE1
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 09:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eq75c/AyEA136CQiTm7Wc0sYuJ6EkP8WBc7Y7kJh8uui06zartjlPqV3QPPQztiytR4g0e7gzcV2JVZxl4mOif7O/g2RvW4uhzrbwc76IiXk+zs0Ge0+0xvpVmrI6+fDqdIqkRjys3E5kcgXZjsYc7ZJB5at/oyw5A1mqy++kodHjjzU0rDdp6qWQeTx0W++49NH6RckX8zPFzCCk6F2+2VWHlL4KLY9sTsRz/AF4DoLWAh35z4jf7fXYwqFYqRuSgB1oo7z/Nqg5/yzuxsYlEVoJ9YIsoAfFYVRqSTqFUN4YQgpwemxGd7bBDrJPZQe+lmSWJ6Rj+nAuPHsr7DPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxltH0MFHN0yv1rtGpfijsCqddouXP8UoSbs5Ejq35o=;
 b=J5GfZvR/YBCFhUyRKiuWIKZd4ojpyDb1Fq8de4/3Rmix5sq2jlsEdb4ffNFO7tYRSHnNgJFEzpnYK9WcklQFKlZe0HHUgg3BpW6miQ6kgYwkgOVat81ZWIdWED5O6IagBoMFSqvgvkO1WjXt1wjuokMIICJA/wAH8nPwjGdf+LaPYFFOXkrIDWv1WQsImhFfH0mqMPB3KhsEo4+okFpeXt9XOHb4ZNw+E/0Mg3DVsL2VQMP/88JEaCstNTrav8RhgMNEkL6M/FvBFhjt2sxnMGsuqb98o20v+nV+aJCvzW5GJ2RMjBVdjb1iXq6oY4LvskUWeS2r6JwbYa7YUFVrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxltH0MFHN0yv1rtGpfijsCqddouXP8UoSbs5Ejq35o=;
 b=grhoNPbyJlxM+uEm2g1XnRHiMH3V7jVtdbVV14QAHi+TiRTOufxM0cbQNAARnlvURM5VeVhkregOYK8uA0UxHKHwEP2nGnLuPgNysNXWDWb0znd/+g6+b4v85TbNg7ssRVBUBG1xHrELJmnVlNxD+p++LvG/ZkMh2StZRph4qe9hd55eVogpG4v0/A2oUmqASlm7xnZtQkwyJ3S4IBxbyyZtDMuWmD38R+FobVSU8DXXy4B0XYJw20PnvP0bp7Pu55qCqR5G7fQkeNhbCtx0mCkqZ/855oo+gRiuG+g4Avw5A854mF+Fulk0DoWSQMNcLtv0izhy4/JZaFwinBN0jg==
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:ac::13) by
 SYBP282MB2462.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:11a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.15; Sun, 25 Sep 2022 16:19:25 +0000
Received: from SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::549a:65d7:eae8:3983]) by SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 ([fe80::549a:65d7:eae8:3983%7]) with mapi id 15.20.5654.024; Sun, 25 Sep 2022
 16:19:25 +0000
From:   Tianyi Liu <i.pear@outlook.com>
To:     quentin@isovalent.com
Cc:     bpf@vger.kernel.org, Tianyi Liu <i.pear@outlook.com>
Subject: [PATCH] bpftool: Fix error prompt of strerror
Date:   Mon, 26 Sep 2022 00:18:32 +0800
Message-ID: <SY4P282MB1084B61CD8671DFA395AA8579D539@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cAYRFQl6/BhKkP4L3/e+mocWHw6iFLIa0UceDIUmLuSzOUcgWnh0jQ==]
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:ac::13)
X-Microsoft-Original-Message-ID: <20220925161832.1516141-1-i.pear@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1084:EE_|SYBP282MB2462:EE_
X-MS-Office365-Filtering-Correlation-Id: 16441a9f-e0a5-4535-3732-08da9f11b65a
X-MS-Exchange-SLBlob-MailProps: C/ir7cSdGlsxpxllHOv5HbamrC1c36SANxPm11wguevW9SP54lG6MYWpJ9xk5LyRBHWHqFIDN6H2tl909m5T8LNEMI+0WpCpaTEtjVX5Ffnctk2CwQsdIaTAToMrBYJZA6TnSOEZ48GShCbiLHry1/34Td2ebsnyBAAPZQuE2EWjFHQsCp9hnnXFTKSg+nahhFToQq9o2AgVPCsfBVe2EnGGJdPGDf/zdGDHPShIZx5wSYG5GZ/UQZEXWBmc/O3ipw5ahBv8cuYI4nk7KH9UpVx/khPZhYEi5PacMJNgjJ9HNLwI5meXF5m80lXw+hwwaJGBO3I1yJBQgoShl8VZyhGa27GBectx6En3YWBryn8fNxoVoYxGlAPa3f6L5dyeFuS4R+cgC+wGNuaol3m+Ko19XD0jELJ458KvC5IPQOE5sbpqmTakjE5BU74F/6RmF+VhqLIsK+nszamsbRRnM2PZKqslIRWv2V5oisnjKKjt+ERTPyvR0lrSETM0KK8PyaOtwx+0hCV+MWNWd7QRBIaXEUgIqB4wZnHySRcQgJV1KcCvnQo9qQUuAut9Yam2bvZt36IIJbTqDoVindl4k3pX8jdU9yRpv0iA9Jx37F/aZxPTD9CHON8F61QHaCAboM9jRgkVBz4q7DUziYA7A7yw43z0ld5uOY8heoOkXbZMbSelFR3rOE9Cqwe6qYA/A0KgEwSEriQRWrkycci9KK4z1yihsTg6hsRcuyQbYTMoPPwwe7CP1Lk3Vr+2smfP
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysXR3jkfCvNCkeow6OgusRBK5N1pvOdtRzhf8Bx9yZn4K/5TXLoHPpT5GFCMxoHIR9qP/3nWXzVfaYrQicDbL6S80pkmlzvIqXez+uT6z11q22BH46+fM/K/fLrSfJ+bpAPSHCPJXDyWCX+zMp0IwZimsbiCt9oPHTKM8HOggSa4FLUrSGnNhK/UqdGIagYzhI1N5oKcELiuNMjPlUevLljJmc6vqD+rBWmXuhHVR9o6Sl3YrZdDqI3CgNl/+ooBJROn5uWZ6AFtAskYMD4Ozq+hXlsWY2D7t3K6sx4iVUFk/Zl9FjZreJI829XSODVN6Hr/zWlS9pVVU6kEJBwJV/BIfjVfeYseNnjvrcujxA6G3qjNpC/YLNfMckJhyE/KDexA16bxCVZtun9wpyvd0Dpuwm8dbZT1G9gwaZIltQhLP6Vvny5yy2y76BLFkrOdgto9DLUs7YNEJbX3+NFLDaIO1inaxWhoaUfWrRv4+VxJtHHDPNv66AUKKqi4PPereLcXscGpZN6hGNvgYkIXuqqkxNK6YpH7XCYKh+q/kb7xeIWrkclsTFih8wEfQuiPpWJerXBjWUinaqfGRrB+QKo+DEGuOWik5iLE9iquqdliR1DX/Pz1bemxQxiyYKHxQJbJ0vZTcduP7YYyqaRx7g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jHmUkWa4og+UUeGKh16Ex/GSXW2R4llNba2CQJIEcGutzLvpsdC14nz7fSoa?=
 =?us-ascii?Q?Tu9D8OiyciQKuCvYiGIhU1t5dN9I3q/l7OvJmGKnIw/7YhR8wcxoS4NhFbta?=
 =?us-ascii?Q?yzfw7qMe0JPbrFNdOsCXlF3KVEq29I42WYwL8UtN1CwVmWp+xQ+Dki4vady9?=
 =?us-ascii?Q?8XFtg9Rm4UxpuiGKnTei7vv/jcbKk9KXpe5kEmni8KnhyYtFJweTtby6n6YX?=
 =?us-ascii?Q?l/8XlyWV61SDIrNcPJFLSQLLtOiurm4n3u/9JExaafXC3TiffFTc5VzHId/k?=
 =?us-ascii?Q?u1OLnqsmwAKpgEdv4TF4vDcTUTBua1qqb2eT0SBRxLVMUX+gBgFnVXf8GDCq?=
 =?us-ascii?Q?W/U0heOkLBBeGL0864PAVQ0WJvhUWssZUiVEDbSdRlVsIUO3QquBz2UT0O61?=
 =?us-ascii?Q?+t5LCVdBZ0U/em/itCM4xiGIqXVBk8ColKW0d8lnzjkxr4N2dGD1GUMdupr2?=
 =?us-ascii?Q?tSvlj0x6LcJ3J+kY0wME4PuPoFVhdCSfYs9DRhEhMHDfI4qAtPwT0qljTaC5?=
 =?us-ascii?Q?/B2zfsM+8n7p+mmqpTZlCuaAg1po8ggUPIqn6GTd5i+tuOqHdR4hZ4huljtC?=
 =?us-ascii?Q?6A6C4OVXVKyY5a17Q9l8rZqghU4hjEHvvEL92SN+g81/CGW2BweWkVrJbSwu?=
 =?us-ascii?Q?EOgMHR19tRD8XnY4KzsOF+og8JzXPG1vRodRUiuHtFAjzLQiZ6IFv8+BqXwf?=
 =?us-ascii?Q?Bs/tcTiOpmERH3TaqwE61imUfvkIQMbmbNZydkbO6H0SirQfK6Z1C09csGI5?=
 =?us-ascii?Q?mi9FC73hVcbynvO4RPJK8DpoLfaD0TbiSewxeF96tQzPuJA3PjZcvX+XM8pD?=
 =?us-ascii?Q?910bE0gpp66eP+qwqc7q0WWYATSSCLkozdDPOtULnni3tBFHiJhXF4Wn/uGC?=
 =?us-ascii?Q?/v1MK2FLQdt/M6GK0yp8CJvotKNJe5VNsU+VXWXwxEcH151A0819XOqYs2Xm?=
 =?us-ascii?Q?r54v20wFPZl9W8RZhwk3zzhQhyKK/WpEkEjM+u4AOsBkP4/1FeWF71NrjT3q?=
 =?us-ascii?Q?jI/tCVR4ZuWdooPaa110jeigPlw3je11xaRc540RVSMdRwktVcT7+57tyFGR?=
 =?us-ascii?Q?miodS9FyJgeQD8AZwB8PYOMLP/b9e0DwHkirwNYVd4gl5sjYYOptk0kFTiV5?=
 =?us-ascii?Q?IWg58MpECQCQQXwhlWt0QaiurXKdo/iAvzZXcsKP4q9OsXZoJUntCY1JDQ7T?=
 =?us-ascii?Q?3frgvVWLWNvH7EIv1so81wE7V8yYJwyeuYbCLDm75mAYbG58YRzgpUpcTqgM?=
 =?us-ascii?Q?ZCxyVk/6vsyBJlXa7WzlnHfdb+gH/TZTXv2O9YpY1KDO+gsQ+jpkCViyVnbL?=
 =?us-ascii?Q?B0I=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16441a9f-e0a5-4535-3732-08da9f11b65a
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 16:19:25.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

strerror() excepts a posivite errno, however libbpf_get_error()
or variable err will never be positive when an error occurs.
This causes bpftool to output too many "unknown error", even a simple
"file not exist" error can't get an accurate prompt.
This patch fixed all "strerror(err)" patten in bpftool.

Signed-off-by: Tianyi Liu <i.pear@outlook.com>
---
 tools/bpf/bpftool/btf.c           | 6 +++---
 tools/bpf/bpftool/gen.c           | 4 ++--
 tools/bpf/bpftool/map_perf_ring.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 0744bd115..ac586c0e5 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -643,7 +643,7 @@ static int do_dump(int argc, char **argv)
 		if (err) {
 			btf = NULL;
 			p_err("failed to load BTF from %s: %s",
-			      *argv, strerror(err));
+			      *argv, strerror(errno));
 			goto done;
 		}
 		NEXT_ARG();
@@ -689,7 +689,7 @@ static int do_dump(int argc, char **argv)
 		btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
 		err = libbpf_get_error(btf);
 		if (err) {
-			p_err("get btf by id (%u): %s", btf_id, strerror(err));
+			p_err("get btf by id (%u): %s", btf_id, strerror(errno));
 			goto done;
 		}
 	}
@@ -825,7 +825,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 				      u32_as_hash_field(id));
 		if (err) {
 			p_err("failed to append entry to hashmap for BTF ID %u, object ID %u: %s",
-			      btf_id, id, strerror(errno));
+			      btf_id, id, strerror(-err));
 			goto err_free;
 		}
 	}
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 7070dcffa..0783069f6 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1594,14 +1594,14 @@ static int do_object(int argc, char **argv)
 
 		err = bpf_linker__add_file(linker, file, NULL);
 		if (err) {
-			p_err("failed to link '%s': %s (%d)", file, strerror(err), err);
+			p_err("failed to link '%s': %s (%d)", file, strerror(errno), err);
 			goto out;
 		}
 	}
 
 	err = bpf_linker__finalize(linker);
 	if (err) {
-		p_err("failed to finalize ELF file: %s (%d)", strerror(err), err);
+		p_err("failed to finalize ELF file: %s (%d)", strerror(errno), err);
 		goto out;
 	}
 
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index 6b0c41015..1650b7127 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -198,7 +198,7 @@ int do_event_pipe(int argc, char **argv)
 	err = libbpf_get_error(pb);
 	if (err) {
 		p_err("failed to create perf buffer: %s (%d)",
-		      strerror(err), err);
+		      strerror(errno), err);
 		goto err_close_map;
 	}
 
@@ -213,7 +213,7 @@ int do_event_pipe(int argc, char **argv)
 		err = perf_buffer__poll(pb, 200);
 		if (err < 0 && err != -EINTR) {
 			p_err("perf buffer polling failed: %s (%d)",
-			      strerror(err), err);
+			      strerror(errno), err);
 			goto err_close_pb;
 		}
 	}
-- 
2.37.3

