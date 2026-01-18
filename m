Return-Path: <bpf+bounces-79376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 062DCD3934D
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 09:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 471A83004281
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 08:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18F274B5C;
	Sun, 18 Jan 2026 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWwZKq09"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933617993
	for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768724243; cv=none; b=c75i7WOYRL6TlmJjjSv2+4QyVnUjcmTfQ+avvYC+hy2XT78SYeybOhAyblOb6tiEXIE5qQWAWNuQgKrcLddCbM6Wbivf/2dwPi7gA6XfTLQcWlTMjdcvVbkkcT0bWGn9qXpwjqU3uNnzMnOtNN/V67rCa/kv0j3Fyw7oka+kUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768724243; c=relaxed/simple;
	bh=Pj1sPigIp/NebNJ8oa/bhXNBS40dnz2XB0+eNSKkJvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ry3p0kMoiVwMuZope947defT065h4rjpwba0s17ZmDr17tJcpc47tWSk3nmvZOYnQYINjCFYL9whP4iRSQWXNps2LfYUOOUaWOwvH6iI/sOejdBw6GpEFK5ngu40WM+8+ddfkLy1ojzMuMrnVsWdfMyZvCjDXwsqVs82mx+vP4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWwZKq09; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c56188aef06so1258961a12.2
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 00:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768724241; x=1769329041; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEP5iKdXQBSTEl9I4Q+Cs17dhqRzcqmuf37yAQk7v9Q=;
        b=iWwZKq09MSYQu0avfOEQBEEyb6WzCtjjYNO+WZd/Ul2R/MZ9z6e4pJNelAJggKCsPp
         zMPmyxFInbNQR9mynkFO2SHw46qFWnKDSIJ5xkRxDabd08wPtEXwamKNwDbnha4htTiK
         K4sukEgVk0jbyxdrYXsbLH05tr+MAb4I7j9RTUyPTTxnsVqhVHxps5m3R9Ps4S+7iRhD
         iU+tPr/3c+/RpESiKG6BlOhwR9+fdep2+wR1T1rtntm+1Rw1i7uDrtNMDXMeOiwL0ZwH
         rZTtJgnnr/c5BQq8LU9rRjfPvaO89oWLDNS80L9sBxb8LxEhkZnn3exCbQdlM6Oh3flK
         uEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768724241; x=1769329041;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEP5iKdXQBSTEl9I4Q+Cs17dhqRzcqmuf37yAQk7v9Q=;
        b=QbW8j1MzkTd42bcq/zjoGY7AZAAaK69I2ya3YVyKJDv9KPhEJcfo6SBfFdE1F/J3Tc
         rO/JStNJOHeJ/2NmWIJc0gMREdDBVW0wNDdvJkROukKgzNptGcCxn9zpj+RYLFreYImo
         i5ImBxUaccvHDuRpd9ez5Ltz62nMuqSlVwWdc5Et6w7AtIFxAA+4Rcy640UdygFk4geb
         aiNIIFjm1XNJgX6IdRTE2S+uu1vmLJ7OyWYREPZjP2h536TiNipoH5vc9E8WrSjK8ztB
         ua91MtADDuPUuPoHuhcARivG83Kc3RilYbbSoh/fvnb1WSHhxLMdKmHte2qeqyO9fXy4
         9AKg==
X-Gm-Message-State: AOJu0YxFAshqncFsHKgUUCuEf/q0M+C3+EMCN6tHrGfsqwhDGASE1cic
	2LZteoHRiiQzfWewcXmINPSAVPTDiVqc+CffWtC5yK5D13G+/U3BRUyy
X-Gm-Gg: AY/fxX6RRKM6X0PiItUurvq2Qcyd14LsL2OaxK7+YkPI0mbDnqpxvEIZ/W4O98NUjnG
	mkNdR9xcVeAK7h+skqOMxG0go6I8LxPaWcK2myThco+hZ9+xwFaR+qV9qpyG6AEinrCP0u/DuPe
	1pmNg7ef/YfoKgEghG9oly7N4A9x43T5KLLIEtkt4SvtFC4A364o+JFl/xv6B7n+nP/x5PEv7ZF
	JWoYqGxCEmmvCk6DGuyWSCnwhaTMbZFSEstvMmVcyDUEhc1MZnki1YWorQ9HxSYbdlkYb+gAhvN
	JwJOg+zIlrDyQs4kwxlewTnWL9TZ526bFBOvj6E7E5syZuXm16QhAWc7gdsO9/qwvqNrMlCetZt
	9DMStbh/o1j9Wx6d9FG1F7780yvdleLP4yWL1eydaSQI2J7nYCTnklxrcLfTOufwW+pNnrRcGDB
	EFwJDdFxXv
X-Received: by 2002:a05:6a20:a10e:b0:363:e4d7:2c34 with SMTP id adf61e73a8af0-38dfe772e84mr8200324637.57.1768724240888;
        Sun, 18 Jan 2026 00:17:20 -0800 (PST)
Received: from [127.0.0.1] ([38.207.158.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d1f1sm5917393a12.22.2026.01.18.00.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 00:17:20 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Subject: [PATCH bpf RESEND v2 0/2] bpf: Fix memory access flags in helper
 prototypes
Date: Sun, 18 Jan 2026 16:16:38 +0800
Message-Id: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOaWbGkC/43OPQ+CMBAG4L9COlvTnlDQyUFWBx2NMeW4QhOwp
 BCiMfx3K4mJA4PjfTx374v15C31bBe9mKfR9tbdQwGriGGt7xVxW4aagYBEAgheU9ORv3XeDY6
 bQpGKZQaxSlkgnSdjH/O5Cys6E53yc348sGuY1bYfnH/On0Y5bywfHSUXPHQViXIbA5T7qtW2W
 aNrPz8CUkKKdAlJoxPYGETzP6JNlpLIIJWIP+gTeYRvzCUMAceYKCgQdaKzXzxN0xsyWYlHWwE
 AAA==
X-Change-ID: 20251220-helper_proto-fb6e64182467
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2233; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=Pj1sPigIp/NebNJ8oa/bhXNBS40dnz2XB0+eNSKkJvo=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2bOdI4//0sX75KOcjrXvYe55mrw5e0XJHZeXj5VMbQ0q
 CVCwVKqo5SFQYyLQVZMkaX3h+HdlZnmxttsFhyEmcPKBDKEgYtTACbi18/IMLv3wQezHzKJzzyr
 r18qVbapNmMOZatc/jf7MtOqHF2fA4wME+5tnLUier6H2NdcfwHmbH2FSZpqxwQ5T1/RNtiZYaH
 DCQA=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Hi,

This series adds missing memory access flags (MEM_RDONLY or MEM_WRITE) to
several bpf helper function prototypes that use ARG_PTR_TO_MEM but lack the
correct flag. It also adds a new check in verifier to ensure the flag is
specified.

Missing memory access flags in helper prototypes can lead to critical
correctness issues when the verifier tries to perform code optimization.
After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking"), the verifier relies on the memory access flags, rather than
treating all arguments in helper functions as potentially modifying the
pointed-to memory.

Using ARG_PTR_TO_MEM alone without flags does not make sense because:

- If the helper does not change the argument, missing MEM_RDONLY causes the
   verifier to incorrectly reject a read-only buffer.
- If the helper does change the argument, missing MEM_WRITE causes the
   verifier to incorrectly assume the memory is unchanged, leading to
   errors in code optimization.

We have already seen several reports regarding this:

- commit ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's
   output buffer") adds MEM_WRITE to bpf_d_path;
- commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name
   args") adds MEM_WRITE to bpf_sysctl_get_name.

This series looks through all prototypes in the kernel and completes the
flags. It also adds a new check (check_func_proto) in
verifier.c to statically restrict ARG_PTR_TO_MEM from appearing without
memory access flags. 

Changelog
=========

v2:
  - Add missing MEM_RDONLY flags to protos with ARG_PTR_TO_FIXED_SIZE_MEM.

Thanks,

Zesen Liu

---
Zesen Liu (2):
      bpf: Fix memory access flags in helper prototypes
      bpf: Require ARG_PTR_TO_MEM with memory flag

 kernel/bpf/helpers.c     |  2 +-
 kernel/bpf/syscall.c     |  2 +-
 kernel/bpf/verifier.c    | 17 +++++++++++++++++
 kernel/trace/bpf_trace.c |  6 +++---
 net/core/filter.c        | 20 ++++++++++----------
 5 files changed, 32 insertions(+), 15 deletions(-)
---
base-commit: ab86d0bf01f6d0e37fd67761bb62918321b64efc
change-id: 20251220-helper_proto-fb6e64182467

Best regards,
-- 
Zesen Liu <ftyghome@gmail.com>


