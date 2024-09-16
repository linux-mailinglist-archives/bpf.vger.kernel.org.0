Return-Path: <bpf+bounces-39987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC9A979E3C
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5ADB22CF6
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDAA1494B0;
	Mon, 16 Sep 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhEri4Jm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F81487F6
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478299; cv=none; b=WCI1EUkdZvmx1aV+JTXl3TBzo3R0obvSP+bbgJcjyP1S/59a1opXjVY0V7ofWbEmtlDdlKLtgJjsLb6j4GxJTRi+M4C8Xf348aCbpUWTRH8ub7Bp736jvOjcPGV2jOt0UloTzsysuErx64z6HhnkZMHuB16Y4eB17nbg607cqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478299; c=relaxed/simple;
	bh=M+7UL8d04qhsgdQdN2RQmEcqgaTkkMYJY8c78p0Q5Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfYYn4d417ku1DQl4l05ghk6YCAx1mspioANe44HPQmW6l9ZrUjlyK7n8hWh0s4EaEGwNvMMwcpzSzEG35JJEBSjo+aMYY2wOuhL8BPKCJJoJ+I7c6JbFpOV/kEfHS4HN4SPPit+tgtXPMPYUhxZhY7vMyrCmP0MxP6XRRXZmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhEri4Jm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053525bd90so25255645ad.0
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726478297; x=1727083097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/rozymKMXpW9VjNOX8o5rulBbaugK9GR2rx/PyIg5M=;
        b=hhEri4Jmkru0VIYr4JxIB3Ag5iMj/4zbHyPUBx3cKtpte1PyIce3AdprekN0xZZR7+
         oWq3JsYwJuvvuzRTVBhg8zo4fUGmqu28JlhGbIKDtgn14o9WovSHQkgU1BT25UDz0FKn
         xtCRhSk0EZMjkYieXQvupP8oNWjocLkSQLaSrIxLKAGO9nBx6tKVrzpxxXg4vxEhFARE
         VdciQu6OQGXxrW9neftCMisvD94a1Rejp2Scm+XlfYPGQtf2QU5ybr9YK3IIDTzq+vrI
         9AhwxIjOdOLKbYjZEjKC99yMx3Eb+a2u6wsAV2xyfb9EU6f2KK7dkDl4MpzrunF1PqtL
         EY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478297; x=1727083097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/rozymKMXpW9VjNOX8o5rulBbaugK9GR2rx/PyIg5M=;
        b=DEErpIbVnzv3C6mOOsb0jDAdzO+XVdfaKRD9jNGXZv5ZsRYBBOWO5jJtvMoxt6N83q
         0iXAnTOVOY4avZir/c268dpFjEqR4xz3dUdbDtl8siooFrGLVyS02QsAQM+1YMpZsbpK
         wgq1C4gBjJq4xXTreiT7AxCETyHVd3M4xFnYuPhgAPv0MmkucUDg12I7bECGLm4eFWIN
         P8vfoT9pgRe93AnYToPiG1ZnPBenPPLXMcOG4zQ0zcKNE+BEpHLBU/k/R9CFl5MYNLw5
         G2OWMh89M1E7sWlVOrQSbL94U0nuGfJ04frP10+UabYfecxlm3ihZlNHcVUw0yOevlDd
         AQ9g==
X-Gm-Message-State: AOJu0YygTV0khsMm7497CoknwJqGhUwOc1oO+8ymIMRpdUCz5lfRc9K3
	p5FQHQbe6IxtIMG0Idn5ibw6gihbJhp9p39joooyxt6iCK1bvrTUjPsZWg==
X-Google-Smtp-Source: AGHT+IG+2JcGNOdvVAIwg6k2jdTPfqyeCqpj0moJYndRGGwJeQXP6O31oM5M/U8QwcqZTWFImgVN2Q==
X-Received: by 2002:a17:902:cf0f:b0:1fc:6b8b:4918 with SMTP id d9443c01a7336-2078296a9f1mr189778015ad.41.1726478296476;
        Mon, 16 Sep 2024 02:18:16 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da63fsm32882195ad.38.2024.09.16.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:18:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	arnaldo.melo@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 0/4] 'bpf_fastcall' attribute in vmlinux.h and bpf_helper_defs.h
Date: Mon, 16 Sep 2024 02:17:08 -0700
Message-ID: <20240916091712.2929279-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this patch-set is to reflect attribute bpf_fastcall
for supported helpers and kfuncs in generated header files.
For helpers this requires a tweak for scripts/bpf_doc.py and an update
to uapi/linux/bpf.h doc-comment.
For kfuncs this requires:
- introduction of a new KF_FASTCALL flag;
- modification to pahole to read kfunc flags and generate
  DECL_TAG "bpf_fastcall" for marked kfuncs;
- modification to bpftool to scan for DECL_TAG "bpf_fastcall"
  presence.

In both cases the following helper macro is defined in the generated
header:

    #ifndef __bpf_fastcall
    #if __has_attribute(bpf_fastcall)
    #define __bpf_fastcall __attribute__((bpf_fastcall))
    #else
    #define __bpf_fastcall
    #endif
    #endif

And is used to mark appropriate function prototypes. More information
about bpf_fastcall attribute could be found in [1] and [2].

Modifications to pahole are submitted separately.

[1] LLVM source tree commit:
    64e464349bfc ("[BPF] introduce __attribute__((bpf_fastcall))")

[2] Linux kernel tree commit (note: feature was renamed from
    no_caller_saved_registers to bpf_fastcall after this commit):
    52839f31cece ("Merge branch 'no_caller_saved_registers-attribute-for-helper-calls'")

Eduard Zingerman (4):
  bpf: allow specifying bpf_fastcall attribute for BPF helpers
  bpf: __bpf_fastcall for bpf_get_smp_processor_id in uapi
  bpf: use KF_FASTCALL to mark kfuncs supporting fastcall contract
  bpftool:  __bpf_fastcall for kfuncs marked with special decl_tag

 include/linux/btf.h            |  1 +
 include/uapi/linux/bpf.h       |  2 +
 kernel/bpf/helpers.c           |  4 +-
 kernel/bpf/verifier.c          |  5 +-
 scripts/bpf_doc.py             | 50 ++++++++++++++++-
 tools/bpf/bpftool/btf.c        | 98 ++++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |  2 +
 7 files changed, 144 insertions(+), 18 deletions(-)

-- 
2.46.0


