Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA84532342D
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 00:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhBWXZJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 18:25:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233761AbhBWXQw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 18:16:52 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NN5GiP194018;
        Tue, 23 Feb 2021 18:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LdQjBxiBEfX4ISPxbw0y5isinbz7JKfl/P2vfImbupE=;
 b=RE0nouSBS49GoJUqt0lB5vKgWRyXsthEvnOj+47RyV+ZCauAC3IOPVOipIz8m/eQDn0F
 2Ci4ThQ5UrBk9rvi8y7GvhacIRD3HHliijHyBFPHUzM+ajDMaiP+Ls4Ee6cnGPnSZ5f1
 UU1yKDG3NSj9KffKkdbaByl6Ly/QqKebadnC1KAWvM1ak4ldyE9EI73Z3kAawIrOAYKq
 p7GvuxLnEqLz+EHjGM8CBdsWhGicY8OHg8+aDokhjjiYsCbSlhF2k2DSjAl3nOO2Ezhg
 Re7UxSlpa2imjSMgjq3m6U3gb9DiUvkLl+EXJTFSbIRE9bAGiHTbIsIvogXCr4nRYMao AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkn1ueka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 18:15:18 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11NNBPqM024315;
        Tue, 23 Feb 2021 18:15:18 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkn1uejr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 18:15:18 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NNCCD3015292;
        Tue, 23 Feb 2021 23:15:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt2831j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 23:15:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NNF11R18612504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 23:15:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC827A405B;
        Tue, 23 Feb 2021 23:15:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22C7AA405E;
        Tue, 23 Feb 2021 23:15:13 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Feb 2021 23:15:13 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 bpf-next 3/8] tools/bpftool: Add BTF_KIND_FLOAT support
Date:   Wed, 24 Feb 2021 00:14:54 +0100
Message-Id: <20210223231459.99664-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223231459.99664-1-iii@linux.ibm.com>
References: <20210223231459.99664-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_12:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230190
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Only dumping support needs to be adjusted, the code structure follows
that of BTF_KIND_INT. Example plain and JSON outputs:

    [4] FLOAT 'float' size=4
    {"id":4,"kind":"FLOAT","name":"float","size":4}

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

