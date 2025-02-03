Return-Path: <bpf+bounces-50315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A5BA25512
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 09:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3023A1EB2
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3342046B3;
	Mon,  3 Feb 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="a7cfz9LF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7699207640;
	Mon,  3 Feb 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572956; cv=none; b=uNGTiiky9nkc1LEj4ArUqSM/zaD+iWsqex37z3eZstC46/BhyrpdCthdd4AIvGv+xCY7Uq2BEauFW4khxr115cePmxAPLWSf4YIFgeRSQQROS8jK3IDa2S8Egliq9fITSqwipfaqk/2oaGJxO9U4+VD70aXx73pR36nHiQWAMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572956; c=relaxed/simple;
	bh=TBmZn9Bd16Gy7egqSQ5QTe9Zh6GCI4/ZlmqABocv35s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdwd9dxSt1r/uqjkCOx4sff7PGSSOid+c7BEzK4OOvjb3dsO4zAi95Lg5DJinaec6vf/U5MKqvAcua4tY3NB4wt1la9LTTnS9TDXe3mBk7Plg4LvMDtZ4O49zFCop9LaUKXQJ3Bj3OGvg0RAcdXrITeud76/1/+VdzjRoKFOQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=a7cfz9LF; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137i9xl012001;
	Mon, 3 Feb 2025 08:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=campusrelays; bh=ODvLgp8YPDdcWqJ9GP8rNHsfm7Whi7Xj
	3UusBO4cWvg=; b=a7cfz9LFLquqwgB9rbjb1qw/x2QYPjw6emBXyLlEDzQ8OsKL
	AiV1st39Zv8xScWGU/B7Ym/FetwSLNGgNmt0A3vlJA/g6JndLjASDxnb/uyFot5R
	qBpAp8wA/YQvGADTK7seR8Gy1DdKajS/ANl3RuX90JIdPkhxhMIwfqbMRAsxmLxx
	OwkB5Pie3q+DoHS9KBWtZYyjKfLmZniaLgc5cp96E/UXDNWf5P92dIi03Qx2xKcl
	FHSxK1sZVwEejH6ZQ4V7UHw2O3TfxQszrU6VjgvNTdGYBOomLxfVeX73Y5PT/apQ
	pCI3uVRUboP1pZh96cGuOC4Q5W/GJEENV9Yedg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44jjep9xeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 08:55:10 +0000 (GMT)
Received: from m0272703.ppops.net (m0272703.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5138q1nO024616;
	Mon, 3 Feb 2025 08:55:09 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 44jjep9xed-1;
	Mon, 03 Feb 2025 08:55:09 +0000 (GMT)
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
Subject: [PATCH v3 0/3] Makefile fixes for samples/{bpf,hid}
Date: Mon,  3 Feb 2025 02:55:03 -0600
Message-ID: <20250203085506.220297-1-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0sh5byDQhXX_9czvjXpmxfctcawUiOPa
X-Proofpoint-GUID: 2ImgSpJeJTiC_dfbTGc1Ev88FmGm-mZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=503 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030071
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
 - The first patch applies the same fix from commit 5a6ea7022ff4
   ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS") to
   samples/hid.
 - The second and third patch replace the relative vmlinux paths in
   samples/{bpf,hid}/Makefile with $(objtree)/vmlinux to correctly refer to
   the vmlinux in kernel output directory, following the recent working
   directory change in kbuild.

Changelog:
v2 -> v3:
 - v2: https://lore.kernel.org/all/20250123081950.173588-1-jinghao7@illinois.edu/
 - Address feedback from Andrii
  - Split the vmlinux path fixes for bpf and hid
v1 -> v2:
 - v1: https://lore.kernel.org/all/20250120023027.160448-1-jinghao7@illinois.edu/
 - Address feedback from Daniel
  - Apply vmlinux path fix to samples/hid
  - Add a second patch that fixes the include path issue in samples/hid,
    i.e., the same issue fixed fpr samples/bpf in commit 5a6ea7022ff4
    ("samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS")
 - Address feedback from Masahiro and Nicolas
   - Use $(objtree) instead of $(srctree) in the path when referring to
     vmlinux, as it is an artifact of kbuild

Jinghao Jia (3):
  samples/hid: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
  samples/bpf: fix broken vmlinux path for VMLINUX_BTF
  samples/hid: fix broken vmlinux path for VMLINUX_BTF

 samples/bpf/Makefile |  2 +-
 samples/hid/Makefile | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.48.1


