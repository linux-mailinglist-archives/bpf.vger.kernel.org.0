Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551A1585781
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 02:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiG3AIO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 20:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3AIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 20:08:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4451E2DD2
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 17:08:12 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z22-20020a630a56000000b0041b98176de9so762497pgk.15
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=TELe3K3v6QvVnw5uSt+2dTftH1AuMLoTm12aT3sQDDw=;
        b=XuyaA5kQBt8PWDo2P+xzZMjoGdqPWw4HDGF4CFS4Ja9XVicZUSI0MHPW/+ryBDDYMq
         R+ypr/akPPhpbMTs/PCVS5jUc5LrPTYBXH5yEyrKX3okGJrfWwMDRT/0cDA49Bi9mI1v
         PSaX60pjJsWbqmfDW2Vy+K9Dv9u6Ibrbgkl2vzgnUa0obW8CM98S2vrBDaFIrXXzGB3S
         5SOxmmFkKDqmHU9czdxb1K8XYu/x/jLziwdGXFtmE5+skjfj9Hnu3Usfw0PmUBE0Tzvm
         EuA0bLbCyKwIlmwNTWPVIEw6pDjLwJ7NonM6nAjiW+VW1vgsSWPJ8hxdpz9iZ5NI395y
         y0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=TELe3K3v6QvVnw5uSt+2dTftH1AuMLoTm12aT3sQDDw=;
        b=7Cg/FP/50AtWX/F3gWaG1qp5Vq4+Kz5NeW0fAkGwax3hgEC2zAS0NUZU0SVRyaCKid
         uX2lE5B5Xg0mgz5MThWWj6BNTR7pA85LyW9uXYzvIHvOnT5JobTnWgtkfBk/sidhuZ7K
         vwxxIa+flE4rB5bxQAO7YSDQ2/sAxq/MXUccY7cqcObg1Lmvq0Ot2JnhEuhUotlCwoEH
         BwE70pYoQ12IOI9BezejYY3g+vaRTp1RI/ZU4uaqnjy27tpXO/+JPdchekdaNKhhnyMj
         0Y0p/HBvwl0ALY8SnPjrSJ44r1pDfiBcn96ZbTcFHfp4R5dNFPzVUqBy7A0O4APqbRaA
         AD4g==
X-Gm-Message-State: ACgBeo285rq+ECLKxBiI7blGXWC0Ys098cYN90Dk2uY6F+sntuXqbk1h
        6HIL8XV+DJK+HOf4By9mXdVfPc68RGio1h/JXaia6SIAJyzwUU0dAuoNviuPfbvQ/bo/mYmzX7g
        O61kDZgFOjwYLWfj66J52Tud8lNjw2Kp+C0lM44yaveYg+l+GoA==
X-Google-Smtp-Source: AA6agR4wO2Ms7Ns28fUYSasqDW0/dYfPYZzpPawmG9aIer77BnGfH1T5+aFhZVxhxkHkmT+PWYhPuPM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:9b03:b0:1f1:85b2:c52b with SMTP id
 f3-20020a17090a9b0300b001f185b2c52bmr7476182pjp.159.1659139691632; Fri, 29
 Jul 2022 17:08:11 -0700 (PDT)
Date:   Fri, 29 Jul 2022 17:08:08 -0700
Message-Id: <20220730000809.312891-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH bpf-next 1/2] bpf: use proper target btf when exporting attach_btf_obj_id
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
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

