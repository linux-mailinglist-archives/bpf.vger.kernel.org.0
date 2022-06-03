Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A8753CC74
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbiFCPmY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 11:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245614AbiFCPmW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 11:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D1C5625C
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654270936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fQ3r8GSbtHTbZrdB4Ec0MRsOtVvi/yoXUAYb6+28s6g=;
        b=Ic3Ps0VGsxTXP7yNxCYT66jQms5kvLcVHmGO4KKSo9FzBrrq3POQ5eHKRVaXqtAozVL9Sr
        /HO8N8n5ow6cF5Pyz6QE5R0Cyl+suE+OSsjgf7iRuu+DCqTWcU9i/CWLMFKlrS+/x5uWsH
        BSxUwYGFoXLfI/AGjvWq2grsPJm3pqA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-kZkNIzZ2Meehj5DU0gBFDw-1; Fri, 03 Jun 2022 11:42:15 -0400
X-MC-Unique: kZkNIzZ2Meehj5DU0gBFDw-1
Received: by mail-ed1-f71.google.com with SMTP id co13-20020a0564020c0d00b0042dc9ef4f01so5705368edb.16
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 08:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQ3r8GSbtHTbZrdB4Ec0MRsOtVvi/yoXUAYb6+28s6g=;
        b=PCeF+J5a6sdmX9NIRoeS7EqcFNGHxr0FM6aMzXz/8sWQIvAPlYSRWEDzFf/XAIFePs
         8MjAPuzrl/Vu+mEp8PsAVSVL/eqJA/Y3PXw0pxI+NgeftaMJwzt18ZSB3wZfacHvBIms
         mmAs6xJ+4f/vVtlQK9ayzcO0U5SVmIQVKTI7+t2htl8ZpfE/7y1XjJX1SzU25IR0CfRP
         FskuP86eqMoR4WJfJ3kndUPffkSovBtII0xNFQ/XzBkTUE2o450wxOPBexZWaWSF+u+s
         BQn2XXutn93JNSbNYrmNeIGm0dBLsSwtLK+mdJNXY4rRYUgppsvTEtqI6cZfrKetUVJ7
         3uHQ==
X-Gm-Message-State: AOAM531sV6j2/mxbeHVUsqD1Lf3Yz9CJqk462bFgpT+chU3vNOQL5ZCG
        Cu6Pvb41l/7x5UAR0Tg8wiOUKKSydi3IvchSgfJsKPK/iciRoHRX6+3ozN7OmEweH3poh2deYUX
        Lpgnfqi8n6RKQ
X-Received: by 2002:a17:907:6d15:b0:6fd:d985:889b with SMTP id sa21-20020a1709076d1500b006fdd985889bmr9339815ejc.753.1654270934032;
        Fri, 03 Jun 2022 08:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytoY88hs8OijZfWo0hBZWbCDVpbnSkElomDqA1GN3kEewUb0KlJSC+duEBuWOzqg+dO19GzA==
X-Received: by 2002:a17:907:6d15:b0:6fd:d985:889b with SMTP id sa21-20020a1709076d1500b006fdd985889bmr9339785ejc.753.1654270933718;
        Fri, 03 Jun 2022 08:42:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s9-20020a056402164900b0042ddfbea36asm4308472edx.62.2022.06.03.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 08:42:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D22DB4053BC; Fri,  3 Jun 2022 17:42:10 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Simon Sundberg <simon.sundberg@kau.se>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: Fix calling global functions from BPF_PROG_TYPE_EXT programs
Date:   Fri,  3 Jun 2022 17:40:26 +0200
Message-Id: <20220603154028.24904-1-toke@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier allows programs to call global functions as long as their
argument types match, using BTF to check the function arguments. One of the
allowed argument types to such global functions is PTR_TO_CTX; however the
check for this fails on BPF_PROG_TYPE_EXT functions because the verifier
uses the wrong type to fetch the vmlinux BTF ID for the program context
type. This failure is seen when an XDP program is loaded using
libxdp (which loads it as BPF_PROG_TYPE_EXT and attaches it to a global XDP
type program).

Fix the issue by passing in the target program type instead of the
BPF_PROG_TYPE_EXT type to bpf_prog_get_ctx() when checking function
argument compatibility.

The first Fixes tag refers to the latest commit that touched the code in
question, while the second one points to the code that first introduced
the global function call verification.

Fixes: 3363bd0cfbb8 ("bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support")
Fixes: 51c39bb1d5d1 ("bpf: Introduce function-by-function verification")
Reported-by: Simon Sundberg <simon.sundberg@kau.se>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7bccaa4646e5..361de7304c4d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6054,6 +6054,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    struct bpf_reg_state *regs,
 				    bool ptr_to_mem_ok)
 {
+	enum bpf_prog_type prog_type = env->prog->type;
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
@@ -6095,6 +6096,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 						     BTF_KFUNC_TYPE_KPTR_ACQUIRE, func_id);
 	}
 
+	if (prog_type == BPF_PROG_TYPE_EXT && env->prog->aux->dst_prog)
+		prog_type = env->prog->aux->dst_prog->type;
+
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -6171,7 +6175,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				return -EINVAL;
 			}
 			/* rest of the arguments can be anything, like normal kfunc */
-		} else if (btf_get_prog_ctx_type(log, btf, t, env->prog->type, i)) {
+		} else if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
 			/* If function expects ctx type in BTF check that caller
 			 * is passing PTR_TO_CTX.
 			 */
-- 
2.36.1

