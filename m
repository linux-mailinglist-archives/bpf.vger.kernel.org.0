Return-Path: <bpf+bounces-65369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C535AB213A3
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEABF3E4A1B
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA72D4809;
	Mon, 11 Aug 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7k7csE4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA646F53E
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934651; cv=none; b=HrQfbBLVbz+VTY6LFzRunoq8R6Ya8b6/F+/z7Ub57fQe4XCP685xs8ov6Nq7dNyvM9gaNs3BXxiNQIaU/bbuyiCNJzPRNuVcsN6eG+Imns91VQ032KhQH0M6rtJU9W3t4eYvVP6rHBjDmIcVi/0sgsXSBY33NG6Wn3Ji4jKA1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934651; c=relaxed/simple;
	bh=k5i0PD8m/alE7Z/bVu8JK78j+lyI8iUXgaIi5W6UMJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+WsKHeBCaAJajILHB0I62quW9VWnB+peAuEsjP2VWwS8I6QLvq96wBG9830mbVbrmcNt+Di+Js4Nt2ny+qcfeYjigLTdJLnwUjeUdarYJ1EKsceOuA5yZvH+XHoHCjOwQqk/QXd9Ephrk+fKg8S2tYqnf39MuaXJZZDK7A9Le8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7k7csE4; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6156463fae9so8915959a12.0
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754934648; x=1755539448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5wFRItrzlSYBKhOegJAxFW+kaFSEXUMVmGBhLZwu/s=;
        b=V7k7csE4KocU4bceB+rpU/oP/nfX7wT9YNAmautKkJ0ioV3QxlLnF/Hm9nnvjx6gTC
         I9nTVjYBHLscBGh8QcjW6T4sj+dg5cX/XIF7RdG1Q4AVuzHZ9xwpCEi5t1vcFCA9jQD1
         Afh2Uf0TZvAHwydQliseXWJc8qDU8BMBguXgihq6d2NsjHWXyLfXCc70z22Jf57C2R/K
         d8D+e3/FQSMDN8OSYjK7HtZIcgpyi0qBq6JAAaM3TGXkbUnH/UzFzIcO7FS3+qxEOiGs
         YAnCp2wvpre/rrV2uMk89W1a6BYjfc7vGahPDKqIOo9fUgszoMcAMKWfjKFdiEl/E/F3
         ygPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934648; x=1755539448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5wFRItrzlSYBKhOegJAxFW+kaFSEXUMVmGBhLZwu/s=;
        b=GhJ7dGtxSxC1+VetNwkRn0uBz1B+Sn/tbsEunv5dIdks0Y2T0CtDfKyH6kbvrt55DE
         oip/+XjX9OVs10DFPCL1MbvmxiOBIoLo6G6ODgjywDUNmz3bBHQ0GUFlXrwuZNT87Vy7
         VT6kSwYsAbBCAVBoDjY8D0530e3C8scYbl4XZKfBv28q+XdtzExKvRVzixWs/lfnoAtY
         UEyn4jelE9mfqQTaCgrzNZkkqI2iwwuJBMLOgpI92jwzq4YIzKHfeF+m9ZcHjyhW2u1v
         d7kLT4gm1gJXUf2fqFkrWyRJ84Gu1VoiTQF/Q/7UaG21zg3vXokAl4EDPqTm0ks0KHG5
         ICBQ==
X-Gm-Message-State: AOJu0YycvohkX3P+ffJTVIzDhovdyFSR7azfv1e2HqpqbjVh/okJ1eqT
	sF2hhTy53FhBvuHaDAxaYms5HIehjfLVFB57sfmdVFbOTIZaWLDKPP8pCVdNZeGXivA=
X-Gm-Gg: ASbGnctF9+kvongQCaBBFm8e5PXxkcsrrmpHlDBBw/MHVFc+YvOjYCGUzVE0TDz0Z/3
	Y3ObrAmfsumrD9uB9xI/4c2D26NIteOiLvgeIFvlacPf0rDuN/kFPhWOFZ8gjZHxdU6rnD/Wldm
	/V9dcApOR2JFZUy641KsyQYNBJ6a8R4pnxgx5WqusQBaypak2azgHCwnmLqqQ3WsxPs/TeO9+BA
	YKuWVL2mfkmalcj1+XFGMBX9cn6lbc6nhTNvd+Ldc9unU7xJ1Qy0tm+aX40Pkolz3xIdQV0Kmrt
	/FxSMTLoGMwCvHcMLyBHP6ELgZv74PLrY6TMhYHRLnUWkSAuDyh26Tk1gKIv6wMfRJBbzFWO4nE
	OXszQgSLhC/4=
X-Google-Smtp-Source: AGHT+IFqz4RKx3c0B3ac2DTYu2iTuK4xjofMFw9agAFBhicNUnEgg053Xr5ShvTfb5qCum5ZSGRVxg==
X-Received: by 2002:a17:906:468e:b0:af9:7025:7d5a with SMTP id a640c23a62f3a-afa1d6d6df2mr37912266b.18.1754934647667;
        Mon, 11 Aug 2025 10:50:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ef2sm2057782966b.96.2025.08.11.10.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:50:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	tj@kernel.org
Cc: Dan Schatzberg <dschatzberg@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Do not limit bpf_cgroup_from_id to current's namespace
Date: Mon, 11 Aug 2025 10:50:44 -0700
Message-ID: <20250811175045.1055202-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811175045.1055202-1-memxor@gmail.com>
References: <20250811175045.1055202-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3604; h=from:subject; bh=k5i0PD8m/alE7Z/bVu8JK78j+lyI8iUXgaIi5W6UMJs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBomizL3DH6OkfjekZnFvyNsHv/6u0fjC3Q5P5E9uqu xJuR716JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaJosywAKCRBM4MiGSL8RygHjEA C4Rhamk09hOhHi6wIt/N+DnlQjOyOW5YHjbQAPj7jqkST80z/mX5J1rCwUmUZ3hhATUrn+Ol5DZcgk FTw46xXjJybrGFaXx+4YXyE+QS+b+OOPu91pzNn+3O5/UHwC7dVHoJzuYNU3jk/pdVUDtQH28P85ub cwsR4/+8WIUuF/oONzEs3YkIX38GVizq5o+3Ta7jM2JxBr7qUcQjXaKFuU7VMHd8CcrM4gOrKP7Jwn gMwVXuffB4eY5TtU6YA1d4YkFVf0J9rSpsycikkEgitrhNyM+GvelWxWtpHiC3RtRVd3DyrKz4r0dN ycySkahUT13eeaZHVZTK9m91na0SDI/zVPDPPjKKe8mje4L6qr7Nw7ueSsBjt3vyFNBtLVM1WBCCg/ w3INMf4ak1fbxixaGZ3kAiATSeGGTd2wuTJPC4MX7K/+nYUFdGpgw0ui22dTmal4gZqu0d+ed06Nry I7Q0ijem6HEbWe7eSGAVIhXsLSH4n2n0dGTDZ2q0EORMhEHPsY5OYKdz1A3WsXyxJloh9qnmrUHu/F RCNiMZ6iAChx0g+YEothaoDy/dYjndyAFsSBCGce9QQ63LKIumqoA/REuyDE6IpCfdZFk4+HYNR9A3 DTQk2ktUw+9h+RDWOxQBfiYxdIwif3QwU+cdjaHlBZQitBsknlixVYki5jWQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
cgroup corresponding to a given cgroup ID. This helper can be called in
a lot of contexts where the current thread can be random. A recent
example was its use in sched_ext's ops.tick(), to obtain the root cgroup
pointer. Since the current task can be whatever random user space task
preempted by the timer tick, this makes the behavior of the helper
unreliable.

Resolve this by refactoring cgroup_get_from_id to take a parameter to
elide the cgroup_is_descendant check when root_cgns parameter is set to
true.

There is no compatibility breakage here, since changing the namespace
against which the lookup is being done to the root cgroup namespace only
permits a wider set of lookups to succeed now. The cgroup IDs across
namespaces are globally unique, and thus don't need to be retranslated.

Reported-by: Dan Schatzberg <dschatzberg@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/cgroup.h   | 2 +-
 kernel/bpf/cgroup_iter.c | 2 +-
 kernel/bpf/helpers.c     | 2 +-
 kernel/cgroup/cgroup.c   | 7 ++++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..da757a496fbe 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -650,7 +650,7 @@ static inline void cgroup_kthread_ready(void)
 }
 
 void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
-struct cgroup *cgroup_get_from_id(u64 id);
+struct cgroup *cgroup_get_from_id(u64 id, bool root_cgns);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index f04a468cf6a7..49234d035583 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -212,7 +212,7 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
 	if (fd)
 		cgrp = cgroup_v1v2_get_from_fd(fd);
 	else if (id)
-		cgrp = cgroup_get_from_id(id);
+		cgrp = cgroup_get_from_id(id, false);
 	else /* walk the entire hierarchy by default. */
 		cgrp = cgroup_get_from_path("/");
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a68..12466103917f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2537,7 +2537,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 {
 	struct cgroup *cgrp;
 
-	cgrp = cgroup_get_from_id(cgid);
+	cgrp = cgroup_get_from_id(cgid, true);
 	if (IS_ERR(cgrp))
 		return NULL;
 	return cgrp;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..b490e1e0d2c4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6345,10 +6345,11 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 /*
  * cgroup_get_from_id : get the cgroup associated with cgroup id
  * @id: cgroup id
+ * @root_cgns: Select root cgroup namespace instead of current's.
  * On success return the cgrp or ERR_PTR on failure
  * Only cgroups within current task's cgroup NS are valid.
  */
-struct cgroup *cgroup_get_from_id(u64 id)
+struct cgroup *cgroup_get_from_id(u64 id, bool root_cgns)
 {
 	struct kernfs_node *kn;
 	struct cgroup *cgrp, *root_cgrp;
@@ -6374,6 +6375,10 @@ struct cgroup *cgroup_get_from_id(u64 id)
 	if (!cgrp)
 		return ERR_PTR(-ENOENT);
 
+	/* We don't need to namespace this operation against current. */
+	if (root_cgns)
+		return cgrp;
+
 	root_cgrp = current_cgns_cgroup_dfl();
 	if (!cgroup_is_descendant(cgrp, root_cgrp)) {
 		cgroup_put(cgrp);
-- 
2.47.3


