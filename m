Return-Path: <bpf+bounces-47884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A95A016B4
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 21:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657C9163613
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2F15A85A;
	Sat,  4 Jan 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="SUkEXbm9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614771CDFCC
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736022335; cv=none; b=eFxKZT7NvfSJN7LSG9UZTrOewELnsymS+IOFEvZWDYW5JibI8PqSWMUx5fGJNEaISkXWlR6GkC6TesmgRxFBeioANGvGZaDjm3WVm0sQGjDuySSxfOaTm4or+xJQWw5XwdjBTYkMtC/OaUmrfHyafNF3mFdqzDPbgPfZu8Ex0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736022335; c=relaxed/simple;
	bh=hSHGEGnD5bmCL0YDJdq/Mt744XSdRJxEYB4AQenLQa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKnmIHIT6gOcE6IGbMi1A313J/GrBP1e0CpwYc5Kd6Q06/9a3g7xYgfqmOAVNo+RNEHQqrXAviKlBEDeMrH8NYbuHqLQ3hktLvQ0II4D1yIZi7RcGk13AZTsuit4yyTLeR4PUDjbhATjUePmH/jsPfy+Pl3DEAeRPbyGhmoA1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=SUkEXbm9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b70e78351aso1067696285a.0
        for <bpf@vger.kernel.org>; Sat, 04 Jan 2025 12:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1736022332; x=1736627132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmALcOErg61e4o7yJybNvIJfIZw9f7N8YtJLyKo17k0=;
        b=SUkEXbm97ZM0FpnBrDomlETZXqtdXma/DTDlLTI8nWFCyLjoxMlCjS/kPd50E/yaW+
         QpDK49BeVMn4QawlY+d8FIi6VZpPsfs80XykZN4jwKFFXFogoH25mWMx1AZ56i2lH/DX
         8dizFngE+e6vHJxsQbq7BtmSd7nWVYgWXujdNJb4BtPKPiQGeCNsipsBztEz/6qouLn/
         7bjEF8e9rucYzqHuTwgxm24XE/ghZi4CaKUaWYpcl+rBiux7q9BPTKv+nliwwq9uipjn
         X3VbF+QRsrmd3OvfsQZXn2ayNCW9pCRnKwB3liF5MmTvHOZJAeDx+RzlMOpcuw0QcYUs
         4lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736022332; x=1736627132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmALcOErg61e4o7yJybNvIJfIZw9f7N8YtJLyKo17k0=;
        b=v0qFRH2RiyrChrPe/MSvrBP7AeZO4DeIqSEx1WewB3iZXGQPpsHwmdJIKIwI/uhp3k
         fD/V017EjT9yd/PEVcfK/ufWykCLZG1vruOBJmpk8fJU2tKi9VD+xiyWsMkRb8aE5gKL
         k3/xVW2qVyF6hNdlXn2h4wrg8rGrq8ggUm54OJi13+R8l/iVdBoSC+it7jHNNYSD4/ae
         Ex1qM8HuJG3Jq6krx2FexsrYN/feLZX0VcATJGPRKoCvpBwpBczUCnHN0bV+1tZZBLrx
         FqjFtdIJxBDwbc1kAe48UpleXklzLdsyDQGbz/xoR2CSXbi0lhy2uL0hisqMy8SMVy3J
         TRtQ==
X-Gm-Message-State: AOJu0Ywkoqi0gEtNAhLrW3XjUUV4jthGg8x6+CCQW5SpJIpw8TjFaPHL
	6kYYeohB3U9lGOuyQ1SDEnBJ0bQQgkLia9IHRm9cH4WozjZ502hdZXXo9WvOrcmDpnrPsIzsJT+
	be3030Q==
X-Gm-Gg: ASbGncuP1KgDLtLnHx9tt+qcAzi2QVt8qqTwIWzHPG98sUaRFMzQONNwMb5wSUKa28N
	Q24OQsbXaPAtp2BKuKhVI2Otzi4Qkbb8usynxLTUJCLTuri5qFqBpDQM3K41Peu2gFexgzVQquE
	v+whpQcqArbG+tgnjSef7A7KbSE3aUtoB4d604tgMNrfI6vxoQW62bu6SiydMGJ0ri+h1+SUiH4
	Kj4geZnJi9gr4eCwfpghvOGbXUWQxxqgKhr8j0UHlzp0Ni21+c=
X-Google-Smtp-Source: AGHT+IFMTPGC/QYT50OuRCcUt2pnsu0ZEVUBXOJx2JE6iHLf+Hc2kvAkrzwiHxVhumc2xrPLAbIk1A==
X-Received: by 2002:a05:620a:40c3:b0:7b7:314:f01c with SMTP id af79cd13be357-7b9ba84841emr8024220785a.61.1736022332208;
        Sat, 04 Jan 2025 12:25:32 -0800 (PST)
Received: from boreas.. ([38.98.88.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30d7e2sm1376162085a.59.2025.01.04.12.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 12:25:31 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 2/2] selftests/bpf: test bpf_for within spin lock section
Date: Sat,  4 Jan 2025 15:25:28 -0500
Message-ID: <20250104202528.882482-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104202528.882482-1-emil@etsalapatis.com>
References: <20250104202528.882482-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to ensure BPF for loops within critical sections are
accepted by the verifier.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_spin_lock.c  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
index 25599eac9a70..d9d7b05cf6d2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
@@ -530,4 +530,30 @@ l1_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("spin_lock: loop within a locked region")
+__success __failure_unpriv __msg_unpriv("")
+__retval(0)
+int bpf_loop_inside_locked_region(void)
+{
+	const int zero = 0;
+	struct val *val;
+	int i, j = 0;
+
+	val = bpf_map_lookup_elem(&map_spin_lock, &zero);
+	if (!val)
+		return -1;
+
+	bpf_spin_lock(&val->l);
+	bpf_for(i, 0, 10) {
+		j++;
+		/* Silence "unused variable" warnings. */
+		if (j == 10)
+			break;
+	}
+	bpf_spin_unlock(&val->l);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


