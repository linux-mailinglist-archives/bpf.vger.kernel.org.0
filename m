Return-Path: <bpf+bounces-6639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA176C0BA
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 01:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4617C1C210F0
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 23:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6688125A0;
	Tue,  1 Aug 2023 23:18:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98E440C
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 23:18:04 +0000 (UTC)
Received: from out-106.mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CFC19B6
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 16:17:59 -0700 (PDT)
Message-ID: <97511804-ea81-67aa-3120-92415b0be5df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690931874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiOZong6Dayf6SOaF5LtkcSVSZUjJaHR5JnKR3+5N+U=;
	b=eMTpIwTORTb3Uwb/YfLrffCT6bjOFSPsU+3ej5MpXFLdcmMHai+w2nnDfuZh7a0hQUpa7K
	rEmXJTf3d2jeIcKQBYBA8u49UPRsDdImKzPC6HD+GVDEH/mIV5Q2OfDaMd+s9MRAyMOVrz
	8rU/eyMJQYFQNkEO8PL4Yq0V0VvQOX0=
Date: Tue, 1 Aug 2023 16:17:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf_sk_cgroup_id is not available in tracepoints
Content-Language: en-US
To: Ivan Babrou <ivan@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <kafai@fb.com>
References: <CABWYdi1KERLa9dOK8mxxdNvT746R8adFHxuN53VMvWMS=yyq_w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CABWYdi1KERLa9dOK8mxxdNvT746R8adFHxuN53VMvWMS=yyq_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/23 2:59 PM, Ivan Babrou wrote:
> I noticed that bpf_sk_cgroup_id is not available in a tracepoint (it
> is only available in cgroup related skb filters), even though I can
> easily do what it does manually:
> 
> u64 cgroup_id = sk->sk_cgrp_data.cgroup->kn->id;
> 
> It seems to me that bpf_sk_cgroup_id and similar functions should be
> added to bpf_base_func_proto (unless there's a better place).

This will make it available to all tracing progs. How to ensure doing 
'sk->sk_cgrp_data.cgroup->kn->id' is safe in all traceable context? so please 
don't do that.

bpf will handle the exception when the bpf prog reads 'sk->...' (eg. in case sk 
is an invalid ptr), so please keep using it for tracing programs.


