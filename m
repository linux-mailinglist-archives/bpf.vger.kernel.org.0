Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDB6C2214
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCTT7j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCTT7i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:59:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D999B21966
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:59:35 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32KH7dCS016505
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:59:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=cLGbrYiSP2GxYN6pv6+F/7L8SNzfXLZ0+yVDwT2Ok/w=;
 b=BHjeYHi7vFj1uqkTSXJOfVRbMA7h2vFHWx3BdbudT5pgRRZztwcF0qZLmCRBMw2OY7Pl
 3THbZFFHEc+lI/3f0uw8ZhLp+w6kj+KjDcXXyOalCJ2GGHlBppDU8qEiy0hZEZQHtx5y
 680/i0bVMwATdJBDDrTuI4ja3WziMgqgT/ckNlvdnBh8fR5Uf8IPnpTtjU8l+6WBGcmP
 Cyj2JFFG/ZVeEQCHd4GO8/8Fq2Wu8Fdv83kgHItQryjiy8voKhR0mhk4jyb2vruc/MC1
 mNU1/pifY6Z9b8GnMSw3okGEXPiAZCDY6AybIDRkKjfu41tQAmIEPdJg7qBXNd2M7PaN 1A== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pd8yyuwyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:59:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU6W65pyvEOvjEcVzriKWCQ5t24edPaeWGwk/e9wwWNILEWVavMCxV58yODyqGeWXkN/Hx+e1yjmzsa4OpbeCaPjCpJ9sfCqDgrWU38pO2T1op+ztZqmZztM+cdMCGqxYI+/V48xNZWIT7vBFeKXh5fJ6t6OfQnJYLXboWjC+juI5MTn6C9eOgXnKcsahqW8UQlfEz7yOrOLYmFTNCemFA2UATx+Lwpim6hZNLUUU1N2QtDii2H+9uv1IQ3weBN5KkYvWwS47y8ce1uUnwg6HjKmPcY+74eI4Kap+d47y16ZIc9+T+ueZLUezUGgd9h2MweJEbdeZ+wrpUJCBg1Q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLGbrYiSP2GxYN6pv6+F/7L8SNzfXLZ0+yVDwT2Ok/w=;
 b=HO90eOCR356YjkCt2g3xpSnFkFb5fuhfaUTmA+93OGYB265HoQ0Rj/y/04hrdaG51OE9fi2aJWZfqyilZkD0eJ+TNVA4Z+6/zpcEwcmNgvdyA533UYU+RrnCfGZywUy5P2B1chMAtO9yYqFERYaBydd3F4YeONXBEACvfeHuQ48pTG7mZefhBJ73WuPTAtkbkd2LHHBqjr5NgRcaviEpRDDbxWgXQ7t6r9BDdYFVeXc6t9iVJWPLhYintOnlhU2LOohyBRI+9IilD5vtPyorRlb7ndqCTvDVl9a6WIRJDTFDLOTGuBWiR8Q/1gEFic9IOYUIT9ZZEIClHBqZ/uOH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from DM6PR06CA0006.namprd06.prod.outlook.com (2603:10b6:5:120::19)
 by SJ0PR15MB4201.namprd15.prod.outlook.com (2603:10b6:a03:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:59:32 +0000
Received: from DM6NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::72) by DM6PR06CA0006.outlook.office365.com
 (2603:10b6:5:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 DM6NAM12FT032.mail.protection.outlook.com (10.13.178.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Mon, 20 Mar 2023 19:59:32 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id AC5C17D4C184; Mon, 20 Mar 2023 12:56:46 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 8/8] selftests/bpf: Test switching TCP Congestion Control algorithms.
Date:   Mon, 20 Mar 2023 12:56:44 -0700
Message-Id: <20230320195644.1953096-9-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320195644.1953096-1-kuifeng@meta.com>
References: <20230320195644.1953096-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT032:EE_|SJ0PR15MB4201:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 45ed7753-d193-4b24-80fb-08db297d9f40
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5qK9RnLXQTrwv+A35eCiSnTM//xq38Vj+iF7oKXyTRgBPXm8J+ia69xfrHg3QjQmJ9P7JrEmuJuLxNS7EdlmZtt/BAby7nquA9FL6qLe2S6+nUIsJxzlBB2Z98PXpPHUJweQsytQEyQ4yYqBfwSdzzrdGLkLkPXCSHLA7gYMXRiJxpjmXGEWsMG/I/xvJksK6KRLGLVgZwjEfUUnFT20XRFJzm4+kjHPF7KoN/gECHDWdnCEOCrcrlyKo9GDfj0E2GpZ1GWrk4XrvDRFE5eOcPeITlEvUMg/8e+T01OFKynUQXzNqMKeM/lqofA6/y7Qq+HQ3bxRqq7qL1OLZyE7A9pEhWxJkRNH6+MpCr5TfHsGEpxmbQKDTD8xwGKu4I0xMzekImSCC5XkTIWwj1ZlacVMfNg6mrGHGDGCXQhz1OrsURsdmLClqvFT3YVO9Bphy85rbrzw54CZl+XgFYAqqf/7jubh9XHyvdvM4td8nrO+N/D6wtpGCdQrS30mbAyAm0nVPS5TjnHsnBec+P27DVp/MOURzHHh2qbIBEDDGYDPXyXkPhLFE3zWyhUOPsIi14xUXJ1X1Jympir0ekD5CHNzqGSV5uJA14aQZqd433NObt1hs/f5HfrgBLqHY21J0uLEeS3w5Nsu/Iv18pLhNhR79Rc1ecvZQrDQ7AXOfEiTYyZABrKQDx5G2qwwkkL6AkH+Nylp52kUUku9JfDSA==
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(33570700077)(47076005)(83380400001)(82310400005)(2616005)(42186006)(478600001)(26005)(6266002)(1076003)(316002)(107886003)(5660300002)(186003)(36860700001)(7596003)(356005)(40460700003)(336012)(86362001)(82740400003)(7636003)(2906002)(8936002)(70206006)(4326008)(36756003)(41300700001)(8676002)(40480700001);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:59:32.1418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ed7753-d193-4b24-80fb-08db297d9f40
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT032.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4201
X-Proofpoint-GUID: CqmDRxpYrGvMG4CtITIY6O89EW5FqSDD
X-Proofpoint-ORIG-GUID: CqmDRxpYrGvMG4CtITIY6O89EW5FqSDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Create a pair of sockets that utilize the congestion control algorithm
under a particular name. Then switch up this congestion control
algorithm to another implementation and check whether newly created
connections using the same cc name now run the new implementation.

Also, try to update a link with a struct_ops that is without
BPF_F_LINK or with a wrong or different name.  These cases should fail
due to the violation of assumptions.  To update a bpf_link of a
struct_ops, it must be replaced with another struct_ops that is
identical in type and name and has the BPF_F_LINK flag.

The other test case is to create links from the same struct_ops more
than once.  It makes sure a struct_ops can be used repeatly.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 116 ++++++++++++++++++
 .../selftests/bpf/progs/tcp_ca_update.c       |  80 ++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index e980188d4124..5f3602326bbc 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -8,6 +8,7 @@
 #include "bpf_dctcp.skel.h"
 #include "bpf_cubic.skel.h"
 #include "bpf_tcp_nogpl.skel.h"
+#include "tcp_ca_update.skel.h"
 #include "bpf_dctcp_release.skel.h"
 #include "tcp_ca_write_sk_pacing.skel.h"
 #include "tcp_ca_incompl_cong_ops.skel.h"
@@ -381,6 +382,113 @@ static void test_unsupp_cong_op(void)
 	libbpf_set_print(old_print_fn);
 }
=20
+static void test_update_ca(void)
+{
+	struct tcp_ca_update *skel;
+	struct bpf_link *link;
+	int saved_ca1_cnt;
+	int err;
+
+	skel =3D tcp_ca_update__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops");
+
+	do_test("tcp_ca_update", NULL);
+	saved_ca1_cnt =3D skel->bss->ca1_cnt;
+	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
+
+	err =3D bpf_link__update_map(link, skel->maps.ca_update_2);
+	ASSERT_OK(err, "update_map");
+
+	do_test("tcp_ca_update", NULL);
+	ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
+	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
+
+	bpf_link__destroy(link);
+	tcp_ca_update__destroy(skel);
+}
+
+static void test_update_wrong(void)
+{
+	struct tcp_ca_update *skel;
+	struct bpf_link *link;
+	int saved_ca1_cnt;
+	int err;
+
+	skel =3D tcp_ca_update__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops");
+
+	do_test("tcp_ca_update", NULL);
+	saved_ca1_cnt =3D skel->bss->ca1_cnt;
+	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
+
+	err =3D bpf_link__update_map(link, skel->maps.ca_wrong);
+	ASSERT_ERR(err, "update_map");
+
+	do_test("tcp_ca_update", NULL);
+	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
+
+	bpf_link__destroy(link);
+	tcp_ca_update__destroy(skel);
+}
+
+static void test_mixed_links(void)
+{
+	struct tcp_ca_update *skel;
+	struct bpf_link *link, *link_nl;
+	int err;
+
+	skel =3D tcp_ca_update__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	link_nl =3D bpf_map__attach_struct_ops(skel->maps.ca_no_link);
+	ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl");
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops");
+
+	do_test("tcp_ca_update", NULL);
+	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
+
+	err =3D bpf_link__update_map(link, skel->maps.ca_no_link);
+	ASSERT_ERR(err, "update_map");
+
+	bpf_link__destroy(link);
+	bpf_link__destroy(link_nl);
+	tcp_ca_update__destroy(skel);
+}
+
+static void test_multi_links(void)
+{
+	struct tcp_ca_update *skel;
+	struct bpf_link *link;
+
+	skel =3D tcp_ca_update__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops_1st");
+	bpf_link__destroy(link);
+
+	/* A map should be able to be used to create links multiple
+	 * times.
+	 */
+	link =3D bpf_map__attach_struct_ops(skel->maps.ca_update_1);
+	ASSERT_OK_PTR(link, "attach_struct_ops_2nd");
+	bpf_link__destroy(link);
+
+	tcp_ca_update__destroy(skel);
+}
+
 void test_bpf_tcp_ca(void)
 {
 	if (test__start_subtest("dctcp"))
@@ -399,4 +507,12 @@ void test_bpf_tcp_ca(void)
 		test_incompl_cong_ops();
 	if (test__start_subtest("unsupp_cong_op"))
 		test_unsupp_cong_op();
+	if (test__start_subtest("update_ca"))
+		test_update_ca();
+	if (test__start_subtest("update_wrong"))
+		test_update_wrong();
+	if (test__start_subtest("mixed_links"))
+		test_mixed_links();
+	if (test__start_subtest("multi_links"))
+		test_multi_links();
 }
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/te=
sting/selftests/bpf/progs/tcp_ca_update.c
new file mode 100644
index 000000000000..b93a0ed33057
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+int ca1_cnt =3D 0;
+int ca2_cnt =3D 0;
+
+static inline struct tcp_sock *tcp_sk(const struct sock *sk)
+{
+	return (struct tcp_sock *)sk;
+}
+
+SEC("struct_ops/ca_update_1_init")
+void BPF_PROG(ca_update_1_init, struct sock *sk)
+{
+	ca1_cnt++;
+}
+
+SEC("struct_ops/ca_update_2_init")
+void BPF_PROG(ca_update_2_init, struct sock *sk)
+{
+	ca2_cnt++;
+}
+
+SEC("struct_ops/ca_update_cong_control")
+void BPF_PROG(ca_update_cong_control, struct sock *sk,
+	      const struct rate_sample *rs)
+{
+}
+
+SEC("struct_ops/ca_update_ssthresh")
+__u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_ssthresh;
+}
+
+SEC("struct_ops/ca_update_undo_cwnd")
+__u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
+{
+	return tcp_sk(sk)->snd_cwnd;
+}
+
+SEC(".struct_ops.link")
+struct tcp_congestion_ops ca_update_1 =3D {
+	.init =3D (void *)ca_update_1_init,
+	.cong_control =3D (void *)ca_update_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_update",
+};
+
+SEC(".struct_ops.link")
+struct tcp_congestion_ops ca_update_2 =3D {
+	.init =3D (void *)ca_update_2_init,
+	.cong_control =3D (void *)ca_update_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_update",
+};
+
+SEC(".struct_ops.link")
+struct tcp_congestion_ops ca_wrong =3D {
+	.cong_control =3D (void *)ca_update_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_wrong",
+};
+
+SEC(".struct_ops")
+struct tcp_congestion_ops ca_no_link =3D {
+	.cong_control =3D (void *)ca_update_cong_control,
+	.ssthresh =3D (void *)ca_update_ssthresh,
+	.undo_cwnd =3D (void *)ca_update_undo_cwnd,
+	.name =3D "tcp_ca_no_link",
+};
--=20
2.34.1

