Return-Path: <bpf+bounces-78837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3545AD1C51A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 05:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF5A0302E3CF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C01C84B8;
	Wed, 14 Jan 2026 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoYhAtxO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5404A23
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768363271; cv=none; b=aXi/nts2zKXyK76hHijfHUH/VjAXznyvPL/AnIuqiJ/+ASqrq3GgmCSkHLRkpj+BPYlQYfRHgIHf8xUiWamTNRkMgHihVfvTB09sWYd4EF7nN+vtUsJxI5SWJBABZr4JOxbDEAUNxskOCd8bg3HDxbu4SxVBF2IhmlUBtwbcr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768363271; c=relaxed/simple;
	bh=g3ttzySCpadhRihhOHOSG7r8/H5jbizgJ+zbI4SvFrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BwSeFvqmc4ALi5DbPKTHNrVaEegrOFmhHxY2Ihp7Su/LpumPPVKlC7Srq4RZdEhqx6dBnM10tbdw5bKTVw8afyTmnGpz8x3WvP81E95ujrzWLSUKGoTAAmQjMKK7rl8W3RhL8obEX4X5c2wGKPZQ2jVAdLyQ+lm5tatmUgrXfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoYhAtxO; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9413e5ee53eso5172046241.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 20:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768363269; x=1768968069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OqvlnKm4qKjRisLmwMXjojWSI5sL/ME1vVLL5S7zzvw=;
        b=DoYhAtxOP6wCEcmZ/t21QQ424oOP6PlD+X8Y+QSuKDIobnoF23t0OSlBHkc1m+XlM+
         XMnBWhwwc8YWoHjZ64RN6T0+2ZzKVcTGUre/Y0Tz9aJ3HfYtU91E+VBwI33yBs612/H8
         Vaw3OFw7x5SH/kTV0Eh0UJ45tqIOJUOLkFPww4PXasalz2BmCec91i8jsbIFIRjQrAwq
         D/3ltSPHaJAKNqpGcvrA93RUvRCDnkiEDh0IShwKGk67W37gVjWkilKTZjw77rNWcJ/U
         QLx0GfBkqlLHhk0CpUk/E5KrrMisAHBG/Esxz/9C8+kTgYQS5snS5O5YSyZ6tWQftzN5
         GDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768363269; x=1768968069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqvlnKm4qKjRisLmwMXjojWSI5sL/ME1vVLL5S7zzvw=;
        b=AGAgIw61jctPcpKfjt4VxjDsjF8VCG8766wA8zH/GE2LiZcHb8vUk/FN5FtDaeywa2
         bTQCLNuGz8uP3bw+4xAAKYQeTEyC7nlAoMKeleAyYKkvYu5iPH9x8DiT7/BI/JbMHIPV
         35ntS+1ZPv1SlXKnnYgui77ZtyRfZBwFqgDBLx2Uh6qiU+DtS41JufjXSJZ+IQ3Lgkkh
         H5dycLfSE9DpoJ21knkExhWAF5pZGSNVEwnJr3kOAawkRJPG12PTrExaHJ7S+YgjY1bs
         1Gz0XsY1GEAIfHfzeZFwqKJvKF7QnsT9jrW7mSQNY7kRO6wWkBZVz1ENBcNDhbDlja0e
         R7ZQ==
X-Gm-Message-State: AOJu0Yw2RN7oypD/S05rUb0HEb6Uv0z86VeSr8wvfTpy9e+BDCakQ+1R
	KcNsp1X3rn/HFtExKhiKrwV+SPh9QjmhiP/C3wfV0HZYp+D1wkPe4ey3PoMbzA==
X-Gm-Gg: AY/fxX5+1CVCRgKHVshvc0emAjNAJNp7TxCNw5wj6N4RcfkW88XGB3SpSM3dCN/BeE8
	kO+qAJe06ZJnSimWqJ9yzBlXAoB7IaaWytI4mQM7Ib30JDcJX0VAVeHUj55DstPqZq8NBbxdQUb
	eyZEvUOpfQrBLNUS0QAiVmPVWD/ZTQVGZncG+Uw9xlwEc72cQRqNmJ7y50v7BmyWoQSSY7JTWtY
	mHVKVuHKV8NnKyZOys6BhnBeooQrsA0ug3ri8I8WnWGVrcbzizBQQE0FApl7ICzNstwhfrKE66s
	U2NcErXD3EbIINJrzAdqTw8834MoLYJb4NWR0+sT5ePfXmDgE5TIHtMsxEzyFAIN3BxqxnT4Mqd
	pP3Dtqih0ORn20Po4QY+wWScRnRxN7sT1+fJ6Mm9ka2hdhzz9jzConjh4IEKb0+B7PHBnZBmCge
	V2MbBYnAbaC4SPhBizc/xmyKylDlHLX9epr3lIFoetOSlrY4A38Pn/Pudx+uzy
X-Received: by 2002:a05:6a00:8c05:b0:81b:8990:be32 with SMTP id d2e1a72fcca58-81f81bb5f3emr876966b3a.0.1768357165095;
        Tue, 13 Jan 2026 18:19:25 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de6405sm21666323b3a.61.2026.01.13.18.19.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 18:19:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.19-rc6
Date: Tue, 13 Jan 2026 18:19:22 -0800
Message-ID: <20260114021922.47032-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit f0b9d8eb98dfee8d00419aa07543bdc2c1a44fb1:

  Merge tag 'nfsd-6.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux (2026-01-06 09:12:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to ec69daabe45256f98ac86c651b8ad1b2574489a7:

  bpf: Fix reference count leak in bpf_prog_test_run_xdp() (2026-01-12 16:37:40 -0800)

----------------------------------------------------------------
- Fix incorrect usage of BPF_TRAMP_F_ORIG_STACK in riscv JIT (Menglong Dong)

- Fix reference count leak in bpf_prog_test_run_xdp() (Tetsuo Handa)

- Fix metadata size check in bpf_test_run() (Toke Høiland-Jørgensen)

- Check that BPF insn array is not allowed as a map for
  const strings (Deepanshu Kartikey)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Deepanshu Kartikey (1):
      bpf: Reject BPF_MAP_TYPE_INSN_ARRAY in check_reg_const_str()

Menglong Dong (1):
      riscv, bpf: Fix incorrect usage of BPF_TRAMP_F_ORIG_STACK

Tetsuo Handa (1):
      bpf: Fix reference count leak in bpf_prog_test_run_xdp()

Toke Høiland-Jørgensen (2):
      bpf, test_run: Subtract size of xdp_frame from allowed metadata size
      selftests/bpf: Update xdp_context_test_run test to check maximum metadata size

 arch/riscv/net/bpf_jit_comp64.c                    |  6 ++----
 kernel/bpf/verifier.c                              |  5 +++++
 net/bpf/test_run.c                                 | 25 +++++++++++++++-------
 .../bpf/prog_tests/xdp_context_test_run.c          | 14 +++++++++---
 4 files changed, 35 insertions(+), 15 deletions(-)

