Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391CC21C690
	for <lists+bpf@lfdr.de>; Sat, 11 Jul 2020 23:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgGKVxu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 11 Jul 2020 17:53:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23225 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728178AbgGKVxt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Jul 2020 17:53:49 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-UMkMTqfOMFu274MuJD3IgA-1; Sat, 11 Jul 2020 17:53:42 -0400
X-MC-Unique: UMkMTqfOMFu274MuJD3IgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5EBC106B242;
        Sat, 11 Jul 2020 21:53:41 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E82B60BEC;
        Sat, 11 Jul 2020 21:53:40 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v7 bpf-next 5/9] bpf: Remove btf_id helpers resolving
Date:   Sat, 11 Jul 2020 23:53:25 +0200
Message-Id: <20200711215329.41165-6-jolsa@kernel.org>
In-Reply-To: <20200711215329.41165-1-jolsa@kernel.org>
References: <20200711215329.41165-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now when we moved the helpers btf_id arrays into .BTF_ids section,
we can remove the code that resolve those IDs in runtime.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Tested-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c | 89 +++---------------------------------------------
 1 file changed, 5 insertions(+), 84 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4c3007f428b1..71140b73ae3c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4079,96 +4079,17 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	return -EINVAL;
 }
 
-static int __btf_resolve_helper_id(struct bpf_verifier_log *log, void *fn,
-				   int arg)
-{
-	char fnname[KSYM_SYMBOL_LEN + 4] = "btf_";
-	const struct btf_param *args;
-	const struct btf_type *t;
-	const char *tname, *sym;
-	u32 btf_id, i;
-
-	if (IS_ERR(btf_vmlinux)) {
-		bpf_log(log, "btf_vmlinux is malformed\n");
-		return -EINVAL;
-	}
-
-	sym = kallsyms_lookup((long)fn, NULL, NULL, NULL, fnname + 4);
-	if (!sym) {
-		bpf_log(log, "kernel doesn't have kallsyms\n");
-		return -EFAULT;
-	}
-
-	for (i = 1; i <= btf_vmlinux->nr_types; i++) {
-		t = btf_type_by_id(btf_vmlinux, i);
-		if (BTF_INFO_KIND(t->info) != BTF_KIND_TYPEDEF)
-			continue;
-		tname = __btf_name_by_offset(btf_vmlinux, t->name_off);
-		if (!strcmp(tname, fnname))
-			break;
-	}
-	if (i > btf_vmlinux->nr_types) {
-		bpf_log(log, "helper %s type is not found\n", fnname);
-		return -ENOENT;
-	}
-
-	t = btf_type_by_id(btf_vmlinux, t->type);
-	if (!btf_type_is_ptr(t))
-		return -EFAULT;
-	t = btf_type_by_id(btf_vmlinux, t->type);
-	if (!btf_type_is_func_proto(t))
-		return -EFAULT;
-
-	args = (const struct btf_param *)(t + 1);
-	if (arg >= btf_type_vlen(t)) {
-		bpf_log(log, "bpf helper %s doesn't have %d-th argument\n",
-			fnname, arg);
-		return -EINVAL;
-	}
-
-	t = btf_type_by_id(btf_vmlinux, args[arg].type);
-	if (!btf_type_is_ptr(t) || !t->type) {
-		/* anything but the pointer to struct is a helper config bug */
-		bpf_log(log, "ARG_PTR_TO_BTF is misconfigured\n");
-		return -EFAULT;
-	}
-	btf_id = t->type;
-	t = btf_type_by_id(btf_vmlinux, t->type);
-	/* skip modifiers */
-	while (btf_type_is_modifier(t)) {
-		btf_id = t->type;
-		t = btf_type_by_id(btf_vmlinux, t->type);
-	}
-	if (!btf_type_is_struct(t)) {
-		bpf_log(log, "ARG_PTR_TO_BTF is not a struct\n");
-		return -EFAULT;
-	}
-	bpf_log(log, "helper %s arg%d has btf_id %d struct %s\n", fnname + 4,
-		arg, btf_id, __btf_name_by_offset(btf_vmlinux, t->name_off));
-	return btf_id;
-}
-
 int btf_resolve_helper_id(struct bpf_verifier_log *log,
 			  const struct bpf_func_proto *fn, int arg)
 {
-	int *btf_id = &fn->btf_id[arg];
-	int ret;
+	int id;
 
 	if (fn->arg_type[arg] != ARG_PTR_TO_BTF_ID)
 		return -EINVAL;
-
-	ret = READ_ONCE(*btf_id);
-	if (ret)
-		return ret;
-	/* ok to race the search. The result is the same */
-	ret = __btf_resolve_helper_id(log, fn->func, arg);
-	if (!ret) {
-		/* Function argument cannot be type 'void' */
-		bpf_log(log, "BTF resolution bug\n");
-		return -EFAULT;
-	}
-	WRITE_ONCE(*btf_id, ret);
-	return ret;
+	id = fn->btf_id[arg];
+	if (!id || id > btf_vmlinux->nr_types)
+		return -EINVAL;
+	return id;
 }
 
 static int __get_type_size(struct btf *btf, u32 btf_id,
-- 
2.25.4

