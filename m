Return-Path: <bpf+bounces-15043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE96B7EA9D8
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 05:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D29C2810BA
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281FCBE4A;
	Tue, 14 Nov 2023 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0GmaRme"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7CBE4E
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 04:54:59 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBBD18D
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:54:57 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6c415e09b1bso5187571b3a.0
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699937697; x=1700542497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXzT+3Ak0JHrKHlBli6RvkJW17J45KrF6p/rzIgNF8c=;
        b=O0GmaRmeNQiQ2LvSTBr55IN7K1uE4P4WoSuezBpptmTBMkO7KBxQXRc28tRU9pgk2E
         q7IgDYpZ/erl+k5OizEdZNWvGrnF9Z+b3dgcctHSWOjxDgYRWCw2xyMoX+ABXNA05fiq
         soOmig84vJzWfaN7rl+EZNn5Y5o6ITrQ4xsxtXNOaLTd04DzeH8oLlkX/9kj/sskIIto
         uhXWwM8YSrypVeQYCS50dSVWw0TWQ3cok7VT/c1Tb6IHm93eGs+fYB9GsFxHo/NzAnKL
         mE6s6Ny9yxpW3UbYFIGxgh8JmySCg8Epw36T+oGlaCw8tMkO54plAxNx2qL8r3gZDxqE
         K1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937697; x=1700542497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXzT+3Ak0JHrKHlBli6RvkJW17J45KrF6p/rzIgNF8c=;
        b=IccKdvzfqhMMGF53PTDtFk+gMxz4Tm1nSOY65AOz+tM0zQPqXC0CkSRI6rpglfSocE
         bjsQDOj9Ywo/z4E3n5/SpK8g1pTccebhQG9hSSFHlETYH2a7eTAeRTBlkPKdEOFkzJ9D
         A72NRXYrotTstXmtj/tR+UPl+QG4XqsZd1dLt7wPxpZPgpBmugZgDJWLGgD+AAPk4N6s
         YuNXWX0M58bPtuo86DfCF1SptGyXl5Km0l4OjMPlurjgHajXJBWLuCdlFMkC4Q3ik2mw
         HyvpLaYEktZKA5bmCm6t26b0cMu9iNjujjzHgQm7cLVhY3XYO6Tzk7EBAwn3/3tn97N6
         9MrA==
X-Gm-Message-State: AOJu0YxcWyTcOyeJYPqQgvYJyNtqwi9iK7mR2Qj7DOnKUz0OyA6cm/u1
	xZHd0dcXtsLIc+PmzncUPWY/oWAMy7q6dy9qaDk0P9zILdhLzbvvoVBHoTPlRt7/KjcY3k+pDKb
	SEk3XGZ20RXAc8Wk8EnCijGbDip49b33siJLxwfBZrdqERNRlYQ==
X-Google-Smtp-Source: AGHT+IGWF7XSwqLBEK1wJwVpXO9lb1cDKDlPlaS4aLH7mH/s7E9StMeoY6zfvu0D4aRcQHugPQG5prA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:93a4:b0:6c0:f86a:8d85 with SMTP id
 ka36-20020a056a0093a400b006c0f86a8d85mr2965314pfb.2.1699937697188; Mon, 13
 Nov 2023 20:54:57 -0800 (PST)
Date: Mon, 13 Nov 2023 20:54:52 -0800
In-Reply-To: <20231114045453.1816995-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231114045453.1816995-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231114045453.1816995-2-sdf@google.com>
Subject: [PATCH bpf-next 1/2] netdevsim: don't accept device bound programs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	Dipendra Khadka <kdipendra88@gmail.com>, 
	syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Commit 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
introduced device-bound programs by largely reusing existing
offloading infrastructure. This changed the semantics of
'prog->aux->offload' a bit. Now, it's non-null for both
offloaded and device-bound programs.

Instead of looking at 'prog->aux->offload' let's call
bpf_prog_is_offloaded which should be true iff the program
is offloaded and not merely device-bound.

Cc: Dipendra Khadka <kdipendra88@gmail.com>
Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/netdevsim/bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index f60eb97e3a62..608953d4f98d 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -93,7 +93,7 @@ static void nsim_prog_set_loaded(struct bpf_prog *prog, bool loaded)
 {
 	struct nsim_bpf_bound_prog *state;
 
-	if (!prog || !prog->aux->offload)
+	if (!prog || !bpf_prog_is_offloaded(prog->aux))
 		return;
 
 	state = prog->aux->offload->dev_priv;
@@ -311,7 +311,7 @@ nsim_setup_prog_hw_checks(struct netdevsim *ns, struct netdev_bpf *bpf)
 	if (!bpf->prog)
 		return 0;
 
-	if (!bpf->prog->aux->offload) {
+	if (!bpf_prog_is_offloaded(bpf->prog->aux)) {
 		NSIM_EA(bpf->extack, "xdpoffload of non-bound program");
 		return -EINVAL;
 	}
-- 
2.42.0.869.gea05f2083d-goog


