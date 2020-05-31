Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673121E9647
	for <lists+bpf@lfdr.de>; Sun, 31 May 2020 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgEaI3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 May 2020 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgEaI3A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 May 2020 04:29:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8864DC05BD43
        for <bpf@vger.kernel.org>; Sun, 31 May 2020 01:29:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x1so6261433ejd.8
        for <bpf@vger.kernel.org>; Sun, 31 May 2020 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6hhD1gpEYyyTsG5wna8NX2v+cYMcZ2GZPPNFHidNbU=;
        b=OGJxXLZSHYBkDmS0aWBcuNeJQ0aCQ6lpwg0IelWNG+40n/4Q1uum8+vpztVHsB2cZY
         sHzWBaIsQpNCgju/b+cxfFQESwgIq20xHkNfRW6x3avQz7IYiPgH4EDHmi0zLsoBiQ6w
         CqmW5H3uorXADzOM3C9rbDmr/87Jk6Aljpkgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6hhD1gpEYyyTsG5wna8NX2v+cYMcZ2GZPPNFHidNbU=;
        b=ImVl9du1PlWP/PC+Y7qzAIrPzYPpVQiMD5uSw51ERNdyUmzuzw2MkIGPrFlcAKzL80
         iKECFI1fhx2ozr/J48ihJNli3UBl85RSrNjRiB47dtpwLyJRbN+bnF+9Wd8eiGecmXP2
         ZG4Ev5yw4N1nd3uJ+6sFKssY2l+naUe6T1cBHF7t4z5h/wJIwhn9KldJhRQoMcL1tjAv
         OqCX3ksvOKdf1EaS7S15FpNRxeI6nbLWMoTwEJw8IxwZHaoB/yZAiSX1KjS7hAMNMSS3
         1IwMKmoEUE+yiVtRAY5QNsTUizxpjUNCIn2NypiH0vED6qc1k2FK8eo1SRr0Chyz8gOR
         IFiQ==
X-Gm-Message-State: AOAM531jwGpL842JZspPMeM6IX9++yLQOv97lPBa2G9fbm24pOprzWgT
        wPERdyvZa7BuE2zjUkfmNqHbb/s+0YU=
X-Google-Smtp-Source: ABdhPJxXEeVlpE0iKL373LIknlsYtHroJQJyEUVG50oLhXoNzHULY7aSAulW7u2Q2TNySjDuERTfWw==
X-Received: by 2002:a17:906:3bd7:: with SMTP id v23mr4153545ejf.299.1590913738962;
        Sun, 31 May 2020 01:28:58 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id dt12sm12089119ejb.102.2020.05.31.01.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 01:28:58 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 05/12] bpf, cgroup: Return ENOLINK for auto-detached links on update
Date:   Sun, 31 May 2020 10:28:39 +0200
Message-Id: <20200531082846.2117903-6-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200531082846.2117903-1-jakub@cloudflare.com>
References: <20200531082846.2117903-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Failure to update a bpf_link because it has been auto-detached by a dying
cgroup currently results in EINVAL error, even though the arguments passed
to bpf() syscall are not wrong.

bpf_links attaching to netns in this case will return ENOLINK, which
carries the message that the link is no longer attached to anything.

Change cgroup bpf_links to do the same to keep the uAPI errors consistent.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Suggested-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5c0e964105ac..fdf7836750a3 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -595,7 +595,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 	mutex_lock(&cgroup_mutex);
 	/* link might have been auto-released by dying cgroup, so fail */
 	if (!cg_link->cgroup) {
-		ret = -EINVAL;
+		ret = -ENOLINK;
 		goto out_unlock;
 	}
 	if (old_prog && link->prog != old_prog) {
-- 
2.25.4

