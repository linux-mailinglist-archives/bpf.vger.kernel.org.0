Return-Path: <bpf+bounces-78089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B19CFE0F3
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FD0D309794B
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D4232E72F;
	Wed,  7 Jan 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQx0CCIK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468332A3D4
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792149; cv=none; b=MJflYkMufQ8MUhtRfcNIHdvU2r0nAz5FXogMWe/NpTrHRKs8PPpBC1XKCjMcHASceWCzlAF9m8IRnSjHGeqCDduXQmTbmf3ms44vXiopAHHzr7fMc0Zk8uAy7aIa6pPZZsKfphkKZj/NZ39njw/v0zBe0lfRw1+2XGdncBbXS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792149; c=relaxed/simple;
	bh=Pj1sPigIp/NebNJ8oa/bhXNBS40dnz2XB0+eNSKkJvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lm1D44u4Z1gRj/XAchDGaub/2NHjH8330DI15hVJm03V/7xtDLEPosMSFb+Y8R0PK4DLV8Ri+mrM69RGNJxyceRLazTjmcQqGRU6xdTFmAds6Fctv0QCXnsHj4aOHdQoir4NlUuD9I0BvU3T/6P8iDAwTe4gxLXUwZ2tODRfCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQx0CCIK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b98983bae80so1196119a12.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 05:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767792147; x=1768396947; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEP5iKdXQBSTEl9I4Q+Cs17dhqRzcqmuf37yAQk7v9Q=;
        b=NQx0CCIKLBEIeqyxEiE0d9FQ4K07G9LezoF4vEX7m6lyj91LG4D1WMOLsD6C7mVZtv
         hCQPLTUU0X0CuLTjyB4zk0PfaPeT+u2P/mvOLvZeWrZg+1yyUHxL+3ctux8g5qRvUSec
         CDt9pvNHusss9nticdHHyRpUzS9yz1FI/Fe6328paOxMNcCuBB9htnASsrZR4brEWLEa
         TmDckrqJTfLRilPKCqdGoPitGTvTEOlkNpYPFEwBk4y6HiKyTUXWR1fV8wEQywLUKdht
         HqfHI8SHrlZJkAEkcfYKZcPQB9yp3eS+C+KoDMGUHn4rJmot/kJjkUF8rvvX5sXqdlcf
         WewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767792147; x=1768396947;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEP5iKdXQBSTEl9I4Q+Cs17dhqRzcqmuf37yAQk7v9Q=;
        b=LJqXaADvhvOUVoB/RwtpNjrOSZ/kMBPG0nfBCA0uKxT6asTUyaW9MSpf3cTEjmlH/d
         xCl/lCMiDBiAn/5cyEkBJHaoFH5M1gpd6eYobBdDuvdilso1/FIm+cDLc3fYqkc9JZ9K
         3NTyXR+yI7FIKCS6IRRfhDnlV6CQP1jcOxiiN8RDj6lBUkeGQm7gWo2mmW2wlB+RwuNF
         KMYNZ5h/rkgY8uMkwTN0BmOsvq6emu/4YiDTFiGGz9dhdiuXqnzajI3AxSrdTyv2ID+1
         FToADcPMyqRtSt0m8gvdX+WnWoxCm7HReonC8u/OyS/9ZLhKlh8VPNr/367wjiPrqBBD
         6+qw==
X-Gm-Message-State: AOJu0Yx/+l50F8FQABgr+fzQL5Y9tUSchTPSbdzBGkB2vewnGJmhkLWe
	ExBR+pTKowEwjLHCv0WDPntnFHCb8rvgj/agOdJJSL2W1bOiScnnt+g3
X-Gm-Gg: AY/fxX4q7sOg7OpYR0R9wgQhwVEEL3eCRHYEl0A0HTJI/iprcOpc2ZhXXQTuBtsxNo7
	e7sWFaVuLF+TUXToQO6nK9VIKyBZEw1Q7mtrTehOX1Vba/yN0XVyKtQUJ7mF2FLfnbbHO3cVUHn
	aO4J2Hx7fmYUuvv6yZi0rTxYU5CuJhOxKQF+0NCu3ixuv5Gde/z1yubfisTfvryRL2rBT7ja/li
	Z6PKTiZdIPYJ/MyHJoFZqwlE5b3bi40jBK1WgZskHTWwRUwLHUuUt/VctRsILS7vb5dWiecyG2F
	Oa1kaeUYXqdIAeWrNwE7CoE5+d4aQk8JaRl3tlsDBV3sZe/9ai9oCX7M+q+HK+mCVPSMzo2Y1Ct
	XtNKOn0Ba/7VrMlPSiRuNrJ0wt0TGzLaBdvVguDGzU+Vy2Ivg+g7wla+mmJ4LHUz3KGA/50a8Kl
	rut6+A2jee1h4=
X-Google-Smtp-Source: AGHT+IHRBhcmZTOAWCkmyvKGN/yIZEW3BGgNcWJLj8eAWLx29Gncqv2b/qbhRUayMjbaD/Ww+6ckVQ==
X-Received: by 2002:a05:6a21:3389:b0:366:1e11:11e6 with SMTP id adf61e73a8af0-3898f88920bmr2498991637.4.1767792146339;
        Wed, 07 Jan 2026 05:22:26 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7912sm52511685ad.67.2026.01.07.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:22:25 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: Fix memory access flags in helper
 prototypes
Date: Wed, 07 Jan 2026 21:21:41 +0800
Message-Id: <20260107-helper_proto-v2-0-4c562bcca5a8@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOVdXmkC/42NQQ6CMBREr2L+2pr2Ay268h6GGCi/0ARo0xKiI
 dzdysoFC5czk/dmhUjBUoTbaYVAi43WTSng+QS6r6eOmG1TBuRYCETOeho8hacPbnbMNJJkLkr
 MpYKE+EDGvnbdAxpvoEplb+Pswnu/WMQ+HdsWwThLrSTeXnPE9t6NtR0u2o1feYIkF1wdQcLUB
 WZGa/M/RFmpiJeohNY/ULVt2wfT8Z2dFwEAAA==
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
 b=kA0DAAoWjB93TexNMocByyZiAGleXgWghpdyHONMr/NpV7eozodgDA95HAb8EsuASP3dBahaG
 Yh1BAAWCgAdFiEEjfgx3alpNzO2PKDBjB93TexNMocFAmleXgUACgkQjB93TexNMoforwEAn1i+
 D08CVCAhApBR8MWrFoZWhJSQOkE1B/v9gIIQ+FsBAMLe3c6CqkH09nxBtAz7VkutkjMiFc4pH6a
 WK3ueEEIC
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


