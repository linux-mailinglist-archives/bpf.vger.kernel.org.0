Return-Path: <bpf+bounces-4186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028417496BC
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE302281259
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC1915B8;
	Thu,  6 Jul 2023 07:48:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F615AC
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:48:02 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051C61BD2
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIdllxNbpfcnXXDqbFP9Hi0C4Pe/60IInh9FugHKJB+w5kS0t0fRRq4W0uftCcZcYmqfwabb8pnaVxLHP2OEnsEgf3ApLXsffQ8PJZq+Aa5JvnDE/OFduze34yyTgycqZXSjY4puC0FPzW4dTgXIsoH4RdKXXGZtvy54K+irwI1gzizGwcsTdoBiYSkEbMYEp9ryWKA853WKxKZ9OztcZZ9OStzuatXeBf0T42uAihUM0Par51vYC9GfjoQCyJ+bTth9VZtIKUhpBA2pkjiBQT9Ug/Pt8f6y7rfeBQ1jru+4O/3x84sgGo7TQQgvbULevyzI7Doxj6v7QXaZGZYtHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCbo5XqEqbC+uIC16R9lbl1b4dXbL9eVmWQcvZ28mp8=;
 b=TMahPZnsBiCHHlHyqsWVgCqa5C60nYCZ+XfBj/zJyXdyhtJcW73Fjw2pc5z/BeoWEZY9vhmyEwyfqDl9yTumMydQsbIFVzt6X5CdyVQs4ZohMMCg7V5Y3D2VmLrd7MHIo2sdz+pHq3x7iVfShIj/4uuvB0AlxF8O80lAprjd7K2hhpMFFbeXER+mBQ+vpzDNhX7xALtchWF5PiygYaWz5J9EPPSApw68pdJhvdWImc5rK3Ww9KTghgpIL7MnTXVjZ3AWjXTJ3tY03uRws7HbNQKlUY1pOoUmNThohBsOsYyQwzmLDn8OL8nw5htwzOE+I5fP6FPkMfLhOLGTvEyLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCbo5XqEqbC+uIC16R9lbl1b4dXbL9eVmWQcvZ28mp8=;
 b=FVY38LDASEKIZYU4dutOpHGgW3VXm5KTca0crdw2sUqNhCmgZcrInIH5zPkwkldgTM6sXauIaZ60/BpPWMqBrBSNWBiDDgChyQzi3dgK+CDUjB3C5Gpf/T4zG2324z0FiSNSKpIbidMqLlV3I/lGSgyzI4C2ZeVDIxqfenPKf9IPqHeBoZwc+oOJMS1UX5hoKufVXNXrIwWWbp/UGtQ8o2XKY+Vre5GCyth+6eN+/A0h67mvnJ+KbFV06FoXRUdHo8q4UyaqC0yquh9X4/ccUpwyqUqMHVJezSYAV8coW4gaTrEQfGR/wVioDEVOZd0DK7fEcwYQ0r0f85xOIRy/jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:47:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:47:57 +0000
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
Subject: [RFC bpf-next v2 2/8] bpf: Run a sockinit program
Date: Thu,  6 Jul 2023 15:47:26 +0800
Message-Id: <1654cf3707d93253e1891084c74894a1f535abdd.1688629124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688629124.git.geliang.tang@suse.com>
References: <cover.1688629124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0153.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: ae083e39-62ac-4791-8f36-08db7df55036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0pVdzuGjk+pAdoU4UTTOVVybcU4+1WY9MV/v9fbFzGCWwD2mYnWnIHCr/WmoKUixJ30N4Q3pkfAKF/SBI1MBLXLMPZTnQicFc6g680Hg7R0PVq/0pOOfLHmnQHlSYClyuJkisAQso0yV5SUyBfNE8I55ZzsTAdWUCx1qmoeSTlE6y4NvAmXrPPYLZEMf8b9iuOoLVmWy1JRw0Ui05/wccnnS4SMaRfBclhyQG09HgUYM5Dm4Kbb786vcz/0+RZxgmFns8qd4NbOXTrNNFbQDD0Xwehc0xq8MjjuGgpfwQwspR+F4ncTaFSSNZV27Vmo2BCkpu5dPOcsrACkXXNwCl81TusWbJA+AIPpfMGSiDXuABzykygHzeDAKbnYh7NacOwdOz0yHG5SmnMyVLFbAamvgdDbxtq9xnhTJ9LqWnhRywotWtB30txfLbFuAIJsRxnAhVjJe2A1zNaqK3+N10p0n6v8n1kYkBY4px96ona3jAXkszd2aZEgVkS4X5OGecrnCvKDWGW/ykFm/qVvq5nsni5qmp2AMr+d5+jJFX2MKt16rJSUxXvpWgljFCJu0KP0NjUUrDuQ7WhfOsR57ETmH3nVhEdGJD75W4o3/+HpBDtu8Dqp2xo5DF1bfqhmd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(6666004)(41300700001)(7416002)(5660300002)(110136005)(36756003)(2906002)(44832011)(8936002)(316002)(8676002)(6486002)(66476007)(66946007)(4326008)(66556008)(6512007)(478600001)(86362001)(38100700002)(186003)(2616005)(921005)(83380400001)(26005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OZObJYpFlBxRHvPPao1jqhcb0j0DLqcaor2QyYOV9oV0zV8qfasEwdEjwAd3?=
 =?us-ascii?Q?4YjN1ww59lsYBCoZWaJgEMGZcMbIQAmteiyytXNOC6haIJmUaemukOtPEEfa?=
 =?us-ascii?Q?aBjuqEz7e+vFvtCkUCgNciPCmQKhixBK9YNU9CI4IRctxhyKbUtFAbBSnC2x?=
 =?us-ascii?Q?YcbLdOv0J74IOOybsofrc/gci4o8afXHQEp0BBGOxwHhOCkD0MdrIFrFLWVI?=
 =?us-ascii?Q?ezLGog6tynJKKDRp16+Du0p8rYwMvTHmvlAdd1YSvI8PYPNZz6mIbyGKGGGk?=
 =?us-ascii?Q?G9n1FsRDRrhB0CAi+mhjSZlJSgmH754OH1VrhDaQ0VeUXn4Ggx4Fiz4+aDrk?=
 =?us-ascii?Q?wgVmBb8y7y822sMUHBNK2tnVFkeBioKmmmDY8vxxrSJ19Vl7EA7sKTLl1dTC?=
 =?us-ascii?Q?bJ2dNFMYV35bbryXzfe2GAGpyq4say8uxuygD0my7gkVkmHk2CwBZ35EJibJ?=
 =?us-ascii?Q?9eJTgA3+Y+jJToGqkuxEwFgvVnjQdTLBkolwRXrF7qXckWm/T/9mpd0F/K2f?=
 =?us-ascii?Q?G869So4VoECML8woW98rxLiPCm+BmjCdyETCQaFn88hccTxVFDGLboCxWc8A?=
 =?us-ascii?Q?yk9/sfQYSwnNGiy1RZZAJAoDNtXyEBkylq9G/yBQY3m4yzl4TEHf9obYWrJ2?=
 =?us-ascii?Q?kkwQXnW9lSfnMESspTr0IJ5n/rJiEE7JdmtuzVVyiwAkjsC/rq8tE5hwJYqn?=
 =?us-ascii?Q?rgyLMNPuA0UsfltNycJKvXnpBN/hp81cwazhLvp2KSswIACQ88DQ0QZ4WjMa?=
 =?us-ascii?Q?ajhjzigzRj5wjYBehqNH56pL467dK8+1xvkrXuzdSrd2JUMmQxNl6rnEm/8L?=
 =?us-ascii?Q?hsbbggbhasJsnJzQWdcJ3flKPvok7ecYmdhg9yWPN/jnXG7/SsPD0pM7devB?=
 =?us-ascii?Q?EHrafrU3b8/vU9y5vCGM8DpPfLPdtYvIe9U/8lpoMpjCblgyysCWLjk9k43K?=
 =?us-ascii?Q?61itc03YV+60M69vgMcNdSO8twOY1IRDAzb4Rpw1YncyCnDbk5ncpkMaKg2F?=
 =?us-ascii?Q?Aiy71f0BqCT30Te/98vg62SWmWgHYZ/H2xg19p/rrhzKovw/YgYyEt5LFWpI?=
 =?us-ascii?Q?yLee/bIPZEJYAVmchuijpbY0/UYRxnlgq8943Jb8H86aRRYyWLoN1lkV81R+?=
 =?us-ascii?Q?Fx8V59J1d9FOcQDOCLfAPIL+dw11+UncGONcOColk618/fV7n/AGTTjHex16?=
 =?us-ascii?Q?qvKvkAs1+NoVO1slAZSJG1CnkMg0By3wSZ+svrWJ8qavjrLe3wmsutRAEGjb?=
 =?us-ascii?Q?6mdHeIA7ASFCWfdjwSZwW+b+bUrY0oGJbsOal/TKLkAOQr+v1IbN4xLYxewi?=
 =?us-ascii?Q?RCQ9+zZ8tC6ZvJ03ejkGA3VHnhmhYs6Zl2WzpdSGJXR3KJFp47z7dCyMuin9?=
 =?us-ascii?Q?PrCNyeYjyMrBfyFeuxtvSzPrThd4YCKWq1gUzy85Z6/nXcTKQSncLg17N5/x?=
 =?us-ascii?Q?ozh1o5+/IZi7jhyw/EJtHn5cKl0rNPI8nFY+UPJmWxRgx/Xh6WW2aC9Vefz0?=
 =?us-ascii?Q?AV//l5h/G6jzdektf6S9AEqvRNf6E6ArQksfbWroqNe1wdYZFgy6YZ0/d/9y?=
 =?us-ascii?Q?vPx9fk+rxHyHnRnRVdYsm4eB57QtjUv6W8uxfQp5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae083e39-62ac-4791-8f36-08db7df55036
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:47:57.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBLvwg5tiF4zJcm7BAp3aiitlSjc7JzLvRz6I41J0byWGDm6EDjBM5w5oeMAbfWdOG5ufgY7ZLBJlFwWRzl80A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch defines BPF_CGROUP_RUN_PROG_SOCKINIT() helper, and implements
__cgroup_bpf_run_sockinit() helper to run a sockinit program.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf-cgroup-defs.h |  1 +
 include/linux/bpf-cgroup.h      | 14 ++++++++++++++
 kernel/bpf/cgroup.c             | 24 ++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index 7b121bd780eb..aa9ee82f5d20 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -37,6 +37,7 @@ enum cgroup_bpf_attach_type {
 	CGROUP_UDP6_RECVMSG,
 	CGROUP_GETSOCKOPT,
 	CGROUP_SETSOCKOPT,
+	CGROUP_SOCKINIT,
 	CGROUP_INET4_GETPEERNAME,
 	CGROUP_INET6_GETPEERNAME,
 	CGROUP_INET4_GETSOCKNAME,
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..a2f58f0d2260 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -57,6 +57,7 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 	CGROUP_ATYPE(CGROUP_UDP6_RECVMSG);
 	CGROUP_ATYPE(CGROUP_GETSOCKOPT);
 	CGROUP_ATYPE(CGROUP_SETSOCKOPT);
+	CGROUP_ATYPE(CGROUP_SOCKINIT);
 	CGROUP_ATYPE(CGROUP_INET4_GETPEERNAME);
 	CGROUP_ATYPE(CGROUP_INET6_GETPEERNAME);
 	CGROUP_ATYPE(CGROUP_INET4_GETSOCKNAME);
@@ -148,6 +149,9 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 					    int optname, void *optval,
 					    int *optlen, int retval);
 
+int __cgroup_bpf_run_sockinit(int *family, int *type, int *protocol,
+			      enum cgroup_bpf_attach_type atype);
+
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
 {
@@ -407,6 +411,15 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	__ret;								       \
 })
 
+#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol)		       \
+({									       \
+	int __ret = 0;							       \
+	if (cgroup_bpf_enabled(CGROUP_SOCKINIT))			       \
+		__ret = __cgroup_bpf_run_sockinit(family, type, protocol,      \
+						  CGROUP_SOCKINIT);	       \
+	__ret;								       \
+})
+
 int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype, struct bpf_prog *prog);
 int cgroup_bpf_prog_detach(const union bpf_attr *attr,
@@ -505,6 +518,7 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 					    optlen, retval) ({ retval; })
 #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
 				       kernel_optval) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol) ({ 0; })
 
 #define for_each_cgroup_storage_type(stype) for (; false; )
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 93b9f404a007..fe294e4d618c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1996,6 +1996,30 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 
 	return ret;
 }
+
+int __cgroup_bpf_run_sockinit(int *family, int *type, int *protocol,
+			      enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_sockinit_ctx ctx = {
+		.family		= *family,
+		.type		= *type,
+		.protocol	= *protocol,
+	};
+	struct cgroup *cgrp;
+	int ret;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run, 0,
+				    NULL);
+	rcu_read_unlock();
+
+	*family		= ctx.family;
+	*type		= ctx.type;
+	*protocol	= ctx.protocol;
+
+	return ret;
+}
 #endif
 
 static ssize_t sysctl_cpy_dir(const struct ctl_dir *dir, char **bufp,
-- 
2.35.3


