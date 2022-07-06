Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC980568934
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiGFNRT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiGFNRR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 09:17:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7B1193FA;
        Wed,  6 Jul 2022 06:17:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266Cn3Km005422;
        Wed, 6 Jul 2022 13:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jpjPR0SFNnVcMiSptNs4ea7g2HB2jY1qEFhUqkkrYU4=;
 b=WUqS5Trxw5vaO5SzI+UlkKscFFnY3PJJ0uqAGQSpyTEWl4R2L/PbMTUON5GM6ftfwwTo
 D7RRA2Dze5ETEhKGVKNiuZFAW3q6SwwkVLe3D8Xq98phfb0tzniMpHim4uXBRuRjIGkV
 BAq4bylAosBw0AxsRywvSCDebS/UnP6PbF5w7OTZKlBLAxd/qxB27wJlSCxm3SlBCIxS
 yFv5MLsG/8vhmaVV63XVdkcdDNO8coKLW61h9q/lwM3wEwy/aXWx4hYkNhoHnH2UKl/2
 eHsWN5JXVpbyePQ3RcAY2drChyP75gVKI4OEsRxeKl+tXqgYcDi/1gqCKpkPY7RaKFMW XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyswv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 13:16:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266DBF7D010580;
        Wed, 6 Jul 2022 13:16:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud4v17g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 13:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5wIHJs0hIKvrcxbN545GUTgT9eAZSbd5j54cN2axXr1Gjj/Iq0gD3GCSPuCwuMfuepVeaddVJxN+Mv5vlGZJtc4SbWue/DdjmXUt0wttXIfcuqKvVS9x8ICzqVM04/Tb9Nwqx+ahF7PCCHkJjfy2LsfQzR1gK2FUwGKjTiPoI3cmZ2VlF4c/O8q8ZR/3AZ/IpCZ7p3Zz/ENUeOpN0fFjgUcNcgmJidFf+CsPWHkJtB8+FhY6jRX8ugbseyqCq1GKmNJKT/WJr2Y6GZcwkBFogBe9MojMhYq8w1Eyb/S+6rLTf6UdQqfrx61sG6tFHDDA2wjQjlWPKZIA6gAvsQRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpjPR0SFNnVcMiSptNs4ea7g2HB2jY1qEFhUqkkrYU4=;
 b=MR9KsMoN34NN4VmR8qibJVzmz887mJJt6MfTXAHYMPFiLXwGF7Pr2TrYGo53iSeKPkaXQcPCW8j5wn1BuP1woSYRe63Xqn3ugnh+zSC9HTXR/dQGrOx6QzDBDNjWRpY4TI5b321RYN73mCCnSMl71WykwNkz/N0H8uJ1jDWuTlS0XA5VadAiZGqWjtyA8zqLoO8r4biqrsAE3R/6c6t8azNt01+jsL3kXeOss8vfS33BX57f+9NwzXt8lHX0hSxfgQ6T33gs5kV+nrSF/6R8yFGrKnTHawazzjlSvtmnnsxktlhzq9cVlyWTuHDIebknvNvocP3RM/QOwdj8MrF3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpjPR0SFNnVcMiSptNs4ea7g2HB2jY1qEFhUqkkrYU4=;
 b=ZNOrOVSZx7neU9JCbQwrkkhdKgHxd3CdoJW+ST7uvNsdB22VQmI8+W8ZwU9OpHUgVOBUZc34e3uBOnmw40d1SJ+8zxZOHQbLlUiuYFpdrNfZERUZr4vuakMvVIDxXtHgKzXNMagPa/JBmXOroAGYxkITuBjHIDvtBvUQUWoLdrY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN6PR1001MB2163.namprd10.prod.outlook.com (2603:10b6:405:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 13:16:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e%7]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 13:16:40 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 bpf-next 1/2] bpf: add a ksym BPF iterator
Date:   Wed,  6 Jul 2022 14:16:30 +0100
Message-Id: <1657113391-5624-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657113391-5624-1-git-send-email-alan.maguire@oracle.com>
References: <1657113391-5624-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e67d25c5-f93a-4a71-2736-08da5f51c324
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2163:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvhn+CHfFSUWNVjlW/TZX/MXJ7CMxHF3oqQHgnbs+/MIaiQK7/K6fQ4aKKrcTzRBTODjv+PSkLqS/1jx4nXfaFvLLB4gLupipOtOxuoseuRebRp1cZjLMwJoMIByJCtKWyUlGvOUC21qgZ4KNw7ymzBDBXu8WCawNZuwER1WNRLDQjJuHJMYYjrb7ZsRIyNaXtGzxtcHTzw/G/f0dZWRIvocln8E7mGzyDNsQ8rEKjygNCHf7y8OHXHWZLz3/7NQfVrBldhqyQFnd3bM+1bK8CK3tYLZHiSEEN7uP2c5UQ0pOLFTZwLRy2Ik1bUEN+Atl01FK4JJQUVdiKF7E/YdmVV0tRcMOUr5qBg2fRbYMUjt4Qc3tA09uUxqHAwAwayfo29Rf/6mZnLigP7YbczD3kpagR6TOxDTZnyGEWcUL8hff1Mm+WH9oIsEnjtJOFFpKs9iD3Xi+UhCfxj78x0vNktVuGDmmzHgnyG3Hvpq5OECSBs3NfUHbQe65WmOnsR7bh2wsy1FMY3Zr7Uwhl8Sx1/mBjOeepLifpdJERy16zAMhAvs3fqfhe63oF27+M07nwUfIjFxwPrTV/R+HknyOgrKp+Lq238rqbaNUNKY2DC18+MJZOzgpUem2ZgTnTER0/N3qxaRe5TseM2mp9q99eWfrhaE5nTg/5EGFeVC1OlULLA4VCpIFsI5KQkqeAV8ytzimuMtipBQIr/GgXdwPfMmjlBVgbjHD/NkQLuSbKMcRlKKMF8PIyExFopSLC1EJH8hNrgktZHJTK9fw0iy3oKp35vER9jcCqKhJn7cq6z3n9/TL9eVODmvzR/jW3lE+9BJaNySdCIjb35GAbTAtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(366004)(39860400002)(396003)(2906002)(38100700002)(6512007)(26005)(6666004)(2616005)(41300700001)(6506007)(38350700002)(86362001)(186003)(8936002)(83380400001)(52116002)(5660300002)(8676002)(36756003)(44832011)(316002)(4326008)(66946007)(66476007)(7416002)(66556008)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2lwe6DX/Yr6QpfAm/k3IhB/HOFZ/tHf/Wx82ou/KnbTyQeWd3+drUHx16+P?=
 =?us-ascii?Q?e23GaTuM27YEkmP0ceWI9+Z47Pu8kHA41g2E+lMKJjkfz1fdhlKguVKIxbRM?=
 =?us-ascii?Q?f1b6RFdIVFETpIDoakr9DzzGS4o9V4PCcOBNuFUyzQvs+6a6r2e03HzrqvQ0?=
 =?us-ascii?Q?LpqbC8I2ziIpUkGYZWVV+SrhYm2rThHtdZBRIfLBd6mA1t92ByPvwKE+gQcU?=
 =?us-ascii?Q?qG+YgXgxZNnwyCwbjvNNXa/htOV6Q8c9JcpdHshrwtvQqU1ped88mqbisypC?=
 =?us-ascii?Q?Qt//VFKsacfy9cUTor3c6x6WbQ2DeTLcWTXaAgvIIFGCBcLzDRUBrAXFx7nR?=
 =?us-ascii?Q?vx2WCdaFgCFA0vDLLDfwc+7DStxzXrNeyBW3i1l7lJLTSheu1/l4zx52zpFe?=
 =?us-ascii?Q?Bx+j5swfNxh8Rr//O6mc2720DMifMt5YIPKj34wu6cRZlPoxI/KNdnddMcDw?=
 =?us-ascii?Q?hkr3we51RqSHoIktZsp83up+gv9ovvgKYzqeMhlmVbyEouVVenU0AR7887Eh?=
 =?us-ascii?Q?dWr2WGSManWWSjNdDMCnlHb5Nwaje1NudGqKEATLfLsAgWo//MOHHOOU9Q2b?=
 =?us-ascii?Q?td2ANA7ZqSvLp/5//dvbDZgWt1jhdHR45RTNS38jRHWKMlMmid6sWwjxqZAq?=
 =?us-ascii?Q?1rMee72UFwIc+TpItKBLsjkYIdpacr9jHp6GTm27vhwiREG+B69/mLNHERKm?=
 =?us-ascii?Q?gIG2W22OwLj+KrLltLL1Kl6gUQ/quI6EgzO4KlLRbltuBtKuWop/UMlu5G9D?=
 =?us-ascii?Q?E3soUBEKz/ksi65uTcUOgrHjP80w6wQ7YS6C7EoIOlwfnFYwQTYSFNLL0uW9?=
 =?us-ascii?Q?ERFxMdEthRXtvynBNrlvgZtE2FvcyEu6iboIusb81dNd8kMOI1h/dKjSvfSS?=
 =?us-ascii?Q?afJa+e7pxV7xY+LSLKeawFAXYXybKu5hS5yHhaUhVOejOD8mmgtteoWYXVTU?=
 =?us-ascii?Q?FJtU+I3n0CCOKzJm/rXhPQjUm5sQJHDyPgREcvvXQF4S3b/Cd9tXRgmbC2Xl?=
 =?us-ascii?Q?NDuTIpzCfzWuErTjxf9FOubPtQiJdAm3z0z1+Sq5XaM2ij1fPnTEHBxb93We?=
 =?us-ascii?Q?kvGG1gACtAQZAlwkKDGIpoCcpiwdDXX+4Mg9FE61rGIwhs2iceYApwogWIbU?=
 =?us-ascii?Q?5Mlexvx8UYGYWruczHb1jGCrh/oXK78RAZwxJ4yR7BYRz2U526BA4hFdG+vL?=
 =?us-ascii?Q?5gtKbMrPJHG6O4zPC1Ex4YR+bjxPiXMdeFonq0SDsH8tgXy+gnTrpjBTPhba?=
 =?us-ascii?Q?RDadxg8+KkpFw4Fb3o33v9ucKVis4JXFVvyrmtW+sqpEvsa21YoHCZa2gM7b?=
 =?us-ascii?Q?+aszxztuw0e+8dTMPlXYmNs+L/eK1EcAX+75/Mg4DtGIt9xiNH4n08D49V7s?=
 =?us-ascii?Q?4MkfiAeBJph/aja+u2gfOPfP9OTB7tymgwnvQEq+dApVrWoEnShjkGiUAjlf?=
 =?us-ascii?Q?7EXiEPFiUqW6zElvEvGMg4EW3hx47uRdpxhy/Y7Fu+LtI7dcUVxF8ZU/wnLU?=
 =?us-ascii?Q?jKyAQIIQv1Y/lL20KDxd8sGxfWFnKtH4SqHeebAFtpiWTdJhymujCRTOt5aM?=
 =?us-ascii?Q?+M1i4Os4+qGgdtEP+Z7XN7c++vXE5tN5R6Zfy2nz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67d25c5-f93a-4a71-2736-08da5f51c324
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 13:16:39.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL/9YyYR9Nk9GzcAgCyyDqx3i3/4cCikOTvXp2Blju5th8+jPzOP4bfkKMN/NJwaZa6TkHNTSxPnbTW0QZMipQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2163
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_08:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060052
X-Proofpoint-ORIG-GUID: lypIi4NF8axv0xL3_olXuL9e-IfwiKLT
X-Proofpoint-GUID: lypIi4NF8axv0xL3_olXuL9e-IfwiKLT
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
 kernel/kallsyms.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fbdf8d3..5748020 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
+#include <linux/btf_ids.h>
 
 /*
  * These will be re-linked against their real values
@@ -799,6 +800,100 @@ static int s_show(struct seq_file *m, void *p)
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
+static int __init bpf_ksym_iter_register(void)
+{
+	int ret;
+
+	ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
+	ret = bpf_iter_reg_target(&ksym_iter_reg_info);
+	if (ret)
+		pr_warn("Warning: could not register bpf ksym iterator: %d\n", ret);
+	return ret;
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

