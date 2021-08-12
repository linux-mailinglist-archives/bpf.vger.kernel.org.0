Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1413EA793
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbhHLPaq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbhHLPap (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Aug 2021 11:30:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58C6C061756
        for <bpf@vger.kernel.org>; Thu, 12 Aug 2021 08:30:19 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id m8-20020a05622a0548b029028e6910f18aso3412830qtx.4
        for <bpf@vger.kernel.org>; Thu, 12 Aug 2021 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FKmBhBBmRifwAw1wud9HfRzter1UnR4c92xc+2b6/5s=;
        b=rYggVfve59E5l2FDPgU103fdU6dGEbIyX1IJmrjbutp2ueeWXsTlxMMgmjKTKLjEkU
         8JsKv+B0lzkMkVIRiPQBgcqZUq0sCgIF6S4yUSvI+gAmJeynz0HhZceseIhff9OOOLgq
         cygHt2ctYoa716ivGpuO8rCicHfyDoJYW8dlRnDXEGjl4oghw9cQqUIpffGj1z18txzi
         yWMH/FUQq///zwLHKeJ8WYF4/ckKMPiAuoDgnJW0YpEz0Hyc5jei54I9gBc6cNsppZ/0
         TF1OPc7T1e9yXx4Y96aKLIygPpqFru5aoTnC8gXnzL9pp69rTqD1kP5L9hLHCzRZcVor
         1RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FKmBhBBmRifwAw1wud9HfRzter1UnR4c92xc+2b6/5s=;
        b=dO1JmvfNS4I2j2ET+dEhYX9PeyWUI09I+IkesaXa7QLC9D6UFQPZkjaIhf+uTqU9T8
         FJzVanacV1ZWji+rWFgDJ+tBiFOjddVqF955XQkOwSOuxNysOQ5LvmsIYcZzUUfwqlQ2
         oTVFbV27dZKNeSeBeMdDnRYfwSCKABwTaMwg2XUT6pwD76iFWH0y2EwPAHc2wV9Dh76z
         g54DPjh3ytF3nQ53e4Ih0hcfS+l/OIeP+lB5k3PHqhbHx/uoA01vf3CouCpgqZjQaSM9
         4jq1VHz6pFTCGamzY+CoLG9JMkKT0RKCys4R5paBYW0JKhG5SvrfKdW7cPQWTb3HmxQj
         r/Zw==
X-Gm-Message-State: AOAM531+hD9rUu07/8TJvi7aQhgQ4IOHBN+PaZmU3hlRJihgKAyx4vcg
        Y2E/SCcDxn0Eg2kgMA79/bp3HQE=
X-Google-Smtp-Source: ABdhPJyl20Z+uSrL5WekJdVuznMqlTbOmdP6c3tP7LTydERHeX7PQVn4yaU7xEawZH9kEzN2gTkEW/M=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:fa15:8621:e6d2:7ad4])
 (user=sdf job=sendgmr) by 2002:a0c:c441:: with SMTP id t1mr4375766qvi.25.1628782218847;
 Thu, 12 Aug 2021 08:30:18 -0700 (PDT)
Date:   Thu, 12 Aug 2021 08:30:11 -0700
In-Reply-To: <20210812153011.983006-1-sdf@google.com>
Message-Id: <20210812153011.983006-3-sdf@google.com>
Mime-Version: 1.0
References: <20210812153011.983006-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: verify bpf_get_netns_cookie in BPF_PROG_TYPE_CGROUP_SOCKOPT
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

