Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0715C22395F
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgGQKfn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgGQKfm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 06:35:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F1C061755
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t9so5746737lfl.5
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ky7Uwd6iOLNxL3k0LttI/qHMrfh4/rNGFNpqXTzD72k=;
        b=nEcDn0DfA+WcArBQl/5WVvOkpMc5OjsLMqzCglcytwykLk0dvf1TJLylKhKjn6889z
         OGPV3utedExOtYpkksOuyx/BmTkzMsoCbiF9Ul/quwune76CLLTwvzxM4tvQYQbAPvFD
         TOWiiwXWvCdpboUe3d3qD5mcjrpiaR/9xi1po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ky7Uwd6iOLNxL3k0LttI/qHMrfh4/rNGFNpqXTzD72k=;
        b=gglWJtAiU5BPQ58tMR+CTCrOgXS5JHXAAdQJnh0hrNtu8zt2V1yu5v58zq2AqC6qtO
         PNGtPABPuXd/ga7X2LgjHLJHNnSYgIkLvJNtvT5cbdORwKxZAGkdJDoxuVl6zBuEy6yX
         K0Zj5hoTMv17tgnWL9B/OjbFSoUu4vlyHWZOuYteINRwGm++r1nQeT5AdavNGO/E8MrG
         ndpj1NgMJKcQJ9z0S4wFONE8KMaOo/4xAHWrfNhq42kEsvRBjD4j+p0snkxhR0KqqUOk
         0GT/NoMzPcV4uY5ga+7BAPAwBYVAjeWJO/8rwqAdR04VXlfC2hWLkIgHd3HNYuULv53R
         YVXg==
X-Gm-Message-State: AOAM530QFEyGLdt03DVB93RvA7nk7OaH593dWajSGw1r5x5lh8WxPO2t
        hG6bxU74PPfRGXx1fMBThIGiszye0MLdPA==
X-Google-Smtp-Source: ABdhPJxj77WW/WfzDQ9ZOeDxJ7QkLoiCUA3WextVubpq4EhnoiAIsgFsLXdAOdhZj23Zs0G/1frm8g==
X-Received: by 2002:ac2:47eb:: with SMTP id b11mr4519679lfp.165.1594982139754;
        Fri, 17 Jul 2020 03:35:39 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id p8sm1871618ljn.117.2020.07.17.03.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:35:38 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v5 01/15] bpf, netns: Handle multiple link attachments
Date:   Fri, 17 Jul 2020 12:35:22 +0200
Message-Id: <20200717103536.397595-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717103536.397595-1-jakub@cloudflare.com>
References: <20200717103536.397595-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the BPF netns link callbacks to rebuild (grow/shrink) or update the
prog_array at given position when link gets attached/updated/released.

This let's us lift the limit of having just one link attached for the new
attach type introduced by subsequent patch.

No functional changes intended.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v4:
    - Document prog_array {delete_safe,update}_at() behavior. (Andrii)
    - Return -EINVAL/-ENOENT on failure in {delete_safe,update}_at(). (Andrii)
    - Return -ENOENT on index out of range in link_index(). (Andrii)
    
    v3:
    - New in v3 to support multi-prog attachments. (Alexei)

 include/linux/bpf.h        |  3 ++
 kernel/bpf/core.c          | 55 +++++++++++++++++++++++
 kernel/bpf/net_namespace.c | 90 ++++++++++++++++++++++++++++++++++----
 3 files changed, 139 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54ad426dbea1..c8c9eabcd106 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -928,6 +928,9 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array *progs,
 
 void bpf_prog_array_delete_safe(struct bpf_prog_array *progs,
 				struct bpf_prog *old_prog);
+int bpf_prog_array_delete_safe_at(struct bpf_prog_array *array, int index);
+int bpf_prog_array_update_at(struct bpf_prog_array *array, int index,
+			     struct bpf_prog *prog);
 int bpf_prog_array_copy_info(struct bpf_prog_array *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9df4cc9a2907..7be02e555ab9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1958,6 +1958,61 @@ void bpf_prog_array_delete_safe(struct bpf_prog_array *array,
 		}
 }
 
+/**
+ * bpf_prog_array_delete_safe_at() - Replaces the program at the given
+ *                                   index into the program array with
+ *                                   a dummy no-op program.
+ * @array: a bpf_prog_array
+ * @index: the index of the program to replace
+ *
+ * Skips over dummy programs, by not counting them, when calculating
+ * the the position of the program to replace.
+ *
+ * Return:
+ * * 0		- Success
+ * * -EINVAL	- Invalid index value. Must be a non-negative integer.
+ * * -ENOENT	- Index out of range
+ */
+int bpf_prog_array_delete_safe_at(struct bpf_prog_array *array, int index)
+{
+	return bpf_prog_array_update_at(array, index, &dummy_bpf_prog.prog);
+}
+
+/**
+ * bpf_prog_array_update_at() - Updates the program at the given index
+ *                              into the program array.
+ * @array: a bpf_prog_array
+ * @index: the index of the program to update
+ * @prog: the program to insert into the array
+ *
+ * Skips over dummy programs, by not counting them, when calculating
+ * the position of the program to update.
+ *
+ * Return:
+ * * 0		- Success
+ * * -EINVAL	- Invalid index value. Must be a non-negative integer.
+ * * -ENOENT	- Index out of range
+ */
+int bpf_prog_array_update_at(struct bpf_prog_array *array, int index,
+			     struct bpf_prog *prog)
+{
+	struct bpf_prog_array_item *item;
+
+	if (unlikely(index < 0))
+		return -EINVAL;
+
+	for (item = array->items; item->prog; item++) {
+		if (item->prog == &dummy_bpf_prog.prog)
+			continue;
+		if (!index) {
+			WRITE_ONCE(item->prog, prog);
+			return 0;
+		}
+		index--;
+	}
+	return -ENOENT;
+}
+
 int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 310241ca7991..e9c8e26ac8f2 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -36,12 +36,50 @@ static void netns_bpf_run_array_detach(struct net *net,
 	bpf_prog_array_free(run_array);
 }
 
+static int link_index(struct net *net, enum netns_bpf_attach_type type,
+		      struct bpf_netns_link *link)
+{
+	struct bpf_netns_link *pos;
+	int i = 0;
+
+	list_for_each_entry(pos, &net->bpf.links[type], node) {
+		if (pos == link)
+			return i;
+		i++;
+	}
+	return -ENOENT;
+}
+
+static int link_count(struct net *net, enum netns_bpf_attach_type type)
+{
+	struct list_head *pos;
+	int i = 0;
+
+	list_for_each(pos, &net->bpf.links[type])
+		i++;
+	return i;
+}
+
+static void fill_prog_array(struct net *net, enum netns_bpf_attach_type type,
+			    struct bpf_prog_array *prog_array)
+{
+	struct bpf_netns_link *pos;
+	unsigned int i = 0;
+
+	list_for_each_entry(pos, &net->bpf.links[type], node) {
+		prog_array->items[i].prog = pos->link.prog;
+		i++;
+	}
+}
+
 static void bpf_netns_link_release(struct bpf_link *link)
 {
 	struct bpf_netns_link *net_link =
 		container_of(link, struct bpf_netns_link, link);
 	enum netns_bpf_attach_type type = net_link->netns_type;
+	struct bpf_prog_array *old_array, *new_array;
 	struct net *net;
+	int cnt, idx;
 
 	mutex_lock(&netns_bpf_mutex);
 
@@ -53,9 +91,27 @@ static void bpf_netns_link_release(struct bpf_link *link)
 	if (!net)
 		goto out_unlock;
 
-	netns_bpf_run_array_detach(net, type);
+	/* Remember link position in case of safe delete */
+	idx = link_index(net, type, net_link);
 	list_del(&net_link->node);
 
+	cnt = link_count(net, type);
+	if (!cnt) {
+		netns_bpf_run_array_detach(net, type);
+		goto out_unlock;
+	}
+
+	old_array = rcu_dereference_protected(net->bpf.run_array[type],
+					      lockdep_is_held(&netns_bpf_mutex));
+	new_array = bpf_prog_array_alloc(cnt, GFP_KERNEL);
+	if (!new_array) {
+		WARN_ON(bpf_prog_array_delete_safe_at(old_array, idx));
+		goto out_unlock;
+	}
+	fill_prog_array(net, type, new_array);
+	rcu_assign_pointer(net->bpf.run_array[type], new_array);
+	bpf_prog_array_free(old_array);
+
 out_unlock:
 	mutex_unlock(&netns_bpf_mutex);
 }
@@ -77,7 +133,7 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
 	enum netns_bpf_attach_type type = net_link->netns_type;
 	struct bpf_prog_array *run_array;
 	struct net *net;
-	int ret = 0;
+	int idx, ret;
 
 	if (old_prog && old_prog != link->prog)
 		return -EPERM;
@@ -95,7 +151,10 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
 
 	run_array = rcu_dereference_protected(net->bpf.run_array[type],
 					      lockdep_is_held(&netns_bpf_mutex));
-	WRITE_ONCE(run_array->items[0].prog, new_prog);
+	idx = link_index(net, type, net_link);
+	ret = bpf_prog_array_update_at(run_array, idx, new_prog);
+	if (ret)
+		goto out_unlock;
 
 	old_prog = xchg(&link->prog, new_prog);
 	bpf_prog_put(old_prog);
@@ -309,18 +368,28 @@ int netns_bpf_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
 	return ret;
 }
 
+static int netns_bpf_max_progs(enum netns_bpf_attach_type type)
+{
+	switch (type) {
+	case NETNS_BPF_FLOW_DISSECTOR:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static int netns_bpf_link_attach(struct net *net, struct bpf_link *link,
 				 enum netns_bpf_attach_type type)
 {
 	struct bpf_netns_link *net_link =
 		container_of(link, struct bpf_netns_link, link);
 	struct bpf_prog_array *run_array;
-	int err;
+	int cnt, err;
 
 	mutex_lock(&netns_bpf_mutex);
 
-	/* Allow attaching only one prog or link for now */
-	if (!list_empty(&net->bpf.links[type])) {
+	cnt = link_count(net, type);
+	if (cnt >= netns_bpf_max_progs(type)) {
 		err = -E2BIG;
 		goto out_unlock;
 	}
@@ -341,16 +410,19 @@ static int netns_bpf_link_attach(struct net *net, struct bpf_link *link,
 	if (err)
 		goto out_unlock;
 
-	run_array = bpf_prog_array_alloc(1, GFP_KERNEL);
+	run_array = bpf_prog_array_alloc(cnt + 1, GFP_KERNEL);
 	if (!run_array) {
 		err = -ENOMEM;
 		goto out_unlock;
 	}
-	run_array->items[0].prog = link->prog;
-	rcu_assign_pointer(net->bpf.run_array[type], run_array);
 
 	list_add_tail(&net_link->node, &net->bpf.links[type]);
 
+	fill_prog_array(net, type, run_array);
+	run_array = rcu_replace_pointer(net->bpf.run_array[type], run_array,
+					lockdep_is_held(&netns_bpf_mutex));
+	bpf_prog_array_free(run_array);
+
 out_unlock:
 	mutex_unlock(&netns_bpf_mutex);
 	return err;
-- 
2.25.4

