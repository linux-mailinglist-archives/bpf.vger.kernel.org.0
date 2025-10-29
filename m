Return-Path: <bpf+bounces-72860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A60C1CDF4
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D9A189B57D
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E27C358D07;
	Wed, 29 Oct 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Spyj6m29"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BDB35773C
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764521; cv=none; b=RfL6fWqW362ThZ489y/krOWzmp9cOEL6+6sU80eoVHVZn8ORzoxXduv9R36JJ0HM8LF5SmdPzehBZycfwLjmq+Q1/6GYq4F5dB+jL1sRMCwSrhIjQE2lbaFDJKSYei97AQD6pOejlHJJ5QFORThtEAlRJ8QbIpa4o/eu7fKOuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764521; c=relaxed/simple;
	bh=t6MWm5UxROMtfKS1x8WudEUL+e9P65gKgxv77krDvBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1lYyvruCakgUndiXroeI7my9MqclFdu+K6IupP/NitFxav1d71E1pB7n1E0vdnzaT/bkszBs9c38d7MaFBur2cDP4K9H+FPoP5LwWpxc5BHR5NqWFuG5Y6bybtwLsLmDpLxIzhMZ7rjNDUoy2JD6+jqDiEpP0+lgpGCnP2Ks3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Spyj6m29; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4AdH8Kg4bs8C+ee9O1PiZppXwLm9Yt0rKW8HHZaaQ8=;
	b=Spyj6m29ICbnOrsex2jqoIDNhqWv7hxd89s+131evOciMzKSW8bs9Jz07vT0LslXV/zfCK
	D70BX/5jd1frGOTU/mp8nr70KmXEH18gQsSUUsAGvQ/ZUh/JKeOopkZfOoeAdlJecLtyLs
	Kmd/EiyYbTsN/hz576lz5JvaZRxTfNs=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 6/8] bpf,docs: Document KF_MAGIC_ARGS flag and __magic annotation
Date: Wed, 29 Oct 2025 12:01:11 -0700
Message-ID: <20251029190113.3323406-7-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add sections explaining KF_MAGIC_ARGS kfunc flag and __magic argument
annotation. Mark __prog annotation as deprecated.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 49 +++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index e38941370b90..1a261f84e157 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -160,7 +160,7 @@ Or::
                 ...
         }
 
-2.2.6 __prog Annotation
+2.2.6 __prog Annotation (deprecated, use __magic instead)
 ---------------------------
 This annotation is used to indicate that the argument needs to be fixed up to
 the bpf_prog_aux of the caller BPF program. Any value passed into this argument
@@ -177,6 +177,37 @@ An example is given below::
                 ...
          }
 
+.. _magic_annotation:
+
+2.2.7 __magic Annotation
+---------------------------
+This annotation is used in kfuncs with KF_MAGIC_ARGS flag to indicate the
+arguments that are omitted in the BPF signature of the kfunc. The actual
+values for __magic arguments are set by the verifier at load time, and
+depend on the argument type.
+
+Currently only ``struct bpf_prog_aux *`` type is supported.
+
+Example declaration:
+
+.. code-block:: c
+
+	__bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
+					    int (callback_fn)(void *map, int *key, void *value),
+					    unsigned int flags,
+					    struct bpf_prog_aux *aux__magic)
+	{
+		...
+	}
+
+Example usage:
+
+.. code-block:: c
+
+	/* note the last argument is omitted */
+	if (bpf_wq_set_callback(wq, callback_fn, 0))
+		return -1;
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
@@ -374,6 +405,22 @@ encouraged to make their use-cases known as early as possible, and participate
 in upstream discussions regarding whether to keep, change, deprecate, or remove
 those kfuncs if and when such discussions occur.
 
+2.4.10 KF_MAGIC_ARGS flag
+------------------------------------
+
+The KF_MAGIC_ARGS flag is used to indicate that the BPF signature of the kfunc
+is different from it's kernel signature, and the values for arguments annotated
+with __magic suffix are provided at load time by the verifier.
+
+A kfunc with KF_MAGIC_ARGS flag therefore has two types in BTF: one function
+matching the kernel declaration (with _impl suffix by convention), and another
+matching the intended BPF API.
+
+Verifier allows calls to both _impl and non-_impl versions of a magic kfunc.
+
+Note that only arguments of particular types can be __magic.
+See :ref:`magic_annotation`.
+
 2.5 Registering the kfuncs
 --------------------------
 
-- 
2.51.1


