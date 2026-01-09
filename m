Return-Path: <bpf+bounces-78362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A610D0BF3D
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE90F3031956
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25E3659F2;
	Fri,  9 Jan 2026 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EA+Mr6LC"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A43644CF
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984607; cv=none; b=blRROAV8jSFVLd7WO5P7Sfv9Dx0vm0Thg57byP3hqhbt0ZXhS6gWFRyi4j1fG+kuebL0jxKJ/khZw6tN5RWQTiHBY4dXw4+6VOijhLvs6j81+Hi9vcpy0bNJr+aylKTzW1+y4dwmwBxb2zI48A31b09heIVGI7Ea3HSRTjJUJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984607; c=relaxed/simple;
	bh=kNZDi4PouA5ysECu4OljUJ+SIqICtp/OzbMttetmQ0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUDecXWMOelLqwgUlPDJx2pCflBKg4DSyRVPfcAMiuwPhlXRtZ9HGCyep/i7hPQi+ERdb8sGuuCtBTNrK4d3Xhmij/oMke0hudYCI6M6f1PSzbok5qOnkyWfZlrvgAcJyOprts71gAf/vzdd6wtn1x+vecqoVPAsp2TL9eEDheY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EA+Mr6LC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767984603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcYtpXxzyX/CMZF9iakQ3HFggQYBdT25wRsLTnOoPdM=;
	b=EA+Mr6LC2wzBX8R1oW/w4jlXkR2k3lgfgLtEZPv5w1xQJpUpIqdPWsU0Sunl+HtvdifhDs
	DJvR+qjMjvwluGdh3Hwwu7Y4fZdTEMuh4DCC5zZd3CkRmmURHoC82/dQAhY9hOwkdw9SPm
	7XTzyiDYyqNVLHk/N9YFJfjSkps1KKc=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v1 10/10] bpf,docs: Document KF_IMPLICIT_ARGS flag
Date: Fri,  9 Jan 2026 10:48:52 -0800
Message-ID: <20260109184852.1089786-11-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add sections explaining KF_IMPLICIT_ARGS kfunc flag. Mark __prog
annotation as deprecated.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 44 +++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 3eb59a8f9f34..b849598271d2 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -232,7 +232,7 @@ Or::
                 ...
         }
 
-2.3.6 __prog Annotation
+2.3.6 __prog Annotation (deprecated, use KF_IMPLICIT_ARGS instead)
 ---------------------------
 This annotation is used to indicate that the argument needs to be fixed up to
 the bpf_prog_aux of the caller BPF program. Any value passed into this argument
@@ -381,6 +381,48 @@ encouraged to make their use-cases known as early as possible, and participate
 in upstream discussions regarding whether to keep, change, deprecate, or remove
 those kfuncs if and when such discussions occur.
 
+2.5.9 KF_IMPLICIT_ARGS flag
+------------------------------------
+
+The KF_IMPLICIT_ARGS flag is used to indicate that the BPF signature
+of the kfunc is different from it's kernel signature, and the values
+for implicit arguments are provided at load time by the verifier.
+
+Only arguments of specific types are implicit.
+Currently only ``struct bpf_prog_aux *`` type is supported.
+
+A kfunc with KF_IMPLICIT_ARGS flag therefore has two types in BTF: one
+function matching the kernel declaration (with _impl suffix in the
+name by convention), and another matching the intended BPF API.
+
+Verifier only allows calls to the non-_impl version of a kfunc, that
+uses a signature without the implicit arguments.
+
+Example declaration:
+
+.. code-block:: c
+
+	__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
+						      void *map__map, bpf_task_work_callback_t callback,
+						      struct bpf_prog_aux *aux) { ... }
+
+Example usage in BPF program:
+
+.. code-block:: c
+
+	/* note that the last argument is omitted */
+        bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback);
+
+An exception to this are kfuncs that use __prog argument, and were
+implemented before KF_IMPLICIT_ARGS mechanism was introduced:
+  * bpf_stream_vprintk_impl
+  * bpf_task_work_schedule_resume_impl
+  * bpf_task_work_schedule_signal_impl
+  * bpf_wq_set_callback_impl
+
+These are allowed for backwards compatibility, however BPF programs
+should use newer API that omits implicit arguments in BPF.
+
 2.6 Registering the kfuncs
 --------------------------
 
-- 
2.52.0


