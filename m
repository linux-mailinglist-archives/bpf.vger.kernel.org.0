Return-Path: <bpf+bounces-7343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9867A775E0B
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527682819AE
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBEB18002;
	Wed,  9 Aug 2023 11:43:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1AA17744
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:43:42 +0000 (UTC)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBB210B
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:43:39 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so11107045e87.3
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581417; x=1692186217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOpe+KLiU31oQSG0sOAigLOphpYYwxqbP41P4lMfoBc=;
        b=AGLf4ylofyoM4yOwItvDDzFBw1dZyVNt0w0Z8iHJ+JjhE1HuzvmrXRKnR1foBQHbR8
         zGvcn3Ifn50q68gMSdh3T8zz1ddfx7BaGsLh0+E5U6vWYxHHopE55EMArFsDAWaJlrot
         x9CgLamhOsqsnY8zS2bOYMDryzjGqBDglW3Qmi78YwsLFDldQ0O5G7vnUkQlEtka4zt4
         8rT9zHSisPPCSOI1KdbcI2XD+kZIMZ9dkUlwo2F+6Pg4PUsYSHFpNeeA0J6jAsOCk/cC
         YLEoYCFwqzw2qDmUESxgijBL0IeOkS6rFRbLQItp6Lncgq+dud1avMewB7BEfyw+sG8J
         lnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581417; x=1692186217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOpe+KLiU31oQSG0sOAigLOphpYYwxqbP41P4lMfoBc=;
        b=CQuasDnL1vBJOsmArVasYg5CSj8rEaG+JOn31w3Jmvh4Fm5XT9vnWF/oy+dWXDoHQR
         A50EVZNcGnuf39kXvfQm3En5CKoWh7+959e1OWKDtMANBOXz7ZJ4fSE2ZXUczJFsm/Uk
         0INR8I6Es9YzxevpGYqjRQa+lNDUquVI24i7uptxFpXVEgFy31aWpOegnK9B4OvEILfB
         kcU0dj1K+UhU4i3riolinhCaFdqiFXxfnZjlcq89K0DGiiGVC9LekR+SDyh/Y2UEoqzl
         kHru8oU4vGk2gSX0nBHi3wxxbyEYvbRenQ1wIfjk6qFdIuuimvNMexeaKjs+daWaVjBM
         WlkA==
X-Gm-Message-State: AOJu0Yz+Ai7PW6TpR0DaNrsSWr4QoP5g1eVxiKd5VagesFBOq7XhbIPK
	4w3uNrKjfXxyZ2GP24xbaUwoX2z8ydeIfk1xReE=
X-Google-Smtp-Source: AGHT+IG3nMZD7OKoFLJhAwBnGv+G8AAYQQyB6pUwVlNUdBg2GoMAvukpDC8l7drgwKcfmyJSA6wz1Q==
X-Received: by 2002:a19:6507:0:b0:4fb:8939:d95c with SMTP id z7-20020a196507000000b004fb8939d95cmr1513259lfb.30.1691581416947;
        Wed, 09 Aug 2023 04:43:36 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id e14-20020a056402104e00b005227e53cec2sm7837421edu.50.2023.08.09.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:43:36 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 10/14] bpf: Disallow extensions to exception callbacks
Date: Wed,  9 Aug 2023 17:11:12 +0530
Message-ID: <20230809114116.3216687-11-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2960; i=memxor@gmail.com; h=from:subject; bh=+FH1ASLYTMFo7b517rED6jaPFYVZ8DbNm8TQbKjCl1M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rJMJpVmU7EL/Wi42Nihq4WoWMPM7rR7Q0P+ u7A3iWL9/yJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yQAKCRBM4MiGSL8R yptaD/9UyuPKlxGAIUOsl3H4wo9pWdQ7qDbeqhXJh6rf4jeezcrHyTOr+gj0Dr3fXCjVIioc8lQ gcZnFhoiNfci4I0UlRbpUUS5mwxKcYiom8Icv6yDKfko/xWvjP5CQu0c6xyPe6/Gr7LQfdy2EyP kJbVg7fqHw9JRoeqHBFY1VhmgieGG6zcpwZz7oD1+j+EM6YG74dKizXFz+1GvTRRJFsjHOr6+AT StQlAr0UlMdI58jkZvLYxcLaC7lPc1ZPYgkSjn0G3Ltn/psgFyskQwUGEeQ4QRb4nJqktvQO4nd N3SLVcIn/GOFs3wkbqnxoNwjZqw8E7B7UQgMl0QZaMvxIlIZobtE8QVGCyfAPC3kBq3DXbVgfwb BW9FWmXaNZkDpz4ask/IIab/YtclIzhv0uuHCLYbz6qpOidZId0UOKkWrEKXeoPLq+3FDOuYpia hPyniDSIuUGNetDhe9FzC6wNqe1WT4tB73cWOLFHkCI5DJ4Is5Uht1lJ8H/fq+fgc0M0W8isk3g CgQZFoAp/kEbNci74Ufhz1Oxm7aF9woQt5C+wlV8YH+IjoePUYG1mcQrcYbXERSHBpnw7qA3UMq Xg4Kjj0AVxY1ZLZgOxD0yy5zZXnCHlYg5uI3c9cT1Pq+m5YZJNp326W3Yme+q7sjpSasQbMEA98 dSvVTlI0/WAjVyQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

During testing, it was discovered that extensions to exception callbacks
had no checks, upon running a testcase, the kernel ended up running off
the end of a program having final call as bpf_throw, and hitting int3
instructions.

The reason is that while the default exception callback would have reset
the stack frame to return back to the main program's caller, the
replacing extension program will simply return back to bpf_throw, which
will instead return back to the program and the program will continue
execution, now in an undefined state where anything could happen.

The way to support extensions to an exception callback would be to mark
the BPF_PROG_TYPE_EXT main subprog as an exception_cb, and prevent it
from calling bpf_throw. This would make the JIT produce a prologue that
restores saved registers and reset the stack frame. But let's not do
that until there is a concrete use case for this, and simply disallow
this for now.

One key point here to note is that currently X86_TAIL_CALL_OFFSET didn't
require any modifications, even though we emit instructions before the
corresponding endbr64 instruction. This is because we ensure that a main
subprog never serves as an exception callback, and therefore the
exception callback (which will be a global subprog) can never serve as
the tail call target, eliminating any discrepancies. However, once we
support a BPF_PROG_TYPE_EXT to also act as an exception callback, it
will end up requiring change to the tail call offset to account for the
extra instructions. For simplicitly, tail calls could be disabled for
such targets.

Noting the above, it appears better to wait for a concrete use case
before choosing to permit extension programs to replace exception
callbacks.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  | 1 +
 kernel/bpf/verifier.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 64a07232c58f..a04eff53354c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2470,6 +2470,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	 */
 	kasan_unpoison_task_stack_below((void *)ctx.sp);
 	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
+	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
 __diag_pop();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0e1a1d1f5d3..13db1fa4163c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19622,6 +19622,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension programs should be JITed\n");
 				return -EINVAL;
 			}
+			if (aux->func && aux->func[subprog]->aux->exception_cb) {
+				bpf_log(log,
+					"Extension programs cannot replace exception callback\n");
+				return -EINVAL;
+			}
 		}
 		if (!tgt_prog->jited) {
 			bpf_log(log, "Can attach to only JITed progs\n");
-- 
2.41.0


