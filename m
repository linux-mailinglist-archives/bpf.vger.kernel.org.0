Return-Path: <bpf+bounces-58553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6186ABD8AB
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916763AB2CF
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D522CBF4;
	Tue, 20 May 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="TGZjvB2L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11422AE6B
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746103; cv=none; b=tuGSoHa3H9pXoenkJ9XciAxvB63n2rm1J4ZOqqVZ6dcAH2L6c46lBbKgirhi8SMcXHe8EqGJxXP/O6buFGcGYh/QqC3DK/kmJ1CP+T4OQspDQOVNhzuQRQwfhml2ZQh+C3+zjVXqWuI+wXtBBMhWkh0HVqlm4p953XRoX/bDzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746103; c=relaxed/simple;
	bh=34t1ctJUizMtaGCXNLsBowJ2GwafQ+PDmebniuWuRcQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GLO1F3ToM2/GC/URXoSK8XHBP9mwc8Yo6QXqRaa4HQE1Oxpj6Rk49iQrvpGjrr4nQlwuadX0wwfrYvRnXVm6vNKiOkfgdGiOe3PgCKUpQPP32gn67XTqRo1wPdJahxkWAhXipcPTYcHF/yXrUO+uqm2rdR/bX+qkSjtZbZTWCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=TGZjvB2L; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0618746bso44614925e9.2
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1747746099; x=1748350899; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALq+75rbc0YSVKBhmMHZ9TQaUd2k8+MFk3atSFaxTp0=;
        b=TGZjvB2LUIMxlniUq3MZA6Edl0zDjL1J6kyLs/ObOnBQAsFDxB5SqtVCcnbMYlYnEH
         VeoMg6for0eX/4qDlK9fLds0uOa1KYniTYDNZQsxF7wimcjyyUS9hBC6mGBETv4QSJLq
         +f2unQzH5sq+nJNkVovJPtbqKLDXKfx/KLNKGrF6XizxgKHkr+ToC89tPAisGQmtluHB
         jLOMITRenRhStiuuH98P0FD+2bo6135lyFyU9qr/RN0MlcVPaAaF4GkIVUGNL/+DeSJp
         0TFK4myc/SEvIU5l4JL2EwA5WZmAbnBhmLVsjkHYAcxuscedzmff3bOgjxlZ8YgA/TmS
         nynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746099; x=1748350899;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALq+75rbc0YSVKBhmMHZ9TQaUd2k8+MFk3atSFaxTp0=;
        b=nbio9Cfh19NwHY2SbXpsPq/egaqnHddktyHVIdm9FHBPEx9QYAlnCMoNdrXiSiuHkQ
         5lX9s8oH7O5ZawI21+j24vgpi3Iu25HUN3i7K7eZsv0lrd7u6zWGOD0PbuKFwBBI46sK
         H4ktKyWwKhihMx87nWle/xY1jo6E9607qUTbqPBSUD8gFtvbCMUuIr7yfgmLBrswMur7
         CjU+4mli3NtZiWa2TF9nV/7DVLeMnDVqT35C3AHWxMrg+vb2AqjjH6EBkSNl1E4b2vSL
         lAGPJ2o41R7zWg5vCzbxD9U7kFQfcNcRYh1Ol0qvuEn8FcrD7EIZy2g1Wbk8Hjy8x+AH
         iYgw==
X-Forwarded-Encrypted: i=1; AJvYcCXe4dzqAdpiR6XR0WN563/hW92fde+NaNTlguQ1n54SmSjXXaWJX0WbR4GW0/jv77uzEJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTjepaUuZ5yQ/ILXNO8hKO856hWXgOUP2tLEDpgWGxrOrRg0v
	BntrkYhwVaEd457kkSo10z8NQ1WQugBasP8ZVjX6wjqdREGsce8u0NOr1XcHYpTxW38=
X-Gm-Gg: ASbGnctW9xgdOvZ7V9qnpn+tt6EkjXM8tfbo3z9re/Q6nQImKyVG5In1oUxwFijXy2G
	o+HjCdDyZVb5wGqdL1yJJv90C4Ln6bwgNbH2V0c7Kz4YiZKVnB6A8rIcA0ES4JpxM5Yd1d7Bwck
	cKR10x5tHq6fy5qf+eOEY8W/V0jvIrLj0rIIg6PAdGFQpjTMhDwwt7qH1Rz7Qqxohb6CGIFTOU8
	pA07Fcycp4GXXOc3mYEolINTjBp/zWTq/4OQjwLiWSN57JVz9CmEqmwYx5jNBgb/AHvPUAliua7
	UKR1KxGN8G9Ww1QyAOLnazYF0CHdUdW4ml2t8A+4eEwp1ioxmQvxWx64JgoVJGi1O4NkBrOBH4m
	Zz2csHXLEkUOsjGTrpst10udW5QzFXMp7lYy/pqEpNuv9hB0=
X-Google-Smtp-Source: AGHT+IFbIOxSLUg33BUpylzuKCK041iXvPKBjS+f2FA17A7KvsDTPjKnbUw6g/iuY+iBfbcHhkntQQ==
X-Received: by 2002:a05:600c:6296:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-442fefee254mr154045245e9.12.1747746099064;
        Tue, 20 May 2025 06:01:39 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a8cfsm16538095f8f.37.2025.05.20.06.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 06:01:38 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v5 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Date: Tue, 20 May 2025 14:01:16 +0100
Message-Id: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABx9LGgC/23OQQqDMBAF0KuUrJuSTDJau+o9ShcxjjWgUYwNF
 vHuDa5EXH4+8/4sLNDoKLDHZWEjRRdc71PA64XZxvgPcVelzEAAChSSx651/jvzrjMDB7KImbK
 KasnSyTBS7eaNe7FyqLmneWLv1DQuTP3423ai3PpzMkouuDGQg8YcsLg/XeijaclPN9t3GxZhD
 8ABgAQUaCGXWmmUxRmg9gAeAJUArFCZ2ohM0OkHegdIcQB0ArKCNOgSTJbDEVjX9Q9WJ3bweQE
 AAA==
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
 Lorenz Bauer <lmb@isovalent.com>, Alan Maguire <alan.maguire@oracle.com>
X-Mailer: b4 0.14.2

I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
With some upcoming changes the library is sitting at 5MiB for a parse.
Most of that memory is simply copying the BTF blob into user space.
By allowing vmlinux BTF to be mmapped read-only into user space I can
cut memory usage by about 75%.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Changes in v5:
- Fix error return of btf_parse_raw_mmap (Andrii)
- Link to v4: https://lore.kernel.org/r/20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com

Changes in v4:
- Go back to remap_pfn_range for aarch64 compat
- Dropped btf_new_no_copy (Andrii)
- Fixed nits in selftests (Andrii)
- Clearer error handling in the mmap handler (Andrii)
- Fixed build on s390
- Link to v3: https://lore.kernel.org/r/20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com

Changes in v3:
- Remove slightly confusing calculation of trailing (Alexei)
- Use vm_insert_page (Alexei)
- Simplified libbpf code
- Link to v2: https://lore.kernel.org/r/20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com

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
 kernel/bpf/sysfs_btf.c                             | 32 ++++++++
 tools/lib/bpf/btf.c                                | 89 +++++++++++++++++-----
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 81 ++++++++++++++++++++
 4 files changed, 186 insertions(+), 19 deletions(-)
---
base-commit: 7220eabff8cb4af3b93cd021aa853b9f5df2923f
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


