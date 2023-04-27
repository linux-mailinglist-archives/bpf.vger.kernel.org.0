Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3710B6F0CD2
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbjD0UEV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbjD0UEU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:04:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAD6359D
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1a6ce2cdb92so94179265ad.3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682625858; x=1685217858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMnXpbgbJK1tBOJAoq/xoB1rsubwxMbquh5P5alNzmc=;
        b=TYCZVhO8l5KX+hdFxEqPhRF19ppZw/OJm39lYR02LqzsWXABLtj2ycjcjcFYzOn6j2
         +7MLYv+EOCJurAyrHlGCAEDRmUbVjUGWhMPI6MIzfT0hLm8NaZ/wiLJcdyuOaKUxnT4o
         Y4i+58CcH9jiqJcEKascr+JEcMClpoxqvsh919lbzVe21QCqf+muCA7AGzqM8CZYWJBF
         N46E5/uCC2tXXrTZ5nB1LZ8ZC2tsc3bgXeUHtnYj96UBllbTZa3SqzzlZ19tHpQ/qrcA
         oxj/FjYatPd39ztPV/oWTLrHan+p3shPLAD+efrrvHed6AA3KCBxRTXw8CwB9E5hLvW9
         vKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682625858; x=1685217858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMnXpbgbJK1tBOJAoq/xoB1rsubwxMbquh5P5alNzmc=;
        b=BzXnIMH3pqggWwKKSIaZISlmyRZg/JIh/ijGIzYjYn+NgY15ZBqtIo6QyvbGQi0dE6
         dsX/ygppUV8fAhue9rR0fYJYZZ8H4ITuvpO/7FbcSZhRoPhq24q2A5mAaqIe/Zoy4r+e
         rlD58tah7erzIqjq3iiDVJHYT+VO1O4CZU3vM93sIWeMdUTyp3xrXm9PR6Sh02xX/7EO
         RoIjyjrXevgQKnat8vgZi09tXXzjwZXaDOFjTKOHc0Z0xtP+xdn7KBt6KJp8WhaCKpFW
         KKsBUSC1qqSnL4ZHPKjgV4gBxK8cRPFn7ZgzfUvIOlJjvV312fgUoyq4E4Y4WGplPhMS
         4hCA==
X-Gm-Message-State: AC+VfDyPiEhZ5B36DmIljkJOSi+HKdgRm0Gw48rOSpKyfqKBfBlI8IMc
        GNDNQ8DqY7U3xpBaKu+uCBa2zsA6w0ax7eLlj2hfZ9VSqfYfuyFI7yw0rraPZqAFbWXLqWFIqCG
        KciDq5sUm1r7YdSaERPbzv7ItFpj5ulkGaVYcufU1BzHAXN3U0A==
X-Google-Smtp-Source: ACHHUZ5W2eLi7BDwgpawpryx/Qpq9b8AU5fn/GtZrMe9hNUy6xcDXq3IDm0e/g8am2CnAvrUq089DHM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:190:b0:1a2:185a:cd6 with SMTP id
 z16-20020a170903019000b001a2185a0cd6mr891091plg.4.1682625858076; Thu, 27 Apr
 2023 13:04:18 -0700 (PDT)
Date:   Thu, 27 Apr 2023 13:04:09 -0700
In-Reply-To: <20230427200409.1785263-1-sdf@google.com>
Mime-Version: 1.0
References: <20230427200409.1785263-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427200409.1785263-5-sdf@google.com>
Subject: [PATCH bpf-next v2 4/4] bpf: Document EFAULT changes for sockopt
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
index 172f957204bf..d5cca25135b6 100644
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
+		if (ctx->optlen > 4096)
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
+		if (ctx->optlen > 4096)
+			ctx->optlen = 0;
+
+		return 1;
+	}
+
 See ``tools/testing/selftests/bpf/progs/sockopt_sk.c`` for an example
 of BPF program that handles socket options.
-- 
2.40.1.495.gc816e09b53d-goog

