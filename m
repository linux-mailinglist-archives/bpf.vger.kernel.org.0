Return-Path: <bpf+bounces-351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C56FF697
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0B4281832
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB16363A3;
	Thu, 11 May 2023 15:57:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571D613B
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 15:57:53 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7E840E4
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 08:57:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba2d0b391d3so11211585276.2
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683820672; x=1686412672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/pyPNy9qZZ+kH0++6rFd1D1h7SDPYk2nW4BjP//A1I=;
        b=pgm/3civrevUYpU/KFDdajU9IIsKus2s553qkydi8MKFJyZq7jacMwlrDhU6l8G+L/
         Spnl/hAw1bMqIXKqniXrHLDdZg8cy4I9mjbIuIiRFAlxID79t+9Wlp+nYpyE7lOPzZlO
         GT7BdDzeEKcdCFw5SVDFl3Gf/fiaSVcd0ixUbX8lG53ps+PV5mJl3fA1QTw/tvGsfN1p
         aJJUyobNczJy1pqsIAOC/nce3IyzNgQps2QlndLvYOXfTau8Qj6bvi4uvBIAj05HkaIw
         PSPXzW21owRyQXKCQ8/kJ8XInvRftjgyis0PYs0cMwRk4Wc6LMO8JoWYEgKjpk7rQKoB
         JB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683820672; x=1686412672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/pyPNy9qZZ+kH0++6rFd1D1h7SDPYk2nW4BjP//A1I=;
        b=YS018vsKPxJUOp+PWTNeQUKCfro5J86KbtxevbuZGJz5CXwU0TPbdDKqo7PmPfSWRk
         G/j2hfU9rMjv4SsmDYmlK1TLcKlZaBx4Gy7w+bZLz0wNAW3bLiWjgN5fYl3/B0jF/E0N
         Xc8pBr4LafCATl9I2+FTF870ta4bruXrOuKlQtZ4r3dYq1hBa5cOHfb2OEfxp11XRqvz
         IhztgVCOSCqcO+3698UimoTmalobM7VSXLSaR1n6aVER8KAHaACxyHjrw0tMzOXQC5a/
         1HGZa8FJraT27BSAk+1bCXtMaAa9vp3yn9plW2eEYUfFFWSqKW4fedy7O8tdUdx2dIap
         DTtA==
X-Gm-Message-State: AC+VfDxXtET8iPfEBgFc7Je5j3DSEZt7EzHiMafxqTOZ5UypYqlKCM+E
	1o965UmjZa7jUE6xtwtwRz9eFlLJoGYOvJe/vYbVFDwLrevFdaqWJ8zzgE3y6DkDOkZz3IjI1V6
	ZmqOFIsVDSPXUdSw4+2MlMBKIRqpknRdBwni7VdyLRq8GUeuPLA==
X-Google-Smtp-Source: ACHHUZ4Wx+lgthJVPUBgyCz2JuK2/covIwQqoMqteHyLGcmpvQFBpBtFv4O4Gt6KU0iydh7qmIQwaMY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:5f48:0:b0:b9e:6346:514b with SMTP id
 h8-20020a255f48000000b00b9e6346514bmr13230815ybm.4.1683820671762; Thu, 11 May
 2023 08:57:51 -0700 (PDT)
Date: Thu, 11 May 2023 08:57:40 -0700
In-Reply-To: <20230511155740.902548-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511155740.902548-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511155740.902548-6-sdf@google.com>
Subject: [PATCH bpf-next v5 4/4] bpf: Document EFAULT changes for sockopt
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


