Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDF6E4D8E
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjDQPsE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjDQPsA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 11:48:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03BB728F;
        Mon, 17 Apr 2023 08:47:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso12861911pjr.3;
        Mon, 17 Apr 2023 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681746478; x=1684338478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/znH9BN5OMTUR3LeE3OihOiuQbmxlh1YZhsXL8dYfT4=;
        b=JPDSEWjrfgUWXIj6zj2+c3dq3PtMSLRSwtABCi6ebTbg/B8kbgq0EA7gKPxEVRA3WV
         hP+XjUZPUP0SGkrk5HKYDhXP5u1E/3xaou2q/7ZiPTsp+rIO8t2xcXtCxcBiCsOgVb8v
         nNZqWgSvvBCYy5xukci8Ucp4iN7AxiGZl1lCVYEVZ1dmkyeWQVu3Su83WOOi7AMRtvsB
         +o6Y2r605Q+I7/nzplGvh1OLYTjTj4D8BY1+eeYdDGt6kyzUP6hLxgq/cq1a5+8gM1u5
         6sigqvrWx8TAHtw+nUgXdRF7ZwmHd/7f2+AOBWhYzqGlvypnoN/R/k2kS43l9mpyOkod
         WKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746478; x=1684338478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/znH9BN5OMTUR3LeE3OihOiuQbmxlh1YZhsXL8dYfT4=;
        b=ksoADueJOyC6CNjJ4caou804bES3ktO1NqgH/buRM8XIKzNNAmlv7gbe/F19HFEgKh
         P0l9TfueN6E0iz8IvOx2G/xzQ+OnDG4WbtoIJNlX/kituVcqlVNQJLMFgB+uBTL08Yzq
         RYsxrnCdKyGfcRS+GEBFNtXc34DFMm4FqkulrjSujO/2cut2VTnqD8I4poPledsMPCJu
         X7iSxMWgyVa2Ipb4Q41jKOGM4w0otysLST2rCcEzoGhSte1c7Of3swr4teRoARyXXPGB
         ClPzigE7WeNsj2jugqssWbYRQaLAoXFz2pLxLAOvO7R6UsQjy1aHOf+I91Sfsqyfgd6I
         dydQ==
X-Gm-Message-State: AAQBX9fVy2a2Sc+hEQ12PU6ACy1vAIiwSiyz/y97uyZDZuqwNDmEGuJ4
        6B0/Hw+eyg/6tWDVWzfiBFo=
X-Google-Smtp-Source: AKy350aNu6PaN8hh0owL6/4RkczvLkDLflCyv+SK//mMKuNnR9B/1FvUPbqVcAPaDSLHU2n/r+zllA==
X-Received: by 2002:a17:902:c149:b0:19e:839e:49d8 with SMTP id 9-20020a170902c14900b0019e839e49d8mr11923255plj.59.1681746478068;
        Mon, 17 Apr 2023 08:47:58 -0700 (PDT)
Received: from vultr.guest ([2401:c080:3800:263c:5400:4ff:fe66:d27f])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001a6b308fcaesm4437513plb.153.2023.04.17.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:47:57 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/6] bpf: Add __rcu_read_{lock,unlock} into btf id deny list
Date:   Mon, 17 Apr 2023 15:47:32 +0000
Message-Id: <20230417154737.12740-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417154737.12740-1-laoar.shao@gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
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

