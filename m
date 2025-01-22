Return-Path: <bpf+bounces-49497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BD7A19743
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEAD188A11B
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381B2153C9;
	Wed, 22 Jan 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWbi/EPH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62521519C;
	Wed, 22 Jan 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566057; cv=none; b=X68buiL/yLrxBt6+3Ze9ye7NSS49RGG3/xaQZlNFdVEXSadlBKJrhcEzjRct/TJtGutVtv7aP/Ygwj8YsqqiO0DzlV3cLteU0ZOQ7jIvy5G6ebPVElmy47999t7wjz8rw/x2du75lBngdCIQTMoWs34mLT1ye98lMhiz027VYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566057; c=relaxed/simple;
	bh=/soEHN2xtVU1gtwSpLHJpj49L3qPGrxuc0AMAZvmUNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3cJPV0iM3tpjfySoSo/dnTbU+oEJoeQmRbDWHGwWLB6HFIviNYs0cZ+abUdr1fV+8Hpg3BICXYEt5HZBBlRXscri0XVZYGr4ut7zZlSlJkITkKH7H0T7ASgxvsxkCSQ2KwHevUdomQEycR8qR/ExlrbxU0ts6xMNpgyqa76SVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWbi/EPH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21670dce0a7so150147985ad.1;
        Wed, 22 Jan 2025 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737566055; x=1738170855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE070qqGZGw6mDAzzE1IWQug1apufvChvMUY0TYHWLU=;
        b=eWbi/EPHuS8CInm65PGSO8C1MGk+u6CE845Im4sG9Yoc/vXiQewcPC7gysNU1v3eyc
         +fpecWBFmNtbJ1IYfR5bm/xFumq2CEQMolGrF6kG8VCMeypvvLiQkhtoJgObmO2RR4EI
         ZCZdcWvvxq6ua3yjuMqOSY6YXNi4iiFjUzxVd1hAtMv7eWiEPHcZEUq9f3dluz6SJHsf
         sME9VO7b42MDijaIlhSw8AwY+JuFp/AbWn+YY3hTlolsDVhYEwJJYrNwFySZPwHy6UcA
         e1CnT9ev9uJdh4RwC2NktAnhInqbH3x81SoC6YGR1abWVCxIpfsgOjrnehVvde1vBLyP
         CLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737566055; x=1738170855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nE070qqGZGw6mDAzzE1IWQug1apufvChvMUY0TYHWLU=;
        b=g3qNxmJrzXZK+n0kW6v38gp9KU7UFbTpGKueThkRKoTglPL7VA3nrd4HaxvfLNefgN
         hpHVpoEklXxS4wvL6fKb3Gn9+MGlt/i6Re+fpJ7aX1Pd5b6oVI/0xyclCZcrZmuM9iEC
         PkDHziybHwRmsmkOzw7OwMUSRwLnFD0Rxu6J0wKzXYHf1iCTLrfOhlqsra9g8VKrJZlZ
         /b/IsEzh+V+hrd2yRplQybHuV9KlzRbQXasgz5FsQlodIiBc2FsL5Cbi4839Iu2dhWwL
         4tnnCbvL0zZptQXjRMjUolUzLIPpxsktuvheFJFnMDlgPc6bCK9k82s9j/gzLlgQbS0e
         55EA==
X-Forwarded-Encrypted: i=1; AJvYcCWULOZdjrdsQ7QKrLFtD5x1pPcEMTCdcQs5K3K6Zmjkqc+KpvD8JLcdSxP1eIHU1IQa232hPOWtcT01Obk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwm8Xovd18IfZgf9PFxGRSAatq0JWbNuC/68XyQnZ+kdOHoa3r
	gf20DMad1c7wjZwC/JOSYHO8lVSe5y2htFBxjXX8UL7uQo2ZSTvm
X-Gm-Gg: ASbGnctHEYoYaN08bzl5cUu+d5Y3MyFwsB0x/EZNZKekHjqCgRVKQFfUybgOzkeuTnU
	/2lI2FgNj0zvmBoTd/N0FPEeAyBI2YCpgp0PK4E2FBlrzk+EPzZr4zOc5uH1m4ZLA1jzYli1A0v
	YS8mB9ShQH7au7NBPr+ZwDMTHdhfySuoqNc6gSYef5O2hAWv/CeABDIsGVdO9YkcBH7bHPbTjGj
	hWhOlkBP3yQ8H1jauC84QGZebSgsNojtXUlFhT+ydH1LZDXJ1gEjRGVrrbI+o1X0G/SQ82xIpyX
	l1k=
X-Google-Smtp-Source: AGHT+IG8EHOsbJUTujLQ/fOnmzsKPjbbzIgMHmktLEEWzk4ajFxIv5SGEihVGmS7wYpdwaa2IoWQ8Q==
X-Received: by 2002:a17:902:f54e:b0:215:72aa:693f with SMTP id d9443c01a7336-21c352de455mr290597865ad.9.1737566054861;
        Wed, 22 Jan 2025 09:14:14 -0800 (PST)
Received: from localhost ([117.147.90.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4215dfsm98585685ad.248.2025.01.22.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:14:14 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
Date: Thu, 23 Jan 2025 01:13:59 +0800
Message-Id: <20250122171359.232791-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122171359.232791-1-chen.dylane@gmail.com>
References: <20250122171359.232791-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for prog_kfunc feature probing.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 4ed46ed58a7b..5f94971649db 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -126,3 +126,33 @@ void test_libbpf_probe_helpers(void)
 		ASSERT_EQ(res, d->supported, buf);
 	}
 }
+
+void test_libbpf_probe_kfuncs(void)
+{
+	int ret, kfunc_id;
+	char kfunc[64] = "bpf_cpumask_create";
+	struct btf *btf;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		return;
+
+	kfunc_id = btf__find_by_name_kind(btf, kfunc, BTF_KIND_FUNC);
+	if (!ASSERT_GT(kfunc_id, 0, kfunc))
+		goto cleanup;
+	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, NULL);
+	ASSERT_EQ(ret, 1, kfunc);
+
+	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_create */
+	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, NULL);
+	ASSERT_EQ(ret, 0, kfunc);
+
+	/* invalid prog type */
+	ret = libbpf_probe_bpf_kfunc(100000, kfunc_id, NULL);
+	if (!ASSERT_LE(ret, 0, "invalid prog type:100000"))
+		goto cleanup;
+
+cleanup:
+	btf__free(btf);
+}
-- 
2.43.0


