Return-Path: <bpf+bounces-49671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB5A1B812
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421B9188CF08
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA3F152E0C;
	Fri, 24 Jan 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsywawv6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665113E02D;
	Fri, 24 Jan 2025 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729897; cv=none; b=PF5ORb3m1znEVJa5v44FjOEzLS0WDEGeKXvWNd+R8qFQD2rHRN4Y0V+NWf7nm7IbCv4V86sIpoJQN6WKSqpmKJmO8FC6aR7oVITSRHCOFUuUe3M38G3R3zE24WM4LZVm901O3T3xCSacDNVwKXm1SO3Tyyafg3IuMJXkhK+tU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729897; c=relaxed/simple;
	bh=mA+mJ3mi7U7MaBJ2e8eOvpTBae6TTDkQcLJH6uMnwVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iX15mmoVH3A5FzICnkra3B7jBRUl7RCPThy10F1u+jaChI7qPO4vjah80WWzPBZKzWPGtHwxLPeLS8IxXr5+QeQickdgzZc9Jc8w4uvT/pxu1JlsS56OJqRO5KLBEtTflkKdJWpTJufUJhXaw9N+G5/jE3pOjqUTKgCmc7vSMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsywawv6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2167141dfa1so40693345ad.1;
        Fri, 24 Jan 2025 06:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737729895; x=1738334695; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ee6/s1dz0eBpIOdllXaYw2eJ26q2sLNmUw5j+eAKmRQ=;
        b=bsywawv6OLTPl46v1N6l+8evgWFSkUSYT48ciDuu2cLqpY3NIKiVwxMye2OA2RbO9o
         OpbLSrCda8+AnQt9pwQUvYXLxHhPeh01xI/MkLIBfr4biyEU7idR2bYoi2aP/fBdmxsO
         A795C9S5KgIDMzLO4DmgLihwazUDBO2ozKGaC2xJqFBYSj+fw/HvkE4DSD5+61JR/sL9
         BsfJJRfdkVCXTXUPv2f3KQTVDEosJvekSIzZllZ1WoEhrLetG9pQjZ7yGjH9Va+1irUR
         tDXSY0yZX9HdM4wtRAYPKUSDVzYQngl3wTBSYG/vpyY7fV7N6eEXhn31VJ1MWI8uydMJ
         mRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737729895; x=1738334695;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ee6/s1dz0eBpIOdllXaYw2eJ26q2sLNmUw5j+eAKmRQ=;
        b=nvLVyQnXw07zf7RTpdX/edCSpiLZwWOLAbj18laPLHmWxvSy1iWFpIrXc9ZripgBMk
         NZhPabRkq8J2JyjYwISyB9nx7mtVCPCsdCovh80YbPzgpPOu/h8msrI8KCti4bSVCPye
         vuWLePS0f926DuZP7HHsjdkbU93kTI9Y7TsISw9n7k70UJ0AgmTTBTrZKHJmmA+kWP7b
         /3X2YScz5ofjpAU2j06dr06XbL7m0En4ZGg1JcBaPXgpObbjtxOzPUfIp+VsvG2RCH9A
         qv55+ckS1R0i9iMBwd0LKXSfQo9xzluq/tfOuwxR+0gtDUf5VLOIYVQUXajJmOrClgzQ
         8dow==
X-Forwarded-Encrypted: i=1; AJvYcCX2b0OYtvS9bFuirDuvBr81Ku6Jr3pUTWbAUFdjPLjiJ135n8gGA35MfIHfgBSJKCvn95lJrXy5OXGteqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RoTh6Hx/2qvQeSH0DWPr8bD56NDsHCMvg8D0YRHtjhB8sXKK
	gUUO6/5upmUXY5rqO0seRdFcINqiKPN3Pyvq01FpwYKUAQTzMETRlC1gkQ==
X-Gm-Gg: ASbGncs1WOsumGNeSHgHA8zTti1i37QyyoTu3w+Yk42GGlCIxGO06ssPIIkEisgwtjc
	G379cv+Vc2ADJjn7X+8n7X/25J+BGAHFP1KoPdDz3aum+MYP1HkkoGyqSU0729BhTkOpP2NQO6S
	HcM/GEVNOqxqPLA305/t6ASYk+jt0XDS/51k1dwecuIS2kRdgRYBzw3sEJmViNwHkqiJTV54hwD
	UywP/g13PsSOY141h+31FEkxtJDUR0+3vadWBdGcchW6CkIfmTCxhRU+r3SWalYq62z2Mapp6S8
	5DWPT9GciUK7k+gb
X-Google-Smtp-Source: AGHT+IH+i5jAJ/35LDWNtXq0uPzLgLIWCnWOwGJ8aR6m5MTuRVT1Unz5NY7NLNA7hiuaeCLuIK+F+A==
X-Received: by 2002:a17:902:db0d:b0:216:1079:82bb with SMTP id d9443c01a7336-21da4a9d43bmr61970975ad.19.1737729895336;
        Fri, 24 Jan 2025 06:44:55 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414d905sm17054255ad.180.2025.01.24.06.44.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2025 06:44:54 -0800 (PST)
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
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
Date: Fri, 24 Jan 2025 22:44:11 +0800
Message-Id: <20250124144411.13468-4-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250124144411.13468-1-chen.dylane@gmail.com>
References: <20250124144411.13468-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

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


