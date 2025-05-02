Return-Path: <bpf+bounces-57214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D8EAA6F5F
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 12:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF13B1191
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B2023C4F1;
	Fri,  2 May 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="cVLsjI0q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581122A4F8
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181235; cv=none; b=ir9KvtnaqUNhAzKUy6WUwrFFCEkt0VRpZjKWvknF7DVEkRDb+TxGbBd/n6AcJ+vRHFsCTq0eQbFwmvmVNXE/DVuzk8Bdq7NntjJ35LGkYwWUq/0B7bSSxvllB7VLQuyLb0WB0fTqzhX7Mf439EczTGB0w299YDbIAOk4sLQI5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181235; c=relaxed/simple;
	bh=u1j0xmZoRnBzW8s0HMWnudNyoJzXBHt8pCUQz+ESzuk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AqbSKbYXdX4GXylaYW1RD2opAKrOjgQq2Zu4NwVEqfjlxBRkhUpjHMCpzGTXo/j0S4DckvDDuHwLAcCOQyg2mZtLU1XWkZCt70eb4GPzx3OZhNmy5I8k/qUgZ784vEcXaRPQwQi8u5WDWfMyLK4vAVyV4tY+f3eJJX778FihPaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=cVLsjI0q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso7191495e9.0
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746181232; x=1746786032; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMtJkZBjun5r4V6RProzP3wHroZCQ0IdrQUIPRbgJLs=;
        b=cVLsjI0qtP+1CG6fIYQI7nf+/8z1ksm0jh6cHrgQDevSISvnxTnJd6zfC881v/eAy6
         A3an4iff/tbOFa8T7kcHD1dBna7iFLpHV7hVWCR/srZ2M8nnLyiKrS9YPNWbwvnCkp1o
         keFOha6vUg/pdKSJ0VlHQ+N8IpYG6vx5F3VXVfs+tm31gVt+Jd0t9Z40BTg0CRxvjBvv
         MGNV7m6WFL2UAG1cy1/euExF4LFiNakJMqaTCgJ4fh7HcPUxhpJuAwctSbkOEeKApOPa
         9GgX1a/vNzWeAcG2D0tYKU/infQsqmjJ9lYFJ700M8eLIgTaqY42Tp+V8q4Q+Djp7fxE
         aFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181232; x=1746786032;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMtJkZBjun5r4V6RProzP3wHroZCQ0IdrQUIPRbgJLs=;
        b=ThaQqwnjj6n3XYhb7BCrhBvlcag9ouLu1OylyTIGOtmATpZqbMKTq/fTSlZSHCTGQU
         xfdYvc0bjyRxfECfcyxQ42UD5N6q65tOWrmT+X3/AJacndYY+qveZ7tqNn4LLKnXEoj+
         3R4lR9/5VoYUJ0p+iu/Tyds/8gPlAVfM0LYRtV4z8lHDQ2RH7xq0tSLYGz+BNKEq+04a
         mq2vA64Ymk+XgBw4LinF4J15q3rjtScZhQEtgqgr1czmTbKv2Oa1l/EAorYwuFmqXMct
         7H76LUl4wDCrZJun9amdfJK57cTMs/3XrzjzkTRChhXpdMNlS6c8vqz/8iE3cKlJm/LN
         K/2w==
X-Forwarded-Encrypted: i=1; AJvYcCWtC4q4SxUDGGgll1iKthKNNXiAigAh7h3nJQeN9RqYerZXrqaREb7DP5xRtEcyHXjbGkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4WCkkoQKyfq/nCy+kFlQfKfcQeQ1sp5M09/EL/BWf+jvGBMU
	e9/XKwBlmlw7bBlcrHKlkdVwPq2OrrT1JlPBr/laWuNZt53xcRAct9jed/5Q5M8=
X-Gm-Gg: ASbGncs+vk0Ju6TZbPzHu/dwQA93TYtX4TLY4j+tNX5Jq/qes3a8jM7aKxBnuvyNChI
	g2+BrNtFBjWkZLb1hinesG8F3rlFtg6VlPIFRBvEEYsYdVgwer+SjOJgtqbHEtkIbTSfvIlynhH
	jWehL09rSVBX9piqhpgeM9q8affze+ehWTwx0PIjDEf7l2XKrdlThwrOHOVw3Ko7hPIsY/YInrB
	jqCyRzGrHBfJoVxNvG7MsdGuf5DGJUtRdDZLnQexJDiE3GP4croNXeubuoYvq9T8KDYz4s+32tY
	x0pIss2w5K0B30af4/SXvjB6Cx6Sj81jzeVR+AOjb7dWUddNJ+jwpMWBjL0jdDA45WO73DR9fWq
	6G5f9UcnYwqDm29FTKHg6H8uNhYc07lpXMCw42ul81auC7xU=
X-Google-Smtp-Source: AGHT+IEHjhGDCWU2ZicYHzORmLl7fKou5XinJhHqakSMdG3W/Xr6HSBzfM+uhzSB/14vI2WwqXdL4A==
X-Received: by 2002:a05:600c:3ca5:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-441bbed4726mr17576305e9.14.1746181231995;
        Fri, 02 May 2025 03:20:31 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17017sm1742342f8f.92.2025.05.02.03.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 03:20:31 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v2 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Date: Fri, 02 May 2025 11:20:04 +0100
Message-Id: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFScFGgC/22Nyw6CMBBFf4XM2pp2sKKu/A/DotZBJqGPtNhgC
 P9uw9rlyck9d4VMiSnDrVkhUeHMwVfAQwN2NP5Ngl+VASVqqaUSxU3sP4twzkSBZLU+t7alQUG
 dxEQDL3vuAc84CE/LDH01I+c5pO/+U9Tu/yeLElIYgx2edIf6erlzDsVM5OejDQ76bdt+Da2w0
 LYAAAA=
X-Change-ID: 20250501-vmlinux-mmap-2ec5563c3ef1
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
With some upcoming changes the library is sitting at 5MiB for a parse.
Most of that memory is simply copying the BTF blob into user space.
By allowing vmlinux BTF to be mmapped read-only into user space I can
cut memory usage by about 75%.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Changes in v2:
- Use btf__new in selftest
- Avoid vm_iomap_memory in btf_vmlinux_mmap
- Add VM_DONTDUMP
- Add support to libbpf
- Link to v1: https://lore.kernel.org/r/20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com

---
Lorenz Bauer (3):
      btf: allow mmap of vmlinux btf
      selftests: bpf: add a test for mmapable vmlinux BTF
      libbpf: Use mmap to parse vmlinux BTF from sysfs

 include/asm-generic/vmlinux.lds.h                  |  3 +-
 kernel/bpf/sysfs_btf.c                             | 36 +++++++++-
 tools/lib/bpf/btf.c                                | 82 +++++++++++++++++++---
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 82 ++++++++++++++++++++++
 4 files changed, 189 insertions(+), 14 deletions(-)
---
base-commit: 38d976c32d85ef12dcd2b8a231196f7049548477
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


