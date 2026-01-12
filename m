Return-Path: <bpf+bounces-78532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C118DD11FD2
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F053032FE5
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 10:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6BC2D0C8F;
	Mon, 12 Jan 2026 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ3cWvcB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976223ABAA
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214741; cv=none; b=Ku/wnGYjF4xT8kTaYE7k6293s+ozSwmjCzrUhWdvDmvv1QIbVAVXaFbIWZp1zmcLfH/1r1B+/RTsgc/8BRMQCZCoTKnSKI3kd8NEnElX76QyNQmBUBO7BWKP8oF2CFJUGOUZNKqlbmdm8qazJktcY1Rp1WuEIt67D86afHlZ5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214741; c=relaxed/simple;
	bh=INASmhtzEmwVMGdk8RicN5mY0Ypee1UrDkr+7SE2aB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Afk/peA7E/HoX5UqGCHS9QgmUc4R41Xt8oNv9N+QU/zzonvh6O2TpDJrwYl/aa61UDwboBgHpYS1xRRkXsx08WAeqGue3UzJ43I1x4fMZI5mJY5+haVAd69xvBGDJ1SKkgFBXljan86ldbbjYw/MXbS3c83ERWazAlrmser6J2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ3cWvcB; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a09757004cso57737715ad.3
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 02:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768214740; x=1768819540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4NGS4kiHrjFp20rjEHisCC7TTujHz3ZxAku6ynck/Y=;
        b=WZ3cWvcBx8XUWZY74V5AVEYExao3Du4SykLmiy3tDch8skf1buRYb8+w/fy6kkbQvq
         xvQu3HXz1JpdQMiG/Y38k+OIusmyEwl7wovNqOLsEKUi0pHSjHQaA7KLiS9KNCKwxLKl
         2ZeTZgUQW9Y9N1SIBlEyC779qqQeQBKSj/c7KR5flChHA1ULP2F85Zcg44sodPRFG7W/
         TvBNWi/OO/mkfY1ZB6MdW1osaIvT9+6Ov9nGQZ0gTN5kDMGzFhMBX8TCmhCjGgSPv7J9
         eLZBfZ2rx7+x0cHkauP2/uAPkdtZWfd87OVr6ktsEJz5kfOne5zWJT3e0cMHdErgKJ9H
         Uj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214740; x=1768819540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4NGS4kiHrjFp20rjEHisCC7TTujHz3ZxAku6ynck/Y=;
        b=sDVdV+tcdCqwNhb5sqWOUXZT1yRTfG1al/ypH06uxheJMHZME0Uy1PUGVJaCzatdCJ
         qRAX4r8v+4H8ROOAYaIc2T+glsjee6DfYavVsUTEkQgimfWaqmE4y7f77lFYVoZQuUwp
         s0jrl4Ua4n3FUmzBgXzlWTBChP5Gg1US+gj4bqHN6zRIJ0lyHntkhJBbFiIJZuCyGCuS
         nE/YU5CMWQtiwXQse3Sn01EDAmV2jDFUmbaDUp8l9/wRytrDI5Kkkwf53l+ZpqwqYUTK
         4NnVsv+g+kUz0dM/IhE6Hh5jgzW3G5drhTIvqkJOQMhN7CFBVAJTeneEU/BVJGriTZiv
         SDDg==
X-Forwarded-Encrypted: i=1; AJvYcCXMsmZqkIG4XnQUC3IOGC7g4T9zjLFOgJqJkhTJgyCoEu6WULuvTJTB7OGXg7PjvLYGYNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytvAIzzsYoXq3EQILjyQiq+d5jQWDenBBHdOPK/rij/UMeu1BW
	3kPBX7THin9wdagI2WHFzKg0WbZib/o5BvsV5JtzaPckxBmPwNKk9y8d
X-Gm-Gg: AY/fxX7azO4v1IU8a/HdAb0UqrdDU7fRdxcQWDuM0I4XnqH2EK8RGdxW+wYthlYdFry
	SwUOPUCF+E0H7p1DxNViwcs4ntXP11FbMkxmBlLyDvpj/S0NGkuZuyaW4X1P/amU53hHmAQ6HDU
	U1+qZIVDa2mAoiVg4FuhtwCcWkLHWp5v5QB012ssJFpiq0MCD01PxEgcJZCwWOH+no8hsZdjnE3
	bdwecq74vgwclZlwWx5ZokbWSAY5TdrZRogUv9kt+apog7Tm6Z5LCQSwoT6If66XDrrbaU9shyh
	3dThFyxOV/GqdPqpQ6tkxj4F4QJqq5vBfFPAyeXVjkbZBRnTjUYQd3Ojefr0e5mNLpIzTu8tcaf
	jPa0yQWxLYd3/VbptGAT5hLf2lWiDMNkUohpWomrfYITuNsnWRbNZph5bcIV2FsB8gxYY885ANU
	iieah81B0=
X-Google-Smtp-Source: AGHT+IH/WL0y3IhgBfnc+6kQkF0JmAPLODjU/sXe45iwLcJO86CdhbLsKtU6CWt0zAIQhp55TEC0oQ==
X-Received: by 2002:a17:902:e809:b0:299:e215:f61e with SMTP id d9443c01a7336-2a3ee48b1cbmr160810415ad.36.1768214739594;
        Mon, 12 Jan 2026 02:45:39 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2df6sm173551775ad.61.2026.01.12.02.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:45:39 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Mon, 12 Jan 2026 18:45:27 +0800
Message-ID: <20260112104529.224645-1-dongml2@chinatelecom.cn>
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

I'd prefer to the approach in V2. The code is still architecture
specific, and now we implement it in the verifier.c, which is a little
weird for me.

What's more, it need 3 instructions with BPF_MOV64_PERCPU_REG():
  mov rax, &current_task
  addq rax, gs:[this_cpu_off]
  movq rax, rax[0]
which is 1 instruction in V2:
  movq rax, gs:[current_task]

Maybe we can implement a BPF_LDX_MEM_PERCPU() instead:
  #define BPF_LDX_MEM_PERCPU(dst, size, variable)
and use it with:
  BPF_LDX_MEM_PERCPU(BPF_REG_0, BPF_DW, current_task)
which will generate the instruction:
  movq rax, gs:[current_task]

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

 kernel/bpf/verifier.c                         | 29 +++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 35 +++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

-- 
2.52.0


