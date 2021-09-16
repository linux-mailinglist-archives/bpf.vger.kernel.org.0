Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE79240D8E8
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 13:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhIPLhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 07:37:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:45364 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbhIPLhs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Sep 2021 07:37:48 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mQpgo-000BFV-6M; Thu, 16 Sep 2021 13:36:26 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mQpgn-000FX7-Tu; Thu, 16 Sep 2021 13:36:25 +0200
Subject: Re: Patch "bpf: Fix off-by-one in tail call count limiting" has been
 added to the 5.14-stable tree
To:     Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        johan.almbladh@anyfinetworks.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
References: <20210916113154.692945-1-sashal@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ad8a98b3-29fc-fb43-9a0f-d1ead5af6c81@iogearbox.net>
Date:   Thu, 16 Sep 2021 13:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210916113154.692945-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26296/Thu Sep 16 10:23:58 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Sasha,

On 9/16/21 1:31 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      bpf: Fix off-by-one in tail call count limiting
> 
> to the 5.14-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       bpf-fix-off-by-one-in-tail-call-count-limiting.patch
> and it can be found in the queue-5.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> commit 0af0fa0371eb376731a350bfdd8687e7ec206bb9
> Author: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Date:   Wed Jul 28 18:47:41 2021 +0200
> 
>      bpf: Fix off-by-one in tail call count limiting
>      
>      [ Upstream commit b61a28cf11d61f512172e673b8f8c4a6c789b425 ]

Please either drop this commit from stable queues, or also queue its revert as
well (in case you don't have a filter in place, and there's a chance this could
get re-queued again in future by accident):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9dabe016b63c9629e152bf876c126c29de223cb

>      Before, the interpreter allowed up to MAX_TAIL_CALL_CNT + 1 tail calls.
>      Now precisely MAX_TAIL_CALL_CNT is allowed, which is in line with the
>      behavior of the x86 JITs.
>      
>      Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
>      Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>      Acked-by: Yonghong Song <yhs@fb.com>
>      Link: https://lore.kernel.org/bpf/20210728164741.350370-1-johan.almbladh@anyfinetworks.com
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0a28a8095d3e..82af6279992d 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1564,7 +1564,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   
>   		if (unlikely(index >= array->map.max_entries))
>   			goto out;
> -		if (unlikely(tail_call_cnt > MAX_TAIL_CALL_CNT))
> +		if (unlikely(tail_call_cnt >= MAX_TAIL_CALL_CNT))
>   			goto out;
>   
>   		tail_call_cnt++;
> 

Thanks,
Daniel
