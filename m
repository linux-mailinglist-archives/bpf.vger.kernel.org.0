Return-Path: <bpf+bounces-23109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D125C86DA45
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 04:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1464D28709A
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 03:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD75026A;
	Fri,  1 Mar 2024 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBR4xWkx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119684D9FF
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264277; cv=none; b=qmz9v9NkmH4FTr5LBCWk3e+alWcJZEJbJj8BQtM8kkO3w5Y0RlFQBi1J8Gc+cg/FPU1i6rRM49NILvexBGDuAtR9OyvbpMa7tiN/81kI3z2Qfv6xmrReJ3ibcXgh6Jk0wl/lXdoTUMryzP2JZdd02niykuGpAUCaBDeP7ClGynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264277; c=relaxed/simple;
	bh=dfXEAHZhy6jdQ4xwmTIA+k+a5jFU6CG/dcqvpa7co3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSvmVyPjY4WKtAnKL8yt+HqJ2euO9AEWlQUqCN3/RnW8p/GnyIYXyOD13dTmzprgGX7AxQzTe6nC+W3gE/j/yPh4uW5R0XaIfl+c5irBSSeoBdo9GibnuXOj2dXvqSh3WZ6o/ceztkFKj0FfmPXN/xxR4ljkfOvsgXQ2n+++W7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBR4xWkx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e55731af5cso1328556b3a.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 19:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709264275; x=1709869075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5wx9ymqphzfExBttxLv5GhJT6/NHpgQiyl9aEQxmqQ=;
        b=lBR4xWkx4M2/6TnlaGI6CHQflqsm+5F1IsmhMLnDYkpUVACmVWjBeG0ePivytGmQgG
         kTT6AGb5dsJF/mqNObjTP+nRkOG3/HjZbWHkBno5POSZZZr9yzq+80X8PH6ewz+vhO5M
         bdoM34PITYknEuXLUT+6WWEoN3D5f2cdxzphVGz6hdpiYb2IvqDuZGfLfTs3Y7CLZuzm
         uhhl+nMaymGU5F2CJb8AZCgvc4/fxsRVBhZAw26QS4XqiW2S/SBjqDcjydLd/A7S/wht
         Ec6FewvENe0Ogc6GkR2qNwIJAxokrtMdNmxv83bt8zCwmfXZ8ow/d58V/2vj1fC9PV03
         OLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264275; x=1709869075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5wx9ymqphzfExBttxLv5GhJT6/NHpgQiyl9aEQxmqQ=;
        b=VR5hgAhM1bC4223D8u3mU6lGP+OuzzArm7A+boI07cCavesR/4fUDP34GE8bZ0vyhK
         qK+J0ecXg/r0b+uLcwSyYLFbTGNIPSxbUahngsxSIKhmtH/M9E/esE8QSR8ykPmgC5kh
         sX5DqStZZlzAhclKTh5cmxo5itz6vlD95JYSWrqhelVPLEIekD0ZjIPUqh9X84uBJPXK
         zhCWmfQO/XhW3crKax8Nod80XH027K/Z6w+8sN8PxRnaDnLMccuUjxVg4sJRbHiz1/id
         j4hdBLWTtkzQOXBCTjwcafUE5gZzHTIoqNdHScqviri8VPBn0subiwM066m0dVM3HzLz
         tgSw==
X-Gm-Message-State: AOJu0Yx8SlljxkPB4wZLRA6zeZ0McGQU3wjY/TQ6Oo+yu7z6+uNOS0YI
	NfkDkBiir27RNlFLApfhq/bGctB5Q9SWTGoevx/cVd65z0dfEfAgsj//raKU
X-Google-Smtp-Source: AGHT+IGZGUyRWB6ym8s4mBFHFsfbEzBlPC2PyuV3A2B4tX5A7F6GC87aC+X8xD1qJn8NudlD7sAL1w==
X-Received: by 2002:a05:6a20:428a:b0:1a0:f5e6:110d with SMTP id o10-20020a056a20428a00b001a0f5e6110dmr387618pzj.7.1709264274969;
        Thu, 29 Feb 2024 19:37:54 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id nd16-20020a17090b4cd000b0029b035682d7sm2772584pjb.9.2024.02.29.19.37.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 19:37:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 3/4] bpf: Add cond_break macro
Date: Thu, 29 Feb 2024 19:37:33 -0800
Message-Id: <20240301033734.95939-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Use may_goto instruction to implement cond_break macro.
Ideally the macro should be written as:
  asm volatile goto(".byte 0xe5;
                     .byte 0;
                     .short (%l[l_break] - . - 4) / 8;
                     .long 0;
but LLVM doesn't recognize fixup of 2 byte PC relative yet.
Hence use
  asm volatile goto(".byte 0xe5;
                     .byte 0;
                     .long (%l[l_break] - . - 4) / 8;
                     .short 0;
that produces correct asm on little endian.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 0d749006d107..2d408d8b9b70 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -326,6 +326,18 @@ l_true:												\
        })
 #endif
 
+#define cond_break					\
+	({ __label__ l_break, l_continue;		\
+	 asm volatile goto(".byte 0xe5;			\
+		      .byte 0;				\
+		      .long (%l[l_break] - . - 4) / 8;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: break;					\
+	l_continue:;					\
+	})
+
 #ifndef bpf_nop_mov
 #define bpf_nop_mov(var) \
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
-- 
2.34.1


