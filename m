Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733E658B16A
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 23:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbiHEVwt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241401AbiHEVwa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 17:52:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E12127;
        Fri,  5 Aug 2022 14:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEVAAZW1BkUGLIN0+HicoAvUWdhozN7n//Xnwl3Q/WumE1iRkZjzF25tPNNifysUVTZK7cz9f74YKTXiJtPJAoRQa4K+o0N7aA+Ey310ikSxC3ZM0COoBgEmYL06v4twbLxOqsSYObPlHcBoAv9vUfwEUj9nPKqjFhtLnsTUDejsQO2A5ugze+8higlZY1abx2g9hA4Bu9dLiSrifwGtnD+HVo73HrarIOOw6xI5Adj2dsEcyFgvGQk34VOoPASao2a/JtF4OGsLb5wcQz+gIRNrjlx0dQGZRZ9j+zVUVy3YADvxceyqhG5jpnN8JEMKRRa1MTbtAREmnP+Kfgwj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3Np1u/ivq/SZM1VaLFZDLQNHSmKX7VXBtgnRfTPULw=;
 b=MYtpV94PniBBke8OfUv9mduaQvQN+2UBjLbXhOl4x9bXwtvYIx/6PLd0YqxuqmHi9PPtL4ZWfT3W+Yjktj2Njr9rmcaKbuqFrnKWVUhmXPs83PBNI/97v/oHSosK9R4EJqXbSD1ar3L5hTTEfQXsZKEPW1RiUvEF0eAd30su3JGB2EYzm3BigBBcuU1s4cRXMUetF1oysOl2dwkrZUCuNTbCyroRYef7uSYZC87kJmFbRSpFQugwwl2i3XPFwz6hxeRTDiYo1839OcMBS5C9+a666Bze2tqvNu0fB8vAwnmqwfQvHcSlIhi4gtsLwze+UsQTvsxzePGq3UTzXPxmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3Np1u/ivq/SZM1VaLFZDLQNHSmKX7VXBtgnRfTPULw=;
 b=a9PB6Ct4ZL6gljCILFxOGehn2rwelXMJknaEth1z0FcdWBA8kMz7/zhiemxhE5fBDLG+0ohgcRqTlKLP+Z7L/ERLrQRrVJh1f8axzG/M3CVvEfCY7juZjQfghCDaxXIFNC39HJxY9PZ96AHXKkX41lmuKmEhN7Vc8VljJ99R+hM=
Received: from DM5PR08CA0047.namprd08.prod.outlook.com (2603:10b6:4:60::36) by
 CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Fri, 5 Aug 2022 21:51:59 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::1d) by DM5PR08CA0047.outlook.office365.com
 (2603:10b6:4:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 21:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 21:51:58 +0000
Received: from fritz.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 16:51:57 -0500
From:   Kim Phillips <kim.phillips@amd.com>
To:     <bp@alien8.de>, <x86@kernel.org>, <peterz@infradead.org>,
        <bp@suse.de>, <bpf@vger.kernel.org>, <jpoimboe@redhat.com>,
        <andrew.cooper3@citrix.com>
CC:     <kim.phillips@amd.com>, <linux-kernel@vger.kernel.org>,
        <thomas.lendacky@amd.com>
Subject: [PATCH v2] x86/bugs: Enable STIBP for IBPB mitigated RetBleed
Date:   Fri, 5 Aug 2022 16:50:09 -0500
Message-ID: <20220805215009.498407-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Yu1Zj5mNZiAWdJgK@zn.tnic>
References: <Yu1Zj5mNZiAWdJgK@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa44e9c2-5da5-47b4-d953-08da772cb890
X-MS-TrafficTypeDiagnostic: CY5PR12MB6060:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzkNyI7fuIlqQJ0eGmBVMOayjl8/QPtLwloLPfoooB5qo7aPcsueLl2tNxRqUIxH848H0sDeSvpREzQmwUr7d/H2XhAO9OL/e6fuKk+V33cLJekhyBDv8b19p3sOYBUtre2sA99WQHdf2nt8LIwhjBfIsEr5NROcDJfyXVBcATGP9GALqKQ+ztV+ofGgbaVjo8EhcVTEYz/c5yoLyP335C2PnR5Q4XnhmLE5dOsM+lwqkLgH7H+jtwrYOsgkGWIzgwYesytz2SCyZ7xXa6DBD3UCIEXjOLjkcvROjPKU8dRSNZ0oJUQZR0UicOAEs8TL3z8TQ0VLWzEWpsnjKlGRGpi0stEOGYqJ05KElWS/GJKfXoMStM9+GJj9TTqckmfJnMzF5K/LmIM/XG5Ub8gN3bQk3uYVYYKeYctpQdUJ3xDbpGT7blwD919E3nT5ocTrtoyud3WnA/aV81gint6UL9lygY+AyiK2Vw9xzm5+uZCkZvJCYCXSOqvb5CB80195URzDmxa7s06l1BWFrJwiigE6AgzYGuRWOu2S4Va4SqK3ZJNl9wiV1B8ZNZA5ejtZLdho/qZur8LsJ43Zk8U6FCSD+Yr5terlNF5t4ftB9YGQbM68rwCsBSptoOFBIXwYbqUIWMTOAA5JsgarAMtx4usztgJpCcV81vsfLyIQsMkkd8WDFHvuHhi2Sp4+h6jF6mvPj8ekDg2LzkwIXLTPABqPBxU2X60xDK+ku2exqnQ5kuJAYGX5uHsXR8IMJlcZ5NnLcckrHUgc53KjY14lzcGF/tUw4pJ4PCu+ZxMjsmtD5pkbeX1Pg2HqaAk6hheaYkRQIw/XVIRpUxtoavaMdf2fLye+egxPeo1NhSeiQZi17zMXm1tYJtSEql9n4YVLgnE+LM6stV2Dvqk5UK1EMzKdlducx9uIXmKCjOhUY1s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(40470700004)(36840700001)(5660300002)(316002)(4326008)(40480700001)(16526019)(2906002)(82310400005)(41300700001)(44832011)(478600001)(110136005)(54906003)(70586007)(70206006)(6666004)(8676002)(8936002)(966005)(36756003)(2616005)(1076003)(7696005)(336012)(186003)(47076005)(83380400001)(26005)(36860700001)(82740400003)(356005)(81166007)(40460700003)(86362001)(426003)(71626007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 21:51:58.4175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa44e9c2-5da5-47b4-d953-08da772cb890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060
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
 .../admin-guide/kernel-parameters.txt         | 20 ++++++++++++++-----
 arch/x86/kernel/cpu/bugs.c                    | 10 ++++++----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ef9f80b1ddde..c1061e7df55d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5237,20 +5237,30 @@
 			Speculative Code Execution with Return Instructions)
 			vulnerability.
 
+			AMD-based unret and ibpb mitigations alone do not stop
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

