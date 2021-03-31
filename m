Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2233234F657
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 03:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhCaBod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 21:44:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233203AbhCaBoU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 21:44:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12V1Wq5H176186;
        Tue, 30 Mar 2021 21:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=j3zuO47NaPkhgbTMExGujZtX9fB4BfGpM2KE+klhFvc=;
 b=GFoT1sHEQAA2g10ffKxOHJ8Rb2ywtXy/mIPK3xEVjOkNluGjpF5Q9dddiVyiXFtNbn/B
 P3X/K1TjiVXb+kTXgWn91pKKQh8qUPxd70wSyHj8S/VpOV4kuLUwkjLC45PJRlKPAHoe
 9P03f6VSuEnb+n5LjQX19lQIPwMFKj864a2+1s28Yuc3C/2v4QY3XoajO637y+Jre5Ls
 +y56/Isp5s9p4x1mPe5WwTPfyJi/CVNaHVVVd6iB+DUzkAmc8v8zlJHDg/8zNQQrpsAk
 ZT8usGQft4Hl+6v21O1t9dmGVIGfcdHM12zcTGm2zS+wzG+cQXSEBx9QghMkeOsEL4uj Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mb9e5m27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 21:44:07 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12V1fkLC008054;
        Tue, 30 Mar 2021 21:44:07 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mb9e5m1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 21:44:06 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12V1i4aT024260;
        Wed, 31 Mar 2021 01:44:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 37mb22r51e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 01:44:04 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12V1hfcH27066836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 01:43:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC07A5205A;
        Wed, 31 Mar 2021 01:44:00 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7E96E52051;
        Wed, 31 Mar 2021 01:44:00 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] bpf: Generate BTF_KIND_FLOAT when linking vmlinux
Date:   Wed, 31 Mar 2021 03:43:56 +0200
Message-Id: <20210331014356.256212-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GgBHTwT3NpWOmsJYmASs-UWLDht1_FSB
X-Proofpoint-GUID: HSc3QSKkOuSMDOzbteaYIQ-oyeMAVjuu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_13:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=873 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310008
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pahole v1.21 will support the --btf_gen_floats flag, which makes it
generate the information about the floating-point types.

Adjust link-vmlinux.sh to pass this flag to pahole in case it's
supported. Whether or not this flag is supported is determined by
probing, which is chosen over version check for two reasons:

1) at this moment --btf_gen_floats exists only in master, which
   identifies itself as v1.20.
2) distros may backport features, making the version check too
   conservative.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 scripts/link-vmlinux.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 3b261b0f74f0..f4c763d2661d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -227,8 +227,13 @@ gen_btf()
 
 	vmlinux_link ${1}
 
+	local paholeopt=-J
+	if ${PAHOLE} --btf_gen_floats --help >/dev/null 2>&1; then
+		paholeopt="${paholeopt} --btf_gen_floats"
+	fi
+
 	info "BTF" ${2}
-	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
+	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} ${paholeopt} ${1}
 
 	# Create ${2} which contains just .BTF section but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
-- 
2.29.2

