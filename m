Return-Path: <bpf+bounces-392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331067006E0
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 13:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC21C211BF
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FAFD514;
	Fri, 12 May 2023 11:32:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3349BA56
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:32:49 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C358E738
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 04:32:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C8i19m029950;
	Fri, 12 May 2023 11:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=XSpTmG44m6Df+9MGM6DF2s7/rs/efBQAZMpER8iT6F8=;
 b=isFGXb61r6cf4lIEnVoXuCKX+nd6tt2eDPNHvQKzNrtX1Oydc5v3Dzf/I2CYHk6V+4BM
 WB960TZLEv9CVRgDXxlTRAfoflzxMn1dEMujujzPkXUmQwcFPwdMwBCuUZH8Y0SMsIT8
 y1qv9pwpgJEtd3boziTVjs3J8iaxEM+5suy0TjhDCFoCRUWxYFFY0i78lEqqTgJWfOjN
 3mDVOz0TUN/Y9TXe56/qu7CXh4JlEu94L2AN3MRywKm8EZ8as65rygUKrgmOIBhNls/M
 6sXlQU0m8drBqhz8dnjzbokSq1eulAXN1pTvEWnX2FoOzjhv4cxokPOqWvOEEYix8/+s vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776stgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 May 2023 11:32:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CArVfO024384;
	Fri, 12 May 2023 11:32:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y80kur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 May 2023 11:32:19 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CBWIb1035664;
	Fri, 12 May 2023 11:32:18 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-218-250.vpn.oracle.com [10.175.218.250])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qf7y80kt0-1;
	Fri, 12 May 2023 11:32:18 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: quentin@isovalent.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Nicky Veitch <nicky.veitch@oracle.com>
Subject: [PATCH bpf] tools: bpftool: JIT limited misreported as negative value on aarch64
Date: Fri, 12 May 2023 12:31:34 +0100
Message-Id: <20230512113134.58996-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120096
X-Proofpoint-ORIG-GUID: SOkR_1yAyXLSqQkJdSbz5gmnOVtfNzav
X-Proofpoint-GUID: SOkR_1yAyXLSqQkJdSbz5gmnOVtfNzav
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On aarch64, "bpftool feature" reports an incorrect BPF JIT limit:

$ sudo /sbin/bpftool feature
Scanning system configuration...
bpf() syscall restricted to privileged users
JIT compiler is enabled
JIT compiler hardening is disabled
JIT compiler kallsyms exports are enabled for root
skipping kernel config, can't open file: No such file or directory
Global memory limit for JIT compiler for unprivileged users is -201326592 bytes

This is because /proc/sys/net/core/bpf_jit_limit reports

$ sudo cat /proc/sys/net/core/bpf_jit_limit
68169519595520

...and an int is assumed in read_procfs().  Change read_procfs()
to return a long to avoid negative value reporting.

Fixes: 7a4522bbef0c ("tools: bpftool: add probes for /proc/ eBPF parameters")
Reported-by: Nicky Veitch <nicky.veitch@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/feature.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index da16e6a27ccc..0675d6a46413 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -167,12 +167,12 @@ static int get_vendor_id(int ifindex)
 	return strtol(buf, NULL, 0);
 }
 
-static int read_procfs(const char *path)
+static long read_procfs(const char *path)
 {
 	char *endptr, *line = NULL;
 	size_t len = 0;
 	FILE *fd;
-	int res;
+	long res;
 
 	fd = fopen(path, "r");
 	if (!fd)
@@ -194,7 +194,7 @@ static int read_procfs(const char *path)
 
 static void probe_unprivileged_disabled(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -216,14 +216,14 @@ static void probe_unprivileged_disabled(void)
 			printf("Unable to retrieve required privileges for bpf() syscall\n");
 			break;
 		default:
-			printf("bpf() syscall restriction has unknown value %d\n", res);
+			printf("bpf() syscall restriction has unknown value %ld\n", res);
 		}
 	}
 }
 
 static void probe_jit_enable(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -245,7 +245,7 @@ static void probe_jit_enable(void)
 			printf("Unable to retrieve JIT-compiler status\n");
 			break;
 		default:
-			printf("JIT-compiler status has unknown value %d\n",
+			printf("JIT-compiler status has unknown value %ld\n",
 			       res);
 		}
 	}
@@ -253,7 +253,7 @@ static void probe_jit_enable(void)
 
 static void probe_jit_harden(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -275,7 +275,7 @@ static void probe_jit_harden(void)
 			printf("Unable to retrieve JIT hardening status\n");
 			break;
 		default:
-			printf("JIT hardening status has unknown value %d\n",
+			printf("JIT hardening status has unknown value %ld\n",
 			       res);
 		}
 	}
@@ -283,7 +283,7 @@ static void probe_jit_harden(void)
 
 static void probe_jit_kallsyms(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -302,14 +302,14 @@ static void probe_jit_kallsyms(void)
 			printf("Unable to retrieve JIT kallsyms export status\n");
 			break;
 		default:
-			printf("JIT kallsyms exports status has unknown value %d\n", res);
+			printf("JIT kallsyms exports status has unknown value %ld\n", res);
 		}
 	}
 }
 
 static void probe_jit_limit(void)
 {
-	int res;
+	long res;
 
 	/* No support for C-style ouptut */
 
@@ -322,7 +322,7 @@ static void probe_jit_limit(void)
 			printf("Unable to retrieve global memory limit for JIT compiler for unprivileged users\n");
 			break;
 		default:
-			printf("Global memory limit for JIT compiler for unprivileged users is %d bytes\n", res);
+			printf("Global memory limit for JIT compiler for unprivileged users is %ld bytes\n", res);
 		}
 	}
 }
-- 
2.31.1


