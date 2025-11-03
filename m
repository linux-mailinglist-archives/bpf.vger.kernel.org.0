Return-Path: <bpf+bounces-73340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B6EC2B926
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 13:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73B8E4E1673
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A6309DCB;
	Mon,  3 Nov 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/jNm8n3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79762D839C
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171660; cv=none; b=u0XioQkgggSrfMSABzvXHbbNf/o5CcLUklcJgDLtYUapzygufIfjTkMQb5cWFYVcaQ2ENpIbLwoxl04LXPl0KADqBwhstnFNDNjr00JbklNqrEbHnS9ZSpAAPzmwr4vchPkB9+hYNphfF1DLQtIKRqctturHuX4STm5oSVSno/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171660; c=relaxed/simple;
	bh=HDgFH8+lcYGTIPsMGp8pD2rOtin1LQuwHRYPV0vyMOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kU3VLwYShnXbfziflyt/eQYyBWtS4KonqBY5eis3mNRzWVuPOyKi3wVvQQ/eYz1wCGtYseG9iKz/T9ITVirqYWDsx6wSJFnrNRT3bFPRS5S6xjYaNOvXIZOquR4i9cfOFYOvxrPICgmVPUdMp6Z9+hJXsUriYrJafEWFyn4Zx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/jNm8n3; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so4137348a91.3
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 04:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762171657; x=1762776457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBV8uCibKMjflLcauf2cgohnqF8noUoexoXvof5RE6k=;
        b=N/jNm8n3Q4TDdu1jT8LVzrngGETCcGxqBev7pVMEAH1b53yXXMDZFCQprCzpmbBDfM
         tAswHxsmR9WXe23WGFerfwMOpXPp+SkXNoEQ+kyRJG3X/rcQrAUH3akCfoo0WRHjfBBj
         /HcJfnRv0QAGh5k1zgIX6Ld73HvA2Akf4XfCBV6zLhBHIQj/EP6bHwYxRatewvGzs4jR
         y7mblMMDegRgruHPRIS93PAv4xlcDcz9bSdF1L4Orrd6Drd8OaW5GSylgnPJfz4z4wN+
         DdXDtYVtGxwYNZkytFmQarzzAulDPvJgWZNbWLq9YBwy2Lo0dHzrYqsaI8+VmD8fl7NI
         ZqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762171657; x=1762776457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBV8uCibKMjflLcauf2cgohnqF8noUoexoXvof5RE6k=;
        b=MDtuMEDfnycXR7+brlUwHrMCo//tmlljfIEw6N1Nn01p2pqjKEgNMdtAzL9D/QG14g
         2nVaXeUyKWNISjLIlOB0rneXjDWbrh0lbyLOH1SvmOuKqeMdzP/lQNMqPtQPmI6XhVAU
         I6I67zJ3K3yRVIKWtGh/bcwD5yQoMuBfAuOv1CV384TEd5+tTSIHV+YeTG/GrYMY9Ef1
         iQB/cskJMTkBYxPBnKKb38+7TspW5Bs9F2wdutzfsbg6NkmWhiMRz1ExxvRjGxb7VIFQ
         6g8LU1NXpvTtKZsjlUDpuU0PYFI6NRro9rVnLtgOtF2dUKV/lYxT0MeMubXBZMTxm5fW
         LGLg==
X-Forwarded-Encrypted: i=1; AJvYcCUA7sbx4jAgtw0uPG0KNbcdjMY55F7NeS0Sj/Y29WL1V67XLxME+E9uiENQdPgFMWC6lj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxphRAmwtTTluOAF98UfOi0wnuME0eHdujvo1D1bXnOOCbLkx
	6mh4b6Wx6MM4dFwcJl2LPnr758+Ks2a28VP1sQPFkwiWmoP+wZsRvzy7
X-Gm-Gg: ASbGncuMFd5IC8HqfNVK5SMEzHLyA94wnuqoe2Hp5NrF+RYDUGhI9LCCIUnezTrvxU0
	yigizeMSMXa4cIdfPavE1Hq66CEsWxWVcOJG/oO8osJiAHMGFPK0X3PAQyyK5s2Ya0MJpog9tr8
	5q9n70kms4tVREcMS5xZ/bI2jZlPJGEMdizmblQwtEigGg/oBxJy2LA4zZzhPxOifDJnlR95l6T
	6ov1HkGboaOviD2Vzmhv4TfjHIg9HhboJ3MB5Nvs4lbhuGEUnnPtlhDLJLNkK7tPiilxbuqxOpM
	WmV09X5beJm+XiKMUIPL91Srjn+bDLMemIbVxe4kkYNceSs2l17/ERT5oaW3g/cC/9HzjGAFzAW
	b4genYCE/oV+leCgWdJvaRGCX8bhQvE7Iw4mnC2xLZrC1gW0hyL5ccgcVorPDlgwim5PwpLR6gV
	RB7szWfUZCnwekw7MZsguF6FLDhJjS890uMQ/bOu4=
X-Google-Smtp-Source: AGHT+IEZfSB9HYZQPKGGoO7TtFh1e+B/9EFdNU9vpxUkttXXx8+VOJaZX9b0S0yE6isAEzXUS5yNgw==
X-Received: by 2002:a17:90b:2f06:b0:33b:bed8:891e with SMTP id 98e67ed59e1d1-3408307ececmr15049100a91.19.1762171656813;
        Mon, 03 Nov 2025 04:07:36 -0800 (PST)
Received: from E07P150077.ecarx.com.cn ([103.52.189.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b9887a3f044sm6329497a12.18.2025.11.03.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:07:36 -0800 (PST)
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
Subject: [PATCH v4] libbpf: update the comment to remove the reference to the deprecated interface bpf_program__load().
Date: Mon,  3 Nov 2025 20:07:27 +0800
Message-Id: <20251103120727.145965-1-jianyungao89@gmail.com>
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
v3->v4:
Try to fix the CI FAILURE issue by rebasing the local code to the latest
version. The v3 version is here:

https://lore.kernel.org/lkml/20251030060322.1192839-1-jianyungao89@gmail.com/

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


