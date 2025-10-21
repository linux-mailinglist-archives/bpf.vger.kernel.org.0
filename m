Return-Path: <bpf+bounces-71624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD38BF8804
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF9744FA475
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840FF275844;
	Tue, 21 Oct 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUdBazNV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E823D7E8
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077025; cv=none; b=emoaFL5yzgsWjnGMv5amU8jlAiYj09D8mCseEwXIWa+GQlRZSfckj/38LBZ/DD2swe7D9nfojVFBtDGoJxXGDCVPHkadTVw93zxZcCClG6d5aqux575+AsbMJCIW3LA0JkAL4OJI1UUYeWMFjEykaci9+CsM/59hxGAoRLUkyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077025; c=relaxed/simple;
	bh=S7wR7aZg7Tjl3o7Oqf0exsC+eBwpfOYtGuNSbYyxGDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbBJ27UzgrfSBo2jOsu8I7GjRgpkfRWPk6E3p87XFaY0p2SlEjYWaejIxSreNax1X1I0m8H3oXb0LP0kBcd1O36MMV9RqUE1GKdNLCjE4Zczf5LaUgPKfvkKwiuitCEIUUdJLDDGumucpkN0pXTZYe6cFliaTNyN18+9baHe+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUdBazNV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47118259fd8so37562975e9.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077022; x=1761681822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=879X/wWgmNgdWJ+TiOg8p7qqMzA9yE+P722ipbE+i44=;
        b=nUdBazNVN0Ctf0SvwKRCw0Eth3JcATLSFIBLjjbQbqloUhGtgWZ7v8XAplxApiBzNL
         GURWTfje+2g8/9p+drF2dfLsEan1wI4kaeCFvW14265EBUvK4L6cfuS3YP1/eRGkUR1B
         q1G90HTOdOUo5u3FkSutqWzEZoK1QqMF3O9aVaDBbyMs/VsYXRbjFEVfOLnJuPS4rueN
         pJGMk1cFygWV7rAbVIVL+x0hBX3yzNziJDsf3iXbZfUNwMWZwv2O2ge/Q2vMuhw4zyGl
         f+e07tfL4+GZco1NgRZ1r+p2OQqroP7vzRVRWigOzGzreMeZeapczGZ3KP4SO4NwaUbx
         f5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077022; x=1761681822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=879X/wWgmNgdWJ+TiOg8p7qqMzA9yE+P722ipbE+i44=;
        b=S4ye8h1rzkStJbUmdEd7a8O+md90szHnPhWnqF5zjr0sM7yxsqQ94Bvle/4FuZsHI2
         ooPfXmGv/WHJmwNtRACSNhOT6/Ea1PtlN40NmHPomvynOjD2hdZoHI4d2YJkHmgweP79
         SRwmE03o5cNqErzE1K1oEqEmolSxsz+kkyW65U+LlWUgyA1b7kB8VSxgVNmSgD2Iq43S
         0WrdfuOGyfws5s2Wr688yoxl8sS3chdD6PfOWXNlNpFt5RAorc7GcTNq4vEASafukwCr
         kd5f4eWcoZJLXDWpBIMRyslws+uzmrZDRjpBRlTKHIM3BlmKK6nOpxIMRdX2TNEKIoZs
         Bhsg==
X-Gm-Message-State: AOJu0YzWc1000cJI8jyrZi2P03D+0sfJQf9fFxLpqdpAqeGbCL1HLijq
	vR5Z25qY33tluXGWL5AMFGslHXWqGIER1xMvI492gokoKXu/6hFQKzpxi1wtIw==
X-Gm-Gg: ASbGnctr/Oml+d/y5qEBwla0br0nfLGvweml3XF/S/bhChukJnpvESEx7KeTPxZZlHb
	LI/TuD/wz4nNMB13w2KpKySstqm+hp5nT46Bxlqy0GJaj47/O9QZKXbjoF9yVj7n+rWuLh5hRFE
	f9NQfHVp8uMzTruCPh42qf+qUeOi7xN1eaGps+OFaLQKWVYzt90LV9pz+ERizjGTe1oovs4VdnG
	t7k26JDH03Wn/ylV/UorXUtyk9kvkCuvLkH+gSVQk266XtlHtldzmFNnYiXd4XHDkk0cU27Q6l5
	2nl+5ScIyC2owvj7tHrbpr/I/YcgSUQ1kr9dmXy4UTTI5Nx+GFiyfZsEMZrAWfwW5c1CYT8Brvm
	2+Ln1xnEqbpRlnnwitZyCdb9/TP8TAQs2qyF+D/FUMOfIFJYD4TSTUq313svqo14LTffclIA=
X-Google-Smtp-Source: AGHT+IFulm2+9Gza+pWvjhKKxSYUZptcEx8qIDXgv+Wz8mFMbU1OX8e8eMxc3GQHOcRAuwSYfu9cEQ==
X-Received: by 2002:a05:600c:3b04:b0:471:350:f7b8 with SMTP id 5b1f17b1804b1-471179017damr121739705e9.20.1761077021515;
        Tue, 21 Oct 2025 13:03:41 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3e2sm21708108f8f.47.2025.10.21.13.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 01/10] selftests/bpf: remove unnecessary kfunc prototypes
Date: Tue, 21 Oct 2025 21:03:25 +0100
Message-ID: <20251021200334.220542-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
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


