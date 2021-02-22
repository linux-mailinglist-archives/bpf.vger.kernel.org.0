Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58A53212D8
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 10:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhBVJMZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 04:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhBVJLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 04:11:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA3C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 01:11:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 7so18242796wrz.0
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 01:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbovnjqHCyxq8Q7/rENNvfW50//hf67SxGXerY7FIq0=;
        b=AJjkxPsrlrEryAXDUtsYmn+T1nmw6kpPqFU27mZVn0Uvx/JWgLC3J6a/WubWZW1fQq
         5w2oXS8lXjdSyIR/WY9BR/bctYHXa5KZe047nv/NLnS1WkD8gY5GvZDCNcz9AdKe9gfO
         39Vd8c+z77M7S6qZW3fLyEtYVsdQCIvDYWKziCuNPO0MJZ9iEeTRHuuw9jrwh8AnAGNe
         YbsE24fxj1bF0pRvLpL/9IpsOyjnPstejC5qcHUb69sKvsIRE3B8N35m3lrVrkn+45gp
         2MakpI1XkTMj3E6iu6ZSa26v9vagcSkeTq+7KyxPTLRwit91/uU77UJ7gbPyR3c1PD5Q
         2j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbovnjqHCyxq8Q7/rENNvfW50//hf67SxGXerY7FIq0=;
        b=ucFrN77XkGHTJSDCImEvD1r4tbpzLVvb790dHGWbRKw6y823pgSMGn/SdnzvmiacJg
         pN4mYQV117VD5Mm2ndL7oIMvTXy12O3EgXsTBXDLo7I9zo7lN8pVJtjIaB4+k0/yNGpn
         F1AV3cj0z53+UNeaEqxCfQLzYWzAbgMphUke5ZfGTMBa3mJoaIrQCLY4GJPyAUJmBikb
         tMPSZGz3wShawey2NmPaD3zHTkZ3xd9brxnTl/QaJtc47n27J0HG6T/dOAOi4Ojx5cZY
         Hno+1RHAgJqcVAdy0Nenar5Ds8RDsuLyeiSYlpdYcVB0tYQW0l2uiQLo9oMipM8CCngp
         foGw==
X-Gm-Message-State: AOAM5312qPvafirBmBqFDk6g6274J9MNgWC/B/H001Pox+aDpxggiAyC
        THPzIF+2g1N7jAgYjsoj90VsGwhSKkb2Tfm+rs8=
X-Google-Smtp-Source: ABdhPJx2YYBdK/YlJU6ZfkxiIq5ClR9mYD17sLAfWGuYXQ1dWq8LreHdl4Oy+IKTBA5uHN39vNR9Zw==
X-Received: by 2002:adf:e847:: with SMTP id d7mr18098642wrn.367.1613985070735;
        Mon, 22 Feb 2021 01:11:10 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id v6sm29036495wrx.32.2021.02.22.01.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 01:11:10 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v1 bpf-next] bpf: Drop imprecise log message
Date:   Mon, 22 Feb 2021 13:10:50 +0400
Message-Id: <20210222091050.160161-1-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210221195729.92278-1-me@ubique.spb.ru>
References: <20210221195729.92278-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now it is possible for global function to have a pointer argument that
points to something different than struct. Drop the irrelevant log
message and keep the logic same.

Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 v0 -> v1: drop redundant commit hash mention

 kernel/bpf/btf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2efeb5f4b343..b1a76fe046cb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4321,8 +4321,6 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
 		 * is not supported yet.
 		 * BPF_PROG_TYPE_RAW_TRACEPOINT is fine.
 		 */
-		if (log->level & BPF_LOG_LEVEL)
-			bpf_log(log, "arg#%d type is not a struct\n", arg);
 		return NULL;
 	}
 	tname = btf_name_by_offset(btf, t->name_off);
-- 
2.25.1

