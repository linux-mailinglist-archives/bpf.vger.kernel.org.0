Return-Path: <bpf+bounces-2035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69163727057
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EA72815D7
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D213B8A2;
	Wed,  7 Jun 2023 21:12:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C212B79
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:12:13 +0000 (UTC)
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 14:12:11 PDT
Received: from antelope.pear.relay.mailchannels.net (antelope.pear.relay.mailchannels.net [23.83.216.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E3173B
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:12:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 30ED63411BB
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:04:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B2C47340696
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:04:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686171873; a=rsa-sha256;
	cv=none;
	b=psUADU3R5oz0UiDVJ7X9UabeLAO88xtt1AYqnkBFg+YWSzwWfHIYrC3VR2q+ZHOJMLzWJ/
	JdrRUqiy76pqBZC+U0/0xUZMigoWoU8fGzxvFQm6tRBN23832CxsAhfMT1y5fHhIF7TLAs
	cPNdPynRYfWHwRc00pZSAebDJ30GHcIoDDLcOq3j7MKvxYxrLvKrJqitM4boQW8G2XfwH/
	y3tIEGjYYwPmVl/pkE8g69d6iHRBjh2VF0A3EAn89gATt5PJ38j4CaUXArbljnUifebola
	SeOK1AkcIU2u6kqg+v7IMO7SOZ3t3rPUsG7cinISXrFJNlBv5GjH5jgjwnoUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686171873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GNnQmH+wS+zURx3eyS+tueWtQk84sc6MMvTdEAlLPgk=;
	b=i6d5PtONtLMGQMbAuvpFETAKfGOEEczPydFUlSmgb2G+VN33UAApUHTf0apf7BHnDZpNp1
	w+AGNVBvivDK8wlLL3sYnq3XcYB9Ed6A5vpiwLylWwWaP+yQbbjzkkBTKQWCvXAMwc9c14
	Jcn2httvqCwlrgIP+ixsMG7LL7zpyjPRSNeSSPSaeiX/iT8SaYfKDDsYW8OGC1su6fDBF6
	cKHi6sqtYEcsnW0/KJ+Epnk9e4cbQk5kWQWzqg4OjGdi8seG6g3vGbRar5BfIsrk0Iphr+
	RwXNbO30mDzpQt3SUvaPnLwxSosDgwTnE2IgevNx2OraZBsqfSDwDyoa2rt6Ig==
ARC-Authentication-Results: i=1;
	rspamd-6f5cfd578c-jwvbw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Language-Lettuce: 097a59ff57bfa9a2_1686171873983_3414903736
X-MC-Loop-Signature: 1686171873983:1922295445
X-MC-Ingress-Time: 1686171873983
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.30.49 (trex/6.8.1);
	Wed, 07 Jun 2023 21:04:33 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4Qc0G86Y4Rzlj
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686171872;
	bh=GNnQmH+wS+zURx3eyS+tueWtQk84sc6MMvTdEAlLPgk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=S9bzB4RJPOCOTOBe1eHyTI2ybvqkq7haGr0inpIci+G56RBFJf1PH6YsHOAlTxm0N
	 qB15gt4jUq4eDHjdp9QECico3dubCY4Lmd5qPH20vn8Io3UlzN+0xHouAGzOZy41CS
	 f/BbPxLP8Ea87E2RvSCJ3ehO1sNJ1Tfml7i+ckzM=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e005f
	by kmjvbox (DragonFly Mail Agent v0.12);
	Wed, 07 Jun 2023 14:04:31 -0700
Date: Wed, 7 Jun 2023 14:04:31 -0700
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
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 2/2] bpf: ensure main program has an extable
Message-ID: <de425e99876dc6c344e1a4254894a3c81e71a2ec.1686166633.git.kjlx@templeofstupid.com>
References: <cover.1686166633.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686166633.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When bpf subprograms are in use, the main program is not jit'd after the
subprograms because jit_subprogs sets a value for prog->bpf_func upon
success.  Subsequent calls to the JIT are bypassed when this value is
non-NULL.  This leads to a situation where the main program and its
func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
has an extable.  Extables are only created during JIT.  Now there are
two nearly identical program ksym entries in the tree, but only one has
an extable.  Depending upon how the entries are placed, there's a chance
that a fault will call search_extable on the aux with the NULL entry.

Since jit_subprogs already copies state from func[0] to the main
program, include the extable pointer in this state duplication.  The
alternative is to skip adding the main program to the bpf_kallsyms
table, but that would mean adding a check for subprograms into the
middle of bpf_prog_load.

Cc: stable@vger.kernel.org
Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5871aa78d01a..d6939db9fbf9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17242,6 +17242,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
 	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
-- 
2.25.1


