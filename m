Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991E81E0E72
	for <lists+bpf@lfdr.de>; Mon, 25 May 2020 14:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbgEYM3c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 May 2020 08:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390492AbgEYM3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 May 2020 08:29:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94099C05BD43
        for <bpf@vger.kernel.org>; Mon, 25 May 2020 05:29:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so16875809wrx.10
        for <bpf@vger.kernel.org>; Mon, 25 May 2020 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okfMkOEy6BJedGaS7fNe8T5pyno8cyE3qtzAy6s5wmQ=;
        b=wEp8gGGNEJrCAy3mYECILXNzwxfDNqxu0dS9KZMFc/s4TJV7gE5pmN4yEcNNIcNfrV
         VmBoZ1HqFa/7bH9E5VY0MsDv+cVjXlXiID2WB6zHKNmDTrJuJUTwUVgp1ADF9gobJGwv
         sHhgiLFDPYOMhRwl3hNs06xgCNcp5lg0t+B1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=okfMkOEy6BJedGaS7fNe8T5pyno8cyE3qtzAy6s5wmQ=;
        b=XlKXjfY0iT+qk7vUV+wghhmnbY1k9fkytdHc+WlQDNePO3TB3o+SLndjhmha/7CQH4
         tQqzriyCIVjs7DN+iZYGh2Xp4SxJGkDO0rmtsdoSclyzeT3ZIzDI8TZFe7ZOfGRSZaZC
         qsESB1Q8AvwMLkafVwo9Te4+Go30nxwEsPvsnXv1vogsKHsgPhGdPWKIODnYYnXoxGBT
         THOeHccJuMNtoO3qK9iJYR85oDBSWzDjilHSDuBp7WubsgAkLqJwSlMHzGEMhp+yUbJd
         QHRdwhkFbd9+URN69e/mzZi37eqodcYQvqn/3PFpbLg/iUhfbdWLQFSmc9IhNeJfz2Oj
         ShJw==
X-Gm-Message-State: AOAM533WKyjxgOgenT0XnWZh+Fy9AXe2VtnrvR9gDGExF+I02tEYTRup
        qkokUm1dz2zFbI6RFnGqsMJW4DnX6G0=
X-Google-Smtp-Source: ABdhPJyJ2iVgeJ7fBQOtbESPYe7+p6XwHcKKH8gfAS9eusHYoFX2/sTGcJKwR1BqBIYaI3hUJ738Dw==
X-Received: by 2002:adf:ee47:: with SMTP id w7mr9504433wro.171.1590409770020;
        Mon, 25 May 2020 05:29:30 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id h20sm18017302wma.6.2020.05.25.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:29:29 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next] bpf: Fix returned error sign when link doesn't support updates
Date:   Mon, 25 May 2020 14:29:28 +0200
Message-Id: <20200525122928.1164495-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

System calls encode returned errors as negative values. Fix a typo that
breaks this convention for bpf(LINK_UPDATE) when bpf_link doesn't support
update operation.

Fixes: f9d041271cf4 ("bpf: Refactor bpf_link update handling")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 431241c74614..f9c86e0579da 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3913,7 +3913,7 @@ static int link_update(union bpf_attr *attr)
 	if (link->ops->update_prog)
 		ret = link->ops->update_prog(link, new_prog, old_prog);
 	else
-		ret = EINVAL;
+		ret = -EINVAL;
 
 out_put_progs:
 	if (old_prog)
-- 
2.25.4

