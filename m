Return-Path: <bpf+bounces-12882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228D7D1A25
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5451C210A0
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73EAA4C;
	Sat, 21 Oct 2023 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cllPDQPg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8180D
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 01:00:25 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3063FD45
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 18:00:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9338e4695so19976821fa.2
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697850022; x=1698454822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjZfCOsiQ8gNa1K5iuy9cN8w9IqFjspIaddvVsyA6LE=;
        b=cllPDQPgh/9xt1CsxZRrOrivIih374uBukLJ4QGRqc2WVMr88td+Zd3T3ykIV8NYC2
         NmrPFLWyuf+4ia6wvilAM4fgmzOvracSuLBQto3VWee8wXzNZvBzXTGHZ+2fyWivSthC
         J3gbDXzOruRS7EEmp44vO/1Np8yEOPPFvkWVd8P9LOJ7f70zBw/y2s5A0MAy3OOCvji0
         7wH5PkrZJxuxvb36QRiEpTTN5rxrAlvJ+aPaoArcUVQbNkdbwb/leShxzH0hifu7r8DB
         fYCFI+z3+W0YLBKk5L3VetxPaW/bKlN2j/f0pzWj8xoctpjG4v3hthzaZLzx9bmTbEcr
         FVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697850022; x=1698454822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjZfCOsiQ8gNa1K5iuy9cN8w9IqFjspIaddvVsyA6LE=;
        b=Cr8c+E6wDKpu32jNZigRJOZ8xbHU7xGfDFGF3BAeIDpbcvrchIvGeqWUVYGZbYXSWU
         1OiiJLZ70h7ghP4IUggBjuYkwD/8hCzpIZXoMCNwMQxderTvWJSJgeG1PbYdc4ltNess
         HBNjV+yrK9kUSgQ2FJkIU6Rkz1hU38xadoXieoz8SRxEwLUr+EfYIZJmQOlarTuCzHWy
         5oxEFnru6hImeAj11IE+lUxk1ExmAA0lYxu3tkc+OGg4ZErjOcOz2qa92uMRXqw5osAJ
         DWlxPr7e6TR5JeJOl4cLAon6Gj6KpfzsenbV1fbIR5ENjdqkZGT2QXfVeb5ywGT4FIrk
         /Weg==
X-Gm-Message-State: AOJu0YxATlute3Dtx1kFMy5S9R2uNbXBFXyGDf5WwpeRPnABRpn0mhVU
	amNS4M5ZTZK+wkN0ErFtGBLAKfCXEF9o2G+9
X-Google-Smtp-Source: AGHT+IFOuHbSAvESzb5MtrUWH8hN6p+Zxd1RivuRuc5VNJeT3Uw7HraTDgcty89I7FVGzgvDtDDGUQ==
X-Received: by 2002:a05:6512:41d:b0:504:7ff8:3430 with SMTP id u29-20020a056512041d00b005047ff83430mr2442826lfk.10.1697850021939;
        Fri, 20 Oct 2023 18:00:21 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cf15-20020a0564020b8f00b0053deb97e8e6sm2370344edb.28.2023.10.20.18.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 18:00:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	john.fastabend@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 5/5] bpf: print full verifier states on infinite loop detection
Date: Sat, 21 Oct 2023 03:59:39 +0300
Message-ID: <20231021005939.1041-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231021005939.1041-1-eddyz87@gmail.com>
References: <20231021005939.1041-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional logging in is_state_visited(): if infinite loop is detected
print full verifier state for both current and equivalent states.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 117dafd9b1e7..29d7908d0ebe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16936,6 +16936,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			    !iter_active_depths_differ(&sl->state, cur)) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
+				verbose(env, "cur state:");
+				print_verifier_state(env, cur->frame[cur->curframe], true);
+				verbose(env, "old state:");
+				print_verifier_state(env, sl->state.frame[cur->curframe], true);
 				return -EINVAL;
 			}
 			/* if the verifier is processing a loop, avoid adding new state
-- 
2.42.0


