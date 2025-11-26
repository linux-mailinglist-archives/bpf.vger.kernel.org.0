Return-Path: <bpf+bounces-75558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89189C88C4F
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2B13B47D0
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EC0322C83;
	Wed, 26 Nov 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQzOZLhS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD7322A21
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147061; cv=none; b=oc7WCW3H3zmb1sW4jJfjtjKwARx9hW2xj+JCRXQ1MsFGZRdm087KtiPr3Ypz4BYNRyjupRyEEVyU3KBZvriJTBRNDsS9H/MGrbm9MJUYGCDDqHC1vfKjIM6Uam+oGC3sCe/t7/7B0kY7RO//SUpIKpQemVI+fnpYls1DfWEdjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147061; c=relaxed/simple;
	bh=PzKDskgzZMerL2L2GaEKme4Emf7+T6L2i2C5wE8wtz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjsHRjig2JhCQbMgSMpujalqapfTnSIfm1k9kq+4jCV2U9mPoiN5Tdq4FgiR3oAb1h8Xe7OE/p/bMkJZSMQawvrl6HbSf5Y9DzjxI62D+omh23muRPCGUISjOpXGWG5JyBE/mBzCk8KM/wyb462/k5NcBY9vn6IfAVACn+VWaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQzOZLhS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso7482670b3a.1
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147059; x=1764751859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58hD1y77fUWt+lA48dDAWZ48XqtnjLY8s5Dj8Cad7ik=;
        b=IQzOZLhScUsnyC9jpg2HSJBkX6IsLKg5UT0cc1IlnC/JCJ1t9QOC0uFyvBjVx4GQjf
         B3p/8Wcy0ZZhzVRB9zJpvf45dUaYbRoVLO58cD26IA8MudTPAfRu9eb8QlyfRfCNnnM0
         sNgmoBUF+6B8ihr4NPb2ajPmxgun+CvQnVY7u7LtdJ99iyTEFS8Z9XyEYEHX4SZUCgiO
         DcJm45Rgknq3IcxYbYcq4uqo6UeV90vgsTyFlRj2KPN4rxlshzuXO1/RyZ8tPar1a0b/
         zmt9zWG8heDpTua/lMoGrtbH0QIHtsvopIiqIpIsOEK//TE8n8nvDrTGeGzzg8kionth
         Otgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147059; x=1764751859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=58hD1y77fUWt+lA48dDAWZ48XqtnjLY8s5Dj8Cad7ik=;
        b=Xvd5DX2DJPqCj8vC7gv7UMp3ZCKP+CAS9Yf+zhg8dWMxvVw0VROI9zzLo7255u9HB/
         xI6UlRuG9iCH6Sj4kdmuxU7yzO4g6KNyB4irJGR61DOL3cBJrRzVpyykHfFOiNsDGmxM
         2AJEDS8lUQL1aB4WkQ1VHAJP7q/NgeFZngtyAc9MGsfU6vVEh6rAyi/OMSOFIkfDUsfp
         lm3jhQ3CKhnCXCGBRWP9A6RV7Phb0SlN4rX1KUn97zyniTxhrr+LDAckH24/NDWZ6CUo
         Uba+an3jerP99yoeSRJKMGLmBDxIS7IADlj3n8HaF+E0kDKsBJygoU7FSTmPIwHdqN1e
         Ss+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXP3dpeCQ5ocNjwMgWyuaHt2ONOkbj7YtHsjdXW126NCIhWRgApIhqgr8BoWQKZjrqxaSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyHcAZfN/K8YkiYTESmTjeMzCrCcal+MU24FQjJ3/l+Sg5XHG
	C/X/v1YiWmDOc2LnfnOGCX7HCLvrFbXxvrLixL2VcoYYW6EnRRCuv/WR
X-Gm-Gg: ASbGncukFqKp31CcpsXp/zkOHN4zUnkxUraAScvSu2+vaz5N/qV3LWFNhCK9C7lSUJP
	M85NhH5B6jOfECV6Xm+tc3++xU1uY+Vjea2pUxKdNVx6TrR1I3YteUg/bqTVM9+4ZIWAQHAzKCP
	7KJwRQgs83asFuC9RliG2viq8HQQe2GesqrXiBhWRDfFsd1skJQIw6+94i+LMilSuB/ePWG4Iky
	/vS86X9aR/coZLKK/eeBfwxo1LapgNsgXe8WYeSkE1UMMd85TbkLpJ7tUc9QwyZFPOcAviS+5iP
	muJRUU4EnbICaD+Yhm05c7IzKmoUWNVyouArWoYV7HDn7TtCpjfkqSsd1KjvzqiSAYL/2p82auG
	lLFPUVQi1N3S7oGSwquUkd6AatpBsOhfvquV7x0z/yAvmATsH0+9Dh+vx+eHqDq5GZl1hOOKLOa
	wtGwXehe6UecaZA+/GXqozyhTgpN4=
X-Google-Smtp-Source: AGHT+IGr8biMRq+KgsRojAjkXMzOBT3BE61S5XBhKzO5zm4iKipVa4IvOpq4czkvkA1GovFn4zZogg==
X-Received: by 2002:a05:6a00:10c6:b0:7aa:d1d4:bb68 with SMTP id d2e1a72fcca58-7c58e112cb4mr17345530b3a.20.1764147058760;
        Wed, 26 Nov 2025 00:50:58 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:50:57 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next v8 8/9] bpf: Optimize the performance of find_btf_percpu_datasec
Date: Wed, 26 Nov 2025 16:50:24 +0800
Message-Id: <20251126085025.784288-9-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126085025.784288-1-dolinux.peng@gmail.com>
References: <20251126085025.784288-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Currently, vmlinux and kernel module BTFs are unconditionally
sorted during the build phase, with named types placed at the
end. Thus, anonymous types should be skipped when starting the
search. In my vmlinux BTF, the number of anonymous types is
61,747, which means the loop count can be reduced by 61,747.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 include/linux/btf.h   | 1 +
 kernel/bpf/btf.c      | 5 +++++
 kernel/bpf/verifier.c | 7 +------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..2d28f2b22ae5 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -220,6 +220,7 @@ bool btf_is_module(const struct btf *btf);
 bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
+u32 btf_sorted_start_id(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 925cb524f3a8..205b9c3bf194 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+u32 btf_sorted_start_id(const struct btf *btf)
+{
+	return btf->sorted_start_id ?: (btf->start_id ?: 1);
+}
+
 /*
  * Assuming that types are sorted by name in ascending order.
  */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 10d24073c692..367699591fb0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20576,12 +20576,7 @@ static int find_btf_percpu_datasec(struct btf *btf)
 	 * types to look at only module's own BTF types.
 	 */
 	n = btf_nr_types(btf);
-	if (btf_is_module(btf))
-		i = btf_nr_types(btf_vmlinux);
-	else
-		i = 1;
-
-	for(; i < n; i++) {
+	for (i = btf_sorted_start_id(btf); i < n; i++) {
 		t = btf_type_by_id(btf, i);
 		if (BTF_INFO_KIND(t->info) != BTF_KIND_DATASEC)
 			continue;
-- 
2.34.1


