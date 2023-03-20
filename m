Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A9B6C2182
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCTTcQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjCTTby (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:31:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA44E04D
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:38 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH6eJs020560
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=cLGbrYiSP2GxYN6pv6+F/7L8SNzfXLZ0+yVDwT2Ok/w=;
 b=g6C9NoFog5xSgBxSdWr1JLLnmXHbOoTPvQOe4Q6TZRtaxhE6Azf3whcNt2ufEeMak8kS
 tGIF0G5gHw4QTWxs/EniwQCC/MvEdi6A05QKR6iXVXHKThFaUywyAtUwdISAFnMBsa3z
 n+GBA2gjYXtrNl8WJj/ta8WSv6r//aR1S5VdB4uw678YpgLli7+ad+3hubuUQbhx/ddg
 5PT5stfWJtXTJ2WSnWHINEn59l/yOcUc0tfvvOoswIeA7vX87sYWk0UO8sv6NSsUWLCW
 jTeeDdWrkneNjmbjo794bi6srzqxPfVlDwEkYiym973M4UYxbZoryFMNhqKQVGusiomm nQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pd9br3vfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8/4MHwYUa/+R7Z6+U4qoGorRbBbnys5TEZlxeJ2gf8y3zCjP7iqYMkuN2VxM3sA6PAumJac00r4AWiqzsQsBgDQb0iaCKtuX4t8Spbt/XiHP+j8ER42dZZWug7deSZ9pHGqs/ttkVONu37/GVZ+EILfi1MrRHibyG/dp2tHUSNN6f0u2ksXHk51pF88+IPTtsr6BEPmCEgp23xUAfyTf/vsivVeXimxmWmqjJZb72Hfokh7DU+khuYfXHWbFCXnnd7bN7IYyK5n9i9joQ/wi0C+jXGBhCI5hro1+2eKM9YNCXHQ7GJmAUlVruay1FhcliaCo77DvHFIiqgFQIWhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLGbrYiSP2GxYN6pv6+F/7L8SNzfXLZ0+yVDwT2Ok/w=;
 b=ViYFN3BSqIsat0G5ZGqNPCbkWzKqZ5NrZXMYf1JCw4fifsoL8SGIE3wnxxT+ahzl1ggAaBrXGR9nf/B6zEwuZhC+XrkpACRUoas2FGGCsBT9R4WW5RU72v1y8O2vWer1xkekV7GPrt+mmUNlqJe1Qaug3LcgFPpbyy/Ev9RIAqGpfq0jLkMSTPXg69sUht3nzUdf92asVPXDtRy9q8HiOj05XLW670NS75mTOdw0SIaKo3TyxOJ3XIRTWgA3MvzskuTMs0E4ZzvV5FVtK9yA0Hjl7EcOOP2H32la65qNO+uZ4x4W0OlEUvSF2WfrNbHgkdDAqP72wXR67eq8BVLf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by CH3PR15MB5611.namprd15.prod.outlook.com (2603:10b6:610:14b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:24:36 +0000
Received: from DM6NAM12FT103.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::af) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 DM6NAM12FT103.mail.protection.outlook.com (10.13.178.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 19:24:35 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id E64987D43609; Mon, 20 Mar 2023 12:24:12 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 8/8] selftests/bpf: Test switching TCP Congestion Control algorithms.
Date:   Mon, 20 Mar 2023 12:24:10 -0700
Message-Id: <20230320192410.1624645-9-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320192410.1624645-1-kuifeng@meta.com>
References: <20230320192410.1624645-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT103:EE_|CH3PR15MB5611:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c40b8b4f-7fda-47b5-8745-08db2978bdc6
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lg7uD3sEDK9y51ELcT/KZ3Etl3hK7yhvaWPiSD/6/Oq71bW8GJnX5FPTsQOMuwLVf9JVNqeC/32BpjXzUNQ3CJskVtzxY/evlWC3XOJz95UsW+NPFqIJpNhUj1hgsDBILyPoNIPNbFItnuVp2JkPcFXmM9l/GstLVEv2sb5et8D4C7k2miIEwOm/3z71SI/dH5LmdpniacNy+BgwcFwg2ANyGIiIIYGb49kI8rXsi+9oGa1na/h6EAKTBarvaXHsbYkwroV/EFwqY0pWwod2GtQEDX+DBv+hlwF6PEg391U6jvJnIQj0Kb5JELohgNgAyk2uWAyhj74ahYKQbilgTsCy9++2Aj+HT7fc6GHrO3ZCq67mF4W9SYJoiEAtbFoRzENbUNH3/ldsPTl4u/++vKeJqdttWMLvkIhYiyRVwjHA5kiY+CnLtAwphnY95q5BoH2nLChxhfSCUfaKL01LIWFftxIU073Jx1z8FhrHMGar8OA0I9GWrb/mjk+0cZltVmLP2uyj295G4OfJvdAcpjSzrELyOTD1be4XbQPLDRoBkgGIDT2ZiBMNCVd3AsEyWVu1ku9GL3on6oWNXoP2qZQ//eidnP6Y2S1QXmUEq+CNJ18pcBLPW5fn2T0zFHSWAfSwi08YusHxAp2C/0QdO8wi4TCTGxC4hgSrxzzOk3YJvCK/4xGuQexELHB2FZUqFjI1sXleU3iTfx9W5l2dYA==
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(47076005)(86362001)(42186006)(40480700001)(316002)(36860700001)(70206006)(36756003)(8676002)(4326008)(41300700001)(8936002)(5660300002)(2906002)(7596003)(7636003)(478600001)(82310400005)(82740400003)(83380400001)(40460700003)(356005)(336012)(2616005)(107886003)(6266002)(186003)(26005)(1076003)(33570700077);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:24:35.8838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c40b8b4f-7fda-47b5-8745-08db2978bdc6
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT103.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5611
X-Proofpoint-ORIG-GUID: u3gelMXBJLRHuxAAOay8Ysm5hhcyQGZm
X-Proofpoint-GUID: u3gelMXBJLRHuxAAOay8Ysm5hhcyQGZm
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

