Return-Path: <bpf+bounces-51855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14984A3A6B3
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B01656B8
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064061E521C;
	Tue, 18 Feb 2025 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2EVm3XO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D71E520E
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905278; cv=none; b=onA/3EOtDIsN6eHKYpZ4llt6aYoOyZYFjya0o8Qw/1uEUx5MvACqsOINgxpQjKpQN6/l9BbRjHQd9u0DUzpjR+xgzBP8GBzL7dT3fm+avuXCVOCpzQ+hmKFukZNIJA91vYOpu3bLubBKipz5Vh8AHnCHp4zhllrFIyFhYxTOXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905278; c=relaxed/simple;
	bh=vcmw7BJhR0EK7XQdyJqnA3pMQ25ghMQT9FGn3OgyPhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1CIx7ToyQ9TLYb7QZiDoT/DH+KtmKM/EdYTb+KNVXzfwsZgWWZkIl7Cc08Q+Ueq8uRd2uAAlaPlhya0f3Dv790KUX435Ek2s0hFuIG1OKyQmYBRlGKDAZLspWspU6Rf91KiQLATF2Z4T6FYlx8RA1ZeBM6kB3FvbWXP8eIEg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2EVm3XO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so8843943a12.0
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 11:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905275; x=1740510075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI8rZPxx4nO29zDE1a8YQQ1c9/ltOEZ6Oc7nBm5GmjQ=;
        b=C2EVm3XOmZ1klITnEobhqkWCqRv7RUjQz1aKfHPiSFGY0eLWRvn1c0j6sFxscAANqA
         O7O98jyiy0BHXqHXuBl9eO41CbxxJoL+bozZB2eaMPv2Vhy+nRZqrcP3tZKoMygwMRzX
         c/kRIYi6fxcETkwR6d/unDlMalSJtTphQ5qegmYqu+4SYg3tKVt2wwWbe2BZ23P2ea8X
         kPAKHUWY3pgqfAsnkG09p8KMY0AS8im9l5ujht7CpoctvOpBpD0X9/57vW6XWD9K0Tl2
         cWP1LgxjCSZg5MSXcNi4oeAtHnhleqb1lPM+2/tH57ct7D9Ufzdz8LX6Va84ATk/MOs9
         RvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905275; x=1740510075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI8rZPxx4nO29zDE1a8YQQ1c9/ltOEZ6Oc7nBm5GmjQ=;
        b=VO2HSdHAqfVNL4msZHvjW6G7jdbw9ACJYwDBlMw5d/deGfTtX5vtbNfWmoRF4XPO0j
         BSeEgAD6rakLKCwxH4JW0nYXTyW8ETVYDekGumixBPcH4u5q4TolbBroxyvLwAdnW0KB
         ZYkgWxVeEDr0E21agGc1tITAN6Xl+Y6NjDt7qIedVbjzwlZ40W0BIYPD9aMP7279m5JA
         H+3fJIOJRTvqz/I1dnLok9zfMas+og/too/HrR/hgAP9KUzNlTaGhhosvxnLV5Vay1Iu
         90P81m4EEAh62J4PVeQx7wsgzU8KLBC4bfeQby8c8Yy+5cCgBanltmXnrPyq5aAxdrCc
         Mnzg==
X-Gm-Message-State: AOJu0Yxtw5A3G3w+RRlBXffKFr5q3hMgzYA6im+cFVDWrlsDD0QafNe9
	VdgLBnNEKFDIcX+wyvZ9y8Ttmi4NOy+gFXRdPcj/K6X8er87G3ImIwgr+A==
X-Gm-Gg: ASbGncseOTxIYMiSu2xNPJUdfpeN1uD0ybIrWkbxRMc18VJBwULVW9g+XvXSRsbh/OQ
	CSe6RaqFO/xI9vQw1oQLp9ddJmEW4QXVTI80cNTEEYoEbVn5aKFUe9mcn2Dy7veWxusIxw65xE4
	NW0sKQ+FvW1D4rHQGcJOjCM2Jsac+v89Pb/dns4otTyMM34oavXWXN9Moh1hPIp98kZT69IAc32
	9U+gMA4nfc/grNgRskUoFG/Sf6Dt0GFXaedHp5v+i87v0vMvkrQHqV2u7QOwj/D9bndxBtYEkoN
	UablfMAFOVYjo/5iRy1JzU1TqclnEg==
X-Google-Smtp-Source: AGHT+IE0FRDguW9BKbb1u1OpWOIDla1OvQGp7Dg+KxGZAalNOfNukZ81YZcLQsZCZIXjF3wNj8i1kQ==
X-Received: by 2002:a05:6402:528b:b0:5de:bc13:6c65 with SMTP id 4fb4d7f45d1cf-5e08950c103mr468494a12.14.1739905274932;
        Tue, 18 Feb 2025 11:01:14 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:4cdf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e02ebeaaa1sm6248540a12.5.2025.02.18.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:01:13 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 1/3] bpf/helpers: refactor bpf_dynptr_read and bpf_dynptr_write
Date: Tue, 18 Feb 2025 19:00:25 +0000
Message-ID: <20250218190027.135888-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor bpf_dynptr_read and bpf_dynptr_write helpers: extract code
into the static functions namely __bpf_dynptr_read and
__bpf_dynptr_write, this allows calling these without compiler warnings.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f27ce162427a..2833558c3009 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1759,8 +1759,8 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
 
-BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
-	   u32, offset, u64, flags)
+static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *src,
+			     u32 offset, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -1793,6 +1793,12 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
 	}
 }
 
+BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
+	   u32, offset, u64, flags)
+{
+	return __bpf_dynptr_read(dst, len, src, offset, flags);
+}
+
 static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.func		= bpf_dynptr_read,
 	.gpl_only	= false,
@@ -1804,8 +1810,8 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
-	   u32, len, u64, flags)
+static int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
+			      u32 len, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -1843,6 +1849,12 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
 	}
 }
 
+BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
+	   u32, len, u64, flags)
+{
+	return __bpf_dynptr_write(dst, offset, src, len, flags);
+}
+
 static const struct bpf_func_proto bpf_dynptr_write_proto = {
 	.func		= bpf_dynptr_write,
 	.gpl_only	= false,
-- 
2.48.1


