Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5C35D2C7
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 23:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbhDLV5I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 17:57:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2644 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239164AbhDLV5H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 17:57:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CLX3vW175376;
        Mon, 12 Apr 2021 17:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=e0jWDVgJjP5zy6toAuB/kr1f6UA0JjgI4UtEmjMQFYU=;
 b=reoNjI/Glmmro3btAWCYZ6KN15WFb/b4oFHUVMbMavKAD1JGyEHFYGgtHhFgTJKupsqF
 x59GmBg5ghqflWSeWYri7hosHEq0pwgi0K44IuCmM1bXDDXq+GmaeUt39TzMPMUfrvJj
 O28ggeGIvwQ/BCWMeOzRC82HNVSBA6vEpiMHSAli6w/r66rnRyJPo5q2UyDCsMpODKGl
 VeLADTDm3wMgqoW7tFDurqYWH8QLok0BJC2EjG5qmtCQuUInKEBs9HxZzD2V6K3wE+9S
 79hJJDVDTvBYbDJvJQQGtyH/8/krh6HjeHHbVp/GvEbYpvhrAiQHXwD+fjhV5aXMIjup 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37uskadu2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 17:56:36 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13CLXZYa176234;
        Mon, 12 Apr 2021 17:56:35 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37uskadu24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 17:56:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CLs3XJ009566;
        Mon, 12 Apr 2021 21:56:33 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 37u3n8t59s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 21:56:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CLu9nV33358182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 21:56:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C209411C054;
        Mon, 12 Apr 2021 21:56:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B8B711C04C;
        Mon, 12 Apr 2021 21:56:30 +0000 (GMT)
Received: from vm.lan (unknown [9.145.157.105])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 21:56:30 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2] bpf: Generate BTF_KIND_FLOAT when linking vmlinux
Date:   Mon, 12 Apr 2021 23:56:29 +0200
Message-Id: <20210412215629.17865-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -w9VzTZB82RBU6DTxDkaPcaaXP0FZ9zm
X-Proofpoint-GUID: JpIM_WVpfmSh9QzqfhIjdASgOyuRSbAD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120139
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pahole v1.21 supports the --btf_gen_floats flag, which makes it
generate the information about the floating-point types [1].

Adjust link-vmlinux.sh to pass this flag to pahole in case it's
supported, which is determined using a simple version check.

[1] https://lore.kernel.org/dwarves/YHRiXNX1JUF2Az0A@kernel.org/

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 scripts/link-vmlinux.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 3b261b0f74f0..392c7fb94d3e 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -227,8 +227,13 @@ gen_btf()
 
 	vmlinux_link ${1}
 
+	local extra_paholeopt=
+	if [ "${pahole_ver}" -ge "121" ]; then
+		extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
+	fi
+
 	info "BTF" ${2}
-	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
+	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J${extra_paholeopt} ${1}
 
 	# Create ${2} which contains just .BTF section but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
-- 
2.29.2

