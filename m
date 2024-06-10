Return-Path: <bpf+bounces-31761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB9902C3B
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 01:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936132853AC
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515571BC39;
	Mon, 10 Jun 2024 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOJJqOR9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407C1514DE
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060948; cv=none; b=NWXT6mNnzJFkT2L7TxBFYOJ35K/ytwKxdPxiL908SEo49G7n1+PfJY0HHMumVLyA/QYFHxeWcrAynx4ellXyWWB8TLWoTL4UlYp37izkpiu1gcJmGk73Y2gwWKGi7Rf/PM9/1gKNctC0whcI+mDr9vW5bUY1CYCmOQhdGpFNTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060948; c=relaxed/simple;
	bh=Gm5gtUs7ESel2//jbT0TijXe29JcPEixmsWoeLbvHjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1nabHqPriajLEly8pR6cKPovIHKLriois1TYc3RDa5qoGdbQDrqBzqe2IbR6vnLd3fQC6OY5fi32DWtSlRX7Jb0wpakSgUg/b93rgnxrE6NZdGGutJEcW7xZF8cJ2KPx1Qr4ahzVpq9wxDZOYTmpZpPPBs6eKKkRMf3hALC4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOJJqOR9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70436ac872aso490549b3a.1
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718060946; x=1718665746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us1aqdKDZ5u/C9Le8gUMjYEff67H98STOGSj9ePhdrk=;
        b=HOJJqOR9TnXBsQrIViQn0JPmcRxEWaV33PEJwTiCHRtO4jkfKWROSuOt0XF5RaM7yf
         MUnv0Nme7koRlyoBJLo75CGKePdEyVzxdgE/AUadPxHmeU5zT4qneivJb5eoUmHD6lt7
         aFZe7OiwuO14RaEHHQbI4bwbUm1D/70INHbVOcn9cipIVclFpwZd8lDVLBBy7Wx5GI5Q
         90RpcRZjvX2ewPfk8XUT629t1CZFSnRrHzvFVoZ7Htf4pmRubulzK4AbDLVD715osu5b
         /MqNVukkkm/A5rk/8D+aUWaI4r5XO3c4qLteTLmWOcgKuvrI6g6TVF8f41ODu04w4eDy
         2A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060946; x=1718665746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Us1aqdKDZ5u/C9Le8gUMjYEff67H98STOGSj9ePhdrk=;
        b=pXgBdTU2V8SAU0uh7b/Rm87NB8G2EG78xUOCsRz4B7EMNAJvjx9MDdvwbU4RSaf+bK
         c7U/QiZuuk3IgkMhUDyNV9Y/YRHFFo2ValiIsH/WHtxF+CRr2BwrzcpTuK960jM1Ukf3
         swWVpADf/abI95cDWjtKa86M2Zic4Wm9kHSIyHorKQmK9q9vbeaVlhPRuOzvDFiVWmiw
         efmGuJj5kF4WmwmRWYk+0LrjR4UuabwcCBq02eSK2cwhtk6PZI7efgYIGsNBxF6frjpb
         zk3zHnRizPAjnwyhs6FvBOoH97LJkWLIQx0iat8xeHqtyyX7b0Zn4VWNN+cMJIX28TxV
         uhuA==
X-Gm-Message-State: AOJu0Yz13F4DGMoyl/NDznJlt3Sq4a4d2H9JVqzh+uC9X//bYDnQC7Qx
	JBTxg1dfp0p0mUOPgKALYgPw8tbLoeSbaq/LxngEBdN9SZbq8h/GRWsJsA==
X-Google-Smtp-Source: AGHT+IEhTdI0vWSWc4npDBTdbwE7TgT/OKNsXY7gD7WOyoDQQodTMBoFskLhlWOeRfIhFO0eEEFGCA==
X-Received: by 2002:a05:6a21:999e:b0:1b4:efbb:d1e1 with SMTP id adf61e73a8af0-1b4efbbd2e4mr10985552637.33.1718060946082;
        Mon, 10 Jun 2024 16:09:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:cfaa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704236597e8sm4681908b3a.141.2024.06.10.16.09.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jun 2024 16:09:05 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 3/4] bpf: Support can_loop/cond_break on big endian
Date: Mon, 10 Jun 2024 16:08:48 -0700
Message-Id: <20240610230849.80820-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
References: <20240610230849.80820-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add big endian support for can_loop/cond_break macros.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 3d9e4b8c6b81..82b73c37b50b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -351,6 +351,7 @@ l_true:												\
 	l_continue:;					\
 	})
 #else
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define can_loop					\
 	({ __label__ l_break, l_continue;		\
 	bool ret = true;				\
@@ -376,6 +377,33 @@ l_true:												\
 	l_break: break;					\
 	l_continue:;					\
 	})
+#else
+#define can_loop					\
+	({ __label__ l_break, l_continue;		\
+	bool ret = true;				\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
+#define cond_break					\
+	({ __label__ l_break, l_continue;		\
+	asm volatile goto("1:.byte 0xe5;		\
+		      .byte 0;				\
+		      .long (((%l[l_break] - 1b - 8) / 8) & 0xffff) << 16;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: break;					\
+	l_continue:;					\
+	})
+#endif
 #endif
 
 #ifndef bpf_nop_mov
-- 
2.43.0


