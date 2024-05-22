Return-Path: <bpf+bounces-30250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43F38CB854
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E39C282886
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC76D15DBBB;
	Wed, 22 May 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIMg1EtA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEC15D5AD
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339765; cv=none; b=fUFyNiYoljN92NvngdkjGz3DMhnpbDZ1zLMo8fAdfqmUXglkZlQ2QKs2WJ4Sllw/jR0GnUZsuUUohkk27lugSIkb03CCMlPlmwlfUF36mZe98i6LZl6VWZ1FPQ3QMiB8pFSN1mlH2/4/25eXagGCEEpOF7ZUyqAZoNoF5taKVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339765; c=relaxed/simple;
	bh=6W30WIKhE96pwmtcuV2NfxhpFW0veZZZU83PwcF+fM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XA0ZcFYmR8OERQcJ4WqowX5sVCJO2dGlVoVFmGts18B9MogHX38RJZ1AoirLZccm4Yttk84x5rcCVwncmJLjvgbwJi0lb8OuKEN0xjUeJrgJ7kYcJF9xcfR+fcHBKvOKbD3FQ0f9IpkHX+/11nuA933T6jnGvockjoIwebGC8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIMg1EtA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f44ff14c17so7314356b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339763; x=1716944563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDddXI/rz5Uh/0hxgnIVyZ6+81rNdMnfIsgCLtRcH+A=;
        b=PIMg1EtATWDnwfr31/oDxOZL4KodTbq3ps6C5BR2hXeKBEGJSNlZyIe2/ibUBHWliB
         N0fu43mmrb1weOkXFLzXFH/ovQYis5dnzc505OxAOhfmlKmdov3tbRjnX7dCr5zatrNH
         dy3g8gYqiW/SlazGKNy2TtKZ68s/pK0ZBh3ucTAeYedjvUehxCpyu84WtjCcgfTcno+J
         zm/IHKFiXZqedKEd046owtFolCwdCNz3+u2lW4pkp+Bxm+Co3s/R79oIV9RPluVwLzFe
         OyOqs9NeYYV0XXZc7OZuFy/JPk8WKUVkIHy4dPiHrH4aun02GYwJuxCKyLgx37elfU7B
         hrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339763; x=1716944563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDddXI/rz5Uh/0hxgnIVyZ6+81rNdMnfIsgCLtRcH+A=;
        b=ovKZg5nkoNgcMVmpqPxXwNFyOmcwowAdFU4oR7ccHeMmfdl5d8sfFWjDo1GdQgtFeJ
         mM2CeTrZOcmLz3bGm4yv8VcNx+n9MvhsZN+mk3B1yx/oJufKgjOxT1vDc/wEd8MQZXvl
         s48T6Yf+KlW8CzITYuYviNvLBcc9skULlIwIpcHzcqJyS65Op5EDBHVc4OyZHU5uuXgu
         T2A7saJpgv20O19tDKCpH4WfeYKsu5FPJJhijYuDhLiEAP0rbixUvGAKXs3Vo2zN/Xdi
         LDlFGBhtDKt1oy3eqUb/4FLtgRtDdwt/rz0BOxP2j/N3HrdatWXvE9M09MBQB73eLzvg
         oLXg==
X-Forwarded-Encrypted: i=1; AJvYcCURwDs3QH//WvJ2XTG7bKf3FCB4ufNbzZx+3OTM4nZZW0my9A8DxcLsTFa8L8qfjGQlTs2l3Z/BoWi4DHmrGuhlJJlh
X-Gm-Message-State: AOJu0Yx37RV+SFuNZ+DVrllnlGLXlifqNpF/fNAGODbhpHkQ+Kz555Nj
	xqKEt5KNHKgRpIED/9VTQFQAqWbLs/b6ZVicT/YcfyMoSX7/mE/fX17WIHPqa56vEYNq/jNFJQl
	hFw==
X-Google-Smtp-Source: AGHT+IH8wpGwaawCict9Ep4Ub644GN8fYtHlm1t7v7pZuightlDMU0GhBoDAJQNtreKGztGUsjMmh0JORdc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3a18:b0:6f4:133:f5a5 with SMTP id
 d2e1a72fcca58-6f6d645c526mr21783b3a.4.1716339763429; Tue, 21 May 2024
 18:02:43 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:53 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-68-edliaw@google.com>
Subject: [PATCH v5 67/68] selftests/x86: Append to CFLAGS in Makefile
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Instead of overwriting the CFLAGS that is imported from lib.mk, append
to it instead.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0b872c0a42d2..3395a5d114c2 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -35,7 +35,7 @@ BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
-CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
+CFLAGS += -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
 
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
-- 
2.45.1.288.g0e0cd299f1-goog


