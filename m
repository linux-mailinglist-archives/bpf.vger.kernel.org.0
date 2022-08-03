Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B36589090
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbiHCQc5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiHCQck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 12:32:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CBEBE0A
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 09:32:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q82-20020a632a55000000b0041bafd16728so4775975pgq.3
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=iyO7DTFE82DSnWeayUyzGKWvvGkvn6Eh0cYt/6e5Cs0=;
        b=pwVa5xrJllIxnM+BNXuMubZJtIyaJJQ8H7IV1FTtEEbjWxP0Rfi2wkog71lpFV9b4M
         EMULtkQy/1tSJK3xkGnUeFg/UPRCJfjYoFuX1nTewhN3rxETb8HmqbkvzMua9a0tuEvS
         FiCWhH6vbaKuJGe4Bg5yPLqlVcrAW5fpZLUirgWeGTQaJL/kkqRK3lgd/qYJZtVVNEA/
         WYQGxn3oZ+lGw2wtKimF89x6xEFJLIAozanp/Y6fH9AxGs7TZsoUPnfb0tgSxXVhsdl1
         rPgpMcPpXSpBl3ipzE2PbL4t4LlvwREECd2ga3l5JQuEHZprQo+B1gVQlaR1HRBio/6Y
         T6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=iyO7DTFE82DSnWeayUyzGKWvvGkvn6Eh0cYt/6e5Cs0=;
        b=VsDSbPAxgFH6haOlph9OYNhZKS2ah8OLU3eYdixKu6a84EskCiHEQ2FaetPyuUnmZW
         pZXEJvp4Wf1e6L9CJux6hy4oGpF1tX7+dXn0+Og8sjHO3oNf00zdYf2aW9+FZsrAxf/M
         YTx+2Rhy30Y7EErjAQ44IBvn59FS7dkejyRzALzyn8iN3II/epFJXahl1zgyhZlZ1Qg5
         mtZYdAYFTVlgzv2LXN6kh/WITMnUdMXL6rtT35dpJbSdNPEDv610slLgVFDjGl/A1dM0
         IvhEg7iOtLi758NAyfGwtZ8mlGmK4S5WQ6bqpYCDl5781tzoPyTuQ9ozoU3DCDWsDKFg
         wg6w==
X-Gm-Message-State: ACgBeo27RBI4tEzwW/0bkqXMDltpJqYCe1E3I451OX9ieN88NdLaCqFC
        qcqSGIxWA6I+QaSG0S7HnLvwk44+eGW06vqYyja6WJy/mw+W7iAUpOpbsJfor4IteJjY6SLn1zG
        3FDEMnVXwzLt2Pn2QV5oStFLerLRbeZD6nCXfLzncPAIlUZC05Q==
X-Google-Smtp-Source: AA6agR5od8MRG15BgO0rZQKxsQUlWHWRCfsn97uuaWQ2+sMI4FUsEWPtfOww1Yrr2ZDY47Uh1T+It6k=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:2688:b0:1f3:3da3:22f4 with SMTP id
 pl8-20020a17090b268800b001f33da322f4mr5517722pjb.182.1659544344773; Wed, 03
 Aug 2022 09:32:24 -0700 (PDT)
Date:   Wed,  3 Aug 2022 09:32:22 -0700
Message-Id: <20220803163223.3747004-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next v2 1/2] bpf: use proper target btf when exporting attach_btf_obj_id
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
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

When attaching to program, the program itself might not be attached
to anything (and, hence, might not have attach_btf), so we can't
unconditionally use 'prog->aux->dst_prog->aux->attach_btf'.
Instead, use bpf_prog_get_target_btf to pick proper target btf:

* when attached to dst_prog, use dst_prog->aux->btf
* when attached to kernel btf, use prog->aux->attach_btf

Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/syscall.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83c7136c5788..7dc3f8003631 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3886,6 +3886,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 				   union bpf_attr __user *uattr)
 {
 	struct bpf_prog_info __user *uinfo = u64_to_user_ptr(attr->info.info);
+	struct btf *attach_btf = bpf_prog_get_target_btf(prog);
 	struct bpf_prog_info info;
 	u32 info_len = attr->info.info_len;
 	struct bpf_prog_kstats stats;
@@ -4088,10 +4089,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	if (prog->aux->btf)
 		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
-	if (prog->aux->attach_btf)
-		info.attach_btf_obj_id = btf_obj_id(prog->aux->attach_btf);
-	else if (prog->aux->dst_prog)
-		info.attach_btf_obj_id = btf_obj_id(prog->aux->dst_prog->aux->attach_btf);
+	if (attach_btf)
+		info.attach_btf_obj_id = btf_obj_id(attach_btf);
 
 	ulen = info.nr_func_info;
 	info.nr_func_info = prog->aux->func_info_cnt;
-- 
2.37.1.455.g008518b4e5-goog

