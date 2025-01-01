Return-Path: <bpf+bounces-47740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F679FF4DF
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 21:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31D51614B7
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486D1E3771;
	Wed,  1 Jan 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ey3+LfdZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05821E2309
	for <bpf@vger.kernel.org>; Wed,  1 Jan 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735763857; cv=none; b=oHjJDKEx4uAwpcyTI0ezdo83gLi7sYV9Isf7VcdJLHS5gncCR9k4r05ZDORdjymrlRX1FX6J/XdJ7+mWAtQctk3YXk8t9FUcJmSaSfrjANucKULPH6geOIeJyDYczNCYnmVHStb4XVdxa2Sf70edAjJMF+9cZRy8N9LouOeMoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735763857; c=relaxed/simple;
	bh=nr6WDRn6aIv+cVeJZ6GVG/zcnxpgHasd6ZNQ4do9Fo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYV5J/im8bkYWgx0TtLdmg6O8tHaU8ltKkSGJ2mT799Nbl5BpWV08ke+/VSgHPrKy/a6aaYxjg8CMgx+3Yj9Ko9hPeHocLnusCcLselqYMTA14dqkdF6s71Ke9EoWGKAkUgxkpur8+9ETKiI7sKyFdvodpbFThpu9MGEDRZYyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ey3+LfdZ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679d366adeso93269721cf.1
        for <bpf@vger.kernel.org>; Wed, 01 Jan 2025 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1735763854; x=1736368654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrRqqVi5U4xTcsBmFLs38PzklCLw/T0W6WWLRWRIV3w=;
        b=ey3+LfdZiiZa+5MSvTMi1L+lGfhBYHYNIPx+e7iz6L+Ej4shpg7YuljPBHfSi3Vffe
         AWE+a18Y4/051pELJek9YbqgTMF/rH4BATiQc4hxayor1Gxuh2lTMws0TJkeDgsm9Otg
         /ySJkFM8ZJMTydqa7ED9ouA3kxQFq/cv6h2bgBt16rfRPHNDV+jO7Oy4tDEdLIRivxXT
         594aPwhB5hlOZqU6qdjct8XDoHa+0VxNxKRZw48YwfbOper/AZ6QdE53Gri0h3e5tkFw
         WNIYX3LAuhlfDK8NwWYqe/tZx3f6vl0K+3Jae7I5kvOnZmYD3xEq08ktfsr70Xw8mI1H
         Mz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735763854; x=1736368654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrRqqVi5U4xTcsBmFLs38PzklCLw/T0W6WWLRWRIV3w=;
        b=Kt5dbcWV8mPkCUMVzVtp/bV2/GO0r1O18sxCaY+ZGLPzDRetDp6i5S811xxyCJvdK4
         g1WgmdJpDRlrPc1rUaRToVYEay385HKttrOSWyObh0r5PFjk+sKCGSTiELZhPP7dUm8B
         aOb0gkdlmX1pP9l70K2g9vz0kB1yHf4/x06ukpo67qzN8RYWpilt66nNeQ68VgOIZSSq
         1doSZTKWX61669j2Z7M7f2kD7K/Za4aNzghmMLgSK6K7YtsZzPOsVq1yRBIVRDFmhZgT
         o+bg47EdI02D73AHslKv9FvHD3advwTGfO0EsLRG7hJ3sF75LGdTYHEqBYQlFKi1cFXt
         f5XQ==
X-Gm-Message-State: AOJu0YwKhb7O/xm8xo1RSof91mYOqNKO/5SXpTL51JZslc9/4RGe16BD
	hskfZpzWPa4FRE0t9QLoVX4my7nfIjlqxriCXjiYkOuHNcsPYHBP3zSpudJdE9/xeRwVk5wXf9G
	nFssNGA==
X-Gm-Gg: ASbGncuRhqIG99JeR4RpCscGBUVKNTQ5F/Ka2cJ1H/3r21y8lVZBKxp0u8ZlHrqCwtJ
	qsrQ44BE38R9xw3MDuPtwmlEQfpQkjsB1otxnrG3wn16/C9bhe205i8+nURvEIHJXpVQa32EGC9
	p+DtQER7wqRNo+GVFm/1aKPPHx35tpZfyyiuvcNSsl/f1L/R0CMEtPHRNWmDaf7Idp3J/PJT1qL
	StWriPbpYKyO4U0BwA8LHcCZRAOFCvb6/ObhayPenipnNhY0ZI=
X-Google-Smtp-Source: AGHT+IGyiUNVVYFBIAv9QxBlsAwVJ/olFCZjRQbkZU0QomifqMJNDzX4AWpHP9glfPpx/u7SwdBfGw==
X-Received: by 2002:ac8:7fcb:0:b0:467:8342:a84 with SMTP id d75a77b69052e-46a3b096614mr775875501cf.19.1735763854445;
        Wed, 01 Jan 2025 12:37:34 -0800 (PST)
Received: from boreas.. ([38.98.88.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb30dc4sm128358131cf.76.2025.01.01.12.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 12:37:34 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 2/2] selftests/bpf: test bpf_for within spin lock section
Date: Wed,  1 Jan 2025 15:37:31 -0500
Message-ID: <20250101203731.1651981-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250101203731.1651981-1-emil@etsalapatis.com>
References: <20250101203731.1651981-1-emil@etsalapatis.com>
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


