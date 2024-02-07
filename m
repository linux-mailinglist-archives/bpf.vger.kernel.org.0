Return-Path: <bpf+bounces-21414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD9B84CE27
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CB828FBC0
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56307FBBD;
	Wed,  7 Feb 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5YGTiCo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA37F7D9
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320167; cv=none; b=vEI+hu3qmrpoNt/H9j9zDmEdOEAr6A2EwmdQ1RKZ2psAdzOYmXKAsHXWueJD9MVfzx89DtzBeuDiz8fyEkm3VsZ7xrRvgn0/Yctcod3o9oh4M3C1+nYIdV0X1N5LdqWbQY0cPruaUHB2fbT4aCol3ZuyINwS1131+djYJljbLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320167; c=relaxed/simple;
	bh=cNBi2HK/opyHs+tSrM7RFfh2FezXH7N1t3ovP655hoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAdf/dGc1aVb9DhTLvQry1A8QsDyMNzlPg1D6yeQlZc26QfwMPf6lTQAimlWJTlVGmtx6qMTTiKwbJHFoGn6cytZh/wC4MYWqKbX+hFmxSPGLPvnF4fj59ryKN+65Q5DqpWCuPQ0YiVd/THUgN3YRqtcmn4+7ZoSW4rUX8PIwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5YGTiCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87341C433F1;
	Wed,  7 Feb 2024 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707320166;
	bh=cNBi2HK/opyHs+tSrM7RFfh2FezXH7N1t3ovP655hoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5YGTiCogEGsOcPa/2ww+t1e2F7poJK0846BzQqWKGVE/JKCk6eLrCpDlBSctoP6B
	 rtsw9NXMLajtTaLl5AMz/FiIT+ZHQXgzNmsSp+kDNaG1nbIqObHhz96YHxt17Bjcrp
	 6gtgyQgd1b9ztKNJrreVxecr2Jn7MyftljZ3b9HPgrbKcghmPqrFBXPlMWUWPk31cv
	 W6KtkObQQdoEELYTrftXO6OgDeMgvEjiO5IHIrfhJIsnvz0vjeHenFHMCTaEeY8j/S
	 EzvjXsChCUbsyZB8XtoJ6E6oadObNEFNl2ONOOSX3Pt57tFjmjPneihOmox6e1qKU/
	 +d81TSvy0tyxA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH RFC bpf-next 1/4] fprobe: Add entry/exit callbacks types
Date: Wed,  7 Feb 2024 16:35:47 +0100
Message-ID: <20240207153550.856536-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207153550.856536-1-jolsa@kernel.org>
References: <20240207153550.856536-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are going to store callbacks in following change,
so this will ease up the code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/fprobe.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 3e03758151f4..f39869588117 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -7,6 +7,16 @@
 #include <linux/ftrace.h>
 #include <linux/rethook.h>
 
+struct fprobe;
+
+typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
+			       unsigned long ret_ip, struct pt_regs *regs,
+			       void *entry_data);
+
+typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
+			       unsigned long ret_ip, struct pt_regs *regs,
+			       void *entry_data);
+
 /**
  * struct fprobe - ftrace based probe.
  * @ops: The ftrace_ops.
@@ -34,12 +44,8 @@ struct fprobe {
 	size_t			entry_data_size;
 	int			nr_maxactive;
 
-	int (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
-			     void *entry_data);
-	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
-			     void *entry_data);
+	fprobe_entry_cb entry_handler;
+	fprobe_exit_cb  exit_handler;
 };
 
 /* This fprobe is soft-disabled. */
-- 
2.43.0


