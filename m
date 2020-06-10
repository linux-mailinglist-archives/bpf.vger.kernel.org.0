Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0BB1F5B5F
	for <lists+bpf@lfdr.de>; Wed, 10 Jun 2020 20:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgFJSl4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jun 2020 14:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFJSl4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jun 2020 14:41:56 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5997C03E96B
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:41:55 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o5so3435985iow.8
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbcSo4RfZ5F0jLQZc36bmvHPKNqBwM6BzqCNRAO8Yhs=;
        b=f5iKckIjfLs8BFATlOXzQwsaG3r3FiSrzXkyS3Z6fwRppFLXh+5XxhZiznU/HSlL1h
         ZbLj1FlUbWhXDahaRZsnESdIFh76Bc65mi5rpK659oQlUw90miuYUpRr4i+7rEFHbZYx
         AYaTc0M0HwPl+dgjKNqn8blx/09opSDmgUnKyvTMbD5l4O8NWQtNQdAot8eKnrO5E9We
         zqQSMLlw3UF+jRx0mMMvkUmSI7C6pvkQWvaok/a6wseMoOXICtkNWaWwfW8fwSirDO/f
         kULpRf3n/TJuF5iDQni4K41bPlu66uh63OK9HQQ99hk5q4KxT18YoOKF2zFY7VfSoXi9
         eqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbcSo4RfZ5F0jLQZc36bmvHPKNqBwM6BzqCNRAO8Yhs=;
        b=DdXtL2mZ6Q4DSIOwuPn+VpDYkqRzUOwjXUNjtvV5lJkFIC5W8VttY1TLuYzHEGvmKr
         6Jk/MvchXzh/jz4CYCmr5l/Q83mh49/e+g8S7DjyGaYM+DCaKihG9E+vTpl8T3cFzvl+
         T3CFsw8zxwLtauuafKzylgVFgPrJQqyio8PGXAxlmE8Hp43DGwtIzesdHxBxaowIGNKN
         D58GUm4EwmC7gWQXZAlqXi16nBGZ7WMIrcmeT7Ei0zobGjmedXn9hukdN2P1zspCuAVX
         BpkGYk7nxQMT3aOBA0oPc4kK2lopuXqcKx9boSL4ug8ArlWHSe0qCal8vtyt9c7doriq
         yCBA==
X-Gm-Message-State: AOAM531rhvQ7btjPaF2c/ZRX4ulD/IAgmCOmT3YXBlYdhkztTWpDZLTl
        zkxNNxHDtxXE1D8pPxK8EEUrBwtZ/9o3gA==
X-Google-Smtp-Source: ABdhPJx+dWOkdjIvwLBDCfcBN8yZJghKartduWNuekRs4Rk2RSrKNb7O0+uiBkL3qtJGic4rhwV2Nw==
X-Received: by 2002:a6b:680f:: with SMTP id d15mr4712681ioc.148.1591814514842;
        Wed, 10 Jun 2020 11:41:54 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id b13sm319587ilq.20.2020.06.10.11.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 11:41:54 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
X-Google-Original-From: YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf v2 1/2] net/filter: Permit reading NET in load_bytes_relative when MAC not set
Date:   Wed, 10 Jun 2020 13:41:39 -0500
Message-Id: <76bb820ddb6a95f59a772ecbd8c8a336f646b362.1591812755.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591812755.git.zhuyifei@google.com>
References: <cover.1591812755.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added a check in the switch case on start_header that checks for
the existence of the header, and in the case that MAC is not set
and the caller requests for MAC, -EFAULT. If the caller requests
for NET then MAC's existence is completely ignored.

There is no function to check NET header's existence and as far
as cgroup_skb/egress is concerned it should always be set.

Removed for ptr >= the start of header, considering offset is
bounded unsigned and should always be true. len <= end - mac is
redundant to ptr + len <= end.

Fixes: 3eee1f75f2b9 ("bpf: fix bpf_skb_load_bytes_relative pkt length check")
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 net/core/filter.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index d01a244b5087..6cd82c9539a0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1755,25 +1755,27 @@ BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
 	   u32, offset, void *, to, u32, len, u32, start_header)
 {
 	u8 *end = skb_tail_pointer(skb);
-	u8 *net = skb_network_header(skb);
-	u8 *mac = skb_mac_header(skb);
-	u8 *ptr;
+	u8 *start, *ptr;
 
-	if (unlikely(offset > 0xffff || len > (end - mac)))
+	if (unlikely(offset > 0xffff))
 		goto err_clear;
 
 	switch (start_header) {
 	case BPF_HDR_START_MAC:
-		ptr = mac + offset;
+		if (unlikely(!skb_mac_header_was_set(skb)))
+			goto err_clear;
+		start = skb_mac_header(skb);
 		break;
 	case BPF_HDR_START_NET:
-		ptr = net + offset;
+		start = skb_network_header(skb);
 		break;
 	default:
 		goto err_clear;
 	}
 
-	if (likely(ptr >= mac && ptr + len <= end)) {
+	ptr = start + offset;
+
+	if (likely(ptr + len <= end)) {
 		memcpy(to, ptr, len);
 		return 0;
 	}
-- 
2.27.0

