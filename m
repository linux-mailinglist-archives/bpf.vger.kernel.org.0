Return-Path: <bpf+bounces-363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203F6FF84B
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 19:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7BA1C20FC0
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9698F74;
	Thu, 11 May 2023 17:21:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCE46A2
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 17:21:04 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE4A5FE5
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:21:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-517bfcfe83fso4813765a12.2
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683825662; x=1686417662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Id/XI7HmaFujCqezw1mzUHd3n5YdL8dJKt80jI2kfyA=;
        b=qTCUnxDkX5j7po4Q557jlcjyo1nkkYkzOuguSVcmDD+u1nWM0GgWxHHeRh9Hc3B1LO
         wPRfaGAAuZ0FYXhX5k/5yb8hW/9F2KZF27lgHSf50cESH63PD7h1NfSvkYpwxF+53I53
         h20FTJ7xhthibG9olZ1IRNVfHvMWk9lYbPmz1wDd4lW+QhoohgegBb4+zUYaChFoZATF
         sp4tYc3+fGnJBabx9L/iz8UVNTaKeO8ZAjVRIc7KVFUULYkIxvGdN0xXo8tQtqqY+Zvc
         dbC9f/sPqR0V+JhFZrioN5aKQz8iAjFfBEPv3umEbsvf3NoPK3YA5GUyfGIOc46a1SB8
         fJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825662; x=1686417662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Id/XI7HmaFujCqezw1mzUHd3n5YdL8dJKt80jI2kfyA=;
        b=gD103yJEcXhj2XVIreeG5FIvS6bMyByOl6fQoj03YbzQja8NzQMTntHAJXq3nOlxg+
         DyHpcHKKKgUVsoKrW7fLBt5ym/PgJYpgPt8ne0HYlKk5nqFharuO5yN/XLnWXBKauwr+
         tRrSATBASWCXrgO/zXW/68aJU6SEWWisaoG/IdPw15VjsVuppIj78vLk8sUq4p+dry1c
         4T81XjGkAOHgcaFeZc0+/TRGjKEu/LHm4LnRWgJK8ZMZwc904zTAuSKg7bU1dBl/toxY
         7PFCtAk7r+WBWho+N20wx+A+RN/PRFgrEQ9QqL/nRk+tVkD7ON7gDIZkAxHekfaGPaas
         XTAQ==
X-Gm-Message-State: AC+VfDwX7xl8v/dOiFnOitv+aTyteOajbdRI2cP3vCKEO9workKR+2x0
	u+VY/qt2nQkerbXnt5EE9FDOScG1jlmmSK3SPv9sTf3s56aEKbnxvTAt147OjJr0RUHuDnWX/Y6
	N+aMLSsGhUa0aasyZ+h2LAAhZ7fwQWpXYy6Js1Vdb4K2NewrNPQ==
X-Google-Smtp-Source: ACHHUZ70P48MafN40T2/066mVDVM9Rw8mip6iTzG4ftvlUQNPRgP6MujY2jsSXNn9wmzvXH1ZXxcz44=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ea11:b0:1ac:8cd4:7419 with SMTP id
 s17-20020a170902ea1100b001ac8cd47419mr4152560plg.5.1683825662229; Thu, 11 May
 2023 10:21:02 -0700 (PDT)
Date: Thu, 11 May 2023 10:20:53 -0700
In-Reply-To: <20230511172054.1892665-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511172054.1892665-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511172054.1892665-4-sdf@google.com>
Subject: [PATCH bpf-next 3/4] bpf: refactor __cgroup_bpf_query
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

No functional changes.

This patch is here to make it easier to review the next one.
We'll be copying buffer to the userspace from the temporary
kernel one, so rename prog_ids to user_prog_ids and add new
extra variable (p) to traverse it.

Also, instead of decrementing total_cnt, introduce new 'remaning'
variable to keep track of where we are. We'll need original
total_cnt in the next patch to know how many bytes to copy back.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a06e118a9be5..32092c78602f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1021,21 +1021,23 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 {
 	__u32 __user *prog_attach_flags = u64_to_user_ptr(attr->query.prog_attach_flags);
 	bool effective_query = attr->query.query_flags & BPF_F_QUERY_EFFECTIVE;
-	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	__u32 __user *user_prog_ids = u64_to_user_ptr(attr->query.prog_ids);
 	enum bpf_attach_type type = attr->query.attach_type;
 	enum cgroup_bpf_attach_type from_atype, to_atype;
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog_array *effective;
 	int cnt, ret = 0, i;
 	int total_cnt = 0;
+	int remaining;
 	u32 flags;
+	u32 *p;
 
 	if (effective_query && prog_attach_flags)
 		return -EINVAL;
 
 	if (type == BPF_LSM_CGROUP) {
 		if (!effective_query && attr->query.prog_cnt &&
-		    prog_ids && !prog_attach_flags)
+		    user_prog_ids && !prog_attach_flags)
 			return -EINVAL;
 
 		from_atype = CGROUP_LSM_START;
@@ -1065,7 +1067,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		return -EFAULT;
 	if (copy_to_user(&uattr->query.prog_cnt, &total_cnt, sizeof(total_cnt)))
 		return -EFAULT;
-	if (attr->query.prog_cnt == 0 || !prog_ids || !total_cnt)
+	if (attr->query.prog_cnt == 0 || !user_prog_ids || !total_cnt)
 		/* return early if user requested only program count + flags */
 		return 0;
 
@@ -1074,12 +1076,14 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		ret = -ENOSPC;
 	}
 
-	for (atype = from_atype; atype <= to_atype && total_cnt; atype++) {
+	p = user_prog_ids;
+	remaining = total_cnt;
+	for (atype = from_atype; atype <= to_atype && remaining; atype++) {
 		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
-			cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);
-			ret = bpf_prog_array_copy_to_user(effective, prog_ids, cnt);
+			cnt = min_t(int, bpf_prog_array_length(effective), remaining);
+			ret = bpf_prog_array_copy_to_user(effective, p, cnt);
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;
@@ -1087,12 +1091,12 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 			u32 id;
 
 			progs = &cgrp->bpf.progs[atype];
-			cnt = min_t(int, prog_list_length(progs), total_cnt);
+			cnt = min_t(int, prog_list_length(progs), remaining);
 			i = 0;
 			hlist_for_each_entry(pl, progs, node) {
 				prog = prog_list_prog(pl);
 				id = prog->aux->id;
-				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
+				if (copy_to_user(p + i, &id, sizeof(id)))
 					return -EFAULT;
 				if (++i == cnt)
 					break;
@@ -1109,8 +1113,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 			}
 		}
 
-		prog_ids += cnt;
-		total_cnt -= cnt;
+		p += cnt;
+		remaining -= cnt;
 	}
 	return ret;
 }
-- 
2.40.1.521.gf1e218fcd8-goog


