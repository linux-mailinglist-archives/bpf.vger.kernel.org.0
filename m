Return-Path: <bpf+bounces-65837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE413B2912D
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 04:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AED57B5792
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 02:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481F20F079;
	Sun, 17 Aug 2025 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auBy6Zr4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CF137932;
	Sun, 17 Aug 2025 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755398783; cv=none; b=lwsQeyiZpo+7ccUAvhiTxXTYlM1QUojJnLLZujSHVSwZijmRCWsq3vL6ZjNnZiPVKuOY09cyyl9GyLGRLYDoNLZk7pmexTqPZNi5d+wc0CjoTnx+ry/cYAGAAmpiNVoCrBDZXDApkvMBxnuthEeoL/bnvjY5v21iVpasRWiSB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755398783; c=relaxed/simple;
	bh=TGw2ul2ZAldEcVHaU0fnT+T9Zm5AaMY7QcEq1fLdVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3MYn0daMUmVLkLkI0b3L2JSZYPXgqFojTqXhk44KXk1rtTd/3jKd8+PGYfef22q+K4zPmJJVvrWFmeq7eCsANC62I1kkJrq21vJvONqaHnmuQR54zyzQqijkxB1kZW+IIhBMVcnRldnUISQTxnO4HrsdskD1aGUtG4kkpasRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auBy6Zr4; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b47052620a6so3304525a12.1;
        Sat, 16 Aug 2025 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755398781; x=1756003581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=auBy6Zr4OGvfPTpO4iLfVVsY4MZTRTSMyHPULQMp6Yh4MikBS0Pp4bxaAa9uw2idkW
         4uHKE9DRYmWHGhKmozMLGhHzjFk6LXLSabz50IJku/x5W8i+pnx/ZNYSCFupKjTqcTCi
         Ill1D8pa53V1zDUGJkYnRwo5AoyGD3n+jMNrE0oHiJuM6vqei/u3pALP/Z1NqGlfYCw7
         lj14LO+YrG+3wELJNqatLLHw1em32SaWySLG+zMCRgREy6sJNZm7ViDmGm87i3dNeSQT
         11unpvPDqF6XH2OUvyjCGMPLEipLRiM+i1Avk2c16sLoFidtIahT8Y2grACDS8qtgLS5
         Ih5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755398781; x=1756003581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=c+C8FpF/amtgFqYgKFoLMc7DAg1hFdB1CU6GVqRnK8A2VYz9SuTZt1Xjvwtql3yhUp
         hLZF5jNlLNowdzI4NNUdq7sAo1f6XvT8vyOD2S+NBQIHCh2+/DwCT+I4DR8R23tOqjCC
         ooZ1Jj9fbX4GRBlIFgSaAgxMjx6DLkIMCyskqetHcdXs9ECJuuqRKPn9d2c+XVTRDA4R
         wQoF/XvLrv62MgJVAOy5yp7TVbXHL3EuDUKGvvy78ybJmL56mTSuV5XnxwOmR1kVDDsr
         vQWYg4OVjkDh5FCH9uUBMUH28dWhjpc2NO5Lw2utbqy/vGuAJGK+mjBFNmj2Mbq01F/F
         H00Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQTMa6NBHacdQDFLtpj4jPcvWnBoMj/HDjMrKVpU4I+jyp4uLTmceo0tox2VLr/1cQnH0=@vger.kernel.org, AJvYcCWXXoX9c7Un74nYp/WEZJ52N0D2AKrtYitQVsdd1o/sBvvfB2tIWNG7f/vgTZyEoc3nX/48tHXeJMxw2fglh+zr2oWL@vger.kernel.org, AJvYcCWjXj76ByPKsgAIk1bB3dxhUPUb7A6AeaA3ubpPisVgGrVMWe44OAxXOhN79iwBtwAkcALlbGXmF4VauUjX@vger.kernel.org
X-Gm-Message-State: AOJu0Yybye0vojqk0h5HqfIdpNRLtP4rmtYASjb3z/hEFN2lnfH6enXZ
	7OO7r8beU7zYjUYmo9lbLeS/MQGu1JkLY3u2CRES6Ktlp78vDUVNQmoz
X-Gm-Gg: ASbGncvWYikq+Tt+WP7+DBhU9HNRrLt1siHxna1NnB9Y8TVslQd/RDVAZ0n4j7eJpIY
	9KGcDzzY9DQUy80i/1z/6SgA8M5ghS38wnpVzbXa90VIBCFUdbm4Ge27tjRrYtZjOuWO/07wnYw
	fiHGHacLHvjuZzeHHOlp0+6kOaBrhWjKjgU8Mq3vrI8bGiJKmcr+yqOZJtKuQBACFmZeoqDORZc
	9lldX30RIklSs9kvaSQ+N6wd1FwBMA6we+yy7fbQXVG/+rts2WY6NA6U0uCXPlrJtV+GCfm1Eyq
	gRZxLMqQ1YCvoIhWbYcmIxbRNdusvBow+RIBO/48AOuLhaee9IODQ564fiu32H8lhPYiCrrUqa0
	7ui5eIq6mGDYH5oe8nmU=
X-Google-Smtp-Source: AGHT+IEeC2V9oqheQugCIcmUB2DfOBvQnyUmbMjdWI+i2rE3X4cT9blBWKi2otTV1GmY599BeVgUMQ==
X-Received: by 2002:a17:902:f551:b0:240:b630:e600 with SMTP id d9443c01a7336-244594f1b07mr188841525ad.11.1755398780750;
        Sat, 16 Aug 2025 19:46:20 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f382sm45009845ad.79.2025.08.16.19.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 19:46:20 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v5 3/4] selftests/bpf: skip recursive functions for kprobe_multi
Date: Sun, 17 Aug 2025 10:46:04 +0800
Message-ID: <20250817024607.296117-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250817024607.296117-1-dongml2@chinatelecom.cn>
References: <20250817024607.296117-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions is recursive for the kprobe_multi and impact the benchmark
results. So just skip them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index d24baf244d1f..9da9da51b132 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -559,6 +559,22 @@ static bool skip_entry(char *name)
 	if (!strncmp(name, "__ftrace_invalid_address__",
 		     sizeof("__ftrace_invalid_address__") - 1))
 		return true;
+
+	if (!strcmp(name, "migrate_disable"))
+		return true;
+	if (!strcmp(name, "migrate_enable"))
+		return true;
+	if (!strcmp(name, "rcu_read_unlock_strict"))
+		return true;
+	if (!strcmp(name, "preempt_count_add"))
+		return true;
+	if (!strcmp(name, "preempt_count_sub"))
+		return true;
+	if (!strcmp(name, "__rcu_read_lock"))
+		return true;
+	if (!strcmp(name, "__rcu_read_unlock"))
+		return true;
+
 	return false;
 }
 
-- 
2.50.1


