Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E772D1A57
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 21:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgLGUME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 15:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLGUME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 15:12:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EECBC061749;
        Mon,  7 Dec 2020 12:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=AzQdQH/N4S5LuRIFI8YYIJtAGFK4/kjv9ZrabkrtxIQ=; b=NU/Ubsec8MCyxXI/U9NW2N43RG
        1kzImbaagnRF5NtFv5LOyNOLesIp6oafYMRqlKFYrk7AYMh+T/a0DVfhC9+d7abI73bfAJysOwO6D
        2E56Ni4Tfffn188DS8/p+0jBvKuwfterKYyRd9D0QKOxFmRzYJU+zVDFu6pDxtv7T+o9P4nKnootY
        O15W0orSpYiiGV3eFkSMXoG8WC9JPqCgy2WHvwURB9YA7DLiOlc8TkLS6GwSYifOwOyZC/bhZYmZy
        oMgp8sUEtMEv57wcsMNsFlQ95GlGCBm5XarbPeYfMejoo6ycYZvyflwPqvlwYkppxfcK06cHLc2AZ
        /4Uq66PQ==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmMqv-0005CW-4X; Mon, 07 Dec 2020 20:11:21 +0000
Subject: Re: [PATCH bpf-next v2] bpf: Only call sock_from_file with CONFIG_NET
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201207200605.650192-1-revest@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <85e90d44-6577-c208-9732-c16d540e22a5@infradead.org>
Date:   Mon, 7 Dec 2020 12:11:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207200605.650192-1-revest@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/20 12:06 PM, Florent Revest wrote:
> This avoids
>   ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
>   bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
> When compiling a kernel with BPF and without NET.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

> ---
>  kernel/trace/bpf_trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0cf0a6331482..29ec2b3b1cc4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1272,7 +1272,11 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
>  
>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>  {
> +#ifdef CONFIG_NET
>  	return (unsigned long) sock_from_file(file);
> +#else
> +	return 0;
> +#endif
>  }
>  
>  BTF_ID_LIST(bpf_sock_from_file_btf_ids)
> 


-- 
~Randy

