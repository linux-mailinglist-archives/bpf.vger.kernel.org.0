Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D46ED238
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjDXQL6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjDXQL5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:11:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E3883D5
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:11:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b60365f53so5934190b3a.0
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682352714; x=1684944714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFH1ZI4ARS2Cpy3G0vNM1sWUYASstdY9e7j3GD3BI4w=;
        b=aUG/SHUdT0EGaXWMggjFmvFqM5P9E1sIWCp+vzrMhLw89ob+KZikVmjB/2SCMoVwp6
         W4trLmAt7AtFSMDB1ngQ4ercbG464DaFbgF4HTjGwpblzo1noUQtiAc02V3N2o47A7BH
         y//DgwtXShZp8NNTYieGNnZE1M+UrSXTlmCN+MeOLQl3g0iT+VHBu1TT91z/NatQj9Zq
         FAmcU6C+Rpokp6wrT6dz/Scuyak7X6DIIwSLPd7eXlaFkXndG6Jwb8tEgaldGQdC3kMa
         /s7PeQ6cKkJnf/psfSmHAfhrIsrFAsc+lS91Kver3kRApoCHP1Xz+yS2jcTd4TfirCQP
         ctLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352714; x=1684944714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFH1ZI4ARS2Cpy3G0vNM1sWUYASstdY9e7j3GD3BI4w=;
        b=FWPDpFBgM48s3GZhghCdm7d8tW6RBThygdOhhCdO9/LyCEi8JLngL7gQk2xPsM624T
         pgNGuADVmV+v+F4Rmo8BCeDBfkL0VFL27uhECruGvhHN/mzSoPRBu09FW9K0st1fHK83
         DiMemA/nbhUeyOEV2++6TXyWPnMHQ0riPQIjTa9u1GwXGITQ6ccelv83pjqfA/Z2ZZOM
         SFvbhYxGinMGrvE88eSIvisWNlav+haWveG0B+Vsgy0nt22bC6xpIwgcSwBMnyR63MBw
         3nhd2XByGCBWm4nMrGAiiAlysMI9CNvRiPCetzuk4hjx9PTftLeqPnkXtoGiH8iJElpL
         wTPQ==
X-Gm-Message-State: AAQBX9cZ2FiPJfTYJApvKHy0IdDiqMSdYQ2ff7g673p8/e1P/wzbywXF
        3+GQjzThC5hnfVmK4HssAmI=
X-Google-Smtp-Source: AKy350YHnX3zYX5N7qs6GHi9rHcm63Dc/WkSQY/QX+xAY1kpwWEzcrg79BWFSMDmI/wCiYhfl/4A9g==
X-Received: by 2002:a05:6a20:5d8a:b0:f0:d50c:4ac5 with SMTP id km10-20020a056a205d8a00b000f0d50c4ac5mr13219110pzb.51.1682352714593;
        Mon, 24 Apr 2023 09:11:54 -0700 (PDT)
Received: from vultr.guest ([64.176.50.146])
        by smtp.gmail.com with ESMTPSA id 20-20020a630514000000b005142206430fsm6775729pgf.36.2023.04.24.09.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:11:54 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Add __rcu_read_{lock,unlock} into btf id deny list
Date:   Mon, 24 Apr 2023 16:11:03 +0000
Message-Id: <20230424161104.3737-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230424161104.3737-1-laoar.shao@gmail.com>
References: <20230424161104.3737-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The tracing recursion prevention mechanism must be protected by rcu, that
leaves __rcu_read_{lock,unlock} unprotected by this mechanism. If we trace
them, the recursion will happen. Let's add them into the btf id deny list.

When CONFIG_PREEMPT_RCU is enabled, it can be reproduced with a simple bpf
program as such:
  SEC("fentry/__rcu_read_lock")
  int fentry_run()
  {
      return 0;
  }

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5dae11e..83fb94f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18645,6 +18645,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 BTF_ID(func, preempt_count_add)
 BTF_ID(func, preempt_count_sub)
 #endif
+#ifdef CONFIG_PREEMPT_RCU
+BTF_ID(func, __rcu_read_lock)
+BTF_ID(func, __rcu_read_unlock)
+#endif
 BTF_SET_END(btf_id_deny)
 
 static bool can_be_sleepable(struct bpf_prog *prog)
-- 
1.8.3.1

