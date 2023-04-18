Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298736E6FB2
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 00:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDRWx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 18:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDRWx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 18:53:57 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731D7EC9
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:56 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-517bad1b8c5so2361241a12.0
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681858436; x=1684450436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAn2JH1Lq9QcR8BANXfaTRPPTo1GcUOEnDLU+00WzxU=;
        b=pXfRJNUD38spNQt20L203si3D+0fZHgVA2J5I7QUqaR9vlqTpo1ujhOMw+B72sVIwq
         s8RWuAMvRpPvlsGuahtkHU8G/bNwGb9m078XHCUXCOg0jXhq1S8WpXePD4sBcAwDKKdr
         nKR79ATxwU8a9IO1LNvBlKn5nCJwlZ7F8LMicrRgW0XSpzrcYPX1O06zpfhCxCNQ1Rn/
         2meyyDupsr/MLZ9EqPSvzEl7NKLXArIrd/CiNjIYNn+2d//2fBId0ORWrLoYpAEWMNn9
         GdMt5GQHqMjIkHdEB1SdM7miF+uk3J5Nf8hq134TsC6wDeWL46+q6n8sTrLW4Y/a8d84
         k1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858436; x=1684450436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAn2JH1Lq9QcR8BANXfaTRPPTo1GcUOEnDLU+00WzxU=;
        b=F9sknQqqq43gLl3TS2SjdQzzMTe24Cc9/8MO0pcb0trtQ0IitGeeufVo4F+NjWnKVg
         cRokXfnV/MtVMA3Vzv17c9vbjl8nCUeC4kyEjQ5HWFqHpuPGVB6tK4l2V8m9kNmvYokU
         vrALOmiuvNNFykEZsnJgKuPG8x6PNUjKErF8iS7Ue0+IPMHMW+ZXiFMKuNY33dY3oa0L
         Bzms7sfZL8k8ClCtwLKdztQk8/2BL8Sg9RDlVfsovwUqDgG+QAKQBGwLKwpKWSKb2z71
         QmBJIc/V9doJsyabcVP6s+Ww9q3u1ICKUThdoABE+JB/dl278CLqx5x2riMp/OQ0fviy
         85ig==
X-Gm-Message-State: AAQBX9d2shOL9nFkYO2dcSC038fPoAxd78q3of+OeFz21nevr9S2asbH
        giu3cvlwTCWrjHayG0NC99zy/RZLXwzmKb5SM1YCGPXmx3VWFCxSqDbTORuMWM2yfER9lrmq2U6
        H33za6Q7oBRaNagLh6kO2XOhC1jkUSCX0o7ngTFFd8q+UUjfQwQ==
X-Google-Smtp-Source: AKy350Zk9RzxEo3bdYu6f/wBCXydxjTq2MnevrgmpGBtDmme/IjcbxtyqMf4A/yPhekxAi43JOdyM/Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:1b56:0:b0:51b:aee8:7ae9 with SMTP id
 b22-20020a631b56000000b0051baee87ae9mr1078756pgm.12.1681858436095; Tue, 18
 Apr 2023 15:53:56 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:53:43 -0700
In-Reply-To: <20230418225343.553806-1-sdf@google.com>
Mime-Version: 1.0
References: <20230418225343.553806-1-sdf@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418225343.553806-7-sdf@google.com>
Subject: [PATCH bpf-next 6/6] bpf: Document EFAULT changes for sockopt
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
 Documentation/bpf/prog_cgroup_sockopt.rst | 64 +++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/prog_cgroup_sockopt.rst b/Documentation/bpf/prog_cgroup_sockopt.rst
index 172f957204bf..dcb8d4681257 100644
--- a/Documentation/bpf/prog_cgroup_sockopt.rst
+++ b/Documentation/bpf/prog_cgroup_sockopt.rst
@@ -29,7 +29,7 @@ chain finish (i.e. kernel ``setsockopt`` handling will *not* be executed).
 
 Note, that ``optlen`` can not be increased beyond the user-supplied
 value. It can only be decreased or set to -1. Any other value will
-trigger ``EFAULT``.
+ignore the BPF program's changes to ``optlen``/``optval``.
 
 Return Type
 -----------
@@ -45,13 +45,14 @@ sockopt. The BPF hook can observe ``optval``, ``optlen`` and ``retval``
 if it's interested in whatever kernel has returned. BPF hook can override
 the values above, adjust ``optlen`` and reset ``retval`` to 0. If ``optlen``
 has been increased above initial ``getsockopt`` value (i.e. userspace
-buffer is too small), ``EFAULT`` is returned.
+buffer is too small), BPF program's ``optlen`` and ``optval`` are
+ignored.
 
 This hook has access to the cgroup and socket local storage.
 
 Note, that the only acceptable value to set to ``retval`` is 0 and the
 original value that the kernel returned. Any other value will trigger
-``EFAULT``.
+ignore BPF program's changes.
 
 Return Type
 -----------
@@ -98,10 +99,65 @@ When the ``optval`` is greater than the ``PAGE_SIZE``, the BPF program
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
+```
+SEC("cgroup/getsockopt")
+int getsockopt(struct bpf_sockopt *ctx)
+{
+	/* Custom socket option. */
+	if (ctx->level == MY_SOL && ctx->optname == MY_OPTNAME) {
+		ctx->retval = 0;
+		optval[0] = ...;
+		ctx->optlen = 1;
+		return 1;
+	}
+
+	/* Modify kernel's socket option. */
+	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
+		ctx->retval = 0;
+		optval[0] = ...;
+		ctx->optlen = 1;
+		return 1;
+	}
+
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+
+	return 1;
+}
+
+SEC("cgroup/setsockopt")
+int setsockopt(struct bpf_sockopt *ctx)
+{
+	/* Custom socket option. */
+	if (ctx->level == MY_SOL && ctx->optname == MY_OPTNAME) {
+		/* do something */
+		ctx->optlen = -1;
+		return 1;
+	}
+
+	/* Modify kernel's socket option. */
+	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
+		optval[0] = ...;
+		return 1;
+	}
+
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > 4096)
+		ctx->optlen = 0;
+
+	return 1;
+}
+```
+
 See ``tools/testing/selftests/bpf/progs/sockopt_sk.c`` for an example
 of BPF program that handles socket options.
-- 
2.40.0.634.g4ca3ef3211-goog

