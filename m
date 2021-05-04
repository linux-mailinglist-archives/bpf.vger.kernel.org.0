Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC6A3732E5
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 01:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhEDXuN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 19:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhEDXuM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 19:50:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7018C061761
        for <bpf@vger.kernel.org>; Tue,  4 May 2021 16:49:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i8-20020a0569020688b02904ef3bd00ce7so359948ybt.7
        for <bpf@vger.kernel.org>; Tue, 04 May 2021 16:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZdSRGJLzb4KjpNs25266npb7NX9+fIrv6tE6wKvXYkQ=;
        b=TbcwiLSGdUbbez0BgZKkedibJSJsyIkWQCaGjpCvgPzp1faOhRee83iTV3WJ1tkt0P
         1NtcurmNCHILH6lbYDiAUMltldG88Al9R+PiAixGpalQSiYQIi8zHHeVVbb6H/h+XthT
         fOqHea9tWE3GfNXtmJhLP/Z6xzK8AfvRefkcihq34e5gxYWRODFANVtlEaWL+20nCXMw
         f4jJbQMjX569oq4jYirvY5sKDN/CuQcWPFK1G2Q5qUNDSPSngoRvGqdycVb03MlblhZD
         /tZJLUdbpbiQvBIdMjgkfZqv0XF4g11pCPetHasOOyie0YssKHVdN6Btkzl9fUSPTsK7
         tvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZdSRGJLzb4KjpNs25266npb7NX9+fIrv6tE6wKvXYkQ=;
        b=Lc386X6eaVSkJsMK7q8nsD3pZVNn0bJFqqH7vQPFIOn29TT3nfivzOIPuERFDwKmmN
         +Fza2UX5HrQ6vv9OE27OoZQmeIHSFnkcLcFxGcwLLrqzHPlMCd9VRakwSRCOLoE/98R0
         n4Oph05aaDzPSn/lrU0B3sai5z6SjHPSkgypyS0gCOBzJT1s7ry3x7o4ysFAcs3pesjQ
         RmC9rAPZy5Tc3jlYIlPS2FU0Ahe0MdJgurFl1/Khji9dlu379PCoXNkGwUHCbP6nBau6
         9bjyBCZla86eyZFTvqAbn0czwqmD6F/PZJ9z9+JGOuSS0AjGSYRXpXPwZvAssZ57eXyJ
         OVYw==
X-Gm-Message-State: AOAM532TcPnTpAZRUaJZfm2n7Iwl+yvaO7MBbqPf2XVv2WTqNAymodb+
        AQit+yvfDG3IftIIBrjg38MAlSGUpPVj
X-Google-Smtp-Source: ABdhPJyUv29soiibo57/StwdT9oVQMlRMvGiEoQ0bn2rIkk4rM06sZg1XXWYdzwYlLtQ7azM31DxhCn5528F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6f05:c90a:7892:8680])
 (user=irogers job=sendgmr) by 2002:a25:6c8a:: with SMTP id
 h132mr38310085ybc.454.1620172154818; Tue, 04 May 2021 16:49:14 -0700 (PDT)
Date:   Tue,  4 May 2021 16:49:10 -0700
Message-Id: <20210504234910.976501-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] libbpf: Add NULL check to add_dummy_ksym_var
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Avoids a segv if btf isn't present. Seen on the call path
__bpf_object__open calling bpf_object__collect_externs.

Fixes: 5bd022ec01f0 (libbpf: Support extern kernel function)
Suggested-by: Stanislav Fomichev <sdf@google.com>
Suggested-by: Petar Penkov <ppenkov@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index de9a5b0118fe..97d9a1c2d680 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3216,6 +3216,9 @@ static int add_dummy_ksym_var(struct btf *btf)
 	const struct btf_var_secinfo *vs;
 	const struct btf_type *sec;
 
+	if (!btf)
+		return 0;
+
 	sec_btf_id = btf__find_by_name_kind(btf, KSYMS_SEC,
 					    BTF_KIND_DATASEC);
 	if (sec_btf_id < 0)
-- 
2.31.1.607.g51e8a6a459-goog

