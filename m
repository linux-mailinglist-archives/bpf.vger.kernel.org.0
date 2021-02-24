Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C139C32479C
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhBXXqu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:46:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233804AbhBXXqt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 18:46:49 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ONhxbL132406;
        Wed, 24 Feb 2021 18:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LdQjBxiBEfX4ISPxbw0y5isinbz7JKfl/P2vfImbupE=;
 b=mTHeGlFY8/Y58MJ9VPZV0/va5gqBvlnDKSVaWql5wEFlUDSH4blVUQrtfyPAQfippffV
 NqL7hbYluWEkj8QBucif/TOw3GYFgNYjlOCrXvzKfIo3uWUgmJwt80BRyMHirLKjq7Gb
 V/ooYSzR1ZOI1nHI4pXVz6E7/P4+Js0E5pU2vq55s/ImbTHrrTRoM2MUkQo3coxpomfj
 krJj/65VaIbpWKTZ7ETfyzH7CPlpnZEJxbKog7pMisbu1qgjzGxFwuC7ln1VMQttn1n5
 7A4teH0pa6LfA0Ea42NjRZYWpUxW1s4AksKDN6vmp/VoSIZaaoxrD31sVYUw23ZuhCak IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36x0qr813h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:55 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11ONjNWd135599;
        Wed, 24 Feb 2021 18:45:54 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36x0qr811e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:54 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ONgk8t002974;
        Wed, 24 Feb 2021 23:45:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt283xy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 23:45:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ONjaPC14287172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 23:45:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 544C242049;
        Wed, 24 Feb 2021 23:45:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D25114203F;
        Wed, 24 Feb 2021 23:45:48 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 23:45:48 +0000 (GMT)
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
Subject: [PATCH v6 bpf-next 4/9] tools/bpftool: Add BTF_KIND_FLOAT support
Date:   Thu, 25 Feb 2021 00:45:30 +0100
Message-Id: <20210224234535.106970-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224234535.106970-1-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240184
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

