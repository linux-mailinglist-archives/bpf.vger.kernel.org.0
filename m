Return-Path: <bpf+bounces-62716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36087AFDB91
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EBD178D9E
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 23:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2D2327A3;
	Tue,  8 Jul 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGeOR/DJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF222F383
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016111; cv=none; b=ciU88ofzmc8rEYARhfcvKwHR/FvAUoQaxarH5rMU0mUKrzf11HFjsB0cF3ihVNvIkmhoMubIN63aZc8jYziw4HYP8wYpZHuE0Tt9P9pLPKXJF7Bmf+f8kFjnCn8rLiNBfbQ3ghb8JAy1al7HgCAg3tUmCtKs3NQPZ9sY749Iyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016111; c=relaxed/simple;
	bh=X8PHsRLDtGz70POJPFrbhWTP06TUPuLrQ2JxNzmfvN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9OnYTh9BGJddgODsIhFdSkGNdf9Mg9Ci3RzXUkSAcPKar4D5KoMzcFW9g/Xx4BogZxyysLxr+SjyxafOq1IrTtHgVG6nkYj7ocrNL7HTg+tLqLQKk5kTTtKONX8PTKCS/jti9SnCMhT08ayzOLOAQ/J3DskwVejADtYU5ajJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGeOR/DJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b52bf417cso3235034b3a.0
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752016109; x=1752620909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+HXO1azrzKVO/eA/px08k551BzStcd852kR0sKyLqQ=;
        b=YGeOR/DJSwxkgxa+BRlJoibNqg+t9v7gUtAsOsvTAxhSUyqPMIDzkl9DbPNcrOsMay
         KkcnfRa8rBSAnJZMtHYMn9Doxhgc+vuCf4f8nUE3fl20m4ro3T4Q2b4HMH8bjxu3hpmj
         SgBNL5ZKFb8v8UyMIpKZ3BU6BqIurobtXNHzbmybkqk5Uz0Eo7tv8/OH2Abc32AiMEqG
         HwT3P9zbADimVmgCC2TU3kNnJpojfH02VoPpJJzI34uGf2fOXVtwvXeDNDq9pP/xIokC
         E3qygii7wMlbzKnUb71svGItluxvxvtTlBxeOoOD1YzCiPz8bshNVJcPD6fBQin6dEiu
         jJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016109; x=1752620909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+HXO1azrzKVO/eA/px08k551BzStcd852kR0sKyLqQ=;
        b=Cbz3TgWP8kITGQGYlA6v0k/tEP9Lc4f/Z2vKtmljPPyq7TuHB3GOyrhMvVM537C3uT
         wxzrGcb6PEfb4b+nGSKZ9b6zcSwT5KtKwlq4kcAQq5JuXriqUUYkFYjQmcDEVEQbUznb
         SXyUlW9DvNypikbHfE6OLwokIA3saQnyl7MFchP5Y29lV4fmIi8ZZqUgtYi1A7dH3WUD
         6RnC/r6KqvkiyALnBYCmSYpeEofz1kCRr+4wzLmWjoMnaXh3lbP9ffo0B+hyTfjDjf6N
         CXvj0ZrMNmxc74Q1vZbw+WiER28zwMJ70+aW0L9Czz7Fun9CY8wCUpmZNckDSQk5eOWi
         sNPQ==
X-Gm-Message-State: AOJu0Yw2E7z9oMld/SbiaDrZCBB6nKC8GPYao1FMgMzst+eXxzMhWCcB
	3leCMd4j7TPc95BF5FCIHGYBt12EjsYhjTT8t2H8hPb92gRSR2RqBnh0qaX1bg==
X-Gm-Gg: ASbGncuXqkJevHomeI+knWnSbmwnxKcTWB4v72+QzmGIv3ROAg7g/5+A9Jftzukkl5P
	BQTMNV3GFhPzXQBylMFcUc17EbMIHGh2Xth9bUFVwhQ1w/r6Ks67kZKbORgjsufcCwE5by54loo
	kMuOfpLHPsEnFjY06QPec9K3uduJ/j0zuAUGc/R2PpCLvYH6XQ13Vv4eo/x/GiOzyQF+2RyFJMf
	kUUX+OWIKiyh0un+3xFU0qZZjpkwvBIOyVWBv2c1JAKhnpgT9exMRQvD8LCcz9WdOstxT9wxAdr
	Xvgo5vMSM6rIESLHI8wsDa8jQAFlClCmPFSEwiUhOwBJh6BCZBPX0Q==
X-Google-Smtp-Source: AGHT+IHkhjgtNMsdUvjO1c7zjzm92RoECdwsi03vSV1Q7LeOLY0k+TwE0WWSd5taToU7i/klYkELtg==
X-Received: by 2002:a05:6a00:8cb:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-74ea63e6803mr549704b3a.4.1752016108864;
        Tue, 08 Jul 2025 16:08:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417ddb3sm13115130b3a.87.2025.07.08.16.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 16:08:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based struct_ops attachment
Date: Tue,  8 Jul 2025 16:08:23 -0700
Message-ID: <20250708230825.4159486-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708230825.4159486-1-ameryhung@gmail.com>
References: <20250708230825.4159486-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support cookie when attaching a struct_ops map using link. The cookie is
associated with the link and can be retrieved in bpf struct_ops program
using bpf_get_attach_cookie().

Implementation wise, trampoline and ksyms preparation are deferred from
map_update to link_create for struct_ops maps with BPF_F_LINK. Since bpf
cookie is hardcoded to the trampoline in arch_prepare_bpf_trampoline(),
it must be done when cookie is known (i.e., link_create). The trampoline
and ksyms are freed once a link is detached as the struct_ops map is no
longer associated with the link.

TODO:
A struct_ops map with BPF_F_LINK should be prevented from being used to
create another link after this patch since a struct_ops map currently
only support a set of trampoline. This may be done reusing the state
from non-BPF_F_LINK struct_ops map: set the state from READY to INUSE
in link_create, and check the state in link_create and link_update.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/uapi/linux/bpf.h       |  3 ++
 kernel/bpf/bpf_struct_ops.c    | 59 +++++++++++++++++++++++++---------
 kernel/bpf/helpers.c           | 18 +++++++++++
 tools/include/uapi/linux/bpf.h |  3 ++
 4 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0670e15a6100..4708d0783130 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1818,6 +1818,9 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} cgroup;
+			struct {
+				__u64		cookie;
+			} struct_ops;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 4d150e99a86c..3ad0697a3c00 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -59,6 +59,7 @@ struct bpf_struct_ops_link {
 	struct bpf_link link;
 	struct bpf_map __rcu *map;
 	wait_queue_head_t wait_hup;
+	u64 cookie;
 };
 
 static DEFINE_MUTEX(update_mutex);
@@ -673,7 +674,7 @@ static void bpf_struct_ops_map_free_ksyms(struct bpf_struct_ops_map *st_map)
 	}
 }
 
-static int bpf_struct_ops_prepare_attach(struct bpf_struct_ops_map *st_map)
+static int bpf_struct_ops_prepare_attach(struct bpf_struct_ops_map *st_map, u64 cookie)
 {
 	const struct bpf_struct_ops *st_ops = st_map->st_ops_desc->st_ops;
 	const struct btf_type *t = st_map->st_ops_desc->type;
@@ -714,6 +715,7 @@ static int bpf_struct_ops_prepare_attach(struct bpf_struct_ops_map *st_map)
 
 		mname = btf_name_by_offset(st_map->btf, member->name_off);
 		link = container_of(*plink++, struct bpf_tramp_link, link);
+		link->cookie = cookie;
 
 		ksym = kzalloc(sizeof(*ksym), GFP_USER);
 		if (!ksym) {
@@ -892,10 +894,6 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		*(unsigned long *)(udata + moff) = prog->aux->id;
 	}
 
-	err = bpf_struct_ops_prepare_attach(st_map);
-	if (err)
-		goto reset_unlock;
-
 	if (st_map->map.map_flags & BPF_F_LINK) {
 		err = 0;
 		/* Let bpf_link handle registration & unregistration.
@@ -906,6 +904,10 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
+	err = bpf_struct_ops_prepare_attach(st_map, 0);
+	if (err)
+		goto reset_unlock;
+
 	err = st_ops->reg(kdata, NULL);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
@@ -915,6 +917,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 * or transition it to TOBEFREE concurrently.
 		 */
 		bpf_map_inc(map);
+		bpf_struct_ops_map_add_ksyms(st_map);
 		/* Pair with smp_load_acquire() during lookup_elem().
 		 * It ensures the above udata updates (e.g. prog->aux->id)
 		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
@@ -937,8 +940,6 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	memset(kvalue, 0, map->value_size);
 unlock:
 	mutex_unlock(&st_map->lock);
-	if (!err)
-		bpf_struct_ops_map_add_ksyms(st_map);
 	return err;
 }
 
@@ -1247,7 +1248,11 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 	rcu_read_lock();
 	map = rcu_dereference(st_link->map);
 	if (map)
-		seq_printf(seq, "map_id:\t%d\n", map->id);
+		seq_printf(seq,
+			   "map_id:\t%d\n"
+			   "cookie:\t%llu\n",
+			   map->id,
+			   st_link->cookie);
 	rcu_read_unlock();
 }
 
@@ -1302,14 +1307,28 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		goto err_out;
 	}
 
+	err = bpf_struct_ops_prepare_attach(st_map, st_link->cookie);
+	if (err)
+		goto free_image;
+
 	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data, link);
 	if (err)
-		goto err_out;
+		goto free_image;
 
 	bpf_map_inc(new_map);
 	rcu_assign_pointer(st_link->map, new_map);
+	bpf_struct_ops_map_add_ksyms(st_map);
+	bpf_struct_ops_map_del_ksyms(old_st_map);
+	bpf_struct_ops_map_free_ksyms(old_st_map);
+	bpf_struct_ops_map_free_image(old_st_map);
 	bpf_map_put(old_map);
+	mutex_unlock(&update_mutex);
+
+	return 0;
 
+free_image:
+	bpf_struct_ops_map_free_ksyms(st_map);
+	bpf_struct_ops_map_free_image(st_map);
 err_out:
 	mutex_unlock(&update_mutex);
 
@@ -1395,24 +1414,34 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;
 
+	link->cookie = attr->link_create.struct_ops.cookie;
+
 	init_waitqueue_head(&link->wait_hup);
 
 	/* Hold the update_mutex such that the subsystem cannot
 	 * do link->ops->detach() before the link is fully initialized.
 	 */
 	mutex_lock(&update_mutex);
+	err = bpf_struct_ops_prepare_attach(st_map, link->cookie);
+	if (err)
+		goto free_image;
+
 	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
-	if (err) {
-		mutex_unlock(&update_mutex);
-		bpf_link_cleanup(&link_primer);
-		link = NULL;
-		goto err_out;
-	}
+	if (err)
+		goto free_image;
+
 	RCU_INIT_POINTER(link->map, map);
+	bpf_struct_ops_map_add_ksyms(st_map);
 	mutex_unlock(&update_mutex);
 
 	return bpf_link_settle(&link_primer);
 
+free_image:
+	bpf_struct_ops_map_free_ksyms(st_map);
+	bpf_struct_ops_map_free_image(st_map);
+	mutex_unlock(&update_mutex);
+	bpf_link_cleanup(&link_primer);
+	link = NULL;
 err_out:
 	bpf_map_put(map);
 	kfree(link);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3d33181d5e67..4075fdd1533f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1894,6 +1894,21 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
 	.arg3_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
 
+BPF_CALL_1(bpf_get_attach_cookie_struct_ops, void *, ctx)
+{
+	struct bpf_tramp_run_ctx *run_ctx;
+
+	run_ctx = container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
+	return run_ctx->bpf_cookie;
+}
+
+static const struct bpf_func_proto bpf_get_attach_cookie_proto_struct_ops = {
+	.func		= bpf_get_attach_cookie_struct_ops,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1962,6 +1977,9 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_ns_current_pid_tgid_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_attach_cookie:
+		return prog->type == BPF_PROG_TYPE_STRUCT_OPS ?
+		       &bpf_get_attach_cookie_proto_struct_ops : NULL;
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0670e15a6100..4708d0783130 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1818,6 +1818,9 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} cgroup;
+			struct {
+				__u64		cookie;
+			} struct_ops;
 		};
 	} link_create;
 
-- 
2.47.1


