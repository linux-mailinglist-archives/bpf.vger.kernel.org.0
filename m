Return-Path: <bpf+bounces-72976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1580AC1E7F8
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 07:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6349189DC96
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 06:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF72D2499;
	Thu, 30 Oct 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0Vljlh0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE723BF91
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804213; cv=none; b=tmQ7IRJrB772m0bbFIOAL4H37xdSG+K8lUxlFg3JsqDHCQhUKuixNEK4OqBym6IpPCfN50ZLt74/kHotO4Fl1ZWKP8Q+pqfCVzFz5NfMWpcOM4fzc6tEPokuklbR36vitoJ1jvFr9GgqbY2l8mlXZAr1RiugQC9e+Uv4GaSsKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804213; c=relaxed/simple;
	bh=uY8PBstVl8AOna1CjFYpDGnZdWH4OsqJouBCNU5dVx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6KiMqdWsJNY0dD2WA1buBg0XgkzfLPSrUod5g9iD2vilQ2lVNhAnrGsOk9/UPoc2WzzvADbUfKP5W2PEg7DOFUV27PoPQymX4aT0QQq8KlGnOQ+beV4t9DFoL0jOcQp7hhlPPlJy7PSS/roE37rC7sf96NoZGP2C2wUBu4fW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0Vljlh0; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso430562a12.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 23:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761804211; x=1762409011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hWunyfOPqPyrT/9j+N72PTU1meMr+xcuMvbrFqo+DIU=;
        b=Z0Vljlh0v/Gc6wrPj1WMfOjr6r6vo5yXdHx/sznzWE75qnYeY4KqA7cdtX9R+yQwIQ
         Vnzu5CbS3ypXv9IobYs8IIzsPSglI1hATfI53v4Eh37YvbJLwscELHa/oBIqOJ0n3qX7
         qmmWQebHXaFAka+UVaz77AhmGjoKdhn01sXvIYc8+Kw3Mzr85IQaUZGgWqG12Hz0dV1M
         K9tnkD2kyUfymzY91uokdudtF7FAPYDKjQPzuTJDzKREABKOCKU57J27NA1l4fP4vYn3
         qtuBuL+X5InOawrgGTtbTLpso9BTnsjzOzL6s62VM3adGy7+cHGG7s4/t9SkpkTxlJwR
         PiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804211; x=1762409011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWunyfOPqPyrT/9j+N72PTU1meMr+xcuMvbrFqo+DIU=;
        b=BrOq6nVvIAeRnocX/YMp6pCn7iZ2xFMHEnuEiQwf5pSJoAJd1NY10yyUZ118GVaJWh
         ERFJdFVozOFFTRdfvEdN2nQI4yimxwX+jSevdVC36bw51hhaHmvkH2aQDJdb+MniyOb2
         +mql7WbJ+tqrbzphnwASOqVreVUQkGRRq+/hBzy6RX6TyCDMFjs/hAL1JJCvYCfTGVcc
         jYkbG55SPRlAfOx2W8hC/GlXmPy08pp7y4gzAw+KcBOXHyV4A1hNsaGaT7d5yDsPZHSF
         vfdZiMATS/UBAqoqgkjrYoyJ+BuT/3Fx0Dc/jHuV0XJ0bBCelmXSN37znJA5+b5Fmtm/
         rT5A==
X-Forwarded-Encrypted: i=1; AJvYcCW4lVgoaicUI+hiIXwaasfMr4Me+QsWTXfYYpvsCsk43GQt0u9XfZ2kzu2BF0CNiRtVu3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMy7ZwhogvwBLmr9xlY6jkqXXWxMydMlrlKlQmZGWxJCnaOizz
	uxkP8zyPJqgZN9gNWm23PoptQ+WvnA5YwqmTWd57p6Awtg1/yTqnPucj
X-Gm-Gg: ASbGncv1oQ93fPfhhAFzgWrQoM/yNFyLV4sM4wZGADrcqPektcQBNeggIrRlzdalTFE
	7O4Qiy8YoYyoj3Hq7LYjey0y5kxZfZPbKItjSz/HE6DAqz+mQaOhz3NSCNWACGlTP/FfpbmsoTA
	PPrwBv7uC5Yr5h+oEAdSO2Fj8DzyPsER2/RX/INaGtbHU5UveorHeckazlbfW9hpd8CSBZBzNJV
	GwdjxrgMbc4CXqFF8HE9B5fGPHaBZYi0+8ye+FEZ+/raSqq9UZ/fmxmdk/fS1S+Ft6A7zBmtoZQ
	oBfV0gBcAFvNli/Q0fEDerEzbIEmMsK22Ay4oEQGGhc3w1mhBr+lhP+lxaVe3CDdshSBSXZxCrq
	7cU6Cc5XkeT+F98FXvxE2+0lL3Lu/pO72BX0sTDLWLy6og8vHrJ9UztDn175YbLqSzmYlgaZUsz
	TJtVAYd6CGjwU37kWn+A==
X-Google-Smtp-Source: AGHT+IFaNi8UKPhzHGI61mtzigpk9LsnKA69RlwPmz6ucy7Dt0QzqkSl5dPcEVVwYWUQEnfME/lUQg==
X-Received: by 2002:a17:903:ad0:b0:269:96db:939 with SMTP id d9443c01a7336-294def33bffmr69639195ad.58.1761804211514;
        Wed, 29 Oct 2025 23:03:31 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42ea7sm171456825ad.101.2025.10.29.23.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:03:30 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools))
Subject: [PATCH v3] libbpf: update the comment to remove the reference to the deprecated interface bpf_program__load().
Date: Thu, 30 Oct 2025 14:03:22 +0800
Message-Id: <20251030060322.1192839-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit be2f2d1680df ("libbpf: Deprecate bpf_program__load() API") marked
bpf_program__load() as deprecated starting with libbpf v0.6. And later
in commit 146bf811f5ac ("libbpf: remove most other deprecated high-level
APIs") actually removed the bpf_program__load() implementation and
related old high-level APIs.

This patch update the comment in bpf_program__set_attach_target() to
remove the reference to the deprecated interface bpf_program__load().

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v2->v3:
Try to fix the CI FAILURE issue by rebasing the local code to the latest
version. The v2 version is here:

https://lore.kernel.org/lkml/20251030041457.1172744-1-jianyungao89@gmail.com/

 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fbe74686c97d..27a07782bd72 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13858,8 +13858,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 		return libbpf_err(-EINVAL);
 
 	if (attach_prog_fd && !attach_func_name) {
-		/* remember attach_prog_fd and let bpf_program__load() find
-		 * BTF ID during the program load
+		/* Store attach_prog_fd. The BTF ID will be resolved later during
+		 * the normal object/program load phase.
 		 */
 		prog->attach_prog_fd = attach_prog_fd;
 		return 0;
-- 
2.34.1


