Return-Path: <bpf+bounces-13080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70F7D43B2
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B68281723
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBAEBB;
	Tue, 24 Oct 2023 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmj1MNxv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479517CA
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 00:09:40 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC510C
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso548565966b.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698106177; x=1698710977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uztZAz2lTE/DfrWW9Ev1qNw/4YUBFyC1T7upJE+3Gl4=;
        b=bmj1MNxvKJhVuH6rwwRh+RLF6p+YLoRIx7ns05rOOkRKd2Zw3XhA0hon3v8I4QetYI
         UzJsuz09Gn5mrIfeQhV3OV/y0jdYYzp0yFFFKcM7/zYonm7dFoiVUYPU0Yr1PJULYwSd
         OKN+YYZaezFeX/7sUm5khjhwa+btr76R1nj/vnAVRmpTwKKMmIndsi1lhkF6Xc4yvFxR
         h7r+QbtrHNmRiZtDlJ+sPwp2YX37TE/8IiK4Cr1f82p4ZMKI1NTn2qSSTtYkPQ9hkXWg
         KZ/9Sl8aeqRYvaC9aJnC+36Su6o9YVCs6FX90qp9q41tb2+hzss2NmdQ0sRjkzeitOc8
         R5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106177; x=1698710977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uztZAz2lTE/DfrWW9Ev1qNw/4YUBFyC1T7upJE+3Gl4=;
        b=E3H1tORnFstShikhQYf4k/jSsnDyYjPXfkKBcGZ+TBrivYyUnHTmTq5PFhGy4kokKX
         bBXVIbncZ13imma/C6FrghMq7Fn3xj/eceaP0VYFUw3GxQioEtRsWppmfmJBWzAIpIru
         unj+Q4YrylEmHWyOGPinb+K8CbCJZTaFfTyiVQLIdNGoPxA/tmF9xcLfCgq8pjUb4+Ms
         TjRqYsHKzJR/5ZqepD5hqy3rPZ8v1sGSt4gQYftsv5abNC4ce2cYfphkGEZTPxr09zj6
         9c+pRq9qy2AW3zruBsQ+8xo9tofw8m12Elc4Ta8CLawWQv8gK/RpNklT2scyDaN4Cva6
         aDew==
X-Gm-Message-State: AOJu0YxbfCc37Uyw2seSzHaHLG7Z9kIJmzbJNnoZskMNZLrgDAuAVtiB
	PSgRci31tZUTdsi2Yd2MOWQL5FwxRQ31x5Q0
X-Google-Smtp-Source: AGHT+IG3zUDSCSn9BxV/BDKWhNtzA4FB9XWrBCoMl6iqEfY5vqJ9s1bCSuGrptpy1eDhBGFApXV9CA==
X-Received: by 2002:a17:907:3eaa:b0:9c3:1d7e:f5b5 with SMTP id hs42-20020a1709073eaa00b009c31d7ef5b5mr8092028ejc.20.1698106177453;
        Mon, 23 Oct 2023 17:09:37 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm7264516ejw.158.2023.10.23.17.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:09:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 7/7] bpf: print full verifier states on infinite loop detection
Date: Tue, 24 Oct 2023 03:09:17 +0300
Message-ID: <20231024000917.12153-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024000917.12153-1-eddyz87@gmail.com>
References: <20231024000917.12153-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional logging in is_state_visited(): if infinite loop is detected
print full verifier state for both current and equivalent states.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f23fbfe82c59..98f9d0f35931 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16928,6 +16928,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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


