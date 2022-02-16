Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875CA4B7BA8
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 01:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbiBPANK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 19:13:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244968AbiBPANC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 19:13:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71DC70332
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:12:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q11-20020a252a0b000000b0061e240c8fb3so707736ybq.22
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 16:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+AggQNb3mZ3envo0A6eMknJWqNQcBktc6H2Lwkg2kWw=;
        b=aCe0htwJwtSKxXVPoupM01sHwF887WiEUQAN+bSTnwiMTR6DKkaVhlWkK9Lju2F50+
         cq5K9CQtMe7yr27t8bZsSNMheLjU4QGZnwdEJbiRoKYEIazP+RL20suz9LOmbMike90R
         pCq6yTO8KEnYTiLmaYU2dtEnqFCdy3kJaU0nMpW8yWGWfQuDQtI2QnWWNGzhKPV1aAQw
         V5rco74NWWMxm/D7cjfIF52T8FMsdzT7VXXwvZ9pdzoM59LQnZ4KcIa01iTJ4uzlRStc
         QOt1f/XjtCZGKp85cwBG41y2QOGxmvVg7PuFcrXJjiKPGJopl1gyPVbBM5AG0O44fKWN
         mFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+AggQNb3mZ3envo0A6eMknJWqNQcBktc6H2Lwkg2kWw=;
        b=T85V4AVM4lZNNevuAlju1jHf6LN4iq3cxbQi15b/OLUKF15d9q7pAx3kSPurUafRgW
         BVgdm29pk8gaTEMLXCGkTmLWjKzGUyYuDJAI1Mfhx7mYZfgRuw+3oyXKWXoMo2gdUs71
         iKslBiG7ZzJ19IhQzHmpc36WtHc8uEArQJmmLBO1j/2t0W7AKxiU4J0X83V8cMj9VHGJ
         BwTX0LP07o+gUp2Nm+ccyKcG0X/aEhbfzsHtbRg4cruds76uuKOrQsvZfVsB8VtYuG2A
         mtbkSscDtR00jCiZ6MkIGh2tA6aLB4ErjGetl0M71Blz/A+8lVifYhJuMQFgNd6xskTv
         LqBQ==
X-Gm-Message-State: AOAM530nNWENrNVtqG9ZscqEAma+l+o/Sf+VptoifKTf2v6MkpM9lo4O
        B6PQaJM79BKlzh1CBlaLpDQFoO8=
X-Google-Smtp-Source: ABdhPJx3eNJv+EBdAMz2QAKR6XnqHO3iZaSH9SsfWgQVZvdUJNxpY179YF2zsGgRgbD2xHGSPtwnpiU=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:754a:e17d:48a0:d1db])
 (user=sdf job=sendgmr) by 2002:a25:780c:0:b0:61e:138b:e5b6 with SMTP id
 t12-20020a25780c000000b0061e138be5b6mr70109ybc.689.1644970371094; Tue, 15 Feb
 2022 16:12:51 -0800 (PST)
Date:   Tue, 15 Feb 2022 16:12:40 -0800
In-Reply-To: <20220216001241.2239703-1-sdf@google.com>
Message-Id: <20220216001241.2239703-4-sdf@google.com>
Mime-Version: 1.0
References: <20220216001241.2239703-1-sdf@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [RFC bpf-next 3/4] libbpf: add lsm_cgoup_sock type
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
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

lsm+expected_attach_type=BPF_LSM_CGROUP_SOCK

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2262bcdfee92..840a0274240c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8615,6 +8615,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("freplace/",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm/",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("lsm_cgroup_sock/",	LSM, BPF_LSM_CGROUP_SOCK, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
@@ -8930,6 +8931,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*kind = BTF_KIND_TYPEDEF;
 		break;
 	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP_SOCK:
 		*prefix = BTF_LSM_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
-- 
2.35.1.265.g69c8d7142f-goog

