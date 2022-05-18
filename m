Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C602E52C6F7
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 00:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiERW5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 18:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiERW41 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 18:56:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62BC5F7D
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 15:55:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 135-20020a25058d000000b0064dd6bc9cfdso2874197ybf.23
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 15:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BFjmZhG7CpEBTsF/zKnk0U44MWRwVVUfrKHp4ZhHdIo=;
        b=YJxnAQi8iXP/bICY8DgVoB54wmM/vroiYHniDkqa8YrX/zt81bL3+EHyzRVBdSn9qq
         mQGEDzAol8FpZnYTiLQA3t0Ci5WwFsou3yavIdymJ9ZSqg5zrXytpR/dq+hhGO/NKQA3
         hUs0VzapM/bRkOYyRsi8Cn4bvO1RibbsVOgcT2GmVMEhsEgc8mpCHW2OFS9thdo5RUEN
         hekXO4mCQLxAa4fyToSl8Cx8BTSUSjmtpqkxp1iSZjFUscE5/75AwhmINBy+C8cvDdO6
         eRXpJQO/xWU0VlBodRo3gLSHhM4aTOjAafztBRZd2TFWY9ckINXVu5Wu0507UAE2Q406
         sbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BFjmZhG7CpEBTsF/zKnk0U44MWRwVVUfrKHp4ZhHdIo=;
        b=s5L/ABOACY3r9BjXN71snMV6Lid/YcXNBZJz08RMk434yeFH1MTd93A4AICXCk7+Bm
         DVQvLvkjkhWLR/Rg4pbtv+cinnjOIy1wd2EBGuS4GAGrCL/DAO/+k3h7Pu2dMBh0IzDU
         MSr4cBZlEUQQXvCCLNktOhzY6hK1ZRDobjkQFq2Dce9FTCT1GUmi+gmbkwChJj9c7h/D
         HROeKIT/nn0gnWd9dYjRex9jYEdhL7omH/mcgHOZRxCBGNlMvtMJkIVkSwxXg6ZzdTxA
         +W3GHESbSk0SPvsNfwEkMqwwLTjOY2IWYd30OZ2WoYsG232ey7LJmd9lVxQ3IAgHMR/u
         Wdug==
X-Gm-Message-State: AOAM530Gb8vQEMTcdbqje3L3Zb74VdU2SYiDWI3QYu5RM20XBexlditn
        mRCSjUrG3ofshb4kCJakZecM0LE=
X-Google-Smtp-Source: ABdhPJxgoeCvpOaOBA4VebtjgAEGJ99P805tt6wtJbxvjAUcJOQYdOrs40ZSTIH4LoXIsA0gTaEjCdA=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:f763:3448:2567:bf00])
 (user=sdf job=sendgmr) by 2002:a25:cd05:0:b0:64a:6b62:373 with SMTP id
 d5-20020a25cd05000000b0064a6b620373mr1949624ybf.264.1652914550345; Wed, 18
 May 2022 15:55:50 -0700 (PDT)
Date:   Wed, 18 May 2022 15:55:28 -0700
In-Reply-To: <20220518225531.558008-1-sdf@google.com>
Message-Id: <20220518225531.558008-9-sdf@google.com>
Mime-Version: 1.0
References: <20220518225531.558008-1-sdf@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH bpf-next v7 08/11] libbpf: add lsm_cgoup_sock type
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

lsm_cgroup/ is the prefix for BPF_LSM_CGROUP.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ef7f302e542f..854449dcd072 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9027,6 +9027,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("lsm_cgroup+",		LSM, BPF_LSM_CGROUP, SEC_ATTACH_BTF),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
 	SEC_DEF("iter+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
@@ -9450,6 +9451,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*kind = BTF_KIND_TYPEDEF;
 		break;
 	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
 		*prefix = BTF_LSM_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
-- 
2.36.1.124.g0e6072fb45-goog

