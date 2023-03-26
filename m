Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330C06C9377
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjCZJWv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjCZJWm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:42 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6050F9778;
        Sun, 26 Mar 2023 02:22:27 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x1so5867903qtr.7;
        Sun, 26 Mar 2023 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEt9rMCN/8rHzWzG6uXe7mNBDuuwgA3Px4yTSwTLem8=;
        b=Uq763ijSODYcUZCFGo67S6aCcVOADK/sW5Dhphk+A3w7DCkjTLE3pF/aqOMwlZOJ/e
         NTRke8IFf0+MSL1qxNnqFz/iFP8hN65vi+hsuhyAbf/D5GuqzYt3tc3VtVuz1Jm1H2Zu
         wy8odXBWigyiwb6xVj921Elg9aE4zfBRM2iTXwDBET2J2xDqQ4MZhDso/JojYggxaP7N
         sXtCT3qDkvU2yA9D/XxSC+Bes1Ckpji9D6vFx2wF9mST5N+oSXOt1S+7/0kqIvDQ+A7M
         Ij2VnMIWvehC+Om9PcFQNwRRYYDpE5JAL8bOCUfFuW5GlHFqoY75eZoO8dLMUh2FKZUy
         wBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEt9rMCN/8rHzWzG6uXe7mNBDuuwgA3Px4yTSwTLem8=;
        b=MzL/ppXaWW/3uJf8XBwHoKaDb0oIgALXRx9K1Ip4nPKa/GwscLhuuNqSd/ptv6VPtO
         UbLjxeJkMm1GlHS/xcm1gortBRfkbTdUBvghYeZ+IMdYHb2yT2+Vz0fM2+2ib2cl3oKp
         v+O8d0HO4ZinVrkPatvRUMDNj24wHCcIBwL6m+TKRffFzTthDTM4XILDXufzQ1kgnS+n
         HC0Oa2CYnP+sMZoZYQPWJYkAO7VyrecndWa0fs1a8Af2la0uvL1k/iIqTZw9GDonv5X3
         sxGRDVg77j5E1pNOH6izR65ips1iOsX/Tw+m3WCSV5IGnBaxDaqp4z7Ox2N34ZYgUs+g
         k+Uw==
X-Gm-Message-State: AO0yUKXGKlMKp81tJLUkfqNr5eF3a/FBZ+1HkkFBcV1mL49opjrN0b4X
        kItu2/qoOoMmsz91EEMxo7E=
X-Google-Smtp-Source: AKy350axGSAtaUnJ8cD1yseHz0qq67FsBed/yK7GOazVxmcNTUFHjtBsY5jl3LMh3vdcC4gu0RdDDg==
X-Received: by 2002:a05:622a:199a:b0:3bf:e4da:2367 with SMTP id u26-20020a05622a199a00b003bfe4da2367mr15703885qtc.3.1679822547030;
        Sun, 26 Mar 2023 02:22:27 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:26 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 11/13] bpf: Allow iterating bpf objects with CAP_BPF in bpf namespace
Date:   Sun, 26 Mar 2023 09:22:06 +0000
Message-Id: <20230326092208.13613-12-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

CAP_SYS_ADMIN is not required to iterate bpf objects if a user is in a
non-init bpf namespace. The user can iterate bpf maps, progs, and links
in his bpf namespace but can't iterate the bpf objects in different bpf
namespace.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf_namespace.h |  8 ++++++++
 kernel/bpf/syscall.c          | 10 +++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_namespace.h b/include/linux/bpf_namespace.h
index 50bd68c..f484791 100644
--- a/include/linux/bpf_namespace.h
+++ b/include/linux/bpf_namespace.h
@@ -5,6 +5,7 @@
 #include <linux/idr.h>
 #include <linux/ns_common.h>
 #include <linux/user_namespace.h>
+#include <linux/capability.h>
 
 struct ubpf_obj_id {
 	int nr;
@@ -79,4 +80,11 @@ static inline int bpf_obj_id_vnr(struct bpf_obj_id *obj_id)
 {
 	return bpf_obj_id_nr_ns(obj_id, current->nsproxy->bpf_ns);
 }
+
+static inline bool bpfns_capable(void)
+{
+	if (current->nsproxy->bpf_ns != &init_bpf_ns && capable(CAP_BPF))
+		return true;
+	return false;
+}
 #endif /* _LINUX_BPF_ID_NS_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 855d5f7..8a72694 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3628,7 +3628,7 @@ static int bpf_obj_get_next_id(const union bpf_attr *attr,
 	if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >= INT_MAX)
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) && !bpfns_capable())
 		return -EPERM;
 
 	next_id++;
@@ -3712,7 +3712,7 @@ static int bpf_prog_get_fd_by_id(const union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_PROG_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) && !bpfns_capable())
 		return -EPERM;
 
 	prog = bpf_prog_by_id(id);
@@ -3740,7 +3740,7 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 	    attr->open_flags & ~BPF_OBJ_FLAG_MASK)
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) && !bpfns_capable())
 		return -EPERM;
 
 	f_flags = bpf_get_file_flag(attr->open_flags);
@@ -4386,7 +4386,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	if (CHECK_ATTR(BPF_TASK_FD_QUERY))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) && !bpfns_capable())
 		return -EPERM;
 
 	if (attr->task_fd_query.flags != 0)
@@ -4781,7 +4781,7 @@ static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_LINK_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) && !bpfns_capable())
 		return -EPERM;
 
 	link = bpf_link_by_id(id);
-- 
1.8.3.1

