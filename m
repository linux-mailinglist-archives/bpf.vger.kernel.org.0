Return-Path: <bpf+bounces-71019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CB3BDF964
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D07E357BCA
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E303375A2;
	Wed, 15 Oct 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5/imdrl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE1D335BCB
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544723; cv=none; b=umNHzTDaqxdx4+ZGZZovbP71YI7LRZdTzmlJIjJw7r/EIGAUUcBQhU/5SdgDAvKDLD2oIwQ7Kc+odmRFj9sNsU15oR6D8x/Tsz6xfBTnT98DoWmUKq6iHgu39ynB0HtQrrHXT27+uibC3QPBXPy+zRfxA+A7DmCmxpgdEunM53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544723; c=relaxed/simple;
	bh=S7wR7aZg7Tjl3o7Oqf0exsC+eBwpfOYtGuNSbYyxGDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX7zHu5N6EF6EM98nUDkHRQQHjI6J2L7Njl6JcZyHinsnHw0hxwiSUj2MXaBCSSS13ndE7MR03ail7KHK9m6bA2fnY73wdF22nh7vrKTZwUOTdauiRwRrFhDozVC+WJiGvAFFXAYnyoMvhVa80aDKVNXUJA05Lz43SlCKIJJ8cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5/imdrl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so43458225e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544719; x=1761149519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=879X/wWgmNgdWJ+TiOg8p7qqMzA9yE+P722ipbE+i44=;
        b=D5/imdrlgv2osdeOZ35IB/R+eV5CkKqWd+lLDEGVPp3ljtDoIdlvswz6vTl8W3FYOb
         MheQzIkHDwbzFVvpj+3wysQhkZlFcjgF1yLcsgwwSxB2EgtJfxdzxQEN/8s8Uq9CRMm6
         3grBk5QM5FBlGfgrRI8cMltiondKQQK2D/giv3ku2oI4GCbMGIz8RAa9l/FbEERGeEoc
         8szW7H2+WvoT+DOw4o//1vwX96GwQUQAUfxvf3H+fuGMfi4sop04dsfJQZtM3KrCR/sn
         Odprue03W++/XdCzbF7INWz6cZ3AJndAd7eVtCLwP/V5uxiEP0UNvO3tpAa4tKSEEBsG
         3kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544719; x=1761149519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=879X/wWgmNgdWJ+TiOg8p7qqMzA9yE+P722ipbE+i44=;
        b=G94VDHsceZPUfgvYZBVEmN4Fsz91+fWp0LPeGr/+qTwWRslp73jsLt1tWTOoBJ0i/2
         iiBltiE/LObB+051Vtk1+wgkdI71J70aouiGplFMD9LAo6NtSe+V3SNqHvOF+eYOHf2b
         UwU2JZqf+I5qWH8QHm6Oeg8Al+RzLYcX+SYrNX4nFqb9Rptc4gniQVyWoJVu426t1zp8
         5yHKsDojJN0SM5egv6sJFKEQ+7lchsn5FAPLECRlxSNUFf1DDMlJKlG7rnUrrbQXb93R
         AR5e3HqYkeA5/lIkJC/SXUaqVNE+JbzZvwWro/Bf+vuUV78jdSGHpsEeGRYP1bnVpJCO
         URRg==
X-Gm-Message-State: AOJu0Yzqzpj8DSDP8dcUEF8wAlOmjK2DK9J5MaUsV4sNUyEsoC9dcmBS
	CWuXdoDRcRlMjITpZcwpWYE0JnwI3nC4tDUyWPz+ewKLzFa2tfHRxg2ybkzQ5w==
X-Gm-Gg: ASbGncvsUHv3oCG/YtuJJ10m7b7nepNUKsnKzvDrHbMXOAEWEgG4X6s4lvOxFEFh59z
	2lrZVNwn/4cFsLYp5Gm2Wo2feWm3g3RBAHfC8yXMzosH2R6otGzE/k3GoFmzV+6QpEcmFUdJNGn
	Ia5sj0XkdJ0GF5U5TsOTh1KpT0PdvQHyV8+nt+nhDGjiWm6C4vuXUN8TAgey1zMewuylWw0QIJh
	Iab4D7DiADI3Ko6acd126pE6kCFtnxUsVFHXn+mePV357hJsspa3qmqE7nC/wR88W86XsVCc8cU
	H9TcwK4UXoaqkhzqJ9fjk5PS9aPhWNWSukJx8ikzIBEUUGNH3GuNncsSy5jI5l3d2X5j2MS/4QX
	qhP3R70QtV+sKBmd+iNA6sROyJHSEyGr5a6yek+CdSQ8L
X-Google-Smtp-Source: AGHT+IFMRqOLD+mNrslaC6kCyRisk3KqM+YTlN+nr2ieVqKlyMbhf21DWYODBO9/J9ReX8qaXA3P6g==
X-Received: by 2002:a05:600c:a4a:b0:471:672:3486 with SMTP id 5b1f17b1804b1-471067234b4mr17859305e9.15.1760544719152;
        Wed, 15 Oct 2025 09:11:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b99fsm310313755e9.3.2025.10.15.09.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:11:58 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [RFC PATCH v2 01/11] selftests/bpf: remove unnecessary kfunc prototypes
Date: Wed, 15 Oct 2025 17:11:45 +0100
Message-ID: <20251015161155.120148-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove unnecessary kfunc prototypes from test programs, these are
provided by vmlinux.h

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/ip_check_defrag.c        | 5 -----
 tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/ip_check_defrag.c b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
index 645b2c9f7867..0e87ad1ebcfa 100644
--- a/tools/testing/selftests/bpf/progs/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
@@ -12,11 +12,6 @@
 #define IP_OFFSET		0x1FFF
 #define NEXTHDR_FRAGMENT	44
 
-extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
-			      struct bpf_dynptr *ptr__uninit) __ksym;
-extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
-			      void *buffer, uint32_t buffer__sz) __ksym;
-
 volatile int shootdowns = 0;
 
 static bool is_frag_v4(struct iphdr *iph)
diff --git a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
index ab9f9f2620ed..e2cbc5bda65e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
@@ -79,11 +79,6 @@ int with_invalid_ctx_access_test5(struct bpf_nf_ctx *ctx)
 	return NF_ACCEPT;
 }
 
-extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
-                               struct bpf_dynptr *ptr__uninit) __ksym;
-extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
-                                   void *buffer, uint32_t buffer__sz) __ksym;
-
 SEC("netfilter")
 __description("netfilter test prog with skb and state read access")
 __success __failure_unpriv
-- 
2.51.0


