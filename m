Return-Path: <bpf+bounces-79575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19574D3C373
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44B1F666BF2
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE8B3C197F;
	Tue, 20 Jan 2026 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI/5sZdE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B93C00B1
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900536; cv=none; b=uE+QY3Im1uxUeLNmhETpBDHbvK1JKzkMbByD8GEfIF7j0u8g9zWpxGor6CpJtHnEIb+pZ8MUTFEsNHaJ2UOC3jfQTH2RptQt0tk2J08vRXroawOy1Z5Bi4UYmur0cC+XGHP/Dk2UIFTleDfWjMl1XYjtg4ygpBh+n/xjboisRAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900536; c=relaxed/simple;
	bh=D6LBuB5PX8Kd4CZf1+FbaPqPfV0TTpjHteNVbX70GmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfGa7kn0koi+NN/uTdZysLURgZZXS+IEchUUoMkE06RgruxkMjLK/ToLet6wmT2O2stQN7R6869ktl6LaxZfdFmHOm9vxvGvCJIGsij2sFSa2eEPdk5StxVGPEoUwT5XqER+QgTYFMBNOx2pMG+E8mQdC1tHmtVoWJCgwhSkINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fI/5sZdE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81f478e5283so4513018b3a.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900534; x=1769505334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ny+PQpdgO6hHDxqMIrR6HHnMRszhUy601KxoCXluSw=;
        b=fI/5sZdE+bXpcpSX/1mNDk0K265XTKp4HBLXWN6NF4n5B6FBW9gHRb7icwkmE15ZAB
         M84DGVAIki5pvGCT0qp+cs4CmuYa45zbQyEDUt51MpiTBbIO8aH0karDt+Ly9B5w837h
         llKOo8p7+4keH9Sxim1ApWr09CGb6wuiJv9C1Pf3akmuBQE1CrTncJm3yBEpO3oi0ssm
         I7TuByu/oT46Da6S+pF/xojjaKz/+1eAZJJExuMKesKFWUFUQCX1AMdrrUftaKuRgU48
         84Hpu9fwd1ZJhECu3VsFW4K1tod3QWZygRsypPgXy/F8gzD8bQqD1rCh+OngGyOyFdhH
         oVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900534; x=1769505334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ny+PQpdgO6hHDxqMIrR6HHnMRszhUy601KxoCXluSw=;
        b=ZII0MY9RMjYZCaS46LyNNatXsr2qUFtsXlT2WvuD9QiHIFOS/HGdZ3W4eK95w2NTjH
         pNW8O4y7wrcXh2FSt6l45NyU9VEqFelKV3w3p0qV6Nlhlvc2gHUQOIDfaQXcZ8ENSLHO
         Gm5MdEpulBI0nRr0kkfhZPIKV2TgC8w+8bHrSKENdsjJDDftUd/YPJiXVyeS+D9lkx48
         uOJ9YoHk2vdyuTjZVFuW7LXj57l76qttF3rgFUw6EhPc7pChlXy3VaEw5Z3YOwZ8qljH
         vg7O/xDD9DXW04OFLxsnwU5ksR8wM7lI30LjSV99zw3R39UeKSlU3lVclN/ltL7wNLQD
         gVpg==
X-Forwarded-Encrypted: i=1; AJvYcCUal4vo1OUVBqK9xE8tsiQ8Qo9a2Pt3xP0QfVT6GLJBgbhDH3kb2fcakQY3rKBKVwDisJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqfcEVS0PK8MQY1dXOJa3PRzgF5p2hgM83AWka+PtgZ2inXFu
	Y1zCyN9pTUjpeufQLSKRXv8knHFyYoGCjp8uwVONRdWVK9IMRLwmytY=
X-Gm-Gg: AY/fxX6z6sFT30wo79+/4BHBTd94x+8XeOxcPGjB7QYmqWUFP9HNy0GcYQrQdUG1L3L
	pOtDEPYju73aV2sbb1wVTqxNLB5Gg9OH/rznXDKzwLb+dkDIpZ2UqIvRJrUhV9cfjpygpH0muoN
	JdKOeZtlPH44/ZnZQRLX33SGJQT44cGwb0/FW+bzfQgL1PDDGMWgk/wYu6t/5KH/TcBEmiVbDWH
	BVCEsiFil4HufmOpCVbGyfvbjxOnKke3gMm2LCk6pgZndVMrwBq4BACHhrzKrgSna0jFsb6Qppx
	gjY1BcY7sNUZRLM2ajpxnaJtGdEcRMyupUN14GOoZlftmKiYIMCwsfvTaz4iQlWKUMmnG2OssOz
	72Iv7NqxVCWYxryyRmdDerGUGwKGXFzDuObEjwh8ShTPjwxHc9w/KQ3uthLzNH2mZ5NaIuA==
X-Received: by 2002:a05:6a00:3d0a:b0:81c:632f:2ff0 with SMTP id d2e1a72fcca58-81fa01b9053mr11906026b3a.22.1768900534315;
        Tue, 20 Jan 2026 01:15:34 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([2403:27c0:c03:258::a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278056sm11571169b3a.34.2026.01.20.01.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:15:33 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	yatsenko@meta.com,
	bentiss@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH bpf] selftests/bpf: wq: fix skel leak in serial_test_wq()
Date: Tue, 20 Jan 2026 17:12:02 +0800
Message-ID: <20260120091201.1718-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When wq__attach() fails, serial_test_wq() returns early without calling
wq__destroy(), leaking the skeleton resources allocated by
wq__open_and_load().

Fix this by jumping to a common clean_up label that calls wq__destroy()
on all exit paths after successful open_and_load.

Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 1dcdeda84853..b32e22876492 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -17,11 +17,11 @@ void serial_test_wq(void)
 
 	wq_skel = wq__open_and_load();
 	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
-		return;
+		goto clean_up;
 
 	err = wq__attach(wq_skel);
 	if (!ASSERT_OK(err, "wq_attach"))
-		goto clean_up
+		goto clean_up;
 
 	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
-- 
2.34.1


