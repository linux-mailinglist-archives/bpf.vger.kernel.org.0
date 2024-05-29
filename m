Return-Path: <bpf+bounces-30840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2828D3726
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705C21C217DF
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B54DDA3;
	Wed, 29 May 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGN3FUlr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBE819
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988238; cv=none; b=ZLY/x29Mg8IYt3L5wunN9emVWiQ/5AQkmzbkWY23+9ide/+GB0j1O/liHsZilrxhw9Ym1sczZlm1DyaC67wKYtjxcN8VPGERcnhPo/EdjeCrDJE2pfT80w0SQYxcMtTrItwwVOg3DWg/igEYYqWv7KTGoe9U3XPzj5UXd1fwDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988238; c=relaxed/simple;
	bh=IIu1h4QaG7Gz4VvW4InqSAQXFG+s8xY930IHXzLgRj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpmmCVQQRWC6CN9WjKeBIli6wNy6d2yuOb6OdItIrG4tdb8eubZovOO6EL7pYyNh7cn7pYuXSCb/wEyAQX52YQ/aNEpd/S9L4qr69Cf2O1KUan+j0ihmS+SJUzF3oxqPXV4FV+tAZTx8elBtiaR8RlOmdpCwaqMKVYHhEkP41wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGN3FUlr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70224f928edso261722b3a.0
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716988236; x=1717593036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oou+LWtz3JmzcKLUwdg9NuhqGobOM99bbJts7M1mbrs=;
        b=IGN3FUlrq4qtBXx87oHKr8A8RCGZ57OOSsWedSQPhxCw3e8IXAkun8Y2LwOIHj74Oi
         9N6AvSoQ0o1kf4YhPhXJ1f1Sg3go+R+snDhUD2Iu4/8Zn6AcK8I2M6nxXRVVERwgAEO7
         1Pli4YQ1Ce+8lWJKPun6POCLGqC75zan6kHrwmLGRHMMIQ7cXaMwZEqSUigrL9pdDbNj
         vH1KsXhpesp7alqA/Z6VEzYS02wQRWRg8koN0fyRdR8cLSjjSGPCe/uXCJPNpprE+H0B
         l6+3JrcNNKIYMv1Ln9s09Q0vpaKXiL3SW2bS1nn29IDrxppaPC/BQQkhS7sCaOqabhP2
         3yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716988236; x=1717593036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oou+LWtz3JmzcKLUwdg9NuhqGobOM99bbJts7M1mbrs=;
        b=gMI45BvBoUaHoD120NtKSsO/NJvTFPoJl5ThpIjrzWUgYK3MTLP6N02GLZsI1Jw5Mi
         NyKjCupv+Yo+hILNOoDFfakloOSE89oyED+A1ZQcZvJTCuqD6RDHj9OBXKUcOqLD9GGH
         /0Xsn2et3XH4txsakJZ24WBVJDhh/3rjAqdaygyZu8f05hzIYR8j4LQ8fmbxV2LlRa0I
         QW+/gQX7ffeH7+W5vLYutNMZg58qYQAk917KgRr710ItcZSgBcBHyWyNmdkjNTpRy4KZ
         bo0nhtqqBLtnoGYP0OQtOuQRG2XcIyLNu/JVmwbwTIYOfpmsZss7sPcr3k4Ymnii9mOc
         4FOw==
X-Gm-Message-State: AOJu0Ywd3qzLUFAmLA+aw6t0EQS3YszxWjkULMLFId22cPcaSqgpBzxA
	qryQ+ls6xTjdCOqI09xD0J0NcDjIuNGFV69aQwDyNNElwnwVNL+TFkdCkJAIGQk=
X-Google-Smtp-Source: AGHT+IFiZs6htV6Y8WjE02ii9pqprx1C+VGL+zFMiSavU+f5eWRVTImjXhgk355wqNCi9Np01Bivyg==
X-Received: by 2002:a05:6a00:368d:b0:6ee:1b6e:662a with SMTP id d2e1a72fcca58-6f8f4194317mr16701816b3a.32.1716988236395;
        Wed, 29 May 2024 06:10:36 -0700 (PDT)
Received: from kta-ryzen7.. ([240d:1a:2e0:8a00:fae8:d381:f90b:a1cd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682229dc57dsm7803739a12.52.2024.05.29.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 06:10:35 -0700 (PDT)
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
Subject: [PATCH] bpftool: Query only cgroup-related attach types
Date: Wed, 29 May 2024 22:10:28 +0900
Message-ID: <20240529131028.41200-1-tadakentaso@gmail.com>
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

Signed-off-by: Kenta Tada <tadakentaso@gmail.com>
---
 tools/bpf/bpftool/cgroup.c | 47 +++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index af6898c0f388..bb2703aa4756 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -19,6 +19,39 @@
 
 #include "main.h"
 
+static const bool cgroup_attach_types[] = {
+	[BPF_CGROUP_INET_INGRESS] = true,
+	[BPF_CGROUP_INET_EGRESS] = true,
+	[BPF_CGROUP_INET_SOCK_CREATE] = true,
+	[BPF_CGROUP_INET_SOCK_RELEASE] = true,
+	[BPF_CGROUP_INET4_BIND] = true,
+	[BPF_CGROUP_INET6_BIND] = true,
+	[BPF_CGROUP_INET4_POST_BIND] = true,
+	[BPF_CGROUP_INET6_POST_BIND] = true,
+	[BPF_CGROUP_INET4_CONNECT] = true,
+	[BPF_CGROUP_INET6_CONNECT] = true,
+	[BPF_CGROUP_UNIX_CONNECT] = true,
+	[BPF_CGROUP_INET4_GETPEERNAME] = true,
+	[BPF_CGROUP_INET6_GETPEERNAME] = true,
+	[BPF_CGROUP_UNIX_GETPEERNAME] = true,
+	[BPF_CGROUP_INET4_GETSOCKNAME] = true,
+	[BPF_CGROUP_INET6_GETSOCKNAME] = true,
+	[BPF_CGROUP_UNIX_GETSOCKNAME] = true,
+	[BPF_CGROUP_UDP4_SENDMSG] = true,
+	[BPF_CGROUP_UDP6_SENDMSG] = true,
+	[BPF_CGROUP_UNIX_SENDMSG] = true,
+	[BPF_CGROUP_UDP4_RECVMSG] = true,
+	[BPF_CGROUP_UDP6_RECVMSG] = true,
+	[BPF_CGROUP_UNIX_RECVMSG] = true,
+	[BPF_CGROUP_SOCK_OPS] = true,
+	[BPF_CGROUP_DEVICE] = true,
+	[BPF_CGROUP_SYSCTL] = true,
+	[BPF_CGROUP_GETSOCKOPT] = true,
+	[BPF_CGROUP_SETSOCKOPT] = true,
+	[BPF_LSM_CGROUP] = true,
+	[__MAX_BPF_ATTACH_TYPE] = false,
+};
+
 #define HELP_SPEC_ATTACH_FLAGS						\
 	"ATTACH_FLAGS := { multi | override }"
 
@@ -187,14 +220,16 @@ static int cgroup_has_attached_progs(int cgroup_fd)
 	bool no_prog = true;
 
 	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
-		int count = count_attached_bpf_progs(cgroup_fd, type);
+		if (cgroup_attach_types[type]) {
+			int count = count_attached_bpf_progs(cgroup_fd, type);
 
-		if (count < 0 && errno != EINVAL)
-			return -1;
+			if (count < 0 && errno != EINVAL)
+				return -1;
 
-		if (count > 0) {
-			no_prog = false;
-			break;
+			if (count > 0) {
+				no_prog = false;
+				break;
+			}
 		}
 	}
 
-- 
2.43.0


