Return-Path: <bpf+bounces-16650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69F8041B3
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD441F212FA
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 22:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FE73BB23;
	Mon,  4 Dec 2023 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YT61gJFO"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81340A1
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 14:28:23 -0800 (PST)
Message-ID: <8344667a-e939-4dec-88a2-dc13d6968c71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701728900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqx2zfcPT0lUmk7iVTace0OjueyQqz3IECN0kNuesFM=;
	b=YT61gJFO1Ydol9TPMwYHZ2EJ4tigpA0nARi1A0bk4AiT5MIEf2pyUb5GOOOxw95zhM2KS+
	Lut9gUqb9piRuOT6OS+SQ+NBTNYOxwosNJbKnklOg1FPI4tpFdXB7+tYGlp8/CtFNISYJg
	mIs5QpP3oXQp61GVLpx8J0DK0lYav7M=
Date: Mon, 4 Dec 2023 14:28:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next] selftests/bpf: Test bpf_kptr_xchg stashing of
 bpf_rb_root
Content-Language: en-GB
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231204211722.571346-1-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231204211722.571346-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/4/23 4:17 PM, Dave Marchevsky wrote:
> There was some confusion amongst Meta sched_ext folks regarding whether
> stashing bpf_rb_root - the tree itself, rather than a single node - was
> supported. This patch adds a small test which demonstrates this
> functionality: a local kptr with rb_root is created, a node is created
> and added to the tree, then the tree is kptr_xchg'd into a mapval.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


