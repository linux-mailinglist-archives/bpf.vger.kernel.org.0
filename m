Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7174B6528A4
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 23:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiLTWBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 17:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiLTWBv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 17:01:51 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3517B265B;
        Tue, 20 Dec 2022 14:01:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m4so13663481pls.4;
        Tue, 20 Dec 2022 14:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppwXM72OEq9TzN8BvxQmanyYhSITXro6/homdwIj+C0=;
        b=f/EP8r2v4/F6MbyeG0xeTvhslCd25jrvRfGoS7cg2lo+PWx+YYhY0AlP4M6cFhMUDE
         U2Yok77E4GT7Mmgx+JJFi7piivQ8nVOpNkki4HNpRqdLMTACehta4z7x7PTWkHhcfUlw
         qe9of5Pyl8p5YSvxOeKePlcccajs9KVCZtP6YQeoUCOYmpp4+9d6HrxREWMa58F6oba7
         1YKX65pHEblXmYCILOIWtz+tpgbY3wXt6Z4MZDwTLjXN6cVzipSQWTp5MNVbn8l6zgyK
         UVjjWjBdfayNi+j1r5DaAQg2lr0bDM/yyS7mtqOABTtyMh7Bnzo3eOlg8acwe68nTCP2
         ypzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ppwXM72OEq9TzN8BvxQmanyYhSITXro6/homdwIj+C0=;
        b=jAEwQtQn+OTvdtBgyPyH/049QSuMF5zXDGGAeOgT2SKObvtDMJSqxC+2nmoz0LNR9k
         IBk9wr3BI52wC1KLE6gedWs8a65RBcV8HmT8SaOa+IViIH3Y8NZF+eR/FEhMqVOXkZUI
         ycg9Tt3YRJsQfqz1umXdEuW5jTAaYfHZ1H3s1ZFLmQgJe3sESL24J6AolNQEDwohXUwO
         vigj8nLKVjzO4GndnqfYApk+MuETkgADZJKeQ5y5Vy1f6bwvB7pwMknbbpMhZkl3+u/Q
         m0YpGdIf4hoENIU5gMXSw/xswfRdspb4ZwfLsuFbkQADFPPH/wAkFL4tNbVFTjzUkszz
         dSsQ==
X-Gm-Message-State: AFqh2kr31wHKj6JnwYNRRmGhgwh4ziNN+Ox2yeDF9KZ9Vh+gXwFFs4ht
        jZbwOWKdc4MAJca+A43SzAI=
X-Google-Smtp-Source: AMrXdXsmRkNiXTEUZsVdv3ki6jdZ1C8cIKwG9O2KRkHuAMT19C4Pw8S5iiQI76hlm5VEM/dAHkMVjg==
X-Received: by 2002:a17:90b:1997:b0:223:f12b:9881 with SMTP id mv23-20020a17090b199700b00223f12b9881mr2908677pjb.36.1671573709704;
        Tue, 20 Dec 2022 14:01:49 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:68c4:de54:581a:ee2])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a174200b00217090ece49sm14374pjm.31.2022.12.20.14.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:01:49 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf/perf: Call perf_prepare_sample() before bpf_prog_run()
Date:   Tue, 20 Dec 2022 14:01:43 -0800
Message-Id: <20221220220144.4016213-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221220220144.4016213-1-namhyung@kernel.org>
References: <20221220220144.4016213-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the BPF program calls bpf_cast_to_kern_ctx(), it assumes the program will
access perf sample data directly and call perf_prepare_sample() to make sure
the sample data is populated.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 kernel/events/core.c  | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5fec2d1be6d7..6bd4c21a6dd4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1341,6 +1341,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_cast_kctx:1, /* Do we call bpf_cast_to_kern_ctx() */
 				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa358b3d5d7..23a9dc187292 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9236,6 +9236,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
 				regs[BPF_REG_0].btf = desc_btf;
 				regs[BPF_REG_0].btf_id = meta.ret_btf_id;
+				env->prog->call_cast_kctx = 1;
 			} else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 				ret_t = btf_type_by_id(desc_btf, meta.arg_constant.value);
 				if (!ret_t || !btf_type_is_struct(ret_t)) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e47914ac8732..a654a0cb6842 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10332,6 +10332,7 @@ static void bpf_overflow_handler(struct perf_event *event,
 		.event = event,
 	};
 	struct bpf_prog *prog;
+	struct perf_event_header dummy;
 	int ret = 0;
 
 	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
@@ -10346,6 +10347,8 @@ static void bpf_overflow_handler(struct perf_event *event,
 			data->callchain = perf_callchain(event, regs);
 			data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
 		}
+		if (prog->call_cast_kctx)
+			perf_prepare_sample(&dummy, data, event, regs);
 
 		ret = bpf_prog_run(prog, &ctx);
 	}
-- 
2.39.0.314.g84b9a713c41-goog

