Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44F52A10D
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiEQMBg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 08:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345825AbiEQMAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 08:00:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CBA4CD7B
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 05:00:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HAqfbX003221;
        Tue, 17 May 2022 11:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=2DSK5YlvPMgMXoC54WDvD+8axwDts5S1hK/sx96102k=;
 b=xlJU+MoUKV/IPMxsI0SK5d8zslPL3cJExqQZIi6sPINo43wc48yY9sZSdS7fK7rIb8Oh
 uY1ThgyHow9dWQV0OKi6lDq5Vgw8YemlLbakyH0T8lNIQ4aLSwz5marFFBM2FszIlEPh
 j3YlPwwvW+AwfSXizLVrtqraCKd2/+dIJKcSwg2tWKVmZdV79DtBO2HQsCscEPMiwNrS
 sFpHLkt90bMkGlc1aM+pvA4tq4z7kt8CI2kT4xRbMMftH+3IosKtA26//cIKetNdws7Z
 PaR2UBeF5I4TsyKLSlrHa/Y02i49bX6JtwZJGidsD7TR+yAzFfeB94k3S8FzQRFx3pOF EA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aadxfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 11:59:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HBtUpO004998;
        Tue, 17 May 2022 11:59:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v2s1b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 11:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2IucvadoAbYX5XtQXZB0PSb6VVF6OUf1etvQblI85SVNcuo834DQK5XoSU25f57HtQfLERAaVUmE6iOUEWkGsjkOmY1kPGcZvmluq1i39AlCn5iHXfFgdUjkDXYE1hg+7En8oagJp2TbkCL0QJhW8ICG7TktxkGgYbckHhcHrIcWRQOUyylEOH4l6zycVWiJVyZqAX+4YYG8BdnU/V9qygh9HvcfvVOFXmj9z9r54VB5aY/WxxREdCdN9fVAxORpxhKqS1/E2zj4dQ8CtwFvWE+8UhUIv//rvapu8+CMazIsaNsEMZ0M051JbEeBQh5QgFC4kePp7ePbtBehVJ43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DSK5YlvPMgMXoC54WDvD+8axwDts5S1hK/sx96102k=;
 b=Y84jGalO7SniIJx1lFd1KVQo96mc3eyPmggmFAxLWDD+xq9fSLwf4TT7cYWuGCi8Jk1DIf4S/cDleyMURAYt7y1bF5MuAvRKCRevyZWeCr4LLS/eaVH1HoUrFKc+qfsIQveH+j8RkbWAOB9nL4FGJJJPuFYJmsoaEDo+mxjnAQheqF1DlopQe5JNNTOSSxC5PwCn31SVm+vWa64fYSqpaDYHX+lHJ8CqXxFYVH9kquuYaQCfFlVHTpW3viwIw80DrzL0GZvcJU2qv1bJiHZLbHLpkGuXLIkb6t0oEQCCgKcGeCMBwvE3jn2W39jyo19iMRUeHpXZzvTpQnfCCuozrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DSK5YlvPMgMXoC54WDvD+8axwDts5S1hK/sx96102k=;
 b=LVTAnYnk1bsVNtL8+H0YwLbFmMlM64pGdIdVqKkrwuWKhCJ7YZ/06syjAFJCr+/1XxyvxeEX381nhDIkOgEY5CRtBNlelwMEe2OaJII+ChW2uHqHsJOjpp1n3FzJLbMXsbyPtadQutg10GBmkGEPaq8Jtj7t3s9c00f5vLSymk4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 11:59:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 11:59:49 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: add tests verifying unprivileged bpf disabled behaviour
Date:   Tue, 17 May 2022 12:59:40 +0100
Message-Id: <1652788780-25520-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652788780-25520-1-git-send-email-alan.maguire@oracle.com>
References: <1652788780-25520-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d2c34e-de5d-4648-4b00-08da37fcbe2a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56947B497BD879C4FF9B06AEEFCE9@SJ0PR10MB5694.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1bIcE3pz43rM8ou/ixYqI/kE42UKCT0bI7yfoefTk3+cIJEHS1TFprOtgmQxKQ54UbUPczuh6Eep88MMs3ZOWBZwq3Ua3KxUsb0FUj31JZU/IMUrkYRAE0j/I8Esd+4xX0SCuj2C8V6AkWfi9g7kJZsDxcx7zCbCKj2BvE4Ck4TTSquHi7iQkho5CpyyCdcOTuY2ETKs/tpejrdzp4aGRhhzM+Bf+SrdDwZjTHbkZ+2l3uuHTuiOXVualGT0MCUBCD3oqzbOV6sVQb9mhMQwryAoufxJyDc9awDue3cP7+L0LbYUlDRod2bkdlN3jK+hFbZ6NHaHIWruD5yFd5j5neFRjJT13gjbVqbfCUuXVO6X1rXL0U/gbN/g7iUoYUrilXcYTuj+NMri0wi8gsV7Hirimv4rHDgnAZdGnQtCBAn2AC6yPdvTbOvDJjb19oZlpMb/bfV8zVKzQQtksjswjWm5loREnSjW9VO2V/NILXwGjK41HLuHHzmkDUroeDVuRivnZff8MREzRGiWhjuQ7zfzboUef+Y8lkLKWqZhzWaCKEer1ZXUBXCCsls4ieRtOc5pLYcmDr5vdKErmoMtjhyrFR+zQ2/gN7AY7gr/lxxBeT+12SEJH5wCEdgN6KQCDJQMNwifiy4qL5z4hWNb0THkxtYa5w+4KeDapHyS3qHQXS20OdbRhLX/8z4K+icYoxCEf+paQBBVPsXObIrkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(8676002)(66476007)(66556008)(66946007)(4326008)(86362001)(8936002)(508600001)(44832011)(38350700002)(5660300002)(38100700002)(30864003)(7416002)(15650500001)(186003)(2906002)(83380400001)(6486002)(6512007)(6666004)(316002)(2616005)(36756003)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L/z/M9BQwhPQLTmoLIOgo5ndTpXSEoV/74WqK8Iq/n5Q1J1zHmXb7MAqvyTR?=
 =?us-ascii?Q?EDXPGsRII50av2mo2+i3bMmhsmYjuxHG6x0fGjeHKaW1Uo9EcPuOMCRvFL03?=
 =?us-ascii?Q?Sd8yiRW3pxgbJ4SrLLreSalXHDUMqp9nFPh0ORix5UImRplJBMj9iGzO8b9K?=
 =?us-ascii?Q?vqWKxWySVYGUYsT1KhVyaAz/duWxEpeaPThNkBTXwCes9fcTPEXLmR9VgAf0?=
 =?us-ascii?Q?7DFU+1iXIHAfDmUDpPHOs8wamLk8CKRwJE/iV73V4CLXFZpWs9ETQOMdvxw0?=
 =?us-ascii?Q?9VwTYKcHFob4J1hY7bO+628b3t7QLix/nqc4YYq8KDM2nZUo9FSSjWUf3lAe?=
 =?us-ascii?Q?u8d9FrFWumdLk/aiG+K76YS6EgDAcJ8uYOioCwXHAtU4BKnCt27cQovH1huB?=
 =?us-ascii?Q?9/pgCNgdWiXf86dkrAmvHCeJYjxb6oU7c5lpNTb0x/PC8Xa85/KP2k/SLE98?=
 =?us-ascii?Q?EwDZyuuFmPuZZpBmlTzxpw7gV159QOOZafTUHCnLIEO6c3rexDnrkbjiztdp?=
 =?us-ascii?Q?M30miKgWbpzqHdCm4ZcROQy6VrolXphKmyq5YbW8yallA976P8WQRj7pQnG/?=
 =?us-ascii?Q?ztUNtATeFFUnAuGBPuCOwPpP8GMLbsqSCtWn8Dn22RxXUyB/M0ks9IEyT08D?=
 =?us-ascii?Q?ojYg6OVl4SGaJXMiWzux2mSbO/Y1U0X3FaFpuOCnF1m/pEyuuG9+1I1Uu4lu?=
 =?us-ascii?Q?V4UOAbNg4udPatqRJn/bT+FN0v0py2VAifc33sc7ZUHuInDA82aVQ6025kz/?=
 =?us-ascii?Q?/COPpxPkS/cSlLM8A48KYZpWjsBkM60iiqxUvt8vOHjbvlMwl4TzSFQZMHPn?=
 =?us-ascii?Q?biAAgHh27fOpTiTswQSRU049FlE58APuFnWKV7hIFrOBvJymO8bV/UQzUFu1?=
 =?us-ascii?Q?KMKaKJql16RHbSSHcuifecS8GxSVtTARn6fNzoJy1c/vChkTGb/b+72C0jr4?=
 =?us-ascii?Q?j31VzHu2/a6Ap9i7flROCt0XKy6HwzGQJNN/NvS09fEOWUH1I6nDlJ2y1cFF?=
 =?us-ascii?Q?42x18r1gGLcE/BFhAPrBXYZ/mrmMTsLwH7tlkKI9+WcfUXID20mPxsN88old?=
 =?us-ascii?Q?sl6P0c8bmSOXcAKGOpNRlWTjsG6cg88ZpXAAMt9BqYQCf3A/uIpNE+9Cw5PD?=
 =?us-ascii?Q?jmU/46dQwPMFfhRs4QrcPqy4aFfK1R6Xy2Knlr16lxhDhfR3LHG3FDyMf3fc?=
 =?us-ascii?Q?UOZU1qZpyK9WfnDVTASivANIRy3d0XkHC+pxraaFgq3HaXK7emVeuBt3Dwo4?=
 =?us-ascii?Q?BbFFaPk/d2c9oJH4F+U0p8yw5NMbdl4qyCN9A/14NX/TdrHaiu55f4YaLPoM?=
 =?us-ascii?Q?imiyXkVCCmyphdjthCajzD3HpHIWwk7cBQrkXdEQ77Hme65ckJJVr11jOdCA?=
 =?us-ascii?Q?4pOGDDKblybL8f6ch9elg7Cibj0xdlpDtcj+u5cmdLvsHSIkIpLd99APP+Lp?=
 =?us-ascii?Q?6ToSTorJOo6mLZIO7jgHfD5F7XrFc6XM5CnHqI+Q0XPd3nRhpZ0OqXarzm4f?=
 =?us-ascii?Q?32PE8PUVS2tAGxpA3QoHTAa3NtDHXxXRQBJ+i1L3uLWP11zhvGS/x1JaHaSZ?=
 =?us-ascii?Q?5/wmJW31sJl15yBhvmZ2J9oljBpePI7Wo938toADIL2fUzO3j1NB4f+F04/8?=
 =?us-ascii?Q?MmJFqnN9U2Ig2rMBBaZjADKmfQIBGV89z02gJ4EVq4602bJmJcxyYJL7Iwnb?=
 =?us-ascii?Q?L2cX+i4e04i4SC3DZI1hx9h72F/tw+rbKOK8JbvxD7SOb0vJ5Gsdtj3KY18D?=
 =?us-ascii?Q?Sw+150gA1Cp95qbTAqocMrJKbHKTqO4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d2c34e-de5d-4648-4b00-08da37fcbe2a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:59:48.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MAwyqtxeub5+T+sanQgmQxgrCRXR9A7nRtEfHYiLlySHB62fFTcyCLUKVRZfHRFXR5s/KbdCh52Uq3KpnGNAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5694
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_02:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170072
X-Proofpoint-ORIG-GUID: lUc_7G4fGqkB1oLP_1vl4y5Ql-fzyzYn
X-Proofpoint-GUID: lUc_7G4fGqkB1oLP_1vl4y5Ql-fzyzYn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tests load/attach bpf prog with maps, perfbuf and ringbuf, pinning
them.  Then effective caps are dropped and we verify we can

- pick up the pin
- create ringbuf/perfbuf
- get ringbuf/perfbuf events, carry out map update, lookup and delete
- create a link

Negative testing also ensures

- BPF prog load fails
- BPF map create fails
- get fd by id fails
- get next id fails
- query fails
- BTF load fails

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/prog_tests/unpriv_bpf_disabled.c      | 308 ++++++++++++++++++
 .../bpf/progs/test_unpriv_bpf_disabled.c      |  83 +++++
 2 files changed, 391 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c

diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
new file mode 100644
index 000000000000..7c58c4f7ecc7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "test_unpriv_bpf_disabled.skel.h"
+
+#include "cap_helpers.h"
+
+#define ADMIN_CAPS (1ULL << CAP_SYS_ADMIN |	\
+		    1ULL << CAP_NET_ADMIN |	\
+		    1ULL << CAP_PERFMON |	\
+		    1ULL << CAP_BPF)
+
+#define PINPATH		"/sys/fs/bpf/unpriv_bpf_disabled_"
+
+struct test_unpriv_bpf_disabled *skel;
+__u32 prog_id;
+int prog_fd;
+int perf_fd;
+char *map_paths[7] =	{ PINPATH "array",
+			  PINPATH "percpu_array",
+			  PINPATH "hash",
+			  PINPATH "percpu_hash",
+			  PINPATH "perfbuf",
+			  PINPATH "ringbuf",
+			  PINPATH "prog_array" };
+int map_fds[7];
+
+static __u32 got_perfbuf_val;
+static __u32 got_ringbuf_val;
+
+static int process_ringbuf(void *ctx, void *data, size_t len)
+{
+	if (len == sizeof(__u32))
+		got_ringbuf_val = *(__u32 *)data;
+	return 0;
+}
+
+static void process_perfbuf(void *ctx, int cpu, void *data, __u32 len)
+{
+	if (len == sizeof(__u32))
+		got_perfbuf_val = *(__u32 *)data;
+}
+
+static int sysctl_set(const char *sysctl_path, char *old_val, const char *new_val)
+{
+	int ret = 0;
+	FILE *fp;
+
+	fp = fopen(sysctl_path, "r+");
+	if (!fp)
+		return -errno;
+	if (old_val && fscanf(fp, "%s", old_val) <= 0) {
+		ret = -ENOENT;
+	} else if (!old_val || strcmp(old_val, new_val) != 0) {
+		fseek(fp, 0, SEEK_SET);
+		if (fprintf(fp, "%s", new_val) < 0)
+			ret = -errno;
+	}
+	fclose(fp);
+
+	return ret;
+}
+
+static void test_unpriv_bpf_disabled_positive(void)
+{
+	struct perf_buffer *perfbuf = NULL;
+	struct ring_buffer *ringbuf = NULL;
+	int i, nr_cpus, link_fd = -1;
+
+	nr_cpus = bpf_num_possible_cpus();
+
+	skel->bss->perfbuf_val = 1;
+	skel->bss->ringbuf_val = 2;
+
+	/* Positive tests for unprivileged BPF disabled. Verify we can
+	 * - retrieve and interact with pinned maps;
+	 * - set up and interact with perf buffer;
+	 * - set up and interact with ring buffer;
+	 * - create a link
+	 */
+	perfbuf = perf_buffer__new(bpf_map__fd(skel->maps.perfbuf), 8, process_perfbuf, NULL, NULL,
+				   NULL);
+	if (!ASSERT_OK_PTR(perfbuf, "perf_buffer__new"))
+		goto cleanup;
+
+	ringbuf = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf), process_ringbuf, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup;
+
+	/* trigger & validate perf event, ringbuf output */
+	usleep(1);
+
+	ASSERT_GT(perf_buffer__poll(perfbuf, 100), -1, "perf_buffer__poll");
+
+	ASSERT_EQ(got_perfbuf_val, skel->bss->perfbuf_val, "check_perfbuf_val");
+
+	ASSERT_EQ(ring_buffer__consume(ringbuf), 1, "ring_buffer__consume");
+
+	ASSERT_EQ(got_ringbuf_val, skel->bss->ringbuf_val, "check_ringbuf_val");
+
+	for (i = 0; i < ARRAY_SIZE(map_fds); i++) {
+		map_fds[i] = bpf_obj_get(map_paths[i]);
+		if (!ASSERT_GT(map_fds[i], -1, "obj_get"))
+			goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(map_fds); i++) {
+		bool prog_array = strstr(map_paths[i], "prog_array") != NULL;
+		bool array = strstr(map_paths[i], "array") != NULL;
+		bool buf = strstr(map_paths[i], "buf") != NULL;
+		__u32 key = 0, vals[nr_cpus], lookup_vals[nr_cpus];
+		__u32 expected_val = 1;
+		int j;
+
+		/* skip ringbuf, perfbuf */
+		if (buf)
+			continue;
+
+		for (j = 0; j < nr_cpus; j++)
+			vals[j] = expected_val;
+
+		if (prog_array) {
+			/* need valid prog array value */
+			vals[0] = prog_fd;
+			/* prog array lookup returns prog id, not fd */
+			expected_val = prog_id;
+		}
+		ASSERT_OK(bpf_map_update_elem(map_fds[i], &key, vals, 0), "map_update_elem");
+		ASSERT_OK(bpf_map_lookup_elem(map_fds[i], &key, &lookup_vals), "map_lookup_elem");
+		ASSERT_EQ(lookup_vals[0], expected_val, "map_lookup_elem_values");
+		if (!array)
+			ASSERT_OK(bpf_map_delete_elem(map_fds[i], &key), "map_delete_elem");
+	}
+
+	link_fd = bpf_link_create(bpf_program__fd(skel->progs.handle_perf_event), perf_fd,
+				  BPF_PERF_EVENT, NULL);
+	ASSERT_GT(link_fd, 0, "link_create");
+
+cleanup:
+	if (link_fd)
+		close(link_fd);
+	if (perfbuf)
+		perf_buffer__free(perfbuf);
+	if (ringbuf)
+		ring_buffer__free(ringbuf);
+}
+
+static void test_unpriv_bpf_disabled_negative(void)
+{
+	const struct bpf_insn prog_insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	const size_t prog_insn_cnt = sizeof(prog_insns) / sizeof(struct bpf_insn);
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts);
+	struct bpf_map_info map_info = {};
+	__u32 map_info_len = sizeof(map_info);
+	struct bpf_link_info link_info = {};
+	__u32 link_info_len = sizeof(link_info);
+	struct btf *btf = NULL;
+	__u32 attach_flags = 0;
+	__u32 prog_ids[3] = {};
+	__u32 prog_cnt = 3;
+	__u32 next;
+	int i;
+
+	/* Negative tests for unprivileged BPF disabled.  Verify we cannot
+	 * - load BPF programs;
+	 * - create BPF maps;
+	 * - get a prog/map/link fd by id;
+	 * - get next prog/map/link id
+	 * - query prog
+	 * - BTF load
+	 */
+	ASSERT_EQ(bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "simple_prog", "GPL",
+				prog_insns, prog_insn_cnt, &load_opts),
+		  -EPERM, "prog_load_fails");
+
+	for (i = BPF_MAP_TYPE_HASH; i <= BPF_MAP_TYPE_BLOOM_FILTER; i++)
+		ASSERT_EQ(bpf_map_create(i, NULL, sizeof(int), sizeof(int), 1, NULL),
+			  -EPERM, "map_create_fails");
+
+	ASSERT_EQ(bpf_prog_get_fd_by_id(prog_id), -EPERM, "prog_get_fd_by_id_fails");
+	ASSERT_EQ(bpf_prog_get_next_id(prog_id, &next), -EPERM, "prog_get_next_id_fails");
+	ASSERT_EQ(bpf_prog_get_next_id(0, &next), -EPERM, "prog_get_next_id_fails");
+
+	if (ASSERT_OK(bpf_obj_get_info_by_fd(map_fds[0], &map_info, &map_info_len),
+		      "obj_get_info_by_fd")) {
+		ASSERT_EQ(bpf_map_get_fd_by_id(map_info.id), -EPERM, "map_get_fd_by_id_fails");
+		ASSERT_EQ(bpf_map_get_next_id(map_info.id, &next), -EPERM,
+			  "map_get_next_id_fails");
+	}
+	ASSERT_EQ(bpf_map_get_next_id(0, &next), -EPERM, "map_get_next_id_fails");
+
+	if (ASSERT_OK(bpf_obj_get_info_by_fd(bpf_link__fd(skel->links.sys_nanosleep_enter),
+					     &link_info, &link_info_len),
+		      "obj_get_info_by_fd")) {
+		ASSERT_EQ(bpf_link_get_fd_by_id(link_info.id), -EPERM, "link_get_fd_by_id_fails");
+		ASSERT_EQ(bpf_link_get_next_id(link_info.id, &next), -EPERM,
+			  "link_get_next_id_fails");
+	}
+	ASSERT_EQ(bpf_link_get_next_id(0, &next), -EPERM, "link_get_next_id_fails");
+
+	ASSERT_EQ(bpf_prog_query(prog_fd, BPF_PROG_TYPE_TRACING, 0, &attach_flags, prog_ids,
+				 &prog_cnt), -EPERM, "prog_query_fails");
+
+	btf = btf__new_empty();
+	if (ASSERT_OK_PTR(btf, "empty_btf") &&
+	    ASSERT_GT(btf__add_int(btf, "int", 4, 0), 0, "unpriv_int_type")) {
+		const void *raw_btf_data;
+		__u32 raw_btf_size;
+
+		raw_btf_data = btf__raw_data(btf, &raw_btf_size);
+		if (ASSERT_OK_PTR(raw_btf_data, "raw_btf_data_good"))
+			ASSERT_EQ(bpf_btf_load(raw_btf_data, raw_btf_size, NULL), -EPERM,
+				  "bpf_btf_load_fails");
+	}
+	btf__free(btf);
+}
+
+void test_unpriv_bpf_disabled(void)
+{
+	char unprivileged_bpf_disabled_orig[32] = {};
+	char perf_event_paranoid_orig[32] = {};
+	struct bpf_prog_info prog_info = {};
+	__u32 prog_info_len = sizeof(prog_info);
+	struct perf_event_attr attr = {};
+	__u64 save_caps = 0;
+	int i, ret;
+
+	skel = test_unpriv_bpf_disabled__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->test_pid = getpid();
+
+	map_fds[0] = bpf_map__fd(skel->maps.array);
+	map_fds[1] = bpf_map__fd(skel->maps.percpu_array);
+	map_fds[2] = bpf_map__fd(skel->maps.hash);
+	map_fds[3] = bpf_map__fd(skel->maps.percpu_hash);
+	map_fds[4] = bpf_map__fd(skel->maps.perfbuf);
+	map_fds[5] = bpf_map__fd(skel->maps.ringbuf);
+	map_fds[6] = bpf_map__fd(skel->maps.prog_array);
+
+	for (i = 0; i < ARRAY_SIZE(map_fds); i++)
+		ASSERT_OK(bpf_obj_pin(map_fds[i], map_paths[i]), "pin map_fd");
+
+	/* allow user without caps to use perf events */
+	if (!ASSERT_OK(sysctl_set("/proc/sys/kernel/perf_event_paranoid", perf_event_paranoid_orig,
+				  "-1"),
+		       "set_perf_event_paranoid"))
+		goto cleanup;
+	/* ensure unprivileged bpf disabled is set */
+	ret = sysctl_set("/proc/sys/kernel/unprivileged_bpf_disabled",
+			 unprivileged_bpf_disabled_orig, "2");
+	if (ret == -EPERM) {
+		/* if unprivileged_bpf_disabled=1, we get -EPERM back; that's okay. */
+		if (!ASSERT_OK(strcmp(unprivileged_bpf_disabled_orig, "1"),
+			       "unpriviliged_bpf_disabled_on"))
+			goto cleanup;
+	} else {
+		if (!ASSERT_OK(ret, "set unpriviliged_bpf_disabled"))
+			goto cleanup;
+	}
+
+	prog_fd = bpf_program__fd(skel->progs.sys_nanosleep_enter);
+	ASSERT_OK(bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len),
+		  "obj_get_info_by_fd");
+	prog_id = prog_info.id;
+	ASSERT_GT(prog_id, 0, "valid_prog_id");
+
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_CPU_CLOCK;
+	attr.freq = 1;
+	attr.sample_freq = 1000;
+	perf_fd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+	if (!ASSERT_GE(perf_fd, 0, "perf_fd"))
+		goto cleanup;
+
+	if (!ASSERT_OK(test_unpriv_bpf_disabled__attach(skel), "skel_attach"))
+		goto cleanup;
+
+	if (!ASSERT_OK(cap_disable_effective(ADMIN_CAPS, &save_caps), "disable caps"))
+		goto cleanup;
+
+	if (test__start_subtest("unpriv_bpf_disabled_positive"))
+		test_unpriv_bpf_disabled_positive();
+
+	if (test__start_subtest("unpriv_bpf_disabled_negative"))
+		test_unpriv_bpf_disabled_negative();
+
+cleanup:
+	close(perf_fd);
+	if (save_caps)
+		cap_enable_effective(save_caps, NULL);
+	if (strlen(perf_event_paranoid_orig) > 0)
+		sysctl_set("/proc/sys/kernel/perf_event_paranoid", NULL, perf_event_paranoid_orig);
+	if (strlen(unprivileged_bpf_disabled_orig) > 0)
+		sysctl_set("/proc/sys/kernel/unprivileged_bpf_disabled", NULL,
+			   unprivileged_bpf_disabled_orig);
+	for (i = 0; i < ARRAY_SIZE(map_paths); i++)
+		unlink(map_paths[i]);
+	test_unpriv_bpf_disabled__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c
new file mode 100644
index 000000000000..fc423e43a3cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+__u32 perfbuf_val = 0;
+__u32 ringbuf_val = 0;
+
+int test_pid;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} percpu_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} percpu_hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+} perfbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 1 << 12);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int sys_nanosleep_enter(void *ctx)
+{
+	int cur_pid;
+
+	cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (cur_pid != test_pid)
+		return 0;
+
+	bpf_perf_event_output(ctx, &perfbuf, BPF_F_CURRENT_CPU, &perfbuf_val, sizeof(perfbuf_val));
+	bpf_ringbuf_output(&ringbuf, &ringbuf_val, sizeof(ringbuf_val), 0);
+
+	return 0;
+}
+
+SEC("perf_event")
+int handle_perf_event(void *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.27.0

