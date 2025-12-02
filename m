Return-Path: <bpf+bounces-75882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 905FBC9BC01
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 15:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B345E346080
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896C238C2A;
	Tue,  2 Dec 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVQNfwkS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF919205E26
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685200; cv=none; b=O957rRcmkY22WF6HU4jEcv5nWMz50T10jzrGb2zClegnE/Dd3cT3cq91rhltQ9W9+h57JdSCr8z2jeigc1t55ZhQlhT7DCplRczivP+6vfje0ZN36qV0isDJQSROaPja5kWAebR9P1niLxF1d26uST2sYe2DtuwnBKFGy0Pit40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685200; c=relaxed/simple;
	bh=TvhO8/wWsryTXGAN0owlp5rKTKABTyepxFYULy3W2mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SjWNHW+9566MzvqpoGjZXrkPSNn8TA1Df67gTsppe/i4JYVbJNJxzbr8M93TmrbykLt+8V6IWbLxs6YxZN01kYCYwediiMdGws+DKRNcTU/ZSjd7SVt1V59Waivq0d2aH2E/1NN1zORt/a5zi4k2LAGe3cOOqbh5JNt21aVug0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVQNfwkS; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6420c0cf4abso5340432d50.1
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 06:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764685197; x=1765289997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZYiG845U9rknD0u3O9bp1/PvtZ8OwPH+UQAfLpgMIw=;
        b=IVQNfwkSQTVE/cj/HGW3SAvX2ZCamyuGLhFtiFuage7RozWddsEOXUfEDDgQzzJCsC
         /IYhg8ziRD2jvu+wcokxqSUaP+ROWGJL6MFEQpabuZdXR6TgHYZp4D9idQYqw2qukBfv
         cYmv0E54pihH6GK6dwn4NXaisBOPkVJpvGUmvX9rKMV+tRo7HWejyjtZHUQewniL/k+J
         k4KGmuYyWq5z+Y0D7gaCxQ5ngx8QY5KiwNtBjRakhtvj5XpmCvVaL67gqkYJftzLGN/F
         8Q/Tgx9zK4YVyR5wEryhItze4uAGhmlrhSoIoX8XpmlSXpLoVldNAM1tmEYwNMgApsSF
         uSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685197; x=1765289997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZYiG845U9rknD0u3O9bp1/PvtZ8OwPH+UQAfLpgMIw=;
        b=InZM5DUxhNWm/KUtoeR0CDvsSxsfJfjHGIFOVllf4A6clKGJbXjPVyKAz+r87uZElW
         o+1VejAorjN4OCmYCj8rJ4h3hG2/bu1QOESPzz+TWvAf7XF8zOG3t/iv+y64jDVF4Fai
         Gsww7dTjQUYSm4kDroanftHU1cjVVh7v4m/J+FT0T5XwLA8+MJpLFWkCSZUJEaKJ2yOa
         raBbFHq2WURB2ZUIe3gA8C3eQTUcoWa36xjKr/q7Uo1kIUK+TT1YJRKJ4fZj8Zv/tl6D
         znkdwUtSp4RTsQKzl7bfAy74sPqgtufOvBTaqCvmVm7XnazM6n4FvGXpJf9yUaN/XPOe
         n0VA==
X-Forwarded-Encrypted: i=1; AJvYcCVcKUWaoLByoJo0oHAUxoPUETWxsP79AKC91UPMeYd/BMXuEo64yp9VY2m5577zL7Mbfjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rCe2HcGeCqsN3gAYkKavz/Vsey1IWe18nEqJIaMcG21urkUs
	mQjLwRdGTUK44nY2286eIdMEaKdlLDckUgksFRV5qXkqZ7fw937wcXeB
X-Gm-Gg: ASbGncsqYfzDDRWy0PKEBGLvs+7hHS0jqblcfJ8wysN21POs2AqtjWAtyQxiEZvKvkd
	GFDVW8VB79ahuMxK1q9fDMDurjvE8z63s78gc5OVv8wUzs61l3PYoaudb9JQ342P1lS+P8/lP7c
	eIMI8zkrmwNqVJRrWAdgXMh1pcwLoHrLFenBD/6V9INLM/4yaFJ2kr/21giTOMMNAfOqdxNbziK
	L/X1d/xLy05UXtnLI5EaFOhZnZ29aexyVTy+JWoq5YCr7oY5GEdSDLPCmwX7MuFf4r1rsUGUoBs
	FqU+4pYe+EU2b9oeYOpTq3lwh2PeKZbPffh6DlsYfh6RgRtCO+AH/olTYITrWQq9QHrYhjUM9Tg
	zbFkRgvEOCjGaaFeUj4ipgP8X0NicvhioecIuEdwxW2RmvekR+E2FhsfXzwoNvXY64TLy3I5447
	4DXtpkpEQ1LRRmdwwOkEz4rACRuzBLi5UEOjaZhUfJyQ4ngIPASImoDta+gx2rGw==
X-Google-Smtp-Source: AGHT+IEBiHZjjwJYZm4wcRsjMQxrAiRlrUNXkeZHkzrztMI4TVsP7sWW8UWzi8YGWUgGsSgqi5H7mg==
X-Received: by 2002:a05:690e:12c9:b0:643:1a78:4492 with SMTP id 956f58d0204a3-6431a78497dmr23565216d50.81.1764685196722;
        Tue, 02 Dec 2025 06:19:56 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c497768sm6257715d50.25.2025.12.02.06.19.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Dec 2025 06:19:56 -0800 (PST)
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
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com
Subject: [PATCH bpf v3 0/2] bpf: fix bpf_d_path() helper prototype
Date: Tue,  2 Dec 2025 22:19:42 +0800
Message-ID: <20251202141944.2209-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a verifier issue with bpf_d_path() and adds a
regression test to cover its use from an LSM program.

Patch 1 updates the bpf_d_path() helper prototype so that the second
argument is marked as MEM_WRITE. This makes it explicit to the verifier
that the helper writes into the provided buffer.

Patch 2 extends the existing d_path selftest to also cover the LSM
bprm_check_security hook. The LSM program calls bpf_d_path() on the
binary being executed and performs a simple prefix comparison on the
resulting pathname. To avoid nondeterminism, the program filters based
on an expected PID that is populated from userspace before the test
binary is executed, and the parent and child processes are synchronized
through a pipe so that the PID is set before exec. The test now uses
bpf_for() to express the small fixed-iteration loop in a
verifier-friendly way, and it removes the temporary /tmp/bpf_d_path_test
binary in the cleanup path.

Changelog
=========

v3:
  - Switch the pathname prefix loop to use bpf_for() instead of
    #pragma unroll, as suggested by Matt.
  - Remove /tmp/bpf_d_path_test in the test cleanup path.
  - Add the missing Reviewed-by tags.

v2:
  - Merge the new test into the existing d_path selftest rather than   
  creating new files.   
  - Add PID filtering in the LSM program to avoid nondeterministic failures   
  due to unrelated processes triggering bprm_check_security.   
  - Synchronize child execution using a pipe to ensure deterministic   
  updates to the PID. 

Thanks for your time and reviews.

Shuran Liu (2):
  bpf: mark bpf_d_path() buffer as writeable
  selftests/bpf: fix and consolidate d_path LSM regression test

 kernel/trace/bpf_trace.c                      |  2 +-
 .../testing/selftests/bpf/prog_tests/d_path.c | 65 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
 3 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.52.0


