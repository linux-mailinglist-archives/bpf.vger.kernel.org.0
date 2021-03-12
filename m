Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1019C338210
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 01:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCLAIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 19:08:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230523AbhCLAIf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Mar 2021 19:08:35 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12C03wls150673;
        Thu, 11 Mar 2021 19:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PEinIIkK0AlmllevoPWCsFyWrim3Zppkk1Vjw8/5rGU=;
 b=N2uj4fZxef2RrzreV3/zFwGAYtPkki7COspXdhZQDRwZ6mg6kve2KckT7qGgAg+zK18n
 mN2qw75Hc+zyt7MXWlCzIBVtdx6fd9wfpeLaXJaeWGShBNv2pwyB4R6k1KzK3cCmnHTF
 r9KO00E5WHINQcIFhfCgpJ8688pW9MdGpQrYVnJUmqVYDyDge1ADwJo1t4719kl8Ds6H
 7sSwMPimzh+gNoPjNAAYutqwO6yozZfYVApl+CWes6YFNXWLxPGL1/zSBAB64cSvT4B2
 cpCVKc8gXQei21xHIXYCWEzpuZvPzcRASy3cV2azZyc1IPQVFpdD3pMu41UfTakJPEB5 BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m46qxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 19:08:18 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12C041JX150896;
        Thu, 11 Mar 2021 19:08:18 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m46qwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 19:08:18 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12C07XPg004939;
        Fri, 12 Mar 2021 00:08:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3768urtbar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 00:08:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12C08Dpc19202350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 00:08:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7DD5A405B;
        Fri, 12 Mar 2021 00:08:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65A48A4054;
        Fri, 12 Mar 2021 00:08:12 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Mar 2021 00:08:12 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH dwarves] btf: Add --btf_gen_all flag
Date:   Fri, 12 Mar 2021 01:08:08 +0100
Message-Id: <20210312000808.175262-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_12:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=995 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103110132
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

By default, pahole makes use only of BTF features introduced with
kernel v5.2. Features that are added later need to be turned on with
explicit feature flags, such as --btf_gen_floats. According to [1],
this will hinder the people who generate BTF for kernels externally
(e.g. for old kernels to support BPF CO-RE).

Introduce --btf_gen_all that allows using all BTF features supported
by pahole.

[1] https://lore.kernel.org/dwarves/CAEf4Bzbyugfb2RkBkRuxNGKwSk40Tbq4zAvhQT8W=fVMYWuaxA@mail.gmail.com/

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 man-pages/pahole.1 | 4 ++++
 pahole.c           | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index e292b2c..cbbefbf 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -204,6 +204,10 @@ to "/sys/kernel/btf/vmlinux".
 Allow producing BTF_KIND_FLOAT entries in systems where the vmlinux DWARF
 information has float types.
 
+.TP
+.B \-\-btf_gen_all
+Allow using all the BTF features supported by pahole.
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.
diff --git a/pahole.c b/pahole.c
index c8d38f5..df6aa83 100644
--- a/pahole.c
+++ b/pahole.c
@@ -826,6 +826,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_numeric_version       320
 #define ARGP_btf_base		   321
 #define ARGP_btf_gen_floats	   322
+#define ARGP_btf_gen_all	   323
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1125,6 +1126,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_btf_gen_floats,
 		.doc  = "Allow producing BTF_KIND_FLOAT entries."
 	},
+	{
+		.name = "btf_gen_all",
+		.key  = ARGP_btf_gen_all,
+		.doc  = "Allow using all the BTF features supported by pahole."
+	},
 	{
 		.name = "structs",
 		.key  = ARGP_just_structs,
@@ -1262,6 +1268,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		print_numeric_version = true;		break;
 	case ARGP_btf_gen_floats:
 		btf_gen_floats = true;			break;
+	case ARGP_btf_gen_all:
+		btf_gen_floats = true;			break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.29.2

