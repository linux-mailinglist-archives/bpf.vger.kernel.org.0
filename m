Return-Path: <bpf+bounces-12595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15027CE653
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC25B212E8
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366D841239;
	Wed, 18 Oct 2023 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="syhjjikt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06B43A88;
	Wed, 18 Oct 2023 18:24:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79896116;
	Wed, 18 Oct 2023 11:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0RDx3bJPuCuBJ9wynzkEBReHn2FM01wskBg08zW4k9V4hjoGzIBZ6iWqadB9rnMDu5iGydNZifRhGoIs0GntiUGELwFhzErhpB/MJlAxySQbuhhLSfNYAUxBxULWIQYUz7c2l8HOJtACvchRpLS2NDaKhrrrLpGdPTQbHrnrV8zZ2f94jqYySiA5mBoBUbnnMZpvo9naN5JCddt/9cyKJnOloOY71iBQkU14nefjLTm0+dM77eKhrSbAgOWSFemktvUWCeh0R95oiGTU4hqyH92hmkpTWTzl7ghczUvV0dMpEMKWsVGwWGxTpFAOhea+IKryO6xhTW1JunwKAkH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jScZYWimXlTit2PeLxDoPXYv52JO/PE1vC/Fa5Rnt0Y=;
 b=bj7Idmsu7l0NHk+AZki6axPNnT054dNkN7sk1ujZuZqO7z34bEbvvuNYxHXYKpx1nCV9eNJBzxmu9nbPQ97uyl1qkxB57dnrxplrvcn07BZ4u/hODkGJm3p6f+rmNXHfv1UCCJxhsdnMLL+baGOviKbiwH8iEuO2RRHuFNLy9E8eFBg5nMQaiRUAzu8pzQYqeDvpPZmVtWYBjF/5kFEXo8jT9HuxlrFBgmMvVdYrQVN2FXReZ54vmZWQMBfYXDWdPsYhYCWImxeYsKi9gXpxRZzJmKAPdvsh8PppizG3ut0v8ywjtIef5lckxMqnSFfmz/0BWem3JlxXu6ie1PzApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jScZYWimXlTit2PeLxDoPXYv52JO/PE1vC/Fa5Rnt0Y=;
 b=syhjjikt4Yt/2efI3mWdo53bjjE5ZMpNojlmLNJtGqWdc2PfUQlkmR7dTruM9fTEwl40QULVVUf/wzR7M03+Ch5kX867fk6xTVfB45JyXMwLFsm+MNfXTeU8wpAazSzDI2dvEkln0ul5YmJewKsOuVcdyp2yUU4x8TJMDoen5g4=
Received: from DM5PR07CA0118.namprd07.prod.outlook.com (2603:10b6:4:ae::47) by
 MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 18:24:34 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::57) by DM5PR07CA0118.outlook.office365.com
 (2603:10b6:4:ae::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 18:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 18:24:33 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 13:24:31 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Harry Wentland
	<harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
	<stable@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Nick Terrell
	<terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Masami Hiramatsu (Google)"
	<mhiramat@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Kees Cook
	<keescook@chromium.org>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, Li Hua
	<hucool.lihua@huawei.com>, Alexander Potapenko <glider@google.com>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, Rae Moar <rmoar@google.com>,
	<rust-for-linux@vger.kernel.org>, <bpf@vger.kernel.org>,
	<llvm@lists.linux.dev>
Subject: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
Date: Wed, 18 Oct 2023 14:24:11 -0400
Message-ID: <20231018182412.80291-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cee09fa-d92a-48b9-a4c4-08dbd0077a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Vc+GWlelbTTNNamBK4X1a4rfZn66Ci9zkdzmBPKtU7edErhOLabCqUjeV5l9mgB+2h/nP1CNNYbYCF+nIi4eH/+WXoKgswnmlli1AMp2sj5KPKUzCqCcmugQ9vTfuyUcwguxar4mCJTD5TW3rxhjks2nEEoHXIkQZUtLBgL0XTi4R/rewaSBsjkC/IF3m+Y3XFC+7/deeTbSLen9eL5eDaJqLDALQvcuMlWbRJK+I/DtbDq20Jckeajx5a8YxEG5VrMsaoUhB6cC40Pl+h88PZJIsUHbvGluXtK6Zwc08v0Kk/xdxC2CSiVQXPW1phfznrEPGeztFilzzb8oUtPOwzYr9A5g27ViOmtHBXPzjpSI1OndLeEfijHzjZuyIBMloeTs55YotRbY/wgQN3bhODadfKFiWZbz6ZAIOyb9nD3phi8d3S4ggdXIeK28sJoWzyC3/YpIC/Mh9UiuWL1yF6aCT5Pmdzn7fsSVvpH3jd7P0YPm1oTXcuM/Fro0I82aH7sTCnYVGQWC/yEi0PV9fdWifGzCfh0i/x0AZTP0jCUYhs4EEQjCCr5WkWtcQZnVZgzdQQgjoB9cEJAACiBfAxvoy8nuqh94MaukuC8JooZs8WOLB/kxw2KEkQHs9YVUJtKh7O3WqiaBZ9AOBtA/2ZyS38OIPUufxQoDO/F2u8I3UvceItruwI5QorhQcwtVocTxx2jF1OTR8/mZ1a86bAdugbgLO47cIFBN3KzZE7ncEsgGGLwPtH6OlKSqHgAqTvFZvR/IPwEyWuZUZbtyU6RDOGuKqvqUU80SvC3JlXGQp/y8V/9kKXrDEYoEznd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(47076005)(4744005)(36860700001)(40460700003)(6666004)(7416002)(83380400001)(70586007)(70206006)(40480700001)(54906003)(6916009)(316002)(2906002)(41300700001)(8676002)(8936002)(4326008)(16526019)(26005)(356005)(44832011)(82740400003)(81166007)(86362001)(478600001)(5660300002)(336012)(36756003)(2616005)(1076003)(426003)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:24:33.8319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cee09fa-d92a-48b9-a4c4-08dbd0077a59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With every release of LLVM, both of these sanitizers eat up more and
more of the stack. So, set FRAME_WARN to 0 if either of them is enabled
for a given build.

Cc: stable@vger.kernel.org
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 lib/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 39d1d93164bd..15ad742729ca 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -429,11 +429,10 @@ endif # DEBUG_INFO
 config FRAME_WARN
 	int "Warn for stack frames larger than"
 	range 0 8192
-	default 0 if KMSAN
+	default 0 if KASAN || KCSAN || KMSAN
 	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
 	default 2048 if PARISC
 	default 1536 if (!64BIT && XTENSA)
-	default 1280 if KASAN && !64BIT
 	default 1024 if !64BIT
 	default 2048 if 64BIT
 	help
-- 
2.42.0


