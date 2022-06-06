Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039D953E32D
	for <lists+bpf@lfdr.de>; Mon,  6 Jun 2022 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiFFHxI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jun 2022 03:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiFFHxH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jun 2022 03:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FF6211829
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654501985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4wjxbsl1erlBKFkxTTfcWwvSHQv8SIMTKUXWHhXdDJ8=;
        b=f/LviB8NC7zj752mx9QYkJp8WFz5xRV8DjA7gINCi6nQgO8AI8MqK+YHG9vK0kPVv+MsSd
        7VCg8AAsmAQaxgOATQ3x3/V27D3Dyrohqxrx0MYHx5RgrCPa20gDFgVAowj+w1lIoIbMDt
        xya+3+2W+abwps7jdNfzB9z6S8bI0UY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-Ap34DnUKP5SJ8SYL7R84Dg-1; Mon, 06 Jun 2022 03:53:04 -0400
X-MC-Unique: Ap34DnUKP5SJ8SYL7R84Dg-1
Received: by mail-ed1-f72.google.com with SMTP id k7-20020aa7d8c7000000b0042dd4a5a393so10049571eds.11
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 00:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wjxbsl1erlBKFkxTTfcWwvSHQv8SIMTKUXWHhXdDJ8=;
        b=voBKLrjCHQnRXH810kcWUDsOTzKCGyhj1E5EjDtorMG3W5r2oPlobkNPDCr5v7PMqU
         umn+saQ+DTf6TW6P6nLUjEapDJiI8kSHnJdGFLwR6B6XP37qy9HUhTlGWfsNABDR5ysk
         9Y8HeT042nUu6KUQVdO7hGdy2buq7E8CNidZdpWTjJViaOdZSAbB2nnzWngasVamixem
         ZnpxXnS8y13pQNCQ6C0ICcg8iuuas7gV3Y6Kix6C2TuJvZ3ABT2eLel+XN5SbOKHnejp
         lRGsNs8wnQXP5M0BqQwsenEeREbh96OlHMv/VKW9ckarnaFHDftQGmM4PaODGblTmtxW
         oeLA==
X-Gm-Message-State: AOAM531m/Fy/j6i9czzkxg+Z217urDjG/+aJxaS6EftfWTtBoJNGQpPt
        lg+/r9073WqlJlE5msiGaN/i0UesUX/HzrgDlz7T2DsevTlmlBdfF2goI4tgVTKUZ3J7CxH9A9s
        TD+OmMNIN45sR
X-Received: by 2002:a17:907:6d12:b0:711:d524:8c88 with SMTP id sa18-20020a1709076d1200b00711d5248c88mr1390608ejc.615.1654501981260;
        Mon, 06 Jun 2022 00:53:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYPfybuQj+QM3Mn4wjMpYzMx3MzTHUG2uQ2hgZMAQK8TkvY3grAtN65X/JyUOvJRQgesi6bA==
X-Received: by 2002:a17:907:6d12:b0:711:d524:8c88 with SMTP id sa18-20020a1709076d1200b00711d5248c88mr1390566ejc.615.1654501980372;
        Mon, 06 Jun 2022 00:53:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w6-20020a05640234c600b004307c8e1c3fsm3676350edc.34.2022.06.06.00.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 00:52:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1B0ED40559F; Mon,  6 Jun 2022 09:52:57 +0200 (CEST)
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
Subject: [PATCH bpf v2 1/2] bpf: Fix calling global functions from BPF_PROG_TYPE_EXT programs
Date:   Mon,  6 Jun 2022 09:52:51 +0200
Message-Id: <20220606075253.28422-1-toke@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

v2:
- Use resolve_prog_type()

Fixes: 3363bd0cfbb8 ("bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support")
Fixes: 51c39bb1d5d1 ("bpf: Introduce function-by-function verification")
Reported-by: Simon Sundberg <simon.sundberg@kau.se>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/btf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7bccaa4646e5..63d0ac7dfe2f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6054,6 +6054,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    struct bpf_reg_state *regs,
 				    bool ptr_to_mem_ok)
 {
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
@@ -6171,7 +6172,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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

