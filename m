Return-Path: <bpf+bounces-31574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F29000AA
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 12:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F67B1F21CCD
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 10:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7C15DBC6;
	Fri,  7 Jun 2024 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3zenTv8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B415B99E
	for <bpf@vger.kernel.org>; Fri,  7 Jun 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755717; cv=none; b=YW5d/8MwpQQ/Nnf1MrIAYBcysQGhhdk06WgNLUX3WXbgMtKHvEOPekULEwwETu8Fc7Xoayu+eIUNqXKFqsHQKxtYzyQ0WVudMxprZBsU2jB/A5KLbqmF4S/mKG4MF6MPYsXvVxUaXLoylAlTV5O4+2+4K2rcqybhX2Wnuu3qNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755717; c=relaxed/simple;
	bh=Z1ziD6PpY4vGgYPAmd3mGBF/RSeenOyRjmkYrHEFJ7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rD0SIfb37dEarObCPPxvofHJEJz67EJWOGOFtevFB9YjtWt9izV7+RMAaSIkX/ou719LL1Cs0mMcXA46JcFQwfxLdzy05NknfXJeNYT6czyT+zFpyI9nSBfUChq/gyWmCeGXiSLxscv4FIU0t3SYwzrQf6Bcp5HfKJecRBT60TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3zenTv8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c2ccff8f0aso144030a91.0
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2024 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717755715; x=1718360515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BrC2SOYgfyFzet4zuRawz/aiQM9sAK8JPisvqvOgQP8=;
        b=L3zenTv8bDrRadnIj1G1aZVwt59wpCESmDvz/WG3ClDiQE5bDl6MOIre5k03AaIlFK
         WRIoCfIA5F2r+zxdMvAN3fP4vL6icPLs/UAY8mjYGVH5rGjjVKeSsXzJXPl5w0mTeg8B
         04c1MPwFlRWy7zPqCtOuvJXK/jTmL1SpNL07VAbb/KCoL7AHOUVcee/dA1tBFcPWo/+s
         Fu8/GIa6g9gy+9ymwpoVaGZMyXugxhtEBCLiRbOs42HPQeVboTc/sSKRmda3ny/ERcnO
         VH3mKV70v0pDwzQkeppEoSHvfOCLSFfB7vR1lhM1xpWn20dFjV/p/lZMyStbIw+42Aop
         tznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755715; x=1718360515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrC2SOYgfyFzet4zuRawz/aiQM9sAK8JPisvqvOgQP8=;
        b=v+GdI8GO2oE/V2Q+yA7E7CllW/eqBt5s6bU8lSegyOJBaGBV2kYYqdurX9I1g0Fer1
         6+lVB3Oulm+J6pqWCNh1JkAyIx3zOtr5wrwoFCqNvDYJx5UMJ4SW63rK6orSeIPpIBIT
         sBmo5CXz9IrkYZEo7mjyJCdXIphe/KpVUEN5AUjXDPogb2F2T4MV/NYoiJI7tz2A5q4E
         22yYs3Oao3Dn5fHKqz9JIPbL3nx6wvCmsHkGmnN2e+earsktpeBtiMSSkVbYz2o3WYeF
         NN/Bx5eu+N7qDpopRVDldUXIeZNtgIXC5nX4oBbh7hCllhvj6/Mv+03+P1GzG3K9ym0E
         PFiQ==
X-Gm-Message-State: AOJu0Yxs4Eae547Y/QKpCh2GxfhViTwooIGbsSgEWpQtp+CIr/Y8m+m5
	AxgxhP4Jukqnah9izEF5gVZH/4INDkLrie8uM1N6hBKgxfZSsW9GKS9qk6iF1dw=
X-Google-Smtp-Source: AGHT+IFcJm4nPp1xfd1qTIT5CfGOaAfVFvzRnhyBoaGHjGVf8qp7OfTHB0+DKoMIUT6zXGVAMvOz9A==
X-Received: by 2002:a17:90b:515:b0:2c2:792c:b618 with SMTP id 98e67ed59e1d1-2c2bcc6335dmr1961810a91.33.1717755714972;
        Fri, 07 Jun 2024 03:21:54 -0700 (PDT)
Received: from kta-ryzen7.. ([240d:1a:2e0:8a00:1e5:bb13:8ef6:1ba5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de2678c69bsm2474541a12.71.2024.06.07.03.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:21:54 -0700 (PDT)
From: Kenta Tada <tadakentaso@gmail.com>
To: bpf@vger.kernel.org,
	qmo@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	Kenta Tada <tadakentaso@gmail.com>
Subject: [PATCH v2] bpftool: Query only cgroup-related attach types
Date: Fri,  7 Jun 2024 19:21:48 +0900
Message-ID: <20240607102148.151272-1-tadakentaso@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_NETKIT=y,
bpftool-cgroup shows error even if the cgroup's path is correct:

$ bpftool cgroup tree /sys/fs/cgroup
CgroupPath
ID       AttachType      AttachFlags     Name
Error: can't query bpf programs attached to /sys/fs/cgroup: No such device or address

From strace and kernel tracing, I found netkit returned ENXIO and this command failed.
I think this AttachType(BPF_NETKIT_PRIMARY) is not relevant to cgroup.

bpftool-cgroup should query just only cgroup-related attach types.

v1->v2:
  - used an array of cgroup attach types

Signed-off-by: Kenta Tada <tadakentaso@gmail.com>
---
 tools/bpf/bpftool/cgroup.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index af6898c0f388..afab728468bf 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -19,6 +19,38 @@
 
 #include "main.h"
 
+static const int cgroup_attach_types[] = {
+	BPF_CGROUP_INET_INGRESS,
+	BPF_CGROUP_INET_EGRESS,
+	BPF_CGROUP_INET_SOCK_CREATE,
+	BPF_CGROUP_INET_SOCK_RELEASE,
+	BPF_CGROUP_INET4_BIND,
+	BPF_CGROUP_INET6_BIND,
+	BPF_CGROUP_INET4_POST_BIND,
+	BPF_CGROUP_INET6_POST_BIND,
+	BPF_CGROUP_INET4_CONNECT,
+	BPF_CGROUP_INET6_CONNECT,
+	BPF_CGROUP_UNIX_CONNECT,
+	BPF_CGROUP_INET4_GETPEERNAME,
+	BPF_CGROUP_INET6_GETPEERNAME,
+	BPF_CGROUP_UNIX_GETPEERNAME,
+	BPF_CGROUP_INET4_GETSOCKNAME,
+	BPF_CGROUP_INET6_GETSOCKNAME,
+	BPF_CGROUP_UNIX_GETSOCKNAME,
+	BPF_CGROUP_UDP4_SENDMSG,
+	BPF_CGROUP_UDP6_SENDMSG,
+	BPF_CGROUP_UNIX_SENDMSG,
+	BPF_CGROUP_UDP4_RECVMSG,
+	BPF_CGROUP_UDP6_RECVMSG,
+	BPF_CGROUP_UNIX_RECVMSG,
+	BPF_CGROUP_SOCK_OPS,
+	BPF_CGROUP_DEVICE,
+	BPF_CGROUP_SYSCTL,
+	BPF_CGROUP_GETSOCKOPT,
+	BPF_CGROUP_SETSOCKOPT,
+	BPF_LSM_CGROUP
+};
+
 #define HELP_SPEC_ATTACH_FLAGS						\
 	"ATTACH_FLAGS := { multi | override }"
 
@@ -183,11 +215,11 @@ static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
 
 static int cgroup_has_attached_progs(int cgroup_fd)
 {
-	enum bpf_attach_type type;
+	unsigned int i = 0;
 	bool no_prog = true;
 
-	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
-		int count = count_attached_bpf_progs(cgroup_fd, type);
+	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
+		int count = count_attached_bpf_progs(cgroup_fd, cgroup_attach_types[i]);
 
 		if (count < 0 && errno != EINVAL)
 			return -1;
-- 
2.43.0


