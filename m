Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D1556D1BF
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 00:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiGJWKn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 18:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGJWKl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 18:10:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144089FF7;
        Sun, 10 Jul 2022 15:10:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26AEbH1E013818;
        Sun, 10 Jul 2022 22:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mdDJHa1Jke1cSpgJlPn8SVJFYbF5UAmR4s2XTPjmMqg=;
 b=SLpHMucAAmcbbSWwli8Gj2ahV5/JJEbguEMXK8qGR8qcCor4DAo/rBEcGVfcGbkwbYTi
 W4xYPpo/hfdMe+VTsPAHrIqRi8GmHqRoQbwbqEOfs2F4ztofo2yJrKucOl2afWaOCfDO
 vCoqZW19grCSzm7AiVFCz4em+GEhoriwlr/wIsCIUSRUYjemsUZ6ZehU8jtgLazTKE/J
 fCotIibSzGJ6FFPDg5HOtrrAzLK5qlPkfc5A40lft9KtyAaUqYLVczV7qdpZrgj0DWio
 cgl1NqGwCNxLsibvaBC1OB1a3GjuKukYrxkUeehm+Uz/f3TjIp4dbkWQqIiy+yIAy0eM uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sghwtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 22:10:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26AM5TCf003457;
        Sun, 10 Jul 2022 22:10:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7041jpku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Jul 2022 22:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BReFCB/3W39po/EsryTIGnekE9xzlBGz1CbITM7YjHPHgkHFyZZrwuhyBjFKaifNYvioQXd0K3uTQ/6KZjhoHyS7RRT2FZw7pzxC3MpvWaIWyZuFN74LR57DZXgvxio5UUPT1AR9UTPFGtu13qzP0WT1md27yUF6qwOCk7s3R6OmAcSpBqlWhWiv8pf4fkFc0HBw+VSQoBIsnf0Ib3Lv5DXwbS6TYEBkrzEZs2D/o7KUYTIAnxSoJ4YQaTdXcIctN27HpIS5ln2rMKSwRPFzJ1mA0ayku9XxSDWLewPTjmUwJmEUucyrFoGNkvOjuaDMUpughjnBdDRdc6z14QGxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdDJHa1Jke1cSpgJlPn8SVJFYbF5UAmR4s2XTPjmMqg=;
 b=PC3EDV3IkWPni1Fq5WACBGq4yh+0csHV0XIDFgqMT2MbuSplQJSFMxHnaTH+Yyy2NGTWCjhaHsZXhXtzsaAVmGczr+FgJG+EriPUpvdZYDT3vt9GIZpRUDMJg/x2PfC8OAhF0htQmnvdoFzOGjOAEjxpD1UNuec+ikYe0BHcfkiMle0Z2og5KMk5t+sEllJL4GhS7fpXuaAPijy4VChlBElfQ33iKkQv89Bvh278A4DxZsQcitS4ihCUzkEcNSJx+zKxWJ+iUruMAFdgmdAnxNzHE0+YNdE/i42NuwjzCWcMkZw6MYjEbQlhGjvN0C92Pu7/mfqosaYlzO2DVJ2KcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdDJHa1Jke1cSpgJlPn8SVJFYbF5UAmR4s2XTPjmMqg=;
 b=nTaEJM6jXeM3Mh6cdslKHQNHvo8RFHhsuc/PYm598neDMsqP+wjFdSLx/qpmGvwG+JUgFpLQaKYtyFSJ33OYnW+e+iU3hR7/0zuey2GO9xfqKqoPNs6Dsdk4kYTUEDxxZh7S0VPEhOADzzWSW/oyzZyeABlkBlEorYeJZouqZzQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB5207.namprd10.prod.outlook.com (2603:10b6:408:12c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sun, 10 Jul
 2022 22:10:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%7]) with mapi id 15.20.5417.026; Sun, 10 Jul 2022
 22:10:08 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 bpf-next 2/2] selftests/bpf: add a ksym iter subtest
Date:   Sun, 10 Jul 2022 23:09:58 +0100
Message-Id: <1657490998-31468-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657490998-31468-1-git-send-email-alan.maguire@oracle.com>
References: <1657490998-31468-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0355.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::34) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2918a020-4e9f-4080-7f71-08da62c0f33b
X-MS-TrafficTypeDiagnostic: BN0PR10MB5207:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZZptx/OX9DgD9zP6RYG+dudUCNb6wZxRiqGB1Jr2TO8Zn4KJT63WWR1WTljPbeq0E9zDgE9cxsj39CdxbLaD27+aU4WdKnyLA+0NB/dTfoj3d7J8Qk3NV1958Hb0d1ace3HKYo87iyVf+AdxhqAw7VzSt4PboMzHFjEhQ0MYeagfxOBLovocN5En7nYWAs7V/aTqX/7+KM3qsZVLt2bE3+IMg+Ne/+I37Z0pFY8TgOgPtD7FKpjxIfHkofVdomVRwZZbA5VsEzI9uR+3dlh6XbSxg8eNi1yNNPN4guFD1HYDTzXzR33MEEhIni9fYQFQowJNtvjzEoxjn87w/frZMBaz1CZDF6tBxo7pt3A7XTZoDZBe3u1yEF+3JX2kh4/lrfjKGPsWiMQbBdvKF9pKOCvz185yeSZdMyBDqa1/SoVFCAym4LQ6Ijibe8mYttboIVXIPDgdF/0KHuulgcCWs7D6576JJLBiiA5BQvYXDc5gT1OvVyMVZzn72+S6NukklYxTWLHXnzaSD2yYXVNhyBqzVCe8AOFp/tVcVnG5IruSdl5MHoRknR3ZsBuztrNrW1/gb/c/JMEGoGjdWhtbBB08L2rAbWTAnshMsvLhFY1BBP0lJKw1ATbCx+lp6amPUB6bjFg/hT+O5Wtvb2tYveFzJtafHXwIthk/u6+Y1lsZcqTZD7a54FefEPq7OqoihFGSE0obLyMunontte2MNkTQ9DOxGowwKzRp5UDlX9PvenLE5f0IzZxwPezb1JLM9dTv3L9ps/NWpTTU7TTuVdhNcUuvNqIw5H9g6S4Wb3XmsTtqzrj0jaWKWLZwfxx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(366004)(396003)(478600001)(6486002)(44832011)(83380400001)(6666004)(36756003)(4326008)(41300700001)(66946007)(2906002)(8676002)(5660300002)(7416002)(8936002)(316002)(6506007)(2616005)(66556008)(66476007)(6512007)(186003)(26005)(52116002)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TAwnXJBrtqh0mzDnaWh5b8TyBdBfdh0slzckPFqs09rg6XAgTCPjnlfBEgLu?=
 =?us-ascii?Q?bgmXaGe3We7yMWQVBacx4jrV21Y0Nak//SRzScOTI7wZvmOpY5vN55DvIw7i?=
 =?us-ascii?Q?MM2F1bKspfGTuNP22oq4RY2M6uLjkegHz6lCvIrfOHbXwPAZpZIMEWtSA5ml?=
 =?us-ascii?Q?cZJ5T1KZ0d8A58rWsF3JtVTxufdjE4l4cUvKool4YQWR4OHVosxWAIf+c0th?=
 =?us-ascii?Q?V/UBaa6MezikuIItDAow9TRspua0Hk+fKR3jqVFjLD+v1/1HBf1CS22eV8ge?=
 =?us-ascii?Q?ymZN11WGmyQKBRmAOZ1oS0gpwcjWGo8m9IC5sn05GgS9mpzfrY+p13/hJCf4?=
 =?us-ascii?Q?2jx5IAs9A8PHZ7xk6Ts+sH7lPGQpf65Zz8okiuGX24Gaj+XX0haVUcPv4wB7?=
 =?us-ascii?Q?4SgSDaAxuUw7cWnWj3KIpDtTeM4+ePfhGkE9vb9w8z8On1uKw5IFhsBzqIUG?=
 =?us-ascii?Q?Wy9XLnjYcqeR2kbz4yCGszMfarTm+af2zlsREQ7rXx/y8m/QRJaACMQYIezf?=
 =?us-ascii?Q?Ym5Hxn1A2Dyzjfigkb1lZmUwJ6wvV+kyIlwRIs7HVukVoObjxaIy038wGXTY?=
 =?us-ascii?Q?5dd5jk9/Nw9/LODchBY8oMPMjLDg+yct3udLLqCCcc2EwGDcIl7plV6ALk52?=
 =?us-ascii?Q?kJzcAzefFpEKRAXwNFJsbTyumvPXeKETO62jLuoskzJdl+5j6iVWnUTJtOqS?=
 =?us-ascii?Q?FVturpVtdbT/+4Nm6bjSrLDeBHfhbXfeEiGDaQTmmU5sis/naqrRQkvQAkct?=
 =?us-ascii?Q?kH1oV8ge+2kwx+5PcVUdQ5MfDJzYXYEZoYu1fpNUqVDr5+uyZ++bQzZJaMlq?=
 =?us-ascii?Q?xeUeX0gIyWqMmn5Dvumqotp9fxZqiR13GTxvGAeWHgzC5EDBjjNiDZ+/KouO?=
 =?us-ascii?Q?aJuunUVbbSzZrNwQHo95w227MF0BuvhthWrr7wEg+SMzs7YSH2efxrCZY2gu?=
 =?us-ascii?Q?U09iFIP6cxQ+Wy7x4qM6wxIyMkud3fNTG2S+5WR/I8ELT/ErsHb85IcTIkjV?=
 =?us-ascii?Q?f8ImvCjCNTwWMchNjp1+//bItysJlJTFsXmfGCy+qJh8ck7XNVAKVdqBTPOr?=
 =?us-ascii?Q?fhoHao/hIZyCcsnTSabKtAP1b7TmzeWlCzgnR6AZ/YM5BzhS64V8HbrRtUxR?=
 =?us-ascii?Q?Ve8D/x//T4WI2mos6S10AJUCgDhjFjJ0tlJdtOE5wIhqpjyqrsmcVLzoX7x5?=
 =?us-ascii?Q?F9mKf7b3FXu5ZhBrB3DLsuAvqK1ott9XBJohQz18Z+Ni9CLKfPfpcQckM2Hh?=
 =?us-ascii?Q?K3GyVMdoNDyX80x4Nz1OQpRNO999hn6+3CgxMWWWGkGU+Bb1jW89Pu0KF18F?=
 =?us-ascii?Q?MiyYqeet64X2keeO6cUpP7pe6PeXoTh9vUJxf4kbcE0grTu6D2bNb0Jb5bux?=
 =?us-ascii?Q?5j0dkhvpdTNSYrMPKbxDdmdeelb5VxKIxy0c0hh8qqVnw8rE4kijkQdvLdUe?=
 =?us-ascii?Q?ZAJ22q6n/f0hgf3QEoa0YHWyEcmuZgTQVys1gYZRQ2qj9PKYXNyJLyKXNNi/?=
 =?us-ascii?Q?xwBdhru66MMrqQV+149yYv2RzLo7C316XVTQMWBySBQPdz9U9IsWTnE9SPRn?=
 =?us-ascii?Q?yVZHtLPcfj8niRP0EbZE7TblPlhXGN3UHh/4c80m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2918a020-4e9f-4080-7f71-08da62c0f33b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 22:10:08.3007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzBYrfX6qb0ff9vTvtH67M5E6K9mYRvj1G0/fbiz34/5+7rEpH83gkVcGecKtMCXZOn7Ea+5wKE/FoZCstf9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-10_18:2022-07-08,2022-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207100102
X-Proofpoint-GUID: q1BmFoZE6iXT7r_X0hDBSBX6KhMuGkQP
X-Proofpoint-ORIG-GUID: q1BmFoZE6iXT7r_X0hDBSBX6KhMuGkQP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

add subtest verifying BPF ksym iter behaviour.  The BPF ksym
iter program shows an example of dumping a format different to
/proc/kallsyms.  It adds KIND and MAX_SIZE fields which represent the
kind of symbol (core kernel, module, ftrace, bpf, or kprobe) and
the maximum size the symbol can be.  The latter is calculated from
the difference between current symbol value and the next symbol
value.

The key benefit for this iterator will likely be supporting in-kernel
data-gathering rather than dumping symbol details to userspace and
parsing the results.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 +++++
 tools/testing/selftests/bpf/progs/bpf_iter.h      | 32 ++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 74 +++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 7ff5fa9..a33874b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -27,6 +27,7 @@
 #include "bpf_iter_test_kern5.skel.h"
 #include "bpf_iter_test_kern6.skel.h"
 #include "bpf_iter_bpf_link.skel.h"
+#include "bpf_iter_ksym.skel.h"
 
 static int duration;
 
@@ -1120,6 +1121,19 @@ static void test_link_iter(void)
 	bpf_iter_bpf_link__destroy(skel);
 }
 
+static void test_ksym_iter(void)
+{
+	struct bpf_iter_ksym *skel;
+
+	skel = bpf_iter_ksym__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_ksym__open_and_load"))
+		return;
+
+	do_dummy_read(skel->progs.dump_ksym);
+
+	bpf_iter_ksym__destroy(skel);
+}
+
 #define CMP_BUFFER_SIZE 1024
 static char task_vma_output[CMP_BUFFER_SIZE];
 static char proc_maps_output[CMP_BUFFER_SIZE];
@@ -1267,4 +1281,6 @@ void test_bpf_iter(void)
 		test_buf_neg_offset();
 	if (test__start_subtest("link-iter"))
 		test_link_iter();
+	if (test__start_subtest("ksym"))
+		test_ksym_iter();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index 97ec8bc..4b23a08 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
@@ -22,6 +22,8 @@
 #define BTF_F_NONAME BTF_F_NONAME___not_used
 #define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
 #define BTF_F_ZERO BTF_F_ZERO___not_used
+#define bpf_iter__ksym bpf_iter__ksym___not_used
+#define kallsym_iter kallsym_iter___not_used
 #include "vmlinux.h"
 #undef bpf_iter_meta
 #undef bpf_iter__bpf_map
@@ -44,6 +46,8 @@
 #undef BTF_F_NONAME
 #undef BTF_F_PTR_RAW
 #undef BTF_F_ZERO
+#undef bpf_iter__ksym
+#undef kallsym_iter
 
 struct bpf_iter_meta {
 	struct seq_file *seq;
@@ -151,3 +155,31 @@ enum {
 	BTF_F_PTR_RAW	=	(1ULL << 2),
 	BTF_F_ZERO	=	(1ULL << 3),
 };
+
+#ifndef KSYM_NAME_LEN
+#define KSYM_NAME_LEN 128
+#endif
+
+#ifndef MODULE_NAME_LEN
+#define MODULE_NAME_LEN (64 - sizeof(unsigned long))
+#endif
+
+struct kallsym_iter {
+	loff_t pos;
+	loff_t pos_arch_end;
+	loff_t pos_mod_end;
+	loff_t pos_ftrace_mod_end;
+	loff_t pos_bpf_end;
+	unsigned long value;
+	unsigned int nameoff; /* If iterating in core kernel symbols. */
+	char type;
+	char name[KSYM_NAME_LEN];
+	char module_name[MODULE_NAME_LEN];
+	int exported;
+	int show_value;
+};
+
+struct bpf_iter__ksym {
+	struct bpf_iter_meta *meta;
+	struct kallsym_iter *ksym;
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
new file mode 100644
index 0000000..285c008
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+unsigned long last_sym_value = 0;
+
+static inline char tolower(char c)
+{
+	if (c >= 'A' && c <= 'Z')
+		c += ('a' - 'A');
+	return c;
+}
+
+static inline char toupper(char c)
+{
+	if (c >= 'a' && c <= 'z')
+		c -= ('a' - 'A');
+	return c;
+}
+
+/* Dump symbols with max size; the latter is calculated by caching symbol N value
+ * and when iterating on symbol N+1, we can print max size of symbol N via
+ * address of N+1 - address of N.
+ */
+SEC("iter/ksym")
+int dump_ksym(struct bpf_iter__ksym *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct kallsym_iter *iter = ctx->ksym;
+	__u32 seq_num = ctx->meta->seq_num;
+	unsigned long value;
+	char type;
+	int ret;
+
+	if (!iter)
+		return 0;
+
+	if (seq_num == 0) {
+		BPF_SEQ_PRINTF(seq, "ADDR TYPE NAME MODULE_NAME KIND MAX_SIZE\n");
+		return 0;
+	}
+	if (last_sym_value)
+		BPF_SEQ_PRINTF(seq, "0x%x\n", iter->value - last_sym_value);
+	else
+		BPF_SEQ_PRINTF(seq, "\n");
+
+	value = iter->show_value ? iter->value : 0;
+
+	last_sym_value = value;
+
+	type = iter->type;
+
+	if (iter->module_name[0]) {
+		type = iter->exported ? toupper(type) : tolower(type);
+		BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
+			       value, type, iter->name, iter->module_name);
+	} else {
+		BPF_SEQ_PRINTF(seq, "0x%llx %c %s ", value, type, iter->name);
+	}
+	if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
+		BPF_SEQ_PRINTF(seq, "CORE ");
+	else if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
+		BPF_SEQ_PRINTF(seq, "MOD ");
+	else if (!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > iter->pos)
+		BPF_SEQ_PRINTF(seq, "FTRACE_MOD ");
+	else if (!iter->pos_bpf_end || iter->pos_bpf_end > iter->pos)
+		BPF_SEQ_PRINTF(seq, "BPF ");
+	else
+		BPF_SEQ_PRINTF(seq, "KPROBE ");
+	return 0;
+}
-- 
1.8.3.1

