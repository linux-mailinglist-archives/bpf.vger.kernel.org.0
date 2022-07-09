Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704BE56C52F
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 02:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiGIAE7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 20:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGIAEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 20:04:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1721A127D
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 17:04:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31cb93cadf2so2361097b3.11
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IqjL6yZGTqZ3Qe1XCgaEl6Fvh17NMPAOr7heTy9DUWI=;
        b=sgi3aVUrpzBWfebO0eixVS0qfo5Xt0wVCPW7ELzk3n4yMTtTrcclhOKlRVXJ1RmLUA
         9YQfDzxLvHW4dQVosJREPn4Niv6/YVO4lwQctTJkGW4lHPxXY4SKXvJGucNbaX6IfLUz
         t6rDR5WEeCcw/g318JGwbL+CqPH6ReaRv2xTNI0j2QM8BBWS8W5TzaKTO3uPfcFtiI6h
         /K+AEn9xXXbg6EmwFKHBaSMOy8kDnkOIICWxXn0oTE0kCLUHjB20+RRazYIHIGQukycM
         xeHWcswZban+jsAKB71K7reqzFvxxfU55QTsB6Mjr/uVx78vP6CIOkmnjlDiACm4XIvU
         slnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IqjL6yZGTqZ3Qe1XCgaEl6Fvh17NMPAOr7heTy9DUWI=;
        b=Xp3kQOFirXMZzU8/Mid0eKbYBo5dou2YueQRjq7xE7kfN2OBDMdb6x9So9XCMSRk1v
         0Nfw6kyI2Ts+6DjkaIuE1INhWrYqfWTWLF3B2LH1kd8yoO/ro/z1K7X4r8DJX4gZdCIG
         RNbUlXvA+a+67oojoTTyhGLyqbo1y4LTqj/SOp5o9xTdE/9nbFDrPvaNykmOmJ/Cf3dG
         lq9akpZ4ZqgGqKLmErJ7YbG+2OBvKzI4taboBWivmkelOVT5MRawKvSdyJYAtRREvR8a
         Nk+qkq05tfQs040Mf7m4QKSUXi23wR/wp950+WtV8jqyyzswiVBkhu4LuaVmDd+RTffs
         J+3w==
X-Gm-Message-State: AJIora+ZqljdYpTnVL2RFGzhaiLdCson9RAPJ0Q/zKql3fKuCGU8lF6f
        ufMMsv64s0Ctv33UGqy/XTqOf6G2YZxjcaL4
X-Google-Smtp-Source: AGRyM1sDgVvHNokF8WKVncgONh5iqmlzWfQXnKSbXZYREuF4EPtY2k5g0mdUxyJ5JYmKP/blrEFtkDRoB7kjysJv
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:9d11:0:b0:66e:4fad:e153 with SMTP
 id i17-20020a259d11000000b0066e4fade153mr6406533ybp.484.1657325090922; Fri,
 08 Jul 2022 17:04:50 -0700 (PDT)
Date:   Sat,  9 Jul 2022 00:04:33 +0000
In-Reply-To: <20220709000439.243271-1-yosryahmed@google.com>
Message-Id: <20220709000439.243271-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220709000439.243271-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v3 2/8] cgroup: enable cgroup_get_from_file() on cgroup1
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup_get_from_file() currently fails with -EBADF if called on cgroup
v1. However, the current implementation works on cgroup v1 as well, so
the restriction is unnecessary.

This enabled cgroup_get_from_fd() to work on cgroup v1, which would be
the only thing stopping bpf cgroup_iter from supporting cgroup v1.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/cgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734d..9943fcb1e574d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6090,11 +6090,6 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 		return ERR_CAST(css);
 
 	cgrp = css->cgroup;
-	if (!cgroup_on_dfl(cgrp)) {
-		cgroup_put(cgrp);
-		return ERR_PTR(-EBADF);
-	}
-
 	return cgrp;
 }
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

