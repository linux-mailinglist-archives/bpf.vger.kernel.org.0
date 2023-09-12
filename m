Return-Path: <bpf+bounces-9835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1F79DCB5
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028C3282089
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487C9154BA;
	Tue, 12 Sep 2023 23:32:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDC1429F
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:27 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189510FF
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so70514155e9.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561545; x=1695166345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biVZEDEAYEKp2V+herIPqP7yZxpTsOL7p/iaRINkOLw=;
        b=nO6O/RfFLchSbmuq6CWirCyvS80yDDb7max4suhBLCBYRGrKOdKlrUJ7bNgO8p2n0B
         RqBWum/ZDbtRAHJ8iGXwNNufm7W4YR6ijRkepdxcY4dp8XBckB8PRpY/S21BDl96uqqa
         7he34mPNrbQO6OGBZp2XveJexL0wakHEdghlaBwdOPOMvfRuAMzv9Jlvl96PIg8T5e/E
         r07Tj48bM3J6qKQpMCLnOoxdLTgRw9q88yV6iVthTgAn5itG9IZXCCwXbRaZwwpe4Gby
         6eCn6VEHY1S80SqM6USayGJNGAXzN3IjJTUO4OpU2IttJ33Uv8GR/swbXEArQPbN7iny
         SboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561545; x=1695166345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biVZEDEAYEKp2V+herIPqP7yZxpTsOL7p/iaRINkOLw=;
        b=IbJCCnhUQrJgcF1LFC5PK0vn52u3QG6eBtMI50HCjQxzPXcl2EqzInA2bnc3Pv373c
         L5craTOr/H76AyuAf/AekhI18m2UlP74xLHRxKNE7Mg8TkkqmvQloHGP2q1tfDUFS1IE
         hC91mRSFK7XBADSbj8gxw4a18ePSPmUUurJXBCX11WGUaWIocbbag3DVN3HfFS9AsVxC
         2aC2PpOP/cE3+iIHICpw1MWmxYp3pM4km9hEONBDshFG+UP81rI0pL2q5/OF8j2o4kqG
         TS/kxSLy5nNxagU4O3eGa+3VJE3hcaQ0MU4Zr3QzfTgWi92F84Q7nibo/qzK5iI30qaA
         45BQ==
X-Gm-Message-State: AOJu0YyPxWuF4pg0qRpbYmMMpmR2FnrUkkkdRINP2908Z7OB9SqKQ/rB
	BqpTPXaoipddd/cqSYszqFl+07YQWdixhg==
X-Google-Smtp-Source: AGHT+IF/10U9we/4qPZgBYOYdt/ovJKo4QwujYWea7Vpt3e2S0TsrozE7pK8bqssM+1yK9P7BDxLBw==
X-Received: by 2002:a05:600c:108b:b0:3fe:2079:196c with SMTP id e11-20020a05600c108b00b003fe2079196cmr723023wmd.16.1694561544704;
        Tue, 12 Sep 2023 16:32:24 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id dx22-20020a170906a85600b0099d959f9536sm7547968ejb.12.2023.09.12.16.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 11/17] bpf: Detect IP == ksym.end as part of BPF program
Date: Wed, 13 Sep 2023 01:32:08 +0200
Message-ID: <20230912233214.1518551-12-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617; i=memxor@gmail.com; h=from:subject; bh=pGHbRWDKfQzSJuQ7RuVgf7MLQ6H8s585iql6KmWXG7k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSt+kbHObhSg37ORGR43DfIeHYlhc407aWY3 Tt++AHRRMKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rQAKCRBM4MiGSL8R ynKDEACnhlZp7MyNLouJrtxXegUULiCsAU0ZoQjgtnRGchFApD7pPel1sVhpr0bwD6qyNakDXPm oHwJfG6iCaUUoRea9jHbosSZt5VN0+WYpmsqYDr4XZAYCGlsL8OId+2tWMe15A9UBnN6oPh/7iL oK1vgxmDlN67l8bBiNoNOgu8nsOQwFZsc+kjqueRotwA8rfxrxatFSmVIazUdr+u7dQ6/FXKVyK rG6Q93QNf3ovhzlGuV++jV1V+ULny9/rE8RiOMd54MaI5jRvZm1sPtD5/cnXdpQY+cGd+E+yiL0 t5C2pMDZjqVPHLJCZpHVuR7SOI1XD415wQXliXq7tiBOVNx7f+Jep9Rq+4byip2EiZa/LgtpMu9 IOujkOLl19z7rubTE1EsnVFzGCMrryfOeDK9a5sagr4M+0NQgXUSPepKSK+qYs49kMjLvSpRcuM LcJLWW6+s+qDLUK1Qst7kT0nPsMx1vyrDNyukAPSOJ+UCTtgQMjoiGIyltxdtycrOeQEmPAJ0x/ nEQLmDLmsWBvPVm6xfHhYxj5zNQ/fGK5bRW16EA6tP8tq4Yjl5y4j6d/ZmDji6tVMZ7jFrJAaVZ ePxfltM6LzXiqbMuTgVDaY13pxyTiiMl+qFtwFqU1X2CWv2bAviN9ml1JQfCJyTQ/TENXqIHtFQ raJ5B2G1zjyoL/Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Now that bpf_throw kfunc is the first such call instruction that has
noreturn semantics within the verifier, this also kicks in dead code
elimination in unprecedented ways. For one, any instruction following
a bpf_throw call will never be marked as seen. Moreover, if a callchain
ends up throwing, any instructions after the call instruction to the
eventually throwing subprog in callers will also never be marked as
seen.

The tempting way to fix this would be to emit extra 'int3' instructions
which bump the jited_len of a program, and ensure that during runtime
when a program throws, we can discover its boundaries even if the call
instruction to bpf_throw (or to subprogs that always throw) is emitted
as the final instruction in the program.

An example of such a program would be this:

do_something():
	...
	r0 = 0
	exit

foo():
	r1 = 0
	call bpf_throw
	r0 = 0
	exit

bar(cond):
	if r1 != 0 goto pc+2
	call do_something
	exit
	call foo
	r0 = 0  // Never seen by verifier
	exit	//

main(ctx):
	r1 = ...
	call bar
	r0 = 0
	exit

Here, if we do end up throwing, the stacktrace would be the following:

bpf_throw
foo
bar
main

In bar, the final instruction emitted will be the call to foo, as such,
the return address will be the subsequent instruction (which the JIT
emits as int3 on x86). This will end up lying outside the jited_len of
the program, thus, when unwinding, we will fail to discover the return
address as belonging to any program and end up in a panic due to the
unreliable stack unwinding of BPF programs that we never expect.

To remedy this case, make bpf_prog_ksym_find treat IP == ksym.end as
part of the BPF program, so that is_bpf_text_address returns true when
such a case occurs, and we are able to unwind reliably when the final
instruction ends up being a call instruction.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7849b9cca749..8f921b6d6981 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -623,7 +623,11 @@ static __always_inline int bpf_tree_comp(void *key, struct latch_tree_node *n)
 
 	if (val < ksym->start)
 		return -1;
-	if (val >= ksym->end)
+	/* Ensure that we detect return addresses as part of the program, when
+	 * the final instruction is a call for a program part of the stack
+	 * trace. Therefore, do val > ksym->end instead of val >= ksym->end.
+	 */
+	if (val > ksym->end)
 		return  1;
 
 	return 0;
-- 
2.41.0


