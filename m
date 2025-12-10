Return-Path: <bpf+bounces-76404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC04CB27F5
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 10:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F0E31354C8
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEAC305065;
	Wed, 10 Dec 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMuORFHk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD3302147
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357630; cv=none; b=gQSEJIRORclODw11u6FTmNvPpNyjdjBkG/uM4j/Trclo2QtlsBdIDg0Bfk/adj9N/cn6ih6jPrxx4cT+qAGr0uuU1a6sf/Q2TzsKwYUp1ktyWxkJOmRWQx/NFc/DAJPFflBs0bkBLk3TtY/6EQgMAfXj2d21Nv6fr/WcdO031Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357630; c=relaxed/simple;
	bh=2h3JSfAbfe1Dhdl8+XSXbyduEsq7E2Ncj7zLOY8VzKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LfSCkVwxzzw/Hlaw/v7uy63ofruzz/lbKEyrHoet8N9CsiJ7oYaly9nFtC8THNQOJymLMsO586iVKOGfMy5CwDqD9+SH0fC4v/JIiS8lhNI+hTkslY4luhQgO2Vd+ur/PvYD0CaXSrIIKKfiQRlYqlDRJeLK6ktRLfLCF5P12vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMuORFHk; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6495cc3e622so1368677a12.2
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 01:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765357627; x=1765962427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHTQNoiSSZhsLkS8cDL7t4o2J4GfKCgKz2OsjlbZ4xM=;
        b=HMuORFHkootAY3BQPY70+Ch0PTDZZnB5ilhnQNeXTmXlyU/LzsKd+kMugG98w+dqW/
         0A2/lcSWHGSodlMXaeWGCuP59aGu/mKxBzq17+EpKlqwWoVh7GSOZajmCV3xMKiI3h7t
         s1q0wiAvJUDzjx3JXjG5sa/tJmpUAAe1WXyA8tKuWeqOkQnPdIHByG02863NOqWJ9Zcv
         xezVtQiOkEkMSqPGNGVuoY6zh1W5Rd9g13922W43cD2MTsAuiGcV4+0H5JKx7uW/WJXI
         xgtbvdRC0g+ggVidT4ucxTaZS/Cqm+S1gq4qpUBmork5hv3G1C4BDaKFZ5H3zVTv4Fzk
         q36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765357627; x=1765962427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHTQNoiSSZhsLkS8cDL7t4o2J4GfKCgKz2OsjlbZ4xM=;
        b=f3ScShKVvGJK/ytP6YOcb00TqZL1yguQUajCuajc5Q2bSBfmroDeWCc8iXTZ3VjMQW
         ksN/74IV//BghC0EqKcYm7seiuOvnlqqifNhAerzn/04zsTI3tV93y1ZamhLZhfW8ShS
         8mvUNy2RRc2naJD4B01qFburAMCGRM0vOsGQ9jW10+CrMun/a2hLJApA6A8ucIprIpj9
         M2Bboe6S9wsl2BDrdQridyFa7w+yYf5Galku129hT2eQSZ+cIB0Lp2Yh4xSrpGor5x+4
         54k/pa1/omhAOfLCWSqQARbqklinubliUhnb8SNW0voylDI5MZADXWVxWOKbmQ8tRgoB
         Pd5A==
X-Gm-Message-State: AOJu0Yytp/Yk+h3g+xW8+BgZZJFSFSTVrA5BHeXREhaDGzcbuhbe2pkT
	6OJfdboqaJR0A5oVaHIFxnYcEcYYexbJLgClWW+Ra9M2qHiTry0pkT9OeXP0h4qG8t07jkZ/l6o
	lF2YkFAakxgqqEuc7v1y3puzDXsggI4XAnGvjrlKdd9DWsyEb/Q6AzTbDQxC7Y4v0tWuRWAcKy2
	P9UKUxTexBbGSTdQFbZktYw102rIT+NX43e71FAcxV2plWXH4lHRD0ltxoDnQl3H/qxk1EVA==
X-Google-Smtp-Source: AGHT+IHUVNieAZA+vbqiyBsX0cH4kc1i1EFe8VRp3fJcWjdRw2FnXco7uu05raIpGPC/Bbbw/YoZYSafJKIO/HXoZBgK
X-Received: from edbij16.prod.google.com ([2002:a05:6402:1590:b0:63e:23c6:7845])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:40c9:b0:649:563d:da6e with SMTP id 4fb4d7f45d1cf-6496d5b2459mr1577656a12.23.1765357627266;
 Wed, 10 Dec 2025 01:07:07 -0800 (PST)
Date: Wed, 10 Dec 2025 09:07:01 +0000
In-Reply-To: <20251210090701.2753545-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251210090701.2753545-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251210090701.2753545-2-mattbobrowski@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add test case for BPF LSM hook bpf_lsm_mmap_file
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Josh Don <joshdon@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a trivial test case asserting that the BPF verifier enforces
PTR_MAYBE_NULL semantics on the struct file pointer argument of BPF
LSM hook bpf_lsm_mmap_file().

Dereferencing the struct file pointer passed into bpf_lsm_mmap_file()
without explicitly performing a NULL check first should not be
permitted by the BPF verifier as it can lead to NULL pointer
dereferences and a kernel crash.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/progs/verifier_lsm.c        | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index 6af9100a37ff..38e8e9176862 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 
 SEC("lsm/file_permission")
@@ -159,4 +160,32 @@ __naked int disabled_hook_test3(void *ctx)
 	::: __clobber_all);
 }
 
+SEC("lsm/mmap_file")
+__description("not null checking nullable pointer in bpf_lsm_mmap_file")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(no_null_check, struct file *file)
+{
+	struct inode *inode;
+
+	inode = file->f_inode;
+	__sink(inode);
+
+	return 0;
+}
+
+SEC("lsm/mmap_file")
+__description("null checking nullable pointer in bpf_lsm_mmap_file")
+__success
+int BPF_PROG(null_check, struct file *file)
+{
+	struct inode *inode;
+
+	if (file) {
+		inode = file->f_inode;
+		__sink(inode);
+	}
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0.223.gf5cc29aaa4-goog


