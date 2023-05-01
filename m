Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5696F3878
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 21:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjEATsi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 15:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjEATsh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 15:48:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4426B6
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 12:48:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559ceb9eaa3so48050977b3.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682970513; x=1685562513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=chEHtwwUNx/kX1jGhlTjBB+oOAO5Kgm7VaBZIC47/4s=;
        b=bi0QDxo0IPUoqHr6P0yGO3r1chjkLhMofnUMpH9mwkJtotLNkv8lnOoGGWhCSCpX/F
         2ar5nN8Z5tw9TLC4tlukN+VesHtF/Vs/ZeZkOeGTkU//QNnwjPUYG4ISRVoWxWb7SMcF
         2/R1cTQMFC/E5OUioGovS+cxBRwzJyeaLc2AK1PAgHIUXYPSXbkB/7xwE6VU30m98AjF
         UGZ9E4S0usCR8mwXVOvviTmBAVecx3P6nqWkqKUKtXmNnteWWbsw7/01nOAIBDRj7amd
         shju2AM4MyOW08RZqfIdkDf6U7nB9474NCWf10+E4T7a07TactMxODm408Ays/7IOGUz
         Mh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970513; x=1685562513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chEHtwwUNx/kX1jGhlTjBB+oOAO5Kgm7VaBZIC47/4s=;
        b=DD956xkE+xCwUWzH6zbAhmCXJWcz4FMUfvWXvSQtQ7JcmrMe5e38gTVYPj7yONtriF
         ZACPgW0O61+lL5u4Q4/KUqzFJv5DXkgua2cL+3SKvIhuHuwP/zEwuAT0NU5eZwxcwqzj
         dHBBUrNOdLI40ce+nYrvHQR64BtMt1VDLO095cjUIgKhhHjdoJSySSH23I4nPcvCxmOp
         u+xNZkjE8xNOgTT5XUWYrY8wyagcVcf5xavlhtX777DJUgp8I+DgCspxu8Du3u7lYFFO
         ATCfQIfrpTRlOz9D+fCSsFHLxbV00KTjs7FWt+Ad6dk5QPIGavk9wA6D4PUmpaT1SIrj
         w3yQ==
X-Gm-Message-State: AC+VfDxOjSs+QkvVcGENsGOTNd+etSBh1C2QM2aDposrKA2pL/Mgb7Wj
        p+LzP+JbVlDtDF+77nlOAVAjjKx8kWNW3uac+k7iwa+PhqbiEFgC/zPIRgVMKVZh3xFwAQoHZBG
        L2InsjjqXCKfpyovUcJOFFipQsq7HNTg4Pk2M3Tel97gBfRUsng==
X-Google-Smtp-Source: ACHHUZ6BW32BHRSMn8bTFUcKBeEQY5jPfFOJuwMYrtIF/tZHRUcCh+Ez0Pht1gbfF6xUSTxCBeAUCkM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:ec4c:0:b0:55a:20a3:5ce3 with SMTP id
 r12-20020a0dec4c000000b0055a20a35ce3mr3033286ywn.3.1682970513703; Mon, 01 May
 2023 12:48:33 -0700 (PDT)
Date:   Mon,  1 May 2023 12:48:25 -0700
In-Reply-To: <20230501194825.2864150-1-sdf@google.com>
Mime-Version: 1.0
References: <20230501194825.2864150-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501194825.2864150-5-sdf@google.com>
Subject: [PATCH bpf-next v3 4/4] bpf: Document EFAULT changes for sockopt
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
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

And add examples for how to correctly handle large optlens.
This is less relevant now when we don't EFAULT anymore, but
that's still the correct thing to do.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/bpf/prog_cgroup_sockopt.rst | 57 ++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/prog_cgroup_sockopt.rst b/Documentation/bpf/prog_cgroup_sockopt.rst
index 172f957204bf..1226a94af07a 100644
--- a/Documentation/bpf/prog_cgroup_sockopt.rst
+++ b/Documentation/bpf/prog_cgroup_sockopt.rst
@@ -98,10 +98,65 @@ When the ``optval`` is greater than the ``PAGE_SIZE``, the BPF program
   indicates that the kernel should use BPF's trimmed ``optval``.
 
 When the BPF program returns with the ``optlen`` greater than
-``PAGE_SIZE``, the userspace will receive ``EFAULT`` errno.
+``PAGE_SIZE``, the userspace will receive original kernel
+buffers without any modifications that the BPF program might have
+applied.
 
 Example
 =======
 
+Recommended way to handle BPF programs is as follows:
+
+.. code-block:: c
+
+	SEC("cgroup/getsockopt")
+	int getsockopt(struct bpf_sockopt *ctx)
+	{
+		/* Custom socket option. */
+		if (ctx->level == MY_SOL && ctx->optname == MY_OPTNAME) {
+			ctx->retval = 0;
+			optval[0] = ...;
+			ctx->optlen = 1;
+			return 1;
+		}
+
+		/* Modify kernel's socket option. */
+		if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
+			ctx->retval = 0;
+			optval[0] = ...;
+			ctx->optlen = 1;
+			return 1;
+		}
+
+		/* optval larger than PAGE_SIZE use kernel's buffer. */
+		if (ctx->optlen > PAGE_SIZE)
+			ctx->optlen = 0;
+
+		return 1;
+	}
+
+	SEC("cgroup/setsockopt")
+	int setsockopt(struct bpf_sockopt *ctx)
+	{
+		/* Custom socket option. */
+		if (ctx->level == MY_SOL && ctx->optname == MY_OPTNAME) {
+			/* do something */
+			ctx->optlen = -1;
+			return 1;
+		}
+
+		/* Modify kernel's socket option. */
+		if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
+			optval[0] = ...;
+			return 1;
+		}
+
+		/* optval larger than PAGE_SIZE use kernel's buffer. */
+		if (ctx->optlen > PAGE_SIZE)
+			ctx->optlen = 0;
+
+		return 1;
+	}
+
 See ``tools/testing/selftests/bpf/progs/sockopt_sk.c`` for an example
 of BPF program that handles socket options.
-- 
2.40.1.495.gc816e09b53d-goog

