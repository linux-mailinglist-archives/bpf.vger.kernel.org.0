Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDE4EDDBF
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 17:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiCaPsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbiCaPsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 11:48:30 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663DC3CA5F
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 08:46:41 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id m21so6088344qtw.8
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ze+TRyAphAeduWuN2skeP9/ZCll4d+wxSL8ZQdiJjAc=;
        b=3xAXCx0uv7wSxkbnN6yD1JLuifFdUK7R1hVRF0HbxSWcEa6JRqkWbCZNuOwm3wZwXR
         9NLXlM3lw3fslVm4jzCt6SQUj+T126Jdpmyg64usIpyVMSR7Q5YRU0IIsOQ39ZZXSg3N
         67AgJg5tqaze/M8euxyl9puyx9Y8XK+fk2mzCSIavEfxpAD0sbRCT9c2eb61xYQjhd6v
         HGfj7vo9v3+3taNdD/5aLo6+0PjpRatgLbeGByUfp0ZSPVfrlMcvgYZfRYN65ZZYaUbK
         pHru/Tf3DSc18OmWSm5sOaWx6uFTJBJ5v6pE9uYHsWMrO9H89Sh2LMTMmOxZGIGjrYWp
         4gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ze+TRyAphAeduWuN2skeP9/ZCll4d+wxSL8ZQdiJjAc=;
        b=O8c3U5cmEKPWxLz5s7fd/GutQ5RHFTw+vCUUWgLJ/DIhbGV9Yq6F5Fs1w9lwRAG9EE
         ZQ8uGW6Wyp5nPgbv8KyWxzzZLiwD4Sl4IiR8k4go3RJv3UcTwnrUorIytNnd1E5ok1GO
         10iZNWul7p3POy1sWtUKYILZrFLrUjV4MR7TBaY/T2nWAEVKw0mXo1lb1LPmGLUkivB5
         if+cr//J0ttz1Y9+rfzcpaNhglIMSXFek8rSuhkXWtHeEmvqDuZYA31y+R4b9qkHwWGf
         8uW8Lk5BT8W31oAG/qp41hkiW+PbHavlxboDkvBzuQPwCGtakpCFYzwKbZrDPQAHCkt5
         V8hQ==
X-Gm-Message-State: AOAM530Va1gfLMSW72dmAcRNgFOdA4mmIuqHiFo179VkXDFV6+jPVq2i
        ALRQYnypiUOZO8YbNyAV4pYFWzmxyrNrrSezzN1mEA==
X-Google-Smtp-Source: ABdhPJzVLojvPkerMf3LFpWe07gvD3uWRA5x7n4tr15Hk0dQJ82dzo4aeF55MzjTM/jUKnB/KOCrJw==
X-Received: by 2002:a05:622a:345:b0:2e1:c756:6981 with SMTP id r5-20020a05622a034500b002e1c7566981mr4762523qtw.177.1648741600232;
        Thu, 31 Mar 2022 08:46:40 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:1d10:5830:565c:ffc5:fa04:b353])
        by smtp.gmail.com with ESMTPSA id j12-20020ae9c20c000000b0067ec380b320sm13126797qkg.64.2022.03.31.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:46:39 -0700 (PDT)
From:   Milan Landaverde <milan@mdaverde.com>
To:     bpf@vger.kernel.org
Cc:     milan@mdaverde.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, davemarchevsky@fb.com, sdf@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/3] bpf/bpftool: add syscall prog type
Date:   Thu, 31 Mar 2022 11:45:53 -0400
Message-Id: <20220331154555.422506-2-milan@mdaverde.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331154555.422506-1-milan@mdaverde.com>
References: <20220331154555.422506-1-milan@mdaverde.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In addition to displaying the program type in bpftool prog show
this enables us to be able to query bpf_prog_type_syscall
availability through feature probe as well as see
which helpers are available in those programs (such as
bpf_sys_bpf and bpf_sys_close)

Signed-off-by: Milan Landaverde <milan@mdaverde.com>
---
 tools/bpf/bpftool/prog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index bc4e05542c2b..8643b37d4e43 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -68,6 +68,7 @@ const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_EXT]			= "ext",
 	[BPF_PROG_TYPE_LSM]			= "lsm",
 	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
+	[BPF_PROG_TYPE_SYSCALL]			= "syscall",
 };
 
 const size_t prog_type_name_size = ARRAY_SIZE(prog_type_name);
-- 
2.32.0

