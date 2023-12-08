Return-Path: <bpf+bounces-17190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD580A777
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7AC1C20AC5
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A548315AE;
	Fri,  8 Dec 2023 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NPY8g95W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A8510EB
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 07:32:53 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1ef2f5ed02so221636766b.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702049572; x=1702654372; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7e0LAup17g0NCNSVw+obiVHzl5PDTKf4AJltQUn8U4o=;
        b=NPY8g95WN9BlEcRj5JDTMwLBX2abMfE99p+H714Iasd7RV77rw8WZNb3b9TRUmdATX
         AzEUlRxOoH3D2G8jADFTlnpJvyNK3KD1+AYgtifZm2ASFQPUFWooYVacDNmpOgkp3rgK
         bpwt8K2ebcJwk1rZzc0snHPfwCjdyArB1tGsRrl4kk1JtENsO0yO9z3Cu2El1DQAaK2r
         EFd3Rr/Smb1dtAcemJo5p8+FFPNLZSrJXg5rPO0DpQwVh9zRI8f5mDgNxrEQpD0t57YL
         BRLSaLBok1HJ+4p1vaqrzx6fupPb7GAJV0kRrpwEOdh2274IJevMuYfjg55ryzofmW4t
         jqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049572; x=1702654372;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e0LAup17g0NCNSVw+obiVHzl5PDTKf4AJltQUn8U4o=;
        b=RnvZ7C4lx6F24kNCXOGLQshefuJDcvCC5+SQDKghLBhsAa0NdBHH6ZxHPEn+OQkid9
         AK/Bn9BgZrL9AFbjcmKH6L6JnqXISmgsswBckP2Jb7zTsd/k5ZZ93nLghJTyauw9Wc+l
         Ob8Vv4gK0AHnGpciQnuajixIZy/Dzduawg5V4XMYyBV69sm3NZntgRprSNu95pOszFTA
         qkM+sngyRoqlDk6j7kgDhnU7AUO+ATlyxoZm2QShe0dOezWljH/6v5Zt5H6bBL9OnuZ2
         CO1Qel20En5zZOhEAHuD/GJ1mgn/y/me0lzmC9QK/3Y+1hYh6qZxU6VhZUlY5rZz7BVL
         iANA==
X-Gm-Message-State: AOJu0Yy0RSQbM4yI6yqbsACgE78mAZK6F9FbaaIVQXoHoHbDP2KE/AkW
	oB64jFufO4LbBewwxhKCdwKfoQ==
X-Google-Smtp-Source: AGHT+IEOJXwDu0ftXR4iOSS0n4hmovnrh3fbopcKujhlKJmV/fxmLyIilVbCbW7y01z4IzCvMLtudQ==
X-Received: by 2002:a17:906:1b17:b0:a1d:20:836d with SMTP id o23-20020a1709061b1700b00a1d0020836dmr67512ejg.149.1702049572244;
        Fri, 08 Dec 2023 07:32:52 -0800 (PST)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090699d200b00a0c3b122a1esm1127367ejn.63.2023.12.08.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:32:51 -0800 (PST)
Date: Fri, 8 Dec 2023 15:32:48 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: revest@chromium.org, jackmanb@chromium.org, yonghong.song@linux.dev,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next] bpf: add small subset of SECURITY_PATH hooks to BPF
 sleepable_lsm_hooks list
Message-ID: <ZXM3IHHXpNY9y82a@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

security_path_* based LSM hooks appear to be generally missing from
the sleepable_lsm_hooks list. Initially add a small subset of them to
the preexisting sleepable_lsm_hooks list so that sleepable BPF helpers
like bpf_d_path() can be used from sleepable BPF LSM based programs.

The security_path_* hooks added in this patch are similar to the
security_inode_* counterparts that already exist in the
sleepable_lsm_hooks list, and are called in roughly similar points and
contexts. Presumably, making them OK to be also annotated as
sleepable.

Building a kernel with DEBUG_ATOMIC_SLEEP options enabled and running
reasonable workloads stimulating activity that would be intercepted by
such security hooks didn't show any splats.

Notably, I haven't added all the security_path_* LSM hooks that are
available as I don't need them at this point in time.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/bpf_lsm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 7d2f96413a57..63b4dc495125 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -304,6 +304,18 @@ BTF_ID(func, bpf_lsm_kernel_module_request)
 BTF_ID(func, bpf_lsm_kernel_read_file)
 BTF_ID(func, bpf_lsm_kernfs_init_security)
 
+#ifdef CONFIG_SECURITY_PATH
+BTF_ID(func, bpf_lsm_path_unlink)
+BTF_ID(func, bpf_lsm_path_mkdir)
+BTF_ID(func, bpf_lsm_path_rmdir)
+BTF_ID(func, bpf_lsm_path_truncate)
+BTF_ID(func, bpf_lsm_path_symlink)
+BTF_ID(func, bpf_lsm_path_link)
+BTF_ID(func, bpf_lsm_path_rename)
+BTF_ID(func, bpf_lsm_path_chmod)
+BTF_ID(func, bpf_lsm_path_chown)
+#endif /* CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_KEYS
 BTF_ID(func, bpf_lsm_key_free)
 #endif /* CONFIG_KEYS */
-- 
2.43.0.472.g3155946c3a-goog

/M

