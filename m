Return-Path: <bpf+bounces-60389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D04AD612C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEEF7A5B68
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4D24503C;
	Wed, 11 Jun 2025 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="GB7QRGZ5"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC91BD9CE;
	Wed, 11 Jun 2025 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677039; cv=none; b=bulC0PajIt2khmUIQghsRSLVKqwkKS3fdZQKeKGs4Zg7ZWkBWYd/ej67pLHg8W8yyui0f+UVMzzzbxfSI9FyhX7JiFfnzGL0823U3MTj5SScqF7HF4WYXltBrTFkOFiv+weTDQhnnn8ZfgDaDqe0ZHq0RmBMfikUQCkeijfNU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677039; c=relaxed/simple;
	bh=t1zJH4Rmm4htAzj/dQwNCS9TEe1c1gCbgRoNZ2a76h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmjGXMk3QCKFgFTT68iAmRpIwKmw34sleU895c+CEsdg15rSKJJqlR+aB62ooiKlYt6qxQISHckIahuxK1gE55QH1o3NNUs9PUUuxiLBRZ9aJMVJtqnnEzk/047LEXygW8m46lQTewkpHDYyQocm1SSt3rmJW/RFsLiKtzgfQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=GB7QRGZ5; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1749676562; bh=S2j0xHEZeQOTVtx7TJX88U0NbtEMbxvs08E3DcOiM3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=GB7QRGZ5lNQDix0fSkRgtNjMUUycMz/UHj26osAKdXgqXZKpzhvC7+v9XyS8QmlYC
	 azUB/LpaFU0XoJC/mJ0vbZ/D59tDhDxJBssj5jaqn1fbH695ZHK/xkgYdQIE7kK+sS
	 N5j8WALlbhpLQrq98pYbzkDR7mjZlqOt+NDyWZyph3hi749A9BIreU1ETu6Pg/Pma7
	 QZXaBnZdUvryQAzJbNaE60AG/8ryVYMTcyp52o6CfoGab8AYoxvbeVrnlVBXMvDLHI
	 OyijBtu3r24T5wMOIZBqjwlbpMaG3cg0dUtM4NFqKqTy0xGay1OeXO7hnwnR+7souS
	 uQpsPOkO1Iuxg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bHdkB0q3Sz8sk1;
	Wed, 11 Jun 2025 23:16:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3626:500:39da:8819:39bd:1255
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3626:500:39da:8819:39bd:1255])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19Vu+9xQHHGMkmfqtW7CJMHQ2bOqLm6aCk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bHdk70Msdz8spC;
	Wed, 11 Jun 2025 23:15:58 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Luis Gerhorst <luis.gerhorst@fau.de>
Subject: [PATCH bpf-next] bpf: Remove redundant free_verifier_state()/pop_stack()
Date: Wed, 11 Jun 2025 23:14:31 +0200
Message-ID: <20250611211431.275731-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com>
References: <b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes duplicated code.

Eduard points out [1]:

    Same cleanup cycles are done in push_stack() and push_async_cb(),
    both functions are only reachable from do_check_common() via
    do_check() -> do_check_insn().

    Hence, I think that cur state should not be freed in push_*()
    functions and pop_stack() loop there is not needed.

This would also fix the 'symptom' for [2], but the issue also has a
simpler fix which was sent separately. This fix also makes sure the
push_*() callers always return an error for which
error_recoverable_with_nospec(err) is false. This is required because
otherwise we try to recover and access the stale `state`.

[1] https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com/
[2] https://lore.kernel.org/all/68497853.050a0220.33aa0e.036a.GAE@google.com/

Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/all/b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com/
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 kernel/bpf/verifier.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3bff0385a55..fa147c207c4b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2066,10 +2066,10 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	}
 	return &elem->st;
 err:
-	free_verifier_state(env->cur_state, true);
-	env->cur_state = NULL;
-	/* pop all elements and return */
-	while (!pop_stack(env, NULL, NULL, false));
+	/* free_verifier_state() and pop_stack() loop will be done in
+	 * do_check_common(). Caller must return an error for which
+	 * error_recoverable_with_nospec(err) is false.
+	 */
 	return NULL;
 }
 
@@ -2838,10 +2838,10 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->st.frame[0] = frame;
 	return &elem->st;
 err:
-	free_verifier_state(env->cur_state, true);
-	env->cur_state = NULL;
-	/* pop all elements and return */
-	while (!pop_stack(env, NULL, NULL, false));
+	/* free_verifier_state() and pop_stack() loop will be done in
+	 * do_check_common(). Caller must return an error for which
+	 * error_recoverable_with_nospec(err) is false.
+	 */
 	return NULL;
 }
 
@@ -22904,13 +22904,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
-	/* check for NULL is necessary, since cur_state can be freed inside
-	 * do_check() under memory pressure.
-	 */
-	if (env->cur_state) {
-		free_verifier_state(env->cur_state, true);
-		env->cur_state = NULL;
-	}
+	WARN_ON_ONCE(!env->cur_state);
+	free_verifier_state(env->cur_state, true);
+	env->cur_state = NULL;
 	while (!pop_stack(env, NULL, NULL, false));
 	if (!ret && pop_log)
 		bpf_vlog_reset(&env->log, 0);

base-commit: 1d251153a480fc7467d00a8c5dabc55cc6166c43
-- 
2.49.0


