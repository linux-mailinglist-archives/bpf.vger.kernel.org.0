Return-Path: <bpf+bounces-75805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB11DC97DF0
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 15:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16803A3EF7
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FA31A571;
	Mon,  1 Dec 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAYg8oVo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182031B126
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599910; cv=none; b=WizZj4QyNICMxBTXxbMBTLchHPoju/KSOhYH4DQ81ZayTWwz6YIgT0TMupK/WVQrIYvCqq+l9okQtFHYP6YDxBhiBz5Z7BRsk888GreXXzw5DmHQ6eOfcq/d2rkGD+hUYJVS4bes7XaalCsSl5b1TfV4h1Lr/xmkDSlvJ7740lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599910; c=relaxed/simple;
	bh=rjNK3UwqIhTAnumjotkMQ2qII4wyclxKpa+AuGebp7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JcaThjtoKoKuSmO/gngoS+bUsQYRVBQYTvYXMPyfuKhfJ+KdS/p9tnSNWffk5QLTfDTenu3v+EDloEpzJ3aP7fen2IjLlrU/9uxWRZS1Ne3QS5/w7gfAxFeqP6RlDfQ7qVpmxxeIXd/uTSqTsWe6MoO811LEXLKvO1FEg7aLCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAYg8oVo; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64306a32ed2so3480584d50.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764599907; x=1765204707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoyj2tNThNgZzU++VN5wulg14DP/XWN247AZ19CJZVQ=;
        b=AAYg8oVoyaNdDgQ1TJlE3tJIkkz9ZSOh5r1NzORgnUwpxNw8tWFvKTPbAVOjVXnQqW
         CL6AA8tzRInzrrxAzRL0F8lpwZCjb5LzTrqt7NkyrpLYy5N0AOdTAtPWFzZe7LsFm4JU
         3pmAWZstmh7lrvIT2nSocw86CzOdC+9jdx+Qd0zAQLnzYpIJkbvxs7NF96KFCHIFGKwT
         qXvfFgUqPnYYyEVrbbOl5xx7pon1M581t16WNJ0R39yATeOShxbBUTLZRtkdzcmKA7tA
         TYUTLh0Ocf5oFQE97ShvCY2Bv3LVk5+mH2HAB7IZAIPF6l3KIVU5T5yIZU0q1ImhtY5W
         doQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764599907; x=1765204707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoyj2tNThNgZzU++VN5wulg14DP/XWN247AZ19CJZVQ=;
        b=Uo3DI0Cv4RVMTgGGtcAEwmy1YW2Nqr9FemI/K5sbBkOnZXkWRzqLo7KNmUIKRO8GJJ
         3TfpNzT3Dn6n6zA2/rA4mk65vSt+vUEZ1iRbeUKUVeyGZUJ7BuumpV58eGAwa5bRayB/
         B5BIFsblXx3o9AG/lBuy7C/w8IsUaBgChgekDjn6sABcPvXfsxRxb6cDcVYrH4OR/lIW
         vpnDC/CANLtcIq32BmYtWBSncP7zc99lFjgMWuBVP/GPmeBUc0Otv4ltBoUZI3thWc4k
         rPwEDxA6Tcd7pN9jcQULiP9ZlAKqIIfStMQLubMWy29t/NMGABGLjHnwLZY9YRbhDKHq
         6vMg==
X-Forwarded-Encrypted: i=1; AJvYcCU0PoQR3InoNAHwfJQghStUDfIMzNgFBoQi1h0GoLbzWJUQwHyvw/cbRV6eM2hcuvI6/54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkhl2oXpCEfMCbGzBXrRYXVpJhFKJYNOAngJyjKKV6El/s0JwT
	6Vg5OaNnzzxz7xSds+2c+ueIcP+61t57KbGlDbUdRsfsCLAQ+VM2PDL8
X-Gm-Gg: ASbGncv05gf/5KJWwY7o5rqh2Vkb8SUGqeF0ZlLM+nrqxL99YR70EvtXF3ycaF/csx+
	gOOV9S77+1R0fp6MLCRivyaZvCI6GknoKGjMT7G9RqkvmibK7yztSS0SAI8XpbUbYesheQdws1c
	/5WHQwobRfOqtC4MiOTMztFBpcJYmNo0KhYHY5ZlVFvmV3d24a4ppAYMOJqYYs0xJPtBss133Jo
	qmoTLHBiTjyByLa7RrOzkpH5anNoDip2G/pQKwNiZgjdVzon54z8N/+ZQ6OXk+zJChegv7Jn9Me
	1RpzbihnIsZqxW9z8cQqfd3yvWNKmH7s4/2rb00vbJW5LSnRBCjPZBctw0otWnNTdg3GyyEX0Dx
	qJuN4i/YiSQT40UoRTQkbk7lg07TEQfpHoy2343vA5dCfuEDvKqOyQvw4Z0B6/fNJlp4uKW72C/
	q0O/fNCQZ3lYL1sxP5H/hofEAF/RXppLF2oHqR9gdhdomRSskvX0o=
X-Google-Smtp-Source: AGHT+IGArkphxhez0KD4SZWDD8fCP5Ui5365d/v8ljTpLTjBeitEXtnR33EfWWTgVFCJ+HypEj1g2g==
X-Received: by 2002:a05:690e:1544:20b0:63f:2b69:9a17 with SMTP id 956f58d0204a3-64302ac69f0mr22683616d50.59.1764599907294;
        Mon, 01 Dec 2025 06:38:27 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c078297sm4889911d50.9.2025.12.01.06.38.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 06:38:27 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	electronlsr@gmail.com
Subject: [PATCH bpf 0/2] bpf: fix bpf_d_path() helper prototype
Date: Mon,  1 Dec 2025 22:38:11 +0800
Message-ID: <20251201143813.5212-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series fixes a verifier regression for bpf_d_path() introduced by
commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") and adds a small selftest to exercise the helper from an
LSM program.

Commit 37cce22dbd51 started distinguishing read vs write accesses
performed by helpers. bpf_d_path()'s buffer argument was left as
ARG_PTR_TO_MEM without MEM_WRITE, so the verifier could incorrectly
assume that the buffer contents are unchanged across the helper call
and base its optimizations on this wrong assumption.

In practice this showed up as a misbehaving LSM BPF program that calls
bpf_d_path() and then does a simple prefix comparison on the returned
path: the program would sometimes take the "mismatch" branch even
though both bytes being compared were actually equal.

Patch 1 fixes bpf_d_path()'s helper prototype by marking the buffer
argument as ARG_PTR_TO_MEM | MEM_WRITE, so that the verifier correctly
models the write to the caller-provided buffer.

Patch 2 adds a minimal selftest under tools/testing/selftests/bpf that
hooks bprm_check_security, calls bpf_d_path() on a binary under /tmp/,
and verifies that the prefix comparison on the returned path keeps
working.

On my local setup, tools/testing/selftests/bpf does not build fully
due to unrelated tests using newer helpers. I validated this series by
manually reproducing the issue with a small LSM program and by
building and running only the new d_path_lsm test on kernels with and
without patch 1 applied.

Thanks,
Shuran Liu

Shuran Liu (2):
  bpf: mark bpf_d_path() buffer as writeable
  selftests/bpf: add regression test for bpf_d_path()

 kernel/trace/bpf_trace.c                      |  2 +-
 .../selftests/bpf/prog_tests/d_path_lsm.c     | 27 ++++++++++++
 .../selftests/bpf/progs/d_path_lsm.bpf.c      | 43 +++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c

-- 
2.52.0


