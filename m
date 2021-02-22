Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203DC3221CE
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 22:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBVVwA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 16:52:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230036AbhBVVvy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 16:51:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MLWnFY055687;
        Mon, 22 Feb 2021 16:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LdQjBxiBEfX4ISPxbw0y5isinbz7JKfl/P2vfImbupE=;
 b=qLzqmRg6HUX2WLhG3kSeal2Im6OV25RwKev0nIKM0pES4N8nXq9FY9a4JbY4GFsMYn9w
 GNzSyDo22s042SNiYgPxc3/bvPq5ZsDdbGDHSwhq4fpHq4sC+LdYkW55UBVO0HBUT3pI
 mVrSPIDOQ3M5M0wUC1sZiENU80jV7GJJIgfJnjpI/RY2vdjs/u7faqEvF9icLqwPZ/gq
 KP6hYbjMsUYb+EvkRIyseratq/bDxPgUiufIjbDCEl64H+KTTODfTfN7wnS0i/dSEtyO
 R+16YCo402sEBw5w/k+Y9OnpQwrorW+SVpAGgh1+Wfw/2NOw064mBTha1e4celtKhJOW gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkehuhhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:51:01 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MLZLrn073268;
        Mon, 22 Feb 2021 16:51:00 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkehuhh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:51:00 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MLmKmx016366;
        Mon, 22 Feb 2021 21:50:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt28a1f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 21:50:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MLotRM39453084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:50:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0768A404D;
        Mon, 22 Feb 2021 21:50:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BB85A4051;
        Mon, 22 Feb 2021 21:50:55 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 21:50:55 +0000 (GMT)
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
Subject: [PATCH v4 bpf-next 3/7] tools/bpftool: Add BTF_KIND_FLOAT support
Date:   Mon, 22 Feb 2021 22:49:13 +0100
Message-Id: <20210222214917.83629-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210222214917.83629-1-iii@linux.ibm.com>
References: <20210222214917.83629-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_07:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220187
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

