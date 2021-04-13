Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9F835E6C0
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347894AbhDMTBb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 15:01:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40252 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230397AbhDMTBa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 15:01:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DIWdZr191542;
        Tue, 13 Apr 2021 15:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=LUStBOqhkFroVcj4oRoT0Yt+1VDfQvnw8+F9s7FvlhM=;
 b=K6BD7N6V8GDizVXXxNiRFwM78eNwTR3+n553DN/J4lORsokZ/cbAVtyw4udCRb6sX+07
 vZp2rHeMLC1rqVYAuCXSRX7OiYqCzDJVZGNWrSNlL7fV2dCPmrDeT83klWuUvT/BzyGV
 qSGVNqEL3ftAOzsTqNAyMrOWONteJ05KYEzv4vryv9+VeZz72t64M5RR8tuLirtJ5reV
 dNxX8Hsj33qlm3QXt7IAIubuNToROwE8N7XC/wS5dR9UsLsAymZAv+kWRTXq7xZtClMx
 pWS2MUavAyWmviNpMb8qaizv9QX44YuY/mgL/EHeGmqDXMpvqpn33v9wi5YyT0abkMuD rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37wetsber1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 15:00:50 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13DIWfZj191667;
        Tue, 13 Apr 2021 15:00:50 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37wetsbepp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 15:00:50 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13DIrLhu031216;
        Tue, 13 Apr 2021 19:00:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 37u3n8autx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 19:00:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13DJ0jRw55705920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 19:00:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55C6C11C04A;
        Tue, 13 Apr 2021 19:00:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D661511C04C;
        Tue, 13 Apr 2021 19:00:44 +0000 (GMT)
Received: from vm.lan (unknown [9.145.157.105])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 13 Apr 2021 19:00:44 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3] bpf: Generate BTF_KIND_FLOAT when linking vmlinux
Date:   Tue, 13 Apr 2021 21:00:43 +0200
Message-Id: <20210413190043.21918-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3iMKYcY1VBYG4e8XVjGIQkj9oHeo6d83
X-Proofpoint-ORIG-GUID: xfINGv4ptqTESxZ-SHj6UbCewewmBIiF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130124
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pahole v1.21 supports the --btf_gen_floats flag, which makes it
generate the information about the floating-point types [1].

Adjust link-vmlinux.sh to pass this flag to pahole in case it's
supported, which is determined using a simple version check.

[1] https://lore.kernel.org/dwarves/YHRiXNX1JUF2Az0A@kernel.org/

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---

v1:
https://lore.kernel.org/bpf/20210331014356.256212-1-iii@linux.ibm.com/
v1 -> v2: Use a version check instead of probing.

v2:
https://lore.kernel.org/bpf/20210412215629.17865-1-iii@linux.ibm.com/
v2 -> v3: Simplify extra_paholeopt handling (it's still useful to have
          "=" when declaring it to be "-u"-compliant, even though
          link-vmlinux.sh does not use this flag at the moment).

 scripts/link-vmlinux.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 3b261b0f74f0..667aacb9261c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -213,6 +213,7 @@ vmlinux_link()
 gen_btf()
 {
 	local pahole_ver
+	local extra_paholeopt=
 
 	if ! [ -x "$(command -v ${PAHOLE})" ]; then
 		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
@@ -227,8 +228,12 @@ gen_btf()
 
 	vmlinux_link ${1}
 
+	if [ "${pahole_ver}" -ge "121" ]; then
+		extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
+	fi
+
 	info "BTF" ${2}
-	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
+	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${extra_paholeopt} ${1}
 
 	# Create ${2} which contains just .BTF section but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
-- 
2.29.2

