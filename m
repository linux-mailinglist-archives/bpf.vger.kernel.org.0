Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6536F7211
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjEDSoC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 14:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjEDSoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 14:44:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4DD59CF
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 11:43:59 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e43240e9fso420387a91.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683225839; x=1685817839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/pyPNy9qZZ+kH0++6rFd1D1h7SDPYk2nW4BjP//A1I=;
        b=sC0owlFiUjnLcKPMXNrM2pYBtCGGPvSgjBG/xjQ+GfNlmfPYDfDrPzBgSIJ1XaMp/I
         VnlGC5ACKzFZGeD7Pby52uOm2oYKkckBoYgjOvt9nQftubzSQVwEcmWxeTr0OVUDgHp+
         ERe4wSmJk8HgjqmvPvIw5DvuNtagbmZK5gva8zsNBKL1VC84C01v/LRkeZ9Q96fOLFQn
         d6F1TZpiYEPO4C5o/BbwCFjD7PTkCVUHyiRhDGr6B0t1y57BX+NdmPyUZEqLoo/sesFm
         IUU9EvvTTx6BiLvp/WqvIoWcsxJk1gEtGdyGoDVPaFhf9SWTiayCrJZJ8jFxR03gZDbR
         xMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683225839; x=1685817839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/pyPNy9qZZ+kH0++6rFd1D1h7SDPYk2nW4BjP//A1I=;
        b=HgmDVwnB9BUVFhulfP8mpbjqGL7GFa3kNrEispX5NwpL19hP17QaS1mQaW5E6S2hZM
         39gKMqX+1Pm7/gZVyIn6OdpD5pmFWDkzNF89sLWdTvL0v4LhxKe5G4ufCOo+5oFP+iPY
         09o7v1idlnv/a/csDymbWG1cDDp085dtSaQFygJ0vux6pphfxGSWgcO7mlH490NIcEly
         rh7QEhVesvAA07FfCpEuVb5sXACwTwfjt9VBhpYLKCfx1YExS32sLIMsb1L/DyC3BfyS
         otVxwXEKbCenRTeLQDcggaDWpcbzcDT4mcHaRzMT6xDc9A9SQLOXu7jz2cz+XTSc/Ri5
         6Cjw==
X-Gm-Message-State: AC+VfDxoBynA16hbiKjkDEjPJNWhhcj7eztoWo04q07NT25KdoruWD41
        8iKmrLEdCOIIxwr9lfXBZ0/6OLPX/BRgdy6ehKtQ88sAJD5jpJEgYOJym5WaqoMgR5W/VcdNbVw
        ha9VBaWyuWT5ycImAHmG4UKYul9D+NlIrJs3WfefRr15ripl3lg==
X-Google-Smtp-Source: ACHHUZ7Hp0/aLE8D9BrUB75ZhFQ3KfTk9Y9P9m4Y1Vru0DKwQCMfjoiTphLmg9r+GSCJTfT0fZ3VTa4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:540f:b0:24e:5627:d64b with SMTP id
 z15-20020a17090a540f00b0024e5627d64bmr847412pjh.9.1683225838987; Thu, 04 May
 2023 11:43:58 -0700 (PDT)
Date:   Thu,  4 May 2023 11:43:49 -0700
In-Reply-To: <20230504184349.3632259-1-sdf@google.com>
Mime-Version: 1.0
References: <20230504184349.3632259-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230504184349.3632259-5-sdf@google.com>
Subject: [PATCH bpf-next v4 4/4] bpf: Document EFAULT changes for sockopt
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
2.40.1.521.gf1e218fcd8-goog

