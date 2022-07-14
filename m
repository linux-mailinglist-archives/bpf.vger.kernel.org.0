Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE745756C8
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 23:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiGNVQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 17:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiGNVQm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 17:16:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880886D9C4
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:16:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fz10so3953598pjb.2
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulrZOs1a0B2p2dUyuBcf6vnQjVR6+PsHJ+UDEIVVbpk=;
        b=ocNtnz/SytBaBQQXYZTnmxblqbI2LcwBCuqXm/4fav7gU+ZR64cPDEM3wAxEfkZvw7
         BQJymE23QMQBIxaoIixHX/vvoLmNKDHTe1FGSEtDNng7cItxvTwiA9vJ8yvb7T4hpzHf
         sOGAcDVmmi4EMtuLZuwf1AYmxjByj8z4Y/H023mi/ynbANq5WdP/9WBEEqXWX+GPBq6g
         OQxfjpFjM4VMjRB8u9xr7Y8XwOMd0b+P2XF/BYk14+rEJsInssUN3P7b54CiNHqN1q/q
         mAPivgMVV6idVMTd4i6xXPCah2XitSvewoIJI70PLlcFPDQIJaUPKONV6b3Wrak9n3U4
         k7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulrZOs1a0B2p2dUyuBcf6vnQjVR6+PsHJ+UDEIVVbpk=;
        b=vmwJxi1TqafmvRjjedl5+n+XGp0vcLenJCYsE1VTKC6NeA+2dzLbZ7DH8tmv5Ha126
         X5H7IrzvYRRavGag4b4JnoA79MBOf7q6JHOn/ix44vzxujGXhfcGZT9g0i1jrQ5IgSpI
         RhUqvJXGk7uuIIlNtWJLrDyiecXsRpAyRK2OOxxzDTL7c9LgSYaBu+E3Sjy1Uoj4BxcI
         hFvKqiPUO5kdLR7wFAsyqMo8g5aadZ1mZ6JoGEgVQH1R3uim6cwoFcEsAYafeSO+iobW
         Cd04qbD5Bb7S+ydhn+Qps7sfib8RvPTPz+8HalJ2+iWoC+++tBWAS74wtGNzOoeCLA6m
         EtXQ==
X-Gm-Message-State: AJIora9F0rFBWbSsOOK1gCoSOPSrRCdgitysxsUebIsTzj9Rwcx1QgI6
        fCJzCnqNGTSPk9oyH4q9Pw40P7/p8kw=
X-Google-Smtp-Source: AGRyM1s7N5+4KpEC0QcemCYy3ym/OfaFiIOfHUXnawZhrLZgtaLR3Gmz3H8nplnWSw1vXb71MRVr+Q==
X-Received: by 2002:a17:903:2308:b0:16c:58a3:638e with SMTP id d8-20020a170903230800b0016c58a3638emr10294001plh.100.1657833400918;
        Thu, 14 Jul 2022 14:16:40 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:697a])
        by smtp.gmail.com with ESMTPSA id 22-20020a621716000000b005252defb016sm2123190pfx.122.2022.07.14.14.16.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Jul 2022 14:16:40 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Fix subprog names in stack traces.
Date:   Thu, 14 Jul 2022 14:16:37 -0700
Message-Id: <20220714211637.17150-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

From: Alexei Starovoitov <ast@kernel.org>

The commit 7337224fc150 ("bpf: Improve the info.func_info and info.func_info_rec_size behavior")
accidently made bpf_prog_ksym_set_name() conservative for bpf subprograms.
Fixed it so instead of "bpf_prog_tag_F" the stack traces print "bpf_prog_tag_full_subprog_name".

Fixes: 7337224fc150 ("bpf: Improve the info.func_info and info.func_info_rec_size behavior")
Reported-by: Tejun Heo <tj@kernel.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26e7e787c20a..9cefeb1284f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13630,6 +13630,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
 		func[i]->aux->func_info = prog->aux->func_info;
+		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
 		func[i]->aux->size_poke_tab = prog->aux->size_poke_tab;
 
@@ -13642,9 +13643,6 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 				poke->aux = func[i]->aux;
 		}
 
-		/* Use bpf_prog_F_tag to indicate functions in stack traces.
-		 * Long term would need debug info to populate names
-		 */
 		func[i]->aux->name[0] = 'F';
 		func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
 		func[i]->jit_requested = 1;
-- 
2.30.2

