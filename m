Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845C14CB5FE
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiCCEv2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiCCEv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:51:28 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781C11C7CE
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 20:50:43 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id m185so4380292iof.10
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 20:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcePxdVil0j2Y0EYMcgPWL10sT920XMS2ub3RyNr3OY=;
        b=KCxyeNhxP6uj3q1LXJtIGETyZeCtrFZMCyquqgy8sxUIEU7DZDduwdzaN3M3vnRaVA
         MxQPD1AQjpby2sh0LjQs8lspz6XvDns4+uRJrZHndYDW4d9GSqQ2S8RX2ewD1DVe9OzF
         nKXYiXJwsITGbHAI3EqHBHh56Ff63NMLHuc/v9tgp+8/XAhKg0YjMbi4OqFJ4Voux+GA
         H3jXRiY3L7Q32ScqWjqOJiWnGpxEu5tPAcdHrdKWxp7nVgRDGHkYPlq6Ghd4QEopcxXH
         v5mVWr3vHRPVQ8xJftcyjOIPXje2hMSgaYqUb7B/LB9QGnf3YMLW+U0pzkElXj2jDJxg
         Nhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcePxdVil0j2Y0EYMcgPWL10sT920XMS2ub3RyNr3OY=;
        b=TvsREn3Zbhu1yc28SDuOJcdeXMGWSGe9Qmm4xG9kXItMk2e4BgwODC22AeTLXkjSqd
         NeZrfufKEa8Bwk6e4ZWfHv/SXcbZATlaCFPpQOpGWfWS67KNzwspS/VoJH0fXY2KK2wg
         SWi3jslrl8gFibD4HB+CYs+E2G3HXetiJCozM9qPwre+4PX3oCb6sHCLeMHM4pP7XHqN
         93u9Pom4CVmTLqgUgii6Re9bA1yf2HiH2Hv3YYlJg6YFQusCYMXUa0C3DmkO1ho6488N
         rgyKVPVqw6IUNv7N0ouO2vDzsDy4o85XTfNHf+kTqU53UX+jqJshAe27xo44kEVfMFD5
         uxQg==
X-Gm-Message-State: AOAM533eu6zQ/jRyQXbLj8yLBAmLRRZJHDi0fom0LrwqqFhWT41uiacB
        K49MDkBrzZDIJLEJ5ZSTDPnGarFUZZI=
X-Google-Smtp-Source: ABdhPJxPWXijqbRGc4x/dbFix8FwKjU9KQlqGrBqwfovnCKUr3LGvV/KwFSCStvHgMMSzDKFjuMlpA==
X-Received: by 2002:a05:6638:2609:b0:314:1c58:9fa0 with SMTP id m9-20020a056638260900b003141c589fa0mr28328031jat.91.1646283042717;
        Wed, 02 Mar 2022 20:50:42 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id k6-20020a056e02156600b002c2f7c95b7esm722302ilu.51.2022.03.02.20.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:50:42 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v2 2/8] bpf: Fix PTR_TO_BTF_ID var_off check
Date:   Thu,  3 Mar 2022 10:20:23 +0530
Message-Id: <20220303045029.2645297-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303045029.2645297-1-memxor@gmail.com>
References: <20220303045029.2645297-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141; h=from:subject; bh=6O/7bE9Cyl1Q+aBejwnyFc0HIYcck0DgiMjjeMgU0Ns=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIEj//KGjWYQoDvpihEw7sVUZ14iQ8LRSclbsQ3t2 Ew6pM82JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiBI/wAKCRBM4MiGSL8RyuERD/ 9TQSyXW7CvZGkYx7GLwApEyC2v2cFuyXdJ6ErTHMvCQCM6ZHTJRysgt5GvEx8eWd9fEztJ6zG+ZOev 3LM4DzSzfafPPLviNs+0RS0Z4yplSUY4WRovAKCOFdWd0VSNXU/jlXVzgJCLB0OFyqD61Hx6xJYE9X FE4zl37DSMAGEg+47UDB8CTl2nkY1Cy3BoZ+R+aQEsGksvOWtrNnW7QOxNvHoTKbVNCie100YS/9tN 8IWc/t++i6kXmBtzyP3pMEs+qMLx45KBhcIoJAJ1lD8sNDrQOQ6TFUnBsLn+7pas6YoI2apkCexb+3 ErJYeqvIqIw/eJKs1u2lJjoLI0GxnLCIxi7eMfMfQH3NrW3fEnRwJdBiw8saGZx7E0QlrFr8IANl2+ BxgrD6VhDWHHOy8OejChCIkL4ieN+f2Ajp9/URFbW5x/8gFw2dog0Bog4ibs28VU/zdXqBOwopuHX1 8YFKk1ALREueYiOuCFC88AnlPkT+LSfDCXHflG2FFh4AM/0TVQ+M5bnqm0kktE1YWS8v9ivWPwfKpX WAmRjSrRsAgTlz2E6r2skSr2k6yIBBffkAXJtLi0pRQVYAouQ+IvXyjDzPwOKxsyDnBarTFYR3TsR0 wyzHcuZ1i6uB2hQpSseHGDImMGovk+e3QnI3+5SCVA5Ykd198FntaYPVBqNQ==
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

When kfunc support was added, check_ctx_reg was called for PTR_TO_CTX
register, but no offset checks were made for PTR_TO_BTF_ID. Only
reg->off was taken into account by btf_struct_ids_match, which protected
against type mismatch due to non-zero reg->off, but when reg->off was
zero, a user could set the variable offset of the register and allow it
to be passed to kfunc, leading to bad pointer being passed into the
kernel.

Fix this by reusing the extracted helper check_func_arg_reg_off from
previous commit, and make one call before checking all supported
register types. Since the list is maintained, any future changes will be
taken into account by updating check_func_arg_reg_off. This function
prevents non-zero var_off to be set for PTR_TO_BTF_ID, but still allows
a fixed non-zero reg->off, which is needed for type matching to work
correctly when using pointer arithmetic.

ARG_DONTCARE is passed as arg_type, since kfunc doesn't support
accepting a ARG_PTR_TO_ALLOC_MEM without relying on size of parameter
type from BTF (in case of pointer), or using a mem, len pair. The
forcing of offset check for ARG_PTR_TO_ALLOC_MEM is done because ringbuf
helpers obtain the size from the header located at the beginning of the
memory region, hence any changes to the original pointer shouldn't be
allowed. In case of kfunc, size is always known, either at verification
time, or using the length parameter, hence this forcing is not required.

Since this check will happen once already for PTR_TO_CTX, remove the
check_ptr_off_reg call inside its block.

Cc: Martin KaFai Lau <kafai@fb.com>
Fixes: e6ac2450d6de ("bpf: Support bpf program calling kernel function")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b472cf0c8fdb..7f6a0ae5028b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5726,7 +5726,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
-	int ref_regno = 0;
+	int ref_regno = 0, ret;
 	bool rel = false;
 
 	t = btf_type_by_id(btf, func_id);
@@ -5776,6 +5776,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+
+		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+		if (ret < 0)
+			return ret;
+
 		if (btf_get_prog_ctx_type(log, btf, t,
 					  env->prog->type, i)) {
 			/* If function expects ctx type in BTF check that caller
@@ -5787,8 +5792,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-			if (check_ptr_off_reg(env, reg, regno))
-				return -EINVAL;
 		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
 			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
 			const struct btf_type *reg_ref_t;
-- 
2.35.1

