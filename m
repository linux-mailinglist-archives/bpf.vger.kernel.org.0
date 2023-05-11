Return-Path: <bpf+bounces-358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A366FF80F
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 19:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802691C20F66
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B198F5C;
	Thu, 11 May 2023 17:05:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB88F55
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 17:05:13 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AE68699
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:05:05 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643fdfb437aso30339458b3a.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683824705; x=1686416705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/pyPNy9qZZ+kH0++6rFd1D1h7SDPYk2nW4BjP//A1I=;
        b=6Xa+J3edzFx0h/D2C1oQR+xRlqr1GUBKGrT6pxDvtLNLF0a2LHLn4d0HwmRLHoRQ7a
         7olgmObrIGwcnc0wIsHWbS/LmPUmN4bs1ht87THUb6qaXOSG6uLwRB8502YMjvyemBd/
         yubgJnGNHEZelMCeUgk2zM6fRA5VIuasAHTtPO+d/KWR8CdCbpIMHu5uvrPJb9TCrHhC
         IZKsQgoDsQRsCHxZLZPkqgzmtCQnUgs1ROCjiyNs0Ci5+ubytzHvVr8/dfkNnrggCcRs
         O98TWX6KBmhsGAbkf+42NT2Nlm+a2f3532M+aRgDhhJdC+dzIQBbwPSwZ6jpTplvMmvm
         N+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824705; x=1686416705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/pyPNy9qZZ+kH0++6rFd1D1h7SDPYk2nW4BjP//A1I=;
        b=jBIz/BVdu3rd0ksUSp9qHiyKg+28UWQpJXUdINmuA73Xo6bCC0BL+CaGn+XccVtsxl
         FBzv/rSfjO/yels4GxnmREkWE2grUkP2DceGFpBkAOfkmoapiV5vFqfZnsY0wCAl6Y1d
         CsY+bb89uiE8yl5f/oj1eh4uRSiMYZOc6bujGvEhhx2M4cpyHiUTGGJXEEENugQIcdxZ
         McAjI2n3g/fV7ZtgqOTnklyIwthmSaqQjNAaDq0f1xRHN42JjJGY48QKNFcwsNldS3BX
         O5vTaylXM72eoV3Y6/ekx2vI04g8kESIh5MuKgOmhMUPSE60YyYAk62LVqkwM5VfX03J
         poQg==
X-Gm-Message-State: AC+VfDwDDqbW+eLnjFxXkoDp9oxc4aWYYFAzWZAU69J9rFOy62PcLxvD
	pZhUHbaadFi/dVCbDfOZsHR3Eblzbqd6I5w+y6Ef4YAwJ7QPQkyvCHj8AAVQagchyeaGcgLkBaz
	pr1YtoCvc8Eq5KFnZijQr8qVCbnY4gHLrCCTm31+yKrrr3aVe5Q==
X-Google-Smtp-Source: ACHHUZ7V07H394cIlaTn6fUmDC+Yi3AkoK4RRxLKeR9H7oLbX0eEsNO7D5H2ptWbGkBJENAZVp+k0lA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2591:b0:1a9:9a18:3465 with SMTP id
 jb17-20020a170903259100b001a99a183465mr8025991plb.0.1683824705339; Thu, 11
 May 2023 10:05:05 -0700 (PDT)
Date: Thu, 11 May 2023 10:04:56 -0700
In-Reply-To: <20230511170456.1759459-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511170456.1759459-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511170456.1759459-5-sdf@google.com>
Subject: [PATCH bpf-next v6 4/4] bpf: Document EFAULT changes for sockopt
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


