Return-Path: <bpf+bounces-33240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F03B91A240
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87461C2169B
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F79D13AD3D;
	Thu, 27 Jun 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WLU3vaBj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02913AA36
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479370; cv=none; b=stJSpe6+ddfCLc2Ecd9Zc6HDW5x0Eko5juZ8CoDr92UXzDSXzQxHmzrJYjYlGI4Kx3a3R4Nfd7r4yinPSNbDAeV4V/6RC7U9tNiq/QgAB4i+oeYWviwjote7Cxv/PR8X7FU+fgYuXmOtSKDsGI5j0LZwDWany4pT2igwR6EH8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479370; c=relaxed/simple;
	bh=q0zmxxiOASIzNQEq8lSojTSLWgFCV3pP9hb/FzsGJLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nctM149DWLXfiBDOLdAD5uyBUbN6XV2z9f74EZcyiZwRGFriZROrIGiai9XPjEUI2bVCqb4PUpAIYyFwdiBekQ5Oubu9yQwKGZRYVurnmQQCOHgpGqYBnYy+UnkmmgYTzL2pLk4eW7QcXg5hpnm768YJ8KJo0sy+vcD89moxfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WLU3vaBj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7wLkD008695;
	Thu, 27 Jun 2024 09:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=94zPWmcXTMqKw
	lHxjsbuirIowqZOlxzhAVA9AKBy8tw=; b=WLU3vaBj6fKCx4l3CP54gvMTqO1Nb
	AfShppmSBqaeUwXjtXLYIkEXzQRgUsxTQqkSxwmOz+f818nB32mQgh8/++XabUO9
	rNVkgVVnpYsOwXa+edn2Ih/J1d/DpDahxgKAHbjT9r55cwzIGNiHZQmcFgiiZ03j
	5K/ihGdMWIl3aAzZ3QO0PINtnipI2ekeYxt8DqGR7HF4lykGehFSX230nFxpXNqn
	fjCpSaZiboSV0YoBwPb0ob00Fa2fSImdgTDXf09S5CejZEX1cdCrno9kolTBfkvN
	STjhD9m3RlUwXJol+3nTUWmuv7cdO1itN6QO5zb2XzegMXiT01ylVxnEA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yaw0sws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R8NVZi000627;
	Thu, 27 Jun 2024 09:09:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaen9tca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R99AwE52887950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECA5D2005A;
	Thu, 27 Jun 2024 09:09:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DA142004D;
	Thu, 27 Jun 2024 09:09:09 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:09 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 10/10] selftests/bpf: Remove arena tests from DENYLIST.s390x
Date: Thu, 27 Jun 2024 11:07:13 +0200
Message-ID: <20240627090900.20017-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627090900.20017-1-iii@linux.ibm.com>
References: <20240627090900.20017-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wsse3ayMpcrqGD_BqKJWJM1hUi4n80Yt
X-Proofpoint-GUID: wsse3ayMpcrqGD_BqKJWJM1hUi4n80Yt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067

Now that the s390x JIT supports arena, remove the respective tests from
the denylist.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index c34adf39eeb2..cb810a98e78f 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -4,6 +4,3 @@ exceptions				 # JIT does not support calling kfunc bpf_throw				       (excepti
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
 verifier_iterating_callbacks
-verifier_arena                           # JIT does not support arena
-arena_htab                               # JIT does not support arena
-arena_atomics
-- 
2.45.2


