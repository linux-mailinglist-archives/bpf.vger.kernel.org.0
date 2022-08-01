Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAB4586FA8
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiHARja (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 13:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHARj3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 13:39:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEBE63C7
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 10:39:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-324f98aed9eso23566987b3.16
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=iyO7DTFE82DSnWeayUyzGKWvvGkvn6Eh0cYt/6e5Cs0=;
        b=qgNa+3GaFLLZzferNwNnjur+sDDZKll9HnViv8v3zoS8w/ArdCQP1UbSnCyBdkKxxH
         2epbED74qWvocG7A2bpKwgDvNPV/pmEWQkXBHXiA6XlVrfI2QS5G5mknrq6W/h+pukRz
         7lIKf55a42k4ZIXJuGXY61IpSLuLSfkoyGnpObx/wFMstrtFqsBwTQN3NYEQ2Jvc/wdr
         IAeNhXEWHiSD/rg6AYiybrVxHXNLfYmFgYR44juvqa3v0EfGQFaL8Bri90Q6GlJESRnK
         i1RO0hgcNZnrjn5b0wDV0SL/aquA7wgSXZumFk1AqQfHy1VG/6HnUEFzq3S0ghpVWmPd
         xtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=iyO7DTFE82DSnWeayUyzGKWvvGkvn6Eh0cYt/6e5Cs0=;
        b=Pojrz9+bHhNZBXnGl4c72SsZYH/tLVhfeQZz2L+XLPlXvoEyCEWHRreXdOjouj+zAt
         wiMLQ/DsFs5XhNgMRg7H3csPngpBGlGTLxpN7SUSgDa5HKZH9UMCeNHrq+UcK3VUJykO
         mXdpWNQD7ZhlAwphpYKIvejFPBwI2G++25jvb60xTAhSwI8Sbr5vzzGqtPPnzYddLEoE
         M8TTjld9HdNF8lZbXD9qDVwpySOjiFeBWTF3Mh6bLInpVlUIqI3SaSH30KR/QFOBVHTr
         dKhWA9Ay01YHxjr0RGS1LG94a9Nxtiwyp02D2Q5Q8ZritDCyL/bjJMkkNlggwndAeCVW
         rBrg==
X-Gm-Message-State: ACgBeo2I4mY/ZpZM5WYO7j0lZwZSl0ZoYr/601MlNBV2zEzFuPtt+0CP
        KPSUFjJ7KyoijU5DkL7890wy9w+MZ9/6VtjWana2L2WarFc0+DGfzL++4FTgDIWuOOYJw4gdpue
        +2ZAk+BZzh2g9+AjVFXo9RkbV1W9piSZCMB5QR40CMPIURQcVTA==
X-Google-Smtp-Source: AA6agR7eW0j4LHeVUOcIxwZaIS4m4/tsDM3UkBrUQn3cZXASx9EoT1P/7/sZue8FAnA9TKH5MqPC7Ls=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:6d45:0:b0:31f:498b:294 with SMTP id
 i66-20020a816d45000000b0031f498b0294mr14230980ywc.214.1659375567927; Mon, 01
 Aug 2022 10:39:27 -0700 (PDT)
Date:   Mon,  1 Aug 2022 10:39:25 -0700
Message-Id: <20220801173926.2441748-1-sdf@google.com>
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

