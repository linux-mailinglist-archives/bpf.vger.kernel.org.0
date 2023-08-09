Return-Path: <bpf+bounces-7342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB66775E0A
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568A91C21130
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BBB17FFB;
	Wed,  9 Aug 2023 11:43:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C917744
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:43:36 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BFE210B
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:43:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so177195666b.0
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581408; x=1692186208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fkgAn42hNtPJ3k0142tc+x/r9LU5OQhsN2tuFGn7vo=;
        b=Tjx9tk+7OngKag2G+2BrZKmSuA2ktqxjrxjpvivx4R3ccQvKTRRtzLL853rBYqXnUN
         1WKthUV2/V8AaOTg0+q3HjpM7Vw8dz7kSxOy+G2abcDQK7Co0L1pgIJgEkTZyalNbLU4
         jS3MtEQgFKPdgd97muapoWYj+dkAYtrA+VFHhblae+mDpvib23/oVVe9KzTmx3M+XKJC
         0lZrBTAtB52zDBVLdgO/OvOmxENY7gj0lgjankbEAm9sTfKGFUTZv+PmyNClp+6pVXjQ
         f9k2aAxCGTPwNTj4c3dtgnPDIM1E+IZKcBX6DaCDBcRNVZO0S1Az0mVDpmEH+dudecpu
         rG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581408; x=1692186208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fkgAn42hNtPJ3k0142tc+x/r9LU5OQhsN2tuFGn7vo=;
        b=GUewB5jUSIq6hBu7EaVEaW0Wtr6qLMkZODWn2y3crJQQYGwW1bHk4pMJ24JT7DBwXv
         X7LkKq+b+Yu8L6Nv0PaBucsCZ+mqk+YePR84SzfrnKS3Jj+ex+Xbywf8eYZGkCdcuLsB
         1uCOnYSJTK6x8jCn/HKuzZNYtagMcnCPQ2SdeRLXgRoWIoE7CyZlaute0Cwm2iScLsrE
         Xf6m8BPvsJJm57WLVZiRsg5lqR68oIegxyAj0S/K8LJJR2UZRoXMhm6UMqgMxh8gCOQV
         OSTuowdLXaq6rRzjQuseLl2eS8bySAt29STMf8oHRus0tgaWiI67jAcNzVD7bNYxpePb
         oEnA==
X-Gm-Message-State: AOJu0YyNMkg2PoFX6IZEATHD5ZfdxYYQdi6Xg69GdEsJepjwUTZ8vkG5
	kiYHVTDDZe/4IWW/DcZ1ryDbHH4f/02LMUP5nPY=
X-Google-Smtp-Source: AGHT+IEG/DHNSvbGx/h1PSlnKx/ln77gEKtQwCiKlLZA0HLuf+q87n+6Vql68NJtuKcWWz1t0vs7ig==
X-Received: by 2002:a17:907:86a8:b0:98d:f2c9:a1eb with SMTP id qa40-20020a17090786a800b0098df2c9a1ebmr1532154ejc.24.1691581407666;
        Wed, 09 Aug 2023 04:43:27 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709067b4800b00992b66e54e9sm7805924ejo.214.2023.08.09.04.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:43:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 09/14] bpf: Detect IP == ksym.end as part of BPF program
Date: Wed,  9 Aug 2023 17:11:11 +0530
Message-ID: <20230809114116.3216687-10-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617; i=memxor@gmail.com; h=from:subject; bh=++XY7wq9bBeKTUhVWFcVuyxVIrhNp7v6Xqks8rPgVAQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rJQU3cyuG0kAPGov/+td5qxhg43JxrsZ9PV sR+KDnRsIyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yQAKCRBM4MiGSL8R ynQzD/4xNmpA958LEqi0KcFOlG5RIZh42VVtYZFv7f/OnUyPM81ys2ONyRDaf4UrzVposBK19R+ jROEUPQGdu3hPhclZT6cAIpqvzEG12H2EwWuLXNtgukbqd5KOjsPCrmErwpLcDMjQQIAmmFfNBk gOP+0ohgQxng5tAYJAJ80xLJaNWmsvX30yJy/vSQ11ZFiU1IHpeGZdrIyYIikU3fEQkWYIvO4JK /fTVXOFzEDj2OeE2flOoSH5FwLzEbf6l0zH8l7HZA2RKsnjy+5BlFdrADJCtVHRAZZDiIkp5aHo y22T4Tr2P3zW5gCoDLzhLmUgH99wZFHvOL8D59ZrjKHvlStnIswyhHTy+i+jt18ahyvxXv6CD4s hwTcc2EPaq1fcTE4hMQhLGcGg/MoXpNzvNlPOzdtic+Uqt+F4OqoR6TvijHVCeyxNxsuYb65Cne fbXXQ1hAmYdDOhb5aGGtInEcpAFcGjtqHIZfNbptLRJeaq/NO6nrql8zWr73pGhwkvV2f1pB3ob BAXWds+VXmxRZuhvbm2i8yaVDCPtV2GbYk8YlioL0bTd93HlbN0s9E7Dxrx6MS7qhm2mKQYp04a Bg4dnEAvRPRiouQu4IDTp4gHI+RtUwSdn0fDWi6x3kpt19TqgDJGSlErS9xl657loLvLpYYPVD0 Q8EqmRv9FzWjLHA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index ef362d7b09a5..08d52059655c 100644
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


