Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF92250A1B0
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388971AbiDUOK6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 10:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388937AbiDUOK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 10:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0DAA22B2B
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=howYSQGYDpGf0MCMMnBxueOpghmy2sP/424mO8pl1yc=;
        b=fbV4Yv2ftN8Ntd+Yxe+cYcd6ohFceA9il0RxArmoG+b1guIUCP0idGTkgYK7Gc63X7gt9R
        axVbf4csbePbeviL3/9PB1SCfbooeDv87PW8Wc0jvWrJTG7amTF/m90u/IQpNWfmBIuEif
        NnVaja7oqgpOfvaiWitoh2KLuSH5deg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-orAbwtltMvCYuCFo9f0gcw-1; Thu, 21 Apr 2022 10:07:53 -0400
X-MC-Unique: orAbwtltMvCYuCFo9f0gcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABDFE1E1AE69;
        Thu, 21 Apr 2022 14:07:52 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AEB840EC002;
        Thu, 21 Apr 2022 14:07:50 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC bpf-next v4 3/7] error-inject: add new type that carries if the function is non sleepable
Date:   Thu, 21 Apr 2022 16:07:36 +0200
Message-Id: <20220421140740.459558-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using error-injection function through bpf to change the return
code, we need to know if the function is sleepable or not.

Currently the code assumes that all error-inject functions are sleepable,
except for a few selected of them, hardcoded in kernel/bpf/verifier.c

Add a new flag to error-inject so we can code that information where the
function is declared.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v4:
- another approach would be to define a new kfunc_set, and register
  it with btf. But in that case, what program type would we use?
  BPF_PROG_TYPE_UNSPEC?
- also note that maybe we should consider all of the functions
  non-sleepable and only mark some as sleepable. IMO it makes more
  sense to be more restrictive by default.
---
 include/asm-generic/error-injection.h |  1 +
 kernel/bpf/verifier.c                 | 10 ++++++++--
 lib/error-inject.c                    |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index fbca56bd9cbc..5974942353a6 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -9,6 +9,7 @@ enum {
 	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
 	EI_ETYPE_ERRNO_NULL,	/* Return -ERRNO or NULL if failure */
 	EI_ETYPE_TRUE,		/* Return true if failure */
+	EI_ETYPE_NS_ERRNO,	/* Return -ERRNO if failure and tag the function as non-sleepable */
 };
 
 struct error_injection_entry {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f339f9058f3..45c8feea6478 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14085,6 +14085,11 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+static int is_non_sleepable_error_inject(unsigned long addr)
+{
+	return get_injectable_error_type(addr) == EI_ETYPE_NS_ERRNO;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -14281,8 +14286,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				/* fentry/fexit/fmod_ret progs can be sleepable only if they are
 				 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
 				 */
-				if (!check_non_sleepable_error_inject(btf_id) &&
-				    within_error_injection_list(addr))
+				if (within_error_injection_list(addr) &&
+				    !check_non_sleepable_error_inject(btf_id) &&
+				    !is_non_sleepable_error_inject(addr))
 					ret = 0;
 				break;
 			case BPF_PROG_TYPE_LSM:
diff --git a/lib/error-inject.c b/lib/error-inject.c
index 2ff5ef689d72..560c3b18f439 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -183,6 +183,8 @@ static const char *error_type_string(int etype)
 		return "ERRNO_NULL";
 	case EI_ETYPE_TRUE:
 		return "TRUE";
+	case EI_ETYPE_NS_ERRNO:
+		return "NS_ERRNO";
 	default:
 		return "(unknown)";
 	}
-- 
2.35.1

