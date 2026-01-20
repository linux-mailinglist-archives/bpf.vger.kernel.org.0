Return-Path: <bpf+bounces-79561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7DD3C03C
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB44B3E48C9
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011023803FE;
	Tue, 20 Jan 2026 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlcVGwHN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05437A4A1
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892778; cv=none; b=oS1Y7Tdtn5JaZkxiHiJ7mh5sKg9ScOsClSxnsTfZe9L33bRMf1D+jxWV/N36cO3Mk8TcLmUZ1bjYXPgsANwyX3n1O6ZWDtlU+vpxdZkl4GPJ3AJIJ/9FaGmrQwwDBF7R+A9pQRhj7mDsCqOsXb02qjHNPcS4vXnrN0E2+DTAmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892778; c=relaxed/simple;
	bh=1TZK5fhyrxC/WB5sP/wiLMfRj4jIbse4KsMa+ws3+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSNSfc+YxQZ0zmY72bFEtOTIOGsRGrsiKhSSYwBhyR31FJSwMbn2YSUDClE59HNGX/W1q+Z3fo9sigNFsGVR7tZgTA82l8VP5DEcH9G9Q8D7h36SwYce9iZBsa0ik0CY06q0wcBXG90VmrLaaP4H3tRmFIs/n8ty8Inpnr3CJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlcVGwHN; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so37289145ad.3
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 23:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768892769; x=1769497569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6k2o46vNuTzPIheaA8GctSKLua8DVfbF5bh98uIEOBs=;
        b=LlcVGwHNAccCKm5daWRmSKFd/90GJ8vdq79Xalve6JxGkUwZ/P4bqRzUe2Shbunc/6
         NOS5ZtKgpK5HA/4+urzzf5Yv7fSA82/ZPS4/akj+/IPCmPqDgQs0MAHEnECseFL/zror
         /L4s8QPx5FcvfSaA2EHnwRW0GaSJZyUyFh5KT50DLnJn28xXhJfG0hME/WKnwjupAvGb
         VKov0RBEGAT9A9VEojAgO6PdygkcPz2pOnacR+b38+vq9hVUfGyb+exbBYUoB7nZVg0C
         aopMM5qR0zMGPNjmSRyDU2GmkcypGj7s0hhpuH+j2kD12te983jiLFHlLx5Q37/wr79b
         OYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768892769; x=1769497569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k2o46vNuTzPIheaA8GctSKLua8DVfbF5bh98uIEOBs=;
        b=XxskvoDX0gQZr0GIWItOQ/JE940n6uqzi3K2q2nz1FVNuDkoqxQqRu4tviNnQERGUc
         rEaBjkrtCyLQ/5c2vpnT7QSVtNOvJ3frOvXU4zZVqMLZ5Yce02lfQV6MEn7CEEffSPJD
         +wpJY+NhA15Xwq8ZJOdWU0pAKEvpWoVzzuSSH8MBnqd55YRnuPbqB8t1F+1RZuR1xk/y
         3NoxCLWVvG3oRIDnr6kyyfv00vtHp4G6a8T5xZb4yLBiOHa4VFK85FCo3naru6jTkxRa
         fxSHkS6mueMXJxdAuuPkvkTUv9JA+aGHB5Me6XH1b+XpOTQDJ2ATrWLsatnwNSWU8/k/
         5FGA==
X-Forwarded-Encrypted: i=1; AJvYcCVFGDt5bz740opgekgf8PlY7Evx5Mbd/RDWGOIX4XU6KuatfFD7JXD/KX6jiFYNi2XgcTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0zw2Vz1O4qn1AFHSt4wS4w6DWoN3Smwrawv8xjPjwiy2DB1Pl
	5XvGGvTnTXaso7XcXEwmhVaunnq7NlvMEK/LZuxYtsmxlqZ5iDEksrAw
X-Gm-Gg: AZuq6aLC7gzhe2phve98h5ThHYzumQ8rDjlluWAWvG2RAgKyRsghBWuJf89vu2MeMZG
	mT4E2v0cZU5ltUd3MEuZXJ0p9Ax+3TyBBxpStMYsGaXZoBKjGGDYhjV+YANH6LoWEfbIjoln3f4
	jnEscWiSUNnHsiX5F3MD9kXyN9MeGoVwGBEx5lODJeFPYwztQpKWJxQlpEUQSlZjsHLTPprY9Ia
	hht3jI0WB4K+MB5kIAwW66ZTTk7aZo2TOXjljcHs43LW8Jyq6LADDYS8Yuhq9I6GzgckFSGeR1C
	5EVe5UR6TQ6vNYWqPp//nvVHvyJYgjvNsCYrhI6/AYbXR9LRZLpTTKZM2JDZjBxD8z6buYWcApv
	Uzi5+oh7UrphHItMSqU9emKhTaI4UTdjljFTe70zxXa/8m405unCQoROsnhA+Ss14OIIadUx6X9
	UJWpQ2QeI6
X-Received: by 2002:a17:903:17c3:b0:2a0:ed13:398e with SMTP id d9443c01a7336-2a71892193cmr102832235ad.49.1768892769464;
        Mon, 19 Jan 2026 23:06:09 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm111695665ad.27.2026.01.19.23.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:06:09 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 0/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Tue, 20 Jan 2026 15:05:53 +0800
Message-ID: <20260120070555.233486-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance, and add the testcase for it.

Changes since v5:
* remove unnecessary 'ifdef' and __description in the selftests
* v5: https://lore.kernel.org/bpf/20260119070246.249499-1-dongml2@chinatelecom.cn/

Changes since v4:
* don't support the !CONFIG_SMP case
* v4: https://lore.kernel.org/bpf/20260112104529.224645-1-dongml2@chinatelecom.cn/

Changes since v3:
* handle the !CONFIG_SMP case
* ignore the !CONFIG_SMP case in the testcase, as we enable CONFIG_SMP
  for x86_64 in the selftests

Changes since v2:
* implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
  x86_64 JIT (Alexei).

Changes since v1:
* add the testcase
* remove the usage of const_current_task

Menglong Dong (2):
  bpf, x86: inline bpf_get_current_task() for x86_64
  selftests/bpf: test the jited inline of bpf_get_current_task

 kernel/bpf/verifier.c                         | 22 +++++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 20 +++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

-- 
2.52.0


