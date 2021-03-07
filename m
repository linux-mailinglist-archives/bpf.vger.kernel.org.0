Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B8330514
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 23:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhCGWwz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 17:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCGWww (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Mar 2021 17:52:52 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCC2C06174A
        for <bpf@vger.kernel.org>; Sun,  7 Mar 2021 14:52:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n9so4261080pgi.7
        for <bpf@vger.kernel.org>; Sun, 07 Mar 2021 14:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2lxfM/pdI7HkNjp+/C0ZoDICHkqEnHCv0Xir4ZZruRo=;
        b=EGtJj0fgw9pwjfIQK3+S2ilqdW6S+VYqgNWci30Pr/c6UynjIA6Z6Ksy7smUVUQ70v
         y6cH5CBV/Th6ucXJJbwMx5q3Z7JPeFM/eoyW8VwnttlrTD2fZ6wABv1PyoXXYy4FQA/E
         MDlluceEyv0zD/6Rwyg1rcHu2+vfD2PMG7AteAsym6LEZOhKsml7zhiy+34THVtZhUi6
         AZxHevcG7UhbZs56U4XivUdxG9ftCDcMBs6agDYPibpWkBYgVTsRz218Il3Jwq1W9Syk
         Kdst7AONp8ZGo4LjdJbc+xRWZXtLiODoxYbhwdmNQwAVxFePvopYRZkj0z57DZ7679yp
         WmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2lxfM/pdI7HkNjp+/C0ZoDICHkqEnHCv0Xir4ZZruRo=;
        b=NoDran1QrNbyqZZgDZGEPRj18jNW97qSSi1dp2joF2Pbm9cpPMnk+u45TLHrW5F3Vw
         wZHyaPVR4sOrWENWWHcai/Hsb0eX/oF23qqT2dNSLyHCs8Wuq8QXH+F/D1JoLD9cNVmw
         +1hL8Oz5FRamCEa860DAZez6q5+2AzpSAJ7P9L+rXNaC3dznavivz1xele/DXz+xjbXe
         Gxgopjf7vmoeXl9u7KZvsyRCQV4HdAdyARBH7CJy0GNo8+KRt/GrI6Ct6OTR4Dyua+/L
         6haKpEdvxy6QcpAEUUclIq+qSYAZ/ZnE5dJTbW0yEZCQmNiH0DG878nGSMxu6zr33nKa
         2zFQ==
X-Gm-Message-State: AOAM530rUdyXQ7WLsQoGTvlsOM99POHaYaKVmqRQOqLI1Sc4Y6QX4CnD
        4/ByeUUc6u/LWOdrtNI112o=
X-Google-Smtp-Source: ABdhPJwhG0tBkQUb2QlKEhxkETYvjFMrCzxIeS5BxplyJMCgKlc+X9bMfjwNjXDvtz8YTNXpUO1A+A==
X-Received: by 2002:aa7:8184:0:b029:1e5:1e7a:bcc0 with SMTP id g4-20020aa781840000b02901e51e7abcc0mr18965458pfi.73.1615157571472;
        Sun, 07 Mar 2021 14:52:51 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j27sm5018067pgn.61.2021.03.07.14.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Mar 2021 14:52:50 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf] bpf: Dont allow vmlinux BTF to be used in map_create and prog_load.
Date:   Sun,  7 Mar 2021 14:52:48 -0800
Message-Id: <20210307225248.79031-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The syzbot got FD of vmlinux BTF and passed it into map_create which caused
crash in btf_type_id_size() when it tried to access resolved_ids. The vmlinux
BTF doesn't have 'resolved_ids' and 'resolved_sizes' initialized to save
memory. To avoid such issues disallow using vmlinux BTF in prog_load and
map_create commands.

Reported-by: syzbot+8bab8ed346746e7540e8@syzkaller.appspotmail.com
Fixes: 5329722057d4 ("bpf: Assign ID to vmlinux BTF and return extra info for BTF in GET_OBJ_INFO")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c  | 5 +++++
 kernel/bpf/verifier.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c859bc46d06c..250503482cda 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -854,6 +854,11 @@ static int map_create(union bpf_attr *attr)
 			err = PTR_ERR(btf);
 			goto free_map;
 		}
+		if (btf_is_kernel(btf)) {
+			btf_put(btf);
+			err = -EACCES;
+			goto free_map;
+		}
 		map->btf = btf;
 
 		if (attr->btf_value_type_id) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c56e3fcb5f1a..4192a9e56654 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9056,6 +9056,10 @@ static int check_btf_info(struct bpf_verifier_env *env,
 	btf = btf_get_by_fd(attr->prog_btf_fd);
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
+	if (btf_is_kernel(btf)) {
+		btf_put(btf);
+		return -EACCES;
+	}
 	env->prog->aux->btf = btf;
 
 	err = check_btf_func(env, attr, uattr);
-- 
2.24.1

