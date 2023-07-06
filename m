Return-Path: <bpf+bounces-4203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD4749760
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B00E1C20D27
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1C5226;
	Thu,  6 Jul 2023 08:20:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581CD2112
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:20:16 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955571988
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJUE3MEVUCmTuiBn0yuXbjsHXLjUWp9JOXTC/pmdIbDndaBB5R5HOFam4Snoqh9Baw327C8uPflRizuYe55G3/hAnnkWB/vJes3788DBFsg2TYhtl4w33kXJBkGUXr2xAMfaQ480SvluKbzHkOJsxPO6GNa8qbWFmf6HEET4iRJTtzTXWwUd1fRO+ISmA9+YFOwzqWzQP6F34+pADDCx4UU+tOqaCoMJ6jvfxrKzw7B0MdT0aKToFIIaibAJAT9H2482n1aK3ztv8F61GN/WtycUa5OYe5BmRaA8vyY5lKWkJ6QTnz4y5wLkMWizYzyb4JuF/cumtwTRCP0ak1nECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFcnVtBZ8UP2TGfsabD++11bnT8sUFM686NQ5RYwVgI=;
 b=WBS4Kg01R7dylAeS72B3BC6q8rlZyYQb4BPTgQb3ZJZQavD3+Z5OSggvm5Vgdcey473CdT3gIALSSrqB3zV65vnDTno3Mjnt/YWif9rUIzemElEmNAV5Igu6ETjzKaBRPmP5rFSXeWaacBglrsd300PJiQ7YxLIu2kKNlHOtHaVmh746wsoIC7JIfUnuRgmOrAJ0BVhBRSk/+MwmOKoxklYybFL9Ey8zlPOwewUWbq7d1O2xI8fvQmuQVuXiZdgCZDEkX5PPMNs8te3V5JExCUUlZPBls7nNSJO0fzVU+zxt3Xi7tNQMKIP/+HlFvnakP6wuWiRHcX46I0PFlPOqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFcnVtBZ8UP2TGfsabD++11bnT8sUFM686NQ5RYwVgI=;
 b=xji9IJjztbKJWA99cFjb+E7TIPVpJasFno2z7WvWJsAUlquNPVwYueBUZHO6Rje1iMTUvGk1rxVUHh8kE9GQa213szafUBpcIZ7romgLN9HzCSi9aTJSWWLvtM5RI3uAbWaN8Jv9XhF8tfJsC5v/wVx5ERQEIL4NVojT3mPQcT0VvXqMDEWfoIBvDg9IkzA8BMpJoLtYGHbqIMniuo4wIcgQJJd9bjxiePQscWpJVLJHE94L6fV6CzbOd1/wSC9hC0oTFUr5LQy+exTyzwoKyHCupP8aNDAj9b3Ni6Hds/asq8mSZqr8hfAo3MQabxOfEkwRi515312hcV3WqF4GWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 08:20:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:20:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [RFC bpf-next v3 4/8] libbpf: Support sockinit hook
Date: Thu,  6 Jul 2023 16:19:43 +0800
Message-Id: <c24d05f27c8d71d410e705a9695e225243c10961.1688631200.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: ad08d958-ee3f-4c29-cd63-08db7df9d141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dmlFfNr2fADZcCyrvCP84PW79AQxCzzOuEuuby90HtP+2RqV3ZqYF974NrT7vn4uUvOAGtAwiO77/1ksHukAlDGAo7O44ikF9vKZOnHd68JA5flZ27nQz9+yj1HN5u3ZBw4K+xlhMd1se7TIwi/vfxKzhXhbIXRa3h68Ri8Bg0EjrR5aIPvWZmwdL3jpMKgokhQt1FGu6HUk1UUq1ucfiqnZEcXcTFguFAfI3hr6bGqkI9ujjAt2A1JPskaaP6utjLIQZoCaTS9AKhdmaFsfxBTwG4HpAsbC5zWRq8Z341GbSdcAzFQL7vOFQX5vGABZv5oVhn+/jxPcQ4y3CsUZaZ8C6ls8xKK8wH7Udbvcfg9NcDvf5BekJonhrayuo+WfdrwfzbRLY6NJ4Fu8DTruNcQhq2Ezqza/j1ej0pkGGLQMCCpsN00OGFB73UyRvWUbL/3eZO72xfRUTAnwOmDgWR59lh5YOP+xATGosTyXvevOu1qiYdZUXaXLjc36R1P+IRzo7crMZNx/GIphLoGnTgMp6eJmZGzc+hg4GbErp1hT0PTTxnLXKtiKArvmSVEH4Nbm0IaiytHUCLSHrfgOXl+nAxtnHoD2rBoHdPqcMjqp+yTnHpqEJe+JO4qniqI8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(2906002)(41300700001)(7416002)(44832011)(8936002)(36756003)(8676002)(2616005)(186003)(6506007)(478600001)(5660300002)(26005)(6512007)(6666004)(86362001)(6486002)(316002)(4326008)(66946007)(66556008)(38100700002)(66476007)(921005)(110136005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W91sUyzrYZpyy/4WOS/YT+9EjQuaX7FhGZbrBrza5oM60ymSK9lcLIZF9lOH?=
 =?us-ascii?Q?FDaVFVCHoCLNq3bU04AS3sP1SCRrQh1DvSur16xedmOgeLJpF72hXyOFLlaV?=
 =?us-ascii?Q?lPeez/U1hFJIGBCpaatG7xYQrJRf7cc5aAp6pZPHfQjksi6+aLgC7rUDbYlE?=
 =?us-ascii?Q?D6RHgJBieGNiw4GXEXx0WPLOVso4crUfTkuyQ3z8FJmfw84h+JoFbSy5muSa?=
 =?us-ascii?Q?7Ytrd0ulxP3tiwf3b2WfdObVIPYz19tnld1ReqO+Ua938SoFNXddziFI6EqS?=
 =?us-ascii?Q?ubV4+gIooByZG6jiv6EGdranvPfvQcOMpvNJrq+V7GqelcPeBNeRZuY/Rvlt?=
 =?us-ascii?Q?kn5nPGEtUK7tc7ShiuEEHLHSRrunefKtARzvZYDscnalzv8YL+bDp+SRA3oP?=
 =?us-ascii?Q?KMori2MsBkbSvBM7QRiQqIopH/VYALDbm4Mn9Ufiamhh++bU96TP4QIo6DGG?=
 =?us-ascii?Q?5V0AYpBSKZ8L63TNO29/0MjqN5w8BB3VtKXLQTLW9okrl36rCGMFd6oPxoDD?=
 =?us-ascii?Q?e9m3BIA1uSV+QtcBZ7KB5gkUGW4M//siUzWr5XwVCljKBFgzHXTIsre3lSgB?=
 =?us-ascii?Q?h3y9rBsCCmWQbLUVHTEH8VK0+0ODFvFBukv9o/8p1IZrRbtc0hCJQfo6sR5O?=
 =?us-ascii?Q?eHdtyzYaLHc+WM0o7nws89tDZPSHS6057Qrw9i36COTqe66p+gWn3yzSXarn?=
 =?us-ascii?Q?ZW0yX+Y3BQQxTK9NdhpZjPI4cVieNkAZGjjMdjwZ+dQs3yvTixSPOATPAsq8?=
 =?us-ascii?Q?jOvROsMUs9qjGLB3bujfXeaUoxs2CmMhZnqzbn3SU/+sMVBLDEEwr27D7MiI?=
 =?us-ascii?Q?QS1BxKIE3S9XJAky0FlMvAZ89/TgCTKbziS/Jp70XY7OKbaf20VyIbMTi7dA?=
 =?us-ascii?Q?c6mnbjoppNPAcmmgjnAXmYuCyoA+3t01GBlEdFQ7+r1eL7YO+UTM3F/xWihm?=
 =?us-ascii?Q?SkMHaLW9W+Zmw2MN0RUpojc9EGAT4f0/PiPvaGDBmlSwORiIcMKnl9o3lP3i?=
 =?us-ascii?Q?U9ajVCGHq0V6pV7Dt0O5eoCA1Eu7jYEXMSu2zmDaTgDXerlddCFsqOu/XB8/?=
 =?us-ascii?Q?mDBDto+zKT3rQkAdUBJzwSW43O0naS/AtuKt70OuPDovICRaVPqppHrNEnlO?=
 =?us-ascii?Q?980pqORQZFy4i0tlb0a+ThXerZRtfQL0uyYiKw3vPyG4oWJKY7HTU3nr0w3h?=
 =?us-ascii?Q?lpAcWcDyINNzagB2X8lnudxXyK/t7peAK92Jclz10zIJW03w3XuELwbaVyE0?=
 =?us-ascii?Q?9ouYsBWiNH1fFYXi4wXkaP2jUH4mFxbqzIq3/265ASpIIT3f6njs/ZGBk4KO?=
 =?us-ascii?Q?M0RFQOEpwrAasinIVNzsxNVfK0y3V8rEf/cNoKzhVin5MkqjHRXV6JocX2lt?=
 =?us-ascii?Q?p8Xf+Gvm5aeURbhtY6JekxkW0443sS3toFr/YJsxQTZ8pyC15LMxptfxvVSa?=
 =?us-ascii?Q?XsN3D/koDPVJK3PKD+EaJJSLdfu1zmkeUTxqIVXD0L+QBX71eR55zuyr/7Bt?=
 =?us-ascii?Q?EnDbHEbgmv9O+zgscpuwlCWhGzoHt4/uZ7ei0eEfletN6a+iTNSn24L946CG?=
 =?us-ascii?Q?xXKD+y5jw3swtpIqvjwUUS6zwva9oPf1lZk6apht?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad08d958-ee3f-4c29-cd63-08db7df9d141
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:20:11.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReuiOdeFslM6XvGwCkEVtuwWPRSjlkGGS8sEydT6VcNQaYObzQjvXjIKzgu1h5J8MucIrQMKwGZpw21DRDIzVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sync BPF_PROG_TYPE_CGROUP_SOCKINIT related bpf UAPI changes to tools/.
Support BPF_PROG_TYPE_CGROUP_SOCKINIT program in libbpf: identifying
program and attach types by section name, probe.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/include/uapi/linux/bpf.h | 8 ++++++++
 tools/lib/bpf/libbpf.c         | 3 +++
 tools/lib/bpf/libbpf_probes.c  | 1 +
 3 files changed, 12 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..cb882ab8065d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -980,6 +980,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	BPF_PROG_TYPE_CGROUP_SOCKINIT,
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
@@ -1013,6 +1014,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_RECVMSG,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
+	BPF_CGROUP_SOCKINIT,
 	BPF_TRACE_RAW_TP,
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
@@ -6829,6 +6831,12 @@ struct bpf_raw_tracepoint_args {
 	__u64 args[0];
 };
 
+struct bpf_sockinit_ctx {
+	__u32 family;
+	__u32 type;
+	__u32 protocol;
+};
+
 /* DIRECT:  Skip the FIB rules and go to FIB table associated with device
  * OUTPUT:  Do lookup from egress perspective; default is ingress
  */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 214f828ece6b..03f62d163030 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -95,6 +95,7 @@ static const char * const attach_type_name[] = {
 	[BPF_CGROUP_UDP6_RECVMSG]	= "cgroup_udp6_recvmsg",
 	[BPF_CGROUP_GETSOCKOPT]		= "cgroup_getsockopt",
 	[BPF_CGROUP_SETSOCKOPT]		= "cgroup_setsockopt",
+	[BPF_CGROUP_SOCKINIT]		= "cgroup_sockinit",
 	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
 	[BPF_SK_SKB_STREAM_VERDICT]	= "sk_skb_stream_verdict",
 	[BPF_SK_SKB_VERDICT]		= "sk_skb_verdict",
@@ -197,6 +198,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_CGROUP_SYSCTL]		= "cgroup_sysctl",
 	[BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE]	= "raw_tracepoint_writable",
 	[BPF_PROG_TYPE_CGROUP_SOCKOPT]		= "cgroup_sockopt",
+	[BPF_PROG_TYPE_CGROUP_SOCKINIT]		= "cgroup_sockinit",
 	[BPF_PROG_TYPE_TRACING]			= "tracing",
 	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_PROG_TYPE_EXT]			= "ext",
@@ -8734,6 +8736,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
+	SEC_DEF("cgroup/sockinit",	CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT, SEC_ATTACHABLE),
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6..3734fee60d2f 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -180,6 +180,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 		break;
 	case BPF_PROG_TYPE_NETFILTER:
 		opts.expected_attach_type = BPF_NETFILTER;
-- 
2.35.3


