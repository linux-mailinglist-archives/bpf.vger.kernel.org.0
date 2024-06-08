Return-Path: <bpf+bounces-31628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC18900EF6
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 02:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9F1C215BD
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 00:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF3E8F4A;
	Sat,  8 Jun 2024 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEUhgqJy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF58F47
	for <bpf@vger.kernel.org>; Sat,  8 Jun 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807504; cv=none; b=CIUjZv+L7+6LxDavgqYjvhwVHVcWM5S1/me9gNlnvXNIRtu3TbAb8k74zGU9oFUFOYVjantX/wwz8VtQMls09iqrDULlFGoHT6nn/jy+fyFrTKCk9g+FH1cAkzn0SWWPM9vxQqqWCjgidJobVJJ74VVOUnjBT7ypH6ZG2P8jX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807504; c=relaxed/simple;
	bh=yV6yP5ikBMdRk/2I4aZIJg+33sDLYKhwECezcDyBXRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zfu7jY3GDznksL+KBYQPQ5JsioEUuOBraHKWFYwpW6/+NnfDYjUMhUDM5QgDmr48GUVG4RMmdq+0+qatQDghlBlSQ64L9t8a1TcADggYejcI4wRsOqEW+qwa7rEOuAYgz/pcxvnpqKohMM+vu75YsFQCLabFIlYQGesRc7V3ZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEUhgqJy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7041ed475acso510183b3a.2
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2024 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807502; x=1718412302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6cOdf9Cu6zqOkqikPzS0/9PNzRSpjAjgooQVzDyA8I=;
        b=VEUhgqJymTPQswzyuSGMmaiAeYI+7jiRUrgyDpgyZuH5XPd3H8k2PhiSNTFWINHOnX
         tQoBG9zFGbN07fGrfeDeIV/gocSKBx8kXSQNo02HDN4im3zgleIYs2IyU3HNv3UknW2v
         7ZLa7NcuLB1925kqGUY7HP30nmkjPdQ16Qwpbk9UhrguBU2SkZErsnjOnw2lPsLmGB4U
         mHraHqpt+fXmHAjL/gd+pPdKUTfWYjdlkDmZ2sDhSd3ETekH8IvDxFPtTRVkpeKb3skD
         xSaOXeJ8oW4flEqHu81pXCPs0GM1A2i5ohngd0eB5kqHE0oaFuUQkHiLbTOFj0JpQDsP
         xDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807502; x=1718412302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6cOdf9Cu6zqOkqikPzS0/9PNzRSpjAjgooQVzDyA8I=;
        b=wAsV7JDzpFY1PnlniMVy6zoPwHUgdUiTsrGIfabBTJaOziW8sU1lAD9iHvyy8U4ZUi
         xfrYwgPBjBw3bfC7I9n9Cwfx0BSGMMsgDmNTXTBX86ByK51kCoK8u3vx7B5Pf1dMVqOO
         VoXI8m2u7In97i/yh1HRV6H4On9k2W9i42U6cNtwhK9NWd3SZlAvIIiXp6ZM7YbUjtOM
         H5l/ugqeIrbLRUxdEsZJMsMR6dJOc8mGdwZ8eCoj5cY+QhJbwU/HXbplhDo4fn5XoCv5
         XMOsk5o0nvkjhf6G5E2CxML/0+Z/EvcYP8AFWyARYr2C/u36M/jy+MAFLXoXKPht4TmW
         PRTA==
X-Gm-Message-State: AOJu0YxKtmeHhRAMncanhOoY2B0CENUJGL8t1vvlJR8F2xgugT+7wCOd
	+Kazk+7ZjpHXWZ5G5SY+EDBQvVQol/VwyEMy93zqSLZR80ur3BpKwDH9vA==
X-Google-Smtp-Source: AGHT+IF2FcNHxKcsxcwylXZrA3UH1vxAjMnC7YE29LOVKhqLFSfQeqbH+2hWiq+riAboOqyCJd+39w==
X-Received: by 2002:a05:6a00:1791:b0:702:3183:2ae1 with SMTP id d2e1a72fcca58-7040c73ef2cmr3866932b3a.27.1717807501547;
        Fri, 07 Jun 2024 17:45:01 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:81a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041f06b6a0sm554077b3a.127.2024.06.07.17.45.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jun 2024 17:45:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next 3/4] bpf: Support can_loop/cond_break on big endian
Date: Fri,  7 Jun 2024 17:44:45 -0700
Message-Id: <20240608004446.54199-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add big endian support for can_loop/cond_break macros.

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


