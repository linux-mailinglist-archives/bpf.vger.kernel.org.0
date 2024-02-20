Return-Path: <bpf+bounces-22305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E599385B76F
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3234286D4D
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3E604B1;
	Tue, 20 Feb 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1noG1LsA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7395FBAD
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421310; cv=none; b=H3VSHx2afJiIrmeOauAuwsrYJ+akz8O4+OiGDCq08VZkpbRQtVncYXShoqhN61gc7kKdYkjVLVZLrysaVMUuWByFRCH6hcVea0M8NQrN7Q948R+bcT6BreHuA4z1HCWwq5lDOnIENTMW+Saya8u/q6LVhp6V4Safm2SUvGAsTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421310; c=relaxed/simple;
	bh=EhRdG8Bffj4HR/2Z9RI+Xs1DgKmtukN31L0orRuOgMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQnjGzpzmlJrcY2m+leC1+REP3P/SO0xaQWqVBo3gmjSHhgOlPCmjH1Nc1ordR9oMZ3NaaP26vJ6tUeu6iCCcBVX18TfaeSiRXv2hwytpV9UDg1sDLWNbrNHw72pfXewto7LXFia0IWL7WSiXmiwL7dAHiAmvss7uoK7PmRkmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1noG1LsA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564d332bd73so322216a12.3
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421307; x=1709026107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNhsno5HhiSi6Kp2q/Iucw8xWVpCBEX2HNzCiTZBy3o=;
        b=1noG1LsA+TZSfMTt51IPdqAzLW4use5siGY7tO8jp1nc3mCXHDN39aQ5H8X7Qfiztb
         wBV5ZJ8rrk+o04D77w5XPeB2NyPJfKQF34a5ewm/CUcwAPpAN9nn8aRN8jMSJXLFNUBs
         NU4LpMyJLnQK7kw1LvaTD1L8KgoKfUfeVNwfH9p9TGwThQiSwQZF20peCW4gl2yLYfNP
         o8eUNGSjgo5LMhE+0qX2sfAWxVoSM9va6Sxi7p0SBjt5UD7g2Lam7mtiLzZzoLxHgSN0
         Rju54j/NrTHQoNUd6hHDv/I7neNN0qaYxeFf8eQAYZ8VVqdHg7QyQX/WBW5HY/xKwtSK
         ZJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421307; x=1709026107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNhsno5HhiSi6Kp2q/Iucw8xWVpCBEX2HNzCiTZBy3o=;
        b=UYgYzpgvoLvKhfM0d5LUOdbvJjpLS26En30KO5OFxHZCFf6qZAGr/csi7mvpWR/ELX
         AQAdwOojZj3UCqvS16+NoMrDOckh3j/0RpPrZ0bZH90EscVGuJupqXX3S+M+0Ks7DG5G
         h8KXUAydGNzc+4g4S9rz5hihT2bi1vNf4Q9hm6AUZP40Hj2X4FXd+gEk9WGL5s2jCk6+
         JVa+eZdCOv2ljZlkD70cUI5EfRNerWRxCIhjcxxQ2LFXFRQACYknhFRUzo/a1xUFcmgK
         yPvHoBpaOGS4ZIzLo2bFE19kj+WpVk/9LM9nhD8hytT5WyQm7wNcXI15E9OCkWMkxndP
         220w==
X-Gm-Message-State: AOJu0Yyq5zWmYLhjDvVd8Kedw5dR+Frlt4M8t5bSPTHPQ4Rf+w7jHyfF
	umxIQ1KrfM0bscd7zP7giwzjmYEstAG6CxSFmfDAHqmw145fS3KEOAh7owdDF1kvbK5+xLloCq3
	U4Q==
X-Google-Smtp-Source: AGHT+IG8xJfeMBOIFOzJE04kz5nK7k/hdFcuo9pPdlEXe65Ue0XcRKNWu/hcJDmHHreDuWqSzOqkHg==
X-Received: by 2002:aa7:d892:0:b0:564:50c7:20d with SMTP id u18-20020aa7d892000000b0056450c7020dmr4066362edq.34.1708421306801;
        Tue, 20 Feb 2024 01:28:26 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id cf28-20020a0564020b9c00b00564761ca19fsm1784597edb.29.2024.02.20.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:28:26 -0800 (PST)
Date: Tue, 20 Feb 2024 09:28:22 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 08/11] bpf: add acquire/release based BPF kfuncs for
 fs_struct's paths
Message-ID: <33108b72903162baa8eb39e047e6a9f50a890a2b.1708377880.git.mattbobrowski@google.com>
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

Add the ability to obtain a reference on a common set of path's that
are associated with a task_struct's fs_struct. Both fs_struct's root
and pwd paths are commonly operated on in BPF LSM programs and at
times handed off to BPF helpers and such. There needs to be a
mechanism that supports BPF LSM programs to obtain stable handle to
such in-kernel structures.

We provide that mechanism through the introduction of the following
new BPF kfuncs:

struct path *bpf_get_task_fs_root(struct task_struct *task);
struct path *bpf_get_task_fs_pwd(struct task_struct *task);
void bpf_put_path(struct path *path);

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fbb252ad1d40..2bb7766337ca 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -10,6 +10,7 @@
 #include <linux/bpf_perf_event.h>
 #include <linux/btf.h>
 #include <linux/filter.h>
+#include <linux/fs_struct.h>
 #include <linux/uaccess.h>
 #include <linux/ctype.h>
 #include <linux/kprobes.h>
@@ -1557,6 +1558,83 @@ __bpf_kfunc void bpf_put_file(struct file *f)
 	fput(f);
 }
 
+/**
+ * bpf_get_task_fs_root - get a reference on the fs_struct's root for the
+ * 			  supplied task_struct
+ * @task: task_struct of which the fs_struct's root path to get a reference on
+ *
+ * Get a reference on the root path associated with the supplied *task*. The
+ * referenced path retruned from this kfunc must be released using
+ * bpf_put_path().
+ *
+ * Return: A referenced path pointer to the fs_struct's root of the supplied
+ * *task*, or NULL.
+ */
+__bpf_kfunc struct path *bpf_get_task_fs_root(struct task_struct *task)
+{
+	struct path *root;
+	struct fs_struct *fs;
+
+	task_lock(task);
+	fs = task->fs;
+	if (unlikely(fs)) {
+		task_unlock(task);
+		return NULL;
+	}
+
+	spin_lock(&fs->lock);
+	root = &fs->root;
+	path_get(root);
+	spin_unlock(&fs->lock);
+	task_unlock(task);
+
+	return root;
+}
+
+/**
+ * bpf_get_task_fs_pwd - get a reference on the fs_struct's pwd for the supplied
+ * 			 task_struct
+ * @task: task_struct of which the fs_struct's pwd path to get a reference on
+ *
+ * Get a reference on the pwd path associated with the supplied *task*. A
+ * referenced path returned from this kfunc must be released using
+ * bpf_put_path().
+ *
+ * Return: A referenced path pointer to the fs_struct's pwd of the supplied
+ * *task*, or NULL.
+ */
+__bpf_kfunc struct path *bpf_get_task_fs_pwd(struct task_struct *task)
+{
+	struct path *pwd;
+	struct fs_struct *fs;
+
+	task_lock(task);
+	fs = task->fs;
+	if (unlikely(fs)) {
+		task_unlock(task);
+		return NULL;
+	}
+
+	spin_lock(&fs->lock);
+	pwd = &fs->pwd;
+	path_get(pwd);
+	spin_unlock(&fs->lock);
+	task_unlock(task);
+
+	return pwd;
+}
+
+/**
+ * bpf_put_path - put the reference on the supplied path
+ * @path: path of which to put a reference on
+ *
+ * Put a reference on the supplied *path*.
+  */
+__bpf_kfunc void bpf_put_path(struct path *path)
+{
+	path_put(path);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(lsm_kfunc_set_ids)
@@ -1568,6 +1646,11 @@ BTF_ID_FLAGS(func, bpf_get_task_exe_file,
 BTF_ID_FLAGS(func, bpf_get_mm_exe_file,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_get_task_fs_root,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_task_fs_pwd,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_path, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
 static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

