Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0895D54
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 13:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfHTL3t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 07:29:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729421AbfHTL3t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Aug 2019 07:29:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KBRFmO002884
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 07:29:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugeg84hye-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 07:29:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 20 Aug 2019 12:29:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 12:29:42 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KBTfxO36896774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 11:29:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3545BA4051;
        Tue, 20 Aug 2019 11:29:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7D23A405B;
        Tue, 20 Aug 2019 11:29:40 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.160])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 11:29:40 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] btf: do not use CONFIG_OUTPUT_FORMAT
Date:   Tue, 20 Aug 2019 13:29:39 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082011-0020-0000-0000-00000361AB48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082011-0021-0000-0000-000021B6DBD7
Message-Id: <20190820112939.84249-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200121
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Building s390 kernel with CONFIG_DEBUG_INFO_BTF fails, because
CONFIG_OUTPUT_FORMAT is not defined. As a matter of fact, this variable
appears to be x86-only, so other arches might be affected as well.

Fix by obtaining this value from objdump output, just like it's already
done for bin_arch. The exact objdump invocation is "inspired" by
arch/powerpc/boot/wrapper.

Also, use LANG=C for the existing bin_arch objdump invocation to avoid
potential build issues on systems with non-English locale.

Fixes: 341dfcf8d78e ("btf: expose BTF info through sysfs")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 scripts/link-vmlinux.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c31193340108..0d8f41db8cd6 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -115,10 +115,12 @@ gen_btf()
 	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
 
 	# dump .BTF section into raw binary file to link with final vmlinux
-	bin_arch=$(${OBJDUMP} -f ${1} | grep architecture | \
+	bin_arch=$(LANG=C ${OBJDUMP} -f ${1} | grep architecture | \
 		cut -d, -f1 | cut -d' ' -f2)
+	bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
+		awk '{print $4}')
 	${OBJCOPY} --dump-section .BTF=.btf.vmlinux.bin ${1} 2>/dev/null
-	${OBJCOPY} -I binary -O ${CONFIG_OUTPUT_FORMAT} -B ${bin_arch} \
+	${OBJCOPY} -I binary -O ${bin_format} -B ${bin_arch} \
 		--rename-section .data=.BTF .btf.vmlinux.bin ${2}
 }
 
-- 
2.21.0

