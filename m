Return-Path: <bpf+bounces-53289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5CA4F631
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 05:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68AFF7A38EA
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 04:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728731C84B2;
	Wed,  5 Mar 2025 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGCESyXs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58455193062
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741150308; cv=none; b=QpIRYl4r9Iv87lAZBMfsnaE0ZQ6P7jkCFvDaG5JHO69Hga4OTzbimH+S54Y6xomxjBDFopD2RRqh7xQKTT7sfuAB9UehRs189E7s/skr2HF0V2ag7f05JIh38NXkuedGuRRikHA+OkYeTLQTkPrlV4lQaT6xmzbBEELRAcWNeKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741150308; c=relaxed/simple;
	bh=7wLAt7O8W74x95cBoOOBhxEA4GSGkeqLTG2jdVQE1ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY2mcUob2wS/Nzyw50Xk/TCYZhQVvSGdf7VIWgRl2nHW+JaicygS5Tdx0f8YV0ALTLVWZ6GJ4L+7PoP91wXqJr+9Q3PO/AR5sKaGu2Ot2GC7HZA0fHbyQQIYSlgJLFasZbBYPqFUIHqneitNZJJnnifRlr48PcewTgCcUbvS2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGCESyXs; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so17147225e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 20:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741150304; x=1741755104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpbEdVMPpfdOJ9ldOmfW/MnEw0rgThHsWUYVOYyHCYQ=;
        b=dGCESyXsEfPdIsAycGzI9E1ErwcKOY6dnUTmovOyGG8Mg2UHwklNybstS24t5Z69mg
         3teDxCVA289K5g9rWFwuAY4NrGG2CJ3slO7aYzteRlb0+2H9mcK/Na9v8al4rz+c+v6w
         6xrqij3QmFiV3WMPJ/kpWNN0DePlWs2aWEBzPiwhITd9JrDP7TEGoCmytk8XeWdT84yJ
         hFr9aoMSKuIhSiGCRxoDQ4odZFlsmO0Xbwnc2mKkW/iSg+waVzfO9OyTdfrDfgpXAQlB
         +MJDm3TE1KxwwV2wO/Vnv5i+MeNqMbIlz6PRMAT1b/eq1CUYoCFlR+R/65TNOlkVcb2B
         +0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741150304; x=1741755104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpbEdVMPpfdOJ9ldOmfW/MnEw0rgThHsWUYVOYyHCYQ=;
        b=scdmQ1QhP/I5G31vVk4k/Z6uZvjjvEhmaxapOqD9Xz5XVJW/sB5+0UHAWDZUnwH0ay
         kUAgj+EiGfmOVCI7/9zRoDSq3waQjWNidvKDYR2V3eDwFv4/AOO1a/ie52kjDyn8ZWqn
         U4LCFCPo5MfuHr97gz4h0Zt9kkwqI/IK0Afdm7GAqLNDy2SC7ZetCv9pxjBUOBR4vfiy
         694fG4io37hAO7XU/XKL72irNq8wJz+OkxM26OrCFPc5OOYcg9pEeh3VskwUB0zcd7kA
         cKmgjRTQ3qsNyAfaSbyVkGI6kmHqdnvctVtwxaR6ckOsx3SpA9XFYdw8kKUWgg86PrXp
         txEg==
X-Gm-Message-State: AOJu0YxGqrARQPyMw9q4k5Q5J468K27CPmgnD/cgrkBIQh2sAE7De+MW
	ZVVpThV/1yMmw+M5KS2Cb1hplVojlDSxEv2CG/3CxXRfwspul4o+UEU7N/sSkb8=
X-Gm-Gg: ASbGncv83/+QhmlEZecu8SQ25kbKmDigDTNecdjCudbo99N1I6zeXujoXGaSGBzw1wz
	n2bVa/dNuauyAmCB3mgjszquNqEjf2ojLDBnzXj8pRVWAlVbG3MvtD9tR5XU6LZjjeYcqInlhoG
	OdYZn9QPC3W53LcmneEfhRADMEwPdYJkxHmta0PaT8KQnTjkSddQFE7wbAJvI+TBYrKSpL/18L+
	7X0vOkIag7MSmwRqAlqVmt3YxOJgn5mjPsk8Kxjmq8CyC+5wG973KfX+q/jtvnSSmSEyHUiOJwZ
	yzSf8qmTY15yv4wW5X7koTKqxje4Gmk=
X-Google-Smtp-Source: AGHT+IEZsOW/yNLk0NzVOH30Jj4Wyrtwx9hUgEEdvPvlJYToByAb7ZIPc0CGMLL5lueOQI7EKoFAxQ==
X-Received: by 2002:a05:600d:12:b0:43b:d531:ca9a with SMTP id 5b1f17b1804b1-43bd531cec7mr2055665e9.31.1741150303944;
        Tue, 04 Mar 2025 20:51:43 -0800 (PST)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426c56esm5827775e9.8.2025.03.04.20.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:51:43 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce cond_break_label
Date: Tue,  4 Mar 2025 20:51:34 -0800
Message-ID: <20250305045136.2614132-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305045136.2614132-1-memxor@gmail.com>
References: <20250305045136.2614132-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; h=from:subject; bh=7wLAt7O8W74x95cBoOOBhxEA4GSGkeqLTG2jdVQE1ls=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnx9WgvBTMFEOe3foCY/HEA3Xje5VIYhs2yIBBnE2Y Cyn6jTOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8fVoAAKCRBM4MiGSL8Ryv2wD/ 9Xuzpky8d8ITM2BBlOvPkEoXeRGfmaHOO+5nza8vedUCtjydIvc5va6CqE0DKUiDST2wARSeFzZRWY D5uBGE7BITKj9/6rmQoYelNjD5RFxnsT68+huLvvfPVOOvSxYGeZUoP5dlT1K2Vh9dIBKdYMn3zal6 VrpXhC93p/huKEHQcs9UnkC2HZsoly0m0jxcP/pjQ8eu3YyMRPrITQ+JBMxlnsx+SQET0+WxxsmWNK yhEMizORDa4v8C1FEB69rfFR1WtIMQFMy0h8jwSO9Uv5MXNKvubuueDJUM0TcUo2pQRZrQtjKwx4K/ BBK9kxuuz8/NvztXlxTudeQ+vK6Jp0D6IwftkjnNBDQAHk/DWuk8K83LFVwEp5sR8jPeTIHDFBT7BT XBsNJpGAfwAkLhlztooVaLxfp2bP+JL4ePIi3YXOvsd/7YJEc4T0nSWtMi5SDhuVAKJAuunEfzTpA5 uXoB8Byk+4RJPSkaBPGhGiqGNfacOhnNn9fG4YhK9ZZIAjyxoTifeFQHp6tI4PDOCOUFhIqPWOdGQ1 oFaO+OzAPLFud2QhgeYskjMaDkm9ixJn5kjyivmW6fKEF+frJoVdLUki1nqgTs4xH1pcglEP9OqSoM IhvlF3fG44uV2klIh10nKqKbrP0EE5UNlRGP3CrJRHSzShtg3JnJ9IKfCnBg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a new cond_break_label macro that jumps to the specified label when
the cond_break termination check fires, and allows us to better handle
the uncontrolled termination of the loop.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index cd8ecd39c3f3..6535c8ae3c46 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -368,12 +368,12 @@ l_true:												\
 	ret;						\
 	})
 
-#define cond_break					\
+#define __cond_break(expr)				\
 	({ __label__ l_break, l_continue;		\
 	asm volatile goto("may_goto %l[l_break]"	\
 		      :::: l_break);			\
 	goto l_continue;				\
-	l_break: break;					\
+	l_break: expr;					\
 	l_continue:;					\
 	})
 #else
@@ -392,7 +392,7 @@ l_true:												\
 	ret;						\
 	})
 
-#define cond_break					\
+#define __cond_break(expr)				\
 	({ __label__ l_break, l_continue;		\
 	asm volatile goto("1:.byte 0xe5;		\
 		      .byte 0;				\
@@ -400,7 +400,7 @@ l_true:												\
 		      .short 0"				\
 		      :::: l_break);			\
 	goto l_continue;				\
-	l_break: break;					\
+	l_break: expr;					\
 	l_continue:;					\
 	})
 #else
@@ -418,7 +418,7 @@ l_true:												\
 	ret;						\
 	})
 
-#define cond_break					\
+#define __cond_break(expr)				\
 	({ __label__ l_break, l_continue;		\
 	asm volatile goto("1:.byte 0xe5;		\
 		      .byte 0;				\
@@ -426,12 +426,15 @@ l_true:												\
 		      .short 0"				\
 		      :::: l_break);			\
 	goto l_continue;				\
-	l_break: break;					\
+	l_break: expr;					\
 	l_continue:;					\
 	})
 #endif
 #endif
 
+#define cond_break __cond_break(break)
+#define cond_break_label(label) __cond_break(goto label)
+
 #ifndef bpf_nop_mov
 #define bpf_nop_mov(var) \
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
-- 
2.47.1


