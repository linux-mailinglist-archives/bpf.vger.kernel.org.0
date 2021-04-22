Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA69636898A
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 01:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhDVX5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 19:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhDVX5D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 19:57:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355EC06174A
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 16:56:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so4990235wma.0
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HxqQ0tc545eSPSWj2addg3aZ+PCzZIXBWlhAkDCX6x0=;
        b=RKupU/wnuOgyevaDTro8Y+iDWilAd7/JHGW0xB3YhcmbXuGyNEIDXV76M87As44Km8
         rsvS5ja3lJC26AG3M8tR+Qb1rS1yV6Repbrr/W3KAYn10one5hHjT+5Ztx4GXZtYwynH
         oFYpbGoQUuZPbg+aHReW6cTU5ldE4igBFMTBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxqQ0tc545eSPSWj2addg3aZ+PCzZIXBWlhAkDCX6x0=;
        b=jnrEwkLakJ725QQ6xAzi5KRwJqBCoY5q78LTvlZ6X6fbrxWDq7GRtTZk2eR+4hzzXC
         rEXRG3wsLcEaq1rmNUHs3tWtbXN7ColCjidutrkEnsNTqpTkYPoVcdKnY6wKgT1B0dg4
         1zsgUEB7xfzGdmCpE4qCVGMLge894plD6sd9/NusU2bcxsLSq3eXChdts+JhJRgjp50P
         K/jc3ytiTg7Rrg5MBCMen2VMZ0TK/Ex7WNF4eoO2YJrk1E9cD33+Hx8IIgghqw6/ejK0
         9W2bDonr04auBpsJorAfnxRDCTcoohEPwZSVAv/wCcCOp7sp5bScg6VlIFqKrLXKAumO
         7zuQ==
X-Gm-Message-State: AOAM53360dhWCu9JU10I29iC+R+2MHNX9uYQN0FQYKDOarBgNgLuzkGW
        icCxtGfG699HMx3jN6Qf9huzQ+eopxSVGQ==
X-Google-Smtp-Source: ABdhPJy9xmIqjGbVYuBPDCpmrvAOvjn8wjIR8Ltcq9C+jOFoBsRWNzOT6ztEfoimb4Sov8KJv3gFcA==
X-Received: by 2002:a1c:6646:: with SMTP id a67mr2584324wmc.86.1619135786207;
        Thu, 22 Apr 2021 16:56:26 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e4b7:67ca:7609:a533])
        by smtp.gmail.com with ESMTPSA id t20sm8201149wmi.35.2021.04.22.16.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 16:56:25 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 1/2] bpf: Notify user if we ever hit a bpf_snprintf verifier bug
Date:   Fri, 23 Apr 2021 01:55:42 +0200
Message-Id: <20210422235543.4007694-2-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210422235543.4007694-1-revest@chromium.org>
References: <20210422235543.4007694-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In check_bpf_snprintf_call(), a map_direct_value_addr() of the fmt map
should never fail because it has already been checked by
ARG_PTR_TO_CONST_STR. But if it ever fails, it's better to error out
with an explicit debug message rather than silently fail.

Signed-off-by: Florent Revest <revest@chromium.org>
Reported-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58730872f7e5..59799a9b014a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5940,8 +5940,10 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	fmt_map_off = fmt_reg->off + fmt_reg->var_off.value;
 	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
 						  fmt_map_off);
-	if (err)
-		return err;
+	if (err) {
+		verbose(env, "verifier bug\n");
+		return -EFAULT;
+	}
 	fmt = (char *)(long)fmt_addr + fmt_map_off;
 
 	/* We are also guaranteed that fmt+fmt_map_off is NULL terminated, we
-- 
2.31.1.498.g6c1eba8ee3d-goog

