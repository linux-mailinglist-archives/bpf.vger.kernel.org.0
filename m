Return-Path: <bpf+bounces-39081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C4396E5CC
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 00:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71623286A09
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1A1B1D42;
	Thu,  5 Sep 2024 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqeq+7CN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D74E15532A
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575903; cv=none; b=Jh3rq0L7q8bRqXO6GlLpGtbiH8iYH9FilUmk3lM8eF+t1JT0f+wF6vzErkKLWlCwKS8djRDvV66QmNN8x3urBmLEacvpMvt6EiwpyXl6cfsMz5E7DGPEmmSUJJt3WDS0TguYzEI849DixDGK8sEB2jeRXS9uE9niRW0513nmCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575903; c=relaxed/simple;
	bh=jV5JI0fa7DNBnP9DfszJ1bTgS+IhH9H78528QNAk330=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBJFnMv+d98zgrwZKgyfAvRgW81NIqdSFUxBVBuYKk2ff2En5nMJ36md7OyrbpVGG++/vK3cqAevnnQWJPWWIlbeFEJUBR3QCLRf7y6FTWnQRA6dLvLk9u1Uhii9yl6YvJSPiYg2gYYmVszO+q0PSYUYd//W9HZXz3S8r+xGTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqeq+7CN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20696938f86so13621265ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575902; x=1726180702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeHk6HViTo9DNhsXLGN76zME7pGq0rBpYUTlrSWSAV8=;
        b=iqeq+7CNgv85MS6k3QarZUoZlv1EdFs72OaHyBrdtVmEUfDoLnLXZCfUiu6xqvBVUK
         XSPjLJEQlqgGUG/BSpZNQ9JW6L/8dzFJ9A7ceeQcMAxS8oeprVuKRJQQmP+4WSLOeHkZ
         6xNISXTvSKvOYHmQSuJC+wDWlMaTSqF7D0trmAqYzf2mJqhla8+c8zh9L3MoODSXZ7Nd
         SmTllikTyUOJJEjA3S05X3jX7nHWClGVEay9ejO13wAY8uSKrY8DdakpM5kfWcw6F44N
         SMYr3Kl0CqHmyFYm+1bQploznSy4bXB+cmXdmc4GD0VlNKMN6CoBUd5huFvBJwx5P+DJ
         dOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575902; x=1726180702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeHk6HViTo9DNhsXLGN76zME7pGq0rBpYUTlrSWSAV8=;
        b=BCdl8gW3vP1sxyTA9PjiLSDLi2oZufc19YTCsW6xWfMRV9X41Ah8fVzrN3MG99IfNT
         e1B5RQIP4NED8LDWt2ETdqHK5DURBwNBg6RaENzpCJhVK7R4zicuq2IUFmc1wQPs8RmY
         ShZ2VyXwaZQv6BucWKMD7UjMDH+FmP6o1uo3pMCbwzaAeyt3qnQU8dkMeIGeJ0hxMC0k
         BIESrK4ZhXqlyZsvhiqOxs5/bgxICtBm+UzXbgqnjF7zrgYS8FHYIoKQ3eVgfH0BZzU0
         wg/6KpbKLX8a6EQqEPVXQZbRrt3MdpjaBuTI1T0WnnRN7KmjeVFLyOHC8C+UdAuFOkBd
         g+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUTcRBozg3GXB80IE+pVfOdNSWnnvznRAVA6k3BckOrNWqbGz0AkkK7o21pqCToNRXS8hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzuVwD8A0hWijmfG/1tnrW/IX8tqIN27GUzZkZbfL+KL0lCaO
	k6CurkAQadOLK+UmUtI0XAFr6KKBrnH/I6xPteaLUQljjFjxftMW
X-Google-Smtp-Source: AGHT+IGQHEPTYrger4MtAvyolgCOpDPx7DtmnL4kNZJsOzoDtaebJ2J2QFttHcV3FKR98H3nuYHEkg==
X-Received: by 2002:a17:902:ec81:b0:203:a0b4:3e28 with SMTP id d9443c01a7336-206f0552aa7mr6469055ad.27.1725575901665;
        Thu, 05 Sep 2024 15:38:21 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9505acsm33067225ad.66.2024.09.05.15.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:38:21 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] bpf/selftests: coverage for tp and perf event progs using kfuncs
Date: Thu,  5 Sep 2024 15:38:12 -0700
Message-ID: <20240905223812.141857-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905223812.141857-1-inwardvessel@gmail.com>
References: <20240905223812.141857-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This coverage ensures that kfuncs are allowed within tracepoint and perf
event programs.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 .../bpf/progs/verifier_kfunc_prog_types.c     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
index cb32b0cfc84b..a509cad97e69 100644
--- a/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c
@@ -47,6 +47,22 @@ int BPF_PROG(task_kfunc_syscall)
 	return 0;
 }
 
+SEC("tracepoint")
+__success
+int BPF_PROG(task_kfunc_tracepoint)
+{
+	task_kfunc_load_test();
+	return 0;
+}
+
+SEC("perf_event")
+__success
+int BPF_PROG(task_kfunc_perf_event)
+{
+	task_kfunc_load_test();
+	return 0;
+}
+
 /*****************
  * cgroup kfuncs *
  *****************/
@@ -85,6 +101,22 @@ int BPF_PROG(cgrp_kfunc_syscall)
 	return 0;
 }
 
+SEC("tracepoint")
+__success
+int BPF_PROG(cgrp_kfunc_tracepoint)
+{
+	cgrp_kfunc_load_test();
+	return 0;
+}
+
+SEC("perf_event")
+__success
+int BPF_PROG(cgrp_kfunc_perf_event)
+{
+	cgrp_kfunc_load_test();
+	return 0;
+}
+
 /******************
  * cpumask kfuncs *
  ******************/
@@ -120,3 +152,19 @@ int BPF_PROG(cpumask_kfunc_syscall)
 	cpumask_kfunc_load_test();
 	return 0;
 }
+
+SEC("tracepoint")
+__success
+int BPF_PROG(cpumask_kfunc_tracepoint)
+{
+	cpumask_kfunc_load_test();
+	return 0;
+}
+
+SEC("perf_event")
+__success
+int BPF_PROG(cpumask_kfunc_perf_event)
+{
+	cpumask_kfunc_load_test();
+	return 0;
+}
-- 
2.46.0


