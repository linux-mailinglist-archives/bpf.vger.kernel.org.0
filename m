Return-Path: <bpf+bounces-69622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC95B9C415
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E402A3279D2
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF69028724D;
	Wed, 24 Sep 2025 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g+C9gk4X"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D02417E6
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748665; cv=none; b=QNKq2h1DAUlWsO2c13RrwyvccSGfBV5etUZ/cEcr3/+sxJUs9GEBdsVvUl9Lu4AEhhg8oTeK2/QDs7x4YB0LGAdY84ts6I4rHLIczpQ2/6VmWDK49UpE0fgCMwlNfKbbHYqE/G/HHlVt2yta6rLd/9lWydgjazBgqqOfbItH8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748665; c=relaxed/simple;
	bh=3IDhPc38RJCqvih6fZIb08mtHUvhUbF6OXJdDllvz5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0ELBs90wLH/GEaYx8lbRv7+b8QXlYoMVXw/KFkRutrtreENVGFwuPEuw1KaZnnhrFB3gXtq9NtfexzIRJkfXMDSV9fs6ARPAGqYuqsUmJm8BcbG851Kejzb4iQQVpX1Muo6vZU3SEFozzjWqwvBM5TWtPxKWSy5BjZJBXwQjlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g+C9gk4X; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758748662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rtw740UVlePHnNJHSehP2wVmWrZailmwDbfQueAecc=;
	b=g+C9gk4XRkwIzG9/+c4NvXQxhXklNVqre2hwASRkTFg8FGnXJCS02kcLa+FWOgr9JY4XaB
	DnkU3MUm9mLm6GEAuwf56kPj56SWWN17XSdPqoYjmjvdVQ5gnP0GynQGcPSB6pF1CMtwmw
	Lng7l4KxrMG2nAn+y+tFHE3P7kdAR8s=
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
Subject: [PATCH bpf-next v1 2/6] bpf,docs: Add documentation for KF_IMPLICIT_PROG_AUX_ARG
Date: Wed, 24 Sep 2025 14:17:12 -0700
Message-ID: <20250924211716.1287715-3-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a section explaining KF_IMPLICIT_PROG_AUX_ARG kfunc flag.
Mark __prog annotation as deprecated.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 39 +++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index e38941370b90..cc04ffd9a667 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -160,7 +160,7 @@ Or::
                 ...
         }
 
-2.2.6 __prog Annotation
+2.2.6 __prog Annotation (deprecated, use KF_IMPLICIT_PROG_AUX_ARG instead)
 ---------------------------
 This annotation is used to indicate that the argument needs to be fixed up to
 the bpf_prog_aux of the caller BPF program. Any value passed into this argument
@@ -374,6 +374,43 @@ encouraged to make their use-cases known as early as possible, and participate
 in upstream discussions regarding whether to keep, change, deprecate, or remove
 those kfuncs if and when such discussions occur.
 
+2.4.10 KF_IMPLICIT_PROG_AUX_ARG flag
+------------------------------------
+
+The KF_IMPLICIT_PROG_AUX_ARG flag is used to indicate that the last
+argument of a BPF kfunc is a pointer to struct bpf_prog_aux of the
+caller BPF program, implicitly set by the verifier.
+
+If a kfunc is marked with this flag, the function declaration in the
+kernel must have ``struct bpf_prog_aux *`` as the last argument.
+However in the kernel BTF (produced by pahole) this argument will be
+omitted, making it invisible to BPF programs calling the kfunc.
+
+Note that the implicit argument is an actual BPF argument passed
+through a register, reducing the number of the available function
+arguments.
+
+Example declaration:
+
+.. code-block:: c
+
+	__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
+						void *map__map, bpf_task_work_callback_t callback,
+						struct bpf_prog_aux *aux)
+	{
+		return bpf_task_work_schedule(task, tw, map__map, callback, aux, TWA_RESUME);
+	}
+
+	BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS | KF_IMPLICIT_PROG_AUX_ARG)
+
+Example usage:
+
+.. code-block:: c
+
+	/* note the last argument is ommitted */
+	bpf_task_work_schedule_resume(task, &tw, &hmap, process_work);
+
+
 2.5 Registering the kfuncs
 --------------------------
 
-- 
2.51.0


