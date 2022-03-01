Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4F44C846E
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 07:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiCAG6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 01:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCAG6l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 01:58:41 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF65BD3E
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:58:00 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d17so13394512pfl.0
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vRJPPkpi3shN7BuP7ff2xoCDECqyI7rI51hNvfdbVU=;
        b=GGmxgmlmL/D/9Cs89aYiK7cPeE2C2PpequarGnxe4TtSuSda8oUnSF50b8keqCkNUX
         Ttkhnc+WFLqzn8E6QR6PpaG4vBmKNMdC+gYPtnPxcZ0MAzURo8+hx560Y33928p/GFdM
         hblDkRXC4CXbdmPRY1H2XacSnhWByz7ajBjIf6SGFzw85OqAJzT1kc2lLTIbEB3nfIMh
         zh4PNNZDvc7pbe36J0rOXBVLaSnhU+k7FjTQlJOymbqENNR+11dwV8nlAJWTtPFcttYN
         NvPyxMdKv7eD/wd3ONlJGBrxXzgJXRZZOvaiYGnCuOayihcraOiasOknKnyNOFBGI9fa
         5jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vRJPPkpi3shN7BuP7ff2xoCDECqyI7rI51hNvfdbVU=;
        b=c4M7joEgc0SG4uQ7/RZJecDW+Yk4jSfp9MnpnFfJClvmDXS/du24TNyplC95rnk+zo
         71c0VCkA53q4ddEGFzUloMSjFnac0PQlZA7DpZy1TJwIGmtsBKEJasQZ2z2PHCvJQmLS
         TVObq99ZXNuh5g5ry4iNF4TUuZtGhoscBFFEto2Q5coF1DDBe6MEJr7/IMaLpEpiokua
         fAvTW8ZrcSappwTLasXpy6SPCLYtEcOkgODjArpkrueto7cv76tQ6NgSz7Uma5HPHuRi
         ScOR/mLJ3R8Oi64krHSD2IbiFZOzvI+iWs35eidKLdNvMO9Muq254eYk3McYJ4HjUUWj
         d+0w==
X-Gm-Message-State: AOAM5318mc5ubWWV9FdB3UN2wW5qbiAP+XFzf4duvEhX5sP9h9DPwg0t
        BpMx/q41bbWbwLmoozwwO44CRJ4yMlk=
X-Google-Smtp-Source: ABdhPJxWCDkrgIANQlVWGL+s0PGdnAGSswCRAkDjKjgFmRhz9IENvYXSyW9UXUvCwy/JMknWuac9Lg==
X-Received: by 2002:a63:4d8:0:b0:373:cf6d:40e3 with SMTP id 207-20020a6304d8000000b00373cf6d40e3mr20624309pge.590.1646117880110;
        Mon, 28 Feb 2022 22:58:00 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm7023680pfb.142.2022.02.28.22.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:57:59 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for release kfunc
Date:   Tue,  1 Mar 2022 12:27:43 +0530
Message-Id: <20220301065745.1634848-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301065745.1634848-1-memxor@gmail.com>
References: <20220301065745.1634848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2826; h=from:subject; bh=M4CUfO4MXaPHJup/3ykL8r/ZWJZcD6lD88+sirxhK4s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiHcO1JN3RKUHplXm0hhxXqrPLKc01Xo4iK7Yl3vkF zWZiSLSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYh3DtQAKCRBM4MiGSL8Ryi2pD/ 9UY750+CwxBPLsUWICFfX0cUDkK5clmi9aqKEbUmarOHkjfbaXuf/J5txKUrxFDH0d2ijOD0aTVqrF 2ofd4cjGVQ+E0kZYhINaliAiIMGU4zDOAhwyEtFrU5rDOI78QTo9Rbr7bzFBPnQoktYsDziRMN/+BB 26jRl5r6ENZubBCe9BlUHyz8CAmk8eb922Tu2UOgoBsRb79xg6KqvtT/9QYJ95JQnaZV8T97UfdfnY rWd/DqjWp4CipqtxggP7NljG9fFM7VAnbmOdD0T4qUnlGqwOlvurPFYXUHRjcGakibzPZYlJepz6jC LrfpxfyHx0rNObDMTqBXZg2/REYy2Y92fuHIkx3aXFf6R60iUW40DpvRVUME7a+et3YYteNYaslZcS 22HUY/S0w919Rchb1HwZMBmml33nOLOYwGgioFXe9yNjaLveHzbkgFM+BzfHT2lwzADC2USvTa4BuX URbJafQvvm1kXGxFDWqBZtMyBAHUR+HtqehcW1N8s8z/XDvPHSy2F8seXgOpUJkNaoffZZhzhYi0kz +AYKHm8HY6p1wH4oFs/VTaM9z28VvN5i3XQR4D5rBpywfuFxfp4+ibLojv8tUgx3bVL+3XQnRL29Qp Qab1DeQt5wf0QzbWSFEhXWRdshYhtq4oxPan3ZOwn1HbljeFlHC/dARPpx2g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Let's ensure that the PTR_TO_BTF_ID reg being passed in to release kfunc
always has its offset set to 0. While not a real problem now, there's a
very real possibility this will become a problem when more and more
kfuncs are exposed.

Previous commits already protected against non-zero var_off. The case we
are concerned about now is when we have a type that can be returned by
acquire kfunc:

struct foo {
	int a;
	int b;
	struct bar b;
};

... and struct bar is also a type that can be returned by another
acquire kfunc.

Then, doing the following sequence:

	struct foo *f = bpf_get_foo(); // acquire kfunc
	if (!f)
		return 0;
	bpf_put_bar(&f->b); // release kfunc

... would work with the current code, since the btf_struct_ids_match
takes reg->off into account for matching pointer type with release kfunc
argument type, but would obviously be incorrect, and most likely lead to
a kernel crash. A test has been included later to prevent regressions in
this area.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7f6a0ae5028b..ba6845225b65 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	if (is_kfunc)
+		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
+						BTF_KFUNC_TYPE_RELEASE, func_id);
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -5816,6 +5819,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 							regno, reg->ref_obj_id, ref_obj_id);
 						return -EFAULT;
 					}
+					/* Ensure that offset of referenced PTR_TO_BTF_ID is
+					 * always zero, when passed to release function.
+					 * var_off has already been checked to be 0 by
+					 * check_func_arg_reg_off.
+					 */
+					if (rel && reg->off) {
+						bpf_log(log, "R%d with ref_obj_id=%d must have zero offset when passed to release kfunc\n",
+							regno, reg->ref_obj_id);
+						return -EINVAL;
+					}
 					ref_regno = regno;
 					ref_obj_id = reg->ref_obj_id;
 				}
@@ -5892,8 +5905,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	/* Either both are set, or neither */
 	WARN_ON_ONCE((ref_obj_id && !ref_regno) || (!ref_obj_id && ref_regno));
 	if (is_kfunc) {
-		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
-						BTF_KFUNC_TYPE_RELEASE, func_id);
 		/* We already made sure ref_obj_id is set only for one argument */
 		if (rel && !ref_obj_id) {
 			bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
-- 
2.35.1

