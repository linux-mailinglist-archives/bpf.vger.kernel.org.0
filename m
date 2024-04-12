Return-Path: <bpf+bounces-26622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A9F8A3031
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FFE1C23EE0
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C65F54D;
	Fri, 12 Apr 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KQohFjvE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBCA85287
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931078; cv=none; b=EoktZWsvXyAuNqcDTimzE2uJ5QJ25FAVdzrPyPZZXPnLFO7AvUrwGupVL68p0mmtpYpGXEgcEyooqlbqLqvHlmxkV/uz2sRC8BlnZWzpVcB96Ppwe8YUuS4+EFCFas1Y/037JH+vF7X53nckd5zM1vXl2kMzNTBO/ZipgjUkGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931078; c=relaxed/simple;
	bh=42B4zF7PEMPHjgFDuBzB0b7o8c6zmBm8mqXYGN/477I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E/Y1UR+ctJys6NRqZsoSXrlYDzOacAUkzftgI9ub5hflS1/IUllcRB6qD8p5kJ6hujr+QSTTL6FyMxZCJumqqaQ+7syNFLduhlkEdTK91cDVhAiBZ9UoO/j+h2SqX4hHl71qQkhUwnyWG8wfeUCELElhvGvFAGv1U9PqT0/cUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=KQohFjvE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so984671a12.0
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1712931075; x=1713535875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baALxoEDq5fanav1NrM4LlybLXiaqMTyM9PIa8OEPyg=;
        b=KQohFjvEsnv0jhTFPKfV2HQBJG7ZM+eL75qOEwUZl88dMgxnxFGpncxi50BjnZQAF9
         CHvhI/YZiFPu+tYoX2UMwFHS4BjSt0h0ob2uaj+sCgY7noa6gDPBPDoPBfO2odoPEtP0
         FxJYuIzXVF8YOiK8UPXWNnybovyvJTlke953HsXGruhzUusQu0NPfmWPpzcDt520wIaB
         VskgiYxDAO7QW9/svcwvJvmCU9s6wy3CKlucNAsr8WP4+WnGN0qxH0zucaoeSuxANnKM
         eWrBNi281NJGTnz0AE19CeGTAK9NC1gSvYdipoZJ734DkFY0qofemnFx0hzZHvSdWTrt
         Lfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931075; x=1713535875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baALxoEDq5fanav1NrM4LlybLXiaqMTyM9PIa8OEPyg=;
        b=k5dBsvxYWeGYWwNIq2vYiU8R0iCeKidat1X1PxwW0jkA/Zw83KeyEsGmQFPQzj4wWw
         iQFL+eFwnvAYXOZVQz8K3r35ho1cSJr/ZZ0BiZAIwEuAopKm102e872Y6mm886F6SL8K
         h9qRRHlCi5YnsfgfRnrNCWjW0MIjCVdF+igLHZRiTcA+wtazEkCoMDxbmUnY6GMUZGLm
         EzlwCUXD4qmb4OUUfZnqmmo/G9CwLJeMoNrEStMBQLLX+YLER0tSHAaT7fSCPuFOjAxf
         OkJlpIfNSctQC1g4Tclj2Dgwwe51gA4RaxMYfXSCusrlA4AYBxudbUrq64/qZF7i3ZmX
         w1pA==
X-Forwarded-Encrypted: i=1; AJvYcCXl2bcoA9YMGBwaflmDgvOoB6QPVxV+Vi3EWPh+h8fMlXkKrlHmCkJJ0+xA/JyrBZXR27BJ5rtJQLkeD5ZhdgSCeZmC
X-Gm-Message-State: AOJu0Yyb/jdp2jQPYpJoGMDyRJ8zFHldyKeNeLJBBbkX0e7+g6OVQElj
	XmPZaU5JXWFc3CD3uSctmemD8oShSQSSNb9dHi84S5WE+uXErLmcaiQ2UBWIS3I=
X-Google-Smtp-Source: AGHT+IEo1svuGXGCHABlrZs47EVMqYhaS+u+2DomyMKvGo2ymc/UjxlezSLvGGhfrCoVKt3tM2yH/g==
X-Received: by 2002:a17:906:c104:b0:a52:2eaa:70 with SMTP id do4-20020a170906c10400b00a522eaa0070mr1927939ejc.60.1712931075503;
        Fri, 12 Apr 2024 07:11:15 -0700 (PDT)
Received: from lavr.home ([2a02:168:f656:0:2929:ae55:16fe:e497])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906391300b00a4628cacad4sm1858537eje.195.2024.04.12.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:11:15 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf] bpf: fix a verifier verbose message
Date: Fri, 12 Apr 2024 16:11:00 +0200
Message-Id: <20240412141100.3562942-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Long ago a map file descriptor in a pseudo ldimm64 instruction could
only be present as an immediate value insn[0].imm, and thus this value
was used in a verbose verifier message printed when the file descriptor
wasn't valid. Since addition of BPF_PSEUDO_MAP_IDX_VALUE/BPF_PSEUDO_MAP_IDX
the insn[0].imm field can also contain an index pointing to the file
descriptor in the attr.fd_array array.  However, if the file descriptor
is invalid, the verifier still prints the verbose message containing
value of insn[0].imm. Patch the verifier message to always print the
actual file descriptor value.

Fixes: 387544bfa291 ("bpf: Introduce fd_idx")
Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 12fcf1901dc2..7e694888d82a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18293,8 +18293,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			f = fdget(fd);
 			map = __bpf_map_get(f);
 			if (IS_ERR(map)) {
-				verbose(env, "fd %d is not pointing to valid bpf_map\n",
-					insn[0].imm);
+				verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
 				return PTR_ERR(map);
 			}
 
-- 
2.34.1


