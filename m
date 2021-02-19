Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8231F405
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 03:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhBSC1b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 21:27:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhBSC1a (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 21:27:30 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11J24Tss168742;
        Thu, 18 Feb 2021 21:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d4Sv3eKVulC7T75pLD2Hjf0QGKr9FT0ufnwOCUntdZ0=;
 b=jXWm7gkDl+86HWVN5pC1cpkZVdXrobqmOfnN2Lym+zJ48fwX3HkLnUH75wWHHKoCYNdu
 U08aIWVhfP5J0N2H1/Vsc7emdRqVe0n9UUtJxiURFBEBobaYVF1QNoVnTIZz61i1DqSL
 ywxZlW0oPidLaAhbH/NuabXLIEQ6zwDOpVOc5+mKtyWIMIV8cKHWGtgbnBl5/Mlo6pAk
 ga/BjT/lOduWO/cahegF3iNrOAB8suqbpKKcsSi/PjUv5PQYEcdrOl+udymn/wmeRxzV
 xb7C+YgaIHDpdVH+iGwwp4U0DiRF1s0+PphiEpgsjFecH4GFsqHBoFfVQ+jdZnMOCnf7 xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t3fuh9m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:36 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11J2Krwl039582;
        Thu, 18 Feb 2021 21:26:36 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t3fuh9kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:36 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11J2MJU1003634;
        Fri, 19 Feb 2021 02:26:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 36p6d8d6cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:26:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11J2QJhs28443052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 02:26:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D7B7A404D;
        Fri, 19 Feb 2021 02:26:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 901CBA4040;
        Fri, 19 Feb 2021 02:26:30 +0000 (GMT)
Received: from vm.lan (unknown [9.145.178.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 02:26:30 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next 3/6] tools/bpftool: Add BTF_KIND_FLOAT support
Date:   Fri, 19 Feb 2021 03:25:40 +0100
Message-Id: <20210219022543.20893-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219022543.20893-1-iii@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190011
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Only dumping support needs to be adjusted, the code structure follows
that of BTF_KIND_INT.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/bpf/bpftool/btf.c        | 8 ++++++++
 tools/bpf/bpftool/btf_dumper.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index fe9e7b3a4b50..985610c3f193 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -36,6 +36,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
 	[BTF_KIND_VAR]		= "VAR",
 	[BTF_KIND_DATASEC]	= "DATASEC",
+	[BTF_KIND_FLOAT]	= "FLOAT",
 };
 
 struct btf_attach_table {
@@ -327,6 +328,13 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 			jsonw_end_array(w);
 		break;
 	}
+	case BTF_KIND_FLOAT: {
+		if (json_output)
+			jsonw_uint_field(w, "size", t->size);
+		else
+			printf(" size=%u", t->size);
+		break;
+	}
 	default:
 		break;
 	}
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 0e9310727281..7ca54d046362 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -596,6 +596,7 @@ static int __btf_dumper_type_only(const struct btf *btf, __u32 type_id,
 	switch (BTF_INFO_KIND(t->info)) {
 	case BTF_KIND_INT:
 	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_FLOAT:
 		BTF_PRINT_ARG("%s ", btf__name_by_offset(btf, t->name_off));
 		break;
 	case BTF_KIND_STRUCT:
-- 
2.29.2

