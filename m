Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E50834AC43
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 17:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCZQGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCZQFn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 12:05:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2C4C0613AA
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 09:05:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o16so6207768wrn.0
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mqp/POwv3HiaquHlLQ1gTN1Ru0BA4oHIhK0qmfN5BCM=;
        b=GPk10D7QKyNGNK62WM1P0nDYs3pFdP5iH+CwIFUKtiMBMRx1SK1pXZZNcIr4r0dD6R
         0bCnup3k36XmYUmZjm26og9Sbue7e4UcKdrL8efhfnP3iKOuZX53/ZP3bn/IgPOrHuj4
         8vGc2v5RMQbhoJeWQp4cJ6L7ND6El5Ywpp7Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mqp/POwv3HiaquHlLQ1gTN1Ru0BA4oHIhK0qmfN5BCM=;
        b=H1MGGWnCZ9pxSRN6vUGVYYFfyn/pRu/viKvRorew21EUYTavUS/yA+9P4ViTTxsmPj
         IB67nPJyRBipEbdXmJUvUNUxX46SotyiX9hW8hTAPlKfq7Eu6n90d3nbd+ltzvbqgwKu
         u/atue4C45AmBASFkWB9yIqEV2ENpY0V7K6GDc9PVKHG7mDFRu+oJwQvg1nqmKGpRvIK
         ir535S7ymvU+wfOG+Vb4MuxKNmM+7alJI2+n6lVV2ponlNg9XMc3MrRu41tnw+cEEUR4
         k2vQZJzYD48v8o9++NioRLhFAsz7BGp/0dPJER0hx6ZB2DsdmGH4TSo98jYmhIpnVF7x
         9Row==
X-Gm-Message-State: AOAM532+LP40pnfW6mSnQBZjJyUlfzSb3jjI+5/WhOhjdlj7b4OB03fH
        h2Trhy02eU+zmKiEFfuZv3QzMw==
X-Google-Smtp-Source: ABdhPJzeLafYdRr/2dkqUCk5gViv+7xxZjUwGkq7UgOvm5XI4BKlgmgK88QvJ/BSIm7Wbvm7U5grSA==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr15395269wrn.204.1616774741842;
        Fri, 26 Mar 2021 09:05:41 -0700 (PDT)
Received: from localhost.localdomain (5.0.8.c.b.e.d.6.4.e.c.a.1.e.f.4.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:4fe1:ace4:6deb:c805])
        by smtp.gmail.com with ESMTPSA id s20sm11692879wmj.36.2021.03.26.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 09:05:41 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 2/2] bpf: program: refuse non-O_RDWR flags in BPF_OBJ_GET
Date:   Fri, 26 Mar 2021 16:05:01 +0000
Message-Id: <20210326160501.46234-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326160501.46234-1-lmb@cloudflare.com>
References: <20210326160501.46234-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As for bpf_link, refuse creating a non-O_RDWR fd. Since program fds
currently don't allow modifications this is a precaution, not a
straight up bug fix.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index dc56237d6960..d2de2abec35b 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -543,7 +543,7 @@ int bpf_obj_get_user(const char __user *pathname, int flags)
 		return PTR_ERR(raw);
 
 	if (type == BPF_TYPE_PROG)
-		ret = bpf_prog_new_fd(raw);
+		ret = (f_flags != O_RDWR) ? -EINVAL : bpf_prog_new_fd(raw);
 	else if (type == BPF_TYPE_MAP)
 		ret = bpf_map_new_fd(raw, f_flags);
 	else if (type == BPF_TYPE_LINK)
-- 
2.27.0

