Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7666C57556F
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 20:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiGNSyN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 14:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbiGNSyH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 14:54:07 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9025243E66
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:54:06 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id e5-20020a636905000000b004119d180b54so1605207pgc.14
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5YIJYLLgsjtvncuo/58QsfEcqvQ8pkD1xgwWrhU3Oyw=;
        b=QP21sYrlO0fYeBESb3/X+r3Xgh5ZAORwgty/hMh64ewTLLUH45glw1IC+Rt1vyIWFn
         olo2jkAdboWPsaKJGnnDRHsmQ65oZtGyioEX1a3+qZ0RWuOwKIInixrNhrJmg3m1jAH1
         tjXYKqmioV8sn8n4dcA00gktZlQJhj3pmpcOSvz08piOlUOPZQEHR2L9dv53y5Qc9MGQ
         oqFuqTHmyJYwY3Up7DIQcJqZ9zAULtdst9m/OGAwo80bd1Pu4WilMHF4WTOzd2DtvbAv
         n1dk5Sl1IEnstGX2YAqCN0uVWdHqEo6Ai1rKMlrlXJR3nDl3nkxRbzO/7cWU2luwP3kA
         eQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5YIJYLLgsjtvncuo/58QsfEcqvQ8pkD1xgwWrhU3Oyw=;
        b=BANJCqf61FK/0AxTfQIKFF9dymK7A80Mos90wuNwri+UX93B8yo5lvaYzG4MsYsuDm
         ycmCfwMIZ1js0eBKYIaXMFcjhAy5PaSy3X2rym3oaOEyFLnojMMxC9pFvChJlVb/O+I3
         qQzdFneAwzelnzzhos0ZOBzgF7qu9h7kGtj8sbOWk/59zuOX+aCS1ycKiwHo/BlgDvjQ
         NO9DIprf3IsxjDLPmDXBRYiYvqDMTgme6Auvr5QSMo1KKxffvjFpCkT3OyPKfZwIqr+S
         jkw/42XygJl5YH6b7Z+8fVkVDVIpMQkW8M9A7l75jBQq6TtSzEiyynJXKdV88IJl/mbS
         wDEQ==
X-Gm-Message-State: AJIora8fEhSaBR+LCWJKzsYUYtNWfR3bSCmVyMXjDH7LzWN4gxwa6J6A
        GQ/2B70d8G8mkzWruZZSD6ME1L6pym1DSWidDhmsGi0PWmZrFQul06p5gRF4L784X+yByaoRiDq
        7pnUzkf1nbODdlxrkyR55fTosAVlS1Ts6Hqy0xeCe5jnjzbQQxg==
X-Google-Smtp-Source: AGRyM1vIGPDveYx+akvMNnF9OMHkH+kH+3p2lRD2L9WVrswhjDeZwJdPWiM9jRP6R6gUXAtqARq6mLc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:1b57:0:b0:52a:d646:de3c with SMTP id
 b84-20020a621b57000000b0052ad646de3cmr9816105pfb.60.1657824845955; Thu, 14
 Jul 2022 11:54:05 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:54:04 -0700
Message-Id: <20220714185404.3647772-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH bpf-next] bpf: fix lsm_cgroup build errors on esoteric configs
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        kernel test robot <lkp@intel.com>
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

This particular ones is about having the following:
 CONFIG_BPF_LSM=y
 # CONFIG_CGROUP_BPF is not set

Also, add __maybe_unused to the args for the !CONFIG_NET cases.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/bpf_lsm.c    | 8 ++++++--
 kernel/bpf/trampoline.c | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index d469b7f3deef..fa71d58b7ded 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -63,10 +63,11 @@ BTF_ID(func, bpf_lsm_socket_post_create)
 BTF_ID(func, bpf_lsm_socket_socketpair)
 BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
 
+#ifdef CONFIG_CGROUP_BPF
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 			     bpf_func_t *bpf_func)
 {
-	const struct btf_param *args;
+	const struct btf_param *args __maybe_unused;
 
 	if (btf_type_vlen(prog->aux->attach_func_proto) < 1 ||
 	    btf_id_set_contains(&bpf_lsm_current_hooks,
@@ -75,9 +76,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 		return;
 	}
 
+#ifdef CONFIG_NET
 	args = btf_params(prog->aux->attach_func_proto);
 
-#ifdef CONFIG_NET
 	if (args[0].type == btf_sock_ids[BTF_SOCK_TYPE_SOCKET])
 		*bpf_func = __cgroup_bpf_run_lsm_socket;
 	else if (args[0].type == btf_sock_ids[BTF_SOCK_TYPE_SOCK])
@@ -86,6 +87,7 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 #endif
 		*bpf_func = __cgroup_bpf_run_lsm_current;
 }
+#endif
 
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog)
@@ -219,6 +221,7 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_retval:
 		return prog->expected_attach_type == BPF_LSM_CGROUP ?
 			&bpf_get_retval_proto : NULL;
+#ifdef CONFIG_NET
 	case BPF_FUNC_setsockopt:
 		if (prog->expected_attach_type != BPF_LSM_CGROUP)
 			return NULL;
@@ -239,6 +242,7 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 					prog->aux->attach_btf_id))
 			return &bpf_unlocked_sk_getsockopt_proto;
 		return NULL;
+#endif
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index fd69812412ca..6691dbf9e467 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -501,7 +501,7 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampolin
 	return err;
 }
 
-#if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
+#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 static void bpf_shim_tramp_link_release(struct bpf_link *link)
 {
 	struct bpf_shim_tramp_link *shim_link =
-- 
2.37.0.170.g444d1eabd0-goog

