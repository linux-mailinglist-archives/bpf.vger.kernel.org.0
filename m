Return-Path: <bpf+bounces-49565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EF3A19FBF
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 09:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E7C188E811
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A420C039;
	Thu, 23 Jan 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="LzgCcnqx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1D20C46E;
	Thu, 23 Jan 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620445; cv=none; b=RKc6IttvIKlkC0Qxf/ymClMEA5+X0r9nw7F21wFaV2HxwmG/tTB3vlkJrT/4Mh6QuvL6YpzzGV1BEh15ptxAZN5MXHuTnt+DDexDnVy44hm8f6ZoiIAJNQL3L+TrQ1JKa2tkv2vXO0G3tMjXCeYlBOzF8/yJ/5iakI+EMggUfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620445; c=relaxed/simple;
	bh=RLXe01LvhZmTH1uUB1F/4MppbCTJ/YBo1qJzUL9Vhsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUpA8WuvlvYGgP5957be/4r4GOy/1KIZv1JRLRppFNk+HtJlCnfpFp1Ns2W6sG5N3qqC46WNy66ghjfd17YXsvkRjZA821f4DAc4ienDNgceRbAH5SUxjvp61X26vbB+ja6/gXiaS/69dcoxaYlURdH7hQXa4wO9Tpr2f0iwnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=LzgCcnqx; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166260.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N7bXte016458;
	Thu, 23 Jan 2025 08:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=campusrelays; bh=kCbJv4trettbR1iOKgifMg0XMAEuoFGS
	aMYrjNu/VsM=; b=LzgCcnqxS3eCha1BA6tljVrubJ8avHgdrJvjG8bXOZS1IQKU
	dyREPoPPbutHLJmIn9YBQGJ3xknXPSrDxZob8NOddV5uBRNGL4IpdMbQfMlr/v8L
	HqRddJqFqR1E/mzGXD2y8xfeNWmjNSFuKoWtT1c6cyuUGIB4+a2YOV+RcExlzivO
	V0Hb0kctbOGjLV8c8TqU9wKP8rm3/Wf6OoH+y62qZKqu5LNEgwjwxfdXfCGfz+m6
	mWrC96D/O//oywL2f8CjezpybGhA9Li7IUISP0G7qEuIkEuc7wUWLSD7Kwo5DOXB
	EwoSbjWtdeFif3JE2WpoPp8r67E8zfWyleA7dQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44b862b4rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 08:19:56 +0000 (GMT)
Received: from m0166260.ppops.net (m0166260.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50N8Ju0M005824;
	Thu, 23 Jan 2025 08:19:56 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 44b862b4r7-1;
	Thu, 23 Jan 2025 08:19:55 +0000 (GMT)
From: Jinghao Jia <jinghao7@illinois.edu>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>, Ruowen Qin <ruqin@redhat.com>,
        Jinghao Jia <jinghao7@illinois.edu>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH bpf v2 0/2] Makefile fixes for samples/{bpf,hid}
Date: Thu, 23 Jan 2025 02:19:48 -0600
Message-ID: <20250123081950.173588-1-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FI4DuP9gUMtQOXpO1WvbAJlq5heFY6vG
X-Proofpoint-GUID: w9BqAD-UyBpQpZVFnX1gWtrUDMAsfZhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_03,2025-01-22_02,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 mlxscore=0
 priorityscore=1501 mlxlogscore=370 adultscore=0 spamscore=0 clxscore=1011
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501230063
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Hi everyone,

Following commit 13b25489b6f8 ("kbuild: change working directory to
external module directory with M="), the Makefiles for both bpf and hid
samples are broken due to the use of the relative vmlinux path (i.e.,
./vmlinux) when generating vmlinux.h. Additionally, samples/hid experience
the same problem that was fixed for samples/bpf in commit 5a6ea7022ff4
("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS").

This patchset makes the following changes to fix these two problems:
 - It applies the same fix from commit 5a6ea7022ff4 ("samples/bpf: Remove
   unnecessary -I flags from libbpf EXTRA_CFLAGS") to samples/hid.
 - It replaces the relative vmlinux paths in samples/{bpf,hid}/Makefile
   with $(objtree)/vmlinux to correctly refer to the kernel output
   directory and vmlinux, following the recent working directory change in
   kbuild.

Changelog:
v1 -> v2:
 - v1: https://lore.kernel.org/all/20250120023027.160448-1-jinghao7@illinois.edu/
 - Address feedback from Daniel
  - Apply vmlinux path fix to samples/hid
  - Add a second patch that fixes the include path issue in samples/hid,
    i.e., the same issue fixed fpr samples/bpf in commit 5a6ea7022ff4
    ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS").
 - Address feedback from Masahiro and Nicolas
   - Use $(objtree) instead of $(srctree) in the path when referring to
     vmlinux, as it is an artifact of kbuild.

Jinghao Jia (2):
  samples/hid: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
  samples/{bpf,hid}: fix broken vmlinux path for VMLINUX_BTF

 samples/bpf/Makefile |  2 +-
 samples/hid/Makefile | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.48.1


