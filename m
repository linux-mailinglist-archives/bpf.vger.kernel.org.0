Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42CD563007
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiGAJ2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiGAJ1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:27:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400077358E;
        Fri,  1 Jul 2022 02:27:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2619HQCL003301;
        Fri, 1 Jul 2022 09:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mH53FWIfEeagADgFv6JEcWm8ugGwduvQIs3N9QEP92U=;
 b=Cesk554fo2/ByzzyPLHdg0HrX9iqRGOe5tkHoRetxSOxO+JQJVw1uc9+5LP6TnGKlVJG
 57TOP/ryDX6bBi2rYv3Pj8KRqI7Rb3OIIElDFQpaj/C0hgItD1aheY7KqLARlnuEL0lp
 +ECi5rPaMN+Dc1zC20CmPb7a1hLZFTEPp03PjTa4oaBgvkmFj8l6dv/PtRv+Cwi2Mo1Z
 MnIhlLp+LDH6bv/2QmFdk3vtVU1VBvoBkrF3vWQZfpZ5sRaQSeuLCLPboiPwugaXGDki
 Lch3b39wnLJ5bUW5D71nSYKokEdOC9+OW7IgYXN+EO5SBrcLiVA68WpXpeJurSTueTO/ IQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscpd65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 09:27:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2619LNiU005235;
        Fri, 1 Jul 2022 09:27:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrtajc1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 09:27:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQdc6P4b3NrRJ/wC5J+ZsBpg1vuqf1u/bgIYcOudIZ/8atLhzfDew6RcdSCckE1kgsQ00Hdknw6opnEfS6S2TQ3kDTSSell6KV30aERimu8c3gy7dB83x5n2uWwpU+yszRHxPnJiM12NHvdg3j4jB5XkT70agQS2FKXTlUUcZJGoVbI7JCvrXdl1838dEuzacagWHHesyeKQBYV+fq0ZthtDd0cgrjQJ5wWdZkUpw86hDtbKZSuU8b0kdYSrjnh8ISHmhjgf5EA0rxWeVRD03irlheN9NlaoPbFZIeKobsgqv/uEa2Ks81dW6nj3wotciwLWnNX1TVGErhYxFbWf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH53FWIfEeagADgFv6JEcWm8ugGwduvQIs3N9QEP92U=;
 b=hpjX+R19Q6fhcDx1EQGWn7J8KtvTbsP5b7DAXX+3bM1wRadKLZmaMyoRD5hIBXYNsIvUoYPv1Tzp3Mx3d1ghNwY1XM6N8/8/XlJxNvlIj9r9rIgYn4c/jn2lDGhhe/qmMSLqqD7HG/xBsW6WL3nhfMzX5SGQ38pVQDyrUeXQJpyZBDZmd5SipILq4DuZDhIFw00lyHqO1Q39oekF8FA/ywRFrKlmFSUjgp+n+s4QqOvfRQ4IJAKO0mUNa5BSkpHNgdBDlORET/Jy3ttTuX+3WUvUGcGzk9KTzoOC0j7Zw5OAVfoXMC808US+X00YR2PUGz8tXxxg542r3pnK4WKYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH53FWIfEeagADgFv6JEcWm8ugGwduvQIs3N9QEP92U=;
 b=FlebPZ+PLxz/c1n15o5JJ7bOLzLg3GnXLQWK04AI/zj7GFYU4GxXT8BEWKaozwePqUo5uBiRqlw468qS62C8kB6lDVSjvO3sCg6GnlMuoeKloZMsylbYrFiCbO8gWLbpea1hCC9Bdrbw8yVQPaQECGsd/sxexbQVC0t0/bwKTR4=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 MN2PR10MB3951.namprd10.prod.outlook.com (2603:10b6:208:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 09:27:09 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::289e:c33:4eff:517c]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::289e:c33:4eff:517c%4]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 09:27:09 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 1/2] bpf: add a ksym BPF iterator
Date:   Fri,  1 Jul 2022 10:26:59 +0100
Message-Id: <1656667620-18718-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656667620-18718-1-git-send-email-alan.maguire@oracle.com>
References: <1656667620-18718-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a94bcd5-b443-4048-ba8a-08da5b43df2e
X-MS-TrafficTypeDiagnostic: MN2PR10MB3951:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILVW/2yy+Z5prPSLf/y3md1yWYr3q+xYyC2TSei39bOMyY4GFB3XLprGl4+AwleIDF6AHRF5hV8RqwWT2quodmLDzsMOgzPbSe4AAWhgEqJ87bqVMfxpDxt+edFzR3+ydyB7Av8u72PWrkMNawW1GcgugxMjmfLvfIoPL0YKdJlS1rKYdAcDVMaohWBzgddYUjZMb9EYW7iJ0IzaID433HWheXLFXlB9Vegr/bCMUZ7g1AEewm7KdM7A4jXwaruVmbJ0Isg2GCsaheuOCjRrq2RITfCDcgkNxGRWIlQr/g4vp+6J4UrZKOzJzgGXxY7dKpvWpz/Y2Cikmyia+mIDjCGy5kPRvprBVPZxriY6uWGiXhyLcC6XVDHvh7NR5dH5k4E0wIB8f02eF0HkBNJ3T4MI99GHhBnPkdJh7F6PN5y124ViNiwLO0yL1+QeldPPtd+1uJrlrpUN4cD/xTYE+hHA50CqTfrLXf6vlwAYTaejEpdlLIE3tiuxcSehOPA+dgYjI4lzpb+1LR+yQtyrvB5t7n7CBCahfIv3gaIhsKxI4chSKtDgdgh2ddbKjOfEoR8Cqqp4X5lT4sAqKjignTdlNcowP65rfklbXN1bLbhreMGyd3nxeDBTqVc1zQAS8oRLrabrHRybCZ7Off/KveWoB6pSPe5QwFFGtnBwzKgSBYe4ArWfjzGDYFTzQ0GzDiple50sDPPyvId0QRoKXPTTAlRZIhXkybHvmolAFGmlUj0v/dttkDV2/XASU87zosW6gnrpK8wzNawfZD+WnPAonWwj3UFV7ZCUjiT/ebxN8gYusfbRuJctCEZAvDzzERd3uW7wQOO9+cYT25wqvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(396003)(39860400002)(5660300002)(2906002)(86362001)(316002)(66556008)(66476007)(66946007)(6666004)(8936002)(8676002)(26005)(4326008)(38100700002)(38350700002)(41300700001)(6486002)(186003)(6512007)(2616005)(36756003)(478600001)(966005)(83380400001)(7416002)(44832011)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z7m0/4mnyly9Rn1ZMX+Jom9u/N51195Xom/qKUyjan+a3chUXlbDy4gT141v?=
 =?us-ascii?Q?hJqE0ZjTZDhACY8URyk/DoPkx5HLUMklhq2tNcJTKBOGyP1OXCy+xYpTn5Lx?=
 =?us-ascii?Q?WN/Z2aI0p8xw1J2Tmlx49tPrVpSGD6UldihpLRzx1eS2Y+9KJT2dmDE2xxsc?=
 =?us-ascii?Q?6hq9fEjpw5ePA3L68LA/ZNghDMbC6SktU4pDBQDMsVqZsY5Vx7mxMkINye1w?=
 =?us-ascii?Q?DKkviP0dJugQNTAAwZNyz/GoUs+Bl7iyc250Ut6vkw23gWnG3QfPrOudilRc?=
 =?us-ascii?Q?2wipEL46VQygymivBRduiG/5OsKMEvSpWXP0FyOjZ63yJ6OvThNkLhVO+rV3?=
 =?us-ascii?Q?NeOMi6AdyUukNL4uHmLGazfLjpi4xB5YzESXqNVNF3t0UzM5KCAgG401evTI?=
 =?us-ascii?Q?2K/QIrx5lQtQqJ6OJ7pqtU/cCcsbngVclyEnjouGPdPPH3oWSk//lHhPBRKG?=
 =?us-ascii?Q?gCdvgSwV5EOyxm66U/MQUec7dgDQXg+VIR0RwnqVg9d02/x+Yob3QUuZIn44?=
 =?us-ascii?Q?a255kn4LgGIErTPamFy4dhSAJCFubnRm7SQmV0mzxsoWguyAjsCRXE7/2xZC?=
 =?us-ascii?Q?G45KwvqjEzKc8O1+tzdvku4L8XllbVifjnwiuDr/4YBoLZxYSgaIam+kXTNI?=
 =?us-ascii?Q?W839T7HVY3QKC9YtEvwColY8EuTwcyc5Lm6STl4ob4cCjIsto8j2hde8aVVq?=
 =?us-ascii?Q?yBnh6MrMPGBrmytVOtGMVV+tRiFOjccDF7H2vMS57kW3O7VyXe6wBorDoe08?=
 =?us-ascii?Q?lRxxq/pEG45mASpvvhCqdjzxODohlyrk0TWA3AnCP2TriQWbbbVIixe9Id+R?=
 =?us-ascii?Q?JKGSHYh5n32a0jgw7S7CcNN+yzQStH/4EPBWg9Ca9y4DqVHqAN/LIqVuVfyD?=
 =?us-ascii?Q?J419g1xa7Ethh1jO/38XqPiWwv3MGZJQDcjkR10SymDHEffiJL9neZfEFQGv?=
 =?us-ascii?Q?NPxpZR6VMZziKHxjOfqdEsmhIAhT6HXw9C9wzteS/5ogWjVnGAVJ3r9+N4n0?=
 =?us-ascii?Q?b9nJha/IZd4FoyL0cE8ZGfdrCPH9QCCTdHBFELAKmrosQmK4NHUJO8ECsRWn?=
 =?us-ascii?Q?BnCEjH3TfGfIz33zeXyj7whzTsMe7+abHDo9JJ96DbCODlg+Prr283sL/NY8?=
 =?us-ascii?Q?leoDJgrEBlgeUqj3GDYhzXukgixy9/Ma+/le1zdtybdd8iD418VvJoxRoHxA?=
 =?us-ascii?Q?dTW25aFkn6qb5lltPXe9s6vNjvx6bKrzcHibMKLZfMi2w/zkLLwNtWFRJ2/d?=
 =?us-ascii?Q?KkHio2JYDNd1whhImskha/TypXubxOXstY7v1+mYo0SPXQJCeEq6Jr2JU9UC?=
 =?us-ascii?Q?TYsPpHnIUSH96DjrLt/U/gaY5HIIfM5XbC8iPC5/Gg7sXtGB2q3q5uRHrR1D?=
 =?us-ascii?Q?TaCN1FD33bQFMAEqjQcGgynpF57jsb5Dvc/reKkORNhXEWDwr/fDCwkPNAXW?=
 =?us-ascii?Q?zmAkYoal5Es4L0K3Z5f4639L57BDf5NPjnP2fVkrDYnUwM/XrGN6gdnW9oGb?=
 =?us-ascii?Q?hWQlP8v7uLeTT9qgghUzJXUM2h//03vwvH3VhpPn/k/FHPbsm4j2CZ9ygIGV?=
 =?us-ascii?Q?h9fMm6mkoZHHecI38JNrPSW2bMyX9EYk4c66kYov?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a94bcd5-b443-4048-ba8a-08da5b43df2e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 09:27:09.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8btsGwi8tWvSLnL7enG2bmYAUeLWeGley+SRewVa/6pObT9iyugbwEMAb6AxA8vXCWLf/JnHJew13pdPH4A7rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_05:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010034
X-Proofpoint-ORIG-GUID: c-yZfvrHerzb_-slzNcH_svt4X4ph4p_
X-Proofpoint-GUID: c-yZfvrHerzb_-slzNcH_svt4X4ph4p_
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
 kernel/kallsyms.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fbdf8d3..8b662da 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
+#include <linux/btf_ids.h>
 
 /*
  * These will be re-linked against their real values
@@ -799,6 +800,91 @@ static int s_show(struct seq_file *m, void *p)
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
+	iter->show_value = true;
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
+static void __init bpf_ksym_iter_register(void)
+{
+	ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
+	if (bpf_iter_reg_target(&ksym_iter_reg_info))
+		pr_warn("Warning: could not register bpf ksym iterator\n");
+}
+
+#endif /* CONFIG_BPF_SYSCALL */
+
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -885,6 +971,9 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#if defined(CONFIG_BPF_SYSCALL)
+	bpf_ksym_iter_register();
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
-- 
1.8.3.1

