Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F2264AD1
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIJROK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 13:14:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726812AbgIJROH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 13:14:07 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AH28vS167066;
        Thu, 10 Sep 2020 13:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PDC571w87Q9Qr450a/fXFYYAGppxHPQlwSRJYCDCL5M=;
 b=UOzOUEQkARpKXppZ3Ts9EUYU0gcU6Wx7IsXcNLE8S+qgItD2BPDZVd6jUu44LDIlRq1t
 4MxcN3sL88jkUb0Udm2VmXy7XcOCQFiwg2SHzEG7/vYaM+DIzCKyUOHx8REGpAq/BroR
 eCPmczwrVl4DZ16JwkZRrbWenuG+9uBcddfLv3tEiiMgQ6az0DF3lYTdE0H2mX9oyWDa
 7pthEaJYYCkshedyGdIFhcSkGFxOKi3O2MbQ4HNB/oUaw7TzuxO87zWW0B7d4vg7VCBv
 d6+ArIryH9AtNzN3cakWVL5NGkV/NhHV2YmfpL42Ci03D1fRcomfBnfHTUcoz59Gi7tp Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33fqngsgb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 13:13:44 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08AH2BUr167570;
        Thu, 10 Sep 2020 13:13:44 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33fqngsga9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 13:13:44 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AHCobU023108;
        Thu, 10 Sep 2020 17:13:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8ea93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 17:13:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08AHDdo432768364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 17:13:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6674CA4060;
        Thu, 10 Sep 2020 17:13:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F40FCA405C;
        Thu, 10 Sep 2020 17:13:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Sep 2020 17:13:38 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix test_ksyms on non-SMP kernels
Date:   Thu, 10 Sep 2020 19:13:36 +0200
Message-Id: <20200910171336.3161995-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_05:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100153
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On non-SMP kernels __per_cpu_start is not 0, so look it up in kallsyms.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/ksyms.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
index e3d6777226a8..b771804b2342 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -32,6 +32,7 @@ static __u64 kallsyms_find(const char *sym)
 
 void test_ksyms(void)
 {
+	__u64 per_cpu_start_addr = kallsyms_find("__per_cpu_start");
 	__u64 link_fops_addr = kallsyms_find("bpf_link_fops");
 	const char *btf_path = "/sys/kernel/btf/vmlinux";
 	struct test_ksyms *skel;
@@ -63,8 +64,9 @@ void test_ksyms(void)
 	      "got %llu, exp %llu\n", data->out__bpf_link_fops1, (__u64)0);
 	CHECK(data->out__btf_size != btf_size, "btf_size",
 	      "got %llu, exp %llu\n", data->out__btf_size, btf_size);
-	CHECK(data->out__per_cpu_start != 0, "__per_cpu_start",
-	      "got %llu, exp %llu\n", data->out__per_cpu_start, (__u64)0);
+	CHECK(data->out__per_cpu_start != per_cpu_start_addr, "__per_cpu_start",
+	      "got %llu, exp %llu\n", data->out__per_cpu_start,
+	      per_cpu_start_addr);
 
 cleanup:
 	test_ksyms__destroy(skel);
-- 
2.25.4

