Return-Path: <bpf+bounces-41530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A05997B87
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 05:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72BA1F22815
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F5192B69;
	Thu, 10 Oct 2024 03:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUxnEyP6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD75028C;
	Thu, 10 Oct 2024 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532621; cv=none; b=Lx3xaWCaGugHR7+7kmzGNTlI3H8pB9Y5EwWWPQOwIYLDVrHR24nbXGzjNaLtqZ2y6up2K2Elf7xvbtd4hjEKgrpY7/cvm9irh5BT4ia9XFX2lun9Tfpn7R5ay212yxgh4W9EbovimGVggLrK6Q7uzNHp9DzcB73ddeqnguV9vxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532621; c=relaxed/simple;
	bh=c69vCHD9sXglxFuU3cVQfkkP0kz++Bt/tDJFXTJAkGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gj9ALIPI3T2i4XsGLtGxE6pqH0Jtiz8R5wh48WUP1T56eVU/ivZBWzdyoi/hOc1bq6StsCqc5yRb82/BJUfeLb5+KzQ+iUHCF03H35XhkgawVK3Thfsai5WrI/lc1xiE4EhQ480/oBckdq7oYA/3bKUNJdN0MJ4c6fropPqMres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUxnEyP6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so3490625e9.1;
        Wed, 09 Oct 2024 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728532617; x=1729137417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIK6iHiUU8vNnmDPHqJUi9UmAD/kMAdpbZF6z5E3nlg=;
        b=PUxnEyP6kG7g4bZYFpSv3UP/rot5y3RcdU/mc1tZj5mz2WBerVs/GaMKsUy2ZucTu0
         cI/vVzpzkGff5VbItHOovMUCpbNT/SmUKW2NwO410ypO59YpJufCnCvLLExJSAk2wnuD
         Ma07zFQwydqeGrQJcq+DcPQ2xBwGJmHwRH5UednXmxDIo5djtZnmxDI9PoP5gpUYhA5V
         1BUUcAxRlWvlUL5ZKht70KHfkDUmYX8TZD875VrQdMipMM3QSQo7K28iGbpa0FNMVhdE
         C13qXI3VLEDWrENvY0H+QxWgoHHWlkp7hvhZAN3hgFV8e9vOuNaIMFVbHe66JrJOZfoV
         nvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728532617; x=1729137417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIK6iHiUU8vNnmDPHqJUi9UmAD/kMAdpbZF6z5E3nlg=;
        b=mHB0JPvgWQpZ3Vh8RBlNsLggbrQKp9NaIQ3jE/fYg0dhW7pkt53VfeKWG2K7kIyh4n
         bHsxsxT5z1nQhHkV/P1gplpfjJVWw1ugfP+nytWOCRNB6huT4QxFtg4Rv9JaR2h5+bgX
         MJ2k9+fyroaxVzrTYSdJ7C3PtcJpzGm0036GF6lvgy6P2Q3Ln+uG9YSdVOzsRrrqmFzn
         zpy/nDYj4lZLF7+YRvcX4AtRtQ7C/0SojfdX/NDfPlIeA4F7hKWOcCvA2YoP9aapG5h6
         wsye1vWRP26lv8mg2a5UvJ0cBzxcp+l0Nmx/MpxYvvkHPp5Epk7bkdHp4CFVE+/vJlBe
         YOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS9Fv+mILmcW6erfOoQvsZUDrHw++JhTekcznFpQgXlcN1QMP1uv2Gf3uJSk5dug+pAk4=@vger.kernel.org, AJvYcCXDOSw9xEoerXQ2LfMYd4Zylm4iLhW5Q82ocz0it3lzpRywwkGu3OfQzOd0zKGTx0VxM2evH/HQXdvGB6m6@vger.kernel.org
X-Gm-Message-State: AOJu0YwMF3t1muA7yf8HCszziB3Zbz0Iwc+ytMahCsdsauHigTAAxuiu
	ZIV9UkLnizWinHNLOPlWCXA3L53GLc4omRss0f0X7rhVlu10rP/3
X-Google-Smtp-Source: AGHT+IF2PPPAibzydI13yi59X74PcyvhPrQFB548ORc0y0pRt0MzmM/lGezSHvyjE3CG9Cr9BfeMyQ==
X-Received: by 2002:a05:600c:8707:b0:42c:ae4e:a990 with SMTP id 5b1f17b1804b1-430d748ca2dmr31731065e9.35.1728532617099;
        Wed, 09 Oct 2024 20:56:57 -0700 (PDT)
Received: from teknoraver-mbp.access.network ([89.101.6.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf5188dsm35659375e9.24.2024.10.09.20.56.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Oct 2024 20:56:56 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf v2] bpf: fix argument type in bpf_loop documentation
Date: Thu, 10 Oct 2024 04:56:52 +0100
Message-ID: <20241010035652.17830-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

The `index` argument to bpf_loop() is threaded as an u64.
This lead in a subtle verifier denial where clang cloned the argument
in another register[1].

[1] https://github.com/systemd/systemd/pull/34650#issuecomment-2401092895

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 include/uapi/linux/bpf.h       | 2 +-
 kernel/bpf/verifier.c          | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8ab4d8184b9d..874af0186fe8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5371,7 +5371,7 @@ union bpf_attr {
  *		Currently, the **flags** must be 0. Currently, nr_loops is
  *		limited to 1 << 23 (~8 million) loops.
  *
- *		long (\*callback_fn)(u32 index, void \*ctx);
+ *		long (\*callback_fn)(u64 index, void \*ctx);
  *
  *		where **index** is the current index in the loop. The index
  *		is zero-indexed.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d9b38ffd220..cfc62e0776bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9917,7 +9917,7 @@ static int set_loop_callback_state(struct bpf_verifier_env *env,
 {
 	/* bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx,
 	 *	    u64 flags);
-	 * callback_fn(u32 index, void *callback_ctx);
+	 * callback_fn(u64 index, void *callback_ctx);
 	 */
 	callee->regs[BPF_REG_1].type = SCALAR_VALUE;
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7610883c8191..5937c39069ba 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5371,7 +5371,7 @@ union bpf_attr {
  *		Currently, the **flags** must be 0. Currently, nr_loops is
  *		limited to 1 << 23 (~8 million) loops.
  *
- *		long (\*callback_fn)(u32 index, void \*ctx);
+ *		long (\*callback_fn)(u64 index, void \*ctx);
  *
  *		where **index** is the current index in the loop. The index
  *		is zero-indexed.
-- 
2.46.0


