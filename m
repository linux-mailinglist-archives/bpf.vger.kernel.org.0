Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E04388481
	for <lists+bpf@lfdr.de>; Wed, 19 May 2021 03:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhESBlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 May 2021 21:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESBlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 May 2021 21:41:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F13C06175F
        for <bpf@vger.kernel.org>; Tue, 18 May 2021 18:40:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t11so6517893pjm.0
        for <bpf@vger.kernel.org>; Tue, 18 May 2021 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H2Qv4o9xUMdz0zbMFxgAf+bRUOr+XzzpHUHlblUR2gA=;
        b=HS+sazVY7OP058aIRxIukQ44d3/1pwcc0bTK5SSokgqlGz/h2WH1ljFAM53WpgJ5QD
         7/JKVc9EseTmiINaKWKStQKEgwFdAKFZizi1I5MAn2qnKcijwyXySaCGdazQUw7xDdD0
         r7wB1zjnZDM2spy+tv/GM2o0r+wewP4ZhldLjNH2M9I3QdP5iPqVYQqMheptCQmuqpw1
         o+yCqwA9HS2WhIV/ngW+kle9Ld7CqMa2RZw5PWoZKdMTtdMfCclR0RlrpGDGyynKTFeT
         G5oe5Vg8uXYb7seiWisnbcr6Aj/GCZwItWXFT0KcAe1uhOBncgob6aZaTDtmZFGXj1g0
         R4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H2Qv4o9xUMdz0zbMFxgAf+bRUOr+XzzpHUHlblUR2gA=;
        b=QLOx4T3JTsCntbJAHUexXhFCXmxQKXE6WBq0g9Rjm6rhWif6J52Rfw58zz7zlJEBCF
         A09QfUKiqGMX7IzQrcypLqiWbazfNnxjAoBh4ln07e8xAO3fkayHL5rl+vQcYa8h7fmx
         pCZ2FdK9P2jqo3haDRXntjIqpouZ1THw4OtZ52g/VD/4mYknIdvPr6/5xFNOE5Loj63Q
         Bmh+vY3lfym3rbtaT8W63ukOBZBDEIINYjp3w5e/aC315+HMF+lpQ1LTKgVMkHpD0+/p
         A0qh5FxE/ejdXTOKYdEgk0r6jzlJIxXi3FXgPxVrfSuUXhNhMHxEyoAjCDkSrzKhlIaF
         JCdg==
X-Gm-Message-State: AOAM532pgxYdwcFg7bg8+sjPw/HBBkX4Euf7ojch1tIEhKwWOnAelWsj
        J/ZLPQ/psu89cvl3K6/jPPQ=
X-Google-Smtp-Source: ABdhPJzpZmR2gPjauf9crOH+sxmgSgRdqcLkudmybiufontDdXU2UEomgGgewbgNWu0IcGEeS1DxIQ==
X-Received: by 2002:a17:902:82ca:b029:f3:fa5b:2637 with SMTP id u10-20020a17090282cab02900f3fa5b2637mr3311856plz.83.1621388436204;
        Tue, 18 May 2021 18:40:36 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id g72sm2918156pfb.33.2021.05.18.18.40.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 18:40:35 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Add cmd alias BPF_PROG_RUN
Date:   Tue, 18 May 2021 18:40:32 -0700
Message-Id: <20210519014032.20908-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add BPF_PROG_RUN command as an alias to BPF_RPOG_TEST_RUN to better
indicate the full range of use cases done by the command.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/uapi/linux/bpf.h       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 tools/lib/bpf/skel_internal.h  | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4cd9a0181f27..418b9b813d65 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -837,6 +837,7 @@ enum bpf_cmd {
 	BPF_PROG_ATTACH,
 	BPF_PROG_DETACH,
 	BPF_PROG_TEST_RUN,
+	BPF_PROG_RUN = BPF_PROG_TEST_RUN,
 	BPF_PROG_GET_NEXT_ID,
 	BPF_MAP_GET_NEXT_ID,
 	BPF_PROG_GET_FD_BY_ID,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4cd9a0181f27..418b9b813d65 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -837,6 +837,7 @@ enum bpf_cmd {
 	BPF_PROG_ATTACH,
 	BPF_PROG_DETACH,
 	BPF_PROG_TEST_RUN,
+	BPF_PROG_RUN = BPF_PROG_TEST_RUN,
 	BPF_PROG_GET_NEXT_ID,
 	BPF_MAP_GET_NEXT_ID,
 	BPF_PROG_GET_FD_BY_ID,
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 12a126b452c1..b22b50c1b173 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -102,7 +102,7 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 	attr.test.prog_fd = prog_fd;
 	attr.test.ctx_in = (long) opts->ctx;
 	attr.test.ctx_size_in = opts->ctx->sz;
-	err = skel_sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
+	err = skel_sys_bpf(BPF_PROG_RUN, &attr, sizeof(attr));
 	if (err < 0 || (int)attr.test.retval < 0) {
 		opts->errstr = "failed to execute loader prog";
 		if (err < 0)
-- 
2.30.2

