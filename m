Return-Path: <bpf+bounces-32450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B3C90DE38
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CD5B22E1D
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85731990C5;
	Tue, 18 Jun 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PILND8Qv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6041922F9;
	Tue, 18 Jun 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745698; cv=none; b=Pc457JSkl7h+NVFkf8Lnyc6HF4Gfh47QW3obaZbI3Uk1y46T2oW6OQnUqbRqwIKCpF1RDQKfNpQNRrl0hm6CEF7hBdg7zvOdWsBQfjGozDneEk3Qa3W9kOOQO6+J+2YDqgVbx7bUb/ueN22F1Z1ZnUrnMET3l1L01K3c8mWfnvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745698; c=relaxed/simple;
	bh=pd+Lf4/PgAM++ePZtIgZr8aNy1FL3LlLgNFXWFtACK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBakwMcTVN34ZVACw+RcIGgXdG9rsMFxZtsZI6rydtaLALsALhHigjZduvMBLYTEiXKP6P6l7BXjNdMWhrGDmYzdPflyaZvPxuXOumsbu33Gccbg3t/JAvEnjNUeXlEuqrpGzbV8Odqjv6OgD2Py0w8G/3lBq69COnW/FT0Evq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PILND8Qv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f480624d10so48027975ad.1;
        Tue, 18 Jun 2024 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745696; x=1719350496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQOVCRdHbxZg8a7b2wEBOiCwoSF0unjmV3U0U40/pao=;
        b=PILND8Qv9P74OWZOefkL1ytVsvB2SobVjWdBDJUeMnjUUwTe7LV6ql7C7JAVUQj/fM
         mGIhUw+oLYAQ7qyH7wLXBOvnk7kglV7Bj5ECeS0R3vEHnz/tYAGDwrHGtpUOugC/150Z
         45LKXIlSIbb5ZLJr2h/W8dsZVbX2NlhwmiY37FePpl8ORJhyT5ANmIvd/GAY0Yv1AuR0
         3mQIq+JxQKC2g12IorOhiUTQWa7umuGCW/xEZnSyVgXoUvexyPK6LfJ+Ij1vTBgM9MYn
         q87LZocjHEnRE/c780V6gLjiBJx9jq6dOuHJzNyaFA0Ngg7KaAKZfEole1i+KaCUPU4A
         m8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745696; x=1719350496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bQOVCRdHbxZg8a7b2wEBOiCwoSF0unjmV3U0U40/pao=;
        b=V0wm5ZSRiglGPf5ajtTGZ59DLYcG/dSNp4btYXlNfjJSm0SN7Qi6gd9kw92MSLT9gr
         Jn4aPzJEwpHwLYe2dqPByOOk8vM4f3JAXP0EQneIybVDYQDwJXuTV0QHQl2TLuX7MyQ8
         B/FhmyHAjC6Q8IwrikFrkhZkC03HMw8GASMNHI8XfU03ozGfigAjMI48+2lFmHIl7AqE
         lFFcCUSwrwBlt8wqYFpeeuLNaDvpT7KkElMaNvPb0rznULPDpzGWY8v7T3ci1jzIas05
         GDhdZ07x7EHROdsWuPVTWtE+OjFWIAFS7o2h02AHMOJAcz0HXr9i1jBdPOFFIoT2DcKW
         gq7A==
X-Forwarded-Encrypted: i=1; AJvYcCVmn9KSUwI6wZ6Veh/xLjsmzzJIhu2QMfLJCREyBsiRN6iG95ASJgb6g8qmCSp/BV28ehBKidHOaYSorJ7B0wYrY+iT
X-Gm-Message-State: AOJu0YzWUhlwFdl+wAX8ChevS1XITL3QewTxGdCoIEB433rHHPviT4Ym
	nE6DgV4QAooKMFu4PuXZ20PARHDKZAvhsVEYtgg9387C2X+L1IFv
X-Google-Smtp-Source: AGHT+IEBK98qJ5NtaT8xdc6vTFjyUhmz1LX6yTDRtc7shB+vcHllHHnvdRFggxrD7XFH2Vll/u1T/g==
X-Received: by 2002:a17:902:da85:b0:1f7:969:7e87 with SMTP id d9443c01a7336-1f9aa3e9e2dmr9953315ad.35.1718745695010;
        Tue, 18 Jun 2024 14:21:35 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f29011sm102290305ad.249.2024.06.18.14.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/30] tools/sched_ext: Add scx_show_state.py
Date: Tue, 18 Jun 2024 11:17:31 -1000
Message-ID: <20240618212056.2833381-17-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are states which are interesting but don't quite fit the interface
exposed under /sys/kernel/sched_ext. Add tools/scx_show_state.py to show
them.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 tools/sched_ext/scx_show_state.py | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 tools/sched_ext/scx_show_state.py

diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show_state.py
new file mode 100644
index 000000000000..d457d2a74e1e
--- /dev/null
+++ b/tools/sched_ext/scx_show_state.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2024 Tejun Heo <tj@kernel.org>
+# Copyright (C) 2024 Meta Platforms, Inc. and affiliates.
+
+desc = """
+This is a drgn script to show the current sched_ext state.
+For more info on drgn, visit https://github.com/osandov/drgn.
+"""
+
+import drgn
+import sys
+
+def err(s):
+    print(s, file=sys.stderr, flush=True)
+    sys.exit(1)
+
+def read_int(name):
+    return int(prog[name].value_())
+
+def read_atomic(name):
+    return prog[name].counter.value_()
+
+def read_static_key(name):
+    return prog[name].key.enabled.counter.value_()
+
+def ops_state_str(state):
+    return prog['scx_ops_enable_state_str'][state].string_().decode()
+
+ops = prog['scx_ops']
+enable_state = read_atomic("scx_ops_enable_state_var")
+
+print(f'ops           : {ops.name.string_().decode()}')
+print(f'enabled       : {read_static_key("__scx_ops_enabled")}')
+print(f'switching_all : {read_int("scx_switching_all")}')
+print(f'switched_all  : {read_static_key("__scx_switched_all")}')
+print(f'enable_state  : {ops_state_str(enable_state)} ({enable_state})')
+print(f'bypass_depth  : {read_atomic("scx_ops_bypass_depth")}')
+print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
-- 
2.45.2


