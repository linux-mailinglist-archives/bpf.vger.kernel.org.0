Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA13FE0311
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbfJVLhn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 07:37:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34444 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388720AbfJVLhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 07:37:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id f5so5086540lfp.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZlR5PU4/YmAeioQRcDed2hFQfaFvK140rZLS4S454Y=;
        b=pHI6U9pRKjgO6ACWmz7LGAOxTgeiHLBfbNv10hbQrC8FE+NZ2i1bNawfwM5NBuWGwZ
         1zyMFcf9blcwhA6V3eZFXiCrXo5ubJpd7KmG+w1s/+lpMqnfWfb09wOxjQMmBbigr5AC
         /livLW1GR9Y0vA+cYLRzExhBVvTm3rt5Kow7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZlR5PU4/YmAeioQRcDed2hFQfaFvK140rZLS4S454Y=;
        b=EGhXj3j14TVdFvfGgLLO3pWxMcaoJeTgvbK279Z87am7Rw1U+RJNtyE452s71Fcxhn
         iN6hyZi0HYwvEM210t9UD/hxzeUrmvYwQ77ValiM5vRTiJc0sEmGbtwNHkhtf5x9psMN
         +j1icC9dQ8T5cXxgcypclF3PYi3zUg+GWxNL7Po8PgoxA7onRQ/NzMKJA2+6M4x/vlaD
         GmoOlDPgV0fi3fQwpKJHV09Etww2QFJCD33ZLoT8CC/KRNrVUnRj1RO1b2cREV+hHYKj
         6Vbka7DItkiCAzOFefu71bfn49E4ELzizt86RAtg9Fk4wkw3KC8cnCqqhgwz+i7awF7T
         nwGg==
X-Gm-Message-State: APjAAAUDiVJgeAf7SfYSQBS31DeovAZagxMyE6EwNPG/ntZrvgw8KiTq
        0D4b0Sl2UHVipqxcvQUWf8BOQ1WCyp5MTw==
X-Google-Smtp-Source: APXvYqyOU0/BVBJiJ8W7YdJ/7zYyeLKHysIabxkAiqlrpbkFYbqPMWAWYb7LQ9S8YZaCzaadpRRasg==
X-Received: by 2002:ac2:4d04:: with SMTP id r4mr8527759lfi.136.1571744257575;
        Tue, 22 Oct 2019 04:37:37 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id 77sm8802847lfj.41.2019.10.22.04.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 04:37:37 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: [RFC bpf-next 4/5] bpf: Allow selecting reuseport socket from a SOCKMAP
Date:   Tue, 22 Oct 2019 13:37:29 +0200
Message-Id: <20191022113730.29303-5-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022113730.29303-1-jakub@cloudflare.com>
References: <20191022113730.29303-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SOCKMAP now supports storing references to listening sockets. Nothing
keeps us from using it as array of sockets to select from in reuseport
programs. Whitelist the map type with the socket selection helper.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 556e82f8869b..77319248e357 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3648,7 +3648,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
 		    func_id != BPF_FUNC_map_delete_elem &&
-		    func_id != BPF_FUNC_msg_redirect_map)
+		    func_id != BPF_FUNC_msg_redirect_map &&
+		    func_id != BPF_FUNC_sk_select_reuseport)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_SOCKHASH:
@@ -3729,7 +3730,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_FUNC_sk_select_reuseport:
-		if (map->map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY)
+		if (map->map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
+		    map->map_type != BPF_MAP_TYPE_SOCKMAP)
 			goto error;
 		break;
 	case BPF_FUNC_map_peek_elem:
-- 
2.20.1

