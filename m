Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD369E8D4
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBUUG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBUUG5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:06:57 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCA82E803
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:55 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id h16so22133382edz.10
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLBEn3jLcMOSmLSoNKVjC/08G00nx8V0vNuukGuHwCI=;
        b=G7+hk36fjR8pSqp378xP+4giFa/CmjeNWFeilCllAm6jNkaPUByLlDFngCrix1MrRN
         rhr6JBTh6Fvb4iPTBbguZULxLySj9yxPq8XTBE+XPkeVjjWwQ+4XHMHAojJp5boflaoA
         A2O1uDyb2/3CECNIJ9Cxpol4qOPhwyHbaq50zIKqXTPUDpi9HA9lXVEO3+/E0jUSJlpJ
         gp6BVkpmAmkXiPKv/B0TjwCiqzSJ2IH0u/zcwy7xPs0wzFxmuFuR9QpY9sB+Fs58M/Kz
         tKKfr1FCajIZ+fQ47u6DygWtqU7rEL6jP0dgRCJPzNAJNCs7u6RTgniTvOwVsXt3/gsw
         rkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLBEn3jLcMOSmLSoNKVjC/08G00nx8V0vNuukGuHwCI=;
        b=HkzyN3SFg3/zyPRbraKLznJ5zpRIpTFwdh74RJ8m0j/jOJ2AIOh50VpXrPgZSE53y8
         SdYQ+9yq8UQU3cIJBAr4ZxE+Rno3QYcFT0JbYYeMzyNwSWs1Lw0d4UtprxWk8irDbcQ6
         4hQQZAs6B2MkieV5i9EWbyIQ7FGaySLWfc1R/yjVm37FUoNTsIKQn95+uegFPsJB+uqK
         qR4vBH02HkU2G92zdezO8v87PMSNCWHAut4tl+qYxHvJKcS+9NcSSb/eBrCXIQCx8XQC
         ka6FVEbLtk/ROP6qfJxwgo+OR2LED5DKEE6YzVSISpvQBNeb2eo4zHhEPTi7Rxg1TVmT
         xMLQ==
X-Gm-Message-State: AO0yUKUQ255KIig6R/egnjAWv6e78ADs3RMdDyKt89kyVKR1ke7Bei49
        QzAb4DjZPLugAw2hpmRWWOqX6f3dBBozpw==
X-Google-Smtp-Source: AK7set/jxnE/UdXCrtVPtMkgJQBDSeY8qpeFZYFPfTQQaoMijp3LCSgwYh/kleCUIXozfaAtDdrI/w==
X-Received: by 2002:a05:6402:5022:b0:4aa:dedd:41e0 with SMTP id p34-20020a056402502200b004aadedd41e0mr7309881eda.8.1677010013219;
        Tue, 21 Feb 2023 12:06:53 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id w7-20020a50d787000000b004aad0a9144fsm3133970edi.51.2023.02.21.12.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:06:52 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 4/7] bpf: Remove unused MEM_ALLOC | PTR_TRUSTED checks
Date:   Tue, 21 Feb 2023 21:06:43 +0100
Message-Id: <20230221200646.2500777-5-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221200646.2500777-1-memxor@gmail.com>
References: <20230221200646.2500777-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=memxor@gmail.com; h=from:subject; bh=sLl/ONgY3LjqhuNq2QP2UePimgBpCudu+JdJnC28uVc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj9SRLPWgTTP1c6F+b6jgW9VwGoxjIc4mGmqcUALza J7YGkT6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/UkSwAKCRBM4MiGSL8RyhDBD/ 9exI1CMsHt8ii9v/atn3neWJZH6hvAUONujG2xUSZWo6B4XcXnmxu6h40W3Vob5TbMPZBobybBmbHL AssgCgP1Yi5OKpxGiE60sGlfQtgKYKun7vGCsP1kr+4OVYaCmN0XkinEiPYXK6WXmzeE50yja1NtCF I9UPzcTwdnX6b70juAWm3LMjX2BPEbUq+tyJmIWAcHmYmebm2tAF5n2Syy48g1hA6QyvOiq5qMRxXi xO0IMzMIc8f0gvbUPAwtdQR98ZJIBX04a9sdcecAYvgudTIKXTpv3Eho9EnfPyjxbyUDHhwzxb9d38 0/UV16fnA3SssuEtFxmgUEzv/6bZ4sN1+XBFxgpM+19Yv4WEVwxRLScgh+Z2ZXMmNODTP+XdyzC95t HPYhFGm2g6i51p+NwgvDwcS2ncNoFhkELiSky5Ut4CwTk68Z1Dy5pF3UdPg7LpRHjtBwX+gJV1uX5R a8Wn3RJG/LgZ3/Rdz5SyPoHUhhROu7VKlo8tFjPkRlkRntI9oKEInXpFPpkhV3RujiIkzSQNN4Fo5y sefnIe5gZjG8E2kghe9rhPjyloabRBHy0prbv3cNKUQBQ2xXGoE2s6FaHxRRQpv0wo4FHyEIbPtL8F B0tb6Zv2OdoWVhfsepfZDnBiVuxW+Qc1IR6T20Jay3elZmtqmSIvYRe63/oA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The plan is to supposedly tag everything with PTR_TRUSTED eventually,
however those changes should bring in their respective code, instead
of leaving it around right now. It is arguable whether PTR_TRUSTED is
required for all types, when it's only use case is making PTR_TO_BTF_ID
a bit stronger, while all other types are trusted by default.

Hence, just drop the two instances which do not occur in the verifier
for now to avoid reader confusion.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9a4e7efaf28f..6837657b46bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6651,7 +6651,6 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
-	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
@@ -9210,7 +9209,6 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 		ptr = reg->map_ptr;
 		break;
 	case PTR_TO_BTF_ID | MEM_ALLOC:
-	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 		ptr = reg->btf;
 		break;
 	default:
-- 
2.39.2

