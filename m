Return-Path: <bpf+bounces-4188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A882F7496BF
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FFB1C20CD3
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1BF15BB;
	Thu,  6 Jul 2023 07:48:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C515B0
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:48:24 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C181BD2
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhwgnuDRlIPA3oGvUhOhNtqNLNyB+ZhvbwZQaFjoA/Dveo3fuQPiZVAjm0RGpUUD0pIeh5n5p9M8o69nUA1m7MSRADEp3AIZT6Z9k5xwIAI1YifDhqOTOFl/a6iO+TSoVQzeNdF63VjkIsXDVM5wvFyeOn87rgWNmBLsgmKWtb3rvwItR5UxUYQlfktK+s/VASrSe80OraXxxBx4dojKj58MSlTASRONao1Hf2b7gCj7aRJzI/SF7ik+Tf9I4pzJDK+9z7HBxNbbnuXtME/ViiERy8I2jOLidlIQge/Hh7Su3oAKHYJwG6QjGV2bcfQ5fqIEhFdu8tMMEhRnhnFIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFcnVtBZ8UP2TGfsabD++11bnT8sUFM686NQ5RYwVgI=;
 b=MSpWdiFSow85rnytVBI3bk2qh1vXtFq8tUxAagfluJbHoHIvuUra6V86uSaiOeuNTPpMrBwG8Rmn/jWlEL+c07kgyBzYTWcxJi4ZXyisawFFplylr2+FMT3ANFUkmXBt3POlO/CDadZtFqzMsoPw2Xnc/2RO8y2XfPne3gQDgwatppwXlI/GBRBzhiddsHLRyV23DwZQr80zvQoVonCohOP8H1QoPVzYjITGEasDdXA76/RXk51dMNbakdzQHV1n2h3IMK4oGQj2AW4kOM6lKmnav1n1aTPmkJxJ2vXNOBOVhHroi+dwDORES3+TE2tIMpDJrvG2rlO6Bylr9uoxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFcnVtBZ8UP2TGfsabD++11bnT8sUFM686NQ5RYwVgI=;
 b=0PSbrtqMbeCbMNIXxMwNILJbsU8pBV+8bSD6ZD3XEuQCRekSGLq4BU9ZwHNH4Ky0qlA0zIGv1aRJQnDDz7lVTqzYUHTBuqAQU5FDJhhCAR7OJQ4uKbAv+JlgOzk1wH2zkr5gYtKrH1EtGBZSQF2UkBh2OIr5W4lLq7rrlwHyJOucvu1+WpasPbTgREOa+21l8AcOYiGJi5o6wZEkAgveC8OXJPDBKjB7je0Q2/EY/ETZQqUsXL3wjMp6BL/Wghwk4Uo0MgKkMK0JQfNEG45GT22b1ovmypDvdBXU+LzRezv2+Dd9bAXQviwWPLMgcn3SNzZLPxdVoaFEFO8pVENP6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:48:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:48:20 +0000
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
Subject: [RFC bpf-next v2 4/8] libbpf: Support sockinit hook
Date: Thu,  6 Jul 2023 15:47:28 +0800
Message-Id: <c24d05f27c8d71d410e705a9695e225243c10961.1688629124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688629124.git.geliang.tang@suse.com>
References: <cover.1688629124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0161.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cf9853-8847-48bc-0a2a-08db7df55e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U3llDOyr+x9H5+71+3QevMXqlZ9BL0L1MknI0bMiKfflGb2p/Jg/K7z90sEoFVKpko0d3rLLCNCT+3mdtP9Wp2zZbhUIKaz98EmBJWi1FBKqscQRYQfzODzz3mAshPX6fASkw+Vv28j60h06plx1O153AJZfC2qxe1xxTxFupsbKtJM+/+8BTKQRT7+RDyyvMNqub+Nl8VfzDZYMgc40AxxL/9O6+jurr47PjxSy6OGw3oB3x5pe7TW9NPp64MB8iuHdTCmf72bWbWXHWSK7zKstbmGm6YD9DuR+UuWk5b1pbRpwrJIa4xZZlYx4FF+rF/T+32kxaDR6OyRbIkuYQVy8LGq6BAUlxZImF0TtT3urmh8LWtBuEsfVE8KGysLc/AMAK5BWEP2iBjCDQt6OvGWVgbepuKTu6GwSaaFzKbxIrkiPJrrAEzjf7Eadec2H8RLDSj5X7VGlkreKkq3ESBQ19g7V2xcyXsYB5h2labpSKsyYLjfKlG+ZWXyacf4R4qiHYg7/MCb7p5oTzwHy+yIJpWfEwCqclGXO9oz6e6ZTuIRnKgO2RwDEmxQasdiKr92lAjfAXHORqqm0mrT/qCnX4fy6kj9XX8XlnAU9MNycbdlk02n0b0FM32S6b1sL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(41300700001)(7416002)(5660300002)(110136005)(36756003)(2906002)(44832011)(8936002)(316002)(8676002)(6486002)(66476007)(66946007)(4326008)(66556008)(6512007)(478600001)(86362001)(38100700002)(186003)(2616005)(921005)(26005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZRDznimB6xhCvxDuhV9+RBO1thEw8bfmg0s1tPNngy8ZvftT4cF194E0Mix4?=
 =?us-ascii?Q?+n9FVOAGN5tEQIpGN67pskCTvQcdqX7jbAQIyXDdZlXESt+2syM33adkjjMD?=
 =?us-ascii?Q?Qq4THlQrwtdBsXToTftgIP4ZD+k4lR815uM/zmlciKAezkiez7CXDz2KEvS6?=
 =?us-ascii?Q?QvrHtaKpW7MayQXOtRx37IkkuTX0vCq8L5pjxP9r6LZ1ecTC49ZTdwcptM7Q?=
 =?us-ascii?Q?X8NUfu97grXa9Vub6a56AmJknu7LsuT628mFGX3XYBh12dxOGbE3q8viCQHJ?=
 =?us-ascii?Q?sKxCocx9y+3atl8sYNPybQ6O7RuqlGCdSb2bwYPUwYLkqe4+C6JKmhuE0vl6?=
 =?us-ascii?Q?AMdVDWYJbaH7qU+t5itmktnuULIx7a6x9wh7GqRre3JK36b0gBpG15ynqLAO?=
 =?us-ascii?Q?kLPjMxtNDKcXR82UalBw5HnLawkDp4/Vwj/3eep6E9uaMJU0mQCHFA23hVYd?=
 =?us-ascii?Q?WhlFatV1P9b7IwyU+sCdIVpSAl3wjPLukfwm8WQAoK/P7sQQJm4mPRiFmngb?=
 =?us-ascii?Q?npiS8dPxIwimkbLTQ6emsUdhgPBk9ORnmaGX3/2TDYd3PvLyh6HU7IGaeNiH?=
 =?us-ascii?Q?rkLGR6HHa+dLN9Ru5uLZQiqwdawR1paDU0mDH+d908AHQS2n7UWd2HgmHmD0?=
 =?us-ascii?Q?YlIJtQjpqTE8RbcIXfTUxJgFwfQjxjQaHtLl0f1CwuS85lmhOgxrL/IlQD+K?=
 =?us-ascii?Q?QLCqCEArSnb9emi7f0RiNWvBirexiCF41qTJ1LWNFFqYOCBA5Bw+/jHtVXIb?=
 =?us-ascii?Q?CYtiDsSrI7DN5DgWluagcQBCoB3B3YoGV3QWMiOY/vxUf1d9PKAQ0K5GN72/?=
 =?us-ascii?Q?dw3KyyP+cEFuYFCOQo+IafET2iWSPrWHYbgNcQ9/Va7rNls0L6burqLV/j0a?=
 =?us-ascii?Q?ZpXc/Mh/fWW97n26Gi/0jPjXjd/TsdnDjCYx+brVq5nFKY1pR5gYd1+TTb0B?=
 =?us-ascii?Q?6yAu6celPgYvFKXGBQNZ8Doh4vA+YJhWR5cXtISVcm9ygBOBxDgQrPppzw7E?=
 =?us-ascii?Q?LaF6zo0TpYxN4ZXRNLVYalfHYG66RDZgllwFQegL4nm3dUeJEb+u+cSoCmEM?=
 =?us-ascii?Q?M46Eg26sWoM0daTy5lGgySs2wn0qIgFylfOpOS4xV7jbOnWHe6iyVE+2525J?=
 =?us-ascii?Q?qGzpHV/IOSdrG701/T32oN/oFMpFKPcQmnGG5DotLpFYi5+1m+YAUNHZnOu6?=
 =?us-ascii?Q?sEtPh9TydFUBVnYbMUzID7hRUe+gKBzPUtWu4x/dOhNXYQcFf+51gMNTpB9r?=
 =?us-ascii?Q?n2n3f06EltyuZNX8Gwlt7yLb5wRn7QhQPE/HOuVaRGyerWwF2aDA+7r1DgmA?=
 =?us-ascii?Q?QN6akSEjdjQQ8MBDy5jt+Ief10LSOvjQ58VhbCIBQPW0f5ZmDBfA61MewxAg?=
 =?us-ascii?Q?FUWcHj3P8YMWar9rp+7+eM5+ZBlrS5hb5Fn0E0QFzrKKLDYmcMZe67fWO1gZ?=
 =?us-ascii?Q?47lRxU6PfTkIhiWGkx/Rgn9IjwsalQBh/xk3nJfrh+rDpGybIWQuvNawQ940?=
 =?us-ascii?Q?iseeAx1OPCKliTSl8prt574NQdIbKT+//5kYLe6ijq3/kJLBhxEIGl/s8GH4?=
 =?us-ascii?Q?RGOYZ+wO8+6uT1SDvXRQwNELrxTbkoyysaMpwqy5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cf9853-8847-48bc-0a2a-08db7df55e06
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:48:20.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/0WR7U4F/LKjmCFaBwZ1cuAcEKmI8lWNwItYf+q8kPqcnCEc2m4yjkUjdeUOz/7Mqv8ahGBeITNcun9NocBtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
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


