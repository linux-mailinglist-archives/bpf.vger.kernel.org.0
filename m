Return-Path: <bpf+bounces-60485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C172AD7722
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2E37ACFC5
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7262BD5A8;
	Thu, 12 Jun 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAYplWd8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709818FC91;
	Thu, 12 Jun 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743614; cv=none; b=UAS16/lxYv+a982DdXH3DHTCtqnAei1aRK3gKB6v5KDh7/t96DVA47aMoypL5XVDRXEql8v+bQqf7y+6rDflCnQ1Ll1lWKUdGzDfMbbKihT4Es93/ja42hz8GW0W6IFjIkpKwX0j/qtTBm7m+IT5F0kGQAw/OpTlqR+50pvOehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743614; c=relaxed/simple;
	bh=oJd9zlLqq+yGzcYCfQLO7Zx+Kd3Fc5whC5ZgR/zQbhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQyJb6WhVZf7pAXx7SqEb+IGJtfSfIdEzeWoxenJDM45UIZro91pbSsOSqRc+6fKoICYNAvsD0Ra0AfAq3paABu1VmmxxsyeqKXozLX7ipAESMhccnXZ1nAco693KO7GwM5TMwuLsrKCB1CoGIOjtC2fcjX/fRw7vMkN2JDSmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAYplWd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C369C4CEEA;
	Thu, 12 Jun 2025 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749743613;
	bh=oJd9zlLqq+yGzcYCfQLO7Zx+Kd3Fc5whC5ZgR/zQbhE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZAYplWd8EO10I6lKieJ2IK+172cR4sYjSUdunAyFL+3KIp8x4a8e88BjlTxL7ogsU
	 nniAAbZ9lQtShuBoenvzSrwA4N0bblX45PZrj5zCS7xkPkOvUS4WRV5GDTXMfDtDn7
	 JP/MKRudGD/uStsdBtb5I7ZxKPXTma9Q33GG6uAQlSg0QiTN3TZOvVCtFoPfK3nolJ
	 oFsNKJ6ujjYu/WTytmhBi6OBuLaOH+fzNGIiJKcOTTBErrG5iofM1DGiwTPydax0R1
	 XOD+KRmEQ7TtxUBW1xVOTMnqAOQLgocqCIazFzigzT8xskPYB2RaW5cr75A5u07Mxh
	 gfUwT3HQllD6g==
Message-ID: <f73a08e2-7793-447a-b7be-07909aa80425@kernel.org>
Date: Thu, 12 Jun 2025 17:53:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdp: tracing: Hide some xdp events under
 CONFIG_BPF_SYSCALL
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller\"" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20250612101612.3d4509cc@batman.local.home>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250612101612.3d4509cc@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2025 16.16, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The events xdp_cpumap_kthread, xdp_cpumap_enqueue and xdp_devmap_xmit are
> only called when CONFIG_BPF_SYSCALL is defined.  As each event can take up
> to 5K regardless if they are used or not, it's best not to define them
> when they are not used. Add #ifdef around these events when they are not
> used.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Note, I will be adding code soon that will make unused events cause a waring.
> 
>   include/trace/events/xdp.h | 2 ++
>   1 file changed, 2 insertions(+)

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
> index 0fe0893c2567..18c0ac514fcb 100644
> --- a/include/trace/events/xdp.h
> +++ b/include/trace/events/xdp.h
> @@ -168,6 +168,7 @@ DEFINE_EVENT(xdp_redirect_template, xdp_redirect_err,
>   #define _trace_xdp_redirect_map_err(dev, xdp, to, map_type, map_id, index, err) \
>   	 trace_xdp_redirect_err(dev, xdp, to, err, map_type, map_id, index)
>   
> +#ifdef CONFIG_BPF_SYSCALL
>   TRACE_EVENT(xdp_cpumap_kthread,
>   
>   	TP_PROTO(int map_id, unsigned int processed,  unsigned int drops,
> @@ -281,6 +282,7 @@ TRACE_EVENT(xdp_devmap_xmit,
>   		  __entry->sent, __entry->drops,
>   		  __entry->err)
>   );
> +#endif /* CONFIG_BPF_SYSCALL */
>   
>   /* Expect users already include <net/xdp.h>, but not xdp_priv.h */
>   #include <net/xdp_priv.h>

