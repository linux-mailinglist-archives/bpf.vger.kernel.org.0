Return-Path: <bpf+bounces-60388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA82AD60E2
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5C41E0C6B
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490ED2BDC2C;
	Wed, 11 Jun 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="TTxOyECL"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6828B1F7904;
	Wed, 11 Jun 2025 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676444; cv=none; b=EHZCb1cnOr5HaLaMwqlWmJ6KpnhWjRN39ZrI8eZT1VfAzU0MSR4lgUCCQBymtVIpoiAQrOO8aFjxsMWTDw/ldLWUFj+hHgQrvFJWm3WB2A41MoN4VuPxGomaTdbeQ+yQ5xqtKeH9xCrvAQXlBnn+K8wxmidr3xBwZrIZQT0B6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676444; c=relaxed/simple;
	bh=123Y/VUR32niZhCHmmjiMZx7FMUBE0IJr1z6U7X4cNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIXZRaw1NVNbZP8QTZjh3kuadGpGY6AvA8zGTTkgwSjDmd9XdpJ8daiJdMDmb/03rmYU7olNPB4jQvC4W/8j20PFc6Q8v8/eYSRT42NB6djm/g55wIEVGbaoLL30al6xfzdiiZe2TqYuRMjaEg2nZ1G8l9bV/uh27c7vI5PJhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=TTxOyECL; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1749676106; bh=SCKfOOSOyeoVjmJnLCPkDxbbVBBcC0ITZCX1zItnZbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=TTxOyECLcB9SDsb2/N6+cXBw3ZgEPfYveEtZaPg9pX40OqZHp5PSX2yGkhh8DgVdz
	 dWnP1jcsZhWVOPVHGujAZdylhyUWQFMaqDGmOAUXt6sB40bAnc/FRgp3IG938oP5jd
	 EbXveXMUyFlGnnhe86ASG8hbXITApl21ujueGKCBf3s90KO9+u5YqkN4EmmHSxGWf0
	 truTIaCRpjcgFgnQXlQypO8aZ09Y/TqDWFzA1Z6eGUGotCq5sy6BX6cSAmO4NdVSH4
	 v+I0CPVULxBWq6++OoQkaMwqcpso/5Afnv4XCfPG4OXMelHF/4DLRfl/pj/n4SJW5f
	 wE65+xLMnklRw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bHdYQ5phXzPk2s;
	Wed, 11 Jun 2025 23:08:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3626:500:39da:8819:39bd:1255
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3626:500:39da:8819:39bd:1255])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19M3XQgzUSjR5vKVmuW0oXhCVKObzOx14A=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bHdYM4FmRzPjmG;
	Wed, 11 Jun 2025 23:08:23 +0200 (CEST)
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
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Henriette Herzog <henriette.herzog@rub.de>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+b5eb72a560b8149a1885@syzkaller.appspotmail.com
Subject: [PATCH bpf-next] bpf: Fix state use-after-free on push_stack() err
Date: Wed, 11 Jun 2025 23:07:28 +0200
Message-ID: <20250611210728.266563-1-luis.gerhorst@fau.de>
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

Without this, `state->speculative` is used after the cleanup cycles in
push_stack() or push_async_cb() freed `env->cur_state` (i.e., `state`).
Avoid this by relying on the short-circuit logic to only access `state`
if the error is recoverable (and make sure it never is after push_*()
failed).

push_*() callers must always return an error for which
error_recoverable_with_nospec(err) is false if push_*() returns NULL,
otherwise we try to recover and access the stale `state`. This is only
violated by sanitize_ptr_alu(), thus also fix this case to return
-ENOMEM.

state->speculative does not make sense if the error path of push_*()
ran. In that case, `state->speculative &&
error_recoverable_with_nospec(err)` as a whole should already never
evaluate to true (because all cases where push_stack() fails must return
-ENOMEM/-EFAULT). As mentioned, this is only violated by the
push_stack() call in sanitize_speculative_path() which returns -EACCES
without [1] (through REASON_STACK in sanitize_err() after
sanitize_ptr_alu()). To fix this, return -ENOMEM for REASON_STACK (which
is also the behavior we will have after [1]).

Checked that it fixes the syzbot reproducer as expected.

[1] https://lore.kernel.org/all/20250603213232.339242-1-luis.gerhorst@fau.de/

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Reported-by: syzbot+b5eb72a560b8149a1885@syzkaller.appspotmail.com
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/all/38862a832b91382cddb083dddd92643bed0723b8.camel@gmail.com/
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b1f797616f20..d3bff0385a55 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14229,7 +14229,7 @@ static int sanitize_err(struct bpf_verifier_env *env,
 	case REASON_STACK:
 		verbose(env, "R%d could not be pushed for speculative verification, %s\n",
 			dst, err);
-		break;
+		return -ENOMEM;
 	default:
 		verbose(env, "verifier internal error: unknown reason (%d)\n",
 			reason);
@@ -19753,7 +19753,7 @@ static int do_check(struct bpf_verifier_env *env)
 			goto process_bpf_exit;
 
 		err = do_check_insn(env, &do_print_state);
-		if (state->speculative && error_recoverable_with_nospec(err)) {
+		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
 			 */

base-commit: 2d72dd14d77f31a7caa619fe0b889304844e612e
-- 
2.49.0


