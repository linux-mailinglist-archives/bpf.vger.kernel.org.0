Return-Path: <bpf+bounces-79338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE1D38752
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E550D3047C95
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6003A7843;
	Fri, 16 Jan 2026 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hH/xdhYA"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E853A4AC1
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594715; cv=none; b=m4coa9MCSECoYRcorSvvbwJJxD5ZIY7w9/hjI8KrmqE9RX3itFGLukvCVeom1Kyj+HtjRgyuYNKU+zsQsm97Bm8uYNGjHV8sFmKhRJaXruI1AEXlLtMrpzz1Ci/wjNiKRkfjOQ6jFmGFso2V+ZTzjTy4790Q0KPCY2jaxfRhOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594715; c=relaxed/simple;
	bh=6g4MFCyn0InZsYBBiZi2fxd9iAJrrdGPEUCAbG9AYTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwR7SggxPCkFxtUd3Yh2TPyTx6eBkuUjeEMGe8cChWhVN2fXLD9wdpCuqY0VhzojWvcj/xBDQgkuMqvDbqAJP6vr3YauY0l9Jrjt5LmMvzXX148mh/2x8Y/ekA85ajSxBcQnvUztAv8oYtMATVLgVM7pjxdujKbUBfI3i56XGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hH/xdhYA; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768594707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwz6Xowq2w+xpgQwCp0JYB93ToE2U9fbiwcFD+udSuM=;
	b=hH/xdhYAlAe3eUh9/LRjYJ67vilIG9fgfC6Xjut5axGW9ptlwjxIKY6IVrXQ2o2LiKbXMM
	qJxlEQo0v47lk8qmMwHkN2cbCHZP7udScVXXK3KLcfphw2VnEjnULMsBTYJ3oG641xSh6A
	cdWSOgmk7dmutydLwL3Yr8RULIg0B3I=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v2 13/13] bpf,docs: Document KF_IMPLICIT_ARGS flag
Date: Fri, 16 Jan 2026 12:17:00 -0800
Message-ID: <20260116201700.864797-14-ihor.solodrai@linux.dev>
In-Reply-To: <20260116201700.864797-1-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a section explaining KF_IMPLICIT_ARGS kfunc flag. Remove __prog
arg annotation, as it is no longer supported.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 49 +++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 3eb59a8f9f34..75e6c078e0e7 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -232,23 +232,6 @@ Or::
                 ...
         }
 
-2.3.6 __prog Annotation
----------------------------
-This annotation is used to indicate that the argument needs to be fixed up to
-the bpf_prog_aux of the caller BPF program. Any value passed into this argument
-is ignored, and rewritten by the verifier.
-
-An example is given below::
-
-        __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-                                                 int (callback_fn)(void *map, int *key, void *value),
-                                                 unsigned int flags,
-                                                 void *aux__prog)
-         {
-                struct bpf_prog_aux *aux = aux__prog;
-                ...
-         }
-
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
@@ -381,6 +364,38 @@ encouraged to make their use-cases known as early as possible, and participate
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
 2.6 Registering the kfuncs
 --------------------------
 
-- 
2.52.0


