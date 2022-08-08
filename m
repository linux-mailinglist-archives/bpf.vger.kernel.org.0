Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDEB58CA6B
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiHHOSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbiHHOS1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:18:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F81275C;
        Mon,  8 Aug 2022 07:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlfE1RtO6mRhg4HAcK8gB44K9HlCGizanbh7EGo6Ep7GqEbVZnR8kdkekRPpb8vdc0tdc6QKuP3G1FTVLluOsuozXjoHxY9yNxjJEwRB2B9mO5md3nrv9VE5M+lZKyjgnI/qgAD3cmxV1f0dwvXF/iiBnDj6mBePRzGO26CI0NmIBGbPhD6Yt7C/ygtFkrfRcwqaXuhjB1H7sQibXeOa6BPegIlpg+LtDykZlVMqD2d4041JWzc/nu/8AcXPXwg7jfCEy2P7BbiGSng+fvUWTEebV/FFuLuI9RfvY9wFwLA2eSbVP1nNiwWyUXXdOPA7urthP4tOPcQ8r7Vbna5fkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5khCtqXtMkcTXDb2jDIsDb6j10F2RoOqg3tIghzE9M=;
 b=NK1przmJeQ9fL+jSUC5yjjvsRrIYzi9KAWJqo0muQ97ss0abC1RLepXLbvDgD3Bnp06WkMHVmHl4RDXDDwORIr25br8ZdEG7qwdfeV9hsskbSw3hXMa9h2kpTtDmllo2DQLouUaTLURmqtEKekTvbtUO1D25swElWmmG8ra/6sHHOrpNt2KAJCr0QQtOfew74ilYh72vjsVGigKcmwWUGYhvDD3Sle5G+uSw/MeB1RTBnzjAvxpYfd1upGIK6Q7bU/trS4XXNfHlgpHteQ4ftsGYPdRBnvy78NJCPPgFilWMVU2/4A+2oAGU+2tnmDbaTfQylV08aI9rzK1oN/d86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5khCtqXtMkcTXDb2jDIsDb6j10F2RoOqg3tIghzE9M=;
 b=rz0ixvCD78OdzwAc26x9eiDrK8uHQ6OByuGkdODj6IyJg3+jjL9xHdk4oWLlIAY3xBMCC79R0VxFq6TwKWj+9OX+vMRJ/3ud8ihO2qKhKMk9gqJLtfNLP4RLchtYbh88niYHJxrq3izPMlx+QsRwYVh/YUCe/JotQpfp+xZ2+zU=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 14:17:55 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::cc) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Mon, 8 Aug 2022 14:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 14:17:54 +0000
Received: from fritz.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 09:17:53 -0500
From:   Kim Phillips <kim.phillips@amd.com>
To:     <mingo@kernel.org>
CC:     <andrew.cooper3@citrix.com>, <bp@alien8.de>, <bp@suse.de>,
        <bpf@vger.kernel.org>, <jpoimboe@redhat.com>,
        <kim.phillips@amd.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <thomas.lendacky@amd.com>, <x86@kernel.org>
Subject: [PATCH v3] x86/bugs: Enable STIBP for IBPB mitigated RetBleed
Date:   Mon, 8 Aug 2022 09:17:02 -0500
Message-ID: <20220808141702.10439-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Yu66YlFzd4VRZq6/@gmail.com>
References: <Yu66YlFzd4VRZq6/@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 817e7b9f-ed73-446a-87e0-08da7948c940
X-MS-TrafficTypeDiagnostic: PH7PR12MB7138:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLrxwZXLxUwWRP/4MUFkcq5AdbF+Kgyww1gsOCmCze/mpkvUxqFYVygVW/adhoO8sb9IHJ9Zeqgmgp9/9SBi9E49WXT0+pCjqP+8eFL3jbAoFCegrjF2ISES2OfkjhEcnf7jMYHc7lZSSOmWffbeUVGzyWBCKAYN0qFhYaYucZN6Agl6kvWTVRIpyxzoKarrT9fB6eRpvmAAi5RWPp/cTtQ5MzemQe2PLHndblLlKIJt6rUmLCUvaMjdZv5Ru7ftTPFenedsUrU9+KCuoHIh6orimtTfUBjl8XbSzy20iOy98lQfMHJcii8P8bhdRNpxojvQJvJWWIhT+BBg8uSBw7B7l54jlE/QP7xml7JvogRF2yRbm0LyPIqnylLaXX4ioxMYePMHW8Yxh7iBVAuRL99xCn9J780mP7h9mE3umlsx0/1Hevxku6v/VvNz74lqesCgCP1NT6BrP+SR2B/ePvbpyFWNB1x1e3jaVU2CiflKfDQNeYZ/U24ISZLSRUsgTYpyjGqgDLLWKfjyebdGp/lrlcHdrOz1JEgdD977PdsmwNPjosOJFM2g1FibGYfNaXByXSig6BWkNotJO1f1XmyOmNYwmPWCeIo4xxqNbxlGFTvKJBPpzl67OnHCaojxjhZKaVvuCj1VmvqajaMk3E2lsxO264jeobmA37MPekNNNpIjjWIkEapLq0ZqoAM5oDYP7DcjU64O0+zzBX5RuOF/Qcaw86rA6fclg5ddEL2rngLwDaiBp2nwnBFT3J7wKwpnKTSseqHZe/Wa5FIVjfCDauL16E1YznFLW41YDrV+CStoJtckTInuvfzYE7TvW2tEYvzlgvnVVVYPK1wDOctRwehn7BLMut3RWtIGtFx5veLm2effcj3AIjzmIF6R
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(40470700004)(36840700001)(44832011)(5660300002)(2906002)(70206006)(82310400005)(70586007)(36756003)(6916009)(966005)(478600001)(316002)(40480700001)(54906003)(8936002)(8676002)(26005)(81166007)(86362001)(41300700001)(6666004)(7696005)(36860700001)(16526019)(4326008)(356005)(82740400003)(336012)(426003)(47076005)(186003)(2616005)(1076003)(40460700003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 14:17:54.6464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817e7b9f-ed73-446a-87e0-08da7948c940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

AMD's "Technical Guidance for Mitigating Branch Type Confusion,
Rev. 1.0 2022-07-12" whitepaper, under section 6.1.2 "IBPB On
Privileged Mode Entry / SMT Safety" says:

"Similar to the Jmp2Ret mitigation, if the code on the sibling thread
cannot be trusted, software should set STIBP to 1 or disable SMT to
ensure SMT safety when using this mitigation."

So, like already being done for retbleed=unret, the also for
retbleed=ibpb, force STIBP on machines that have it, and report
its SMT vulnerability status accordingly.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Fixes: 3ebc17006888 ("x86/bugs: Add retbleed=ibpb")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v3:  "unret and ibpb mitigations" -> "UNRET and IBPB mitigations" (Mingo)
v2:  Justify and explain STIBP's role with IBPB (Boris)

 .../admin-guide/kernel-parameters.txt         | 20 ++++++++++++++-----
 arch/x86/kernel/cpu/bugs.c                    | 10 ++++++----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bab2b0bf5988..ed6a19ae0dd6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5260,20 +5260,30 @@
 			Speculative Code Execution with Return Instructions)
 			vulnerability.
 
+			AMD-based UNRET and IBPB mitigations alone do not stop
+			sibling threads influencing the predictions of other sibling
+			threads.  For that reason, we use STIBP on processors
+			that support it, and mitigate SMT on processors that don't.
+
 			off          - no mitigation
 			auto         - automatically select a migitation
 			auto,nosmt   - automatically select a mitigation,
 				       disabling SMT if necessary for
 				       the full mitigation (only on Zen1
 				       and older without STIBP).
-			ibpb	     - mitigate short speculation windows on
+			ibpb         - [AMD] Mitigate short speculation windows on
 				       basic block boundaries too. Safe, highest
-				       perf impact.
-			unret        - force enable untrained return thunks,
+				       perf impact. It also enables STIBP if
+				       present.
+			ibpb,nosmt   - [AMD] Like ibpb, but will disable SMT when STIBP
+				       is not available. This is the alternative for
+				       systems which do not have STIBP.
+			unret        - [AMD] Force enable untrained return thunks,
 				       only effective on AMD f15h-f17h
 				       based systems.
-			unret,nosmt  - like unret, will disable SMT when STIBP
-			               is not available.
+			unret,nosmt  - [AMD] Like unret, but will disable SMT when STIBP
+				       is not available. This is the alternative for
+				       systems which do not have STIBP.
 
 			Selecting 'auto' will choose a mitigation method at run
 			time according to the CPU.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6761668100b9..d50686ca5870 100644
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
@@ -1179,7 +1179,8 @@ spectre_v2_user_select_mitigation(void)
 	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
 		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
 
-	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET) {
+	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
+	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 		if (mode != SPECTRE_V2_USER_STRICT &&
 		    mode != SPECTRE_V2_USER_STRICT_PREFERRED)
 			pr_info("Selecting STIBP always-on mode to complement retbleed mitigation\n");
@@ -2320,10 +2321,11 @@ static ssize_t srbds_show_state(char *buf)
 
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

