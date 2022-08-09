Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41F58E1C8
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 23:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiHIVbF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 17:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHIVak (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 17:30:40 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AFC4C61A
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 14:30:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y13so24370019ejp.13
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=K1r/HcnKUY4e3fMy7hGNQMhupbyG8CJHERTJH0vxxX8=;
        b=V961u/YwLfbpA/JnJb8BGZ5lCmvy0rMQkF/3TOHLeiHyGFYxnkY4UuF3qM7YG62ttI
         gCo0OPOYSCe0u4LixvTAAAc2r5fl5HN0SKY85uRXlEwyTC+Yg4T7BAhXWY2A1X6xbuPy
         xCJ5iIWfQogN0JtIHv1Ity4I5qObv4JNhvFA9NIe1D78fA3mO9yeyRkID4puKMDnZO1p
         GYN+X8/5aNApOZVQ+ifAjUu9WbOrfSLFEET0c8wxS0qfVhLZ2lzfhp0onswxlbnAEaQ6
         rmOgxSYWeFjqiygGX92hUaSLixRtCVLqZsU5exU6+8I3N7GwOBmXG3srNIeaHae9flpv
         E7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=K1r/HcnKUY4e3fMy7hGNQMhupbyG8CJHERTJH0vxxX8=;
        b=UfX8cm99ohyqz3o5a0Ky26gkSISDBMo/pJDuIouiYauMSom6gf2NqcC4r9ONfOnUY2
         SsD0ERR3ckbHnX/gNG+eBhexc5z43BhEkgZQZTHZFSTq4MMOaV28siAJ0CMJNolZ0U0w
         jSeT2yBdjCdaKlZhU5UgLc5hMSv2byrICuDkspWGODW8VHErYAQIqTm66/yiZIOFVfsi
         5NDyMjx45vZot1r8beCbz7EOkdOy7teKQrAJ247xHib1a28AVFz0d5bn+Er9FOFQjDC5
         62nlKKnG1+BmX/vodpwPn4tAuuwDrmiISG6XafwmPD/6AR6BbvZkEK0jQknS3jRkcOTO
         FlNA==
X-Gm-Message-State: ACgBeo2RPh7vFzOofyEYWBtuXfdzwsXWwNE6gKV3KPa/W02VkakN29+r
        /Be7duFPiafpKZ31xqJ9EsVvCvHH7LM=
X-Google-Smtp-Source: AA6agR4/BgwwlUUN5S7GEoRhDIzEzLS9n0uoPqWtL7Atkl+XqNemImov143WDsAQquqfKUJ9vyjHYg==
X-Received: by 2002:a17:907:6295:b0:703:92b8:e113 with SMTP id nd21-20020a170907629500b0070392b8e113mr18564936ejc.594.1660080638295;
        Tue, 09 Aug 2022 14:30:38 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b00732e3d94f4fsm1257487ejh.124.2022.08.09.14.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:30:37 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v3 1/3] bpf: Allow calling bpf_prog_test kfuncs in tracing programs
Date:   Tue,  9 Aug 2022 23:30:31 +0200
Message-Id: <20220809213033.24147-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809213033.24147-1-memxor@gmail.com>
References: <20220809213033.24147-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=memxor@gmail.com; h=from:subject; bh=pKpFJYwy+G7Sqq4q16yyZoX6s53S9dDWQeRYayu+/90=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi8tHvLF4GTpJpGYWtB7bVW3oKV0ZvhyJv2K8Ow0+O WBIKoaWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvLR7wAKCRBM4MiGSL8RykOzD/ 9uJqRODuKXlOxfCKRMxJHMHcUIFp0rMT4dJmtCFn/HCJ89TuMB+BUCM0/d3ZDmPCUSLB50QInkli3Y yt4b1CSUR6uxPvGW9EWJYURg5g6Kx2M+4rzRtnI1R6jJ7SD+QWLL02SHMr03ibjjBaJKIhW4AHp0Sn hRBLtTU9umcyCRgNvvuefjD8oHT3D1B9EOpJ2D5iU4ubTTTel96Vwjiz6tICl4atl0WS1f2ScYSxnM RXhuR3cdVNCrmekeXvlQkvWeWpTC6mg8AXNe++sP5QcftNXY/0ruju1F4fe5I7SFerqPGwlJcNAC8r QK+ttoea98ivqR+VLXMBej/62lCA78/dAAuHpEdLbEE+wErrAqYJEyiQLDw7SmyJjpyLHaIGjgGd+H VrFb1UJdyry7vz6mraciJF1+WTZ40rQc0bzQEvadq5RyHUWyQHHLwnT5nlsJIM7du2+DJENnBs5dY9 w+8SjXl1DO0GOxznraXWRxhKcDJnZoWzkzJud/n4b8nWbP4ry1sIWlisRH32fdjqdL8DiNtT/fJBcF tWZ7dvDF1mQU8TFdDeIn85BTCTwunriQSPkOo0DDZvDrz5r6bQLi2+VASb9hxSv5pAMwX/Y3OsS2Ea 3TcAz4eH7xjzH7UqqSl0qF4Uqq9SS/lm0du7XvuzJZULV6TBX12SX6p9bAKA==
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

Acked-by: Yonghong Song <yhs@fb.com>
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

