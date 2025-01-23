Return-Path: <bpf+bounces-49585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3042A1A885
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301FC1881B64
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1E21638A;
	Thu, 23 Jan 2025 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkER53eY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D621638B;
	Thu, 23 Jan 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651968; cv=none; b=j70lo++rFpoFS8uOF1P4rD01NIB4CNMANbr4kYessmIWhxAHTTJdHI+tvZhbA0e1wwGUOqDjLL/uKlZRdqI8E31WWEE1xYnPwoO4l/dS4vRMM8Gi+vW3oZo9hZeakj8gFxZwwL9zz4UZ6105FkUPFK12PISq+z+J2gpcu7aWgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651968; c=relaxed/simple;
	bh=mA+mJ3mi7U7MaBJ2e8eOvpTBae6TTDkQcLJH6uMnwVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OnGanqLx5vGs689dahxTTLR1UA9fzHzV5mo0YhtAaZZRJyQOVsvbkE0Lry8bcCJwK8d+o+gXjg+8R6jG6KVvwKr7t6bf6gVYBqBtisbBTNdVRWjFAnKTX9AEn5YwrReKnb9eKlQWnxeTHutXBvFmsluBfbhJsrXb/pvsEcD8c+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkER53eY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2167141dfa1so22765735ad.1;
        Thu, 23 Jan 2025 09:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737651967; x=1738256767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee6/s1dz0eBpIOdllXaYw2eJ26q2sLNmUw5j+eAKmRQ=;
        b=YkER53eY60MDmMQOYTJEhDB/kvqimxw4k8YtxgvOH31IjJ1EHHXO4CIHiG1fAbMwJu
         X2zn/CzPsA712W8OWG7N5YnvD8FDJ0KG98OVUt//5HbzXavEhnMZVLM2XftXKtuZ39XM
         9f5AiPQPC9o8hR9K897npm8FDk8D4dUbpAJUlpozxfuv58s7v/ecS88kHYFQOW3eYHbw
         F5IJX+h7ffyzHhTk+Mm2NINx2pVQA/mcHo8aPLpTjirh5ExPDuBY2T9BOWpdv/11xePs
         EG755bjoQMmlH5JkVOSav2WsENaoifrq8kymPdyUGYKygH8MTLYBk8YJXKX4rGPz6gy4
         41sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737651967; x=1738256767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ee6/s1dz0eBpIOdllXaYw2eJ26q2sLNmUw5j+eAKmRQ=;
        b=TeB9x7VR/fzynBVvmPnfLdlEOwlCg/UFmPsHm78CMtdQj2uObmH3xTIKS5+voKnXh9
         OChuD3NmYQybjGcfn/z943GG7sIzS6nXxc0M7wfb8UMIv1tk9PS56OcmeBmkYg8IDJ6V
         uWv/G1ZNEEWA4UOI5TQGTgheYwarE/d0PQT6YKz/CxrRLOYBUDx15fsz4xl03lrewPJd
         4Ke4mxQ7RSAlYUIlC0NP+fKnMMkgsB5DPWbmmTjWF+bOkflK98yE/9cNHa6Ycn/3PvNR
         6DxmNp6kx7ML+ch6qVAwZzTllGMo0A9iM6mFgQ2SRop4C0J2UBq0ekcHufbOvRIgvl+7
         Lz+g==
X-Forwarded-Encrypted: i=1; AJvYcCXhA8pCDpnnGg2l0q+2CpV1viJk7xbjUbfimGjHz2Nzb6fAT8SpS8tJCFH6orzfvJtYZeyBTXJZ2psTpeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaObOusB9VZOylQ091pVbsOPDbFYI/U9/PYz4Ivv5TcoZ5V/9w
	dV5NZijtTmI9UFNshuQLVv7h/or2u0iPyLU8OhkwdctNBnGgKjdT
X-Gm-Gg: ASbGncsW6eVaBmVg35bGLSlAelYzrA0P685YJKeHJ6Liaq1n7iPXqNq7Ntwt9C0D57y
	S3BxhWr9kwTyDe+hwyYoOJBiqHC7yLqkP1OfBsc9eFVj7XNze86416YABYm4Hp4xL49Al6ZMqKt
	juSrpCBsc9A5GQgXPsZJTdPr15YwpJ+zlUg8Cj8+uAETCHddDZXQ3vF0s/C3Y2tkOkhh7KYzvLK
	umskqtC35MHg6x3oGyoINx3d58I4XPUPVx8amW1pAg4gBMdFyFI9Tk+M1HRZJqd2DTh1+dh43fU
	89Na2LnGKXzT4g==
X-Google-Smtp-Source: AGHT+IF6gzU0pjs1GkkjV2+HOe47qet7DIwvi6uW4xXflvKxwWjhsXsYEZD6h7iwd86maU25N8kpaw==
X-Received: by 2002:a17:902:f641:b0:216:3440:3d21 with SMTP id d9443c01a7336-21da4ace666mr1306985ad.26.1737651965073;
        Thu, 23 Jan 2025 09:06:05 -0800 (PST)
Received: from localhost ([117.147.90.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141c7bsm1244455ad.115.2025.01.23.09.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:06:04 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
Date: Fri, 24 Jan 2025 01:05:55 +0800
Message-Id: <20250123170555.291896-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123170555.291896-1-chen.dylane@gmail.com>
References: <20250123170555.291896-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for prog_kfunc feature probing.
 ./test_progs -t libbpf_probe_kfuncs
 #153     libbpf_probe_kfuncs:OK
 Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 4ed46ed58a7b..d9d69941f694 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -126,3 +126,38 @@ void test_libbpf_probe_helpers(void)
 		ASSERT_EQ(res, d->supported, buf);
 	}
 }
+
+void test_libbpf_probe_kfuncs(void)
+{
+	int ret, kfunc_id;
+	char *kfunc = "bpf_cpumask_create";
+	struct btf *btf;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		return;
+
+	kfunc_id = btf__find_by_name_kind(btf, kfunc, BTF_KIND_FUNC);
+	if (!ASSERT_GT(kfunc_id, 0, kfunc))
+		goto cleanup;
+
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 0, NULL);
+	ASSERT_EQ(ret, 1, kfunc);
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, 0, NULL);
+	ASSERT_EQ(ret, 0, kfunc);
+
+	/* invalid kfunc id */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, -1, 0, NULL);
+	ASSERT_EQ(ret, 0, "invalid kfunc id:-1");
+
+	/* invalid prog type */
+	ret = libbpf_probe_bpf_kfunc(100000, kfunc_id, 0, NULL);
+	if (!ASSERT_LE(ret, 0, "invalid prog type:100000"))
+		goto cleanup;
+
+cleanup:
+	btf__free(btf);
+}
-- 
2.43.0


