Return-Path: <bpf+bounces-22301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2FE85B763
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A496F1C24662
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ACA5FDC9;
	Tue, 20 Feb 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVNiM5T3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBD5FDDB
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421278; cv=none; b=TIHHeAWcrLluMr7FB9FxiB43ZHx8yJ0mCB/9Xp/5DJBKXzW+3tq0+lMLcoim3Q3K4YsEVINORN8wr48p6IVdX2brPdGYthnpKCfRJ7xsWc97gI/vw7gKgMvOQjMVui9movpkLdOQfuLZ8vCqiGYDfgb+XPgVad7OLqUzQhGv+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421278; c=relaxed/simple;
	bh=OZioy8AfLsmSlw0w0r3twrLcp1c+FgadOLiPu1XclVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxZZ33MWjGWhOBMBsPNi2sv0sSX20GXSAapgU/lYVI2K9m3UgZ80zDHpgnDcRJtBGBfqNNQwXo3lr+RAXxj7Xp3K24xatn8f5AU1zrD4oilalP9OgUd6CjlB4UA7Ide4bR0xVLC2+VbL/MaNHX3HDZfLa503FeI3fqqg+vymaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVNiM5T3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564a05ab3efso2037816a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421274; x=1709026074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXZ+DN3CcnefV4u4W5SMOCurbndJVv4wj08ijEsPqwU=;
        b=hVNiM5T3tLpYBBtr1KxqFFMwK/ZwjrMR9qQdzLR4N30JahneU+1pE/JmpVSKADItr7
         9bUksLderTjak8+ldH8OQfhWVct35aDklE1j2HgvHR4XsvBNA3EusxAmn/vjtQrE02Xt
         3j/bwzQBcY5skH07yrvBRKEveE5UnEpc1zX9laQSjeVZXz+iyGKjKRUv/KJJcIAPcZQj
         a30j3H3O3u3q8GQ/J2UNDphfZHw8bSSlWxYM+iVKEFdBdloEJjD6sk3Aa6ZLshmKG5xL
         m26jltMOkP39eqMGiyIZF4zpnBlFXNVprxWBgDwUGteHhS2w2ue0A69uvM4/igxW+dkP
         DHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421274; x=1709026074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXZ+DN3CcnefV4u4W5SMOCurbndJVv4wj08ijEsPqwU=;
        b=STYkzn3k/8mkl/XOvD/n84ZhSxqFOmXqmH4YqQUnNFqJT6aBH4mL91OCl6rGbQsK+q
         OCO7DywOA+jpStHPlJSikvycb9pluc5OfD4XhyWBPNovKv37ptVxGt8wryEWAKZhBblq
         qcQviDHFFe8f5/oS3KjvwPeWt/l5HM5CcyEsB6oJORiH1K+3iN8Gs5CfixX6ZAE/MEbq
         h8S2+7Bx557tCSwYaD8UBVXN+4862uWPMLMfcKv3Cx/e4MV3T4mzwHC5jTI0N/s/k19g
         maDgyYQ9a0pq/f74IT84ANk1SuaM9dINwwjLvHZsDU4jPthsiPLW/291s0SJQ9SGP94Q
         1K/A==
X-Gm-Message-State: AOJu0Yx+oAihN1soWbx/GDiC/DsTcPFpf4Ct94vWYPgskHW35gvoN9Qv
	jvc3t3TrD7TPEYig48heLNFlRR9zBIapW8BBw9tx01BTW2Ba4ugl61OLA/tLsTLvd2XXx6na+aA
	pOQ==
X-Google-Smtp-Source: AGHT+IHkFYDXFwT6cS1Y6ESD1QzbPdMU6iw9dKRUM8cEUuLz0d+G3e4wiXXNVR3TuLLPAbfiZ6GnYg==
X-Received: by 2002:a05:6402:40c4:b0:563:b7b4:a30e with SMTP id z4-20020a05640240c400b00563b7b4a30emr11299389edb.3.1708421274505;
        Tue, 20 Feb 2024 01:27:54 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7dc02000000b00564cb5a3c7esm338161edu.81.2024.02.20.01.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:54 -0800 (PST)
Date: Tue, 20 Feb 2024 09:27:50 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 04/11] bpf: add new acquire/release BPF kfuncs for
 mm_struct
Message-ID: <ac8e4dfb7c3438b488ca0478612e584800ee35de.1708377880.git.mattbobrowski@google.com>
References: <cover.1708377880.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708377880.git.mattbobrowski@google.com>

A BPF LSM program at times will introspect a mm_struct that is
associated with a task_struct. In order to perform this reliably, we
need introduce a new set of BPF kfuncs that have the ability to
acquire and release references on a mm_struct.

The following BPF kfuncs have been added in order to support this
capability:

struct mm_struct *bpf_task_mm_grab(struct task_struct *task);
void bpf_mm_drop(struct mm_struct *mm);

These newly added mm_struct based BPF kfuncs are simple wrappers
around the mmgrab() and mmdrop() in-kernel helpers. Both mmgrab() and
mmdrop() are used in favour of their somewhat similar counterparts
mmget() and mmput() as they're considered to be the more lightweight
variants in comparison i.e. they don't pin the associated address
space.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c45c8d42316c..d1d29452dd0c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1472,10 +1472,53 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
 }
 
+/**
+ * bpf_task_mm_grab - get a reference on the mm_struct associated with the
+ * 		      supplied task_struct
+ * @task: task_struct of which the mm_struct is to be referenced
+ *
+ * Grab a reference on the mm_struct associated with the supplied *task*. This
+ * kfunc will return NULL for threads that do not possess a valid mm_struct, for
+ * example those that are flagged as PF_KTHREAD. A reference on a mm_struct
+ * pointer acquired by this kfunc must be released using bpf_mm_drop().
+ *
+ * This helper only pins the underlying mm_struct and not necessarily the
+ * address space that is associated with the referenced mm_struct that is
+ * returned from this kfunc. This kfunc internally calls mmgrab().
+ *
+ * Return: A referenced pointer to the mm_struct associated with the supplied
+ * 	   *task*, or NULL.
+ */
+__bpf_kfunc struct mm_struct *bpf_task_mm_grab(struct task_struct *task)
+{
+	struct mm_struct *mm;
+
+	task_lock(task);
+	mm = task->mm;
+	if (likely(mm))
+		mmgrab(mm);
+	task_unlock(task);
+
+	return mm;
+}
+
+/**
+ * bpf_mm_drop - put the reference on the supplied mm_struct
+ * @mm: mm_struct of which to put the reference on
+ *
+ * Put the reference on the supplied *mm*. This kfunc internally calls mmdrop().
+ */
+__bpf_kfunc void bpf_mm_drop(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(lsm_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_mm_grab, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_mm_drop, KF_RELEASE);
 BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
 static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

