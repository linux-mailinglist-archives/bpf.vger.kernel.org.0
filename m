Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D44A59640C
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiHPUzr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 16:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiHPUzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 16:55:46 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467F074376
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:55:46 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id v65-20020a626144000000b0052f89472f54so4216417pfb.11
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Tnxh09mMigEObNT8d1AOsWhAz1/ozMeGIpXEVIgkx7Y=;
        b=E1r9/o0vUU2ivMM7W+AZ6k7lK/mBTiLQceLw2XRFWxAFs+1iXzHTxF5vfe4Y1vV3cL
         kIPf4uBI0iNjd3WuYSHNECs2/CC6fwh2DgkSRnxh1V9myuzEkfQdJRw7J0la6mAsmmR+
         AtWvJ/IJewHpUeQyQ2BlnrOpO7Xqya/tWMasAkZpgCNrMRmoys4QN5OoXkmeJdLoCvOj
         FDqMNITTc2XjHsSL31fqhxCHqx+HCwA9j6h+ufIqcSbGs0fed0IJOSkYueyPTkcZgqqt
         YHQmq0Ioj2/zr7od+qRea42Cf0SP8AK8dqvrr7GZyOfRYYPCbaCr/e9i6/yNUzKq0iy5
         6Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Tnxh09mMigEObNT8d1AOsWhAz1/ozMeGIpXEVIgkx7Y=;
        b=rB3WFl0L+r3NSBLmoTdFv+kR+V8+iEeq8p/C6w9wySJkeUdP/3nzAmrPF0QDtNDHpq
         KnNgBHefZ+vjeTU2cpJKF0MVdj7aH5EnpnSFDRaws3Ks6WAzE3YIbMfRuElUa++xGLyo
         Olb8TixwDA7G+1gIhAILottzRK+G3AgHnBdbVQpCU5o8J01HumOkqGGubLbPYLlNg6zO
         5SUPTMTY8RlWluXIxvFRlpJtaBLWdJTSkVjxld2vjN6M7R7iLgueIAX5NFszV4vwVtQ8
         jOPTrpZG3RqlBckzQm7LbwfYRW4W5sSOJbxTAH/X2t4ai3ghfA55RFiO2QrZNUMO+LkY
         4KrQ==
X-Gm-Message-State: ACgBeo2IXdhqJab7nR7uGAEYMZ9X/iJS64GC1EvqzQ9S4vTgXuL8Dj5V
        t24ikpcW1HGO3RifKqtAWUCJnDlLR2qwQXh/QBN1anHRo72HNeaUBsRU/dPut5TrTiYlTUJF9qp
        6rXeIn2ePgJoNCBivP/klrkyw4j5MgI/SyrtJ4uc9MHRoq9ZAq2dMDp7FCy9Gqag=
X-Google-Smtp-Source: AA6agR4kh46MfTnNmY7hWP81gqMBgXm5cam87S6Es8noSzU4cYxWReBe+XMNXF/oqNh1EvxwKx0vuh6G7ffXqg==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:aa7:88d3:0:b0:52e:ade6:6192 with SMTP id
 k19-20020aa788d3000000b0052eade66192mr22776201pff.41.1660683345768; Tue, 16
 Aug 2022 13:55:45 -0700 (PDT)
Date:   Tue, 16 Aug 2022 20:55:17 +0000
In-Reply-To: <20220816205517.682470-1-zhuyifei@google.com>
Message-Id: <20220816205517.682470-2-zhuyifei@google.com>
Mime-Version: 1.0
References: <20220816205517.682470-1-zhuyifei@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf 2/2] bpf: Add WARN_ON for recursive prog_run invocation
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jason Zhang <jdz@google.com>, Jann Horn <jannh@google.com>,
        mvle@us.ibm.com, zohar@linux.ibm.com, tyxu.uiuc@gmail.com,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recursive invocation should not happen after commit 86f44fcec22c
("bpf: Disallow bpf programs call prog_run command."), unlike what
is suggested in the comment. The only way to I can see this
condition trigger is if userspace fetches an fd of a kernel-loaded
lskel and attempt to race the kernel to execute that lskel... which
also shouldn't happen under normal circumstances.

To make this "should never happen" explicit, clarify this in the
comment and add a WARN_ON.

Fixes: 86f44fcec22c ("bpf: Disallow bpf programs call prog_run command.")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 27760627370d..9cac9402c0bf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5119,8 +5119,8 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 
 		run_ctx.bpf_cookie = 0;
 		run_ctx.saved_run_ctx = NULL;
-		if (!__bpf_prog_enter_sleepable(prog, &run_ctx)) {
-			/* recursion detected */
+		if (WARN_ON(!__bpf_prog_enter_sleepable(prog, &run_ctx))) {
+			/* recursion detected, should never happen */
 			bpf_prog_put(prog);
 			return -EBUSY;
 		}
-- 
2.37.1.595.g718a3a8f04-goog

