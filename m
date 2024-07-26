Return-Path: <bpf+bounces-35713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6B93CFF8
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C5A2831C9
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF43177990;
	Fri, 26 Jul 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIObF/CL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1C176AC6
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984173; cv=none; b=bQ2OPQ1EbXvLl6dj2wN4ArlphD/jbv8dkGt3ngLWXRML0wrYZYUUo0fyj2Q2nv+4ZXAgk5FOcWodPbBcWXycK5s252HceHr2OuMxD/wiFNAzoiVE+4bqTUCYCbVXr2ouGiAubUtRJQwoQacb2+fDAb5BwrKgeB2wA1QNQlGM4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984173; c=relaxed/simple;
	bh=01rTGrhez7nMcipxCbynimMvPgxooqqono4ewDJXnHw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rGhm9k3hsRK7dwEPaKavFci5D2k3HV8251NYRd9P76+zhn6ZWAhWQi6o4AEF+BbBaIQxpF+BCIAAkNltj1dQBisgkJGhRCW49SkcdpPdz00TkRo/V0R31KUyuN+TLHT6BYzYdWThrkBQn1R3xSN1gxdAe+fxhrL7oywSG+M+zR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIObF/CL; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7abee2b4b0so123104166b.1
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721984170; x=1722588970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wzhEE0I2ZSCZWkX/coFdL22YkdHDYtKnmVSDepdfaTc=;
        b=uIObF/CLhuF0RdJIJi0SKuZI9lSp59kfL+DIs8jIklpcz982iUQNzoDyU32HNQ1JOg
         M6UrGR1cIVaARETMgR15hxTl03M9LaP2fv9tuEy/sYGv/Ve/E/4Zoo3/fGt09eov0HaP
         /54DjGnbkHPF2lenYiENdytoki3hnN1rKwkCbfTPnHIZevmC+7WP441GghWldzkFc7XD
         F8at1MBkBxoHXVGb8Ul31gMGr7Yr69y6jQkmjL9dUkTXcNY6WOsAyS+1I0ALNE/+ygaO
         OSfAI/hTIb+xUZswdVZYMpOzMEe8UApwqeV3kzz5W62jkQLXXAnA8D2J9R4ZAkFMbSm6
         3+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984170; x=1722588970;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzhEE0I2ZSCZWkX/coFdL22YkdHDYtKnmVSDepdfaTc=;
        b=AK0gvwNlMX252fUKUbjxU1vpWCY3zaR+sdaxDCBt/ZARZb5jcdhK1iEWaSjcLg8vMX
         9xDSAZvhYmUKt2WFTCsjYa6lx8OXu7Op8eFuAqi9ZeHw5c8/bOQdZ17YstlIdk88WVhR
         yYvfASE01A//EkTDIm2w/gZi16GG1EpAUhl3gm1KpTY9dCDFCGZnwEIsZvYPUV6ueygq
         CKIDkc4MUSVsBpiQ72HapgRy4GsXTD8iCND6/VPr5VS9USbuIW1vaUZP+143v3FyvRFq
         s9DA5H993WZQde2hSjHZgn1cEF4RY1PX/JNXjVb4KBiLvjQwlaY2swfSnrro6UMhmmXJ
         aFqA==
X-Gm-Message-State: AOJu0Yw4OvWkiXRA3juyqbu+Ou67GJDWHf74THzFopxHicEAAcCPGXK+
	/DkKFPgNzww14hXGUvNl9I9Y3mbFv78ZMZpvsTdWFyGkSHKedTO+NTrDzLQCIB4NIkW68wJOoUT
	JZijyLvm87wDIFl+Ui7z7ewr3Rv/sAlh4yi0V0gVkihddbr3JCTwZ5gUlYHfuq+CvXLIH1Wq3lo
	gAh2wlMrPBZ+DyNaxGIQBcMx6jAmmY4+IKpXzW7BckrTAU5K9KQ0nD3ufo2AGQxrTnkQ==
X-Google-Smtp-Source: AGHT+IFyXMf6dwxh4GF7E1byYlwWvvDvyucdwlRGsB9mphq0pjANaGoft3BJpuyuA7elNNZyHVgViHE+Ysmk2o0VGG34
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:906:c794:b0:a7a:8c65:641d with
 SMTP id a640c23a62f3a-a7acb3793cemr286766b.1.1721984169485; Fri, 26 Jul 2024
 01:56:09 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:56:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726085604.2369469-1-mattbobrowski@google.com>
Subject: [PATCH v3 bpf-next 0/3] introduce new VFS based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

G'day!

The original cover letter providing background context and motivating
factors around the needs for these new VFS related BPF kfuncs
introduced within this patch series can be found here [0]. Please do
reference that if needed.

The changes contained within this version of the patch series mainly
came at the back of discussions held with Christian at LSFMMBPF
recently. In summary, the primary difference within this patch series
when compared to the last [1] is that I've reduced the number of VFS
related BPF kfuncs being introduced, housed them under fs/, and added
more selftests.

Changes since v2 [1]:

* All new VFS related BPF kfuncs now reside in fs/bpf_fs_kfuncs.c
  rather than kernel/trace/bpf_trace.c. This was something that was
  explicitly requested by Christian after discussing these new VFS
  related BPF kfuncs recently at LSFMMBPF.
  
* Dropped other initially proposed VFS related BPF kfuncs, including
  bpf_get_mm_exe_file(), bpf_get_task_fs_root(),
  bpf_get_task_fs_pwd(), and bpf_put_path().

* bpf_path_d_path() now makes use of __sz argument annotations such
  that the BPF verifier can enforce relevant size checks on the
  supplied buf that ends up being passed to d_path(). Relevant
  selftests have been added to assert __sz checking semantics are
  enforced.

[0] https://lore.kernel.org/bpf/cover.1708377880.git.mattbobrowski@google.com/
[1] https://lore.kernel.org/bpf/cover.1709675979.git.mattbobrowski@google.com/

Matt Bobrowski (3):
  bpf: introduce new VFS based BPF kfuncs
  selftests/bpf: add negative tests for new VFS based BPF kfuncs
  selftests/bpf: add positive tests for new VFS based BPF kfuncs

 fs/Makefile                                   |   1 +
 fs/bpf_fs_kfuncs.c                            | 133 ++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  26 +++
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/verifier_vfs_accept.c |  71 +++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 196 ++++++++++++++++++
 6 files changed, 431 insertions(+)
 create mode 100644 fs/bpf_fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_reject.c

-- 
2.46.0.rc1.232.g9752f9e123-goog


