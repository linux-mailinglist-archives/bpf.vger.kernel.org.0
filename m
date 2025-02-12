Return-Path: <bpf+bounces-51262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B19A329FC
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF17A19D3
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0162135B0;
	Wed, 12 Feb 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyAnq2X0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3E212F89;
	Wed, 12 Feb 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374107; cv=none; b=oV/4gY0s3e7CBUXKXEvTeimD/ShXqyaUwR2QoJuQdqtUeT6HaHi4gDzsyHhi3ZNKmVkMYyLeNkR/Zzi+v5cGlZDP2Nb2ZXuriNvr/2HJvOyOh+IBcNa398LgC0OAY4+G9vUq5el0Sfe7rx+m8sJubgGF9yKtOkUYQBSWzsTe3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374107; c=relaxed/simple;
	bh=gLL6cpzIFJVIxqPRHnNpi8sbyg8IQoOBomtsQRhVUVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YaGdS0mCySvYOF5OIDSt+Re1apw6jprQMHqMp+855nRV4pelMPztaFEjOI8Qrn5ThsfDGuzLHuUIrqY9YzUy/qIvEfnUIViWF5TUiZdNQUhDUwWqctc03avuh+GSdDmZmoVxpXXfaGYQQlxJe14H1pzB07/B59eaCdMcgx+Duso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyAnq2X0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f40deb941so152855025ad.2;
        Wed, 12 Feb 2025 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374106; x=1739978906; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jomb4wbCL0aIqDd/8vp4O87PbPEncfEiumc5w8RJl5s=;
        b=VyAnq2X0SlVP40oWCMpl/+fLF7YixFIjyE39AgPkLi8DNgAsYEispgToRfHYCERovB
         PbQ90ijVEuy4tZ8GHAHoDrl0DmTuuICdPI48y0MjeFlQVL4plq4KSf+Ck1QT6soR0gdL
         EAtpfxl6lcg7w2DSWB1X5G2nnsD3RjfGmyn/XwRLMobhl7OjIzNcP5XPbmTuR/EhAWPV
         0ccclYWtXVQGGPAitCY7HGYInMd4gtvKthpa9OqSA0H1hKz8f5QiqJzFsL0qd0cAzl8E
         qszsnu0UJ8OPV0U4oB1x/MJ+Dfcnpgm0fUnTYU/0H7JUEG/32eLDZNh9q4xKZFOQL0LX
         l0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374106; x=1739978906;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jomb4wbCL0aIqDd/8vp4O87PbPEncfEiumc5w8RJl5s=;
        b=oRL12yTfR5Nqeq20ddoFqJjvzquhau48dk2Cygf1unQpfJ5KyXsaLBZwA01XFtApsJ
         vOS/pUZ3NDChAT6RXQsMA/k5/kak3TPlAbfl3ieGndp5aMDaHU4EjFspo2sjP263a/2o
         mbVf7a4a79Fx01HvyAqRiEapN0dEsYu9ff8Hehu2aP0AjmPrNuJpJ0NSBbDHipUdiCy8
         7JEm2g75o23GPpsIHvZGuH2qiKgjWJGz0yWYi2p7czijd8X/zduqkkIppZaPLUAwqpcm
         Q07L4xyN8+kPeW5Mkxr0VJjOtVPfIzJTE8he+hxZ+k7j88EXE9ankzSugoiMvuXpZKGB
         2ziQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb8abFhw8Nqf9sfdbaJOWcaRtbKq9lBwlDyvn/pxKqYe/U9NOCCnwqzS4kfXNurK0waNrhWUEwZloRshQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89IG8UFTEtTUzIaIc30Abce/7iw2gAVfBSYTeipQHu8P7bMlP
	bpyoeWdvYAo92z6oDLPEdUBX5SP9wPotWdM9spYQI+8aPqd4wOzYF+u1QA==
X-Gm-Gg: ASbGncsOexnVa3/qXwkgetCzSTKcpGUwuAYqsdl6h26jL9tXJS791ziwOpCTju2rrj3
	pyfa2P6rsUwn64P9IQzx7jCeYDa9tJRSWcipB6svJ5p7nRWmDmzWvzeefUff+hRj8xLkO4ROn4W
	bySSyVacUMNF1MLbsQ5VYEo6oJIRJJ9YcsUy3Z++oRXzOANbL1E1+7Vm2xbGsAdW9JoeFtoxHw4
	5wWDOPoQZ6qLiLeeej/SOiIDFwbcoOk/pi10W9cENMDHpLhuyBzPC0kS3/9fa6K2n37bOFU1dPP
	xRzVFBk5NeaA3oyJ
X-Google-Smtp-Source: AGHT+IFQfgv6uXsnkEnIadjynJGLMCuOLTKPpteafRNKBPHJqVl7S8uzYOsVxGC/xA/OrfP3vVVWsA==
X-Received: by 2002:a17:903:1790:b0:21f:1bd:efcb with SMTP id d9443c01a7336-220bbab3b89mr47548055ad.7.1739374105613;
        Wed, 12 Feb 2025 07:28:25 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2faa4ae549asm955547a91.0.2025.02.12.07.28.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:28:25 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v7 1/4] libbpf: Extract prog load type check from libbpf_probe_bpf_helper
Date: Wed, 12 Feb 2025 23:28:13 +0800
Message-Id: <20250212152816.18836-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212152816.18836-1-chen.dylane@gmail.com>
References: <20250212152816.18836-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Extract prog load type check part from libbpf_probe_bpf_helper
suggested by Andrii, which will be used in both
libbpf_probe_bpf_{helper, kfunc}.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..a48a557314f6 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -413,6 +413,23 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	return libbpf_err(ret);
 }
 
+static bool can_probe_prog_type(enum bpf_prog_type prog_type)
+{
+	/* we can't successfully load all prog types to check for BPF helper
+	 * and kfunc support.
+	 */
+	switch (prog_type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return false;
+	default:
+		break;
+	}
+	return true;
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
@@ -427,18 +444,8 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	/* we can't successfully load all prog types to check for BPF helper
-	 * support, so bail out with -EOPNOTSUPP error
-	 */
-	switch (prog_type) {
-	case BPF_PROG_TYPE_TRACING:
-	case BPF_PROG_TYPE_EXT:
-	case BPF_PROG_TYPE_LSM:
-	case BPF_PROG_TYPE_STRUCT_OPS:
-		return -EOPNOTSUPP;
-	default:
-		break;
-	}
+	if (!can_probe_prog_type(prog_type))
+		return libbpf_err(-EOPNOTSUPP);
 
 	buf[0] = '\0';
 	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
-- 
2.43.0


