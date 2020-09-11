Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF04265D3F
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 12:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgIKKAn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 06:00:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47748 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgIKJ7Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Sep 2020 05:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599818362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rEQuoKvsQuQ7UN/WAG0AyU9Tep54WX3TlbS6iNeoLI=;
        b=RakAxVT1s0TeUTJ9L7IO7Xae66evqcfNyQr1DlzbM5W6agaUIoDmvp4eWG7xT+CrIFNi8y
        DiBPVl/qhs9AQJMHV64bJK9G5booKqXIHKrBH48G37xK0GBNIiIjEd91IsZwXbdWCGidvO
        K6WTLsQgCbvN/cuP1V3VLknymceIfMo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-npkFe--oMgWVZp4PTMSD2w-1; Fri, 11 Sep 2020 05:59:21 -0400
X-MC-Unique: npkFe--oMgWVZp4PTMSD2w-1
Received: by mail-wr1-f72.google.com with SMTP id b7so3330014wrn.6
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 02:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7rEQuoKvsQuQ7UN/WAG0AyU9Tep54WX3TlbS6iNeoLI=;
        b=Ws36jWnlKKxuD7v2LUsaX/4KS75R6tU3gdSArrlTmn3w+xpe3ANJwiLvI29+Xv8Y7B
         G4gxHVwnF8yvot00yeYAjVq2ORFdb5Ys4eVGZiFWVuobEfCOVfSYLlalN0c3n7WoM/tb
         Zm2oQVdAs815FOFaCIybROqAKkJfIXFyBkGPsrtgQjke8rxm5IU/O7rhNZ2eabcmlAIO
         sWvkqFyaWH/Y9cYOPoNEzg2r/hss9r0D3rTL/AqUrq1TAAMSEupRqh6oObfWUIZmTbgZ
         ER1+h8p8Cw0hIYxdV4fHL7buGmj4sccxXloVLCvJO6PobMD1DX0kIMHJwkQp8W2hS3Xx
         FHGg==
X-Gm-Message-State: AOAM533b3kcr8jqcLURdg/jWUvkwdsviAMoVBAzX1MaHfGRqkjPzPnsU
        61FjEhe+V5MV+TRLe0JcZhTWbYd6+UP2Y59b7rwLoZLwyta9K8bMllejuVJ4MlIB+Ge66dA5I0d
        5X64QO5SKBuDC
X-Received: by 2002:a5d:40c7:: with SMTP id b7mr1259459wrq.300.1599818360191;
        Fri, 11 Sep 2020 02:59:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDluqwqopDSoDNksslCjCGS8sCBn3oOtrNP5+Emp8DZlmBdbi1xvVBlY8OH/UKRiDAa74kaw==
X-Received: by 2002:a5d:40c7:: with SMTP id b7mr1259443wrq.300.1599818359887;
        Fri, 11 Sep 2020 02:59:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y5sm3503144wrh.6.2020.09.11.02.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:59:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 29CD11829D4; Fri, 11 Sep 2020 11:59:19 +0200 (CEST)
Subject: [PATCH RESEND bpf-next v3 4/9] bpf: support attaching freplace
 programs to multiple attach points
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 11 Sep 2020 11:59:19 +0200
Message-ID: <159981835908.134722.4550898174324943652.stgit@toke.dk>
In-Reply-To: <159981835466.134722.8652987144251743467.stgit@toke.dk>
References: <159981835466.134722.8652987144251743467.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This enables support for attaching freplace programs to multiple attach
points. It does this by amending UAPI for bpf_raw_tracepoint_open with a
target prog fd and btf ID pair that can be used to supply the new
attachment point. The target must be compatible with the target that was
supplied at program load time.

The implementation reuses the checks that were factored out of
check_attach_btf_id() to ensure compatibility between the BTF types of the
old and new attachment. If these match, a new bpf_tracing_link will be
created for the new attach target, allowing multiple attachments to
co-exist simultaneously.

The code could theoretically support multiple-attach of other types of
tracing programs as well, but since I don't have a use case for any of
those, the bpf_tracing_prog_attach() function will reject new targets for
anything other than PROG_TYPE_EXT programs.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf.h      |    3 +
 include/uapi/linux/bpf.h |    6 ++-
 kernel/bpf/syscall.c     |   96 +++++++++++++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c    |    9 ++++
 4 files changed, 97 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 722c60f1c1fc..c6b856b2d296 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -753,6 +753,9 @@ struct bpf_prog_aux {
 	struct hlist_node tramp_hlist;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
+	/* target BPF prog types for trace programs */
+	enum bpf_prog_type tgt_prog_type;
+	enum bpf_attach_type tgt_attach_type;
 	/* function name for valid attach_btf_id */
 	const char *attach_func_name;
 	struct bpf_prog **func;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 90359cab501d..0885ab6ac8d9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -595,8 +595,10 @@ union bpf_attr {
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
-		__u64 name;
-		__u32 prog_fd;
+		__u64		name;
+		__u32		prog_fd;
+		__u32		tgt_prog_fd;
+		__u32		tgt_btf_id;
 	} raw_tracepoint;
 
 	struct { /* anonymous struct for BPF_BTF_LOAD */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2d238aa8962e..7b1da5f063eb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
+#include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
@@ -2582,10 +2583,16 @@ static struct bpf_tracing_link *bpf_tracing_link_create(struct bpf_prog *prog,
 	return link;
 }
 
-static int bpf_tracing_prog_attach(struct bpf_prog *prog)
+static int bpf_tracing_prog_attach(struct bpf_prog *prog,
+				   int tgt_prog_fd,
+				   u32 btf_id)
 {
-	struct bpf_tracing_link *link, *olink;
 	struct bpf_link_primer link_primer;
+	struct bpf_prog *tgt_prog = NULL;
+	struct bpf_tracing_link *link;
+	struct btf_func_model fmodel;
+	long addr;
+	u64 key;
 	int err;
 
 	switch (prog->type) {
@@ -2613,28 +2620,80 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 		err = -EINVAL;
 		goto out_put_prog;
 	}
+	if (tgt_prog_fd) {
+		/* For now we only allow new targets for BPF_PROG_TYPE_EXT */
+		if (prog->type != BPF_PROG_TYPE_EXT ||
+		    !btf_id) {
+			err = -EINVAL;
+			goto out_put_prog;
+		}
 
-	link = READ_ONCE(prog->aux->tgt_link);
-	if (!link) {
-		err = -ENOENT;
+		tgt_prog = bpf_prog_get(tgt_prog_fd);
+		if (IS_ERR(tgt_prog)) {
+			err = PTR_ERR(tgt_prog);
+			tgt_prog = NULL;
+			goto out_put_prog;
+		}
+
+		key = ((u64)tgt_prog->aux->id) << 32 | btf_id;
+	} else if (btf_id) {
+		err = -EINVAL;
 		goto out_put_prog;
 	}
-	olink = cmpxchg(&prog->aux->tgt_link, link, NULL);
-	if (olink != link) {
-		err = -ENOENT;
-		goto out_put_prog;
+
+	link = READ_ONCE(prog->aux->tgt_link);
+	if (link) {
+		if (tgt_prog && link->trampoline->key != key) {
+			link = NULL;
+		} else {
+			struct bpf_tracing_link *olink;
+
+			olink = cmpxchg(&prog->aux->tgt_link, link, NULL);
+			if (olink != link) {
+				link = NULL;
+			} else if (tgt_prog) {
+				/* re-using link that already has ref on
+				 * tgt_prog, don't take another
+				 */
+				bpf_prog_put(tgt_prog);
+				tgt_prog = NULL;
+			}
+		}
+	}
+
+	if (!link) {
+		if (!tgt_prog) {
+			err = -ENOENT;
+			goto out_put_prog;
+		}
+
+		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
+					      &fmodel, &addr, NULL, NULL);
+		if (err)
+			goto out_put_prog;
+
+		link = bpf_tracing_link_create(prog, tgt_prog);
+		if (IS_ERR(link)) {
+			err = PTR_ERR(link);
+			goto out_put_prog;
+		}
+		tgt_prog = NULL;
+
+		err = bpf_trampoline_get(key, (void *)addr, &fmodel, &link->trampoline);
+		if (err)
+			goto out_put_link;
 	}
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err) {
 		kfree(link);
-		goto out_put_prog;
+		goto out_put_link;
 	}
 
 	err = bpf_trampoline_link_prog(prog, link->trampoline);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
-		goto out_put_prog;
+		goto out_put_link;
 	}
 
 	/* at this point the link is no longer referenced from struct bpf_prog,
@@ -2643,8 +2702,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 	link->link.prog = prog;
 
 	return bpf_link_settle(&link_primer);
+out_put_link:
+	bpf_link_put(&link->link);
 out_put_prog:
 	bpf_prog_put(prog);
+	if (tgt_prog)
+		bpf_prog_put(tgt_prog);
 	return err;
 }
 
@@ -2722,7 +2785,7 @@ static const struct bpf_link_ops bpf_raw_tp_link_lops = {
 	.fill_link_info = bpf_raw_tp_link_fill_link_info,
 };
 
-#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
+#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.tgt_btf_id
 
 static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 {
@@ -2746,8 +2809,9 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_EXT:
 	case BPF_PROG_TYPE_LSM:
 		if (attr->raw_tracepoint.name) {
-			/* The attach point for this category of programs
-			 * should be specified via btf_id during program load.
+			/* The attach point for this category of programs should
+			 * be specified via btf_id during program load, or using
+			 * tgt_btf_id.
 			 */
 			err = -EINVAL;
 			goto out_put_prog;
@@ -2757,7 +2821,9 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 			tp_name = prog->aux->attach_func_name;
 			break;
 		}
-		return bpf_tracing_prog_attach(prog);
+		return bpf_tracing_prog_attach(prog,
+					       attr->raw_tracepoint.tgt_prog_fd,
+					       attr->raw_tracepoint.tgt_btf_id);
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d6714c24c4e7..df01e71b118d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11205,6 +11205,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (!btf_type_is_func_proto(t))
 			return -EINVAL;
 
+		if ((prog->aux->tgt_prog_type &&
+		     prog->aux->tgt_prog_type != tgt_prog->type) ||
+		    (prog->aux->tgt_attach_type &&
+		     prog->aux->tgt_attach_type != tgt_prog->expected_attach_type))
+			return -EINVAL;
+
 		if (tgt_prog && conservative)
 			t = NULL;
 
@@ -11300,6 +11306,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return ret;
 
 	if (tgt_prog) {
+		prog->aux->tgt_prog_type = tgt_prog->type;
+		prog->aux->tgt_attach_type = tgt_prog->expected_attach_type;
+
 		if (prog->type == BPF_PROG_TYPE_EXT) {
 			env->ops = bpf_verifier_ops[tgt_prog->type];
 			prog->expected_attach_type =

