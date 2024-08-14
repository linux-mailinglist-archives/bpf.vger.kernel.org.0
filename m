Return-Path: <bpf+bounces-37196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1D095211E
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 19:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CBB1C20E85
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9261BBBFC;
	Wed, 14 Aug 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q4fzSCY/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC51B3F32;
	Wed, 14 Aug 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656632; cv=none; b=Wy9mg5BoVRuFL/mEoGq90TmOKr/Qfp3EQy8kJGHa9IbiqTUiYXXxyUrBhR70nrbaP6qBxEJxTxYIl0h/acRilnaF07CnVj1QaDzdbLBLmkCTT386/W2L1gmhJmWhzlutVkSblegBvH8dyVTY/NXaatKLyPkhPA9QYY5PNZ/cV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656632; c=relaxed/simple;
	bh=UQRi+Eq75+r0FEjzrp7XGdy6GZs8YcZYKPW5WDTPIP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqjMptGnZ4PxUOhg+0wH4K4RxrcUOclNi4ubG3XTXaEKwsgG/PkaVZr8EmrqRGvoGtJxduj1Kifx2mTmsPEGEfi8nKGemp0xa9ugIrTYYRQeGvtK5LRvEdpaSpL3MJ/0p3Vpy+S6cmaSluGyScFI8OOBJGHTE0TnqkbW5mmg+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q4fzSCY/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ECxSln024899;
	Wed, 14 Aug 2024 17:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=BlFGy/2SCN8UWu7KmR8yFNPLtO
	i3t6/dps1K+bIWWLE=; b=Q4fzSCY/qYnL5dcsL6zsqTXv/B2RZjMnrmqJraQHot
	u30SMGAHlhgs3I6lYm5rrXGlszsrHJopLfjFG9rVVWtK/Q6M7plppPDL8CO5cNpy
	gR6gwiO09ismXEhtO8TrWZPcPHebKzqYpEZp/ohFtF8JtazpxL82zDCojfh8vpSd
	kaL9cE6xWW+GoVRjuRdpCBpepe/PMzOcHIxUF3wNvTUkUDUubuTofRnQJDVir3uG
	IXu3t+6uEvCfJALk7ypJabv+RhwjzHNvn/lXdHcfLw8ziu/82pMe9zoRBhZEFnqa
	HkzliOrwsYYQySGuQi9rkm7LZgNF/tcbwxKs5luNhgGA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410w2s17n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 17:30:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47EHPxqY015785;
	Wed, 14 Aug 2024 17:30:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410w2s17n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 17:30:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47EGeoew010102;
	Wed, 14 Aug 2024 17:30:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xjx0tqey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 17:30:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47EHULPB55181634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 17:30:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1A0A2004D;
	Wed, 14 Aug 2024 17:30:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C309F2004B;
	Wed, 14 Aug 2024 17:30:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 Aug 2024 17:30:21 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 9A32EE020C; Wed, 14 Aug 2024 19:30:21 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Brian Norris <briannorris@chromium.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] tools build: Provide consistent build options for fixdep
Date: Wed, 14 Aug 2024 19:30:21 +0200
Message-ID: <20240814173021.3726785-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 61_HCH9tAI2i67dm6--2K0XAgniARvvQ
X-Proofpoint-ORIG-GUID: e44MgMllBYv-EoZlIVWj-LWWbCf1uQZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_13,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=766 clxscore=1011
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140117

The fixdep binary is being compiled and linked in one step since commit
ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues").
While the host linker flags are passed to the compiler the host compiler
flags are missed.

That might lead to failures as result of the compiler vs linker flags
inconsistency. For example, during RPM package build redhat-hardened-ld
script is provided to gcc, while redhat-hardened-cc1 script is missed.
That leads to an error on s390:

/usr/bin/ld: /tmp/ccUT8Rdm.o: `stderr@@GLIBC_2.2' non-PLT reloc for
symbol defined in shared library and accessed from executable (rebuild
file with -fPIC ?)

Provide both KBUILD_HOSTCFLAGS and KBUILD_HOSTLDFLAGS to avoid that.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---

This patch is against kernel-next next-20240814 tag

---
 tools/build/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index fea3cf647f5b..18ad131f6ea7 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -44,4 +44,4 @@ ifneq ($(wildcard $(TMP_O)),)
 endif
 
 $(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
-	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
+	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTCFLAGS) $(KBUILD_HOSTLDFLAGS) -o $@ $<
-- 
2.43.0


