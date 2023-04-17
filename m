Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E406E4D92
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjDQPsN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 11:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDQPsM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 11:48:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43EF7ED8;
        Mon, 17 Apr 2023 08:48:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s23-20020a17090aba1700b00247a8f0dd50so2085130pjr.1;
        Mon, 17 Apr 2023 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681746486; x=1684338486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wgVwyxor4VzOi7Z0g46ftmbnrT2RHnmbGZfAtqjbCA=;
        b=Ypm/PtLVegJYJ/lNGHMLpLBuX0ZC+yhaM4vULV0Sgptn47FedbANYyDu8n0yy0tT46
         rqo/w4dUDbRwOZ+Iu/QHP/H8EhzX39xR62wLm8hd1A0TNdFffBKdVpapFv8sngPgmiTj
         p8tV8TeEYJuLMnek2JZ8XBAfR/a2G2sO+sCqnEVCal97CQs3kAjsRzVnBsA+Hfgt8Bjm
         xVs2J9wyX4gyhKm/huz+i/YHG02ndgoSRuijtPBpZf85T9SZsWOBe25tz13waIw6dv20
         bP1LuMdj8lVtgkULK0dl7YrlJ9HXhWUg+0KcBI8vChWhC6jTaDFndYayT6Rt4C0VkPFQ
         7yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746486; x=1684338486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wgVwyxor4VzOi7Z0g46ftmbnrT2RHnmbGZfAtqjbCA=;
        b=Ku7vCWL6SMXuNyuLGprMCfR1efwahsF1EmPl0WliXG7oSMxCBz4aMrKk5wwI67Fz1l
         6NdVOVpFerre1W4VPIalV7ErSo9rr9VKPgLtWgGK4KV+Yvc5UA+7c7Y+XLhlMh+FE/MR
         ODJzZajOvVgZQ2zrN+Mmkn32n9X+ug2W58CmR1tq5ZCVKuuEcdl+daoBLhUlfw+Dn5Hj
         dTidIPW0O+jwsoPivDc/gdGc4wpH1AeSgWZoyZ9mNYizReCtCBoyj6s/Qbq/1CkMSWAT
         bZtF5W2asx2GUH3AMstBNLQhrIqAkyJRWtEEk3/onO/KqNJsseuFSc/h8SQykP8Orduu
         vLDA==
X-Gm-Message-State: AAQBX9ehWsDYnXr57QqIvTS5rV79GXiqulsQCDxDLk7p22moRaVkYHrk
        s2rI7wISXQiXcUBOGKK0r18=
X-Google-Smtp-Source: AKy350aRsEhgOwTO8pE4AeOr4FeKjjKs5CWz9jyW4rIRAs6bXZ46yIQ0sAhVvwQaZaEgKJzE9d0Rxg==
X-Received: by 2002:a17:902:d2c2:b0:1a6:7a19:331b with SMTP id n2-20020a170902d2c200b001a67a19331bmr14377306plc.5.1681746486035;
        Mon, 17 Apr 2023 08:48:06 -0700 (PDT)
Received: from vultr.guest ([2401:c080:3800:263c:5400:4ff:fe66:d27f])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001a6b308fcaesm4437513plb.153.2023.04.17.08.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:48:05 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 3/6] tracing: Add the comment for allowing one single recursion in process context
Date:   Mon, 17 Apr 2023 15:47:34 +0000
Message-Id: <20230417154737.12740-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417154737.12740-1-laoar.shao@gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
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

After TRACE_CTX_TRANSITION is applied, it will allow one single recursion
in the process context. Below is an example,

SEC("fentry/htab_map_delete_elem")
int BPF_PROG(on_delete, struct bpf_map *map)
{
    pass2++;
    bpf_map_delete_elem(&hash2, &key);
    return 0;
}

In the above test case, the recursion will be detected at the second
bpf_map_delete_elem() call in this prog. Illustrated as follows,

SEC("fentry/htab_map_delete_elem")
    pass2++;   <<<< Turn out to be 1 after this operation.
    bpf_map_delete_elem(&hash2, &key);
         SEC("fentry/htab_map_delete_elem")       <<<< no recursion
            pass2++; <<<< Turn out to be 2 after this operation.
            bpf_map_delete_elem(&hash2, &key);
                SEC("fentry/htab_map_delete_elem") <<<< RECURSION

We'd better explain this behavior explicitly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 80de2ee..445a055 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -168,6 +168,8 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 		 * will think a recursion occurred, and the event will be dropped.
 		 * Let a single instance happen via the TRANSITION_BIT to
 		 * not drop those events.
+		 * After this rule is applied, one single recursion is allowed in
+		 * the process context.
 		 */
 		bit = TRACE_CTX_TRANSITION + start;
 		if (val & (1 << bit)) {
-- 
1.8.3.1

