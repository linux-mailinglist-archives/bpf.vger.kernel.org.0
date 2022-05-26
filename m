Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155B0534D44
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 12:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiEZKYn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 06:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiEZKYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 06:24:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2193DC5DAF;
        Thu, 26 May 2022 03:24:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24Q6TZG9015642;
        Thu, 26 May 2022 10:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sY8M3K4qMT3Y48P/tYz863T9OI41XhH0yEDCg7sDsKs=;
 b=T+Agrli8MRQy9ZCp7NR+YIGTAVpS0VNqGslHlp40ZnhtVvDju21qBEKrDENosRme+ThT
 Gef2qDlSTLIHi58tpLaF7xwEx5yN8QU7l5Ai86l0FBN+NYLsHKTliJNxYeXgbxtVtot1
 dIqoQcK8jCoR9VRmV6BtJECTt1N9IhXmwpZyPKr1lvp0u0mTyGVM70K5zb67CbXL1Qt4
 2xWuLSg7r7msiXqtDQvp6+2O3Db/RKnhCKbxK06KWmOoC2QsRNZcDQjHy7ePqKdO+uJ+
 EUwVLLLa6soKFKwoq+XL5h3/FRHEyrfnWGX9Sr5KzBoPeza3wKNjKIt3QBJcNKZsXShp Vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tbcb8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 10:24:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24QALPlL029528;
        Thu, 26 May 2022 10:24:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x6m1s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 10:24:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQLXXOhPwjspp6PXf/rjQIMyT0Mva0IZriNnF0UoDsitG5y9WioLwQeNT7ITVLpqH1xVqAijNaKH+4k2EKUW4MyooB70DKOrgX4qEeAGMXpxHwgS5wpdKUHi7hmz478hRhTt8RqaL6HPBETllkdnH03kiB6eCW7bYDtP8Klpx4G2F6Q4/k07GdSR8WJtd0ZLIum3lGGw4SIgTS2AtzY9GBUkC9i+I5BokdclGyjP8oo2niNqH2V05U/mwxODW3946NC7RsZEJDy1YkZqE+OVPJRpf8WpMtIJVDovgVhymX3eghlOk11XQwg4vGciYSBWYkENTtANqs79aj0a9P436A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY8M3K4qMT3Y48P/tYz863T9OI41XhH0yEDCg7sDsKs=;
 b=KdycpqRrGFPlj0vNra58v8t+AGKontenxB2uftRo1XvCtr8EnNfh8sMF2trpnKFp/duMqOSo7PDCde5yRlqmB1hidqxspWleX6AP4n1LgWpxy9UQURVBzUGV5Xhwn0OdtyjYbSMRMbMvxGFVViuH2S0sfjxk2zm6THi6Tul2CBu4vUSNU7Wuwdg7CNjnvS3O/RAjTwSpGGxwtrFfZNZOt+Pfts9KLxD9kkmqunZM2RfeJIdTxwKOTVj9aF6kJJpEIK28rnsTkSeka1xxbMRkjtlsrneqmdedxDvulPhwpGfvc5sDVx77Mjn8Z+XmOV+MD/1vBLuZ+KJiXYG+U22MYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY8M3K4qMT3Y48P/tYz863T9OI41XhH0yEDCg7sDsKs=;
 b=qxc3+YDuJl2hNz6ZJ/nqid9cY/i2nEaHbkGAVTc7FsrPO9FUTQS1g4ZgIkwvGgFA3JEDWLByKcWNayuGj+PEWCL+D/KoQ+WjRRg7dPAhlkDXFTUcHGz8GIo9y3gaAxMszoc4icePN0DXbMEDxD5qHOfobKC8eVVn3JqmXgulJOs=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BL3PR10MB6211.namprd10.prod.outlook.com
 (2603:10b6:208:3bf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 10:24:19 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::414d:9b62:3839:f00e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::414d:9b62:3839:f00e%6]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 10:24:19 +0000
Date:   Thu, 26 May 2022 13:24:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] bpf: Use safer kvmalloc_array() where possible
Message-ID: <Yo9VRVMeHbALyjUH@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0154.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::9) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54096a97-5ac2-4cfe-6937-08da3f01e4ad
X-MS-TrafficTypeDiagnostic: BL3PR10MB6211:EE_
X-Microsoft-Antispam-PRVS: <BL3PR10MB6211678D437635C88BD96EFF8ED99@BL3PR10MB6211.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rWD6PpkbojOkUMcQ5uREI66uqOzvWUCoqrNpO+VZwyL9dJ7ohsMB1rbNl2bjJuvPgtbcyZfsyzXfLLK8dNjHgYsGk8kRcZH9G3pXRDDEWyptAw9fqWFFM/0ziQAtKxaobFWNFhZ0xDAEDBvuHqfYWsjw9oFCwPHk31IB4ALGOixHzpolWXtTvWow2nwM3CnqV7JAr6ep3V4+/AUEXFksqaWfnWm+4IuGUqmydg0bTPX2MUVWD/pu4Dz5Pl5bY51IWSFinW0UmtEr0Ww9guy0sKU6ZBSbap/Tb+psuynkMHhxuj+/5S+ciLq30XGVHtMO2CuEwK0RpFr5kYYUHIpKWslknLAPuq96oyR0+lhD+79zW3DDdL9mvssrgYM+8pLjcI0helMSsswb+UJjjrv4xXyrlrD5i3/Glr78KD0LEiF9F8ZAuCrGD0gCM2YVXgGYX89zoNHc+1YuORhbkhl429UlL3JLp6aW2cvW/uONfBuzRGWrWzgBy5/yK+rmQMexm3SQ3khb8iRd15IwbSjeroJNuin852MhMqDEVmUdm7bymCyG35QEYgS0n0jWhN5XgT9yEAONH2tXizT3SfbhlnU48wW1Qir4tw0hJTugfB+ugrKv5Jtv+PZFBamtL2VO8tmzuaE3TxbZjigTwjkVDxa8VmzMmOah7t7013WsBI8MdPz5DCr5/Oi2tgRG5S4OoyUHNt1TnHVwMOXK/rGOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(8676002)(508600001)(54906003)(316002)(110136005)(66946007)(4326008)(66476007)(66556008)(33716001)(86362001)(9686003)(6512007)(52116002)(26005)(6506007)(6666004)(38100700002)(38350700002)(5660300002)(186003)(7416002)(8936002)(83380400001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1DfuX5KBBH4nef740EMT3BO3v0ijTO+q7lCVbaxxdJYGgUdPZjy1SMVPCumH?=
 =?us-ascii?Q?awtCcPCxVYfTBQ9/B5Ev0HfY44+PoZrnYIAypMvkESZUp1cJJv3oruEji/t+?=
 =?us-ascii?Q?Nw7VYM/PR67Eu6YHm20mKLuBHN5U2PJImLajwH4bGYiy5RKChO05I0rtraVl?=
 =?us-ascii?Q?qhBZD5YrJ1AdJU4QwGZPHiu0bFhuzHrQHhT+HTeEs14i4IRz8RFzPOus6nPZ?=
 =?us-ascii?Q?Velc1baqAz7vFjncu8FPr5c1ZOKWqLOMpP3icyl9Uoi9dgk1Y6r44lAu711O?=
 =?us-ascii?Q?9IjMH55LfDVuSny2cZqi7asVVr4lOihSroDSeTH1IPsvguL1rryd4VqOx5TM?=
 =?us-ascii?Q?CZU3w5eB7AmbGjIx97t1NQauSaIwvDd8np+M0OEAPNnGz4XGW1ftK5s8YqJb?=
 =?us-ascii?Q?c0cDmaAfmJOtLlXtQkD0zteBe+A2AazNpoRNyv+MwpOOYYd7ZKelW6tLcy4S?=
 =?us-ascii?Q?/uZlZkwlEB7covkLj5pNzGGkPcYnF1tXM6/I74JzHLhIvY5X2z3P9Ii5oCxG?=
 =?us-ascii?Q?1TtS0KVsr7F0PtqhxiBOE115795nes45LwgXd4SZs5o1XvnPl6pBsw50mate?=
 =?us-ascii?Q?QP63Ehbq5Zpn+XFaLZNZJJFrLbfa54D6gdBks3MDJKiNe4oafnTGYTbhnfwu?=
 =?us-ascii?Q?AQ3IA7HR+TeNN86xewaNCjZW5vclaYpJE73mbBizwhAOYaoWJHrJgdLMzyQz?=
 =?us-ascii?Q?rcqRMPUg3mlhg3gQ+ArCDgAkHA2j/hZBJH2fcfclFLIkBwFxKdDkTe9jcap7?=
 =?us-ascii?Q?Bs2vSmAfv6T2y571vU4VgeIjPmyaaqYOiH2mSVE7jp9uhwetvdqKDaJlFFZv?=
 =?us-ascii?Q?CvgInhZRfxZnK3iK6D4Jyk8TDmPVdnffCyQIgPaudGEJqljGO9vKaaNNAV3V?=
 =?us-ascii?Q?bxvn3pHqABcXlbSX+i4ErduXJMbS2GkxeoT1RU1M65K3EtH+O/Lk5blkXZOf?=
 =?us-ascii?Q?6+GmUJMqxGTWuMPS3UkE4ZZkQ5ozlpOZ3H/V8V9ND2/CjWbnmgyFcyNjJOU+?=
 =?us-ascii?Q?wB1mF3sI5Nt3vSKAe5d/Q6K29gu5go5aG0TotJgJrvZe2+3UjuzmXmdT9TL8?=
 =?us-ascii?Q?ZUeRpolixsl/F2nQB6nlhACic38vnqkeP/it0TfpURq7yeI13fR5Ylt//6Er?=
 =?us-ascii?Q?T6hxXsUgGTVnujmHnGxXPqpulvo7rIHJDZM8IAhp5GF9OY6xB5RG8c+azumX?=
 =?us-ascii?Q?sz0bXHKGLkP2GoJDlh0ym3RMvFEeC3ztQnlxe45emGswk94krS+d00I6Dq2X?=
 =?us-ascii?Q?gGZTXJ15vKylzlGL8zS+DLLoQ6B0sfAI+82DjVuSoq/ioP5U0nZ6x13O071n?=
 =?us-ascii?Q?1ej8thvYKYKnYbCQZzYML61VGHHAkHjChraWdf8ybUsG4obNRXovYIbZJwxx?=
 =?us-ascii?Q?z7SuWu+dIackYCG1n+gZqCfhXh6Yi94P0H43J31ifo6HKwUJzublGuIkIm93?=
 =?us-ascii?Q?7pK6zech7zp6KDDefFxCf4B0l4Cr6xu5HxZWjNY5xKS/rOiFbTdXd399irLA?=
 =?us-ascii?Q?NKAl4I/6D9TSFPtCGc+CvdrW3KnHYT3Bohi/ccuIoHd8UrM+vcSVvlwr2bwy?=
 =?us-ascii?Q?kwPz4c4k2PKCpHZDZSX1BdpPa1TQKTfE512jhyGqZSg5GTMm3VZW+wfzSWDw?=
 =?us-ascii?Q?hMGgGCnIdnhEoiqZ0+Xh3MqzmL8hb4+kKSCiGlONxePYPC6HF906yaw3QMcs?=
 =?us-ascii?Q?FWByApPG+676jnFxCmeHdIB6UwqbXj5OnLUVkzGsNImAj8QoqXpD57fG7eCz?=
 =?us-ascii?Q?PK9oPRvwumK1NXy9zZD2MAbdIS1eq64=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54096a97-5ac2-4cfe-6937-08da3f01e4ad
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 10:24:19.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nnGCRJ7UgEr+kmpCChKtF6JYOzfyOpJOdVhwFJxKUTMmz6tE+1k9KFk+oz++Q43LcxfIq1TgBwcHct4oCiMMOUi9S8yy1Ihqg9V0ui4A6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6211
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-26_03:2022-05-25,2022-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260051
X-Proofpoint-GUID: F-mLWrg9bTlmFXougWR0y_u2Zw7UK28Q
X-Proofpoint-ORIG-GUID: F-mLWrg9bTlmFXougWR0y_u2Zw7UK28Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kvmalloc_array() function is safer because it has a check for
integer overflows.  These sizes come from the user and I was not
able to see any bounds checking so an integer overflow seems like a
realistic concern.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/trace/bpf_trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 10b157a6d73e..7a13e6ac6327 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2263,11 +2263,11 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
 	int err = -ENOMEM;
 	unsigned int i;
 
-	syms = kvmalloc(cnt * sizeof(*syms), GFP_KERNEL);
+	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
 	if (!syms)
 		goto error;
 
-	buf = kvmalloc(cnt * KSYM_NAME_LEN, GFP_KERNEL);
+	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
 	if (!buf)
 		goto error;
 
@@ -2464,7 +2464,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	size = cnt * sizeof(*addrs);
-	addrs = kvmalloc(size, GFP_KERNEL);
+	addrs = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
 	if (!addrs)
 		return -ENOMEM;
 
@@ -2489,7 +2489,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
 	ucookies = u64_to_user_ptr(attr->link_create.kprobe_multi.cookies);
 	if (ucookies) {
-		cookies = kvmalloc(size, GFP_KERNEL);
+		cookies = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
 		if (!cookies) {
 			err = -ENOMEM;
 			goto error;
-- 
2.35.1

