Return-Path: <bpf+bounces-52878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C84CA49EC3
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 17:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37B03A5BBB
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803A3272904;
	Fri, 28 Feb 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9AmGAEX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCB26A0DB
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760144; cv=none; b=OnpHCdjNmrlzRjPdpgxGJPXZ936v+YVoAalrxPzvzYmNMm2nQRXGYbx2JfiPSADk9+NCsErvf12Rh0VRUiBNZJZekKJLXYd1o8lSfmUnebpxSsMYyoZvYaQftHejtwlHflzWaTxn8yUo1yTcMx8o3txtkDt4VoqxIqVILrhMbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760144; c=relaxed/simple;
	bh=RYzPVMA10WxTuVpfT+ffml8CnQHKjdy62WcB3NE1Cgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gigkCiGfDh6sC7wXYMlIcd27+Ijyv4mstZZTA1MIyQb+amQYadrpy4mNdtsNW61LzbzecH+Brh/wG3kOCkcCbvd46I1CGpHAGj2RaYTEX+OwH1dgTk05DIqdxUsgAt0KtmXjgmTP1mifQLpbhbhfda96SsmoHBMBMPcIYBdzdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9AmGAEX; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so15629555e9.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740760140; x=1741364940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FF2tNNrUV8Hj9tn35Hb6zIFN/4UY+5zBfgKFRgiCg3k=;
        b=Z9AmGAEX5COJd7FexKk53ln6NP97iwnqHO2b2am/2YqPvM/21ubUNTTP1cpxRcD/fp
         hJO4l2+6vtQAsDjxee47gYbvhmITOL8z12hrSp/AnkLe2YpG8g4NaW4+1XkRSNvmQCU/
         ERFOLM0gI9Gxf2bYapK2Xd684pweJ18OhuF1wsBVNY11mF7Z4kBxjZ4s8Oi9cu/w42y6
         7wWz19MlUwlnWKBEhVSJXdAknNctRzWMW5rbyraHazjd0HJeV3UrmDZEe3pUNny/g588
         aIEnYSAaKqytvavxcYsg7yiXI3lpR4tEHGJqq/NNWXVO9wS+7ndvRfwuwzA2on/ZRNaX
         V8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760140; x=1741364940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF2tNNrUV8Hj9tn35Hb6zIFN/4UY+5zBfgKFRgiCg3k=;
        b=OiIh1WX/UrvVm8lWaZqLuLdEdKmK5iK/jVo+EFCZNYzwYjiEeck0mTE1UUv6eWfLLl
         UsSPBkvMe3W/C84zk54g6lzejeg2TQbCa1J70RWgXVO8PByxJ5l5+3qcwfjtYE+B3lve
         X44sZDeD6Wdl1MZLPfce+mAPQQiYb8nW37/nhNKJ906dtkgkUKDSrygvC/T7Nxg6+Qye
         hF2DNyjM22fgrC3NH4GGW109iyUiqrA77mwq5VEGoUCAYmrWbB532eQJC7V1mbwl63yj
         OCyf84GNvUcr74K297Y4PAzog9j7uoo3oh1+jZldZTpDQbR0Ake+aY02sXzTSxmoUOCu
         bJRg==
X-Gm-Message-State: AOJu0YyRsQ1etoYtcVlA+F/nw0SwBecjLtkPVztoJpwYCmtpl/pc4hWs
	5XxZ2l7uHSwB6R7v89pkjqWKcnq5fAUqjD0l9gFmPah3v/sdb9SwAHFr1JxPKwM=
X-Gm-Gg: ASbGnctNsgsEIm1ZD4HXix+2zRblBcrTcE9YTcD6MPbXWk3geA5qk+GJe5WS2tK3vqO
	7TLtmrI1pnM2RcU2S5AFSu4DFL63VhhKIMMpBHtdRXRuzQDu3Sh5WHRnGl2hfItPAAgTR8Kxkqt
	d7XFh1gl1Mad0nXUAOAWmu15pulRe3TpuR+xRNu+crI+mYvuZUAySwm/TZkSiNSjYAYWKAPBgsl
	HZr33/4ibSG6re7Ln0cODyTpCDqheHjXKl5X4mjFdpHrgQAqMmZr4t2TnsD4NgifEYxbofUAByA
	Ck91y4Wp1cqyrPRm
X-Google-Smtp-Source: AGHT+IFWX6yQs3InHwt+iP1YTGyxHefGKdNoOehZms471wCi08t3QwnlRTQRLLXuVfJq/MsmMD9QuQ==
X-Received: by 2002:a05:600c:190a:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-43ba675830emr28332545e9.24.1740760140136;
        Fri, 28 Feb 2025 08:29:00 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710c2sm91515925e9.32.2025.02.28.08.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:28:59 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Global subprogs in RCU/{preempt,irq}-disabled sections
Date: Fri, 28 Feb 2025 08:28:56 -0800
Message-ID: <20250228162858.1073529-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; h=from:subject; bh=RYzPVMA10WxTuVpfT+ffml8CnQHKjdy62WcB3NE1Cgg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwePuAQzZSZpvuy7CZ2GXa5cl07BsWlksOkm0gpqu zICcPMeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8Hj7gAKCRBM4MiGSL8Rys61D/ 9fQ3WbYGdOJeiamgw2NTff3EZ62rqWIq1D5lP7m+TdTNfPW93Nh7IwLVDnAx0AnKtPo5MIaUp8q0j5 h1J9RlRdRM+kRbwbrLgxINqyHcjzf+SvQ7q2cjUF6uruzl4E34wIdYWohehDGbYd2NdPzXrogW1KkR onDkm2rjXao91SYUVl7qREtv6rhudMgO1ZsWnmPIRCncwBb1qDkT7hmDNm6gF2yKaLY8BaO3Vt8gFA zSntHWxzLqe/FzXYSRpE4JuWrj65xR/irI+pBLdA2XWXbhPC+XQg9wUAub4T180cdOMXy4RubKE4Dz 88u6FNYUqOCRt80zsLwTMg8mun1A8XMDsgtSDlsjlyiVDl/FOY1L39oWd/w6+KfECK0TJeccXFSDQ8 5Yibg7XtzwnzqJsYOfM8yyAIESApSyZ7Md5CCYZKjbGhpVMbqOOce/gEH6QkQNsKHMJRaXiF8wMYnH 5/Pwj3syoX7iQY8bABrnbUpSifRzbs0mC9rKdIgGbyTM2/2Dhn02c9CdS5lkxF+oxJCviIr5eTyaw3 2/LUzGYC5VmcZSquJ1FpjlQKTnsnoFqzHoDAfy4Kua+8zK8vejp9HLKPirzDRgdWxRHKrpBmdy4rQ7 IuNQOQgJLbV/bd86tvniqNVGFZfoML3/CLC3mKaWRLAkPig8zoq0qzW78y4g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Small change to allow non-sleepable global subprogs in
RCU, preempt-disabled, and irq-disabled sections. For
now, we don't lift the limitation for locks as it requires
more analysis, and will do this one resilient spin locks
land.

This surfaced a bug where sleepable global subprogs were
allowed in RCU read sections, that has been fixed. Tests
have been added to cover various cases.

Kumar Kartikeya Dwivedi (2):
  bpf: Summarize sleepable global subprogs
  selftests/bpf: Test sleepable global subprogs in atomic contexts

 include/linux/bpf_verifier.h                  |  1 +
 kernel/bpf/verifier.c                         | 50 ++++++++++-----
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  2 +
 .../selftests/bpf/prog_tests/spin_lock.c      |  2 +
 tools/testing/selftests/bpf/progs/irq.c       | 62 ++++++++++++++++++-
 .../selftests/bpf/progs/preempt_lock.c        | 40 +++++++++++-
 .../selftests/bpf/progs/rcu_read_lock.c       | 38 ++++++++++++
 .../selftests/bpf/progs/test_spin_lock_fail.c | 40 ++++++++++++
 8 files changed, 219 insertions(+), 16 deletions(-)


base-commit: 0b9363131daf4227d5ae11ee677acdcfff06e938
-- 
2.43.5


