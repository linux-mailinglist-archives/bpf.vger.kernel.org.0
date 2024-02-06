Return-Path: <bpf+bounces-21290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4B84AFB3
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 09:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787711C22227
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 08:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539A12A17C;
	Tue,  6 Feb 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQcm2YDU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DF12AACF
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207282; cv=none; b=KV3xaDXGBRTTZWWw6ykZOLGgV/N5sDExRv9wPGBmFh1bSAKTlm/hcJTjREK1wUmABSm1ywNQ+JBH1gkaBt6KHqvZdBWf6Gy8walVUVPxd0yzk2y/vNaLEM4EWGur9M+kCDJjUH4lFFiHX628/4ksSBiYsxRbpXNly+s4WmpCL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207282; c=relaxed/simple;
	bh=S7eAUhJ8hqTv6o6yVgGkb89nI5rOzNExitdx3weOa1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eB/aM9crpgWxjSIt0fbAZrnGzqyDe9f9Ez0twvXfceJjjrvoOagBk2V9CljW940p5gvBDFGlUFTW22bB/9FzIR+zFFX+34Rc7UcbeM8X0f49fSP7m/OzAtUxljI9ogi2tUMJQZmejYXGT9EhM1qt5Z/EAPyAnjzN2KEwTOkkToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQcm2YDU; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e2794e5a35so2378764a34.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 00:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207280; x=1707812080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Lqz371VIH/39MFcoBpVOZ+n4sCsueBrYONnaXOYdBM=;
        b=LQcm2YDUu/DrO472ecqE53sYoG8q4MVS8V43Qfvu+OOXMX7JCtPtDfe12Qp6U5UXCS
         s+G1vMatqR2YXgLh+kZAauhA9p1eMZbN4biw2SrRMMJw0nk2nrcuvwqd6zPJ7yCvqAp3
         S4f6bKI1G1rcGdCQR+cs+/sMe4tkeCSAiiyTebHQ1P7BpgHBMElEu01QABn4gGV97veh
         plvXDsUscd7kjb9OUgDvPKb9m01HLopTEcOOUcn5GDXjcna22UBxKuF//9ccTUQivaZ2
         pET2oOGK43dnnuGe+DVBkjrUqCRDf4HmGJNBJHvhqKvRkPFnBxqPlDBr/R9ky+ZskLlQ
         EmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207280; x=1707812080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Lqz371VIH/39MFcoBpVOZ+n4sCsueBrYONnaXOYdBM=;
        b=Xs1GrqE4OE5sfqtPKKo/hE6/sh+tf4G1dncKTFikiqRkhZjC9c3SIY7uhMUiPfFDvn
         PvVXrPQ4SFt/Y/jBoRpP/uoMk6llXAwXHcYWIzjLFHB7InGhD0klC0oOt/oYUtkl4Ntb
         1Nnrf7W6uE3cgAAxo085vnfgTuhP+jR/lcUrHOKJms7W59rjKU1QZl2TnPj8UpxrXDbW
         vtUU9RejJqovHBxTIU+P0ZcnVg/B0C91U4oT68gNx9hojLbXXUaJ33do5Bvz+2zBhpYY
         bI47eifsFUdKRicSLiUXufVXpo9ffR7Q/z70O0iIJy547mBOvy6ajIcScp7B5W4gmhU6
         Q/QQ==
X-Gm-Message-State: AOJu0YxF5ZUpwVnm5jFstzvMZQ+oUUaTTmYR51PfQO9ecWRAl2Vm40pS
	SAN79Wtxcb7MKuoGLdH+ZgjhXueHcC14kkKNO7a6T7aYFldVtyrH
X-Google-Smtp-Source: AGHT+IFMILtT7Gz5et6sC9JpdSNGef3t2p3NKgbYayhdbAxYoX3fQdZfv0cg2M/YJ2HTHspexVmPHg==
X-Received: by 2002:a05:6830:4782:b0:6e2:b26f:5a5d with SMTP id df2-20020a056830478200b006e2b26f5a5dmr327826otb.11.1707207279698;
        Tue, 06 Feb 2024 00:14:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXasAjKtOO/SYWn2/qI6EC/8oecWQDY52xaoDUbBnECvAqOW/LxcRctVu5qfRq+WbMceiT+40Ev2m5XSCpEU0AgpITL6epAnczTx9XZvA0cCCQ79k2fPEDNLjBiHmJfCtuDp8UUZESwtDSFUOMuk/D6vU9+5OYdNRn5adES+JQvyoaeTK59DFqxWWquhJvTLn7Cl3IhRv3qvystX9MLH1xyUAdrdPmvMcwETNyo9SANhzS5wnxRflyyCcmk781+O+IJzP/T2aM2HvSbwxuMZ6W1HcuV5LkFzqWgRos4u6k40nudw8Yt3/KstJ89A+n+dNTXKgGghjeC6hZJWbqQ+3RLeWObxOq6G4nAQ+ZJ5WDTCXansAEfg0W6Gwq5skAjg1M+Qk8z6En+7xq6Ys+jS25Qy5qY380GGz2cxtsU1m0XNtlKNhMbgQ==
Received: from localhost.localdomain ([39.144.105.129])
        by smtp.gmail.com with ESMTPSA id 3-20020a630c43000000b005d7c02994c4sm1381660pgm.60.2024.02.06.00.14.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:14:39 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 bpf-next 0/5] bpf: Add bpf_iter_cpumask
Date: Tue,  6 Feb 2024 16:14:11 +0800
Message-Id: <20240206081416.26242-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new kfuncs, namely bpf_iter_cpumask_{new,next,destroy}, have been
added for the new bpf_iter_cpumask functionality. These kfuncs enable the
iteration of percpu data, such as runqueues, system_group_pcpu, and more.

In our specific use case, we leverage the cgroup iterator to traverse
percpu data, subsequently exposing it to userspace through a seq file.
Refer to example in patch #2 for the usage.

Changes:
- v5 -> v6:
  - Various improvements on the comments (Andrii)
  - Use a static function instead as Kumar's patch[0] has been merged.
    (Anrii, Yonghong) 

[0]. https://lore.kernel.org/bpf/170719262630.31872.2248639771567354367.git-patchwork-notify@kernel.org

- v4 -> v5:
  - Use cpumask_size() instead of sizeof(struct cpumask) (David)
  - Refactor the selftests as suggsted by David
  - Improve the doc as suggested by David
- v3 -> v4:
  - Use a copy of cpumask to avoid potential use-after-free (Yonghong)
  - Various code improvement in selftests (Yonghong)
- v2 -> v3:
  - Define KF_RCU_PROTECTED for bpf_iter_cpumask_new (Alexei)
  - Code improvement in selftests
  - Fix build error in selftest due to CONFIG_PSI=n
    reported by kernel test robot <lkp@intel.com>
- v1 -> v2: 
  - Avoid changing cgroup subsystem (Tejun)
  - Remove bpf_cpumask_set_from_pid(), and use bpf_cpumask_copy()
    instead (Tejun)
  - Use `int cpu;` field in bpf_iter_cpumask_kern (Andrii)

Yafang Shao (5):
  bpf: Add bpf_iter_cpumask kfuncs
  bpf, docs: Add document for cpumask iter
  selftests/bpf: Fix error checking for cpumask_success__load()
  selftests/bpf: Mark cpumask kfunc declarations as __weak
  selftests/bpf: Add selftests for cpumask iter

 Documentation/bpf/cpumasks.rst                |  60 +++++++
 kernel/bpf/cpumask.c                          |  79 +++++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/cpumask.c        | 158 +++++++++++++++++-
 .../selftests/bpf/progs/cpumask_common.h      |  60 +++----
 .../bpf/progs/cpumask_iter_failure.c          |  99 +++++++++++
 .../bpf/progs/cpumask_iter_success.c          | 126 ++++++++++++++
 7 files changed, 552 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_success.c

-- 
2.39.1


