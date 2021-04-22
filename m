Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CAA36898C
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 01:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhDVX5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 19:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbhDVX5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 19:57:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9075CC06174A
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 16:56:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x7so46470975wrw.10
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8D036QsY7GYftxsKacpjO/XIVUD2k3lhmMGNnQd+Y8=;
        b=Zd+26HtHAfUOl0+VDy8myB272bVaiz8OT9hUu5v/BdFLFKv6N4JMB5Rv5++sfEiVH7
         8xSpk13d5brnnhuEnagpj6i5XgNkkHOljRMepUfwVdtTn5M/KycVrAYLk1o4407Yl6uA
         WyHSiQctLmO3WEVPW4Jr3ybIFjczXIYMLdIAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8D036QsY7GYftxsKacpjO/XIVUD2k3lhmMGNnQd+Y8=;
        b=EWQqV4ZeGEHJmdloJVZYH+we3375vKBp1HW2g4O9l7YnMDNYCkUGgDvq/bcM9BRzxJ
         N+rQBNKv5X9umy83l3c1id7rdsVztKK3g5rVipsS8AB7ei1lYAi+a3KFRH+apLKKPzAL
         nOTHNFm8/f+e7gEzNF4wOTyDMbgrD3C3b80YT7hRsIPYanTlhe+NMu1KwSZJw9bMrLR8
         EueNk3lLCy8PBku9bOYF1f0HGw3Ry4ZwkolBVWuyrBmWBXA1Cb83HUbva1i/bztWeRJP
         jKTfDEJVuJ1TXH0xAGdT9jEcJwLJ0w98xtr4ntkLvA4TXDSrs8djCLY72lIeqkrQ7rWY
         7uww==
X-Gm-Message-State: AOAM5334tDpo9R07pgw7+kgJlBzqu7WbairGFRXfKQRNs7M0BmBikG40
        L8VZNz0k4H8QPqepVTd5zBKzvX6gVMFOFw==
X-Google-Smtp-Source: ABdhPJzziVEk9OApC/D9HoHdo3L17beTvpGWyrUsvI1Z+SHRjsdYxzQhFOeIc0aZ8yaywZWy0ZHNWQ==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr956444wrs.330.1619135787133;
        Thu, 22 Apr 2021 16:56:27 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e4b7:67ca:7609:a533])
        by smtp.gmail.com with ESMTPSA id t20sm8201149wmi.35.2021.04.22.16.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 16:56:26 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 2/2] bpf: Remove unnecessary map checks for ARG_PTR_TO_CONST_STR
Date:   Fri, 23 Apr 2021 01:55:43 +0200
Message-Id: <20210422235543.4007694-3-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210422235543.4007694-1-revest@chromium.org>
References: <20210422235543.4007694-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

reg->type is enforced by check_reg_type() and map should never be NULL
(it would already have been dereferenced anyway) so these checks are
unnecessary.

Signed-off-by: Florent Revest <revest@chromium.org>
Reported-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 59799a9b014a..2579f6fbb5c3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5075,8 +5075,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		u64 map_addr;
 		char *str_ptr;
 
-		if (reg->type != PTR_TO_MAP_VALUE || !map ||
-		    !bpf_map_is_rdonly(map)) {
+		if (!bpf_map_is_rdonly(map)) {
 			verbose(env, "R%d does not point to a readonly map'\n", regno);
 			return -EACCES;
 		}
-- 
2.31.1.498.g6c1eba8ee3d-goog

