Return-Path: <bpf+bounces-4200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A266774975A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C681D1C20D27
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E542112;
	Thu,  6 Jul 2023 08:19:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965E1FBA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:19:56 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9351988
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSIn4ZfDD72mfllZi8g36HqmUGybZ93dhLXbSJHxRCXyJJdYGODnHcoQfEt/JmrOHsPIuIV6dIu2ahXqal+zFngyUninpfxEAvIXKs4PKEGjB/apSzBXKWQG6VRA+8td5Obb/UIBzULo/pH7nxnoRLCFgVA819duh4FfXGSD+pvJfN/VNAtz3SWNUpZwMtaOavcQYzDvKAb2J7dvy3BKVEWpHXMRzjP3iXHaYV2EFmL7jTSWtBi+5SrEA9wYI+WAtvJ43Xs7ujzGQncGaB4ck6X6I+8S4yid+v1qhfotS//6+g5D/FlxY8zE+IOWjoaEUjnRomFeps2tE8kcn01dIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWM3md3G+KvRxqHdGU4Y07ll+NwhSVoOjfCi91FN6Zo=;
 b=hgkbrywi4xbZf9u+EA6b3rDLsxI1vcm4x7XRBQHSinNl8Iem8QIKq4uZ6f/EOEEzyG0qZigyybmKXKBN/T4cqpmWaHfZOGTOqJR8UWANa2mLo39hW5uaQUMtn3qyGD62yTdynFy0EGpaotVTPKWYBvRDkhkfcrwF3YXlLKzFw+wFQs/a8ECEee42ahLYHj55tlYgl+gHxSeUgrsvVzv07YsVbPHsA9vhreu7vw4U6yM1o9XJsZPjUbUnzm84DKrbu7XWxWVXYjkhRBEpGIZWGasodhKHKuuDJThNRbLjfV2UWqzPvVHiSpGP3OgArw3dcuUQ1EYdl+GTFzcnvtF/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWM3md3G+KvRxqHdGU4Y07ll+NwhSVoOjfCi91FN6Zo=;
 b=r9HzSEiN8mbcAV1PKLkIToEZBHxuu0wfKj7C8dnRIuVB5tO1axF6cdCUKQ0sS/0WI0ozHMS9T3QcNPFMr9U4+eUO40/7tzXxh8/ocz4qxovvW+IL8BH+Hsp+sev2CSRCAfaKCNOaVEaUvoR4ub9r3rmyHuyCpSj3MJXQO0epdU1grm9fDGe9kEvAz3rE2BuTPYozHYBYcIhCmltjP1K9jy0sA3Om73wIZD2VREmnA32ypjl+9FuoBPbTyg83HHGS1azh80+uyTmHUAHSGT2IpR3asRhfmNW/CSWI/t+kUg+lAAoQbUs52xSV53PUGHJ+VXYI0wD+zEYihvJv+BUpag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:19:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:19:51 +0000
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
Subject: [RFC bpf-next v3 1/8] bpf: Add new prog type sockinit
Date: Thu,  6 Jul 2023 16:19:40 +0800
Message-Id: <0880130fe8ba0d721e63f6d37bd8ff6311eed9bf.1688631200.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d2a545-84af-4cc2-ae16-08db7df9c51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2N3NzmYxNRng7Q1PKVX/IKe9FMWlA7mbEDsHitLtZZb5+5pPNmpmZz8DWbl1aWzgdHVo7a6f/AFJEhBDnEJ5nFNkDDZRQ+fFwjhc7brS32gzgUobF8Gkh7l1gi4AFTaINS1XpBYmZgOpib7rcff8+A33boAS0vOg5B4Z1awUvo0ZdHX7aN3LKkCScG6fOzGjJkTHPdIub8i8oVZh+F2fPazYAJ8wjbcHE9RzN7KECLYvCmkTFH38Vujg6rUNIWbeE+0TqTDEQudz3Lwx2JTGI8McBXm0319CTzBEsC0LnsnVDUqWq5dzGAeFTzxhaZeYusGaRhvUFU1Rf7i/JQAB6axf/gaVH/+4z4b3BYjy1zDZSzRXk1Iox6b1c8GAJiin6O6vupCdnMToOQVqtthR6TfdjI9wH0LJvVgR8Ws5+AGKltuDE7MwbsxsA9xRHpoAqwtVGy+tc2jnyfMs9oIt0iywUF/FSdsBvXYl5BZvmqiY2rZNIdNwPbJ2fkGvR3ZhkGQG3U+aKXF6wEeaqqHWFKAIFXugaLcJjFNfw1xzB0I708g3G8cOtTMfHbiT0KBuXD11bcL/jwRgLCDldm1oaTJMrxW74AHjTuXSdLHMU1/f4YlqpmeEzO9pGFtaqydN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(7416002)(8936002)(8676002)(44832011)(83380400001)(41300700001)(5660300002)(2906002)(316002)(2616005)(66946007)(38100700002)(26005)(110136005)(4326008)(921005)(66476007)(66556008)(6512007)(86362001)(186003)(478600001)(6506007)(6666004)(36756003)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?glZvqbYbVyZ/xxavHSDqp5JAz7CixYL8HeQYJ5NaJ5wk30BGLP2r7HA5OE4H?=
 =?us-ascii?Q?J/lPw/71HGb01mXoTdGlSSDpzdxb4c78rLJojTnzngZBvYEBr/hvIkfo+MJO?=
 =?us-ascii?Q?P9gQ+ZONU62chm3AY49Z91P885vCsyI9jUM8wTcLJFz6/axFNvetfi2hKFl7?=
 =?us-ascii?Q?JBnbqxpXskXvOz3hckXkks7X2BXLawEo5msuqS0YVgObM/eMNVSG+SvLHyDg?=
 =?us-ascii?Q?vEHPyrK4FYtqB0xSGR3JSyKYYagcQYH/Ugyg32PQeYvdK/D0c/zrfj3Tub3L?=
 =?us-ascii?Q?dggOTCP9VxHrhShYauZOVtJy4YOhXscgRoVdix0szsCue5V256VaAZMZ85wy?=
 =?us-ascii?Q?B9UluZzWOwl8Ra4ffcDD9f185f0ui1unkpwIf5WNTxgnQQrWLyyt5G0dw0vw?=
 =?us-ascii?Q?vuhIny8+WwRvsBJRjmvM9z66I4esReLbgMbM8qR87iK1Sa3t5BKoncnCqgLB?=
 =?us-ascii?Q?qby85DfnF4fc/WCQJJRuPRfiJe6TNPWiUjjUMqYQYd7bct1GiUKPpEg26mso?=
 =?us-ascii?Q?ciLhVA4TJ3mRXhIXVsvrWzQA5vW+fPqrfk0gXJKckJDk8AHzf5FvHqhiEsoZ?=
 =?us-ascii?Q?w1B94B3/ur2GLlZIegdlpGOOi/cEwyeLj6QSjuFgpIBnjdJ8bUQh64KK3kSW?=
 =?us-ascii?Q?w/D8245ebLFdexJ6ml944qn2pBwYP6WMJGhlVkR/BsKUF/HNrb9wxxnjtg9o?=
 =?us-ascii?Q?b7LDmGFJUpiqvfBDFFVqSj7yfX0T0fMTOkKNuHX4iROh+0IBa8unkrNwpIy9?=
 =?us-ascii?Q?Cp0x7sflSLCn0BHanb58Fbh9Fh1w0gWyXNW+xrtuMvgQ0Sm8P3H+pslEc6YR?=
 =?us-ascii?Q?jIBuaWCroS5z6qeCmeetiOxyOjRP/+OR5iSGPOFwHe6WLPF1tnP4Px073pyc?=
 =?us-ascii?Q?qbGwJIyw/B8DimfWkyXt5oy0mX4fRDA4lumNeE1zuATQdrM6ReiHqaXc+Uos?=
 =?us-ascii?Q?lgUxwIRO6iledTYHmCFufzFpyvqunOyO7gdVUUT9Z9qX7skaARX5BuRN2tZG?=
 =?us-ascii?Q?Sm+ayoY6xVi1S7GNLg0wFZiDQ/Ca3gxrWenZgZcaLp+8RjVo3C4wpvKmO7Fn?=
 =?us-ascii?Q?dTFE6tImDdRRjED2st4R9AO7/JnQ+lfx58viNcmGikw1lZY2Am0igDg9h5s4?=
 =?us-ascii?Q?9X+0Q2f5FniGs8IrWejbu3ZiJJSYB3+qzOIEdFvQWppWUfISEJdGZsq/rY+D?=
 =?us-ascii?Q?qsokcjEbomSSHrCfPSy6xFhQuPrWaWfDx7YbEpJNAaFrlaTXHpQ748PcpvOn?=
 =?us-ascii?Q?e3Y3w7HNgWcMDJ56aD//fcYKE84vj0/O+i4mR9rnzRI3tbpjNEQ7Z8k29WIu?=
 =?us-ascii?Q?6fZgnX2se9i5mk4SCFXPhGt/tX5lM40O7YU4ZvTxSKuAOQKNBbvftx1PZKiY?=
 =?us-ascii?Q?sDfsZme9zXjg0OmH6fEkfz7eaybFxO7Q63Iitivul1o814mDABsI6O5m9lgC?=
 =?us-ascii?Q?2+fQLWxhS5dk3Tm8/R9dMZ6z/g2N5PWvmHkTr+Lp31qITG12/m2HmHXecL+k?=
 =?us-ascii?Q?mftw6n5R1RrdwsYfI+OgFY4oApzP/hrR/mFbbdrIDGfq1pMH+pjEcp24kumV?=
 =?us-ascii?Q?0yh2KtXed57WHHDa+q++fUK2kksBgyz6yonCUQr6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d2a545-84af-4cc2-ae16-08db7df9c51a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:19:51.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmLtQ3xybGZnsfiptJhjw3oioVURIVueDGtWQa4vgMOr2ID1a8KFlwHd8ME1CMiZ5eP5bAV749IKaF7dv02xLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897
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


