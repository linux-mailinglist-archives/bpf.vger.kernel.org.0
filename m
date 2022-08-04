Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DFA58A1BB
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 22:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiHDULo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 16:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDULn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 16:11:43 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C8737198
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 13:11:43 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q82-20020a632a55000000b0041bafd16728so335305pgq.3
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=ehanCOgC+pmflYF4gl+vGFpT54mD+u1UaYnQ25VpzIc=;
        b=htN5irf9dW09KJQ3TK7UOG3y7ul12xibxQ6wU2OYsYOY/2PBy+XW7Jp4OuCpGMy34Y
         aaoLjJHygJhH61PeOZXN2VB9e34gAhna0ehAoKhiz6TG0xPZ8HEwujWpcTGdP59GlvAD
         9o/YhAvoZrW7CrxBRr2t6SfXpK4Le0FopWLTGLnsmAimXgV6rO1m2UI2vY99TOXOMacb
         hHqdkPhXDyETZB45wHRv07sttt6wUOngDzw27HiZXDOQp1kkysgOUJnka0UdazW3KZHf
         28SxlQ0iRF+qUywkdtQiB3ucA01dApLQwaVnSWHKcdw3YJ55cl58NzvMJ/+EoCVXtDbm
         AhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=ehanCOgC+pmflYF4gl+vGFpT54mD+u1UaYnQ25VpzIc=;
        b=UKBenaGDUXSAGCQl8oISvgCf+7gumaBh0y6iPjrEEDUbpyMq0//XKT7ckZsLg9exxp
         8Xjj1o3ppHw9vz+4TNR+Htu9jzejbo5oWufqeO4xeyipiOefeSFdZvruJrgWNE8C4xqD
         uO57CEhdyTxDNxTmJE2M8ql6VYExUjeD0mSXj/1HrtyJdZLGd+Hl2fbrMDl8jI+wGoJ3
         LkQVop1EW6q6Pn4ttCq0tP2jxxqeBfU9o3cdKYe88iEcKZ//LHyNynz1PdnYQC7ua3hU
         OtnHx0r6lvdwcl7hlbiQFOebhomwedWBsfEr+zN/eQv5Q133opCYg6OuoFoLlBaOUSGH
         mJjw==
X-Gm-Message-State: ACgBeo3iVGgd1/AsQkJ9XHwIg/MqqtFL+TzRvpkyEl3VFqgcZpj80xca
        cgNYNc0fHNI9LYOI6C7p24xV3Mlb0L+m/PmFIbvDnkUo/6eTUy0RdPMJ3/GyICu5XMQbxiZBc1E
        ri6MGS/nI5hD7QAe92E5awLpfEIBYy7qYUnyix5SKCDMrEOsFwA==
X-Google-Smtp-Source: AA6agR5N/7BWz2oNgeCTkf29J8g3TEe/vrwxIrb0N0L13DQ4Fyzu/3gVI2lQ+NfDsEGteAtyS6UUIuY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:1241:b0:1f3:1d9f:a933 with SMTP id
 gx1-20020a17090b124100b001f31d9fa933mr3692906pjb.221.1659643902401; Thu, 04
 Aug 2022 13:11:42 -0700 (PDT)
Date:   Thu,  4 Aug 2022 13:11:39 -0700
Message-Id: <20220804201140.1340684-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH bpf-next v3 1/2] bpf: use proper target btf when exporting attach_btf_obj_id
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
2.37.1.559.g78731f0fdb-goog

