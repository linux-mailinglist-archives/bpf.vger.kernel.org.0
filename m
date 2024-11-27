Return-Path: <bpf+bounces-45760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC399DAED9
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE941663EA
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84D204089;
	Wed, 27 Nov 2024 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDheEDZF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA620370C
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742437; cv=none; b=MOARoxiSp1eVOmZzHDF3mPj0Uw8gjVgjZCMqvynBixKFujSce0jSNbUniqZlrQm4djver7MfdLisNjrxrzfBsAOhQYKBYHv2skP4EtsbVPBbZ2qk3sOWGy4XiVV9adZcQpQvc+l3DR6KutDrkPGWQBcIAgkny7nf4ZoZ4/oVmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742437; c=relaxed/simple;
	bh=oY9jsAUPseSd/D6SXyUwXnVl6VJEJJcEJYNkyUDDctw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5lVCe0x7SCIs+af3UvugMm8qhbNIIs0v55lZYlAIlUOn+SlDRtafJI2fYk/GlrlYYKCLNbqlBeiM9jI8bljRX2a+K/fBz5FTBaKC8IP3jCyIuy299+v85Bbs4fRJtC/6b7xwWZk1jq1Ru599lrGuQ8wlFPq14I0DVl9SQwwJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDheEDZF; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434ab114753so1002045e9.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732742433; x=1733347233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ka14TJBEqHtaUHC2SF4/1fJOLh8nxaeNftD7cY8iv4=;
        b=eDheEDZFzv3GjPPNG12MLjYLrhQHSJI+JlQNT1VlmfpGs0vcB8uORHog2zgIZB6PkI
         Vw5/Pv9477LPwyfxMeCzWjCI5BxWMPoxXT25zSHBYaDAdZli/0W4w8Ms9BskCOxetC7M
         pfgZwE3LzEU78CNqHLJs4X3oZcHXL6GawqCTjVUDXrcHrRTYyHl10FzG+L9HvejhSm/b
         OftlUtPvkfjfoiifSC8jnWO3n3f1aE3Ml+LVOTFItDaiLZ3dTKi3FjvAjsvgsblcN5lQ
         X4OXQTc1MmXCy0yZRtYqjYeDTdpF83BZdZ6gCs+JrI+ehcNeO1ZUWgKpqyxcC++SyEJ4
         lXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742433; x=1733347233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ka14TJBEqHtaUHC2SF4/1fJOLh8nxaeNftD7cY8iv4=;
        b=VTMbDkJ4KgFw7uU0KCp2ZfUbGb+MC74ztFYukWlCTgIiNMunDuGtx6A4hywHpCBAeb
         aGv2mS4oDbYyrpczJsLGSfK7r9piWXvaHbMdv9VrYlSUmDD+zM64sLkSG5iIbGGldVf6
         hPEhIOT0N+8yKiDrErkcRb2FxA7NElF6jsPFh0VK1A1+jQVcxWE2mdLTciUZOPVfAjKy
         3M60UCiEPh2wSRkwQhiJdldUrP61oMB1cG8qpjOpbwkiXaeaCpJCG11mj6rBiW8Kabik
         B7c4RJyneyDCCszmUC59pePSRVQFQkbQ19fSb1tuil+GQKNdTc2DR176vr28bJQfQ8bJ
         iwTA==
X-Gm-Message-State: AOJu0Yycc63LsWW5PUlXYOnCNXNzA7gjD16PzOS5To5y/lroRzWnhhNo
	HRNXXHpIOSvBXYqXK3T8YEUcMVfplE7+uOhBEHxxI4qPprrlwCw4lXnl66q+s30=
X-Gm-Gg: ASbGncu1vjVx5yCp7vcllsBmpw+Ua8gPYhkLC1C3pYe2u2rhJP/m7Kh9JazoXCQvYIH
	z+ZG8kTKt5u4i8rGGW8ex/HWwuSX5WhCsert0G+Wgg7lm4lB4rphvuM0UlKUWZv+RDPUH21j7Li
	oOk4lWZV9VOW8TuiWw++dUDE1EpkQ+oCs07y9bE60N6GiW8Z3oF4rlqOYswqycR1l+CG3v/in0y
	tVgZlN7pPUVZtP74bUA1bUpLE0PHtcjuxOqXrbDKC2WI8GgXEgtoiUU4prNv7wuFHRo2L8Q99Vt
X-Google-Smtp-Source: AGHT+IH6YFaDsaRqvBuYwyYPfmtXSo0PhV6iRfH23j82Z694KUbZmMNw4a8NjlVEhlKeyfjBTOvWsw==
X-Received: by 2002:a05:600c:4f49:b0:431:52a3:d9d9 with SMTP id 5b1f17b1804b1-434a9d4fa7dmr46247355e9.0.1732742433001;
        Wed, 27 Nov 2024 13:20:33 -0800 (PST)
Received: from localhost (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbfa2csm939665e9.17.2024.11.27.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:20:32 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add test for narrow spill into 64-bit spilled scalar
Date: Wed, 27 Nov 2024 13:20:26 -0800
Message-ID: <20241127212026.3580542-5-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127212026.3580542-1-memxor@gmail.com>
References: <20241127212026.3580542-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; h=from:subject; bh=oY9jsAUPseSd/D6SXyUwXnVl6VJEJJcEJYNkyUDDctw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR40BDYRUFMIiEq4/rSyy8yQvc6YxVZGPDBJthLa9 u4NlexCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eNAQAKCRBM4MiGSL8RysyTEA CXA88KbvQ4CdRe3nZBkGWTJtD0OxYRPA8655hSFsx/6FUazQLKSULUELJU6frFbLbMDZ1Q/5JVO/YH Vh4XLU5iITLnT7ZiYKnowb2K2ozonUzeILB4vi3d4uRzUySIGYrnQlw4cbAyomcbZRN48FOPRu3+OW TeCYOC/xknY3DyX737QmfBgTijYSPHqShEfxR4DSHz++7M+VqhKZyaYz0ckqXMXVVLsdbY/IVB60EH 9WIU+Ls1ejuL3fzJ1hHkxDnmMkK1OvO+fUVHAgFZxV7fG/pVUywILfdia5C0Kyo5th4qCGNWz9aC47 HjYALspOqxGEdzw9QufEr0clCyyT8hockfpisags8wScbUsC2XTHis06JGC7YYZJw+VwFDTZ6wcD10 TaTvHXEC+PLNA4Vx5mtm5e5CUoN93yXCdbGvnI+5d6dsm8hbR0KGZOVgJJ3ymb0xM2U43wLmavzG91 l/ZlA3rovwyNDM4ZFYHderIzVxBEG3lj9X9PLbNvoYn0A0/GwViLuzq3eaPWGdMLc1aLV1qghC3GjF 7FP/2d89g+jxGIjZdZ/XPgK63GkqtzsZHthVq3+FH/dPlaAOmoOj6FnZJd2hpMukQOcUGCLtzViHEJ PYWpVUB6sGGpgGvD+N1wmRXa9qE6sVOn94/mso6TgI84w5m8aWsBwFcJM60A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a test case to verify that without CAP_PERFMON, the test now
succeeds instead of failing due to a verification error.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_stack_noperfmon.c          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c b/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
index 52da836d47a6..787e01ef477a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
@@ -19,3 +19,18 @@ __naked void stack_noperfmon_rejecte_invalid_read(void)
 	exit;						\
 "	::: __clobber_all);
 }
+
+SEC("socket")
+__description("stack_noperfmon: narrow spill onto 64-bit scalar spilled slots")
+__success
+__naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
+{
+	asm volatile("					\
+	r0 = 0;						\
+	*(u64 *)(r10 - 8) = r0;				\
+	*(u32 *)(r10 - 8) = r0;				\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
-- 
2.43.5


