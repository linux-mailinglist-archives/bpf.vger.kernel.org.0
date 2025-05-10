Return-Path: <bpf+bounces-57971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990DAB23C5
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 14:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70A04A7F74
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EDD257AFF;
	Sat, 10 May 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="UPNfGyDJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EC233D91
	for <bpf@vger.kernel.org>; Sat, 10 May 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880514; cv=none; b=p4BoleCugxswWWEIwGKvonpLLLJjqZpqCM5PdeX+iylfOgQCj/bTEUO9AA4Tq1fRD/KfyisZovJlnOx8SBDdGtdYwpiNAYQEeAUwmnc7n2aQ2XZ6lvLJJffegBJmSX4OiUkIU8Sz/2yg9L2ZgbvMh2gv+3zXL1dDog+fnS6KDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880514; c=relaxed/simple;
	bh=/ckQmMjYXPc0qzguSPFnO/DSHuOJdODbmEv9P7rc2OY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SbPAdY5+mQzRvC67xNwBimnybzJOr4Awzlcz3QWpX2nFiiV1BCpDsyifk01DxtnEgk5HgqdBBdfYfAFmepSA2c30i3m1YruumqSXXHC50nueJ2Ae7SS2jrBKI5+ky8HTqFl+Fn0P3UcnLc7rKb7R/apFlQZIbPd1eU1bc+KiAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=UPNfGyDJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f2b04a6169so35626106d6.1
        for <bpf@vger.kernel.org>; Sat, 10 May 2025 05:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746880511; x=1747485311; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvudCl1s3CkH612+A5JcVTVNc6EQKQEW50vE6gNIcf0=;
        b=UPNfGyDJZum5T92EIlTtyK+OdXkq+lcbL0uJ/YF0UyVkf2s7vu/LMEzaFFhy+0TooD
         KYnxt1q0/uP+0y8mg4uvdu67/cPavgnUbUoqBwSn6syNmHbOoBgqg0xL6AN61Kcuzw0F
         sd56vPtgBrDWz1ghv+DCCi5Db1XI2s4Vr82LnOVzsRv3fancz0JpgZ3s3X2za0GGg6hi
         UxNZH9cTO1mS4A7rVvXVO9HFtRRktjJB2hSloOq3mQC1b639d83OMy2e6YEAHh6nWgwH
         Pp6Rf/AtP0jjoLOsis1P4VKs4F7vmtr+4W4ZkwtwHj7XHXhTcfGu6czdJOJXy3aAWvFT
         w1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746880511; x=1747485311;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvudCl1s3CkH612+A5JcVTVNc6EQKQEW50vE6gNIcf0=;
        b=UisSZid9NcMk7rV/lu8uyhHtBy51Nnrx2zK4xFaJj/0oE7zAG4Ss+zh1553vz7v6wd
         LVMo4b+Q5XvkYtjpGMO+gluq5pohNqZ/juQLE43a3yXOTuE7LAUfvfVr9fsALg1Ii0eE
         TC+hjcNqB3DWcLBplnd9n/o/BXjFl20cCIe5X+qVU4SUbBjq/HOK1gCk3WeT97KgdU3D
         btEkhRkbb9n5/MIot7zC/4iDeqFLs13RRV0A9qQIbW9DDCt3PNw/CpDusPN5dLd1xQiJ
         M0ylUbYN1PQblensMQJUHDC2KS9xR3NszdRPcq2Veu0TUxSA4RrSKynotL8AqnSQE2si
         koeA==
X-Forwarded-Encrypted: i=1; AJvYcCUyILkayx+eR3+9F9opTHK5wGENv6EKG6I8yPcnI/gwlMieQXeB+1M3xcZ3TqksbQDNFGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZr7i4NjWQGWp5j0kal9SqZGxTtUhTcYDdnj0rtpNf1qI2n+8L
	CCOLDVkekMnBPoBqQHb3mWfz7y8yAOBRSSc/FWYtWL5kpHtRT8h9p0m69NFTC9c=
X-Gm-Gg: ASbGncsdzpiMBppxEbJPfqVQB1gLMgmjy0sPssisgxZhogP6YayZPfG7AUddRtJi8gG
	LcMNzuIZKTkw1o/hvJD+zVal3520oNGFhcPSVNovwLAqEGgbiHde5DcJgZG18mZS8l25FIgBrt/
	/27QCYw7Wus9Qe0aWDWMRfDc9b6rxkH8OL9P9QxyXF2WUijqzUTrrus/FMBmMHpTatjkiuoXVqQ
	q6MTtzJc8WwU6VTZk5gZ1en0TGHxtEJEmoAH2TVQjK4Dj7xC5urUvst6CU3uxxPzqwgyZW/bjd6
	zTvnPdKFWd+xKTK1I0R0Eb7DlnVjLDfnhQPyMCStSsR4Y057y0us09xutInwfHWyAq9TamYgxuY
	lXAdkeW0=
X-Google-Smtp-Source: AGHT+IGV3CkDLoaVZ5BDOeHt3RqBddq11DlW+JHa+EzdYifXCxWkWda7wfe6HMzsvO+ohUEdlIZpIA==
X-Received: by 2002:a05:6214:c64:b0:6ea:d033:2855 with SMTP id 6a1803df08f44-6f6e47cb39fmr99649916d6.26.1746880510957;
        Sat, 10 May 2025 05:35:10 -0700 (PDT)
Received: from [192.168.1.45] (ool-182edad1.dyn.optonline.net. [24.46.218.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39f588asm25725556d6.49.2025.05.10.05.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 05:35:10 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next v4 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Date: Sat, 10 May 2025 08:34:53 -0400
Message-Id: <20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO1HH2gC/23OQQ6CMBAF0KuYrq1ppwyIK+9hXNQySBNoCcUGQ
 7i7DSuCLH9+5v2ZWaDBUmC308wGijZY71LIzidmGu3exG2VMgMBKFBIHrvWus/Eu073HMgg5so
 oqiVLJ/1AtZ1W7sFefc0dTSN7pqaxYfTDd92Jcu2PySi54FpDARkWgOX1boOPuiU3XozvVizCF
 oAdAAko0UAhM5WhLI8AtQVwB6gEYIVK11rkgv4+WJblB/OdXWE4AQAA
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
 tools/lib/bpf/btf.c                                | 85 ++++++++++++++++++----
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 81 +++++++++++++++++++++
 4 files changed, 184 insertions(+), 17 deletions(-)
---
base-commit: 7220eabff8cb4af3b93cd021aa853b9f5df2923f
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


