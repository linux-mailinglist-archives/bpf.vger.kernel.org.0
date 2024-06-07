Return-Path: <bpf+bounces-31578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A49001DD
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 13:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711411F21FDE
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EDA193090;
	Fri,  7 Jun 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNjiTKi0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8F191494
	for <bpf@vger.kernel.org>; Fri,  7 Jun 2024 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759034; cv=none; b=iHG8HMLLzm6dhB2EGkNK1j83Y8l8HZi2+v4j2+5Dibyb4X3R2wLkDVON4ujCjn9HePMRTzRtqSdZZM24iiDyNZjm1nLjacwoO30DCCZZxdSx9XlWnU/X+og5i8I44iCv9YD3DM3rcbCTRX88wcgIaNbwBmkuWAytRwKvZDuCSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759034; c=relaxed/simple;
	bh=tWZgTlS+2D0r1P49zlESay7WeMkMOCt0U70apb4n9YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6VU2dP8DQ/NAHxGOvYtlkvlFj/dYDMBYU07KUbttNk4QVvk22iTA1Rq+Yuz/FG9Dvidr71iDglJysLtMJH3VWUAM8AdUybVgRjYyN+XEjwL/LQebekqHbK+orb4Cv2ejxbkY5p0B74ywipBR8FWt9sijAjiSAK+lAR9toqxrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNjiTKi0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1345297a12.0
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2024 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717759033; x=1718363833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgyKCnG6yRF8PW5sXrv3VlJp2Uw1qBe8A89XgNPodUc=;
        b=MNjiTKi0cPgZ4iESHioUla3+HjyQKk2o/BR4T48xtZEO+JYuSLfef9bEfyoj7AS5p5
         a7j4R/TlfPK7K4VjLU+C1U3mtpM/mJ2+XLGRSAnPyTQlmJ1ee0ck/i3CqxHH5gPrndp8
         CORFDGN0TW1oMrSPwf+HOklzHxYCn4KYON70Xc5a2qwQ0MReuALfJqagh3owwQn9omzh
         62RB8I3Ux911rcj1Dt5w73IiaqToNgu/ixr1Z6NOx8DsevtCghZOaCegK/tLO/z4Ezq7
         wRkLTD+Pv1Hu1OLyJ7NseHqo2JLkE2iyTl/yZTL4vQYotqdMVZukhGWxZu2ydcvhzN2V
         vG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759033; x=1718363833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgyKCnG6yRF8PW5sXrv3VlJp2Uw1qBe8A89XgNPodUc=;
        b=hSwJDYR1dh5brh73NEq+BxB05m2VFkCHXj8R6Azo49RSgkkTyba683/DSs6ygQzAzC
         3y1e98Wc5bbgFjoTcVFL2Q0Vx4teSvAgGJnLL/ileNuYJNBJB+WvaQBZb1NlqfECbY54
         +QKnjvsFpEYxvVR5eAFvFZ0rXXJDB/tm/3tkO8UGlZfgiESv8C8gzalWyNZj7NDx09B0
         2NX6H5dGBeEGXFqd8UJfhji1pVz8gyf2hCdY42Pu+a41Ytt1rTTEYq34Zc/1bkOclkoz
         kE2paQAHEgQabwePa2ObDgBCHm3BmNKK+VxuneJSa4NEN7JlbugMGH8JE1Trc8F8pgfO
         DrCg==
X-Gm-Message-State: AOJu0YybiLeQ9dFEJrR2AXTjSQ0QoAYQ4CMNg+XtwemGFQU/fH61SH4I
	7qwRUdYFQ8ad0XUK/QKs2by/9nzLy1KP0gJxY80Dr34OExdLwpOW5DxgFzNYNSI=
X-Google-Smtp-Source: AGHT+IEGVvqeTCmWaAIzx04CtStCcwp6oAccykfA76KxapvX3e2yUvemoVBf6WgTZmQEd+xq2APPhQ==
X-Received: by 2002:a17:90a:fe92:b0:2c1:9ba9:ece5 with SMTP id 98e67ed59e1d1-2c2bcc871d6mr1881128a91.45.1717759032821;
        Fri, 07 Jun 2024 04:17:12 -0700 (PDT)
Received: from kta-ryzen7.. ([240d:1a:2e0:8a00:e49b:574:d394:8195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28063a7fcsm5295797a91.7.2024.06.07.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:17:12 -0700 (PDT)
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
Subject: [PATCH v3] bpftool: Query only cgroup-related attach types
Date: Fri,  7 Jun 2024 20:17:04 +0900
Message-ID: <20240607111704.6716-1-tadakentaso@gmail.com>
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

v2->v3:
  - removed an unnecessary check

v1->v2:
  - used an array of cgroup attach types

Signed-off-by: Kenta Tada <tadakentaso@gmail.com>
---
 tools/bpf/bpftool/cgroup.c | 40 ++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index af6898c0f388..9af426d43299 100644
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
 
@@ -183,13 +215,13 @@ static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
 
 static int cgroup_has_attached_progs(int cgroup_fd)
 {
-	enum bpf_attach_type type;
+	unsigned int i = 0;
 	bool no_prog = true;
 
-	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
-		int count = count_attached_bpf_progs(cgroup_fd, type);
+	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
+		int count = count_attached_bpf_progs(cgroup_fd, cgroup_attach_types[i]);
 
-		if (count < 0 && errno != EINVAL)
+		if (count < 0)
 			return -1;
 
 		if (count > 0) {
-- 
2.43.0


