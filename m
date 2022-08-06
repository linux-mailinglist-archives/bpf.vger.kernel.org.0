Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D058B346
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 03:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiHFBqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiHFBqK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 21:46:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC06A7D1D6
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 18:46:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p10so4941914wru.8
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 18:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=T9rhKHE44Kqx6/Cxz4pDtpbNcz3iUaMJMeFl+qlHrS0=;
        b=La48NvFFbomM3E1Pe8LtYuw8JXXGhA2rAGaz1J6ib5cVlAanO4T9Y8QAmqNKbFshoe
         we9vyRxSQRm0XPTXe4lQV7kz3XZmRYk2vSASYGMX+HtWm2pHAob5sWtubG7Oxl5+8rUn
         0pCQkfF6H7QzZmtL7M0Ao7VIGDnR9R8CcTuMrbi4LujZkqtrbqfert+FyVMpV0xt+TGI
         8AqVL+AOEGix9m71b08Mqh04zpkdlmmFChJH4C+bHmIrNrMBD7xJUPz4Uj2DX+3pLC9p
         96XxeLGtz0rA9aQOGM26Ooddf1FCKUQcClBhWhj6EZXYVy106udUAa0lwXj8clW1X2JA
         vfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=T9rhKHE44Kqx6/Cxz4pDtpbNcz3iUaMJMeFl+qlHrS0=;
        b=NYLzBA0wTzO38ggZuhFsgYoW+vxM5zj7XKykiRGLLVz/xucpySimmvs1J7mdpfBmU0
         k8lKO02cJytsy8JGKnI9Qo8lD6loFdcA6qZ9YZ2c2qScZn2vD5sCMHu5MU5IDvy/Ow9H
         L4MvJwDPDA1yIWxC0i+KySJr1/cRyXptonBw25giT0Ob/ud449H3LnLNC4lxQqQ5K4XF
         Cpt9olgbQhLSpOaPA4K7MAz3FUdBjW6d4Niz5dxbUhgGkItPmkeiEcPQ0YhUPJz2mxNU
         2L+BKfSJcUa/ajzZGbU3MbU5uFi11Vt9m9hygPIjG+97Fca6lH5/me8nMZYKxu7SkI6u
         hdcw==
X-Gm-Message-State: ACgBeo1IDDT8csm9VhHJspXtbG/VcZxMpBzldiUWIk8wm4DQaqORHsiK
        xg6SsVpW0gOfL8ag+nJwU3Z9AMe7T2w=
X-Google-Smtp-Source: AA6agR5JEDQ4cNMfR7k1StL1PUyYW7gGFf+KskzQ7zdFJM5rH2VUY+4Eitbg4fdr9RL/wPxpl9mk5w==
X-Received: by 2002:a5d:4c82:0:b0:21f:1404:1606 with SMTP id z2-20020a5d4c82000000b0021f14041606mr5562690wrs.642.1659750368032;
        Fri, 05 Aug 2022 18:46:08 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b002205b786ab3sm5236297wrt.14.2022.08.05.18.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 18:46:07 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 1/3] bpf: Allow calling bpf_prog_test kfuncs in tracing programs
Date:   Sat,  6 Aug 2022 03:46:01 +0200
Message-Id: <20220806014603.1771-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220806014603.1771-1-memxor@gmail.com>
References: <20220806014603.1771-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=memxor@gmail.com; h=from:subject; bh=awNP/IgLW1N8fIbBHxKdlf2TW0p3qvwRBAwGmHV3Yak=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi7cfJ3qgE/DhN74Ua3h+V8AyFn0fCybOK94XLuCCn kQ1Xv3aJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYu3HyQAKCRBM4MiGSL8RyqHFD/ 9f0TuX9GuYL8rCU1sA3gh24ONqnkEKBcCltts8XDtRykKKpTSibXzGTcm0dAv7ATvBzTCmyObK/LAO /qhrHgFeuKFBmU+ZkMS+z22YEynDGkJ8/66/qDUABxHjoGMZzTspe9ONSHkJWLdmJ13ZBoIBnVmPDo 8RXa2qzR5jmlH8H8JXkTwzpsTmubnOSvO2Aflza6YCv29t1IeV0X8m6kCe9pSxKZSC0dyKzrPuSs3k BPLuGTqtLV7KHKnAd3ONby4uKmNU5sg6w07l8QYCO4g/LLeZd0u+HC9Gg4r/i4jzwT3LEqFj8MwMl0 Zfwn2t0DGGLCyh6jS5Af9SworLYgP6iJV4ADYWN+h0J0sN5U8m/z/3FBMuyXihIxMt23i9+kG7FU07 njJ88dysqzhtFDMQJ+j2MW8HvlunvV5UN1WnbDrJKN7/i+aWHBYQ7IGU8C+Ik6aShmgqtGlYrYAEwM +yDi1X1VtxwhhJ9iYvJ9pmroAJAnZnimvc/L1fNpxq9xbVNLyFlH82wg3A9x3THkRDfFyc4CtoQkYt IBtDUZAV1Reyf5vkJrSwPS7C9dtxeFfZjwMNQ0HEzJVPTEH9RfmskWcFWXUvkMslW7lxPG6xKuL327 p+/rq5We5lCoaGCuXfS7GRXqk7rbNe6L30yUWS+4zJJJ11p0l1JiG8KdkYeQ==
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

In addition to TC hook, enable these in tracing programs so that they
can be used in selftests.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index cbc9cd5058cb..d11209367dd0 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1628,6 +1628,7 @@ static int __init bpf_prog_test_run_init(void)
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_prog_test_kfunc_set);
 	return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
 						  ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
 						  THIS_MODULE);
-- 
2.34.1

