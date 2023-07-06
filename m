Return-Path: <bpf+bounces-4166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57093749495
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E2628120E
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC50EDD;
	Thu,  6 Jul 2023 04:09:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890EEBF
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:09:06 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4461988
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDC5lScujW5KbH4XAkEQVGBsriSpbDBDfgbVE7RAPPORAesbL2byyd3VHa6HRXsyZlaH1xpOH1e2IuijppZR/rpw0qAJe8/Wh8yn31S1jaGY6PEHi4VojMcZ6LVf+7lpjzo6sPQoWwAFHVXH3SMcf09UipSQfZVe+BanarJ3Wq0zWvi4VL4SSdj15/sq3LHUnoyCOjriTyWoz794OrxQldXsDtT2o36b2DAmqGTJIfxKKer3ciwYRn11GFDOhuEIUnirJkZp2+eBqhfP6jx/B+YihRchUGbaY8PKxT6xi8FGsJxY6SMvIlsoE7PXpGQpEGa4m9EDXexUITnrL/92pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWM3md3G+KvRxqHdGU4Y07ll+NwhSVoOjfCi91FN6Zo=;
 b=bqD3w7ZY5VFG/sjgJrF7MFTWMvDUoiWM/n+U031hCR4MCRWQh76mqHFNz16aTFemDg09g/Zw+0/m2ZRvz91fnKMv2vBsTKjGllQ7m4+ipclooch+4F7cog271C4JCS7VIP2xwLg0i/uL3O70XeIL8nUtI/10WwCEZSw9nXAh8m6WstHw8fTB2RTbxfwFf6qQEUvNRI2sQHxxSyB6Lrj7momG6Mx0rlC5ieW5BPCFsPIn9iRq/tleD6POOfYV25REHZl0OxnZUpXyIJ1J36y+a9gIVZHt43S9KFQ/AphxAi7daT51IXrSjETBP11t94YfFON9chiz7G/JbjrU2yONDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWM3md3G+KvRxqHdGU4Y07ll+NwhSVoOjfCi91FN6Zo=;
 b=fA5Mnf6JtQXyvfgVz1HRrjGvy9UMf2qSUW2iYI/ysf8FXqcPYI8kEajlGSGPyXDdpfdNFeAbU9u8ElhAW21RFCSIuBAHQGYQbLF3VVdVMLkVBOylbJdmjurQNKPFte0jMfL73IwPjj1waEknNp2Q3zRimZxV9VRVH5Ev9kPgBgXdISHn7uPiwDtXGdfs+d35IaWvptZ0xjWqOLb28Sg1uo8J+10Dm5TSzg+dzeCJTlQRyni4FAMRyUktU6RWn36+RguVYMTQciTBFKHBfr2KGFdObYlFvXi93VRHvRvmFx2p/3y7f2kBZC9e0z3imCciZSio05BSb3xJRh3c+/megA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:09:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:09:02 +0000
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
Subject: [RFC bpf-next 1/8] bpf: Add new prog type sockinit
Date: Thu,  6 Jul 2023 12:08:45 +0800
Message-Id: <0880130fe8ba0d721e63f6d37bd8ff6311eed9bf.1688616142.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688616142.git.geliang.tang@suse.com>
References: <cover.1688616142.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: e40689b9-a91c-4d2a-41b0-08db7dd6bb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yt3xNz4wyB3mUOHgy7/ubA/6H9MPB9or6xJdGZuuTN6EYUcpXUfyaTStqCo3TCp9gyZVgpRHUDDiLB0LNbvDPJyYzkdhsrofvgfxJ2MaHyBGfi3AyGCzZ1tUtxDjCo15NoqVpJu9gRAP7nvPGFUH8ri5UQK8zXQGETBK9EahwomyAspMrETXjy/6O0egkdY8VLAoXLMhxPn7+RBtaACk0dY0GfKUIC3fd1Xtos7URO35F1V+Y5NxO12u8T+G5LDDAtVPrhDjBQ4JAqzy1fXFr3vM3lemUmmsExLoEE7AXAJsjA6iXwmm6d2vF/rhQxHXB+RTtEt/0QEQ7f96BFDYs+iDCpQdU57kbVOoKkHjIKXp2hFyyPznXYDNOxux5veIWCtaH63zsrsJQ9d+fUovyKVimnd/dZiKf9NZaFtUSzJR1+FkeTmLqwQrgVvOp3np2jI1sH9TiY15A0m10A1EwOMGlB0Hp6aVS99hoyTjkBkzjKZHo+HGbaIlZFeRbFbPoSG+PsxEcLS0FI+4Ec6ifm4m8Sq3CLUikZu7HbakfkEvl2vBkbWwql9ypCBWWenA8CWd75RlL+MQl5Rg6CC/D7kjw7LCHgRV8h3+dnkbyshXx3JcnCdDSVm6Mf8f8rj0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(38100700002)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(36756003)(6486002)(6512007)(6666004)(110136005)(6506007)(26005)(478600001)(86362001)(41300700001)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qj9vo1YAOyE3WlDsDKfuNvd3w/yWlfIolb1hlTQXLvlowUFRz+QwB6HnqN6D?=
 =?us-ascii?Q?7Y/L0jAK8o8eEQ73XRrwKviroz9QG36GrVzBxWrHOVhpUQBmDG/Q3NA/IOxz?=
 =?us-ascii?Q?+MxHJmu+I0cqiFSzQH9SZbIYBV06PGdkrqZhRlkWTFCl2SN7fM9logSGP0+X?=
 =?us-ascii?Q?+m0nvoIPajUTsEZVke9BjjL8IQuDflu5Pp+KCf73IPYUbDRCMg12zP7hFVdx?=
 =?us-ascii?Q?QPbs1rWDuiMqLWQSnslRZxoEmQuhmMN20o+tcJ4zuHdCWsaRj0wte975KsmW?=
 =?us-ascii?Q?Huz4QpRhxPOyzObykxUsR6xWybjy79oGAGWKdM/diJD6wVSPnw7n7ZRjJIHD?=
 =?us-ascii?Q?J9j0ZzL6LarWXkxJgIBrN8OhG1HhSgjM+AVi5/AMQcRdS46P7aJcmxo9LT8t?=
 =?us-ascii?Q?oE+zlmRJloRSDvpkO0m2OO5EQNAgn+Jopm5XBubUvMOYk3NPTkEte7GfKagh?=
 =?us-ascii?Q?jGvjVVuMsMD/2lAACcl5ATlS7jBOSzksYmwqsnq6OczvaZELijtvvS+nIzk+?=
 =?us-ascii?Q?nvK3qDTUPXkTn6gSkOjEh0sEDN6TW3eZiZRI68q8rjqX0kKYpJyOXdASpfgr?=
 =?us-ascii?Q?EMSVk0yEvTphA8RSxMvn6YyuWSMG3j0SuV+hM1p7L8zhPVRvJ7unLESsCwhP?=
 =?us-ascii?Q?SfR+tEL8mfif8pLVRBOhXHATWIUCP+xJrtX+NYyc1Cl7gflhKAPJEUmJHX86?=
 =?us-ascii?Q?o/WhTUIWwN7jBAIvPWOfo/Xh4UgTMUfLBJx4s3m5jElb4Hthd3DMmWeNpa6e?=
 =?us-ascii?Q?MmUP9W/eHqxAyzy9E9cFuUIlS3cOB1Wh69sEdd3PN/j+0UcJ0ax2HcFPhUsS?=
 =?us-ascii?Q?qxVKMd77HA7Q4CUy1WeRj46FIno2dJ/c/XTSYPB+Yg55wPY40hMe1YeuxNt4?=
 =?us-ascii?Q?8fmGB1Z9TFxQLs4q+kMxnatBB7rNy5L4TS+xagA3njOwzmDvwyGIaAAfkny5?=
 =?us-ascii?Q?RBrpvhtD/6EXsC+3YTsubQn764q0x0yFBBYdthM/bT0Monq/ZaDxbwVTWxPR?=
 =?us-ascii?Q?+UwRGCo3LpM5gKaWR7g+5KDps2fUTFrx4Ki2a6oeFs1/Vp7l3rlhICD31f1S?=
 =?us-ascii?Q?nbqYyHBjaTcNteNAfg51nAfPjcLqPH8XUfcyGZvFI87S3C0fEXysH0pUwCbX?=
 =?us-ascii?Q?+/VRIqpN51C6fuMHzxTmbm9ualTBSgv8rtnlgC5z8BHNF8RKyD8/hH/i0Rlq?=
 =?us-ascii?Q?yg47jUVEqJSJ9pFVH0ETYAnd6yc0ILr8oggiIzefW2SmSFjNVaZx4qoQRLT7?=
 =?us-ascii?Q?d8Z7au3lz5ONcr7UkyJ+IH+joA8ePjI6fDKuUrm1BerEz1ta4LwMdpJAGPmg?=
 =?us-ascii?Q?HTwEijT5Qc2m3LTNT9zgZbWpTnZ5K3mGiNq5g5lq5YNb7LEBF3kixjRy21v9?=
 =?us-ascii?Q?B4pyaCBJqALKjpBGI4XzWNGsy0nrIUoEQcaeIGPsAcXKuOcvh3fz8hOK5oQt?=
 =?us-ascii?Q?N0lthwThCVnVn/vYy+zpj3Wcpmz/hd/7x/g1oQBjz4BNnPiXoykfkHqcZyGO?=
 =?us-ascii?Q?QfT4Dk3ID+3VQHtJNGY766Byd6aewQNwZDWgNPIYcdp3C3znOVfOStIGiqzo?=
 =?us-ascii?Q?WEWV8a9dPnk8pVrgA1/hZx/XkgaHbZjcuF4c4S8E?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40689b9-a91c-4d2a-41b0-08db7dd6bb2a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:09:02.2487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L15xtwvTyEpNdtCZ0YXdANBT/O6gc6bThvTnDUsaiWtTve9DmF8ahGiUJQXa1RUm+M0kVI1X8UsHKLexzeg/mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patch introduces new program type BPF_PROG_TYPE_CGROUP_SOCKINIT
and attach type BPF_CGROUP_SOCKINIT on cgroup basis.

Define this program by BPF_PROG_TYPE(), and implement two operations:
cg_sockinit_prog_ops and cg_sockinit_verifier_ops.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf_types.h |  2 ++
 include/uapi/linux/bpf.h  |  8 +++++
 kernel/bpf/cgroup.c       | 66 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c      |  7 +++++
 kernel/bpf/verifier.c     |  1 +
 5 files changed, 84 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..07e1f21e82e9 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -56,6 +56,8 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_SYSCTL, cg_sysctl,
 	      struct bpf_sysctl, struct bpf_sysctl_kern)
 BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_SOCKOPT, cg_sockopt,
 	      struct bpf_sockopt, struct bpf_sockopt_kern)
+BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_SOCKINIT, cg_sockinit,
+	      struct bpf_sockinit_ctx, struct bpf_sockinit_ctx)
 #endif
 #ifdef CONFIG_BPF_LIRC_MODE2
 BPF_PROG_TYPE(BPF_PROG_TYPE_LIRC_MODE2, lirc_mode2,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..cb882ab8065d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
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
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..93b9f404a007 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2505,6 +2505,72 @@ const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
 const struct bpf_prog_ops cg_sockopt_prog_ops = {
 };
 
+static const struct bpf_func_proto *
+cgroup_sockinit_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	switch (func_id) {
+	default:
+		return bpf_base_func_proto(func_id);
+	}
+}
+
+static bool cgroup_sockinit_is_valid_access(int off, int size,
+					    enum bpf_access_type type,
+					    const struct bpf_prog *prog,
+					    struct bpf_insn_access_aux *info)
+{
+	const int size_default = sizeof(__u32);
+
+	if (off < 0 || off + size > sizeof(struct bpf_sockinit_ctx))
+		return false;
+
+	if (off % size != 0)
+		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct bpf_sockinit_ctx, family):
+		bpf_ctx_record_field_size(info, size_default);
+		if (!bpf_ctx_narrow_access_ok(off, size, size_default))
+			return false;
+		break;
+	case bpf_ctx_range(struct bpf_sockinit_ctx, type):
+		bpf_ctx_record_field_size(info, size_default);
+		if (!bpf_ctx_narrow_access_ok(off, size, size_default))
+			return false;
+		break;
+	case bpf_ctx_range(struct bpf_sockinit_ctx, protocol):
+		if (type == BPF_READ) {
+			bpf_ctx_record_field_size(info, size_default);
+			return bpf_ctx_narrow_access_ok(off, size, size_default);
+		} else {
+			return size == size_default;
+		}
+	default:
+		if (size != size_default)
+			return false;
+	}
+
+	return true;
+}
+
+const struct bpf_verifier_ops cg_sockinit_verifier_ops = {
+	.get_func_proto		= cgroup_sockinit_func_proto,
+	.is_valid_access	= cgroup_sockinit_is_valid_access,
+};
+
+const struct bpf_prog_ops cg_sockinit_prog_ops = {
+};
+
 /* Common helpers for cgroup hooks. */
 const struct bpf_func_proto *
 cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c..2952dd88c614 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2513,6 +2513,7 @@ static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_EXT: /* extends any prog */
 	case BPF_PROG_TYPE_NETFILTER:
@@ -3574,6 +3575,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
 		return BPF_PROG_TYPE_CGROUP_SOCKOPT;
+	case BPF_CGROUP_SOCKINIT:
+		return BPF_PROG_TYPE_CGROUP_SOCKINIT;
 	case BPF_TRACE_ITER:
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
@@ -3640,6 +3643,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_LSM:
 		if (ptype == BPF_PROG_TYPE_LSM &&
@@ -3682,6 +3686,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 	case BPF_PROG_TYPE_SOCK_OPS:
 	case BPF_PROG_TYPE_LSM:
 		return cgroup_bpf_prog_detach(attr, ptype);
@@ -3726,6 +3731,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_SYSCTL:
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
+	case BPF_CGROUP_SOCKINIT:
 	case BPF_LSM_CGROUP:
 		return cgroup_bpf_prog_query(attr, uattr);
 	case BPF_LIRC_MODE2:
@@ -4717,6 +4723,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 		ret = cgroup_bpf_link_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_EXT:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11e54dd8b6dd..d0ade7759123 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14316,6 +14316,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_CGROUP_SOCKINIT:
 		break;
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 		if (!env->prog->aux->attach_btf_id)
-- 
2.35.3


