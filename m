Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E083050A1A8
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388937AbiDUOK6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 10:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388939AbiDUOK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 10:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBFA326AEC
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rS2oog3eO5CDVH6MLeAPYqGuTIVoniasbiUdyIVQinI=;
        b=ZuHTZhSKLtFNYiYRFDE5K+PP6O+Mf0Jtx2aMSGkOGuYAVVlCtKM/WvDoWnY1/5Nk3qRkne
        /20CQg7IAxjh1q1arDySva19OXfnUGxNvWaHxRL2/gyNfKRy0LRBJf5jgh6Gr0vkVgK34k
        Y3GcJDdpg/b0kDi+LUzi8uLUixC5Yv8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-MWsIkoWSN2CW2BDWJmDDwg-1; Thu, 21 Apr 2022 10:07:55 -0400
X-MC-Unique: MWsIkoWSN2CW2BDWJmDDwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04CAC38107A6;
        Thu, 21 Apr 2022 14:07:55 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5D5E40EC002;
        Thu, 21 Apr 2022 14:07:52 +0000 (UTC)
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
Subject: [RFC bpf-next v4 4/7] btf: Add a new kfunc set which allows to mark a function to be sleepable
Date:   Thu, 21 Apr 2022 16:07:37 +0200
Message-Id: <20220421140740.459558-5-benjamin.tissoires@redhat.com>
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

This allows to declare a kfunc as sleepable and prevents its use in
a non sleepable program.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v4
---
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 76a3ff48ae2a..b8b83dcf86bf 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -17,6 +17,7 @@ enum btf_kfunc_type {
 	BTF_KFUNC_TYPE_ACQUIRE,
 	BTF_KFUNC_TYPE_RELEASE,
 	BTF_KFUNC_TYPE_RET_NULL,
+	BTF_KFUNC_TYPE_SLEEPABLE,
 	BTF_KFUNC_TYPE_MAX,
 };
 
@@ -35,6 +36,7 @@ struct btf_kfunc_id_set {
 			struct btf_id_set *acquire_set;
 			struct btf_id_set *release_set;
 			struct btf_id_set *ret_null_set;
+			struct btf_id_set *sleepable_set;
 		};
 		struct btf_id_set *sets[BTF_KFUNC_TYPE_MAX];
 	};
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 22e6e3cdc7ee..bf6a82461c58 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5889,7 +5889,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
 	int ref_regno = 0, ret;
-	bool rel = false;
+	bool rel = false, sleepable = false;
 
 	t = btf_type_by_id(btf, func_id);
 	if (!t || !btf_type_is_func(t)) {
@@ -5915,10 +5915,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	/* Only kfunc can be release func */
-	if (is_kfunc)
+	/* Only kfunc can be release or sleepable func */
+	if (is_kfunc) {
 		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
 						BTF_KFUNC_TYPE_RELEASE, func_id);
+		sleepable = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
+						      BTF_KFUNC_TYPE_SLEEPABLE, func_id);
+	}
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -6092,6 +6095,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			func_name);
 		return -EINVAL;
 	}
+
+	if (sleepable && !env->prog->aux->sleepable) {
+		bpf_log(log, "kernel function %s is sleepable but the program is not\n",
+			func_name);
+		return -EINVAL;
+	}
+
 	/* returns argument register number > 0 in case of reference release kfunc */
 	return rel ? ref_regno : 0;
 }
-- 
2.35.1

