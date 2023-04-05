Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2496D8AC8
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 00:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjDEWw6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 18:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDEWw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 18:52:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9021BDB
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 15:52:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k199-20020a2524d0000000b00b7f3a027e50so21871653ybk.4
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680735175; x=1683327175;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=69zSbXgaOWhyBbwPsZXjgkehhybiF17AZPRncmEXrvk=;
        b=rWIaZBr+k212Xdy78XkYIfWPJPTphyVHiW3AdxXktpl9dSrRH6B5uAnNmV5KE18Idf
         2UcZL+pXPrpLw0s8wPC79c2mq1OQztT4OC+7jPoqC3RYRI1Zmfut2bCFKjNNS5u1UhGX
         ckUQGl02PzTNXfWfMchaIWwiYKx741CW6nfeMU3FFoitOcMoo0srWDDV17BEKo6C2iIr
         HeLPNqqOIII0Vhv4R9Fr8d+PXyrspnznW4GH4BuerC3/5wEB3M1ni2BcW4RrK0Pqp+ve
         rtIVzUxPX3g42EihJBM8pJQ0Yxb/0Re2Keqr/7rW3MuaMgeizXiBDoD+Y2iYVv4qzYcB
         ILJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680735175; x=1683327175;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69zSbXgaOWhyBbwPsZXjgkehhybiF17AZPRncmEXrvk=;
        b=VWsIzBSlwKS/srL8JB/l/YaO2Ec7/QSuNrDrDpph7IsehJiI+bzIjvLYpMV48Bi81m
         hvKgFubyYY4v15o2UU/SJUaayAvnCQSVjPqbgnSnB7Km8+6HKZVS7fV2rYJZgCJSUmFl
         JJfYp5k26bR9eqYRiXwweQ3MZv9pG76VRvZVRm2tIPGjG0kSyzv/8I4hG6EJwerMOhAK
         eV+TxvNv7YInvZTL24eGtQLx1IEwqx4+Mw9wfyM72WkMIRbJ6BUc//f3gKdgkcrknM9G
         RZ3qgeIvcu6P0OfSaKUJ45/ITQvj9sdVZebcIRehOetvrRtC4wKzCe4PkZ3445ND8C0w
         71lg==
X-Gm-Message-State: AAQBX9fLNpPzFpTRAd95Kz8W0jUtYXlotu3Ph2Pvoar6JrgUWE5IELja
        YDoUrJh9Ey9N4gXUQxr7dmSRlfMV
X-Google-Smtp-Source: AKy350buJh+ylgSt7G7Xu4/rIoDoHTOcOvT2CLgYmRVOTWHChDbW1t/UgEsVxywLGsvIg5pTvjU4odL3
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:8b:282:cd47:a9e0])
 (user=brho job=sendgmr) by 2002:a81:ae1e:0:b0:54c:bdc:ef18 with SMTP id
 m30-20020a81ae1e000000b0054c0bdcef18mr288403ywh.5.1680735175389; Wed, 05 Apr
 2023 15:52:55 -0700 (PDT)
Date:   Wed,  5 Apr 2023 18:52:46 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405225246.1327344-1-brho@google.com>
Subject: bpf: ensure all memory is initialized in bpf_get_current_comm
From:   Barret Rhoden <brho@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF helpers that take an ARG_PTR_TO_UNINIT_MEM must ensure that all of
the memory is set, including beyond the end of the string.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5b278a38ae58..adffb2f87e44 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -257,7 +257,7 @@ BPF_CALL_2(bpf_get_current_comm, char *, buf, u32, size)
 		goto err_clear;
 
 	/* Verifier guarantees that size > 0 */
-	strscpy(buf, task->comm, size);
+	strscpy_pad(buf, task->comm, size);
 	return 0;
 err_clear:
 	memset(buf, 0, size);
-- 
2.40.0.348.gf938b09366-goog

