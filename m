Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2CE3BDE7B
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 22:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhGFUmt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 16:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhGFUmt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Jul 2021 16:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625604009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ujhLmOadg6wO3s9h7GHVfN4DbhqxzkAvQM9k3l8CkBg=;
        b=CxBY/MsLhC0AJrYWvlRjvAT28CYFrE0ZT0IrrjbJ9zlOTyhfnOL92/3OCVwvm2L0ycAj27
        d6K/5PF+N4rZUSyVTBG+Oos6GdUgBsOt3MsRBO7II58yjHlWbNPtok8CneL/TdiQR6Y9ss
        T0ZhDuWcfbSu0wzl6AcZPjXueFI1RkE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522--97q5nVAO7OG0nFYn152Lw-1; Tue, 06 Jul 2021 16:40:08 -0400
X-MC-Unique: -97q5nVAO7OG0nFYn152Lw-1
Received: by mail-wr1-f70.google.com with SMTP id m9-20020a0560000089b02901362e1cd6a3so97866wrx.13
        for <bpf@vger.kernel.org>; Tue, 06 Jul 2021 13:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujhLmOadg6wO3s9h7GHVfN4DbhqxzkAvQM9k3l8CkBg=;
        b=EX0WTiFQDtsnoWJhch3qVBh/FATchfbvxdvw1C96pOXD5O8xjFUe4nyIU5rS6C/qFC
         olwcfLJwVe7poJ40E48oqTbpzx/0T8yuVnR69qx72wWXGVQo7/5RbL+d638GqQ7RcK0r
         rUD3DrWBMpED8baiAEi8iV1vQAUqXEhW28ENME+0Rh3L1H63mNtW6RM5Ssl1+qkveo6t
         iTRAe+StgFABx7Mc/x1gpwTpwvfEA6Oi4qEugbpI1uya9FN7p3Ocz2Dls9bLRV4bHTvj
         7NPUnOww8G7vMYIzG4e2OaTg1/k/wF7fFZiFNpj7VhD+FeMO1hK91xYd3AsMBtF0u0Lo
         MS8g==
X-Gm-Message-State: AOAM530jXzUZrICzZLeK8AHiHs/Bjk0hRmyXVvSE2QG0dpZZQCxLCITz
        YdjoYjbQZksU0+6fVuWQIuL0XZjEl+EXisTFt+wRzOD0F7+JTHDd5K8h/lhL26TNpdwaOlumAtC
        bJ1NUA48gXUmX
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr23948633wrn.408.1625604007618;
        Tue, 06 Jul 2021 13:40:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJwEylQpa+BTPO79eJ4kmX1c2XDvH8LmhE7iiVch/SjPxwsFe7HRlgV0fu3/zkZMI+8qY9kw==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr23948614wrn.408.1625604007444;
        Tue, 06 Jul 2021 13:40:07 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id b11sm18069833wrf.43.2021.07.06.13.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:40:07 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tools/runqslower: Change state to __state
Date:   Tue,  6 Jul 2021 22:40:05 +0200
Message-Id: <20210706204005.92541-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The task_struct state got renamed to __state, causing
compile fail:

  runqslower.bpf.c:77:12: error: no member named 'state' in 'struct task_struct'
        if (prev->state == TASK_RUNNING)

As this is tracing prog, I think we don't need to use
READ_ONCE to access __state.

Fixes: 2f064a59a11f ("sched: Change task_struct::state")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/runqslower/runqslower.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/runqslower.bpf.c b/tools/bpf/runqslower/runqslower.bpf.c
index 645530ca7e98..ab9353f2fd46 100644
--- a/tools/bpf/runqslower/runqslower.bpf.c
+++ b/tools/bpf/runqslower/runqslower.bpf.c
@@ -74,7 +74,7 @@ int handle__sched_switch(u64 *ctx)
 	u32 pid;
 
 	/* ivcsw: treat like an enqueue event and store timestamp */
-	if (prev->state == TASK_RUNNING)
+	if (prev->__state == TASK_RUNNING)
 		trace_enqueue(prev);
 
 	pid = next->pid;
-- 
2.31.1

