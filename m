Return-Path: <bpf+bounces-4167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB58749496
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 06:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158AE281209
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25649EC9;
	Thu,  6 Jul 2023 04:09:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34BBEA4
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 04:09:15 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3548F1BD6
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xt3AaSzxxLfxYYU26Y8WEVZyHSrS3bls4sd7CoK3XnMSL+1xKhAyczNj6J1kCHiTXmfcHCQuzuNqbHant21qH0XsF8ZqQSWYmCiSghOeyJ7LEF6ybIOmYLvGF4kIqcfg1Du/w+nH7/yiD9aTVX+t9iCn24oil4zjIO9rocb+PgrY0hfNY7USOp3S0LDXyiYCXqbPR0HszeJM/WapHIsPQpPji59H1SVqCV9Do91c0BZ/1YJZIKsCtb854QmZXEyoVhWtOcBBC5oi8wCHX8+fQHc4ZQgna99FzJdYC+0+sxuWyRm6YnEIt5oeF9TAYlfDXijV+QhJsZppJLryycRWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCbo5XqEqbC+uIC16R9lbl1b4dXbL9eVmWQcvZ28mp8=;
 b=QqzLn13YZlG2zp9FBXYyd/lAm9DGSG7pEXQp2cWwx9wC2rkK49qSlkUAfJbEA0kaA/NhM21XE59Mqw48ikS3NTDU5tlI4/bSkJtY/cVQxUJL9sTeDnBoAH9gFO+cNPGCjJWq1JDxr6omy9el1aZg32tH/+J53Vpy1J10b6NhzEJTjD9YUXbBzmc5d4PyT0DHb0EvadU9Oia2sEWLFLn7e7kA9CoqyDkLtEASYO4l6BL7SG0ZjnQe2GoKUtLcA85K9oRwI2DWaCxTsFY71GNv30O2rAtGc1CWA363bGyD41is9zbzL+Bq5oEUQXHXYLJB25LzfeQnV2+kubP8l14Rtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCbo5XqEqbC+uIC16R9lbl1b4dXbL9eVmWQcvZ28mp8=;
 b=TAy1CT5Mb3We4ZJ8mal/WToEISdn6X8IS+6E30Bxn2xB9LmbY1GDaGfxlVLy7+vyr8HkSxI8ifV/l86sQx0Uk27BXHgoOgJu1aeItMtNqYGL41ttBoMGXubGMP7SncAu0Z/FVyAINqlj8qHE7jhN6Om+pqVpYcPa2qZfhBAyoPeqsbarpl+zVTru3JdjVXirThrJOsPz+Z8KYT7fRMeAwe8hDBuh3mjbraZlt6aXtI1LPPoatMRnh5qjbi5I+6BweeXocz2CKmr/te/teeRsRTmMb5dHTpVjuLcrjq08ktLlWMHiyTb0bGsq7pY4dWTabjvA6cJH9sggj2XxTm7ZDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:09:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:09:10 +0000
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
Subject: [RFC bpf-next 2/8] bpf: Run a sockinit program
Date: Thu,  6 Jul 2023 12:08:46 +0800
Message-Id: <1654cf3707d93253e1891084c74894a1f535abdd.1688616142.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688616142.git.geliang.tang@suse.com>
References: <cover.1688616142.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df549fe-a423-4fd6-78ac-08db7dd6c02a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S7pcFZA4yej74WdPo53fL4HcgQjhw1VUx5vpCDaoSGdwf92PfsoSbzvxKcLfSouC+R8yIA4PJt67omNppp8Gz9fU+ShsXGpgMDeI6xSKYz8TBxTdzAf9oVjtJbCkp40hMgoKNXAPL19f/2W6njDlL3YNPOnnht58Jc4Cnucp1KFUpHoPUEfarRE4Q++laOTCZkFrGVITqFLC2kQfp0BvVQwhQB7lJ4WkMLs+vQVz8YHxFvqi00EUdCE8ddcQCoqCAmsH3/ONggM8kJpeWN0GHnXqr1fNGkbpt4KgvMniRQa9ibRpTmvpwBGN5QUN+DCbl5hfgUEsVMHymqviSEHTZ46EU16VjUAIRuCTWa1P4B5G9nsKE+9fbGp3MYeG7QKmQfggP7VBwDqV+gI4XjL4FkT6BBZJxD82antACqhcbUY6CYT2T80ilmkjMd7/H/tD7b2dGue7zhOSoy+/CR9zWgxJO84wvRCphDkuRiY1S9oTkOm+jrkU6iKuN1mGQqwFEXfjZSXkxtp3DDCvqqPXXZHM1SI5x3LOz+dX3A40ODqbPRZuu46sYfS+rhLR/UF4d9bo1nxawhP514FaffV6nOWzmK2CfXZ8StZt4ldS31rvxYDcy1dMM04wbUCUB6uc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(38100700002)(66556008)(66946007)(66476007)(4326008)(921005)(186003)(36756003)(6486002)(6512007)(6666004)(110136005)(6506007)(26005)(478600001)(86362001)(41300700001)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3KDsbsv/ERqtBWT5xgxiE+iZ+S6ZmklK6GloWyZ6KGgXBeR3fRrdgC9pCPaE?=
 =?us-ascii?Q?dAR8PJ22QYXtvhqvoOY9W7ievXGuMgSTGnG+eRZl3oK1Da4wPfs66SrN1zU5?=
 =?us-ascii?Q?7nG9cNL0KinufXTxKOTAO4twZo8yE9W6VCLE0+2q8pfjlVp6TNRwBKXbcgFa?=
 =?us-ascii?Q?w43kYKEU86Uu9SiUljVBQmFH+L0sDv72+ArCPn4KnYO9okXawf38Gb7lpaff?=
 =?us-ascii?Q?7/KjE1FEnRx5ambUnBEqpiYBMUEQtJD0QQMyTRBlcS1BgBGpRW6DuFIlBiwQ?=
 =?us-ascii?Q?UnOJ0Mo8PkB3QE3zYem//0cYYkyo0Y+eCnc5pUdliDIvsnrMPLza+c9A1m0P?=
 =?us-ascii?Q?OjCm3xOLCTrWzUlxkvb8ZghfSUIijxbOsK7/SoFMEXdrLS5A2oR2m6gXYiN7?=
 =?us-ascii?Q?MwS88BBVYEOf5gCO+OQVQPA3jU5y6dfkyDVTAHmGy/vLHEHDs5dpNZRH0dAN?=
 =?us-ascii?Q?8F3gIoBOF79/mB2ef+EaaLtRv30K0ohylY3zW1fOph563e6gpQ4kY7js2uoZ?=
 =?us-ascii?Q?BBDHlapIOMboeEKw95Jhp+Tl6Han8sv2dITTVvJQbvmFfDOt9WPcS/nIjCH0?=
 =?us-ascii?Q?ywudLQ0LJMqz5IxZFHBvfSVgz8npwLnsDAT8ZOLSNFkUKoPKVhFccWb6FQrv?=
 =?us-ascii?Q?R86GOYhFvuGbMyB5ObRII6SGYbzaQh3ZfrOrBfh3KcPkRkDax4gHyigJlFOr?=
 =?us-ascii?Q?nalUm+0yQkY/6EqSE77PeaFtx4rvv2Ycwl2Jc2Zcz13Xqd39qmirq39sXX4F?=
 =?us-ascii?Q?6FRg/uyUC7mkfjdfu1AXUHKVowwQEeNkUOoTF2dgyMBXvNUNuGBatB6gZKzY?=
 =?us-ascii?Q?QJe7Y25RuITtwg+BtfVS/3/HFOSVaKauhjZ9mOEFsIPZjqrI/LJznIRkchsv?=
 =?us-ascii?Q?MQcY/zSCBxmnl8Pcyfd8HDs3tsJ0h5wh25WnifWyBC9qU9zDNjAhRjAUsfeA?=
 =?us-ascii?Q?sWuZzGI45dlxS51M8e3nh9JRSsexlnp4iQg3L7+vC4EIpLuwCJIkgpn9Khyq?=
 =?us-ascii?Q?MTUPpKeUMkk7D24e8J9HUxkwxr7kFyVsTsJkD1+7L6vkJhnVH+1PT3P6UxzX?=
 =?us-ascii?Q?+gVIesNlxke5GO8f/6oAbdfxlE6k90tFh2QTG9T1uauwkBGBjqWe0Q27HrwE?=
 =?us-ascii?Q?DDjbjxTEvzlAkq4mUpyzlW1zC/KMouEhMDu75YD5DeQrunccZsDQkxIjhLgI?=
 =?us-ascii?Q?8SkdvFpdCTfhvhXlH8DvRtzkES1iy9IHEBu0yXAk1fbpup2N3KWM/6o2K2Sh?=
 =?us-ascii?Q?5jWJuxci63wUktQmfThEaXuBEr8Is2SO3h5pwdfzcuWBoHUwCG3f9hENKbBs?=
 =?us-ascii?Q?sHchhp2d+OCn9NtliTSDNi0xbw5/cIXQpDXHv/2WEomRkMghtivJ7HnlYRgX?=
 =?us-ascii?Q?NL1jEsDtdpmPaGe6TWQ1lkDwNF6ObUpEkHTXxvJJsN4c4svZsAyrJVVtUgoB?=
 =?us-ascii?Q?GuIj3Q7TSGxO7H57yoi3XZk9OMZUCQYD9gpkTVtwle2EXoJYLxO89BE/vd9S?=
 =?us-ascii?Q?aWBkzSGvRRMRNK+O92qBH8m+hRgboQKD5GvL8oyhPcrgsDuEXOzxe3JUvVM2?=
 =?us-ascii?Q?b7MUd6SgQ0f+ZTq/Cb10kb9ePdaWAn+aacxvMAUS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df549fe-a423-4fd6-78ac-08db7dd6c02a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:09:10.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR051gTT01oXuUAxHyorozsXE0XPkXZraPfmlbQLG/QgSd0KClt9t3OE6ErOKyL4/LlnuvoejW6mYxrpnBZpQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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


