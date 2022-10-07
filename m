Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBD5F7C76
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 19:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJGRtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 13:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJGRtJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 13:49:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD7AD2583
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 10:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7KmpNvJZ1JjWAwVrm1WGwyQhUM5TEUuusDOYhQBcbd+ZHaQc0i6kpnUFHjRJ9WyXs073/fmXF5nNgB37rw+9xCYAlx18kLHU7DfcFn/tXiaakWTC0wRRSktQAuFaECehkXtRaH7QfEx49OqV2c2YsPzMSxtfVAh328r6XPKwX6LLwknR32O6c1+mnJZEWQ6HOoaxFLwcWVEskimWrae7XDdmnKaJMHtcnuZO9juIdIRT64NIS4ysEoONTsTUEzDIjECu7NzxwkHtYpeE/1v2bPV2VYvZQJNf0xTaw9FPR6YAyDjhPZKiq1+fIHLAojxdlala1ImeIGUrR7W2NE/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Saa4zzAnL2nzcjFL0XRtGX9Q/eUkq9aVM6mbKjHINss=;
 b=BB64vyhdNOaPso/eTW64Yy9U5Qe00EOO1HPflxaXSUNT3f5UE24uIpGcOlUEPRqyQsidR0ygA0cHi2+GrOaxaTSlUen+ZhV4XgXm/gvM3In7pQKE6Pf/3i+0A7pCNfiZdF24SAQacK+dxX8o9bkfzd74zRtaQFoDKaAOQDiXd0n2A+5DcNozNYELZ9pf0TrfG0TcnLJysbXaDyzvtQAIF4/6GvhaB3H/lbkZZVRXJFhACWEvezk0+VR5QkKcqH4dkh7mXJ8zFa8t72oRBXe0iAr1ZZgQs4f+yyoY4W4Q9ukHSRdhP62V2sEKaDBoPlM22w4Nsol3XaK5WaOFbI7KiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Saa4zzAnL2nzcjFL0XRtGX9Q/eUkq9aVM6mbKjHINss=;
 b=3Vy6plpByUHtQWMAsV7BLkM8aJeToDr+b6ZmO25jPRMvfiDM1PpYIuVmmBesQZkcNUZornaIBocbbc2kV/MtGgczWRfQZUtsDeldWCD7d5QnuFEk6Kp7zAbeXfCrYSlDJVg81uhmkOfNA8WUX4Ed9MF/1vfaaN+j46L161NQE3vUCuu5LyxqXeesNIH4GF9jT7Xt6BTZf52qCgTCvUnfFTt8u7QPT9eOVwyXw4pSS+sfE+EQiGeGHvDlBmEJq6HFiECNCV5cyjHRW+eMfsMfKe1ylgnMbvSMvYls77cG2+gXNt/u4sErALL7prxyuiG83qTHyKvbBdDjwBhC9UkzLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by PAXPR04MB9350.eurprd04.prod.outlook.com (2603:10a6:102:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 17:49:07 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 17:49:06 +0000
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf 3/3] libbpf: deal with section with no data gracefully
Date:   Sat,  8 Oct 2022 01:48:16 +0800
Message-Id: <20221007174816.17536-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007174816.17536-1-shung-hsi.yu@suse.com>
References: <20221007174816.17536-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:404:e2::21) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|PAXPR04MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f617a2-a69e-4518-f8e5-08daa88c3b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJXlIhQYZqYaONC/PbUpPn5nmB4U+fAW3LB/5rSEHObQ+WFJ/ayVA0M/vlEWoRbzaCXgRqMGrIcVX8V4Ewr9xt1P1vMvMCFY9z+MJH6IGlTr8dg57TQs2gsQ05ZlEPup6LwAPNX/slGHHNyXQbBL6jYWAVcIoDDW0UdRMnaXV7vsUdPk/LhQhN/ixPbKDZSivZARsLs+FNRewfcyIww62dJh5CFzeuOLaXH4q2LwVzCFgp+3TnH4/qljVgWAbUoboWx5NAyfN7m9en0WopJbaGRrOZStIKbSBKCq0dHXibg5xLIFizi4IgYz016KnFE3zR6HgocftpSVz6192kA5Qw87W/zHDiT/VO3SeIGWspEZxr06PxqIZWBGzEjkfVT/7Jc6uQQAPnjUvfaAbbJn3IUkGnBaLPiZgidEZvNNOXU9yjsoshhIQTkjzyGhKkJpfjxIDFOdu7wzEv2t1JUOIPZMPzF4YRGUDH4pTYKLbKNJPX6nLF0UfnfB0SctVmOIe/lIzOmXUgr2YIWM19+J1WPf249gDJXXtXGg590Df6+4pPB52EM/lMS+2A7bazgtrKVXqsIOZ2zYJw0bZ/L59v6bYdaOx8a9VN1gNB50JpWj/wi+zs2E3c2N6t4XzohFXf1FiInqZSH58UK/29htqN/85jqNzGpQNfzN5TeyPCGnZcYuFORe9nVbvG3fmGrVRxiJjiwlRiRryJW8a37BUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(1076003)(41300700001)(54906003)(186003)(66476007)(86362001)(7416002)(8936002)(6916009)(66556008)(6486002)(66946007)(5660300002)(8676002)(2906002)(316002)(4326008)(6506007)(478600001)(6512007)(2616005)(38100700002)(83380400001)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5eETPW33+ghb+fMd4EfBBHTj545ToeFsEOCB4yQW9xwXEUW2RZXcilKR4g1A?=
 =?us-ascii?Q?ITfgTrRWSBJft5i4YYPpbZm00MvQljB8KLAztJ7ZWy1WhmJOIlWZku47QB1G?=
 =?us-ascii?Q?StueMkLhngNfRJARaHhdNvqFiQeU5R72yF4RgOxLSUt35YJlxVEALZggOtC5?=
 =?us-ascii?Q?fVWqx51o7D0rQap0yLJPRrhjao18Xh5e2MAEHf4iEahz6PBd/eLagP8LcO+3?=
 =?us-ascii?Q?TD3KkNfc0hMPQqVk/qF/DyKPI5i72hi/+zKClLN5FUNyJHBDd3TFfx/45Cni?=
 =?us-ascii?Q?JP0n8tCT5AaKU+zCMLYfozSMOjuDaxdzSvZCKs78ksK/Vs8Vhqfk0hEdGjT4?=
 =?us-ascii?Q?B6UthQHNvyLj1xABHl+4Dw88mhmkzGoLLRcYWyPMzw2Q7Gw1QFnjhdjlOyAb?=
 =?us-ascii?Q?oHQrbp8zjQKzGNeQeEPxiSXjnOwGVbKmKlgmS2kvwF41seBKupWTxhzPdBw0?=
 =?us-ascii?Q?wP3hP1Y9RDCdK+VkFuhcsneYZSj/JmuAkPvmEnZ8haKAbWRZ8ye3yuUoor7s?=
 =?us-ascii?Q?PPR/KDbMBZL0eOhvZDTWKfGgOUXFqalN3i0J6xu5TCv5odyF0fvrKKOudnUM?=
 =?us-ascii?Q?JAfncFgJlj73zY2kenBfSq9CdefYPxZMCIk3pw0B+uD6qdfWKy8nf0LyllKb?=
 =?us-ascii?Q?YDlt1TFM44diepyNPQan6UPAzvWv1aXcjjVL04Pz2hOGhEMRVABoLoS1LAl2?=
 =?us-ascii?Q?VPjalxxIsWIRbNLiF+Kto8WsieZUCv1vL4zuRvmwz3ivwlSRu1M21fCt550W?=
 =?us-ascii?Q?jdf7OjRSOyecT5M/svDOkUk/AIDGCnWXfBMp3pksvDJBUI0XUI+Bns9OkSbp?=
 =?us-ascii?Q?t52yZ3QFEjlgKXnLMTxnxzkCpwdLhRJpkrGKOC46LkwFpjhNtFwpZAA/TZKC?=
 =?us-ascii?Q?bJcXh2On12kCcomDv5b0P73Nu+ymQ+zkH5ROns4ri8ssuihZbBMNqXMft9qe?=
 =?us-ascii?Q?B5kly2iX88jowzE1HEyrTXXX3G+NhAr+PU9oCVb/+xZglFj5QF8RyX3Z6S78?=
 =?us-ascii?Q?ShVTl5QEPhMcgzwgA8sX/fKWl+BNCXbqX/p4Qb8vdmrYnRrg4IjWRCHNgpmu?=
 =?us-ascii?Q?w3U4FYxI0PCjUaAOH34j+gcIVicfF1KvnFEKKRgV8BEEmg+7K4HW1x8Evpk4?=
 =?us-ascii?Q?s+y1LNnEqk0/SGREspvJDLpKsvK94CvHvt3DB2lC7gHDVHColbw743LJ9urw?=
 =?us-ascii?Q?zQSNcWEnRhrg/W1WVPmFtDQ4YRpOMbj/G7uQW0442/uR8uphujpb0p4qsq6N?=
 =?us-ascii?Q?o/lvOSThAsdp7B97Kqp/TA7Vz/+w8eapwDofToeE5Y7lmCJkdlZS3PKRaSAO?=
 =?us-ascii?Q?XfqkUQCLNYJKe435jn8O3VUYPMC1yxKZdn/PapITirXUwpLd3REXnyQeYhM4?=
 =?us-ascii?Q?o3Ih6wRPHqBiSE+C3yrkdfAf/A06AucsRXKDB/Cfgbxn66hzbMRR9jYCzGzL?=
 =?us-ascii?Q?EYuEWeBhj9MFjsldXvbfiwacAteiI/9J0BJ1zC9d8YuB7er1B0AFnLwXdsM+?=
 =?us-ascii?Q?ALmB5HuBQCFTFOuIvXjOZl8ltWp+D0iS3rwyDFZWzZB1TT6Louh64VBStFeH?=
 =?us-ascii?Q?GTOi57tFPY2pbW3ZbcraW+s6G2+DzROC1MQg6z3M2oGgdxIP+oEmDKByqzfs?=
 =?us-ascii?Q?Z1QdOB4GDW/nmS+kSTRNY18U/N/ZP7XF919vBFo8H61X?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f617a2-a69e-4518-f8e5-08daa88c3b25
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 17:49:06.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coIXRMSOKTeph+azqOokFDfLTFqjTZFr34m5HAMs7//8Fvp8u4FVaF7AkFltS1DQFpzRqLcJfGjRPrRPxH8wcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ELF section data pointer returned by libelf may be NULL (if section has
SHT_NOBITS), so null check section data pointer before attempting to
copy license and kversion section.

Fixes: cb1e5e961991 ("bpf tools: Collect version and license from ELF sections")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/lib/bpf/libbpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c700489239e8..89f46d0616f9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1415,6 +1415,10 @@ static int bpf_object__check_endianness(struct bpf_object *obj)
 static int
 bpf_object__init_license(struct bpf_object *obj, void *data, size_t size)
 {
+	if (!data) {
+		pr_warn("invalid license section in %s\n", obj->path);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
 	/* libbpf_strlcpy() only copies first N - 1 bytes, so size + 1 won't
 	 * go over allowed ELF data section buffer
 	 */
@@ -1428,7 +1432,7 @@ bpf_object__init_kversion(struct bpf_object *obj, void *data, size_t size)
 {
 	__u32 kver;

-	if (size != sizeof(kver)) {
+	if (!data || size != sizeof(kver)) {
 		pr_warn("invalid kver section in %s\n", obj->path);
 		return -LIBBPF_ERRNO__FORMAT;
 	}
--
2.37.3

