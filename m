Return-Path: <bpf+bounces-134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E76F88D1
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 20:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9441E1C2195C
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647FC8D2;
	Fri,  5 May 2023 18:45:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F0156EF
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 18:45:53 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33A159D4
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 11:45:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f32cc8c31so3812947276.2
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683312352; x=1685904352;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JYH6yjYyFxchRW+drWuqI4RYj3NGZEYWg6Dp6n94NHA=;
        b=xDSKe1j2HVsOUguizcphc1uBOvEWWTiUbpdKL/P0grXAM+PRy/VkPtojoHpEvhhRYl
         B8Gb7yfKwCu4szFyEcdkJiDPKAtV5kV8gULRiJXPMShY+ecjIk4OP2CFLYzBGguMGHmP
         H9vdM+Zh4Z132Tr3PDToORT9kzSMIXwRMXD3sm+ch+sCyWERcCdkrSQlAkcm7cG+RhNw
         7xAWEWV7vwvXxmNx/TGocGwjoPGzQglObzLcdS0MY6ZSKXCqZo1gxd5441lEJFj8Gi5O
         pO+PiSfUYaxRU1YvZf8tDsH+5TNo/oZ0gScP13G1CjM+KfYfG6b7i7VdQNKosUsRzYQX
         n5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312352; x=1685904352;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYH6yjYyFxchRW+drWuqI4RYj3NGZEYWg6Dp6n94NHA=;
        b=jiqMkdk7Bk763a/A7IrIHzFLF9qCbWtJxRg8ZRoR6yvV4yjFfY1p6Ue9UnUbTW0twx
         GNvZuJ7z0lFIhVJbIPEJ9b//kj+b39FXmDJjH1J0NVf+EIU3e9i3OyUHJa1wFNjLdwq1
         vhwvyDhnsM6EbYkCA5TQkwIpq55vml/2tgwPAZygXZ2qxBmXylJJqd7JRtAiil5NpSjc
         +9JLwtzIdcCmcycX5A38gcs+/azEhfmTGWKRS/SGBdYHjS1MRnsL08Lj/FYnhM3g06iq
         rEwmQoz8C/BMiEOfI/ElYHS9kPUmcplpsjjZ0P14RA/2KchABgVk4BVEU6KBNP6yXyoD
         g2IA==
X-Gm-Message-State: AC+VfDwirEt3iwFJMSdrhnm+OsXz7rGX2m+s/cKOPLdsVkoEJLhQFM3A
	m6xMTpMdO6FtjE8XD2HoZMbtoabxdyU85R7njsoIutL6UdnpFuBqTWJk8wYs1LnVDqmfZyrhUde
	663bgUimSK9HELc5WmGS1yuKpNiGLqL1bKbmwB5MuzcFWiuh3zA==
X-Google-Smtp-Source: ACHHUZ4iDPPuQYoXz6YechxEqNx/CQOJYB5WadPneAeylXlyXas9xwyTSDRcuvYPmPZ/s8+57cBxaHs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:1c82:0:b0:b9e:6d41:54c4 with SMTP id
 c124-20020a251c82000000b00b9e6d4154c4mr1078192ybc.8.1683312351830; Fri, 05
 May 2023 11:45:51 -0700 (PDT)
Date: Fri,  5 May 2023 11:45:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230505184550.1386802-1-sdf@google.com>
Subject: [PATCH bpf-next] RFC: bpf: query effective progs without cgroup_mutex
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We're observing some stalls on the heavily loaded machines
in the cgroup_bpf_prog_query path. This is likely due to
being blocked on cgroup_mutex.

IIUC, the cgroup_mutex is there mostly to protect the non-effective
fields (cgrp->bpf.progs) which might be changed by the update path.
For the BPF_F_QUERY_EFFECTIVE case, all we need is to rcu_dereference
a bunch of pointers (and keep them around for consistency), so
let's do it.

Sending out as an RFC because it looks a bit ugly. It would also
be nice to handle non-effective case locklessly as well, but it
might require a larger rework.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a06e118a9be5..c9d4b66e2c15 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1022,10 +1022,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	__u32 __user *prog_attach_flags = u64_to_user_ptr(attr->query.prog_attach_flags);
 	bool effective_query = attr->query.query_flags & BPF_F_QUERY_EFFECTIVE;
 	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	struct bpf_prog_array *effective[MAX_CGROUP_BPF_ATTACH_TYPE];
 	enum bpf_attach_type type = attr->query.attach_type;
 	enum cgroup_bpf_attach_type from_atype, to_atype;
 	enum cgroup_bpf_attach_type atype;
-	struct bpf_prog_array *effective;
 	int cnt, ret = 0, i;
 	int total_cnt = 0;
 	u32 flags;
@@ -1051,9 +1051,9 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 
 	for (atype = from_atype; atype <= to_atype; atype++) {
 		if (effective_query) {
-			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
-							      lockdep_is_held(&cgroup_mutex));
-			total_cnt += bpf_prog_array_length(effective);
+			effective[atype] = rcu_dereference_protected(cgrp->bpf.effective[atype],
+								     lockdep_is_held(&cgroup_mutex));
+			total_cnt += bpf_prog_array_length(effective[atype]);
 		} else {
 			total_cnt += prog_list_length(&cgrp->bpf.progs[atype]);
 		}
@@ -1076,10 +1076,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 
 	for (atype = from_atype; atype <= to_atype && total_cnt; atype++) {
 		if (effective_query) {
-			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
-							      lockdep_is_held(&cgroup_mutex));
-			cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);
-			ret = bpf_prog_array_copy_to_user(effective, prog_ids, cnt);
+			cnt = min_t(int, bpf_prog_array_length(effective[atype]), total_cnt);
+			ret = bpf_prog_array_copy_to_user(effective[atype], prog_ids, cnt);
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;
@@ -1118,11 +1116,23 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 			    union bpf_attr __user *uattr)
 {
+	__u32 __user *prog_attach_flags = u64_to_user_ptr(attr->query.prog_attach_flags);
+	bool effective_query = attr->query.query_flags & BPF_F_QUERY_EFFECTIVE;
+	bool need_mutex = false;
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	if (effective_query && !prog_attach_flags)
+		need_mutex = false;
+
+	if (need_mutex)
+		mutex_lock(&cgroup_mutex);
+	else
+		rcu_read_lock();
 	ret = __cgroup_bpf_query(cgrp, attr, uattr);
-	mutex_unlock(&cgroup_mutex);
+	if (need_mutex)
+		mutex_unlock(&cgroup_mutex);
+	else
+		rcu_read_unlock();
 	return ret;
 }
 
-- 
2.40.1.521.gf1e218fcd8-goog


