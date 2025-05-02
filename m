Return-Path: <bpf+bounces-57216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B288AA6F68
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1EF1C0077D
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ABF2417DE;
	Fri,  2 May 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iFrMq2Kr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396C23C4E4
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181238; cv=none; b=cvh5g8UUrQVYrnNS9FPRP7Lm5FFZfTjJIUmWjrhT8e6ZHpNYdgWX5he6wrLgDlNlE1ykbCRxUknbnHnWgEftEdG29sSBVOFvkN1CSdI50aDQPQz/KFRJxCnA31k/nZ0wwCm8vEUsOk7mfPfvoaW3YgSXUMhNxIBINopT6LvcBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181238; c=relaxed/simple;
	bh=ychg/Ta4S8UTx4Xf2MItnvBeDG7XnCP0C93pzW0Ay8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgjdKYUIuRZf8M59V01g0x/CJc8EiqottcQv5vYesMSzBNBTslz5Wo7zMpfW4XA0/B3yLFqhOCslgyIqdAxurJkfBl1FHlrVUaP4nxCYSCQI9QA4ADYjKFATOEDgKPv+eUZI5AbIsNTaX45DLZOn4oia5/IX+DHCkaxxd1/CuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iFrMq2Kr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-440685d6afcso14531335e9.0
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746181234; x=1746786034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BATcMPOI1ZCFC5PD+E37IaicFbjrMSjSWMu+X6OAJY=;
        b=iFrMq2KrEzxnqYfZpYrSkDcrZmSXTm2R2EtCbbwmyYKFjKSIIsFU86nA4vmhJg6ZuN
         DvnbFMh03gM6vDLUU/Hmo/dk5sY4h3QaiDpLxQYREkUU5q4XMgP2SSaeathVg5CFyQhe
         avLEtw4z9At7ELVDylYmj2FmgylcgBbpFIxe3PYfv4BHUaggnYgEw//Dmb7Oy26hGvd8
         3vUVhp8UTwb+b/38pMJui3OOujpePmtCAXWne/Mf9FGfNca2qzWipt2HbaLAlnthB9tg
         al9xKIId2v4KV1OijFmaGFnsGNufdTC+8q/DRLEL4csL3IbuuJcUHDlwEyL/gLncbGsn
         j/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181234; x=1746786034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BATcMPOI1ZCFC5PD+E37IaicFbjrMSjSWMu+X6OAJY=;
        b=BdHZNYHM46nukRa9Ro8t0SxMowEVh366gSD/uKOaYNTCIXjZvKifK4eAkixZ5mdA4b
         ZJVJ15Jp8lzKMZ8rzJ7EEbOsYJD0RMl0rGn4VkfhGLGE+nLf+mp5q93uUNJv8wlvi/n+
         EhdrNSvV4xwkFWOyFSAlRimcYmymkvq33+9bxpFZIo0syhY/VtEtKBLzHYdHxglCJnmK
         jIna2/fhkDARottDE4HC+EbOmxSUvacbj1nsVwKTXV7bhx+AX5fjGqRIWTlB6TJ95UBW
         3yLoVj1cspfC10fyHqfoqcRhzTdLSh9l0nqOLm0y/tsc5cZPI+ZjUuUBs8FTd4nK+fb9
         JQow==
X-Forwarded-Encrypted: i=1; AJvYcCWLF78KeZzzvzyq6S4ejHq0ro+7hZLIkehlGgQQd0ZW1r3HlM9+1KUTwi/FtiuFUBvNu6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhraZDt6EydLB2ZxOABO7ClYqM4CEG9hc+ME4iMzWlkOP18Nf
	o8n2gUbX6kstoDE9kEyNpA4AGl6/mIJ00zsBclnUZzM00dsTxLwHfnwBktFb1qw=
X-Gm-Gg: ASbGnctafe11IgPVjm+SwMdqgicnokvDe1wUqyf4iitLlKz+vlH3c48OEkwqliUJPJz
	qIL7NryAKrSoLXaB7UlhRskb3z29xxZbFHeN7lQQAAkQswWCkm3WRlQSkgD7VjMgj8XE+33BLxR
	bQ7nR6iYtV+pgfZYm1fnoIv+6ohyeI4Z7IpCWwNzAKB6cBMQGT0ZlE9dBxILGLPbo9CswmkCY7c
	jCpOC5AIbA3n12gOviwSaPqOJClpKxw1mxFEyPucl992jSKDtd/54MSCPa/C3Ma11PXv4EOY15a
	72oQGZjy49cKA1quEdzfzIsQswDa1L4z3IrZ34+b6q8gWyYS7iEFGdvyTFloYTx2RCO93zVJUpN
	xwu2lCge7/XKVUc7XPecI7roQVEMi+dL5QaXS
X-Google-Smtp-Source: AGHT+IFUHkTtc0DcElXRacw231nP94ZA8KvkgC+j1gjYc5WSrObc75yVcLMxn3UnSEc1kGWDOkoudA==
X-Received: by 2002:a05:600c:1e88:b0:43c:fd72:f039 with SMTP id 5b1f17b1804b1-441bbeb3813mr16937805e9.11.1746181233840;
        Fri, 02 May 2025 03:20:33 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17017sm1742342f8f.92.2025.05.02.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 03:20:33 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 02 May 2025 11:20:06 +0100
Subject: [PATCH bpf-next v2 2/3] selftests: bpf: add a test for mmapable
 vmlinux BTF
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-vmlinux-mmap-v2-2-95c271434519@isovalent.com>
References: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
In-Reply-To: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
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

Add a basic test for the ability to mmap /sys/kernel/btf/vmlinux. Since
libbpf doesn't have an API to parse BTF from memory we do some basic
sanity checks ourselves.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..5c8095bedb0517930aabdecc17ca7043f80f3692
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright (c) 2025 Isovalent */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#define BTF_MAGIC 0xeB9F
+
+static const char *btf_path = "/sys/kernel/btf/vmlinux";
+
+void test_btf_sysfs(void)
+{
+	struct stat st;
+	__u64 btf_size;
+	void *raw_data = NULL;
+	int fd = -1;
+	size_t trailing;
+	long page_size;
+	struct btf *btf = NULL;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (!ASSERT_GE(page_size, 0, "get_page_size"))
+		goto cleanup;
+
+	if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
+		goto cleanup;
+
+	btf_size = st.st_size;
+	trailing = page_size - (btf_size % page_size) % page_size;
+
+	fd = open(btf_path, O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "open_btf"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_writable"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_shared"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size + trailing + 1, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_invalid_size"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_NEQ(raw_data, MAP_FAILED, "mmap_btf"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(mprotect(raw_data, btf_size, PROT_READ | PROT_WRITE), -1,
+	    "mprotect_writable"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(mprotect(raw_data, btf_size, PROT_READ | PROT_EXEC), -1,
+	    "mprotect_executable"))
+		goto cleanup;
+
+	/* Check padding is zeroed */
+	for (int i = 0; i < trailing; i++) {
+		if (((__u8 *)raw_data)[btf_size + i] != 0) {
+			PRINT_FAIL("tail of BTF is not zero at page offset %d\n", i);
+			goto cleanup;
+		}
+	}
+
+	btf = btf__new(raw_data, btf_size);
+	if (!ASSERT_NEQ(btf, NULL, "parse_btf"))
+		goto cleanup;
+
+cleanup:
+	if (raw_data && raw_data != MAP_FAILED)
+		munmap(raw_data, btf_size);
+	if (btf)
+		btf__free(btf);
+	if (fd >= 0)
+		close(fd);
+}

-- 
2.49.0


