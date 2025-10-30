Return-Path: <bpf+bounces-72969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EED6DC1E560
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 05:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91DDB4E37DE
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 04:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11259212559;
	Thu, 30 Oct 2025 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOBS1ihg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B528488F
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797709; cv=none; b=kzLxOUi2dm/tqK6JcShgFJ8DGxG3qAOXdDX4FC9YRzwgDyZhMAdvsLFDMAHPXM9w+8Bcxo6i40fxaAegTLYf9Dz6xb39f23BtGE7QSrE37QJpWPQifQvmWty90BjARA+qzryW1Wt+ZfUYRQCDY1N2IjlRoGFdnVVddOIS4X1sf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797709; c=relaxed/simple;
	bh=aBRTdJV/Cutznnm5Vnl/Wt1QdN+f9b7CRXwerleKGHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oB2+u5QEsfZqz7MBa7dVElOoOanxR2ePerRWKb+BwLFtzdKSOiefH0gGnYO4ilW6+9y7t72iXJvVgWyb0nzPh3n3ILbwllcNKB8fWuS7lvZru6blCuslmSsyXYguAInGzxVPgaX5VtIaytmSV+tZyMh2OeolTZH0r7tpsJcvDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOBS1ihg; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so697823a91.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 21:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761797707; x=1762402507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WywPhK8rX8KYdEGPRDNQCxYargrpyo9AoIMZ6I9iyXM=;
        b=bOBS1ihg2Tu7rDWPWoGhSTxcJNY0kPySOZ+K6VlWGDDGMCmnzAGQH4WDoIQN0JX8Gb
         UJ6XNLtm7AwN+AHLsNUnELXut9bJRj3ate6gRsN4d3gJumz8efR0icQv7MHCIg65oSks
         CfnB13Sd/26+JG8JtC7i7Um+nLuoYv0FB/54Fmrnq9Px3op6wZAf7akty+rx+pzG8PJi
         G/kn55n5pUhD2c2+mDvjGY+i1obx7scbYZpGK0EkLEfi91rrKk68S9/NtmSSMvGonHbR
         CROWF+/ToyJ507VcjQFijqAA94OlFx1FmBJf1waY07HAX3SB2Cs1Js/2Ci0fsFyqpsvY
         E6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761797707; x=1762402507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WywPhK8rX8KYdEGPRDNQCxYargrpyo9AoIMZ6I9iyXM=;
        b=qHhkIIQKUjIE6WTrHLki1UXHwuunxWrZGKjNDkTkJxNXElckZ+UKs8HrRrZScGvo3s
         X0EEyqETX6pW/tPGDKZhBdd1Iiq4GH/dHQQZ0sr3UjReq6LKsLOEhxhMMmUWWSaCzpad
         8bGmtR6mw2d+nz3TlNH8SoLfHPZpLdOTFUz6tVVn/u3rCGkQA5bgfb4J97vsT05TJW9y
         U3yZtCsMduPmLYI7sOnMnN+28GalKHTGJAS6hzE25qUM0RTaQ/GzjeJga+HBvrB36hJc
         mVz2HbCs6KGULGWbf57px7QdWmvCYn+DF2J1jPLDqrWVxiyQmI4lPBkspLD/lLrMuTy1
         EW4A==
X-Forwarded-Encrypted: i=1; AJvYcCXu7AS1W/sWEIeQ1G6PbMKjjqcUALb+4txr9YhNf225Qg7rcN/uUJRgPa/7eRAF45XUh00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTdFlViXOnnHG59FPDK2vP6DlnmEJtxoGJYRwAfzbKInWFCj0
	ka6ItWY6JoGXrAO2mxx2d0TJi1l8NkTNHIofQRdVi58a/Oq2s9G5SOnH
X-Gm-Gg: ASbGncvRUyK0yHrEEc1WHShQn4vj6+zwt1ODk1GWljXtjPQARmyLGQiSsfHAodQhzEi
	zVSbi/zzbV6CSeuA3mA2kL1fxxGWXmofJws95uk94UB9zvd87sxraiLVUUExgj7+cneF1LVBB/H
	C3RBxB7T9PaWgkjsZKCFLIWFy/1ZevAceqMEeWjf02wEaCVix6SqCMOzosdATnQa5g9SsPWlMVh
	YMZm1wtfN7PZfk4Pdhr3aLPnxbtJx/UHN//hxU9MJfjc6D/QllD6GsEnDRtJR2HRApjiLpwfwML
	BVYnNdmHmauIl9GRNtSVC0swC0836dRYSPUQOh1UUxyiOk7SkjVAScfmeIq9hrLobKUQ0enVpsE
	AaZ0yLPeWeUpAXmsbaXbYD9ymabwys4QJ0wp2ISKhyHFo4a+Cz63GNCD/Se6bywIqGQVo4+1Inf
	UEEhx6SV3KuIj/MVlukw==
X-Google-Smtp-Source: AGHT+IHmVRX2SSN8xFtoHIWs97eLO18pwBpAmDhLc/ti/WeUODi1bpmpP+p4Z1+qnjhH3BvJpXhGUA==
X-Received: by 2002:a17:90b:570f:b0:33b:c853:2d95 with SMTP id 98e67ed59e1d1-3403a2fe505mr6536937a91.33.1761797707315;
        Wed, 29 Oct 2025 21:15:07 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050992f92sm877375a91.6.2025.10.29.21.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:15:06 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH v2] libbpf: update the comment to remove the reference to the deprecated interface bpf_program__load().
Date: Thu, 30 Oct 2025 12:14:57 +0800
Message-Id: <20251030041457.1172744-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit be2f2d1680df ("libbpf: Deprecate bpf_program__load() API") marked
bpf_program__load() as deprecated starting with libbpf v0.6. And later
in commit 146bf811f5ac ("libbpf: remove most other deprecated high-level
APIs") actually removed the bpf_program__load() implementation and
related old high-level APIs.

This patch update the comment in bpf_program__set_attach_target() to
remove the reference to the deprecated interface bpf_program__load().

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v1->v2:
Modify the commit message in v1.
The v1 version is here:

https://lore.kernel.org/lkml/20251030003235.1131213-1-jianyungao89@gmail.com/

 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fbe74686c97d..27a07782bd72 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13858,8 +13858,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 		return libbpf_err(-EINVAL);
 
 	if (attach_prog_fd && !attach_func_name) {
-		/* remember attach_prog_fd and let bpf_program__load() find
-		 * BTF ID during the program load
+		/* Store attach_prog_fd. The BTF ID will be resolved later during
+		 * the normal object/program load phase.
 		 */
 		prog->attach_prog_fd = attach_prog_fd;
 		return 0;
-- 
2.34.1


