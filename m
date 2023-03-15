Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764AC6BA757
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 06:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCOFti (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 01:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCOFth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 01:49:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90612231C5
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 22:49:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b20-20020a253414000000b00b305140e33cso15209725yba.0
        for <bpf@vger.kernel.org>; Tue, 14 Mar 2023 22:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678859376;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p5ozhbExSp124prI8izec79T5UTSN1Zg2cFxKIFyy6Y=;
        b=JrfZ0lSsJj54ScQQ9WhIMYTt0H8N9wdsE3nBLK5R9cXi0g/lcmUOD0bfd0fsPKrdlL
         myNK2dv0DKDdXZmlYChFRrFd4lktPUVo4gNWbvVf7U5tPw39P6q9KkfNNzRoye65zP8J
         iZuM+pQNXIH6fWkaH1yn5dPJsZmcFWZLJQrT29tWYBp65pyj2M6b1sDKEwuPa1h1WrVU
         TpE0ZgkmA5vGDNhdgktHfsstetu71cn6HRNdDe76WQQyfd5aNNAAR2eAOwr8OibetnNc
         oKBvh/yN3Y3iOpwKBouxiABMpd0hukSRbJgizje2bH6VsJiKxmFcdpWe5JC+bRrJa4vx
         dmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678859376;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5ozhbExSp124prI8izec79T5UTSN1Zg2cFxKIFyy6Y=;
        b=wdyGTbabwj6o1Z29lR68Y6KkEVjIRIcv0SqZQxqBZAKYiuhIfcmNwE9BKdr8KUmjnx
         B3B1FwckCh9qN664/QSlWYHOTdDMLkisQD+k+GY9V5GqLq0My4nMqBZnkwPG74ocUJkr
         pLD14jC0PNChtLS0ClSTiedf/BaozIcyeXNVXroWL4ZKYr5zcKCSO7CZV7X13yAIRBnb
         anQKLIhiw2INaMz25+wBHNgxuIiAbuPEOPVQgmjHNx3tWTdb6htrjpRPkGgZk3GTvqmo
         GRII7llHdFDGgG2SmJWO3sno/vmc1UghuqpjjjO4vf8aohrJvSZd0rBa3cKfy1qRQyks
         98nA==
X-Gm-Message-State: AO0yUKUc7d8om0Cf6cjkKypyY75Um4SXnqSAzzizTO72d9uuuXQg4vqL
        aueBGzASOpC1mSB2VQT1Pu+U5fBbtydl
X-Google-Smtp-Source: AK7set8TochKdEZmoLnXQsFcpuT2ztvRyVTvffYAqiJOPG9v4eWrl3zu5SJZ3UqO6I7f+HmP9AhTGb90mro/
X-Received: from gthelen2.svl.corp.google.com ([2620:15c:2d4:203:72ec:5908:b03f:4293])
 (user=gthelen job=sendgmr) by 2002:a5b:386:0:b0:b0a:7108:71e9 with SMTP id
 k6-20020a5b0386000000b00b0a710871e9mr11023532ybp.4.1678859375798; Tue, 14 Mar
 2023 22:49:35 -0700 (PDT)
Date:   Tue, 14 Mar 2023 22:49:32 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230315054932.1639169-1-gthelen@google.com>
Subject: [PATCH] tools/resolve_btfids: Add libsubcmd to .gitignore
From:   Greg Thelen <gthelen@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After building the kernel I see:
  $ git status -s
  ?? tools/bpf/resolve_btfids/libbpf/

Commit af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
started copying header files into
tools/bpf/resolve_btfids/libsubcmd/include/subcmd. These *.h files are
not covered by higher level wildcard gitignores.

gitignore the entire libsubcmd directory. It's created as part of build
and removed by clean.

Fixes: af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/bpf/resolve_btfids/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfids/.gitignore
index 16913fffc985..52d5e9721d92 100644
--- a/tools/bpf/resolve_btfids/.gitignore
+++ b/tools/bpf/resolve_btfids/.gitignore
@@ -1,3 +1,4 @@
 /fixdep
 /resolve_btfids
 /libbpf/
+/libsubcmd/
-- 
2.40.0.rc1.284.g88254d51c5-goog

