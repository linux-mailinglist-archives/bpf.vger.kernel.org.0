Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE7244581A
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 18:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhKDRRP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbhKDRRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 13:17:15 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0AC061714
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 10:14:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k4so8304951plx.8
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veketWKw2Fc5JJ/rZK6bSXLb4liBnzJiO6VVedHVvtI=;
        b=Uj0IxxDYP28f1ZBKf7k4WTTAa9zpipbsEiAtlh6Ys+jjzD7nDYXELWY7SgVbVhMlhc
         EnC1G0YJriaD39UaOloptAt4bpO9GnHf2pUPclKNFxnKqlyOwG8GhLkmkhqE/yS1Nk+e
         9j0sNGcoWq9QT5UYVQFBbIPDC5GmIi3sFIMBPgLyUGRgFnj054dMUWzprSCEIRPDfNDh
         HKsu7I+e4SfK/VVo0IvraplN8+pXI04fuODRliML0h5OvLRWWJEJ+Uc7gvHjlYtaXsu8
         bTVWwnbF6pK5VjWrvW2OG0Wb889aFiyZ8VNWztk3MIV3KylWUUYIWzZ6jQgPqkJuOqWM
         cnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veketWKw2Fc5JJ/rZK6bSXLb4liBnzJiO6VVedHVvtI=;
        b=VZtCLBPe4cZ6YyEZDgjX6u9qlLkCoKljwxu88i8/zK2N+uADsY+xPBBUb5C4CKfrFK
         Wa4e20fHUiRhwA/CMbvgCS92o7Av4m0O6PBoNS5xW4+9oDVLixhhsjKU3ZeqFziBMIXo
         5mSX2uRhOE0vtE1ASaW4OuxUoNf+PIlIzH0lZd8ZZ6SLHvxwM0h3zr0wqbGVwwRYqPRI
         4sn14VOJ3JaseRvrl8c/fLgIqtrSMNethnKE4LB16ZWSnCeehRfrBbUKagU8zNCsecTK
         J64eb/tv6zC9iwE74YzZomfqs4DPrvgNR0sy5RylnGsGzF8iLrG7XNRsFWkjdCFaVeq4
         B3Vg==
X-Gm-Message-State: AOAM5337vMYe+cVhRbteA33yzzmsc37nrlH+FasVds9LGrP/xE0JoSZB
        XsFwYKQK0039paV+h6Wza0AlXXh4RQs=
X-Google-Smtp-Source: ABdhPJy/ZPHv69MkdKzJofw/uBoKB6hSvo0rzFkl1tEuIg6qjG1H/XPAzRbV9+qmYc3VH6PaVKqsyg==
X-Received: by 2002:a17:90b:1106:: with SMTP id gi6mr24154809pjb.115.1636046076392;
        Thu, 04 Nov 2021 10:14:36 -0700 (PDT)
Received: from localhost.localdomain ([68.170.74.242])
        by smtp.gmail.com with ESMTPSA id ng9sm8035370pjb.4.2021.11.04.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 10:14:35 -0700 (PDT)
From:   Mehrdad Arshad Rad <arshad.rad@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Mehrdad Arshad Rad <arshad.rad@gmail.com>
Subject: [PATCH] libbpf: Fix lookup_and_delete_elem_flags
Date:   Thu,  4 Nov 2021 10:13:54 -0700
Message-Id: <20211104171354.11072-1-arshad.rad@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added libbpf_err_errno to bpf_map_lookup_and_delete_elem_flags

Signed-off-by: Mehrdad Arshad Rad <arshad.rad@gmail.com>
---
 tools/lib/bpf/bpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c09cbb868c9f..725701235fd8 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -515,6 +515,7 @@ int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, __u64 flags)
 {
 	union bpf_attr attr;
+	int ret;
 
 	memset(&attr, 0, sizeof(attr));
 	attr.map_fd = fd;
@@ -522,7 +523,8 @@ int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, _
 	attr.value = ptr_to_u64(value);
 	attr.flags = flags;
 
-	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
+	ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
+	return libbpf_err_errno(ret);
 }
 
 int bpf_map_delete_elem(int fd, const void *key)
-- 
2.25.1

