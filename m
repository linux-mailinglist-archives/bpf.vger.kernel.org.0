Return-Path: <bpf+bounces-64483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07247B135B1
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D057A5358
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 07:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42762397BE;
	Mon, 28 Jul 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPY9NkHq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E957236A9F;
	Mon, 28 Jul 2025 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687616; cv=none; b=a8yagRjfgr19UGCygDzJen3iMNqDai56lRjmJui8KEq/POmI6zX7WU5mZbZCULUzTKSPiRVZZ9sLqDJ39h5hB3TT8ErmQE11gv3CrqGirJiTbvZ7GCtPGxs+VV7ieXKzDDlGAcMNb744wdakVyEW0or0hEaE5QzXvYmIWUdpS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687616; c=relaxed/simple;
	bh=TGw2ul2ZAldEcVHaU0fnT+T9Zm5AaMY7QcEq1fLdVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7IZa58XnF7+fgfa5T7MY8mZ2XHfrpCvDXnyKwzrTH7QJ6uRx/12CTa78QLH+40FowB+VWCkR6nWXPN9nRcm9hFoG1oJNDRTKAP/UU7o+mU9CBfY86o1s9g84yMsrj2oobc4MDXExJLmKY0/awnKXUsy5xc8wHO8RBguUCNLPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPY9NkHq; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-31eb40b050bso848166a91.0;
        Mon, 28 Jul 2025 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753687614; x=1754292414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=mPY9NkHqqRiVPqM2WAHhMtNIl5psfpS8hC5Hgu89sEZ3ANCKkoeaPZJfHywwBYU7+v
         Jb5y15TqxxNLigI6aNkqSjKn77wcflZPMD5q0dILU1kUZ7cYH+DuRFo+dP/HeNF2g8uM
         7GK618Rp1ux1okrXxe9UD+X3+POxX4rVrWOJlkyFQun5ocE1B/wohWO2EC1FcDZ0i8Nw
         vz5w6+k8SB39i+MbjbIBVBhWuXJRpQDHll4EB1m1ZdF0bTwV9EGMq3PgN3IdLKQ/AxGO
         +PUmHEoVBpskQcsm1/xn085qYPMmlNDjcd7Oc9iWYIxPDATyIh11wZmmECM+r3JiGQSk
         UcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753687614; x=1754292414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=CB+MUsVS2+9IW1yvgUKKHEwqt5zJKQo4Yq+h3WGDV9vhdLShFS+68mNaQGNl3taHxy
         i1W+HCj5W5TIzSi1qydEfuo1espHJ0HJVPxoHH/DKCqYIGt4oOtYZ1aZEOBX9HY9sjAg
         YsQDIVk3exI+vKvQHQN/k0urYLHfpGStsucYJBxAjzOgdkQjF/iCWC5WBzWG5aDTC5+u
         A+R+wjNjFZaiibJjJpUFGLiMwo6cJUvpesCVcI9/ofEMMaHv1b2ZngLjeGppr4CkkRT/
         zVJ9jvwXUOVINIF5rf3W6G0+FMUO7jAkznnE3NX9EDxTcjgCnt3SNNbDxEJauRcHg0PE
         HVxA==
X-Forwarded-Encrypted: i=1; AJvYcCU32zBR1bibepuyWOcTiBlIOgY+abO61TouccYPl8bSlPiIJPqxqa5LH/SxI5yyZkHq97dssJRuc0WHCEsS@vger.kernel.org, AJvYcCUOWXaWCnIuIKxmnuFqJ3npwivtDq+b7i9+9r3iUz1V/c7f0OnrylREjY+xd6avQj28I64=@vger.kernel.org, AJvYcCUdSg+V3SUgKbU9yLee25kbBYDcjvrHbvKB6hJIyWR2IEYYhah3FF5lCD9tqqZSZvn+JPTZLO6nfg/eValX2r5Scblc@vger.kernel.org
X-Gm-Message-State: AOJu0YyeASbcWLkPmz5/4SdvHrq4JbxNL+ILpKEmOaV7UX5ElTZeM1DS
	cl8eLvHmNBrTw30YKj9AKnKwk8PiO6idwWgQbGEWW4qjwOodJKpbksnC
X-Gm-Gg: ASbGncuwc4xDGxv2IJ1BFaw2Jrt1cG3JcmUqG07NTiMmO6AQ5EFLwmRzJ/LcJdxSGO5
	5vQOJveJd+KAyUfDl6JNMIwShHO4fJtMKiIuobygFQhhHKPnTa6Qn3qVMiPJWVzfchQ6ISzaaed
	oSxCgGfaN1flG1IHLSJ3cSxaBT+E8+0D3KOwa1N0dePQPhivrv9D6NGg1+X5NHdCOqbvGjzLPNt
	npYXTFRK+CK3rZaBxV4X5H1fiuWEnDAUhWRiHx0XWM76jrmAMyjezk7dMuya2dvmnrn6ugF1Ow7
	5QFvElahdSnGf34aTjN8GiG8Am+ah3nTC1XXt5fQL8FEjlUrofAhtrwXbkz4DKUqDobD8KETFZG
	SQquxTLFCGFsUN3x37ZTxEjKX3E/MRA==
X-Google-Smtp-Source: AGHT+IF7jIYJLv6nMqQFak/nn9g9m+uvaHqaYClggpwcVWt9FynpsHR8SH9kO8l27gIScxMlb2slQg==
X-Received: by 2002:a17:90b:35cb:b0:313:283e:e881 with SMTP id 98e67ed59e1d1-31e7785efe2mr17127850a91.11.1753687613470;
        Mon, 28 Jul 2025 00:26:53 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e949bbf7asm4459599a91.9.2025.07.28.00.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:26:53 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH RFC bpf-next v2 3/4] selftests/bpf: skip recursive functions for kprobe_multi
Date: Mon, 28 Jul 2025 15:22:52 +0800
Message-ID: <20250728072637.1035818-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
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


