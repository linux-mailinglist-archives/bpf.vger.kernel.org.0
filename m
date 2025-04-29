Return-Path: <bpf+bounces-56953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D37DAA0E96
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 16:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5194D5A0892
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128162D29D1;
	Tue, 29 Apr 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZgyE71Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19238FB9
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936278; cv=none; b=nIQbySFPUmWJtHKo3eA7HLeypisFifykejRNrvRhCnHw2C28VQciStQASKAn6PiX4pAmZf9F4eXXbpAFSL/a3yk4xmFxoD893eeZETGNOD+4lZZOqOdvXaeZd8gstdk3YPHvZjb4Wu+nG2/mKOkhulDSRnAFguF3haRV3Tr8FAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936278; c=relaxed/simple;
	bh=MBSp4uinK0IbsH3GL3C7EsYtfGdDmWP4QH8uyUjU7/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tqrK28TMj4JyH4ZFwQ8Z1tTFWa7oy4w7FiDtVshkrk5zCZIoeOVhkVZYfafE5dI0szqpjZV9vK/SnCUb46CnV+RQTB5ZyAvSR7zVQDWwTdFSIbUYRncVlU/KM47VUKRynakPkx+PnjAYnnR1jntxK2gARiZNa5H34yQycLkTUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZgyE71Y; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso12452318a12.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745936275; x=1746541075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbGF3XR3ozs9mXdxRMf+efYbHNsBF0v0R1O0uockv1M=;
        b=VZgyE71Y5mOKajlWRnMoZ6FPbLU8LBsB2hLbH4OXkHKP7L+uoL0McYAT7/OFkIV/8U
         bmFse/oITYjysEoJxtSu1Ui2ekGDDcXyLbu85kW4+EXQ8BcgDF2wB9E3rZniUQdwnJmK
         TQxT14Yt099xl+5is+xP0kGe0qa654HOdIz7r1PiqMHeAjPgIWzWAaUNtbOba+Qn5aeS
         7mD9NEliLuhX0dLXcb453/CsEckZnmD4xnhjfwQ/rFH0kibWzlyo4pRAE7mVgJlBvUEp
         u1OCIU+MoGuqO6GlFcR5h9fAE2iGIZDAHUQjDHgyHPxfZxppZXtLAytVfJM2Pu8/xGCr
         tZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745936275; x=1746541075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbGF3XR3ozs9mXdxRMf+efYbHNsBF0v0R1O0uockv1M=;
        b=BYEjx0+xjEIrX0P5LiWsAwH5Npe6ilo1s9gOAOgSF2g9gn3XOSVcb/s4w6cjjjuKGU
         +NQN07tbHuiMESrOLwvoM6s1jIC2PkGhtmIBatd4DIbgTZqDraBmdkibv26u8+jiyYNa
         CPHOJuMbsUt+Gh4d7O1hOHyOmiW3J+WBBzUdRrCDeSgFKEiPt6o4z50+YS2PJL9FbId7
         sSyCFyM+sYZAtlZTPFhi+cjhj1GIJxGABo1cPRz3r5Z8USQpNdcVFL7kg+XDPdnI0TO3
         x+qPctIRFft13G08lIB6h41mWWe9bM6RN26u2aORyIU8EjMiMU0d9rz+miRjhaHlMfBz
         zrbw==
X-Gm-Message-State: AOJu0YzM/7Ht9XEdoh1UYcFn9f2P/cFL7Lf6HECGiF/PBqR/xPI9t5kK
	ZDW/Hq9tzEBQiA/1AjDlZi12uxF8HrGyxC3elYIDeJvyj3uEYF9Xef/zkA==
X-Gm-Gg: ASbGncvsVIvoGqbMax+aq7to3eViUXAxe21NGPJ/yNThTROT7Vo3GN1NHOb3nYv8pZF
	cLCaSaNORx3A0wtySlDyCwMXeVrIpD2SDkt8LKpi/DdqF+iqwlEx938SoJNFAxcIHQG6KD0omBt
	2+69l1orJtbImK80gfaPXV+OAv8uXed7t2c29NefZQTneszcm7EF5hLwvo4zTHMSjac8fWcG4eK
	zRFPOqezKYnE+djtfRG6yUdnwrZ4ntlfRz36TcT4HCRQNy9xrIfDOHWPgecOc9HlDXgpbJp5jf8
	3Nm5j7pDb8Re7VNdpLetG4ezrK3z4EaMPgrsqEa2gpD88p8HajdOA/pjqhrM
X-Google-Smtp-Source: AGHT+IENOSPyF9m3dUpvWb4XRuy6OAuiboF5lE6/yciY7vQLrMwsXT0asfzTJI+Q4Qx6Opw3OOQ2ng==
X-Received: by 2002:a17:906:2416:b0:ace:d468:6c09 with SMTP id a640c23a62f3a-aced468704amr100262966b.5.1745936274653;
        Tue, 29 Apr 2025 07:17:54 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e587f1csm787652166b.79.2025.04.29.07.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:17:54 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next] bpf: fix uninitialized values in BPF_{CORE,PROBE}_READ
Date: Tue, 29 Apr 2025 14:22:41 +0000
Message-Id: <20250429142241.1943022-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the latest LLVM bpf selftests build will fail with
the following error message:

    progs/profiler.inc.h:710:31: error: default initialization of an object of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigned int') leaves the object uninitialized and is incompatible with C++ [-Werror,-Wdefault-const-init-unsafe]
      710 |         proc_exec_data->parent_uid = BPF_CORE_READ(parent_task, real_cred, uid.val);
          |                                      ^
    tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:520:35: note: expanded from macro 'BPF_CORE_READ'
      520 |         ___type((src), a, ##__VA_ARGS__) __r;                               \
          |                                          ^

Fix this by declaring __r to be an array of __u8 of a proper size.

Fixes: 792001f4f7aa ("libbpf: Add user-space variants of BPF_CORE_READ() family of macros")
Fixes: a4b09a9ef945 ("libbpf: Add non-CO-RE variants of BPF_CORE_READ() macro family")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/bpf_core_read.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index c0e13cdf9660..b7395b75658c 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -517,9 +517,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
  * than enough for any practical purpose.
  */
 #define BPF_CORE_READ(src, a, ...) ({					    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
+	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
 	BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
-	__r;								    \
+	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
 })
 
 /*
@@ -533,16 +533,16 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
  * input argument.
  */
 #define BPF_CORE_READ_USER(src, a, ...) ({				    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
+	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
 	BPF_CORE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
-	__r;								    \
+	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
 })
 
 /* Non-CO-RE variant of BPF_CORE_READ() */
 #define BPF_PROBE_READ(src, a, ...) ({					    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
+	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
 	BPF_PROBE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
-	__r;								    \
+	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
 })
 
 /*
@@ -552,9 +552,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
  * not restricted to kernel types only.
  */
 #define BPF_PROBE_READ_USER(src, a, ...) ({				    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
+	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
 	BPF_PROBE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);	    \
-	__r;								    \
+	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
 })
 
 #endif
-- 
2.34.1


