Return-Path: <bpf+bounces-33464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832691D7CF
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 07:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4071F229A4
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A446741C85;
	Mon,  1 Jul 2024 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sq2ppaGG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246F23A0
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813560; cv=none; b=Oq9gUZL2ytoleLgte+RUTgcGqVflwWCaGdOg9ZXce3FDKpsh0v/IjLPYR15nroZ0DkEZSQcjoOG9JYRcCsp+T1LAB5hcx+6VJFSOpV5FCWqI0pGNBGoCzl7MSffRTTQhgNkLxpZ9rS1fZA9hoMRFhc5mO0Fr5Nl+zz8Ujgy1wyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813560; c=relaxed/simple;
	bh=ly2SjOsA7McENofGb5MLIveCLPctxXip49J0p5xWQH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkbOteRH6ZTTO4rJLa66wo/vh7eWxaTRAmq3nrJKKaXuGrHnloYJaGnr2VIrFyuryLC94HlGOqpIUV9XPJiFf9BhLhZFjQCbBceLOTV2Ih2E5u3bj5U3YKE8hKbVGYZIvOvkY5h3BMkBaEI66Anksig7RKTOFQLuoWxDi+iX19o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sq2ppaGG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36743abace4so2272261f8f.1
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719813556; x=1720418356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CnlR0K0GlTLEE7QoiTdvf2+QA+aby87qZzTZn/30bnc=;
        b=Sq2ppaGG9sJopabKNEZK7wrDY9vH3QmuvLUnVwubi4Wa2YD5kkFle07XRoiMOX7JlC
         9AQN9rW1cUtBTBtN57qQedQxunXrb7+HyNTtFMKMbKvuqgkBG2Q7dqTV96a8HRljLiYs
         D5wxuekTdCjfsSUYWj6VpurZNkJAN4CGilqDvk/Y0AS0W/vFM3cvnAQK93eDw1jAneUD
         nJS/dYmgozhyfGNhYE93Su8AaxUiXWmNMf+kQugjWGaBAU5MIK4mOZIoMV4Wb+C/sfda
         4PktLoG48Mab59cFzl/7T9nIDRhOphRSYihn1im1efNOB/ADdA3QHt0V4ai6xy3+SsU+
         waBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719813556; x=1720418356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnlR0K0GlTLEE7QoiTdvf2+QA+aby87qZzTZn/30bnc=;
        b=Xwk3HNwzu6Sj9WuPbDRpFUMAIQCIIb3DGpt+Zx8IebVsnvBgoXQqVZoUC6r67u3coY
         xsysAiQuL757c005J924LQOCHiCFrNrxv5wi0hPFv8pNp3A0JEduNPHEsoWmDuR9lyhE
         xJ7bEsm/Q5NdNheuVuovNJknKHhYxSL+PvHwwjmRqa3LaQAAqcPwYt/pkVwmnYYSiFnh
         Qyj9/7l3h7cJZgJtXaAUvfAS6XFFT/Vi6UMxwMhMGB0TnzeiENxb+137YRtbR9rOZ5uc
         m0fteczgha2qlX14id4U0Rl+FEeh+YbFuYgFT0hH3nILTYFfqNZO8At9cXAhktd0Q9s5
         WwPQ==
X-Gm-Message-State: AOJu0Yyz2tn7Om5ogZl7fBLgvQwZydpAEtk4fcWnORUMtiXSFgwctXyp
	eqEcAsT3OOIKRVWVmE3WAZfo5Mnx5D/rvIN1nnInUonNGa0NnTn+khXixw5Auokpwf3kBaJJ+yA
	u
X-Google-Smtp-Source: AGHT+IF4+KsEwGUxpCL/PxHs1nxtsU7psg/DwjkSKTpTFflQNgz8TL0niR6S5BYl/9ukYTQ30DPZbA==
X-Received: by 2002:a5d:6d8c:0:b0:363:337a:3e0 with SMTP id ffacd0b85a97d-36760a62ecemr8215328f8f.1.1719813555590;
        Sun, 30 Jun 2024 22:59:15 -0700 (PDT)
Received: from localhost ([2401:e180:8841:b02b:633f:bed8:da6:a3a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc5ffsm5864557a91.43.2024.06.30.22.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 22:59:15 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 0/2] Use overflow.h helpers to check for overflows
Date: Mon,  1 Jul 2024 13:59:03 +0800
Message-ID: <20240701055907.82481-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set refactors kernel/bpf/verifier.c to use type-agnostic,
generic overflow-check helpers defined in include/linux/overflow.h to
check for addition and subtraction overflow, and drop the
signed_*_overflows() helpers we currently have in kernel/bpf/verifier.c.
There should be no functional change in how the verifier works.

The main motivation is to make future refactoring[1] easier.

While check_mul_overflow() also exists and could potentially replace what
we have in scalar*_min_max_mul(), it does not help with refactoring and
would either change how the verifier works (e.g. lifting restriction on
umax<=U32_MAX and u32_max<=U16_MAX) or make the code slightly harder to
read, so it is left for future endeavour.

Changes from v1 <https://lore.kernel.org/r/20240623070324.12634-1-shung-hsi.yu@suse.com>:
- use pointers to values in dst_reg directly as the sum/diff pointer and
  remove the else branch (Jiri)
- change local variables to be dst_reg pointers instead of src_reg values
- include comparison of generated assembly before & after the change
  (Alexei)

1: https://github.com/kernel-patches/bpf/pull/7205/commits

Shung-Hsi Yu (2):
  bpf: use check_add_overflow() to check for addition overflows
  bpf: use check_sub_overflow() to check for subtraction overflows

 kernel/bpf/verifier.c | 151 ++++++++++++------------------------------
 1 file changed, 42 insertions(+), 109 deletions(-)

-- 
2.45.2


