Return-Path: <bpf+bounces-12909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F5E7D2095
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 03:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EEDEB20DEE
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 01:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B324BA35;
	Sun, 22 Oct 2023 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvlPEbPr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3156804
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 01:08:49 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0FD5D
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9936b3d0286so319766366b.0
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697936926; x=1698541726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLfeHgMr9OIfGdF10vRyhHBz4oJNHJP7vxVaMvwIYcw=;
        b=PvlPEbPrYje3FWUXbj9a1gaXcY/BOssjAGQE93rYZRolo5Kbw/SJPGNfcmIT2lfqIc
         zkVLuOpSSmBty9Y4mUBgbJKtZ9KFhC7493K0MCkY9wc2YtRXbB9jPpPupBCQiy9JwPLE
         RK9D3XN4SHFshTwz5QtsrizwyPsH5oYiq14bWJ4rS+KKlhKDHFHqEW/i7Ma/LbrTitHy
         ziasNXn8Oyii1ACZatlTLvslN62Bbh34IYh4GEAB8hl+hJ2oUYI6EZ6PrDeu+IWwvwPE
         LWTYMxqm4eG432wkehSRbTRVGIvvd7YwLNAQJfhXC8O5YaKZ/Gv1Gk/FJYza2nFTnJdt
         ap4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697936926; x=1698541726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLfeHgMr9OIfGdF10vRyhHBz4oJNHJP7vxVaMvwIYcw=;
        b=bIMkmcC54KkhZaGrkFUy72sRJv/qpeEf5idrSXM13GcUHX7c56gX6i+wRI0haJ4WoW
         voMhkk1i9Hgr4P+vXsyFU9/wi3MidhPpNrVj2QJE79W0cXlUxKoS1qdi9cuyGINBEkYh
         0rOxuEpJ7a6/RJ13roPp9X8DBSajOlZo2s7ktFcgrB/FP7b8SrER7l7ijuk+Fo3Ijp3B
         0Hvoa9e142e5vm65cHe3pf1IjBLFsbr90NdehEc4aGlYbcGaFqPfAOiE4xKhnVUQ8LeM
         /r/wvuwhc20KP+gNrojDX+hVqEJprCjCGfIZbjOPxFj6AXgnZqWVfcyMbX3C9SPOgOMT
         SeWw==
X-Gm-Message-State: AOJu0YzvXUKvoD7D4fnYu79VPVWqa+TraVZ+UHUPLEzCdE+9Y+7nu6tn
	drAzFG2tY4d0c1FG4tT4Qz1V1lLhXf4Y29Ip
X-Google-Smtp-Source: AGHT+IHaWm2ImKRTqMcaWE0Km8D++MLZ9GkFas2KpZffMd2TMjk6IGuE9VW248ZuMk0jFNZpzQ18rg==
X-Received: by 2002:a17:907:a03:b0:9c7:5b43:a8ee with SMTP id bb3-20020a1709070a0300b009c75b43a8eemr4322278ejc.74.1697936926422;
        Sat, 21 Oct 2023 18:08:46 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906655000b009c3f1b3e988sm4276143ejn.90.2023.10.21.18.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 18:08:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/7] bpf: extract same_callsites() as utility function
Date: Sun, 22 Oct 2023 04:08:07 +0300
Message-ID: <20231022010812.9201-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231022010812.9201-1-eddyz87@gmail.com>
References: <20231022010812.9201-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract same_callsites() from clean_live_states() as a utility function.
This function would be used by the next patch in the set.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6232b5d3964..366029e484a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1830,6 +1830,20 @@ static struct bpf_verifier_state_list **explored_state(struct bpf_verifier_env *
 	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(env)];
 }
 
+static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_state *b)
+{
+	int fr;
+
+	if (a->curframe != b->curframe)
+		return false;
+
+	for (fr = a->curframe; fr >= 0; fr--)
+		if (a->frame[fr]->callsite != b->frame[fr]->callsite)
+			return false;
+
+	return true;
+}
+
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	while (st) {
@@ -15909,18 +15923,14 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 			      struct bpf_verifier_state *cur)
 {
 	struct bpf_verifier_state_list *sl;
-	int i;
 
 	sl = *explored_state(env, insn);
 	while (sl) {
 		if (sl->state.branches)
 			goto next;
 		if (sl->state.insn_idx != insn ||
-		    sl->state.curframe != cur->curframe)
+		    !same_callsites(&sl->state, cur))
 			goto next;
-		for (i = 0; i <= cur->curframe; i++)
-			if (sl->state.frame[i]->callsite != cur->frame[i]->callsite)
-				goto next;
 		clean_verifier_state(env, &sl->state);
 next:
 		sl = sl->next;
-- 
2.42.0


