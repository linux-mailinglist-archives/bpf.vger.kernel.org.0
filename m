Return-Path: <bpf+bounces-21035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2545846D0E
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 10:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402A21F2561F
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE855FF1C;
	Fri,  2 Feb 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bfsoeErL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BF77F16
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867779; cv=none; b=Ge9ml1yXiOdreRxGPUzSXkhoTNLwQT/DIo/FIFX/4K1Dz4U+6IXGeEkv6PgyfLjWV4rySUqJZHO7y85zRZGoibZ6gz/LhomcO+4xClECf1sLKrFcXqfdAfmxfWvMueSAwQO59PEIDETZ6Q3mRbYiZYYYgZtWmbuzmQKIBAiw7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867779; c=relaxed/simple;
	bh=1FiCRVQhPK/9XMkFYDyi/Le7Bhl9I3PL9BLn45Zd6J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A80nnEjAXk761jjyqo2DWMdObSGQH/XduVePsXlLQpUzuPzGFi6bCTXQ+BuaeXfzWPtgLGDPGbNYA1BODNe6sub5V0LapKiqD15Zhw4FYMsZ+nTk5HmmyEMuMoOC+/8Q/Ym+1m70qKmHNVqNIZY3dtRHraAjDWeL2YUOqPm+j9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bfsoeErL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a30f7c9574eso270804966b.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 01:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706867772; x=1707472572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Pnxme83LYnIF9RdC1Eb3R1QwG2loqZNJrQFwXrenMM=;
        b=bfsoeErLYewOLMKYz0tZ8xljXconTqEB/2Y3/zdKP0RtXV0QyRetBtkn2zUR+VdADR
         bJKUSi1IEoahXhEzlB2MVwAkcu0mhhTaYZTsd77QXniPg7+48Bxi57ewna5pNgkakLcs
         1aHV33rESydTSxmbAqmF0goderWxB72l+xuAU2jswmPDxRabzDGdmUdrRFTYaBz2gJ/L
         YvLIrcMVBPszDtgbwrvEE6kM3bZ2AHyL4n1MvUNYj1tmI38B0jB05Kj/2+bmk/MbAg3W
         EjaNbqGV1/9WZ5j9Sp+INj3i/WqJtumgAJPCyEtWqaqawyGeocUkGtyrGFgA8oRx7Glz
         n3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867772; x=1707472572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Pnxme83LYnIF9RdC1Eb3R1QwG2loqZNJrQFwXrenMM=;
        b=TagKl/SJV3rpt2FBtUc8FzguR59vz8Ka8/2rSAK/pbdKD3cSIbqhJ1c2YGq20jNbSE
         jXsNDDTEQ/TMd19bPcgZRkDqSrvZJOAhRDawzt4qxotqbNcee5kD7De2rgncxM3j0548
         KuwvOciWSVyu8hAdOYAyZf/rjIvnTS2DWm3I6NOpvdE7kvHyChgf5NOTGF3njnDtnQT7
         g8SZ9eJmcWXohdQB9wapWYoIW7G/XK1PVmmNsh7kVKB/62Z837mQyX6sYTDqWh2VPxAF
         LSYEldNZiemoJp4GCAoP//XovI1ruzELT5BjYnSwmPF7hdCjdtYpfQvRFSOTjwtimKuT
         Vdtg==
X-Gm-Message-State: AOJu0Yw3MtAMNdchcL9B5m1i5kkTaayn9s7AcH0Uqpbds/+ooXytz/+5
	uRjzJzzBDtY5H3E3BrxQr9FH/JZ3Jegp6l0M67DD6BAzUbrcCUOl6KRhrYEYa9cvtqrPBXUp1J7
	RX3louw==
X-Google-Smtp-Source: AGHT+IG8s8eLcWS4HWGIaE8/4LrNDvQpmBk+RVYciZvK6M1U+qQ1GGeK0XYJSoxOz8XzVi79ZdZKZw==
X-Received: by 2002:a17:907:784a:b0:a37:1e9b:3b4b with SMTP id lb10-20020a170907784a00b00a371e9b3b4bmr240217ejc.70.1706867771939;
        Fri, 02 Feb 2024 01:56:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX5NHZFuMiNmbVTZMKzJqtYJ5H10lKdIW8zb78ZCRlahABy4ECEJlKM0CGtfglz44hiY4E4VLx6Nd+1/wZ0o/iQPlmwYWpuIhat+rms96NHKi2J6ICHfRCq8ijjR/oJYMOep9OH/Xn7xry+WR7THv4zh2pnOsd/AMQMFSR6S4bZhjuQEwNA3LDabQaPFhrRri3v87+01h1TfIgBZNop6pnkQspjcD0y1eB5FCIpP475YPygatW4SXBLQojgR6zVq2wRz0r3r6BJvAgWsbGXOvXsLJE/oZV/7iRWBuJbPgGiabvzjatKGzYGerzK+s9QmofttIBUiLgFNIrz7vGZgR9Lr7QHrNxstGmjkXFYXYUFeLBc+Q7FqHPhBFjlpDi13csNwF0q2WgLqWnKvvJoH/1DgzGFMaVdnZkNzaE2ePhu
Received: from localhost (1-174-6-55.dynamic-ip.hinet.net. [1.174.6.55])
        by smtp.gmail.com with ESMTPSA id ss28-20020a170907c01c00b00a311ab95fbdsm706893ejc.63.2024.02.02.01.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:56:11 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: [PATCH bpf] selftests/bpf: trace_helpers.c: do not use poisoned type
Date: Fri,  2 Feb 2024 17:55:58 +0800
Message-ID: <20240202095559.12900-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit c698eaebdf47 ("selftests/bpf: trace_helpers.c: Optimize
kallsyms cache") trace_helpers.c now includes libbpf_internal.h, and
thus can no longer use the u32 type (among others) since they are poison
in libbpf_internal.h. Replace u32 with __u32 to fix the following error
when building trace_helpers.c on powerpc:

  error: attempt to use poisoned "u32"

Fixes: c698eaebdf47 ("selftests/bpf: trace_helpers.c: Optimize kallsyms cache")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Somehow this error only shows up when I'm building on ppc64le, but not
x86_64 and aarch64. But I didn't investigate further.
---
 tools/testing/selftests/bpf/trace_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 4faa898ff7fc..27fd7ed3e4b0 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -271,7 +271,7 @@ ssize_t get_uprobe_offset(const void *addr)
 	 * addi  r2,r2,XXXX
 	 */
 	{
-		const u32 *insn = (const u32 *)(uintptr_t)addr;
+		const __u32 *insn = (const __u32 *)(uintptr_t)addr;
 
 		if ((((*insn & OP_RT_RA_MASK) == ADDIS_R2_R12) ||
 		     ((*insn & OP_RT_RA_MASK) == LIS_R2)) &&

base-commit: 943b043aeecce9accb6d367af47791c633e95e4d
-- 
2.43.0


