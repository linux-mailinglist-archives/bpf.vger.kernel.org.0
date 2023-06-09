Return-Path: <bpf+bounces-2271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E272A571
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9C01C2115A
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1845D23417;
	Fri,  9 Jun 2023 21:40:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E80408E0
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:40:13 +0000 (UTC)
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F73A80
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:40:11 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A273B42967
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:40:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1B46B41D90
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:40:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686346809; a=rsa-sha256;
	cv=none;
	b=NN0J/Ia2OiKk1gR7GQBuemrczOk0Tmkir//reHjytKNdpBoL89TDeudwIF7nyjfQZm/p6w
	LCLLK7YHq44F1YuTFua/HfKKRcku5j4cmA2CxhDMEIin8uYslz6PdaUfb9zoTON08i1Sap
	L9EAXfsODpj9+o63D6P5CKOuDjjGMiAqTtpmDMx6eQ/tYxCT/XVLcGWyOOAozZQjLu+17R
	n/u7l21fwGebJVH5Rm+fBaQcoTdshFBHbgfEJWOnCEIVmfFJWV2uwFZel/FycXWszO3yEc
	y+9iA4B3Kp0N1H/WEjNwcP1+SJ5NgKgDq1b1aHQ6OdKAbFGLIb/3Ww/jZSJTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686346809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=u6VFkU8CeRSXxG9CpKygUWaCfdMHq1wUPGyeNaB+TlE=;
	b=aLp3q0miw2oMbCKqpGuSAQy3Qkp832keXHDTOx2U5Taa/tZi+VMiurA7hambOHPbwix+5/
	4uDjVEsb+xEXms1NZuegxEfaOChsj73sJcuqJdiNXdI7gktHfwKX+j0492yn9Wo9JiaSdQ
	yRawN75DYgF3kdttZ44/O7jA8c0Bgz12SeTA5YMesHmvxFL3tBU+VPQxOhxzbwZxnKzcdg
	PsEyy3kfNy+M0HHkvgE5I7LoLung9PEg/lBUsCCsQRCjohyp9RNh1UbiIp7pdkpmX+BIoK
	VlrIiPwW3zsDbV69f+1kVPKaAazoQfd0HgVEqn5kdtZL6xMkiIILPc4/i7V0Mg==
ARC-Authentication-Results: i=1;
	rspamd-7c78575475-t5tnd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Turn-Spot: 1d15a96e3783d39a_1686346810490_1701988873
X-MC-Loop-Signature: 1686346810490:1513712278
X-MC-Ingress-Time: 1686346810490
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.48.103 (trex/6.8.1);
	Fri, 09 Jun 2023 21:40:10 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4QdDyJ611ZzRG
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686346808;
	bh=u6VFkU8CeRSXxG9CpKygUWaCfdMHq1wUPGyeNaB+TlE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=QsiYEL0kWz0Vg4dpqakHu1f++lQpIiR15twBL0XHHlFWLWW1js6m7dubqPCVWtD/a
	 BfekR5k/2B1i7DaNj8jogY7UTN8Jg12cPrKzrJ1YcaEb/L4BxpmkdzZ0ODevVjCutB
	 luF2kGOfqxyWCxitlqdZUhB+OUUeJUgtE2EXvEqA=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00d9
	by kmjvbox (DragonFly Mail Agent v0.12);
	Fri, 09 Jun 2023 14:40:07 -0700
Date: Fri, 9 Jun 2023 14:40:07 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 1/2] bpf: ensure main program has an extable
Message-ID: <9253ce691956f19adc93be7dc4c3a7aabe3db3de.1686345886.git.kjlx@templeofstupid.com>
References: <cover.1686345886.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686345886.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When subprograms are in use, the main program is not jit'd after the
subprograms because jit_subprogs sets a value for prog->bpf_func upon
success.  Subsequent calls to the JIT are bypassed when this value is
non-NULL.  This leads to a situation where the main program and its
func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
has an extable.  Extables are only created during JIT.  Now there are
two nearly identical program ksym entries in the tree, but only one has
an extable.  Depending upon how the entries are placed, there's a chance
that a fault will call search_extable on the aux with the NULL entry.

Since jit_subprogs already copies state from func[0] to the main
program, include the extable pointer in this state duplication.
Additionally, ensure that the copy of the main program in func[0] is not
added to the bpf_prog_kallsyms table. Instead, let the main program get
added later in bpf_prog_load().  This ensures there is only a single
copy of the main program in the kallsyms table, and that its tag matches
the tag observed by tooling like bpftool.

Cc: stable@vger.kernel.org
Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5871aa78d01a..b62d1fc0f92b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17214,9 +17214,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	}
 
 	/* finally lock prog and jit images for all functions and
-	 * populate kallsysm
+	 * populate kallsysm. Begin at the first subprogram, since
+	 * bpf_prog_load will add the kallsyms for the main program.
 	 */
-	for (i = 0; i < env->subprog_cnt; i++) {
+	for (i = 1; i < env->subprog_cnt; i++) {
 		bpf_prog_lock_ro(func[i]);
 		bpf_prog_kallsyms_add(func[i]);
 	}
@@ -17242,6 +17243,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
 	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
-- 
2.25.1


