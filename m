Return-Path: <bpf+bounces-13077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524687D43AC
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64A3B20EE3
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0962515BE;
	Tue, 24 Oct 2023 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5RBL8Ml"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0810F6
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 00:09:34 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC34110
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c75ceea588so548014466b.3
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698106171; x=1698710971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLfeHgMr9OIfGdF10vRyhHBz4oJNHJP7vxVaMvwIYcw=;
        b=b5RBL8MlX3Cd7i7Bc26YoO9tU3+1j4XkdIzu0cpTLK/5lakLD9uDwiSkBiubxSZMzq
         7NEVKEBmqKAcGDBP/tQm2HkPtI/q6ROclSBVofl0xJrQVQzyRONOLijXFWz2d4fw1vM8
         DOI6BCzY9ZTaMC5NiW9svzvgP7NDYgJtcRwxfso3YLbOuF7pxMvwXEOjaSJnxNlQfjOF
         hFPDWuZ08AONt2faSkcTew4fZ8vtRzetAfN9du8y6LZG7j4HRYjz2ZZCiNqg6GvF0JlO
         NW6Q4gIGCBjJTwArf9gBHfOoM0Nx9m2ewhOEcUUU2zINqCq4tdEHj7S8ymgzY9QkTRuZ
         rdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106171; x=1698710971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLfeHgMr9OIfGdF10vRyhHBz4oJNHJP7vxVaMvwIYcw=;
        b=BQwMbsRCzk2AYulnPAQkw3fqKkMflisccnYv5eA1ntXvc8aLnsFLNLPaapKiszEeMK
         64a/JCo8ozFAjIlhNj0VFQePiswbq3tg+orydjYjzk1KcWwOrqnZNbN5mJKm6wjiwzJ9
         zfCyGpRZacWy1T2Iv34Fl+5Ug04Nl7UJgf+mS6OIPzYPOJd5aQ7dBkGkt9VjRmlPiJYA
         dH+7RszdsTkn6ksx5OqnZf+gjTIJOi6FhfQUyueCfsKe/JZEkW+4v6uSB7TAE8kpaN7r
         Yofu4H0gDGcXMvZGeCI5L7l1eL2WlyDa8eZ9lqkLuBmg9hHc9FJADfbY4CkOAAOjHdGt
         0lXw==
X-Gm-Message-State: AOJu0YxuLdKCVHYSgRZbi+pfJIuMykvphA3lrXFhRlqV947/1jj3tJNI
	6hyvLstdHQTocMN1hzvNyFZXbMCWnO3mqrcm
X-Google-Smtp-Source: AGHT+IHK76oaWtTs8itKS+u03HGjrKi8wH5Envz25qHR2wFE+lDBG6RkXpBDb0vWxSKvdK7iJQONmw==
X-Received: by 2002:a17:907:3f1a:b0:9ae:6ff4:9f15 with SMTP id hq26-20020a1709073f1a00b009ae6ff49f15mr8194024ejc.11.1698106171454;
        Mon, 23 Oct 2023 17:09:31 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm7264516ejw.158.2023.10.23.17.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:09:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/7] bpf: extract same_callsites() as utility function
Date: Tue, 24 Oct 2023 03:09:12 +0300
Message-ID: <20231024000917.12153-3-eddyz87@gmail.com>
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


