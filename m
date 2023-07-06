Return-Path: <bpf+bounces-4169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DEB749498
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94441C20B75
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866310EC;
	Thu,  6 Jul 2023 04:09:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340EEBB
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:09:30 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83F1BC7
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhK5M/GbAfx2pVKtsjPmDFmCYfrOD32SWLbChF/uUkObWcf9g6Ge2OPh9HzxTZ/LyWs5ztUOvqr1B+4i16PhCvVRF/HitjBapBoWVniIXUaWpKqfgIsjkqa1qReEPjiv8LEzrwrY0cAHVru1lKIx6RZqxSTPPwGMxiAWPa+lEhvvXHB6zulsk5PMH+WfO7VayTcFfNS1CIuSyoxmdI9b5JfpTRRCAU1RtjpFvO6nP22KaCQSQwvrqv58uytxgnz2ohipnsXAuayVtbH2T4qpk1S9RZr2HV6a8PKjA4aVjycioIajcUy9U0u6D0LgDbj8Bfr/2FsRKHvwxq9lSADL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFcnVtBZ8UP2TGfsabD++11bnT8sUFM686NQ5RYwVgI=;
 b=YVAPbvnDPclmFhD/rmfce9WpPqLqF4sKKD3cDknRsWzSir65Sc8BWKlxjzQuH/GzOFiKcJfiNSoZ8YT2GHrTZRHRbMoqS8T1IXTPOFx/V2baPvY6rLcNE1KPfHNVdyog2J+eB82627ms7OfPCUMstdhhJnA4b/zhXJN3Ppr9AfB1bWImv5qvtCBWevXNFjgars4f5+v2ABlpHRmwvWouIPyLp+hQOUZow/lozz0X3SlNRSxVqQBjCA4hntWFqXZz6CkSIu8OxTf0zIyxoqPmRtvsOCzd+KQR9Leq5mTQE6tx5CPh2SAEJUR/Hy6zcw6LztUVrFNWdJ9HCoqDkZBw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFcnVtBZ8UP2TGfsabD++11bnT8sUFM686NQ5RYwVgI=;
 b=vi99ia0gv7wftHu8TtHEB/g1SnW5b2bqgQVzJimYThq9Dmwna/ZauvUb5KTEimfs9aOLZp9mjo6INWTrL6HauaxlIoTLBr8iVP14tCBpF3qiXfGuQt2O4xWTHbUd0iF6qITPr1Ww3lkHk1QAXMfJAB/uxf2I4pPsN/iacTAVU+kawn3qKQRv+Gcx7kWqqVaaaLr5Q+TXbqNWvW4v2RRKBL8DXC4JKR+K9aEQExBr+IxRxqVSLi/eFeJlMJ+ja0nH1LH2rTk0fuQlnTpSZlSDPhMae7k1qL707cXO0X0hiunQSTHqza8X2KjoLgTEH3TTG1+k9xCCdNfOadBQufk9WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:09:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:09:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [RFC bpf-next 4/8] libbpf: Support sockinit hook
Date: Thu,  6 Jul 2023 12:08:48 +0800
Message-Id: <c24d05f27c8d71d410e705a9695e225243c10961.1688616142.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688616142.git.geliang.tang@suse.com>
References: <cover.1688616142.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e443eb-e438-412e-4c4c-08db7dd6c8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	30aYU20yDRxMKsla81KSylKBPqVfeGf69mQ5xLN32wve1+8QMszIn8em++GI8Zf3wydsNYLlY6Hn8nahTkBuDYNMDbQCWcj4BVJ2DXFNcSSAkrhN0l4lyQuoM0k4/ZZoGvDfrHvdzCRUF+qYA2Qp6k1nxBocZqiqtkRnDXY7YuJWsX0Nswg6AsvfSprhN2KHb1cl7lRmxK00xo4qDgbfsm+rEZDwo/yMJCqjQMiAs6tTRhEhw2lQp+8zjN9yQyZCJNIVmYfrDM42EtE8FSOBmcHI4YE5SNpFkxTNc/kbInWjmHXd3nWwrRwHtqL35GtsVVrf2TyfwIpLkjVzh8gCbox2Y5QqsppwadoiNOZTnyVetVGYL+2HGzEQRxM+7sYBJj6mvJSVcwUcbzG2fUw7kx42P0/oNcaZ1Je9pe3Pi7foz3/3vpyxtezctq7eTtqyRa3NNIsPsKo04L1LS+OR8XIPHZMU3eLd+uvcnsDzME+ZWL/E7C8qwcQT1j9ab+DSYH6x6MhgrubYIS8LStcnJmJevnmsrQ9kr0uUe+HL9Us9UF6YAmUlHM9U4h2birBlEE+GyqsZLLzDqpkRsSDYWbC9lfeIcEOteCFjYRvgFzToIJ4Ka/kxwdqixZQZElbE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(38100700002)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(36756003)(6486002)(6512007)(6666004)(110136005)(6506007)(26005)(478600001)(86362001)(41300700001)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KWl3xbH7WvdqOgzCREeOopRgtmT+oSeUViDt5GPgX9Rdt1ovTmO2HO7StWQg?=
 =?us-ascii?Q?srSFj8sT8Y07V0nXvyk6EEMqgphICjNapHXLrjoGNBfegpiDM36c+z+Rh3+2?=
 =?us-ascii?Q?gBaW1U6NPKAnDg9pTLqIAHA8YlZfryHdLcAoSkkMMzJm2LwFNrCbJ/tjU9L+?=
 =?us-ascii?Q?9HlIymN8PLbSdgzU7TLxVYpG45Ui0u+QdHhsV+5Qo1VrBTHwqqLXeDslsCvN?=
 =?us-ascii?Q?YlwA7fY31E1c9Xmi7mOa+yMwFznLapP6Kv6VOiz1NZ5qwl3bU4P8jKHPxmYy?=
 =?us-ascii?Q?nnQAH38BT2m0XEoH5u5PRg9tlRb6Td9sJ3jF3wdP99Bxv17r4x6ClUvtX8GX?=
 =?us-ascii?Q?ESXr+ly9UQyrlNsxgaT/xnjl3eGxXg16SsEf0gA4U8th5cDYAMqyk0D26AhC?=
 =?us-ascii?Q?sabSr1t2PngnVHe0mebeW1Wy2ULTXZoK06UM2c3x1EYyuzg5mX44LUzF1IHO?=
 =?us-ascii?Q?y+GmhEzlU1cPS6mzK90s8eFpeyn5XxQ7b4sTgYjzVB+FKXaz9150RlDaWZTH?=
 =?us-ascii?Q?7eoxj9+SZ8Zc42YyX3Ox12xf1VmWIWqwajYbjxN3HjuEErVydluBhNIgPOpJ?=
 =?us-ascii?Q?3gTlAaHPX8ihDrLPgSfXvapDrsM1lbyUnQHrGp84tQheKoxIR9NDj8936m90?=
 =?us-ascii?Q?LPX0KowsrVFtCGAJHItwiwG82VB4K4OmrE/LnIszNLrudD9G4/f9MnRJvbSt?=
 =?us-ascii?Q?vYr1eGgHnTyyGBd81ON2HlD/UTmv65jjmpeWr1AbHUQ1zqfla0ltd0gC/b6/?=
 =?us-ascii?Q?ggtGW3CBc+BhtcD0rxq0UJsFqX034EIh71wFeOPDUo1wCEkFT6gdnspVGdQL?=
 =?us-ascii?Q?1dd1HcHZPqZ3ef2ATN94NTe6Udq+B0PgnI12Zx1zbPYPEd2ps9njyZCopAlF?=
 =?us-ascii?Q?EEh7tnO2yIwCSr5z80Oo+vgwb7gy3iN07FSTF9s6mX2vgoozRNacjVGCNYPo?=
 =?us-ascii?Q?gHnOsLelhapJCb7D+xyWyW0q4t7Dl3xYckCN9CxBYkPBVduLLTjrcYlwi/fz?=
 =?us-ascii?Q?/tCzwMwmaKUJUWmb+uehaGvvS4b7tL7IiHHwsTfVagVgMcG/W327rUUau92i?=
 =?us-ascii?Q?qty1SwDlxARS1hywMsgbOnSh2av/Vv08sf2dglGmrFNkZMQUSAuacpmRaY6q?=
 =?us-ascii?Q?10yPyEOjVI8pN+Vb2FQeXPqjwce7OaK5l1AquuisOzHgMdTTizz1ZF4vp8Ju?=
 =?us-ascii?Q?Zcyf9XbOPp0/i1l+Wc03Dvm4wrvQD6NCs/lbH7RpW9BhSL4S0U9cDbcHfPeh?=
 =?us-ascii?Q?AjDHQYVI0X9fM9cNJRx4Qxs22SGILE6PfIfZdkFLoJwuUAOcPGGQjQ5ZqOq9?=
 =?us-ascii?Q?e/NEStm6aG+G1c3HhLkqjz3itxUJ64ePkDHELbXWEhyOBwpjMpf6wCqwdyQC?=
 =?us-ascii?Q?81QR0B4SQH1YzuhAw/GjftMrnAPTN3f95Fqjck7GBbJrG/PWJd4cZz1TrIC4?=
 =?us-ascii?Q?C4vRLk1l5evvvqsOJzpR47HdeQuAQSr8Z9T8wvQ8DcZm7nOe/wXW0OMh47Y/?=
 =?us-ascii?Q?YOwSmx7z4KuTWzFqEk0wM3lCYj+siBEHAV1yzczsfBcaZT/+kbQYZZaDYA18?=
 =?us-ascii?Q?6pyYAzFrsJViLGB5JKBst2jq1l6RxIjYeNlZ1gH2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e443eb-e438-412e-4c4c-08db7dd6c8c5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:09:25.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhN4ZkWUhh7Tdidp5yW36bUBvBL30Q3kzyDTSoFgb7krCzT0/hQ+z228dtkySc+PiXAMwRYWCboB5ncqJJaGGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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


