Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4FB315DB2
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhBJDFC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:05:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233471AbhBJDE6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 22:04:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11A32oDn056558;
        Tue, 9 Feb 2021 22:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wdOsSeXYSC9rEIu92RkHBsJfcy8hQOazKkhx58y2kTc=;
 b=mcnmhqPLxXBAhcIvi1WiL/kukDGAKQeGsBId80RvfAd27ONFyv3IRwFXjD7WjxlVsLsW
 YA5AiYVrdSJy7qMmzh378WMjUkdSUxh8mlxloPzqYD4i2d26wkcK1QOWtYSyYxzxIAoz
 A7sfytX5GVVCIN2G26/DfZx4pm1506Sv58ZJqRHRdPiXTum/9o87jnM1GpQmqVrKbM7f
 5E6wj6H8yUi6erVTH4nkaqvSK0QngDuSmKSIBtVFwcv4GCctexWPk63D7taS7S335Fz/
 4PiKMHv+TFJbFfH1dcr+3gzqIF0KCJ994WkDB1YDJDcWJeqfvSWlFhFbn6wP9Rxg1AKh 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36m6k7gveh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:03:56 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11A33mnl062123;
        Tue, 9 Feb 2021 22:03:55 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36m6k7gvd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:03:55 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11A33EeI022899;
        Wed, 10 Feb 2021 03:03:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 36j94wkej4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 03:03:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11A33nwb34275794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 03:03:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9D34A4059;
        Wed, 10 Feb 2021 03:03:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E259A4055;
        Wed, 10 Feb 2021 03:03:49 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 03:03:49 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC 3/6] tools/bpftool: Add BTF_KIND_FLOAT support
Date:   Wed, 10 Feb 2021 04:03:14 +0100
Message-Id: <20210210030317.78820-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210210030317.78820-1-iii@linux.ibm.com>
References: <20210210030317.78820-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100031
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Only dumping support needs to be adjusted, the code structure follows
that of BTF_KIND_INT.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/bpf/bpftool/btf.c        | 13 +++++++++++++
 tools/bpf/bpftool/btf_dumper.c |  1 +
 2 files changed, 14 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index fe9e7b3a4b50..7e72527b0409 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -36,6 +36,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
 	[BTF_KIND_VAR]		= "VAR",
 	[BTF_KIND_DATASEC]	= "DATASEC",
+	[BTF_KIND_FLOAT]	= "FLOAT",
 };
 
 struct btf_attach_table {
@@ -327,6 +328,18 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 			jsonw_end_array(w);
 		break;
 	}
+	case BTF_KIND_FLOAT: {
+		__u32 v = *(__u32 *)(t + 1);
+
+		if (json_output) {
+			jsonw_uint_field(w, "size", t->size);
+			jsonw_uint_field(w, "nr_bits", BTF_FLOAT_BITS(v));
+		} else {
+			printf(" size=%u nr_bits=%u",
+			       t->size, BTF_FLOAT_BITS(v));
+		}
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

