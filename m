Return-Path: <bpf+bounces-51653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A229A36D92
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086541896976
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44211AAA1D;
	Sat, 15 Feb 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNYgj7Tv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23861A9B39
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617477; cv=none; b=CkJKiPrCDhAsQQW6iYFwwuuWbjbSJDk3Uj25OPTS1dUvPvotjNHiCOjsjQgiCQiGrBFl8/zCck+LIYS41QaRZBsUIKw1VKWs9ey1yMdgqTFAW6TRi5wC60Tqs6FXyls16BelI+LnErAGcENaPF7/AUY9RF4IwrzppZJEiWr2tTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617477; c=relaxed/simple;
	bh=d/gA7YbLF8CuPatwKNVF8jZFZ3F4DtpmMEBhJe2mdQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgfbSBicUqLQzuETtJmr7ZqadimknHX2t2TsE0X0EHR0jq6NqBB4pAvWHTeKOKLm85/qVn3mEw9eaw4ONowIFLM69y5gzpY1OEU53M8gPVFGOrq/jU4xor/Yf0nB3CtosNN4yw5LrC5VF9AfZWp3wbu8Po0+qmcXjTip+LyO6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNYgj7Tv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso5333856a91.3
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617475; x=1740222275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD4Fri+vIX2r3fzgTK26CxYSkIN9OYppa9kRT0keu4A=;
        b=kNYgj7TvRO0V4xbwbTP2RK0c3cQ7q3uX3jsPN5C/mi+N9FqLQ0b14VoKc+JSM033cE
         6z4z6zIgk5C+ymXGnCSR7h8IkG62mH78UnMMHCsRVLgTKWAaLpVxHIBpexZvujEVk7YH
         7mGr1oaTqH9eftnflpSgNkYkW9sAkhn7hTfkOIYp0mF/5ALAVP0CGj/uNFnEqIB6LrLd
         bCt9fDBucUiNrxFBs6E0O3seaYWdAR5xdsGvqPKfXqFddVvfeAt9Q8US6Az7brSq2Cs9
         SPUPkjlZbOSRNfIvjfF0sKlPSd0XkxqdxUAHdouPm5ynHSwq/XO/o1bO5ltr3Dd/afHN
         fxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617475; x=1740222275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qD4Fri+vIX2r3fzgTK26CxYSkIN9OYppa9kRT0keu4A=;
        b=TsouI0OjMXmp/IFhfi0aoFHAloos/K+pVM8kIgp8+E/+99teef6cTnCIMkzUz/8Zll
         MjzrB/BtWxqNomQFBTQ5MuOLBLwN3avVjhx7ruYo0G0ShwjO11MduAbf95oi4X4GM7CX
         wIfUZ7Ggd7oDjGVltnUsuJV4J7wVGPk5fppm76ZNlNfj9AM7RSU2mwfci7DYYRaAme0L
         sC9l2KVw9FhnT01x0fsxdquFLNwRVbHQOckLfSAsu4hb3xajaw/05UYVCQPLnhBjTdzA
         6imgiC1pmGoRsFNbju6EBLhFOJ7QDaBYS982wyKbIaI4cgGXR93HUh1cRFP+v6RZCWJD
         0Jqw==
X-Gm-Message-State: AOJu0YzLMuAMceUqKFd7+Av6A0XZc6z3LqNPdBlL7TgWk3Qut3BSefeC
	QHaUlCDi0azqyFTUuundOxwZ0PalD1P6EGG3qhv1KoaFWnA0pFqEXGd/PQ==
X-Gm-Gg: ASbGnctXkZcTPo7WHOBA10LcDbTf5KwAvBGNJ9nlO37jjMauZDfRyAyLfJdpBmYRex2
	4oI7yy/YDGbw1U9cM/KliVB/BJ5HlzKAxFkTRJ70QHqDJGPBWbz4SUzGudJhtDZLht7CdnPSQ3+
	I8kv/lkjq4LZT93dK6FY7uX2hHJ/9ObW4AtTdlApoRJYzgEb13c5PuXu6yxhH1XSvX7wfkCaXHD
	wPh4uic8NtnAFYu3quDgDe/48A0vuKxKACxU4pHYYUV7oQ0YrvcuW2nR4FyqHhsg4PF3zyX/BYL
	+72l0R8pkTg=
X-Google-Smtp-Source: AGHT+IG1trQgNo7jW2laOLKHbSGl2l8ALFyGvU1PHIRf1bZOsOE3BpIUouAXjwnZ7csn8iNIIezr9w==
X-Received: by 2002:a05:6a00:198c:b0:732:1840:8382 with SMTP id d2e1a72fcca58-7326144b0b3mr4815210b3a.0.1739617474965;
        Sat, 15 Feb 2025 03:04:34 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:34 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	patsomaru@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 06/10] bpf: make state->dfs_depth < state->loop_entry->dfs_depth an invariant
Date: Sat, 15 Feb 2025 03:03:57 -0800
Message-ID: <20250215110411.3236773-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215110411.3236773-1-eddyz87@gmail.com>
References: <20250215110411.3236773-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a generic loop detection algorithm a graph node can be a loop
header for itself. However, state loop entries are computed for use in
is_state_visited(), where get_loop_entry(state)->branches is checked.
is_state_visited() also checks state->branches, thus the case when
state == state->loop_entry is not interesting for is_state_visited().

This change does not affect correctness, but simplifies
get_loop_entry() a bit and also simplifies change to
update_loop_entry() in patch 9.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f750c8607470..02f60b8683b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1788,7 +1788,7 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
  *     # Find outermost loop entry known for n
  *     def get_loop_entry(n):
  *         h = entries.get(n, None)
- *         while h in entries and entries[h] != h:
+ *         while h in entries:
  *             h = entries[h]
  *         return h
  *
@@ -1827,7 +1827,7 @@ static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *topmost = st->loop_entry, *old;
 	u32 steps = 0;
 
-	while (topmost && topmost->loop_entry && topmost != topmost->loop_entry) {
+	while (topmost && topmost->loop_entry) {
 		if (steps++ > st->dfs_depth) {
 			WARN_ONCE(true, "verifier bug: infinite loop in get_loop_entry\n");
 			verbose(env, "verifier bug: infinite loop in get_loop_entry()\n");
@@ -1854,7 +1854,7 @@ static void update_loop_entry(struct bpf_verifier_state *cur, struct bpf_verifie
 	 * hence 'cur' and 'hdr' are not in the same loop and there is
 	 * no need to update cur->loop_entry.
 	 */
-	if (hdr->branches && hdr->dfs_depth <= (cur->loop_entry ?: cur)->dfs_depth) {
+	if (hdr->branches && hdr->dfs_depth < (cur->loop_entry ?: cur)->dfs_depth) {
 		cur->loop_entry = hdr;
 		hdr->used_as_loop_entry = true;
 	}
-- 
2.48.1


