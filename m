Return-Path: <bpf+bounces-78228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E995D04AD1
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 18:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA8DF365435C
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A0443024;
	Thu,  8 Jan 2026 14:19:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE040F8F3;
	Thu,  8 Jan 2026 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881949; cv=none; b=mC03oytCuq9ldHHzwefLQ+GnyBIVtre3qX1hw6me+VmgbtqQlHpVgT4Z6UNZ3tFU9lve+/fE3It3Udo3RyQiI16kNz0XqfapDFijxjsW5R+l7oB3M3a+vuDXzv0WrkpzM0rML8HfMfmRwAVNg3X4e1+W+CAp77PMBqTa8OmN20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881949; c=relaxed/simple;
	bh=BepAi8AeO4+ixlelyuqSBWK9uM4+csWfw4z51yePc58=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a4bpf2E5NQTWuY5Jc2tGMII8o+cuhHxUEHjpVq61H7Re2ACwop+ohbHu9Fvh2TKSD/8deURnLmGynb2CGWVixNvbcQDrrFTKSpYNPY6FZHl4RJsKNslca9F3/woPH9MI1BHXRDCHCV/YR3vNm3N2sNmG9EWBuFqJ2vcKZaFTy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 608EIsPZ043558;
	Thu, 8 Jan 2026 23:18:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 608EIs3R043554
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 8 Jan 2026 23:18:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1db0fa14-af3b-47e6-93dc-0adffaa3d934@I-love.SAKURA.ne.jp>
Date: Thu, 8 Jan 2026 23:18:54 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix reference count leak in bpf_prog_test_run_xdp()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <af090e53-9d9b-4412-8acb-957733b3975c@I-love.SAKURA.ne.jp>
 <87qzs02ofv.fsf@toke.dk>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87qzs02ofv.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/01/08 23:01, Toke Høiland-Jørgensen wrote:
> Hmm, this will end up call bpf_ctx_finish() in the error path, which I'm
> not sure we want?

Excuse me, but I don't think bpf_ctx_finish() will be called, for

+out_put_dev:
 	/* We convert the xdp_buff back to an xdp_md before checking the return
 	 * code so the reference count of any held netdevice will be decremented
 	 * even if the test run failed.
 	 */
 	xdp_convert_buff_to_md(&xdp, ctx);
 	if (ret) // <== ret was set to non-0 value immediately before the "goto out_put_dev;" line.
 		goto out;
 
 	size = xdp.data_end - xdp.data_meta + sinfo->xdp_frags_size;
 	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, sinfo, size, sinfo->xdp_frags_size,
 			      retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, ctx,
 				     sizeof(struct xdp_md));

> 
> Could we just move the xdp_convert_md_to_buff() call to after the frags
> have been copied? Not sure there's technically any dependency there,
> even though it does look a little off?

Unless

	xdp_md->data = xdp->data - xdp->data_meta;
	xdp_md->data_end = xdp->data_end - xdp->data_meta;

in xdp_convert_buff_to_md() lines do something bad for the error path,
I think this change will be safe.


