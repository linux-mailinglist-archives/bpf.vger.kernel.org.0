Return-Path: <bpf+bounces-59936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59873AD094C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921503B4D00
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F24220F25;
	Fri,  6 Jun 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao48c0TD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78C21ABA5
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243881; cv=none; b=hApzbebkv0gPUTaaEhWz5xJ+HOoLn78Qrpz/dmrRTr+WX+FsNkxBZZnZBL1Y+Uvwjgdop8KBIyS6gvCjDZYBUxE6Zy16/tFIcoeD88GeUEiVtBaCK4dheXL/8FnRV5d+bcOI6RXI6JYseBlfA7SLLaJXz9/wFnuj+u/E62EgYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243881; c=relaxed/simple;
	bh=naToFI1KeLYxDvgziDXvb9+iosc+TJBqE8acWKgHMNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6ogdZdfnP1KlOVaHwiQmnWZgY4aehOLsm0UoCeg1yRZctCWGNQOp++rNqCLDorxtnXarOZwwXeWZejPrUzGhOz15B7TaU2SdbMH3gqFTn7eXrWAJ0B2TDP0SeWeoIhW+cLRmpOhVHg12QZjPwjkUrO2SSW8vzCXQjmXJNAu9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao48c0TD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-745fe311741so3022678b3a.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243878; x=1749848678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBB9rWGgbns+rTgZs3xJZWHMeUYcA61fKaHwv5uXTOY=;
        b=Ao48c0TDy/kGYUNsUdH2eBqpPxxkppckOVWLhwfSk4dqxlgMS3+Bt/uBNxp0LHs1ij
         CW0fqp3YY9u8Eqtsu7n9NKXYG5cJKwtpZQe8OfJOToH6yv+QzSTeBcoY9v8iyPnj/Gei
         acVpgZ21X7N/Qyk0+Wq9rDNM4LypfYFyI5F6lRYzfqZBK59KuKvU9fiSuwaoWbgps2tk
         vZiHP9dKQltymwMUD1AHf0yKdlkUR+JLkBDwlPabrY5eA+P1OwqPvjaPb14ynnCDQ5h8
         DV7oTIJXPFWnRskAB22gXM/X/NQbIjaBbIA+hEAeDwVCZrjmlYs1kRJSXk27iqMoqcQl
         qoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243878; x=1749848678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBB9rWGgbns+rTgZs3xJZWHMeUYcA61fKaHwv5uXTOY=;
        b=WHGou2XXSEy6jiy3YLhukrH/DFVmgOsMAYNvPzI4qKWo2QjjCRqtrw6LeEyOkKu0Ar
         ZxYkAz86/4K0CMAyP9OpCmdTtj8yt5NseJoYAm7nQcfw5sUM0uATaQ0ursXiTqMXGny0
         SX3jAiN3DA/Yh1i/f3419by3zIlmOzc90o6CnVOrdtaO+x1DDKbonN6r+RTh1JSJ4DXK
         2CJISVqAE/UJR6T9qAsxe8jYc2Rs1DdA+KmAr4IXvF458bSuKx4bPvTG8KhRv49U5XVe
         iBETvYoe64Dl587nCM4Aol7hUzOnU0rQs4pG56+GUsQjxGS8bzW17HaG/zFyWiwX/NsQ
         9xng==
X-Gm-Message-State: AOJu0Yzgaothgauvcso0lEKnE1vQUGp5lj2LxLear0+I4cF4NDHHPvzc
	L1GIldoBsppOP2oo8sK2MGjNbm4C1RjhUsBXRSEO9Dz39jXwYhVp6wxrQ7jIDO6r
X-Gm-Gg: ASbGncuyqI5k7TSfzzuS35NcheMoKfsRGOwdca+FEPZdMa8srkjSjvaW//aI1vrkqLF
	yTyZr2ZOAJFPcaEAoe+DPcUNgRKpJjT63fvkSHaJVTVxa6LunoXObSYgr1qyPNlBfAAAl9R1O8g
	s8p7fWdbzIZGFAaxDa8SleGbe4flpfQqIeUueKUiN2POIG2cgN1jms4mQQlX6/bIVCrOOpdhCnr
	7MH16MZlmxbzEFphAQ5oHDYKN0Hj+kTl/r71docbdNRGlWKxDc1VVI78UYxp3YkBZupmrmAHgKs
	rIjlFIF/VgELbXR5er3PDTKc6vMONZDoSusJODICXXfO8fjOHlsDPqFYfQ==
X-Google-Smtp-Source: AGHT+IFiRxKAV5d7kXvfeZGSlX/0jttRK3urDRzfeBERC7ukuzzSgetdiG7sgG22lPlusG4xAI1BrA==
X-Received: by 2002:a05:6a20:7343:b0:1f8:d245:616d with SMTP id adf61e73a8af0-21ee255329amr6654880637.21.1749243877919;
        Fri, 06 Jun 2025 14:04:37 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:04:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 10/11] bpf: include backedges in peak_states stat
Date: Fri,  6 Jun 2025 14:03:51 -0700
Message-ID: <20250606210352.1692944-11-eddyz87@gmail.com>
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

Count states accumulated in bpf_scc_visit->backedges in
env->peak_states.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 2 ++
 kernel/bpf/verifier.c        | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 06848291ed21..47444983b353 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -732,6 +732,7 @@ struct bpf_scc_visit {
 	 */
 	struct bpf_verifier_state *entry_state;
 	struct bpf_scc_backedge *backedges; /* list of backedges */
+	u32 num_backedges;
 };
 
 /* An array of bpf_scc_visit structs sharing tht same bpf_scc_callchain->scc
@@ -821,6 +822,7 @@ struct bpf_verifier_env {
 	u32 longest_mark_read_walk;
 	u32 free_list_size;
 	u32 explored_states_size;
+	u32 num_backedges;
 	bpfptr_t fd_array;
 
 	/* bit mask to keep track of whether a register has been accessed
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6cf3a9654e91..54b06f342caf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1647,7 +1647,7 @@ static void update_peak_states(struct bpf_verifier_env *env)
 {
 	u32 cur_states;
 
-	cur_states = env->explored_states_size + env->free_list_size;
+	cur_states = env->explored_states_size + env->free_list_size + env->num_backedges;
 	env->peak_states = max(env->peak_states, cur_states);
 }
 
@@ -1948,6 +1948,9 @@ static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_stat
 	if (env->log.level & BPF_LOG_LEVEL2)
 		verbose(env, "SCC exit %s\n", format_callchain(env, &callchain));
 	visit->entry_state = NULL;
+	env->num_backedges -= visit->num_backedges;
+	visit->num_backedges = 0;
+	update_peak_states(env);
 	return propagate_backedges(env, visit);
 }
 
@@ -1976,6 +1979,9 @@ static int add_scc_backedge(struct bpf_verifier_env *env,
 		verbose(env, "SCC backedge %s\n", format_callchain(env, &callchain));
 	backedge->next = visit->backedges;
 	visit->backedges = backedge;
+	visit->num_backedges++;
+	env->num_backedges++;
+	update_peak_states(env);
 	return 0;
 }
 
-- 
2.48.1


