Return-Path: <bpf+bounces-59929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508BAD0945
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A415D16B6AF
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8F201013;
	Fri,  6 Jun 2025 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHD/+quc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73536A31
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243874; cv=none; b=Yk8SWOoxq+75//KONGfhnPUxSEiUgubmzbD8iyvnENH7twH6KyS5L609iMN68QGLYbaEiY35ljQulMiKlCRqjZttCtrXMd2XlcpW0ssr7BSmlVpNW+YcbOcC/4/9XcQh665wJoirtfodQ2rCC4SO+t1fV/GPBam66O2sd1ck02s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243874; c=relaxed/simple;
	bh=T6Xs6l4KRWChSpIJmsqMr0vACEhFq+qD0UWkh2fAULk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yj/GVKxF++QBJ3Bm+AoOak79u+PFBLZq/QbQmlN56ycUUIsHfKFGnEUOXXoMMMJrIdcx3D4k66vsWVw/cSfjyfzLRY7MiNXH3KqavKkX2HmDhyZU+BKVfBYYgbv9RlM/7Nln+yeowpD6s/HiwRSuaju46XFTc0FcgVdDDCWf2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHD/+quc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso2079777a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243873; x=1749848673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYyyMyesBqRJnMoKNeW65FJUrMW+W7XvSTJZ2/LBN+E=;
        b=jHD/+qucQKmgdcHS5g9A/KmTMrdOYwiYV102d/kTZMImavWn4QaApT7i/IeCgmtEdR
         NwPMw2KEFqlL5sAjsBz/6bkpVBgKGuw2Qv5jgp32KAubKEIIy0ioBRk9Gr0voTK29Ew9
         T4pPsROhniV9JiEtCKEH4bt1ZcGYozAWEErTrxWc2z0D1dJvRDwb4KpO7tfW989kw3K2
         A2m++WLeqL2IDVwqs0q/O1toUuOSpVPL6WQVHCfgFkjOj81AShnoh2iNgXHvkERtoi3N
         CZAzIPcYihbAF//I3JUOChUL6Hs8SE11blGqhEKZJN79V7BUyNBCAm0fctE1b9H7D+xt
         oHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243873; x=1749848673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYyyMyesBqRJnMoKNeW65FJUrMW+W7XvSTJZ2/LBN+E=;
        b=NCVaIEgJwcY7GQTL3flVadvrAOEhnqXL1aOgvkD36C6bni4xQzh2An65dor+tsgIXx
         Z8CEEfA4YP98kpTgGlXE6LS48f2eix5dCq04JSi1awvLGuetFwIjfTxVN+KgevxlzHD+
         j4PsFPwysYVX0dlWZn32DNEBLljA8Z0iM7MamyKfHrvM0quBv3X+1s82I7on/5HylnSj
         sSupffVqmwJyADRas8fjzihPqEnckXA38vbXh7TzTQJHrNXSFB4N5tpbid+e5jkgg/ap
         VJaJCifAaUtBp591c6y5YYwp2gUkCuqG9wVCSK6TRRoLen0tAACP0CHzVXqEH6o5Ax1s
         5YCQ==
X-Gm-Message-State: AOJu0YxzMXaCDjS7Vnk8TfXz3xMacpYuP0UafBaVrjRVOvKTnFQu3xDV
	qXmjoEUQXIvwxpQUvAekP15+B5laA7gWkUwQHtJgP8UXW10vFsVaUrULKxLtMsrW
X-Gm-Gg: ASbGncuKM/6A1ixwEjRXLpUaJyil0TxgImqszq3bPtNTPJv30h/arRm8mxgWqXg7MoS
	MvrQvBu3/YW9c0/OozQfZqBCa9zgHxLngDmN/kDJ8+Th9K7NIYftoiaRjZKRkF1AK8x06lxWqRE
	0jduVANPERoel6IXtzziU3eYiqkN+t+91kmoFafi32ef3lnTvwGMuNzNJ8ft4AMMmCLGEPxpuL+
	tBFdBrhA51xnv6FK9bzuJk2mwyFfuTwGOU7ub0yl/H8TpP64eg/1mo/AzLyiaT+uohxb3/ysmYB
	f8g8oXFeO8pHOEhr5BZMiYqbAN35zT+aXuMZXnawVPe1oUM=
X-Google-Smtp-Source: AGHT+IHddICfJOHZfQLF/VdEe+efNMi1BXk0MLsOVj/8L9c+zGeij6Ezw2Dkeqf2JWhHKuFP71PVxw==
X-Received: by 2002:a17:90b:5291:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-313472d3210mr7886458a91.7.1749243872700;
        Fri, 06 Jun 2025 14:04:32 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:04:32 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 03/11] bpf: frame_insn_idx() utility function
Date: Fri,  6 Jun 2025 14:03:44 -0700
Message-ID: <20250606210352.1692944-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606210352.1692944-1-eddyz87@gmail.com>
References: <20250606210352.1692944-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A function to return IP for a given frame in a call stack of a state.
Will be used by a next patch.

The `state->insn_idx = env->insn_idx;` assignment in the do_check()
allows to use frame_insn_idx with env->cur_state.
At the moment bpf_verifier_state->insn_idx is set when new cached
state is added in is_state_visited() and accessed only in the contexts
when the state is already in the cache. Hence this assignment does not
change verifier behaviour.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa8c227775a5..644ffc23db1a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1963,6 +1963,14 @@ static void update_loop_entry(struct bpf_verifier_env *env,
 	}
 }
 
+/* Return IP for a given frame in a call stack */
+static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
+{
+	return frame == st->curframe
+	       ? st->insn_idx
+	       : st->frame[frame + 1]->callsite;
+}
+
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	struct bpf_verifier_state_list *sl = NULL, *parent_sl;
@@ -18775,9 +18783,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 	 * and all frame states need to be equivalent
 	 */
 	for (i = 0; i <= old->curframe; i++) {
-		insn_idx = i == old->curframe
-			   ? env->insn_idx
-			   : old->frame[i + 1]->callsite;
+		insn_idx = frame_insn_idx(old, i);
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
 		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
@@ -19470,6 +19476,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		state->last_insn_idx = env->prev_insn_idx;
+		state->insn_idx = env->insn_idx;
 
 		if (is_prune_point(env, env->insn_idx)) {
 			err = is_state_visited(env, env->insn_idx);
-- 
2.48.1


