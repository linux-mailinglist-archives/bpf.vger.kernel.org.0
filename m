Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541803E9AEC
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 00:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhHKW2T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 18:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhHKW2T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 18:28:19 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F354C0613D3
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 15:27:55 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ay14-20020a056214048eb0290357469934easo2151482qvb.8
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FKmBhBBmRifwAw1wud9HfRzter1UnR4c92xc+2b6/5s=;
        b=KtorBMIjMc7PRX+Eu8q9UZfgz7ozjZS/YIQxhZ4KL2/4npw/Ogxow4rDpoky8ge4wv
         GshTjP/p/8DWUfc0HZ0Y+Y4ouTaLdunkIN62NhsetlQ3m6MJ94G9o87D9Bm22V193IzH
         31YGKStXfGLmoTo+khXW+88VsRbjHBxAuF4Hp96MM/EzVXEuHdn6gAuQm1Xj4tDdmueY
         0eXLXctdGi/e+K3LxI4858JIrEa+lnb5ywM5jMd8Nc73ZKL5CLgZ5957OdyDbR9PM6ET
         +9bc1Gpucb7t5QEBxooDyIXpHAWE27/4h1D5vXWwiab1J0GYLfyrygDL+Vvw+Rzf+jmn
         JzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FKmBhBBmRifwAw1wud9HfRzter1UnR4c92xc+2b6/5s=;
        b=UVnLE/3Xn5Wh/OGc/SYGqWgDpfw5paNo7No9AtroKoh3uVfW3QamknsoeDzCWNbIv5
         Ae0x22qm5NiXM2f1Ma7Xzr6O2AhWQx33jN2pZIa9SImRFZACmUlPjZuwyOTFDdGjwKwP
         O41c4ZZtqEQgw5r2IP05geSTB2PoZrFbwUBDc4a0GxyCq6B/6wyelWPMf8CTzTRANcLu
         GiGGP/RRojS8l5A3Jf8P/SR9txt3OteBcNboNmH5kXMRcUtVs+VsFwlQBQxYATUVyGB4
         WADT/GMwgoBBix2/ATmP8rQG/0YfhVuY8tQhUcnH3cLEnS4cPy1xy+8PwQRvzmEDvrzB
         juaA==
X-Gm-Message-State: AOAM532cu0Xi83tHIyc4QVnlNaaHaiHNnTLppeRv55SQrxvrc9nNC+u5
        XVh9w6xzx+vvYlgvAJU9gzJuvdU=
X-Google-Smtp-Source: ABdhPJwLgIPSwzO3YGooos4qruEZJUyvIjVnraAgI9++Ha844zvdXoIktyQ1NnwmY8hMo+rSbaGgx68=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:c78e:f5dc:8780:ed29])
 (user=sdf job=sendgmr) by 2002:a0c:a321:: with SMTP id u30mr846227qvu.57.1628720874259;
 Wed, 11 Aug 2021 15:27:54 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:27:47 -0700
In-Reply-To: <20210811222747.3041445-1-sdf@google.com>
Message-Id: <20210811222747.3041445-3-sdf@google.com>
Mime-Version: 1.0
References: <20210811222747.3041445-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH bpf-next 2/2] selftests/bpf: verify bpf_get_netns_cookie in BPF_PROG_TYPE_CGROUP_SOCKOPT
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add verifier ctx test to call bpf_get_netns_cookie from
cgroup/setsockopt.

  #269/p pass ctx or null check, 1: ctx Did not run the program (not supported) OK
  #270/p pass ctx or null check, 2: null Did not run the program (not supported) OK
  #271/p pass ctx or null check, 3: 1 OK
  #272/p pass ctx or null check, 4: ctx - const OK
  #273/p pass ctx or null check, 5: null (connect) Did not run the program (not supported) OK
  #274/p pass ctx or null check, 6: null (bind) Did not run the program (not supported) OK
  #275/p pass ctx or null check, 7: ctx (bind) Did not run the program (not supported) OK
  #276/p pass ctx or null check, 8: null (bind) OK
  #277/p pass ctx or null check, 9: ctx (cgroup/setsockopt) Did not run the program (not supported) OK
  #278/p pass ctx or null check, 10: null (cgroup/setsockopt) Did not run the program (not supported) OK

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/verifier/ctx.c | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/ctx.c b/tools/testing/selftests/bpf/verifier/ctx.c
index 23080862aafd..3e7fdbf898b1 100644
--- a/tools/testing/selftests/bpf/verifier/ctx.c
+++ b/tools/testing/selftests/bpf/verifier/ctx.c
@@ -195,3 +195,28 @@
 	.result = REJECT,
 	.errstr = "R1 type=inv expected=ctx",
 },
+{
+	"pass ctx or null check, 9: ctx (cgroup/setsockopt)",
+	.insns = {
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+			     BPF_FUNC_get_netns_cookie),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	.expected_attach_type = BPF_CGROUP_SETSOCKOPT,
+	.result = ACCEPT,
+},
+{
+	"pass ctx or null check, 10: null (cgroup/setsockopt)",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_1, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+			     BPF_FUNC_get_netns_cookie),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	.expected_attach_type = BPF_CGROUP_SETSOCKOPT,
+	.result = ACCEPT,
+},
-- 
2.33.0.rc1.237.g0d66db33f3-goog

