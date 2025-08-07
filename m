Return-Path: <bpf+bounces-65224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DCCB1DC7A
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2693F56460A
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6E626E6F1;
	Thu,  7 Aug 2025 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sDwP1c/I"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB6199FB0
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587975; cv=none; b=I70gbANBpCNSUsN5hL22+B1hSwV6W2V8idXqzWvIdn0PIJ0WLF2G9UQ3/KmleJdhNexzuK+FMKYIfCRy7HZoKmQppFPMs17i2o2h+rU1yk0A9pLS2KPxGsIHq5RvS54g8FZ/trxe4P9qKk953jRz6OXVB59taMjumr9sDRM3Gz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587975; c=relaxed/simple;
	bh=QuH8GceveWdfU4PoJeVHSeg1WJpUaCGKZqwJCRzCJxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arOYXh9KFae9UdYalUFyKBITSlQ1HHCtSJu6hQtPr/OaXH2qtYTy75mPfK1J7j4nn3hK1zloQe7ZY/3ncFW++GL3hMROXX/cNLGgdH7vKlRUeFktQhPAhuUQ/ygYoNIlt+sz0NYIW3qufMglB/MFXOeClAVD5veLHLEDo9S1QA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sDwP1c/I; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <32abd47f-0b8e-4fff-9844-9770c4b11d38@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754587971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vDEMnL+3gm71xDcSDgz/RwdC9cLHzDOBedjkd64HJU=;
	b=sDwP1c/IpuYXJwtU0w9vfj57SX+9Q/huwdMlCrEr7C1XFC2oLmkg6SRakDlSAKViE0PVsS
	Q6T1W137kO3pQ7OOlSkY3qikbuGHdvghht3EsZqBG91lBs8egSYleDAj+Zm/rUBG8heJUq
	6Y70Hbs+2pEQPFFX661eJtRssg/bZno=
Date: Thu, 7 Aug 2025 10:32:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: fix memory leak in SCC management
Content-Language: en-GB
To: Dmitry Antipov <dmantipov@yandex.ru>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org
References: <20250807123433.7868-1-dmantipov@yandex.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250807123433.7868-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/7/25 5:34 AM, Dmitry Antipov wrote:
> Running with CONFIG_DEBUG_KMEMLEAK enabled, I've noticed a few memory
> leaks reported as follows:
>
> unreferenced object 0xffff8881ce3bd080 (size 64):
>    comm "systemd", pid 3524, jiffies 4294789711
>    hex dump (first 32 bytes):
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 8c5ed7af):
>      __kmalloc_node_track_caller_noprof+0x25e/0x4e0
>      krealloc_noprof+0xe8/0x2f0
>      kvrealloc_noprof+0x65/0xe0
>      do_check+0x3ef1/0xcd10
>      do_check_common+0x1631/0x2110
>      bpf_check+0x3686/0x1e430
>      bpf_prog_load+0xda2/0x13f0
>      __sys_bpf+0x374/0x5b0
>      __x64_sys_bpf+0x7c/0x90
>      do_syscall_64+0x8a/0x220
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Wnen an array of SCC slots is allocated in 'compute_scc()', 'scc_cnt' of
> the corresponding environment should be adjusted to match the size of this
> array. Otherwise an array members (re)assigned in 'scc_visit_alloc()' will
> be unreachable from the freeing loop in 'free_states()'.
>
> Fixes: c9e31900b54c ("bpf: propagate read/precision marks over state graph backedges")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This one has been fixed in
   https://lore.kernel.org/all/20250801232330.1800436-1-eddyz87@gmail.com/

> ---
>   kernel/bpf/verifier.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0806295945e4..c4f69a9e9af6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23114,6 +23114,8 @@ static void free_states(struct bpf_verifier_env *env)
>   
>   	for (i = 0; i < env->scc_cnt; ++i) {
>   		info = env->scc_info[i];
> +		if (!info)
> +			continue;
>   		for (j = 0; j < info->num_visits; j++)
>   			free_backedges(&info->visits[j]);
>   		kvfree(info);
> @@ -24554,6 +24556,7 @@ static int compute_scc(struct bpf_verifier_env *env)
>   		err = -ENOMEM;
>   		goto exit;
>   	}
> +	env->scc_cnt = next_scc_id;
>   exit:
>   	kvfree(stack);
>   	kvfree(pre);


