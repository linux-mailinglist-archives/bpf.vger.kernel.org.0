Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F7571A05
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiGLMc3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiGLMc2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 08:32:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F73132D8B;
        Tue, 12 Jul 2022 05:32:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCDdL2007831;
        Tue, 12 Jul 2022 12:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=iZMK9bktdwDJd00q6Om8llTMLBx5AoG2S8LRR0BTstI=;
 b=N/w10pL5CB1mEiCXb8FGUSxlRCUexnVXjfVIrmlE4seAm2sP+gxdSSK3v2+PrjrcvJT2
 0ShY6RfcIyHkvnxnuguIYujnu1JxboWNNldfO1NCxJFwGTfCzivcysWQh1/gcHnl2j7f
 uIVUE+iZuw8htcPZ9kWck9AaVj4A2dAcNaQCDIyrXEpJ8LhMa8YtYF3cDnThCy0sIIXV
 xB5JixOF+AgiepgoeZntimvV98+TYd9dAYVzPmA9kSX3dK2je0UwSS3qNFfYDlWpyDxS
 j/lOdNbXLJ86C/NRHg9dY1xiZfSpj9KdPZTYaoa1+CMWgDA+KJ2DdE0090Fry/yyVPm+ Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc6n2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:32:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CCLb5H039161;
        Tue, 12 Jul 2022 12:32:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043buk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:31:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT4w1jS85X3g84sdDjDIFfWaV0y2gCEizR5bIeBQcD/3KJtFcBQSsg4AbJPzNDZZS96cuG7+37NurS7YYwvWEdvYun6Esm7JnG6S44ZMVHasX31rMmma2+hggB1cDMAPh7dwJMQPy5Pv8VMKYuHhFeAHOooX2cOxlqtyHeZ5hiVxazMs59pJQF9EGpu7jrQcaul79IlKACTLyjoaeyeEmzHWzFsa8f/khbJgPOZWUA42llD3DA/ixsGkiayYF4CtNL/3PwxU3EOJEbT6u1vLMv8l7yi5x6aPBIUMeq/xuiTT0S+Jqxt/xsDEy7u8tozNjR+PdXfCrjO9GaKS+EtK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZMK9bktdwDJd00q6Om8llTMLBx5AoG2S8LRR0BTstI=;
 b=ZCI97w7T+Q92Ltarm0Vyt+cWvZ1aIKusYLVXl9/FdrkbC3bsMVMSrfwcSxu0RtUYUjDl5xlRzKuT2HEMkxY4esEjaO2OnwEqJsVwjQLOmtpHnQoC2u1uUn1/Ih/HqtwZpbS4XLoWeg2rVkPAj84q0ylphOwPW8Fok4xpwkLw8TiV1gbckv/cn+jabd8TlP2C7xuu48KFv2wC2MRLBnUuHetfP4WetQ1dT08mi+boMnHdEkTXX99hO5lIbphS0Kv9bTY9eaCXCtJgUHzrbeFac16tjObo3xLXOFPEigXXtofk5MQeJT/ZlGeWpTzK+/icUs3OeMXjLGrQF/3jhpQXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZMK9bktdwDJd00q6Om8llTMLBx5AoG2S8LRR0BTstI=;
 b=RgtvQB9T8TT4eEslwgTOv/j1IVsJE1Mi0+1jpnSHZgj4NM0KVBNc7sJWgBqieuyHMludCUbNfYD1TleyzAT4yOM8Y5ceBxAENcULtlzp9k0tB5rCeFC07G3XEk5yeT5CsysuKXz50u3YxHs/NedhkGsPNIvLJWfytfnqjvUCtjQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 12:31:57 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 12:31:57 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 bpf-next 1/2] bpf: add a ksym BPF iterator
Date:   Tue, 12 Jul 2022 13:31:44 +0100
Message-Id: <1657629105-7812-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657629105-7812-1-git-send-email-alan.maguire@oracle.com>
References: <1657629105-7812-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0902CA0006.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5b80d83-d31f-473c-ab2a-08da640282bb
X-MS-TrafficTypeDiagnostic: SA2PR10MB4426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCnHSX4rHsWroV2oOKh2kgqpCjis7TeJRul+3K3UhVccwJLRGS8oCnm6tjP7ajdLCbBdPc9h8r7PcTItyaP4avznwW3+/sh1MkrrMCFpleoTsiUwUYUDe8vvJluSkyZN+AWPxkoE/JFdBjytJ36lcQGP8NUEz6XkFAD7sNPBSul4qK0LGZt8UQ8ptFl57jdBIk7B3EBui+H40lvMfUC8IrsZmHSMDkEYlx0WOUWC1Me1/EPEwVbjakWc+AwuUkdASQNNTDhxYxMCGaFptHcSAEjPS0DPQ0SRcurzIgoelEhmWnXAIkYANjk2O0aPfJ3eWGEEuzv7y9MzmpOgHIWDwCQNO+Ycjh6s2uEmm1ldFHt2GgleCvg1PRXp8siWNXhwYpxpQx0QSlXuCEgy+VXZAnjSquPyNRQA/kXpVNi2sriHVasWyICROecV6LJfCZ+uluvBX6WenApEEKq/XxngOE47pFh+2nUt9tBcCgvTEKKBbDEDFgD1xlpiHJn5nRvc/diyyPMcyZ2pojQNsFcNspYq31Gih9093JNzVZxX4Z+lf97EBerb2eJwA6ZJpqFUt11eQWi2EL5c1Y3ScJwfuam9WlcupPXBtdfUw3Rfhyf/NAheHJiMzU02MvEBY5GD2iLNSm596c+Nh25WwTRzDyXajUQjpSdru7IibktzBbJ04EJy0cFC/XvQgD7ByDIf3eVpU3ULDphV/RFL0kgfsO8Z6QNjl5HDzGqNKEonFIYZk9iF7Y4zfjF9lfZeO907mmTUi78nPrIQgB0MzpOCgrYjQjWrHhKS59clqPVs6Z7PvIjtwSVghsWzMhhC1YSyEm94xtYlM1tmcAukM8kyxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(6512007)(26005)(6506007)(52116002)(186003)(2616005)(41300700001)(6666004)(8676002)(478600001)(4326008)(83380400001)(38100700002)(66556008)(66476007)(38350700002)(2906002)(966005)(8936002)(36756003)(7416002)(5660300002)(44832011)(86362001)(316002)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMW3+q4WfgiTwby6TqBgIziLEW6bDPmUuni1EMLkeBUuJoOYC/AMoBvFKmUd?=
 =?us-ascii?Q?5sTBuD+jM3yTPy+czxJL0UpFzARZWhfvhI5NLOntD1g/aC5D/Pv7LXay3JaO?=
 =?us-ascii?Q?g/46IYEl984YwUUy6NO5pzmsJwg6CHgKprKB8Et6JMyZR1UFDybuEwV07vbX?=
 =?us-ascii?Q?4MueXgiRmDKJnNv26W4jOAWBQ8v6pG1pr5UmvEVRinJSAfqACsJ/p8z7trzT?=
 =?us-ascii?Q?PDbMtr3SC9ELoSQlSMNwtJ8KqsQUq7deKX/Gt2pMCCHTimmrkHRl5bU2wg29?=
 =?us-ascii?Q?97TM5wuA5LJ8xkIQ6zGlg9i3Ru3/BPWRKuuhRlxtIZwPGBGNZkmRXOG0R6gF?=
 =?us-ascii?Q?dhzBXf8wGBtl4sVjrcGJlP+evTOEAl8jGR/a+M0OFWybO2h7Qvf/ih00gKtu?=
 =?us-ascii?Q?G8krXbuNYwlfke/os3KCsNoJFYUGG4eR9cKLOZ9Wk2AuoBeQrpp/l0cNzvC1?=
 =?us-ascii?Q?VA7fezkMNBh0KrDHmgTyOWwWwAQb7v4OPBiBwm3+nO9dVd7lFPzi3q1RukUK?=
 =?us-ascii?Q?TrJuxfyutHDux+M+zcQQlNk4if2mfcmLvb7g47lXuO3IKMTkwSAs0umIQY/3?=
 =?us-ascii?Q?m1twVYxcnK4ulr5SHyDaF3Z2ot9GLFIPWNSp/hGsT0ZCLPjoqzcuSNLrd9QF?=
 =?us-ascii?Q?wGxQG/QKdsg+WvFZUm0XCQelDXcjfm7OyPUgfI4EQ0sTx5eQjhkm+lEd6uFw?=
 =?us-ascii?Q?Gh22m6ZuHE3+/3TKpM5fw3Kn+ZzNz0z99oWoE+RWWYa3QK6XlyLv3dmKtYkl?=
 =?us-ascii?Q?59PxHJYdOw4dW2KFB0savE1cabWGyQumA/9DwgWx0GWjc+CYCMZw4uz/oLBe?=
 =?us-ascii?Q?BLMHPQ7FRLsY6Q8dketTBh1ShvZ2Qx8bBvPs7VoBMmFxKVoC8pZD4XCteATP?=
 =?us-ascii?Q?th8+D6ngmHdGEEjyN1plBDU4bi3lsVJSFdhviQvijvgxJTyiywoJUx8CNu/i?=
 =?us-ascii?Q?kyWuKTRoK+5hrenRUIeVKtsU8KLw8CmURERBnD/bP6kPzYQqy1YuxuFQ/13m?=
 =?us-ascii?Q?1Aw4e2pYuty2TSlRC+iVg5k83E3acq5TXfyFA2bmdCxpM6k1zQkO3lhpD2Fw?=
 =?us-ascii?Q?lO4xV4RdQgslhAzabEtyJHLxxPk+zO3GhxaWCiqOOrx9mhpHPr4PiP8mzhJD?=
 =?us-ascii?Q?RgOMEaJhERayh17+eyAy5bYxJgKXlaj79pe3lYUbhzYHg5MDf/4GnPv6vyv8?=
 =?us-ascii?Q?K4MDHoHrr+AreEOcBADVOpquPsUvUe0HYLLCQoiZD6ZDEY/50v6xuoO4PWRL?=
 =?us-ascii?Q?ovnyOcuuO6Q7YAtDmOuKXzQzTbpWfrKNTHVfJU3DMcwWK7R7hXTm/V7cfVd3?=
 =?us-ascii?Q?+8eRHVWc/CcG0sb4A5u4i5NZ3YNvxB8rIrVya9Of3wZX2ZdhYo/Aq9jCMqgO?=
 =?us-ascii?Q?fEd0jrLk0tQGlWFU57vTDUlnJS5woucpRujch5/j8gM1GBDHn5NozuFhsIMH?=
 =?us-ascii?Q?L0biFtdkeZXeGfaz31W1+GUkBiFVe4nMB1sbBRKVbaCVV/NmqB6FibuZcPNe?=
 =?us-ascii?Q?slAfHl62XrIB2IfTO8q53W6ldDw/5Jft5RW4m5tUy3p3+Er+0EETZaBI/ejY?=
 =?us-ascii?Q?nGuVPA0u+Qv+K1H7intkbZQ0se8QO3sec8XpWiyt/evfw5niGfR72FuaGkss?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b80d83-d31f-473c-ab2a-08da640282bb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 12:31:57.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alqysBbTNYdU+C3FfvC4UiJdxk/X4aLy9nh8wpOJXKtAqYDrA/Kvx9npzst/Jn1scdHHRx093a34S33DivfoTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120048
X-Proofpoint-GUID: Y5F0OVlOm8tw2JYRRR_Z5wsjYuP-A89C
X-Proofpoint-ORIG-GUID: Y5F0OVlOm8tw2JYRRR_Z5wsjYuP-A89C
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

