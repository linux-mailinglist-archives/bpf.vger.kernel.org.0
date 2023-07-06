Return-Path: <bpf+bounces-4201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAB74975C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB2A28127F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFECC1FD1;
	Thu,  6 Jul 2023 08:20:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30901872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:20:04 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D11C1BE3
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATKtQAyGDz/OS2YQ/gMV5hOw5FTvIujL9tPGcc6IvMsPA15hDpm1zVWh0VsFrrNsBdAJN3wu0f/rQmOwa/t38Y+xR1pN0vKWAptpPRtALabJHtxA1c1iuen6kewoGHLm/LNpdlRPs5iZK0NsdxKBsI8/ENpnZc2PJFPu5zmbxRVxKxRSd2+js8BYoBmmetHzVVu4VV8DYDxHSGZej+PFwIi/6fLO+D60Kb1dykZP4HcCc2UrjIa7kzh8j8lpfrEU+s7Hy4ibe3+KA2r5R6ZcfeJhn5dBf5K8p/TSJqDayBeVSV7SDFlMpBuWvogtJKXuZtuuIUFpmoj4GyTsIzyBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCbo5XqEqbC+uIC16R9lbl1b4dXbL9eVmWQcvZ28mp8=;
 b=GoleiZ8f6UWw23TpEijS/c4hdGmtrXyOHzFROm571m7lmx5JUHjdJNDgUP+rYVqOrvYFFn44ghuYVXiq1X20/OkWyjrv+Jq2KJYNaJ4ztzg9RM3Bo7xkbHuLhmzR7WS1pbTeIJzd2FS8nlFz8uf1IrX3vRDo333Ml2ObT+mIaTN+ISNdC8YepE2RHLNiKvmLKeAoZv+vVxKfUdJhbo1UPoFnXTK55dr7gQpPMbhQviMYCuFjRVDg/GvwhpCKCB4ORO4ypzf/LzCdHH9FlTJIEuN2gKYYA+A8AyG7BdTKsPFINKz9DX0Ue4ef/bc0US+ym0F0gX/a4tlqa0DEKsStNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCbo5XqEqbC+uIC16R9lbl1b4dXbL9eVmWQcvZ28mp8=;
 b=Y8tw6p3D3aPYVUXjS6Z4gRrbJJzhssODtxJ80O7X4zTK5tpnjuQ+0ntZS9/Ifg/4VFxuPOYk6cWWS0ZvPQsQ8g2CufNWBr5pvjoRTXXjg75EywnTvEGv0u0fOmL6Q9l7wyoOPNP/nWjUbyG9zczi1B/Tqx0vmvjUOlvr3bsu7JkgXp4YipblBAgfNYMPwG4YVQoVCaKREg/jYyj6RDX8fLFOAOGSqt1o1zejUnKsLLZ6d+PBL7401gLRUQpjZzRj8apXXZnKLOXeMr2ceW5Po1+x2cuy/3nPAjVFow8EqkIKMUjNcjd8Le0qeiW4nwqG/8THZmTiZSgYPEzU5jk2Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:19:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:19:58 +0000
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
Subject: [RFC bpf-next v3 2/8] bpf: Run a sockinit program
Date: Thu,  6 Jul 2023 16:19:41 +0800
Message-Id: <1654cf3707d93253e1891084c74894a1f535abdd.1688631200.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec314ff-fe2b-48be-43b1-08db7df9c912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UvB61uXXTZGxuRuuMhYkO8m6sOwWUXNl3WV8b9iRlgq4OkmWBr1OY/pwWNMC7VGvQC9GtiaU7ltMqjarkaPPQ8jKvB7JWiQvvExGrwx1zfLj0zlq6+CMiIX7DhAnf1RpiseRkF48cv+GI2SHkMKRzTd9usOTpOCmWNW0S1Iq5SEBPeRclbUPc8WiyDEIqnKPM/MxYaZM1iWMNpiZLqIZH5/5FKMDuYApo5yfeNAVVXuZ+VvPAAMnhK823gCL5YEF3oHtI+MYKm/H80D928F/BF0Uf8rSE0a0QoUOv8MuxRjAaeTg2v1YF3448xCVIxW27Ah0Xkjqohq4aDHIFt36bSN4uXC/FceI0u2upUCxM0MZ6btr1TNDflUjzNa8WLUzo/a6XggmFSababsRzLJSIw8HLZyfcIw8JgGXo3oicWlALyr7AaoaI2E0GH6bQ+r3bCswjw+nWwPDmrTPL4sku/OpK2lMs2RgsT+B54RBmq+PcayNGF+3peUL7feLSHkGrKJTR3SrgfRpgBrI7acqM1ww7WJ3UZAK05l78iPWE7aJZxKEZFSp287qGBYT2GRKqFB6tLSaJymZdVfTKRJp3Y3CMQZAHsmQb+LKccgucokBWjxojsDfvWeiLlAPy8PX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(7416002)(8936002)(8676002)(44832011)(83380400001)(41300700001)(5660300002)(2906002)(316002)(2616005)(66946007)(38100700002)(26005)(110136005)(4326008)(921005)(66476007)(66556008)(6512007)(86362001)(186003)(478600001)(6506007)(6666004)(36756003)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrJgdSsunfErFRC6cK0b+AM2cJjZ6eUHP7bz6EVNA32sJ0KKac/q1hoPQu78?=
 =?us-ascii?Q?Rj/5oYIeT+3fmZOxjtUw7yCXYrtkIFuy8heI5uUvc+esgTX1lHKOAFZ9EIc3?=
 =?us-ascii?Q?rIQx36HTNgjkuBve1GUsmk0Q9A1WYFGvUcS1/vNf9Dh1DAksXCUVxFOwEIdP?=
 =?us-ascii?Q?qB1asKt5RQndP+oQA6kSJUejoojk7wXzNaJYy9keP9vn3OlxNX1R6+sBpEcG?=
 =?us-ascii?Q?NDrR/l9lmaIDg4L8KXTRzM3IGdapbgf4S9FqcTbJ9/p13Q3EcgKRKwt5IfSo?=
 =?us-ascii?Q?VniAwzmMf603bhlbhyzhoDlZa61TsHXqHextcy9Hh3DCS6bdR01AhQOE/PDJ?=
 =?us-ascii?Q?A3OnEGiNk6iaAu4YK9OuRRPgbJXBDvk7JuIiyfK9BFHfgRTfwU0uLA25UsPV?=
 =?us-ascii?Q?U+zSJClF+s0lCgU1VZLSAVLKLzWAccNtSJ9WrbnRAmGDOnvUirC83sjmDQH0?=
 =?us-ascii?Q?4//3uS/wSWXZEDsLUSSql+A/ZPVGtrFCrEfqEmKZsQPVaHbADC1PLF7StsOi?=
 =?us-ascii?Q?4JDiJ9WEWcPsS/rC5ozuZKNZ4BSCfUTqSTnYvFaXKbMkLuaocuQEvczdwDzI?=
 =?us-ascii?Q?045Kzq9asqaQTE0JLrBNmBIMaRavkeMKyTf1yyTsBKxRw8g1OYoK/5oKLJyr?=
 =?us-ascii?Q?IBL3JKVnkivf5Bkzcs7vTJOZ0aTuycr/r4gMJX1s/OpZKrv0jtJCGlr6qeiW?=
 =?us-ascii?Q?iXWPVMwmapSnnWAevHdVyG+8cLOIxDDmKBb6rmIiSeAqvG9y4AgrCjYqyIZj?=
 =?us-ascii?Q?DDWs1HPiAR79kCIxdn69CLe+RQR33/MeppN66g6eAyUMRPrEstrTqdfyJWDK?=
 =?us-ascii?Q?tKzCDbdY46BVs1Au/GUAP+ZIq7DqETconuq1Z7lA+GFHGP2ZQS/RaPG/d4S+?=
 =?us-ascii?Q?5H3CO1F2WAL74k8NeBP52SlaPwrD4yFEgrGtogZNfLkJnvCJXf194hMmcjAa?=
 =?us-ascii?Q?z8WOdR9kw9m3cnuzAIVjRx+JtH6qotluBbmdA5n/AfTEK6qLoTS+1EQ29Tgt?=
 =?us-ascii?Q?xxFR0Ku3XrWMOSopXUDQvazF31ITT4kFCsT88IOfnaf2aJWSRFvDZLZ+/Rix?=
 =?us-ascii?Q?s5VvsKSld3V+6cAQuIul4oAjXVL7oPUSMM/UF8oel+Ozd0vCDMtQtKuQhkok?=
 =?us-ascii?Q?grx+r3lZ1UhjcZVOOpQavlj0mO2SzMIWWPK/1x5/H6WD5WNLot9y1H7ap3+J?=
 =?us-ascii?Q?s5cENqxJCqylcvKE4YJnfKyeN2zzIMYNC/tcb3xp1mJhGe4DRdcU0Q12Cv6j?=
 =?us-ascii?Q?aP+xWlYE+ovaDBdQkb/QCQwi9bWYeLRc8oClz5vny2ZBj03XbmB4SHsBUrH1?=
 =?us-ascii?Q?O8cRKNRYYuPDN+Zppo7PYiiF+i+KNRLkOF82xwfHAEYYpnrkKJRY7CnHqfXm?=
 =?us-ascii?Q?zxbby59uSrKpwxR2wRgFG7tSd3ofg8qicVRTs9G+X16OR4hvVHx5IbmiuL8M?=
 =?us-ascii?Q?2e+tKBVwdzIjRAiMhJvVtkDKPYcboAKty9zV145Lqqfrf2PWj8JIdNV+/dOi?=
 =?us-ascii?Q?dYdo5QpuXKbd2z7gxjATh0ljl72v1qPd5d2GhDjgecxMEr0mNFVFxr8LxApA?=
 =?us-ascii?Q?156lhPVrCD2KPgPE4rfDGWpOa6uBFP4v7bhJ/6D5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec314ff-fe2b-48be-43b1-08db7df9c912
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:19:57.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEn+bbrap+GxLdyB+0PIS0eS5qUBRQANGBjoSbJfxqOnNMvx/rTlRuLmYoYhL1uZhF/Y7lqmzPDXriXs+gG2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897
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


