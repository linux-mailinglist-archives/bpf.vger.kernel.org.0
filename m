Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB20AADB3
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2019 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391820AbfIEVPg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Sep 2019 17:15:36 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41389 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387731AbfIEVPg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Sep 2019 17:15:36 -0400
Received: by mail-pl1-f202.google.com with SMTP id b23so2227840pls.8
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2019 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5OIWaQS8XUylUqWEOLvRcQ6wvtAGUWcmHb4qQooXQU4=;
        b=sqoOcBxZdlqGDWySWP2Y/co94HGedfimwCSXcJFCDa2CSHTgUIbVs4Pv6YfiqW989D
         qwxLXD2E6ccpMCJrXFqhjsQ8KvKmii4DOcdayDCxOPHgZnS3MYlw7VykblxC7tziuiWg
         TGPazBMqwY4jU9+ikaAjXWzQA567E4smuiqVvfBzdgaMlJPhw+KkxBjnb4RpotPIP0yv
         4To4Fb74sAf5hCcy3mrBjhnNGk5/27rRSbZnG99BZMVY57d6quzmuw/KdICvu3J8iC9a
         ndMLLbyFrE67/RIXYeSI2gDac9o0MrmV7qytiMO9xmjTphHOMt5lwQ4Jjd8n6/kFiDV6
         qRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5OIWaQS8XUylUqWEOLvRcQ6wvtAGUWcmHb4qQooXQU4=;
        b=V+6xdeXWSXem0WlUXeeL0zrlyKKiha0nEKpityjN9ZVDnH1ajRyNzRjP75o7at5wmd
         FY68oFiAkiZv5JRISaUhofEHFQe0v4ObwkU06kjHJsaPmUT4Tpg8nPV377tcpUTawBkd
         Ah+RLkkynj+F1rn37oZ3pqzG9za4Oyk3oFzw9HqNf1g5+0a5HiVotF/9juZbk5TlESIk
         +QsIvZQP2yDD9s4yEy0fWoRND41bESJxNjf1+puD5Mey0Rnl2fmCXHRKo2mRWr8F1P98
         oOT8HhUnwrKQmy3w/WW3hx9dIf2qcaWwLl3ccKLMlp1o3g1oorxvxX2OmLe3T3101eTZ
         IT4Q==
X-Gm-Message-State: APjAAAXLIARkilqmSkJRZitS4THmhqkus0UIV6p/RlGXyXAuzN0JymBO
        jdv/OfDTvVgqtvzpjK2UzqxyqHvwav5ue64F3pY=
X-Google-Smtp-Source: APXvYqwZtsOP4oeCbgdcEYz4SC/6uGacnOnUYdFPlg0VekmO8GAS2KcyDuLyw3ItW3lkQRTZoimV43SVKTXC9aSch7E=
X-Received: by 2002:a63:2252:: with SMTP id t18mr5065062pgm.5.1567718135010;
 Thu, 05 Sep 2019 14:15:35 -0700 (PDT)
Date:   Thu,  5 Sep 2019 14:15:28 -0700
Message-Id: <20190905211528.97828-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] kcm: use BPF_PROG_RUN
From:   Sami Tolvanen <samitolvanen@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Tom Herbert <tom@herbertland.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of invoking struct bpf_prog::bpf_func directly, use the
BPF_PROG_RUN macro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 5dbc0c48f8cb..f350c613bd7d 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -379,7 +379,7 @@ static int kcm_parse_func_strparser(struct strparser *strp, struct sk_buff *skb)
 	struct kcm_psock *psock = container_of(strp, struct kcm_psock, strp);
 	struct bpf_prog *prog = psock->bpf_prog;
 
-	return (*prog->bpf_func)(skb, prog->insnsi);
+	return BPF_PROG_RUN(prog, skb);
 }
 
 static int kcm_read_sock_done(struct strparser *strp, int err)
-- 
2.23.0.187.g17f5b7556c-goog

