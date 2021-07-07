Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636763BF192
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 23:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhGGVvU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 17:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232996AbhGGVvS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 17:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625694516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyCTtNsvJM23bTJlhCXcXFu90hTwq9G3m+Uc2FcCDhw=;
        b=Se9zk1X8A3xV3LpnfZm66kVx8CDKosItrTUc5YEKUDGr8igVt18wHgL0zljSHbBQxSq1a/
        dCSn7LeVJiEya86nYLzWUSU2CqWTSQUtYVkesjEggeKMtEKE9ofbrgtLF6v5697Qq2GYpN
        J2mQwptqLNCqa/4KGlheUD79kdq3cKw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-XyNtHVkoNR-ZhVOQu4YK_g-1; Wed, 07 Jul 2021 17:48:35 -0400
X-MC-Unique: XyNtHVkoNR-ZhVOQu4YK_g-1
Received: by mail-wm1-f70.google.com with SMTP id t12-20020a7bc3cc0000b02901f290c9c44eso1533875wmj.7
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 14:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XyCTtNsvJM23bTJlhCXcXFu90hTwq9G3m+Uc2FcCDhw=;
        b=p+kDaiFNVe8PWhWwkgXV21pdN74nu3LAmQz0tgEX8QMyyFEzJDy4Asn5bc4wLPO2X7
         aoSZrcAtGARBWLU7bFD8WptJ9jGs7EaIhqNEiu1+PkN76IcTEwZcl2kUwn4628q7sYw0
         gIdIrN72AJcBBMr1wj6dmr2lU/a+Vh5Vw1LCcL9idDa8qypD++6YyWGs+9F+wVVTCeze
         kXLQVynUxOFV3Q216AviTezKEeGp0kprBfOlQQKFNL52MgcNQV+nWAPDBTiHKlxoFoRd
         fUXahJlS5r0seOlQvSF38hzoUdlJo/9pGBLePdlYUK34hYSfogL093i+tbsRqfQw9VOp
         Sadg==
X-Gm-Message-State: AOAM530WCe0WyTOitzwIVA7SxsSwBPlduN9w/g+pN+Y4C+S5n2zNfE7Z
        +M6t/ZNhTE59WwxY5/ajQ2kCNRvLtMLGBEXSsWLQKT9dSc/FG9lEJz4kGj01tQ8rX7zp6Qm6uFL
        wRe6zGUFH7VNK
X-Received: by 2002:adf:a2db:: with SMTP id t27mr29810081wra.272.1625694514725;
        Wed, 07 Jul 2021 14:48:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1NKGIS5pSSuMCbb3wlNDchZjdi7A4xHRDEuiUKRnEl86QJ3yOKStzcLekLUeKf1S8O2RVww==
X-Received: by 2002:adf:a2db:: with SMTP id t27mr29810063wra.272.1625694514514;
        Wed, 07 Jul 2021 14:48:34 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id p9sm150545wrx.59.2021.07.07.14.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:48:34 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv3 bpf-next 4/7] bpf: Add bpf_get_func_ip helper for kprobe programs
Date:   Wed,  7 Jul 2021 23:47:48 +0200
Message-Id: <20210707214751.159713-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707214751.159713-1-jolsa@kernel.org>
References: <20210707214751.159713-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_get_func_ip helper for BPF_PROG_TYPE_KPROBE programs,
so it's now possible to call bpf_get_func_ip from both kprobe and
kretprobe programs.

Taking the caller's address from 'struct kprobe::addr', which is
defined for both kprobe and kretprobe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  2 +-
 kernel/bpf/verifier.c          |  2 ++
 kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
 tools/include/uapi/linux/bpf.h |  2 +-
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 83e87ffdbb6e..4894f99a1993 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4783,7 +4783,7 @@ union bpf_attr {
  *
  * u64 bpf_get_func_ip(void *ctx)
  * 	Description
- * 		Get address of the traced function (for tracing programs).
+ * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
  */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f975a3aa9368..79eb9d81a198 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5979,6 +5979,8 @@ static int has_get_func_ip(struct bpf_verifier_env *env)
 			return -ENOTSUPP;
 		}
 		return 0;
+	} else if (type == BPF_PROG_TYPE_KPROBE) {
+		return 0;
 	}
 
 	verbose(env, "func %s#%d not supported for program type %d\n",
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9edd3b1a00ad..55acf56b0c3a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -17,6 +17,7 @@
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_lsm.h>
+#include <linux/kprobes.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -961,6 +962,20 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
+{
+	struct kprobe *kp = kprobe_running();
+
+	return kp ? (u64) kp->addr : 0;
+}
+
+static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
+	.func		= bpf_get_func_ip_kprobe,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1092,6 +1107,8 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_override_return:
 		return &bpf_override_return_proto;
 #endif
+	case BPF_FUNC_get_func_ip:
+		return &bpf_get_func_ip_proto_kprobe;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 83e87ffdbb6e..4894f99a1993 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4783,7 +4783,7 @@ union bpf_attr {
  *
  * u64 bpf_get_func_ip(void *ctx)
  * 	Description
- * 		Get address of the traced function (for tracing programs).
+ * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
  */
-- 
2.31.1

