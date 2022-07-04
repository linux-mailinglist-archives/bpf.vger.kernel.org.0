Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2435657F0
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiGDN4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiGDNz5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 09:55:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD3BDF1C;
        Mon,  4 Jul 2022 06:55:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264D2QMG004721;
        Mon, 4 Jul 2022 13:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=AO7OMtcTBdq2gtPFmgxqa06O7ZYfBQO4Z7rrXq4TK4g=;
 b=OwhWAnXzbV+VkPeRI1+j8XRBZEFS2SUv7dQwLNwrWtQ5qOLu/WVYV2mu5TejwgniKplp
 G7OgMW05tKbjS3bc90HkJUtB15cAf8/V0esb7hTFPfErE9+AuRKuJib9HyvDwkC6ZaFX
 OcRT+Ixtu8wLm1IjEbFjEN576aueSe5RzAGwQVz1f/hleU6ch4wHAyenjNQGkK0ibiKP
 IrsxvBVRIF0AIszIl0fZ9O7xNUBMN43kqclP0Lc4qQJL/sf1f2lljBEH7FMRU2cP5Fqr
 saaiMvfB0WbCb/0q9wuCcJSrrptBsROtQE68V0PSbe7Z/O+PjmX/T7CR/nAHBOv3pLgH xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2dmsuhau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:55:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264DpLW2021264;
        Mon, 4 Jul 2022 13:55:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7s00q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiYAqXcuw2MUaRWm8T/OOTlmVp8xOFvfmZku0C3nduaukvPfWBTRkr7nXiLLt2AYQCt1v3X77Gd+qufy3wKHf2R7K2MeUDEbnC/e/FXH5yuY++VckG2GZ2Ej8Otp4cKjck35qQSSxUe6vlS7JgBhfqrtasRnzHRtO9sU1S0mx6Iz5YwuE5B4TnLHH96Wb6z4Ez4SLNyxA6g3gcD5oOfDkpfwnQ5lFy3utLa1IfxqnUgLZ+A0GidLqpFViX0mKaFjRktVIGYj7Os2LA+z9CuZHymbuyK+dPhwmSvuXKmwkogWJpw6HCZzxZpmvDAU87ARWNeCDyCwQfIWhzSKqwKmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO7OMtcTBdq2gtPFmgxqa06O7ZYfBQO4Z7rrXq4TK4g=;
 b=WoN4CQy3g1fBm2b9brkKOPmZoagv6zQyRQkq1QnUa3yZkUAkq7ZZDyyQ7prhRpPNWSGz4Auo9aVzmvORRVJEnIm8Dbk4MImY6z79os6OShEZp/YN20Kgly+52fzTG4h6qANd2EYburXKK/KXgwRDoY+4cgfBuOVRMYAs1sVvRaEE+xJxnJLhWGK28UpkeqcK6hrkPwqa+PJybGtBE4aUR8eUJyPlx7Ybd0V78pgY0tckuKTxNZE9RDiqp8dQgyw8AteoC2+r0PgNAy85ifpKZL5JbXsgG89+MLWgMkyWlJsF5d31d1GbWY7j16He4dOkbchvaxCo61gdN3rr+KwmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO7OMtcTBdq2gtPFmgxqa06O7ZYfBQO4Z7rrXq4TK4g=;
 b=Sj9njxR7yRZ9U8Q1XSQ5L3IAILgM4AJUX1UzZIQ8TVRI4INaZqDeGHdRhqlifWQVFolA1R7xJbOZ6lRTMGIpv8s4puHxoj0BkvriVtBwYIR+vfwD/Y8qVxG5jUwlz9LthFI2NdnoMIPqzHjA7NUDfoVKSfF2FGLzcWNNg72sfAY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6086.namprd10.prod.outlook.com (2603:10b6:8:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 13:55:26 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e%7]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:55:26 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com
Cc:     kafai@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, void@manifault.com, swboyd@chromium.org,
        ndesaulniers@google.com, 9erthalion6@gmail.com, kennyyu@fb.com,
        geliang.tang@suse.com, kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next 1/2] bpf: add a ksym BPF iterator
Date:   Mon,  4 Jul 2022 14:55:15 +0100
Message-Id: <1656942916-13491-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656942916-13491-1-git-send-email-alan.maguire@oracle.com>
References: <1656942916-13491-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c5f5a12-00ed-47c0-c0e8-08da5dc4d8e1
X-MS-TrafficTypeDiagnostic: DM4PR10MB6086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/CCQo16w+/51ZWurrr7lHmzF1pYmRSj5haRSkRnN+K1Mk9+vn7BsQhuGA490EtWKLGSm/md5jrrwifR2x4CPzD1q619RslB8giHu5p3oSL1iyxbpG8veCDaqaOx84+Qy1CGrrx5D98/pYql0dLJhqPxdAQ/w/dX14TXAcDIrEqwJEufREeINSgM7NU7w89/EXFi4nrqtoym2sB/pRu/JqOkP6WXA1JvOQb1UIe+ZgG/2OiDUxUhoL+W9Sfdesd/fwGwcFJGiQ8hv/4BP+Uh3139zKhESbAUDBgpHef50LHqRUbXnuNr+SV8Bvd+TSmQphoN57JLisDOpooYgF3MXHsaN1s/4I1mirPb8b9KW5Z5QYkz3tg6KlAxQ8NSsj3ondltu2OqeiCGqZUkk3lF0Oylz2K2o3ni/Ifbr6KTzxlJSJLC7jmJvqW3NVRh7qPqUdun0LILcYICSk7+dTP8bRsGfF3nfbSDjolJwHzyRMLrQUNeRDY5A6xeglDh4XdwxPLcyx3/tLs1BIUSt/Z7rjVr95DWJZ/20vFzt3PHCzLbO6C80iE0FvmUQMc2XRuQFU3yac3yBJvqxQ/hoY+aE3Dm/BxjMiVBFkxRo+8A2FQHxpBNy2+X4dd9PmHksoB2kgXNAvgzGLYPTLU9iZl8eXZ/rMZmhpqfAQG6kikH0NmnCYefdw1zB6XfBEf6UTudKWKLqgxIb4/R/HgOLhGCcPCbASFwCy0CcWanpYr02JOARS69y6W5IjxFV1k4r7tsjwLa3BPTRUJ7MgxPsz7s3dlb8spsusdqwL/8kMPi9uk1uFcFxyiclK/P4/mWwbuFJFVYi84Qa81UQfPOMHRMhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(136003)(366004)(4326008)(6506007)(8676002)(316002)(66476007)(66946007)(66556008)(966005)(6666004)(478600001)(41300700001)(6486002)(8936002)(7416002)(44832011)(2906002)(5660300002)(38350700002)(36756003)(86362001)(2616005)(6512007)(186003)(38100700002)(83380400001)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OJhnJnQQtl0yvYrtfJ3HkZ+ljbaq7eKxBTUxY5L3m5yl9gzyHBoZhiLji3ag?=
 =?us-ascii?Q?b3sjllXEKB+PtpVlWBsfAuuAzhYf/ZcOps4eWt3qtPO4L4PslrQDPgFduVN3?=
 =?us-ascii?Q?PMss9Rw5z4AE1G/Oc6k04a0ow19HdpziPLRaAappmDXCq2d5xrCjwFA70vsz?=
 =?us-ascii?Q?FhS5VcDRh/GHSY7tEAyTb0MWi3NWqIxpzN0ONs+xxv2hwGJODejLhiGIIujP?=
 =?us-ascii?Q?ZMlqMOGU4XAKPnsdiiMM3gYFGgL8HdY/rnrnUmKHaKQ3TqyopawWjc/P1KEl?=
 =?us-ascii?Q?6otYL3cz7E7I1Hd5jxxZaJ/pTv6kOQvJdHnm2ZrtQHHvvqqiHfaEqS5e2KKz?=
 =?us-ascii?Q?EPnSEV4X2SjxQD+WfXgCVF41dSdUFdNtkLO2N3o59ZN0ZZ4NbqdqNjF/n5vB?=
 =?us-ascii?Q?zNA3Mu4IBSrC/oOqrfLcoZCMymOgkcdtVgvHb0KsCSczbeRLGP9adJx5+K7L?=
 =?us-ascii?Q?gmwRp1W1WsOdypm1zTYwG3gFee7RqMAu+JoGAygu5NUpV0D16/yNK/WjSmg0?=
 =?us-ascii?Q?RI9SouxnKfJeTvIgBAcs+H8meT/SyvFvhsUiII5OJv2KRZUkDXOjVwaTPL4W?=
 =?us-ascii?Q?muej/X5S38ZEg+XNFx+HRZpTiAr4/roJlic7G0ATYyHiqsklIoBM+9pJEekT?=
 =?us-ascii?Q?UzRBDcKcaiSY3wpY11kfmmAvxHNC4AaQ300wLvMtC+woUFRiOGoF/Zmcq5As?=
 =?us-ascii?Q?9Hp3arb204UZ2FzrYbCWooWA5v5gQT1hfi2sjqdIzCjW82jMLXkzCyY9xNT9?=
 =?us-ascii?Q?6EyhAgnJ0mP5r/C8e7H+uiWJL+Lk8xNEZI+pxYM2R711OxajVbkjdUxHtQmP?=
 =?us-ascii?Q?3k86bHlHm+a+0qQ9d5klslTxm1r8ufbrBah+RNW7q5VaYKqkzyj9w0e7hHAi?=
 =?us-ascii?Q?TqMiDVIBH+Yic4gVe7Jww8bfraNees4b7iFF/f0JnSkQ8m/+ZM+sSipca6qs?=
 =?us-ascii?Q?BD2rXlabSQ5A4V8EETqMvX1E6RK+MKdCtbjKtcRPgeIraD3VVe+xlHEypI+3?=
 =?us-ascii?Q?03v2OtYVSblliVhzBMmm7rd3fgVbuvJTS0Socqz6bfc1x145QslDLXSO+3B6?=
 =?us-ascii?Q?vNYktFmC74cBhANc4yI9zebPQbXf5gzlGGitWgsRykxsUQ3+TTC6LpyKmwFa?=
 =?us-ascii?Q?ovSlLYSTekogx1mM5rU0h+HuIW07DqedELZpE/6HrI1jbcf2O4ymazOLNXCF?=
 =?us-ascii?Q?cPj4GaYz5y6bAPVmeN7H2XkEJVC9KE66llak3Y2AP0eGMrFup4pZgm7Jlxaa?=
 =?us-ascii?Q?eO1mjh00TU8aRtq9FPnvSR1sK/BlgcxJCjpVZgMDhYFwXlTGqQvV09zbgQDg?=
 =?us-ascii?Q?LZxYAn5jS6mIpBlZZHL3PDCMN1nxoTl6R33+yrtUncjCME1931oH5eKblZ2Y?=
 =?us-ascii?Q?gSYYOC4xe1xaw+ikqBaCcSh8BGfo7QR+qGubfPOruODl/9n8RQISn4fJ1coW?=
 =?us-ascii?Q?8/J1NvdGaUB1eIqU3ymeXrbmiFBeKSLDHb1RNksXISX0yk89nf3x/7Gfx7s4?=
 =?us-ascii?Q?XV+YnJEY5BYj+6jjUtNhnGEBDsiLyDnWNQzKF2Z/H+T7SSzUeXirUExxZQRf?=
 =?us-ascii?Q?IBBNnDXl+SC/NhgyphxJXOQoqK60iy0XNg7wuN01?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5f5a12-00ed-47c0-c0e8-08da5dc4d8e1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:55:26.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pFfqug3QIOFEd+erjOptw+CJ+0ZIbZwUTMfuL4jXVzHDywY2yV8yJNJ7udnU2Tv9KYATTOFmv0ccDaFf0Kv8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6086
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_13:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040060
X-Proofpoint-GUID: tTSTQ3DPxlJYr9wvop5g54hR_0kWMUsj
X-Proofpoint-ORIG-GUID: tTSTQ3DPxlJYr9wvop5g54hR_0kWMUsj
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
---
 kernel/kallsyms.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fbdf8d3..9bd37be 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
+#include <linux/btf_ids.h>
 
 /*
  * These will be re-linked against their real values
@@ -799,6 +800,87 @@ static int s_show(struct seq_file *m, void *p)
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
+#endif /* CONFIG_BPF_SYSCALL */
+
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -885,6 +967,18 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#if defined(CONFIG_BPF_SYSCALL)
+	{
+		int ret;
+
+		ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
+		ret = bpf_iter_reg_target(&ksym_iter_reg_info);
+		if (ret) {
+			pr_warn("Warning: could not register bpf ksym iterator: %d\n", ret);
+			return ret;
+		}
+	}
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
-- 
1.8.3.1

