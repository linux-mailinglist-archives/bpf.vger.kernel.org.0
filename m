Return-Path: <bpf+bounces-54321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40712A6766B
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17340423317
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5720E6EC;
	Tue, 18 Mar 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="TmPVlFkd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C674320E00A
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308200; cv=none; b=dAnJF0MHoLlgsiSeHrWyrRk7omdYHfs2KFvlfR+ewUcsr8n6K8Jqu9mJ2w4TL557JPqTAK10rXcKf8G8iVECZnike/qbqhDXP0NtCNwXk315b8Dl5QgjdlmqHdCoMpFqBghcSoe8/mzXC+GopIrnZoa1VDsKTr5MBSAKRhNZGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308200; c=relaxed/simple;
	bh=Plh4uXcXwwi0W1hxJ0CzKsRLvLtSkFJDakUgMqwcx1g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CtnGdCY2ox4oS7W1kW3gZSoR0G9jAar+2uMuSvT0EFrnPCDlS7RGUVvtyqzI/OTno0A6feO5zyq/aQiCX2g+EYMWCV+3KnXJoSZ9ONHUm5GeVFvv9UoW6AWo6cxVgbQ5ErCk/EgDI8MCSdT0sUMgpD45jZ/WOTUeVE1XcFum5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=TmPVlFkd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso3276938f8f.3
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308197; x=1742912997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLTCxvK6gGz2vRybKBKe1olf4mufnbfTYMfiXcuyDVU=;
        b=TmPVlFkdvffew3u8xstc2o97EfuF1UCLIaHF40XoqAYWKlPLWoK89Ke4NJSfXpMDdt
         GRh7buJ6mOkbQIz/E31XfSpQZkJ1uXwbrMmBoYMMsmdmuSOJJftT/OULJR7TValn8uam
         4hlnK1lbqQHKhPy19RwE4kEwiQujWmlB7pZdZxikBsIRqvNG0gXB5PZ9zPjfvIvnKaki
         O0OaBACJ+HRI046I52jillwo/Ph5eaSPPN4lZdBBwCQk2sjzC18SI7LAumufoTYEr6ek
         6kXhEMA5ItHSm/+SxJ5bnwLyoE78smEIcHPmVjjSxnVMQn+bJrkXuw+AMUruGZGkKXXc
         HLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308197; x=1742912997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLTCxvK6gGz2vRybKBKe1olf4mufnbfTYMfiXcuyDVU=;
        b=OIZYY6Al0o2fJSQHmQrsVsXN5wKjpnx/sxtFYx2Cmbbca2gPJWURE4FrS/HHn00uF2
         A0TZ5KhMxvyys7hO2/I+nUvVnpq8/lDw8SM915UDkp5sTfFCSNVSwrQnCi0yXQk14jFn
         dqsf8/wXOmP+ulNzAKa7XaYFpfucrOJCQXEnKUmrrCxoifhgYb7tldUeooRdPL8zZY1w
         eeF8ZjVepfJMMKl85RNCQcggVCCnxCsGfSu+cLMwWgtliajvY6Zm7l723gvfOSLWLSq/
         9VhehsGJKFtVRAwzeDtpyFmYvXM9wnZF2/GTfE+EHJqotg/+XBW461NE8aMZeHT+sgU1
         LVlw==
X-Gm-Message-State: AOJu0Yxc92xsGL6l6ctakgHUKeyo2Fnfdm2r0UL6+WlJWsfTmbgpBWF5
	SaN5XANYtWdCtEiJNolbDTtgoELSWjFRjSpX3SyGIdVuoTr+oIKig8FQgk077w8UB/uHltLYk02
	8
X-Gm-Gg: ASbGncvUVfMDbYbIsBGuUQae84cAQNhcAatUXYfS1tNixW9/Eauq3AOtY9FvPMIupLC
	WnIUbC5KkAomGe+ep9FlMgfEuvEKfWaU3lfMLpx3RmllW57Md2y2Rjvn950eaSPS7Z1ckvgK4mm
	xcB6VLhFF/0kWlvequd/k2QaLHgeV2W9B8c5/R4ItkzMpdYUsvYkQO8QQ4lSaFviPMhFGqpczBX
	bY68rZoYB/kRkHyGIn+bax4x2nBRuDhuAkB4dv+RcuXIacQEPEkqiBFdN78icEVSY6BBCdWc1AQ
	sJcLMw38FckC3Xaz0pcGEdfXocGc5AF3XKJ1emS3/cJRtL1rZ8Z/LRW/2g==
X-Google-Smtp-Source: AGHT+IEUXDflq0sUHBuXlU4pARL7PO58L4hyO9yw68ro0APDXJTcPif7iclmTWRbeZrXMuDvkx51uQ==
X-Received: by 2002:a5d:47c5:0:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-3971dae9542mr19436157f8f.25.1742308196660;
        Tue, 18 Mar 2025 07:29:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:56 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 11/14] selftests/bpf: remove likely/unlikely definitions
Date: Tue, 18 Mar 2025 14:33:15 +0000
Message-Id: <20250318143318.656785-12-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now likely/unlikely macros are defined in tools/lib/bpf/bpf_helpers.h
and thus can be removed from selftests.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/testing/selftests/bpf/bpf_arena_spin_lock.h | 8 --------
 tools/testing/selftests/bpf/progs/iters.c         | 4 ----
 2 files changed, 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
index d60d899dd9da..4e29c31c4ef8 100644
--- a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -95,14 +95,6 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
-#ifndef likely
-#define likely(x) __builtin_expect(!!(x), 1)
-#endif
-
-#ifndef unlikely
-#define unlikely(x) __builtin_expect(!!(x), 0)
-#endif
-
 struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 
 static inline u32 encode_tail(int cpu, int idx)
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 1b9a908f2607..76adf4a8f2da 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -7,10 +7,6 @@
 #include "bpf_misc.h"
 #include "bpf_compiler.h"
 
-#ifndef unlikely
-#define unlikely(x)	__builtin_expect(!!(x), 0)
-#endif
-
 static volatile int zero = 0;
 
 int my_pid;
-- 
2.34.1


