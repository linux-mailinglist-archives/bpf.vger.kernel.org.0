Return-Path: <bpf+bounces-2183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D552D728C40
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 02:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354521C20B37
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 00:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5717E5;
	Fri,  9 Jun 2023 00:11:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B8163
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 00:11:10 +0000 (UTC)
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8701706
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 17:11:05 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 261D45C1CE1
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 00:11:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9F5EB5C1D50
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 00:10:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686269459; a=rsa-sha256;
	cv=none;
	b=c9h1X2vizJyg+kWhdXc961LTZ+RRwHXZexLirDAilTTcVBwsVKVkFLTGAcuJA5I84PUrvO
	BKGRBfg6Rj/1LJIfUyszAEvqDtvGpqviVBFacDIgsQBSl0YeY1+0m6OncovnLa26fzEwGv
	RNdtZ3vcw8hFZ3to59VJy/5mP3ewg+g/64TUF5IJTuFBsrde7gXX7JK5KDERsMysNPamjQ
	m7yOQTq9OSlf5E5gTfCRY2U1BEPIh+J1Zkvif182xLA8EVgvHKiF5Fnpvx7272nmDkrLlT
	4N2nLS0e+2VEfubG34e9JCFoGbDbdrjqugj1pD6hKfvzamrwVUgTn7emdS41yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686269459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RLbI/q+jNwtC3CHXt0I4xW5xpj8BgznW9VU/aHNxfd0=;
	b=0DEGGbc6+xH72v5dLTCPijV4T9Kfav5eLiY15x5Yr9cscIAzcmsTbJ3lyNvvyMp7gRRBzH
	5lu81STwVWD9/AS8du9nQbM2s3Kl/4O+CeIF4h2cIhI10lD6HXMAQ5xk5K017abaPcIflA
	cZIWXF6fK6CW4doC7Y7Df8YeVF74OIGldYPjVvVOd1DT+CTR9y7wR+DH/4dICLXGKK2x2x
	m6Wa2d1FVRtT9pMRSVFZ1UILLxsAx2OSLavVRiLZE6WHX7HrKr7+ZJZwiF+1uk+gXxRosx
	qH5VsAvHlkvYqPKGs7CW40lUTfX5SM5hNvzmTHCx4FqbWEY/gJYwYNZOJl+PVQ==
ARC-Authentication-Results: i=1;
	rspamd-6f5cfd578c-c6h9m;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Thread: 04394cba36293c9d_1686269459970_2323812822
X-MC-Loop-Signature: 1686269459970:3390451124
X-MC-Ingress-Time: 1686269459970
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.163.30 (trex/6.8.1);
	Fri, 09 Jun 2023 00:10:59 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4QchLq2yfSz1m8
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686269459;
	bh=RLbI/q+jNwtC3CHXt0I4xW5xpj8BgznW9VU/aHNxfd0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ZV0VvWueE8CSb7L2iDzEP4wufwbaN5u4R5zhLLdIi03X5t1BN8Pzu1tuw3tEoZ3f8
	 77ENKM53Zmq9z1rOh4wgY5Mc22JDFdBNEvO3Tj4bqkCB60f8RfYKgcPhayh1EsGh1V
	 yyjlFVGp+pigziGilygQhjOMvqfaBlUMXHQbtyrs=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0042
	by kmjvbox (DragonFly Mail Agent v0.12);
	Thu, 08 Jun 2023 17:10:58 -0700
Date: Thu, 8 Jun 2023 17:10:58 -0700
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
Subject: [PATCH bpf v3 1/2] bpf: ensure main program has an extable
Message-ID: <d0c703a2d47d3368032c65fa70297cdcb5a16da7.1686268304.git.kjlx@templeofstupid.com>
References: <cover.1686268304.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686268304.git.kjlx@templeofstupid.com>
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


