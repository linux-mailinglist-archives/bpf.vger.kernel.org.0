Return-Path: <bpf+bounces-55662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634EEA8471B
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7E44A6BA5
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE728EA4D;
	Thu, 10 Apr 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baLKlXrw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C314F9D6
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296922; cv=none; b=K1ADgCbqXSZjHlegaJSKmM1xWT2HBK94q0Ti6WEuJF4t3A7T+AW8++5NntiCkmC1+iGKA2D9jB+hXVEvvHegpp8OS1ls7k0zIj5JYuHCA2VfaEnt4PzevV1mV+uMZHRU9Fly2cuVDLCOYRxe3kov2LKHNa4yoWeMYmbLqTG+2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296922; c=relaxed/simple;
	bh=hmoJjXU7D/59AUWk9B2Ey6kH7kkheqn+KejcVNEUnxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWbM5EKGYydoCR/9qv1No8hiBGGP8VDS+oqjBcJXgu7AAzJgFWLuur6uzVnzpzGW9XyWMWQOHen9l7WtMzCfLZM/VtoqVXWxmJZH1Y5xTI4jkbq4XY+nJ/MjEYCUony88Ubj9PC3NxdS0lZ2GpIJqaFmF9Fod4aB5Ks4Yq74UN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baLKlXrw; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39c2688619bso547018f8f.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744296917; x=1744901717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8nU6F/O9pk2Ml1KvUpatFBvafF8j6XKOTJI0jsGIJo=;
        b=baLKlXrwZqU25/bVg9vzE3mn5SvBvetie8FOzCjB0LTUa6M10xuaZW2zfU248ndt7N
         kaieogN/2E2DuGqdcprBhs17pwfHjleF1B1XI3xTGvOcQp2wxLKpigf08JnP1ag/ergE
         jb/jL283AkNsZWKruTjKh+OLYWlvvPZQ1rDXe0UW0Qa/RHPXGTdurEd1jg3dM1Bhyjhg
         /zryZrs/7U3lUXmt3j9CnW4pzeG+2ub4f3aP7Lop7WOrNqtFY9guq4KnMBvojtfx6uVw
         HKWuNimzwTvCG6S/Yb/Nid+AFbrhs/GlAL3lm1/GUD4hywjz5CUXTBXZvQIBKcmB3nAZ
         KW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744296917; x=1744901717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8nU6F/O9pk2Ml1KvUpatFBvafF8j6XKOTJI0jsGIJo=;
        b=ZKyRPo1/cg4r6PTYaU59QYe+633islFSph0dVTAUh+sK9Qmmk2Q16C6IiFt7FVU96q
         ZwYQkar1Zv0vk9Jl+04aGujDg8hqJPOMLK/qFuZCPidJrRuIhp8j73A7OdXudyI0w3ox
         HLKt3rERQ92bxPsrXQX36MjKGXKOvzPO7gfbfRtqVKEhEoCrqUb/1RxvMlphXcGIZqy1
         bXgP68glQSnUCB9Rc+1yJcKCJGK4ju3JgLp2VPQzr5Ecb6qnetHH98HARn3CU4u9qbf2
         SxZVXbDOoVS8v6GTN4jpcb3m1ivWYK4e4RLQoyFVGxltAdTX0rhNajAiyfdRmz46D95t
         8ANg==
X-Gm-Message-State: AOJu0Ywds3dZYePRulrcmAedg1/hNvT3ZWWEbHNQfB9aLvYiTcBZRyzD
	dl5+vqafy83yNOZEGBxQotiF41ccP8WMGKQlzoTUX5Ah07KbeplL+Q9mrBH9Ks4=
X-Gm-Gg: ASbGncsNK1YZThPIGAjFsA6vdCkCHdwWy4l7vV2cVN4pgD8JxpR0+lmIbEAB1D0xkqg
	kg1h8MmwAEpkr89q+3MESWmWb26ZY8ym8l7JuTquRQ33uYwXLWWt6eCO58xrmdYFuJVzYMin9r9
	arLjn044et+QV6wEg5liMilL9Zxsvka9+mQ7XxpHjICAa2LhJxRt2dmxtW0WwqPB0k9kx9Gn/lY
	g1yCdjKWXw7+NxK/7aeytcTUFVQdxNagOf3dHmte+EWGMPW/gbC0IaSLDAeH6WBB7EfwlfwJMrj
	I73XZS82aMKGOCji89v9WoOsqX9iW+ehmvEKa/z7yA==
X-Google-Smtp-Source: AGHT+IH2K0jIHosh9oCXB2/nZdWpuZv/sgcJ7vFDdTe4dV66vI+Nn53fCMmKXJ2Z8cgxuNxKizu6ZA==
X-Received: by 2002:a5d:5888:0:b0:39d:724f:a8bf with SMTP id ffacd0b85a97d-39d8f275e77mr2064852f8f.4.1744296916396;
        Thu, 10 Apr 2025 07:55:16 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8940012asm5023718f8f.94.2025.04.10.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 07:55:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] bpf: Use architecture provided res_smp_cond_load_acquire
Date: Thu, 10 Apr 2025 07:55:12 -0700
Message-ID: <20250410145512.1876745-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; h=from:subject; bh=q14YDwmfcou4rwUmystGuYR82T9Dm2DF0VUjMbI0f0Y=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn96i+RNXh4slWpCFXLMiIArZE21r2HVHaIBlqm/Ib 36CawqGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/eovgAKCRBM4MiGSL8RytMYEA CMAfdxp58j6x/Kl57RDshYezjZO3Iedxo8LlE25tMs4wLeaNbg7ZpxpoJ9yvE8N9Nzl742hsyvF5Tg vsoOgdgX3ni2ze1wAGsfWm1dSnERcl0KQTbnKH/SfmorHPCxBpnwaEUY0fPeb3+eVx9gTXOahmBbQd FwlNyoVcmKlUylIxpNNe36kuHuPI4uK3NpBCIbgssA5nU4h/UIjHzQs7PZvsHPdJEx52Yoacl/rWWo W2VJZgTEaxFObreFDdijYIkrgipeOl/Lb5duSFtfP//Dn7sJUGE8ZNi/zUFuz5hepilSloJkIb4jfF yGDfV7ZY9Dpocz33qCk1/GxRkcoln6qZ/5eWwsRGFp/79mzcFmtQ/PHnlYI+H7e2yMK5e1w3aZjrOa w2qSSR4ZUSCfYnGaNl8WsB95b1Q/zXixOSmCD4JhcDRIUXNbr7f8BrEmOz29ftKM5kKdIWRyeLuZTJ xkLyI1ZqWmIA8H1gig+fyANpG8O+3FmtpcxibZK4zewnXlGf1gEz/qKT6HLGKMt2dgVgRvrbOxhcXR kgZK2lmrteylY4dm/Z/gLVHeoeq90rtF30rRgunmeKD6wXMhmWAQKIMyGuamEqoc2Ob5c6RHdJHePw WTf2qxl04WtN+6xX+dJc1qN/Vq00AIoCQEyEcirOMbgFBtNcEWyqt5ODlhWw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

In v2 of rqspinlock [0], we fixed potential problems with WFE usage in
arm64 to fallback to a version copied from Ankur's series [1]. This
logic was moved into arch-specific headers in v3 [2].

However, we missed using the arch-provided res_smp_cond_load_acquire
in commit ebababcd0372 ("rqspinlock: Hardcode cond_acquire loops for arm64")
due to a rebasing mistake between v2 and v3 of the rqspinlock series.
Fix the typo to fallback to the arm64 definition as we did in v2.

  [0]: https://lore.kernel.org/bpf/20250206105435.2159977-18-memxor@gmail.com
  [1]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
  [2]: https://lore.kernel.org/bpf/20250303152305.3195648-9-memxor@gmail.com

Fixes: ebababcd0372 ("rqspinlock: Hardcode cond_acquire loops for arm64")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/include/asm/rqspinlock.h | 2 +-
 kernel/bpf/rqspinlock.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 5b80785324b6..9ea0a74e5892 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -86,7 +86,7 @@

 #endif

-#define res_smp_cond_load_acquire_timewait(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
+#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)

 #include <asm-generic/rqspinlock.h>

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index b896c4a75a5c..338305c8852c 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -253,7 +253,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	})
 #else
 #define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout(&(ts)); })
+	({ (ret) = check_timeout((lock), (mask), &(ts)); })
 #endif

 /*
--
2.47.1


