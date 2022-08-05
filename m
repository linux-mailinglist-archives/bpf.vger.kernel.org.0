Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B662358B14B
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 23:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbiHEVtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 17:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbiHEVtO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 17:49:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CF47B1E1
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 14:49:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7-20020a25ba47000000b00677405b2d2dso3078045ybj.13
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 14:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=7MaHmbvjhjrXHhN5Hd2JmNuqCLNElFu+/Qz1TUQGsGM=;
        b=XE0i/VM2AKUVwDXrI7BSBUWMw8xZL12GqzlEqpo9DCJuNkA2rk48R5GIWi3DkPnewZ
         Wqvf9KpzxAPPV+FGmjzKY47JWe+wrpsfYtvFSHb7DSImp86aYtmySfXl+MACOjjbsl7E
         YSsiFaaLXKUzdkjkTNUYxnprMH6PDTmVSVPM9FeftJ8EKEjX+4ITxuColVd/djrYLv5Q
         TqcPRDDcgfhjG/51ZgCmmTqr/S+HVPaNytx65orUi0h5nGR0lofrgsGKAn5TAUFqiufk
         Gm2cDgi9HxIrq9dUhtauCQN4hSLAgikGj+kw+GAt1YS8s9rH/fyWctEx5ntVb17vS7e0
         OAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=7MaHmbvjhjrXHhN5Hd2JmNuqCLNElFu+/Qz1TUQGsGM=;
        b=ltR5IVHZRTlEchwnC9iDk23XnFGdCnCSU3MPYyCb9elBt9x9ZwkjhCG0YexyWpR/fK
         ja8ZUYZwU4JpVLuKliB/iEDGeBMiRwmzjPN611Kgofzs4sRFfR2/XmRPskMqyeWbWBWJ
         0qCWaKDFix2UkPFpKl9NnO2CYm1KUpBfFsTBY40whdSMWcJhH59zLjhCVjMlK/2+kX7S
         bCAkSCcvD+yqNhn1STd3gGlfQoRqYqYhbA+/UxCGWgo6EEs4vUimYemQ5Jqa72+J/Z1o
         iK3OrMgGxrn65pZVUfqCQv8WsvmtF14Hmu1E3oqt5YaZEMYqPOT16bkeGCuaygJ8Gqzv
         4M9A==
X-Gm-Message-State: ACgBeo1LFSeaqY2D2B8R1ANxSlb7eLiB9j0NfF2BDAncx9/miScZD/gJ
        pRlZv7vRYEc74Vj0QJlhI9Y9TIXKQBk=
X-Google-Smtp-Source: AA6agR7KtTkBAQflnjFdkH6sxoe3pUYKkJuoWbTg/BWcY40LDCHQ5LL4ugM5Gne1On5cT0W2CO7WbylmRu4=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:4f27:97db:8644:dc82])
 (user=haoluo job=sendgmr) by 2002:a25:c695:0:b0:672:9622:ace4 with SMTP id
 k143-20020a25c695000000b006729622ace4mr7456744ybf.311.1659736139343; Fri, 05
 Aug 2022 14:48:59 -0700 (PDT)
Date:   Fri,  5 Aug 2022 14:48:16 -0700
In-Reply-To: <20220805214821.1058337-1-haoluo@google.com>
Message-Id: <20220805214821.1058337-4-haoluo@google.com>
Mime-Version: 1.0
References: <20220805214821.1058337-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH bpf-next v7 3/8] bpf, iter: Fix the condition on p when
 calling stop.
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
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

In bpf_seq_read, seq->op->next() could return an ERR and jump to
the label stop. However, the existing code in stop does not handle
the case when p (returned from next()) is an ERR. Adds the handling
of ERR of p by converting p into an error and jumping to done.

Because all the current implementations do not have a case that
returns ERR from next(), so this patch doesn't have behavior changes
right now.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/bpf_iter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 7e8fd49406f6..4688ba39ef25 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -198,6 +198,11 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 	}
 stop:
 	offs = seq->count;
+	if (IS_ERR(p)) {
+		seq->op->stop(seq, NULL);
+		err = PTR_ERR(p);
+		goto done;
+	}
 	/* bpf program called if !p */
 	seq->op->stop(seq, p);
 	if (!p) {
-- 
2.37.1.559.g78731f0fdb-goog

