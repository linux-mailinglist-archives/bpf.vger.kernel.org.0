Return-Path: <bpf+bounces-37251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC4B9529CC
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBF528212C
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 07:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD6F17AE05;
	Thu, 15 Aug 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c8+Xi9iA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900C179954;
	Thu, 15 Aug 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706457; cv=none; b=izzGRRUQfl3ry59QBGa3cm0TRFIX05ZOrComb1e3ZyzNm02L6lNecDbztishWLGAYHRlNLRVT7ZXxZPvR679vua/EtFPHVh4CZJAqdv5BdSwA7j9oK3ccpP/oSYVKMeITVNMfGY7jEY71qanqYwkhKzIRXk9ciDSaGsokxwb1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706457; c=relaxed/simple;
	bh=gkaaHYQmqifXD3EyqOYx9n8/LSNFTXTuxRZrsETEBjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UM4c+aA7p9YZXnJH4ubcUDc1xkXL7I40jvTBLINJ7RmM227avLwGeEeZjC7eCGehzckZp6BEthfJCSeguidxxfMg+qwP+kheXA6KJ36IopXjBVJJnIpUxpGBOR95IM5DhxXP24IcJSp8A4LsTE/ALLEPnBaIAAoaSuPyx8gbeYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c8+Xi9iA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F6Uap1001447;
	Thu, 15 Aug 2024 07:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=5Xv0TYGQ562mcC/GmoIH7NNoOnfIQOEfPjj1KKk
	SqGo=; b=c8+Xi9iALBE44E5XwWPKAkbOu/6BSZeXJN0+qzaIyy+YM9jWm6pG6/z
	1nrwoVkruXskPf2DAxZ2/SidQuZn3JZQOCNAQULVkJkNHJateP/kMU34paImbbTl
	z0P1iwmrC5OhrMpE668230XB45kKN2Vm9ycVzCbqFF0uO/DqDeNmeGz42Kru12p5
	dLNgeCG8/Do2e6agDaECMLPwBOFhTBnRBIkZNyzCY0z0vy7ZxhpIEHV4XVJYytQm
	ZEaB/B2Bmqa4oruHkV6kpQTCmWlwOnY5QZAPfamjuPT6AqKEoytYmDLh3buzgvWk
	EfNvo6VY26hKeeK1FiLy7vNzcBFzRHA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111j5tgcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 07:20:52 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47F7KqU0012317;
	Thu, 15 Aug 2024 07:20:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111j5tgcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 07:20:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47F5Lexh015571;
	Thu, 15 Aug 2024 07:20:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xm1mwfw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 07:20:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47F7Kl5r55181746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 07:20:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18C872004E;
	Thu, 15 Aug 2024 07:20:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08C912004B;
	Thu, 15 Aug 2024 07:20:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Aug 2024 07:20:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 8A037E020C; Thu, 15 Aug 2024 09:20:46 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Brian Norris <briannorris@chromium.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2] tools build: Provide consistent build options for fixdep
Date: Thu, 15 Aug 2024 09:20:46 +0200
Message-ID: <20240815072046.1002837-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y-mA0KOwdqknT9rZ3VVlUSKEZUIbumLZ
X-Proofpoint-GUID: OPQXc17kQCAWF9oTgzqRPzfT5YaOaNXD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_22,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=541
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150049

The fixdep binary is being compiled and linked in one step. While
the host linker flags are passed to the compiler the host compiler
flags are missed.

That leads to build errors at least on x86_64, arm64 and s390 as
result of the compiler vs linker flags inconsistency. For example,
during RPM package build redhat-hardened-ld script is provided to
gcc, while redhat-hardened-cc1 script is missed.

Provide both KBUILD_HOSTCFLAGS and KBUILD_HOSTLDFLAGS to avoid that.

Closes: https://lore.kernel.org/lkml/99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info/
Fixes: ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues")
Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---

This patch is against kernel-next next-20240815 tag

v2:
- missing tags added
- commit message adjusted

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


