Return-Path: <bpf+bounces-4185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182DD7496BB
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C096628122A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6715B9;
	Thu,  6 Jul 2023 07:47:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E215AA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:47:49 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8610B
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2LqMmKNJW+UOiA0PXpSK1nJRIC6vz2TusNwEDqXw6RzwyvpzH6UqVNC9LNhz+I3uiC8WAl7n711uY+VpsPCecYumabZCL7QTac2HsFHY+gGP0YXwPo+qT5zaS0e7f0gXUyBPAC4apH+gyFXkIsFcHZpgPkJUgRwE6GiaktFvBv2ZaGMlkDmF4Sax5smI76HnRmHTx9REXweyG/grfxB8At8aAyR19X8suwdnJDTu7kBBNilnax0eARERzt4Gl40hksN0ypsEO/ktD2i2yMSFQxDUo8jSWxzE2uoskHychOtgcRMexMrZR53etj3F8BjBY4Ho5n3L8MR00dGnk2hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWM3md3G+KvRxqHdGU4Y07ll+NwhSVoOjfCi91FN6Zo=;
 b=Y94uJl6mxjKQjq7qysAKA5azPfEADA/uWX9/NNTWbkVRHkgfqg3lmRA+s7oTQvqi7oZ8+ode9RZGnu0CxUEo9CmOS5N903410iVPGF5Rmt9OIWL2iP6ONLQXnPXbXeQT0/n11ysXz5YiXYxqD0bmHOGZI+vxru0a8JhwIoKD2KpFlDRu0hyb5+uCS8fPI7D8BjklhNMBDc2Ec0sK/gfK2t0Z7qkDUPlT70dlejS12ElGr1T0Kcbg7m6fXRCc+UU75txhRELxuK3n+Zubw7x27okSA5Rx/N6osfuaLzp4+5cRpgZIaJb5FGZc521G27PoPGgjvjGeliJh1M9kFJOZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWM3md3G+KvRxqHdGU4Y07ll+NwhSVoOjfCi91FN6Zo=;
 b=Bwx4MX8FRr80gTS/zl9lKi+B7fWsfYQ1+dgft71/CSP9Y3T70ztYSNrzi1P3gD1n1INKpw3sAsxdMUu/iBImRuZ/sPk5CutmX4NWPMTlkyMPXkBqOElGACZLWSCfPiWRK1LJdlM/e6urk1YhuT0f+KHXz40DuLKB5AgaAjuf0Bg/pBfK990OoWO5ulMb0TON/tHwcVfERBxSBDiycKDlN1DJLclhvVICHD3HGgJhf4pRKfohJjcV7zB0Fcz31c+/hIlYBH3ewNUUfresapCczFPcQ3qVKUuTRu8OWL5kuxbMD6stx1k6s5QtvKFT0hl4KjCsxHMOZsOVLJSZPiEJcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:47:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:47:45 +0000
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
Subject: [RFC bpf-next v2 1/8] bpf: Add new prog type sockinit
Date: Thu,  6 Jul 2023 15:47:25 +0800
Message-Id: <0880130fe8ba0d721e63f6d37bd8ff6311eed9bf.1688629124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688629124.git.geliang.tang@suse.com>
References: <cover.1688629124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0157.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a48dfb4-29b7-4940-153d-08db7df54963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YKFIMH/QyeSHgJ2DZ7n13ZFltH34RsK42Fwqwz1GyYPovw1JSDeFz5eL2wPIzsYfKPWtcsT+WbqnvuU5Wxy6/PmyreUCXHQ7uzEq7WK5X7xmSDG4iUqLbuklFXxYBnnwSfkvlhGZQqTZBvwi8YwakEZV5ixIqdUUqaXzjY0osSsGxep/VaNqjFmLYNlC955hnu3s+H/f/GwQbo3JvQhIGerSoYhBABkKRXH4VDwWTHZygdKwRBRL6UeV7LNQq6wJHkSX8SweSsEeKIt3MBhoTqDqlz6ArwwL2H9AuZg4mCMb3bUpZhISrgfMzIweSLXc1bxmSRlHpEf4rIZ3ieCHVd1VeR9cTQK9QSMmDFGqhzUC0YDUvTsCZNKQN/Lf9IyIuQ30MUIzYXZLvX0vAYICJLffp1KLQeOgtdheYQQ/1uSVU/SS6QETAUIlZr8CR4X8GNEsVHaSuaRBYp8tDQ+3aOWod81LANWRITRphzsQ1MBy76A+/ovsLCorSSqUQbee/E/GAmlwoIAVmblgmwjn0LytMnEBUkH+Btv6AR74rTEO8RR4gYeLsXzIbHuRHy+ydK1NxT326S/sP6PvmeEW8WfeoyKTgGsZiim3hQYUH09xYYFTMvOoDUB3+6JUKE5t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(6666004)(41300700001)(7416002)(5660300002)(110136005)(36756003)(2906002)(44832011)(8936002)(316002)(8676002)(6486002)(66476007)(66946007)(4326008)(66556008)(6512007)(478600001)(86362001)(38100700002)(186003)(2616005)(921005)(83380400001)(26005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eG5FUmE+i/SbAODvh7VIgQBdB36U8kXJtWIqkyVbZF8yp1AoW4ROyjLY6gSW?=
 =?us-ascii?Q?na9aB12raVTsWJ8K7Qw3tztfakfm2lGSOcqXlSjksLbLyhZvgALKNaLJ7HhY?=
 =?us-ascii?Q?jmYgRXaOpxVABG9JI+s+WJ+GZ5Fj5ij57gjtxsAk3baCZ8ksRr0eMpnD/wDk?=
 =?us-ascii?Q?0hbj/ISJJ+bDEB3a1VZs5fio8pbf7b5semKcRImNZRkHASo3GbLmUtYnP4Lr?=
 =?us-ascii?Q?Pm438xYIjP641YLMyvTteGh0GjGUQcMXEoRkncWHq2zzbQzZWH6ZjhI2VaiH?=
 =?us-ascii?Q?Z+caqnKMul/Jih8BiC3MGvrABGVwi7y464PO+s1l5keeHQoqryK8IZDL/ED2?=
 =?us-ascii?Q?G+4c+xK61rumntgYP/x0X9XgPnLljXAJHZGy+fAIM4j8LlNrut92JwJjZB5p?=
 =?us-ascii?Q?m+X4KBFcVu2OgyQs+aqaQMM14msomqvJPEF1MT3bdvxziIWpSQgie6ziBkft?=
 =?us-ascii?Q?T7O7zXMvDVwMHfMTeGl8jbkkJO/RHlG2VSS797LinqpOWS8cHZZ26DCrO48S?=
 =?us-ascii?Q?TyvMEHp/DoRF08wTnvwBlafuprFvs9dzM2sCEPZdNBIQLZqwuhp8k5ZwFhOO?=
 =?us-ascii?Q?B6e0Hi1aJaA3bxvtg2YtLq+0DFdNO2YjwR2hnhmms8+wEu57Vxt7PSXYdQjn?=
 =?us-ascii?Q?3eRg8ybdQxHYyS/PoGyua+DBI5TBcWLYnEVSCegV8hiFOYSJhJjHWxt+dAb5?=
 =?us-ascii?Q?8sweRwOmm45Jy/3rT/ssGolep8jq0Qj8Nr1ppV4ajGWeyGeI9mD1X9bW1oo7?=
 =?us-ascii?Q?nK6hZ5clZbwRzYWhDD4Ovvb3MuZ8w6Mt2PpMmmTiF2wwghz3Gek0lLY3a5Rv?=
 =?us-ascii?Q?+BuEq2UyemstCUjk1h6Lg9whv07zPsamjH37vzLujF+blhzqY5xQr890tq/t?=
 =?us-ascii?Q?aOQ+UjKpnDtGOT+p9cjomKiGEsSErufSZNKvcd/9kshWm/Mr0jZNGdOjtTRa?=
 =?us-ascii?Q?BvDWPfAsaAtY+Ml7QhACg810TT3WHvm/WvV+giBj/Ihs5Vl5BLJNVKJHg7AT?=
 =?us-ascii?Q?2EGSwvA7KbGPqV2V4ymJUswBhLMwuVKa6YbEJLWLxz0G/RP+wr9rl3dpog5c?=
 =?us-ascii?Q?FoqQAKT9VWbR8hC0mOlqGG0B9IEENy/gjdxxNckbXkbCgNg64xoBTfKq84pJ?=
 =?us-ascii?Q?2i2aH3uEkc26P+253Zcplp3tTRBxD0yca3TLHpYa4ObzOLszi6ToE10gBzR3?=
 =?us-ascii?Q?YTtdqYWFD25hNmp+vJ5SYZoTjWf1FifS5H/RZ5XeeopLUYXcpiqhK1H1UiKV?=
 =?us-ascii?Q?TlLdSAu6eIJneLECB9T/G8pw5EI41zfmYOl4Hvuf8mJ2BxHpIDRMx+lu5Afp?=
 =?us-ascii?Q?ikFFWfr2ENdLTkucNC17FzvmyUYSlL+KYyDCZ6Flmo3f/x+CnhBj9TP85mJj?=
 =?us-ascii?Q?3UvxC+/UsUjA/G1gbMSDr2wur2tpWZAGY14rEyQU5AnDSxeYiO/nRfGkaNll?=
 =?us-ascii?Q?wk3MypPTt3+tLb87VENzs2MaVCuCj+TBDzNipPwKe3SP5f3Jv7V2NlYp/iHf?=
 =?us-ascii?Q?lpGUtB2YI0MYp4n2Wy7R0dOUtBTKt24+ABNBmm6hC6OWJJTqSTGDElytgknQ?=
 =?us-ascii?Q?8X4HKmjIrmVeZzDsCvfiitNomNaZ8L7aptOM20PY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a48dfb4-29b7-4940-153d-08db7df54963
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:47:45.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/mGt0X8KiS+euUyDJePOOiz5yJgNh7csjWGRvGpFJvHDTQwyhylMNUdEMeiCds7kgumqRQRHhLj4upjlKii6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
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


