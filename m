Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8058A121
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiHDTWO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 15:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbiHDTWN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 15:22:13 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361BD167EA;
        Thu,  4 Aug 2022 12:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOPbrHtTeGuhFeMzRHqIMyB/hvXysbzirw+Ll1npBe2SxkMSSddksOobTM6RoZfa6gmD3MoFmtaccwP4YE5dqDnYvU7ePg9bjKyjxScJe0l4VivFxFaEqX+MMCP3uEKp6eqSVpJqcoDoy1NjS6nRcR3VErt4f7weKk7ZA1qZCS18Xu7CXnOlKFfFFoDEP8Ki75/p9HK8latTE0//pWQbRSeNu78LUyvPksLEraswT+X19n8FFMWaj+JuPDbqOmbOfun7ioxDme3K85aKO+bHN0ayoJHCGXmmerEn9ty1rjft6eBdV+oVebZUPvLrZSIAOM6qW1k4qyVR+ZwObBRYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNrHSdqyVX9MIzSR2G7ifuSr91LQ5PxgkCZumwByzM4=;
 b=mpVgLu8ACinLrfjY6/1NaF5AZomEWBRDTeMuXFZ6AWjHE23fIVUsJM2vrEVNKwXmsN63ftKC01Vg3Koa9reV70On1E+Xta7J46xAx+lDpAgsaWh9UMFL3AL4ZyvnYg06ZQGocFtwOYLC6XQbwMfb3P7cX/L03hgx/7lmF8vmdLFlJh8FjfDuB/UU8UykrLN+QAF3YcEbM1NUUy6oqDNV+8D1CXJWwfWoBw2WwtWHfNouWhZKYk1PyXoTN9xeHVHQOOfQUqhC5NT/W7iu/ebJz864s490PMMoAxWpgW1VGphqCBpSnhv6yfkWEM+VYFlBSO7Pe/t+Y7D8uml0DMzgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNrHSdqyVX9MIzSR2G7ifuSr91LQ5PxgkCZumwByzM4=;
 b=LiN3vTW+85vQ5ysQNwNIj+dbsqjcLrFEgXfori05SjXJq+Z/j1lxQjAO8z5wJyANis7LWj2J3pGYvBarEogOx5QrkdRoMS1aR1ej1ldwgjj+WOxvzaEOQUbEA3YUOP1fU3pEXYMzKYSnSQ6TjuSz+zbShAJdvP6dZPoAyRm5uYg=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by DM5PR12MB1404.namprd12.prod.outlook.com (2603:10b6:3:77::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Thu, 4 Aug
 2022 19:22:09 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::a) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Thu, 4 Aug 2022 19:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 19:22:09 +0000
Received: from fritz.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 14:22:07 -0500
From:   Kim Phillips <kim.phillips@amd.com>
To:     <x86@kernel.org>, <peterz@infradead.org>, <bp@suse.de>,
        <bpf@vger.kernel.org>, <jpoimboe@redhat.com>,
        <andrew.cooper3@citrix.com>
CC:     Kim Phillips <kim.phillips@amd.com>,
        <linux-kernel@vger.kernel.org>, <thomas.lendacky@amd.com>
Subject: [PATCH] x86/bugs: Enable STIBP for IBPB mitigated RetBleed
Date:   Thu, 4 Aug 2022 14:22:01 -0500
Message-ID: <20220804192201.439596-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c513011-901b-4612-858f-08da764ea030
X-MS-TrafficTypeDiagnostic: DM5PR12MB1404:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svMM06aFc4X7c1gGhmtr3TLbTP6Szt2liIl0T1bt37a+c0DE/38zVrJQoCDI6b+ICmB+qdSm/ebnhtesWAqxTMYvOa/2T3/OsTiEyuKJgzoDq47GLv3LtwlrBwVu/vVSWXrpb7aVNlKlQ/xx+HQPpujwNpCTsQY/HMY9ISLD2BtUC68891t3dZe8xUKW4e7a/T/U/oWaeHl/TXXCGgjZw0pv/l/EGnEEHuQte4Ko7OEA4Li/3ku/GaYETM1hUZmCoICWOSnkG4p/FbA4ni7halSYuWf1tQI4KM47PHMvhIb4K2wTv9xKCCHYkIFOTJvjWRRFzWT8MfdaTMiCqR3NObrQiEHtIxQItwvUcZ6M+UoUggfo6+i55v3sNqRJEraVY7/A+SWiTuTFvgqQFtHW1bWs9VEHJvLQ1k8RpboOJz1xN2vXFGBKU7WV7XAPQJVZlWL+O8vb9eJZsk/b8Ee05ItCImT+RJBpPrtFxwGlsTqDvWgiH0qO2zWbZK6xmGQQ0oRYDJsZR0Mp8tEtnCkJvz5LFFfkRALrvlkmtjkFy+4rdUk6FJuPEMfHyG7nfp3BHoUbuxbPGB0o992mcWnjAv24BQHgoTRCtCES7yjZb+AWYUNcn9HW2hXf8TbZQAoT9IwaE8G8h8h4U3uPuZb+Jzdl7BJDxJ3rY1RGrvRtN7vXWuaMr7xv//xQMAjYXhjUW35xXYSIMp5CvBLvGA36cGnF6rUXFj4bhFoLIYojpNiZ8ZzoqLjAnB/PlV+gXHdZNg9OmLnjCi68bUCp1fB03Lo4DcF0HhBMOWw0FE9KcHj4N/8afsc7DSJpXeI7Pc8TXjG2iQlv1a7pLgT0T5Ew1/QcKYCxQEipPj3ZYOHjPg4tHrmTvgs5tbiUDITs894A
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(40470700004)(110136005)(70206006)(40460700003)(316002)(70586007)(82740400003)(1076003)(5660300002)(40480700001)(36756003)(478600001)(81166007)(8676002)(356005)(2616005)(54906003)(4326008)(8936002)(16526019)(336012)(86362001)(36860700001)(83380400001)(47076005)(426003)(41300700001)(82310400005)(2906002)(186003)(44832011)(26005)(7696005)(6666004)(71626007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 19:22:09.1688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c513011-901b-4612-858f-08da764ea030
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For retbleed=ibpb, force STIBP on machines that have it,
and report its SMT vulnerability status accordingly.

Fixes: 3ebc17006888 ("x86/bugs: Add retbleed=ibpb")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +++-
 arch/x86/kernel/cpu/bugs.c                      | 10 ++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 597ac77b541c..127fa4328360 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5212,10 +5212,12 @@
 			ibpb	     - mitigate short speculation windows on
 				       basic block boundaries too. Safe, highest
 				       perf impact.
+			ibpb,nosmt   - like ibpb, but will disable SMT when STIBP
+			               is not available.
 			unret        - force enable untrained return thunks,
 				       only effective on AMD f15h-f17h
 				       based systems.
-			unret,nosmt  - like unret, will disable SMT when STIBP
+			unret,nosmt  - like unret, but will disable SMT when STIBP
 			               is not available.
 
 			Selecting 'auto' will choose a mitigation method at run
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fd5464ff714d..f710c012f1eb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -152,7 +152,7 @@ void __init check_bugs(void)
 	/*
 	 * spectre_v2_user_select_mitigation() relies on the state set by
 	 * retbleed_select_mitigation(); specifically the STIBP selection is
-	 * forced for UNRET.
+	 * forced for UNRET or IBPB.
 	 */
 	spectre_v2_user_select_mitigation();
 	ssb_select_mitigation();
@@ -1181,7 +1181,8 @@ spectre_v2_user_select_mitigation(void)
 	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
 		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
 
-	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET) {
+	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
+	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 		if (mode != SPECTRE_V2_USER_STRICT &&
 		    mode != SPECTRE_V2_USER_STRICT_PREFERRED)
 			pr_info("Selecting STIBP always-on mode to complement retbleed mitigation\n");
@@ -2346,10 +2347,11 @@ static ssize_t srbds_show_state(char *buf)
 
 static ssize_t retbleed_show_state(char *buf)
 {
-	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET) {
+	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
+	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 	    if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
-		    return sprintf(buf, "Vulnerable: untrained return thunk on non-Zen uarch\n");
+		    return sprintf(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
 
 	    return sprintf(buf, "%s; SMT %s\n",
 			   retbleed_strings[retbleed_mitigation],
-- 
2.34.1

