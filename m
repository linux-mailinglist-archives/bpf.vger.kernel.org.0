Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF02EBC69
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2019 04:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfKADeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Oct 2019 23:34:50 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48802 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfKADeu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Oct 2019 23:34:50 -0400
Received: by mail-pg1-f202.google.com with SMTP id w13so6022291pge.15
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2019 20:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=unmgH0OiSy3jDJ6az+b/xInzZdYuHgLlqgn4pre13TA=;
        b=cydZe1owe05ISb5LJ/dCm3khNLU0GVAJ9uUDWLvpNLLc6hQfTpx7nns7zcTApAU8J0
         RTh6Y1Ra3mVzHmVxTLo0VcTZfvqmTWvDlv4cEyyq96PvcJF8vXdZXC2qBEwBi5oZ0Uq8
         udTtrsLj4OalXZ22tOE+CQC9HhgyK4dYmzPhK+v6w+n/XsMg3qVeKEpMFevIU1cmN2fQ
         ke4jqk3R/2jYo66D8jrFdFChreyQoC9dw8SbdbtHxffqzB+aDUuouLC4BuSHl0WMOJke
         4YwTihxJDl5RsfnPBS2J2g7nfjARX5OLiMR3So+TBiNfs+zlcfQaRoumsl7gQj6FQG9F
         5deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=unmgH0OiSy3jDJ6az+b/xInzZdYuHgLlqgn4pre13TA=;
        b=SXN2LT5xizzMKw2kLn3KGsKGiV+UpGqUW0ry+A4SZukAMu6vVfsgSvePshkRG+dvnM
         Rkg7R9saB2e5hxxuS/c8grYopy8t2Ewtu7JV8Moek8jPzxmdizfj3uXT3mKxeyPm5PTD
         mOy2Rvk9yBCYPbd9XcoEIFFJd4FsTLv25465nh3dn2T3pHwR/Bt+WE9G4C9D/Q7bmip0
         Yc4mZtpGijBtBl0wFV99ltm7jCRLMcYjeErQJ9uIqe5RRe9TNG425Go+xwavrhcYn4zf
         LsNFQjmFVpwLPW2eOlsrJk0IElTCC+XybRG5k40iW/nzrdAa70nLekCzDDKYVZYsM82p
         kfqA==
X-Gm-Message-State: APjAAAU+6HLCSY6coU6GkSsO9NCRLzaiMEjDDqGQ+rn8WsRT6/x8DziA
        +f+2lzgzb6gRa8IQWVAtjHK1xxPjT1CB1A==
X-Google-Smtp-Source: APXvYqxMwhIpgSPCGWaDzlp0xMzKAy0b4vaUJpHskEPwTvMaVqc15ftDiZfFQlXA9zR1CBYNtiSyLE1mU5RzMA==
X-Received: by 2002:a63:7015:: with SMTP id l21mr9992972pgc.200.1572579287290;
 Thu, 31 Oct 2019 20:34:47 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:34:44 -0700
Message-Id: <20191101033444.143741-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH net] powerpc/bpf: fix tail call implementation
From:   Eric Dumazet <edumazet@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have seen many crashes on powerpc hosts while loading bpf programs.

The problem here is that bpf_int_jit_compile() does a first pass
to compute the program length.

Then it allocates memory to store the generated program and
calls bpf_jit_build_body() a second time (and a third time
later)

What I have observed is that the second bpf_jit_build_body()
could end up using few more words than expected.

If bpf_jit_binary_alloc() put the space for the program
at the end of the allocated page, we then write on
a non mapped memory.

It appears that bpf_jit_emit_tail_call() calls
bpf_jit_emit_common_epilogue() while ctx->seen might not
be stable.

Only after the second pass we can be sure ctx->seen wont be changed.

Trying to avoid a second pass seems quite complex and probably
not worth it.

Fixes: ce0761419faef ("powerpc/bpf: Implement support for tail calls")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
---
 arch/powerpc/net/bpf_jit_comp64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 02a59946a78af46416e9d949047ad3fefe3fc159..be3517ef0574d0911f6d63b530b33954c8ca343d 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1141,6 +1141,19 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		goto out_addrs;
 	}
 
+	/*
+	 * If we have seen a tail call, we need a second pass.
+	 * This is because bpf_jit_emit_common_epilogue() is called
+	 * from bpf_jit_emit_tail_call() with a not yet stable ctx->seen.
+	 */
+	if (cgctx.seen & SEEN_TAILCALL) {
+		cgctx.idx = 0;
+		if (bpf_jit_build_body(fp, 0, &cgctx, addrs, false)) {
+			fp = org_fp;
+			goto out_addrs;
+		}
+	}
+
 	/*
 	 * Pretend to build prologue, given the features we've seen.  This will
 	 * update ctgtx.idx as it pretends to output instructions, then we can
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

