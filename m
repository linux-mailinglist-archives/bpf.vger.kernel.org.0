Return-Path: <bpf+bounces-23106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158486DA41
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 04:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D381C20FCF
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 03:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2105D4D5A1;
	Fri,  1 Mar 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhXYDJRR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B604F88B
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264266; cv=none; b=NhgLFOiCKjP63Ob0tya9MV+DlftOVs8XT4hS5jqVqUZvE4i3eRIOoiczMyz9bXkaJVqrlDl0zw5+Z662DRDlUR3Sb9uTLkUauTW9+VQHywIeQPYW88NzVcWK1umDHniAvPTwZlYVR33l8bMR2ATbQ/rusenKdNAMmbmblOvu6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264266; c=relaxed/simple;
	bh=7SUEifGiJj5drx/qwSKMtxxXBVnMDMpjhSxfidNDIoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7e4T/7bbDT6UxXj8EVa7tkOTUPf/L17Qy+6xyEjPVL9CU0YzeSUzCgFr0B944zM63yIlCpjV3pYTGrzfD1g7NHVGPC8xf+mcC1sHTXFcaJOxfcrjcSjLe8FZhKCLSaqRC0ltrK3W+ghFVeFZPzxBBx1WVDwKYiByiGYqyr4giY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhXYDJRR; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a0cf64bafbso871486eaf.2
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 19:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709264260; x=1709869060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOdHzLAa9wvOFeGaARhaTF2NVArAhkPD7JquazGvTnw=;
        b=hhXYDJRRLLTehtI4rOjhhS+lOn1TWHk3d0u0yixBom7bvYST+SxV1JwjbSgSiDDWjo
         UWT9a5eVNFaMnqn4Hv9T8jhewNF8OT57I6PbLnH41+TPgmKQAPGgWWcuY8B86f3f7VzN
         O+HOYLE+xcD3+zshIclujN7Nf6iyN8jmK5oqeV5zn2sSXVlUugacHOovgym2FhTUNLbS
         Wp2cOPPJBQTYX6jRWTU8acJJGE7dlbSX6WIk8zo4DUaHchqIPMGRoV5YigtmdKGbR4lN
         m+Og9408r4jp3KnhfvelW4tWhW6BkmdCkWMHP2jdyO5L8FsUMFP5lp3qYQ28PIYRkJQy
         Svbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264260; x=1709869060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOdHzLAa9wvOFeGaARhaTF2NVArAhkPD7JquazGvTnw=;
        b=TaDdIzgmRV2tiRbYp0ygen6izPN27JePjD12Xvd4mlBaqaz4NPmjCsKIfk2oFPyhTW
         makIP6ZkQLV4i5x+8mLKJOV3gKHC9IMLnXd3+XserFsAckbyC5mT31D4ay+MHN5Ybbjq
         RY9UaWC6sbMyMliif9zKz1010peRA48H/iic/QmyQeqsFiMmQpM680zn8VjPmXWmvDS6
         YBPexp6/t2Qt2OnzNEfq2oS3Oro7+ic6dYsGONyLAuhKn8+FCMpXnKFCQBqZ9J24GTQb
         V1eNWL6lLmIquVZ70ov83ZijW4FWftzrU822zig1tbDIvxoJMyJZJy+53u407w/C4XkV
         Asaw==
X-Gm-Message-State: AOJu0Yx8RbYuKoRJ/jeSE+i4Tha3mDtw+znAD/WwHU6Qh0Ee5m2RE+Hm
	W+3TM9X97lwCMJkt5AIaoFB+IYY78uSMM41PiPt3jlZmBDdYe9v1SSSdw3Qr
X-Google-Smtp-Source: AGHT+IEFrEwvEZIGIJdS39w9LLCZzAHZQS9cTF7TobQkxaQDInz3azgTn85Sa+T+cknTUzlsipvEaA==
X-Received: by 2002:a05:6358:5923:b0:17b:5a95:9902 with SMTP id g35-20020a056358592300b0017b5a959902mr505869rwf.2.1709264259583;
        Thu, 29 Feb 2024 19:37:39 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id 15-20020a63184f000000b005c662e103a1sm2064552pgy.41.2024.02.29.19.37.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 19:37:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 0/4] bpf: Introduce may_goto and cond_break
Date: Thu, 29 Feb 2024 19:37:30 -0800
Message-Id: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v2 -> v3: Major change
- drop bpf_can_loop() kfunc and introduce may_goto instruction instead
  kfunc is a function call while may_goto doesn't consume any registers
  and LLVM can produce much better code due to less register pressure.
- instead of counting from zero to BPF_MAX_LOOPS start from it instead
  and break out of the loop when count reaches zero
- use may_goto instruction in cond_break macro
- recognize that 'exact' state comparison doesn't need to be truly exact.
  regsafe() should ignore precision and liveness marks, but range_within
  logic is safe to use while evaluating open coded iterators.

Alexei Starovoitov (4):
  bpf: Introduce may_goto instruction
  bpf: Recognize that two registers are safe when their ranges match
  bpf: Add cond_break macro
  selftests/bpf: Test may_goto

 include/linux/bpf_verifier.h                  |   2 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/core.c                             |   1 +
 kernel/bpf/disasm.c                           |   3 +
 kernel/bpf/verifier.c                         | 269 +++++++++++++-----
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../testing/selftests/bpf/bpf_experimental.h  |  12 +
 .../bpf/progs/verifier_iterating_callbacks.c  |  72 ++++-
 9 files changed, 291 insertions(+), 71 deletions(-)

-- 
2.34.1


