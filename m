Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716B356D1BC
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiGJWKl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 18:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJWKj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 18:10:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE19D9FF7;
        Sun, 10 Jul 2022 15:10:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26AFVbru006469;
        Sun, 10 Jul 2022 22:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=iZMK9bktdwDJd00q6Om8llTMLBx5AoG2S8LRR0BTstI=;
 b=s9X2xy2+jAXWPYSXKu9v6yOU+zjX6sJYQf+H+ZbO23h+2iUJzx+pKY3UAyC1qYSCY1jN
 OPJCiqEFkRuC4cByfGxbNp+zJsapQDw3Lcs6oLFTZHVpTCcEevOzpRxjeHhfOd6PErGL
 Q6SAAoi7t7YKHxw5m0m9sk2SizDas+LcUN8MAmTGHn/cmRwuXrHkG9B4q09qR0gKPZbE
 24TwEBqgjZCj2RDr+0jeqLcrvFByXBprSXGj132DoFabfAQTWr53WliEtFlc0pQjRB8W
 ay8TDCIta1tMRDoKLfj5MdKfFZ7VpnsQUGCMyEIwLuSJFdpFjU11eXLZ59+/iQP+jYAQ Zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xr9w7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 22:10:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26AM5CBt007949;
        Sun, 10 Jul 2022 22:10:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7041x8t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 22:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQr2CHMTghKz+O9dS5/kW0WC0Mcm7smYylVSW18Q8nN1P2eSU7OIBK02OFEbRKZH1MCziVJ7bpiupPPti/OlqOsh7udJK2TnTIH2F8lsDnysymZfXfcQeWI21ftYu5GfwrPMJxmcemy8XarQmWlUuu2GLXANLHvxTKsmhgFOj4iQlsSvBsImaLRjLtAgQh5drMYWUxllpauF/5MWwb9hnEUVIncAmD1kk67XOO3UV8Yn9Os3b5KRDeDYhfH5yeKzpR2Ksmgpk9g31CreJxB8I/IhNd1El1PNdA9ZYde/hEsSDT4N7wwkMp+fxCXWsOAF+Qo3PRmm1s3f1bLt3VFXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZMK9bktdwDJd00q6Om8llTMLBx5AoG2S8LRR0BTstI=;
 b=Jgq/wH9Nkk1z387qLRMZONU8/aXIlRlKZpTRU0Cuvp6jJln5mFF5b/71GhYb262nLfSiPRJTmgZw06FpZ7Wpmd2/UyZPKYq49lk2IZ7sQ11Evavtw/tv/i+RWcBIBrCfy8thZbt9+iiq2JKyBu0ZksjZ+r8Lthys71b9Gy/qc0ASERQLe8rBpZdC2HGPR5mupq/vZKuC4GogTxGXSw6yrq1TZiPSBQT9QnDlTpBaxKWzZ8YgQFn/2QlX6UQDroMfX88+HheQmjUQ738GOtvC2YWjEw2QBipc9XRdRFvb8s6oc3QlUUXCvdFMWwYY89FeCLJzYrHWQiIfz5swq1MIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZMK9bktdwDJd00q6Om8llTMLBx5AoG2S8LRR0BTstI=;
 b=Z4GpU/YXyEEv/QZ1Nvw/SzETlLNf/xkz1++f7qQc8vYpYz6kKqn1WHJoam/mYtGoWyOY4LmJNLntz+2zJqoI7rAAJ5YP7q7SVQKtFyIOqenFLQvgnKS6NdJmleWzEry6u4kS2zsRMcC01iKRjUIghX3oUCQr0Y8BVHEuRTz3e94=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB5207.namprd10.prod.outlook.com (2603:10b6:408:12c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sun, 10 Jul
 2022 22:10:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%7]) with mapi id 15.20.5417.026; Sun, 10 Jul 2022
 22:10:06 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 bpf-next 1/2] bpf: add a ksym BPF iterator
Date:   Sun, 10 Jul 2022 23:09:57 +0100
Message-Id: <1657490998-31468-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657490998-31468-1-git-send-email-alan.maguire@oracle.com>
References: <1657490998-31468-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0355.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::34) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df608e25-9c49-45a1-8d20-08da62c0f1d5
X-MS-TrafficTypeDiagnostic: BN0PR10MB5207:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fHebmAnGMZWjZM+GnACa8JZlUaYTtOP/f8IHHPSp1dRWmmzahLKDp5OT4NFfZptTKMkgmKz5cjm29lRi+aeOBBtPzFCUaqEBWQfFdQ27e0zUD/rnf4YEG4HANC5qvwjIf2dVw7koNbe2FbWq7HfJVBDx4DKyG4bh/djY6IPzAJ3zXaIGfyfd+BmdJGBDp0On4Wm/s2yROMMFUICzXDe0kuFzlzXMwLJ/q6O6gYBOlm2x7uDMqQ9r/g7bgbhICoCaLLnN3Z0b0P2a49F1vX1fTCOmZuReFxoSwRAv4AfXVx6N1KRf44ZdLPgJEa1vn0w1bC3izV5U0EGvyU/NQSJBHCYZBV96GllQJSMh1IS/PiU/GlKGQGK7Ut24powNCnoiHhqefABuJWf0QVxfMHlgDQAg1PxVsSuzoDzLRpArdxHvp+d5wrL0MPWazcegG674IOgw2B9CeNg33mcBL0f5zDbgMB/tsfwy0QW+hSFimJhe1xP3SdIm13YLAWykofCPzEPHXLQkPCAGj16rN04aMzzO8qKsBzpHfjVMNCQ+l6kqV0R6bCInycAHDtKb/ls1x2DXnP8CZuKMP7zZfM2ruHBFxQB1ETL5RAguVq0ior2cw2XTZ9mM8njQHRHcexqTaN7KeCQF9B7mmeOiZy+ljj4xwC9YytIKRwbQjQ/q34N9gTCMi01Qu2oekRfiLeXa3/OdJkRPy40JLc1q7giAmapHM05QrVLss+ii1c9PcFkCAhr2DdodqKV1HmAxXVPittgYLPoO/XdNe0ph5K79liG+hPRroRueuXgiWZmhW4hmX2HO9e7tHPnbrM/uaAJfcVSeN4zZUbsFASoEwAQKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(366004)(396003)(478600001)(6486002)(966005)(44832011)(83380400001)(6666004)(36756003)(4326008)(41300700001)(66946007)(2906002)(8676002)(5660300002)(7416002)(8936002)(316002)(6506007)(2616005)(66556008)(66476007)(6512007)(186003)(26005)(52116002)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7OYGa0QSyQIM9lzeY9OWlFc3vCo93d6ZIsV7E4a2nu8zDoZnsUCjWQiTBq5g?=
 =?us-ascii?Q?UGOYRgC68XHhxrulOPbM9zmMga80jI5oVBb25qUxyVyvvOW4l8BegrB3caQa?=
 =?us-ascii?Q?wluwSClUGiH0VbQmbDoWNZGJYT5+7AKTZq2KTyqb/mS64/8a3LxTsfooKCbX?=
 =?us-ascii?Q?SPPKmcOxFiLFU9PpiFK0dnlUBzo40gGGBO3Giit1e9elH+whycrdDRGCcBQP?=
 =?us-ascii?Q?0Akw61ICvOCdD5ZdES/GIWYBUG+QHNmlySYL8oF3AKdECZNNeG7il+zW6rcM?=
 =?us-ascii?Q?M+d9JuqPfAvOqwDHibCAnfd4FVp2i8lpLA/CWVWNAsZMHE4NQPH+VTt9rVf1?=
 =?us-ascii?Q?AkIrqzGAhcstwnisSAKlNZEOUmqPxhNgN8odSHr0GuuJBphNU0ZjpSsLf5vv?=
 =?us-ascii?Q?hfV++GinN7Y26F479yd9irI9xC8cFjSBFA0SxXghxKIplTDZ2oZCdoR32T+W?=
 =?us-ascii?Q?1/Ctfw9qADwEVBZSaFuushoIJjDtakG/2dSAMPfT21loYogmyMmoQYaX52mR?=
 =?us-ascii?Q?KdBgyilwFODTf/HiSiF2V4VIBf0W2cOmB5+jr61J61/O/Gg0imvRmKBWl5be?=
 =?us-ascii?Q?79I51siIN9ifi1PbyEEXouL+1RMU+eVdwCrddTentlwuZYeDdeRdvZ2JjICi?=
 =?us-ascii?Q?Ezes3MoJI9x/1+kx5ouQatKxrwb87qWViphsWJzdAxHMAdEuvIC1exO/vn9p?=
 =?us-ascii?Q?HutjBNgkS+MX+ycGJRzrLF/mXR7qMGoKAfO82xn3J1CYmHOAFZqIj6cSWj2E?=
 =?us-ascii?Q?D7dzoheIg7K0OkETEhlwurByIJk+DwGDdTKNwiNVxM4GJjel3HGV055IOdhR?=
 =?us-ascii?Q?dzOXEki2fOsWrD+xC5ngvKfJBl1UvfklqsNMAuNo/eMDlf599I3F2zdZpTx2?=
 =?us-ascii?Q?aPkDxtpZPk6Mz1A1rZlcOmnzKH7e0cKTKwGzh6cqHgAR0V13orJMuziGCZJx?=
 =?us-ascii?Q?rM7JTSkxN7rbBLtCdUtlwFKIp7lmXTP8RT4B0CvV7sydDBeVIyi/xDpTTHvI?=
 =?us-ascii?Q?OCqp9b+GU5nYm3nC8nfnaGe++05teoCHxtHHUhRtmf38zaMx8jsnn0moSM4P?=
 =?us-ascii?Q?kjwN0HBnwnrq5D+dleHm62ohlI+3e/WWlRTUKwulipW9Y4ftHIj0sK5wLQw2?=
 =?us-ascii?Q?6iMueRvCeZeAh1GlcB7Jsh7nvtgXgta4yV+XMl9vadzwLtdYAMrByp9ObYHs?=
 =?us-ascii?Q?Hm83g8sSASIY6iX9jlQkuEia5KR6NHY+s1kKIHd88NX4VZnQPmPKvsNwGqE1?=
 =?us-ascii?Q?sK5+M8eomju92Xx643bdtTREGfg4nlPTtomv7KXz2Ijfu/v7HajAKzW/p4Cy?=
 =?us-ascii?Q?LuqL6/gpTzaiW/me8ns4rOUJcZiTz4Hxu4jySun0OpLtbJzCAB8JVoPSOmdJ?=
 =?us-ascii?Q?6KpUt1Zu0ByVAcHUcPvbCfadxDGpQzgNZ/ucD+8PKiH3knJyb0yqMtsPg1NO?=
 =?us-ascii?Q?gv3Gi7UTWCclzuKUYGZu3ElK/Yx4NkO21rpon+R3W3Nt06XpBBsLaTWIeUiq?=
 =?us-ascii?Q?RHeS1tt2Zi1rkbWtgtxKFASzpO1Y38OFsQgwIVGesZtMKpe0gQqQgDap21eP?=
 =?us-ascii?Q?CZP2Z4dpmOPGZL7NIu13HnygHBd4b7a+o3P1B/yW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df608e25-9c49-45a1-8d20-08da62c0f1d5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 22:10:05.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ek246sBb6dFJzKZQcKcYmr/+5w23vGKV6jtKXlvfS3eLLULI+8Gfo9QuANuUHa5xXnJXBc6rCYhF/4vJc/mXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-10_18:2022-07-08,2022-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207100102
X-Proofpoint-GUID: -2w1wpQCYnHeZniZeZKsXxCSis1u3mD-
X-Proofpoint-ORIG-GUID: -2w1wpQCYnHeZniZeZKsXxCSis1u3mD-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

add a "ksym" iterator which provides access to a "struct kallsym_iter"
for each symbol.  Intent is to support more flexible symbol parsing
as discussed in [1].

[1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/kallsyms.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fbdf8d3..79a8583 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
+#include <linux/btf_ids.h>
 
 /*
  * These will be re-linked against their real values
@@ -799,6 +800,96 @@ static int s_show(struct seq_file *m, void *p)
 	.show = s_show
 };
 
+#ifdef CONFIG_BPF_SYSCALL
+
+struct bpf_iter__ksym {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct kallsym_iter *, ksym);
+};
+
+static int ksym_prog_seq_show(struct seq_file *m, bool in_stop)
+{
+	struct bpf_iter__ksym ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	meta.seq = m;
+	prog = bpf_iter_get_info(&meta, in_stop);
+	if (!prog)
+		return 0;
+
+	ctx.meta = &meta;
+	ctx.ksym = m ? m->private : NULL;
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static int bpf_iter_ksym_seq_show(struct seq_file *m, void *p)
+{
+	return ksym_prog_seq_show(m, false);
+}
+
+static void bpf_iter_ksym_seq_stop(struct seq_file *m, void *p)
+{
+	if (!p)
+		(void) ksym_prog_seq_show(m, true);
+	else
+		s_stop(m, p);
+}
+
+static const struct seq_operations bpf_iter_ksym_ops = {
+	.start = s_start,
+	.next = s_next,
+	.stop = bpf_iter_ksym_seq_stop,
+	.show = bpf_iter_ksym_seq_show,
+};
+
+static int bpf_iter_ksym_init(void *priv_data, struct bpf_iter_aux_info *aux)
+{
+	struct kallsym_iter *iter = priv_data;
+
+	reset_iter(iter, 0);
+
+	/* cache here as in kallsyms_open() case; use current process
+	 * credentials to tell BPF iterators if values should be shown.
+	 */
+	iter->show_value = kallsyms_show_value(current_cred());
+
+	return 0;
+}
+
+DEFINE_BPF_ITER_FUNC(ksym, struct bpf_iter_meta *meta, struct kallsym_iter *ksym)
+
+static const struct bpf_iter_seq_info ksym_iter_seq_info = {
+	.seq_ops		= &bpf_iter_ksym_ops,
+	.init_seq_private	= bpf_iter_ksym_init,
+	.fini_seq_private	= NULL,
+	.seq_priv_size		= sizeof(struct kallsym_iter),
+};
+
+static struct bpf_iter_reg ksym_iter_reg_info = {
+	.target                 = "ksym",
+	.feature		= BPF_ITER_RESCHED,
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__ksym, ksym),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info		= &ksym_iter_seq_info,
+};
+
+BTF_ID_LIST(btf_ksym_iter_id)
+BTF_ID(struct, kallsym_iter)
+
+static int __init bpf_ksym_iter_register(void)
+{
+	ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
+	return bpf_iter_reg_target(&ksym_iter_reg_info);
+}
+
+late_initcall(bpf_ksym_iter_register);
+
+#endif /* CONFIG_BPF_SYSCALL */
+
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
-- 
1.8.3.1

