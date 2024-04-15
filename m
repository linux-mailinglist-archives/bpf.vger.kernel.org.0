Return-Path: <bpf+bounces-26879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC928A5E39
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 01:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD581C21AC5
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 23:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B83158DDC;
	Mon, 15 Apr 2024 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="e3D+huNG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F41272B8;
	Mon, 15 Apr 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223349; cv=none; b=BxJkUzhN2HgKCKqrVsOZJefspbmiHL1QaUN7q2FbVRN1mYx/6bKsPvy4O0l0aTkjAk8ahe7GIiTTBvVI1uEWgmy9X0uZYAqtFPONWCkcxsgK2lmJvLvQuI1X23uZJLZzKzdvYZjsEREMCCz/XsdC45Li1rcMZebWH3eWIs1SHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223349; c=relaxed/simple;
	bh=quDJp0nmfOtlJCGhx+JE1aXmvcXtsbLBxBDLT69n6uw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lzdGPF6RFkQ5fGF7jnnivDQ+lbzclroNaqSVyoT/Lfemi8APhrXfebbBVGkuRmcxGRgJkI3//NhkoCpBOYmuHksfj2CYfxyp4PKDC6DhDRAivKfE/tVcYkHWvp34yEeE/mCn/UWr1GNfhwT7Ss0AOjO2TYPvOANvx6KVE4xFXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=e3D+huNG; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FLxUMx007335;
	Mon, 15 Apr 2024 23:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=default; bh=14J70gYg9
	RDH634/oH+jURif/pgn4cONK6QdW2lwxIg=; b=e3D+huNGt/VMyIEpGhWR5/lao
	GJV8ue40GPQ64jnImeFTcwxkGw5SUybMMvc7ULaU7RVdSJqSNSi4NugdKBRpuKXn
	Vh+1oSVpR+Yn25KXgEuqZU5KpEld6bc7Wrhg2ayw5ja6s04VkN4EHJnf94Yli1kw
	1/a6Pc3v5sWhBF7qY+5xbSHlaMLmrlKrr8R878DSwDi0zItqnAwNNgBc8AZYgcxg
	UqDEZzHZcpk9/6pDk7IILnKtqy04sy190r2xuLl2u0j4xMurUOQ2PmTg/Cb/+E26
	aGEXbPtlUqyLSuMxHEdLADq/FbFDVSyk7yyOhPToz8dkHtvwhmDj13VDehveQ==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3xhcn083u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 23:06:51 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 15 Apr 2024 23:06:39 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next] bpf: clarify libbpf skeleton header licensing
Date: Mon, 15 Apr 2024 16:06:12 -0700
Message-ID: <20240415230612.658798-1-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04wpexch02.crowdstrike.sys (10.100.11.92) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: kwXhQW-ctYVmUNel2rWf6BzMWZeZf576
X-Proofpoint-GUID: kwXhQW-ctYVmUNel2rWf6BzMWZeZf576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=563 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150155

Add an explicit statement clarifying that generated BPF code bundled
inside a libbpf skeleton header may have a license distinct from the
skeleton header (in other words, the bundled code does not alter the
skeleton header license). This is a follow-up from a previous thread
discussing licensing terms:
https://lore.kernel.org/bpf/54d3cb9669644995b6ae787b4d532b73@crowdstrike.com/#r

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 Documentation/bpf/bpf_licensing.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/bpf_licensing.rst b/Documentation/bpf/bpf_licensing.rst
index b19c433f41d2..05bc1b845e64 100644
--- a/Documentation/bpf/bpf_licensing.rst
+++ b/Documentation/bpf/bpf_licensing.rst
@@ -89,4 +89,8 @@ Packaging BPF programs with user space applications
 
 Generally, proprietary-licensed applications and GPL licensed BPF programs
 written for the Linux kernel in the same package can co-exist because they are
-separate executable processes. This applies to both cBPF and eBPF programs.
+separate executable processes. In particular, BPF code bundled inside a libbpf
+skeleton header may have a different license than that of its surrounding
+skeleton. In other words, the license of the bundled BPF code does not alter the
+license of the skeleton header nor of a program including the header. This
+paragraph applies to both cBPF and eBPF programs.
-- 
2.34.1


