Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA536EADF4
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 17:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjDUPYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 11:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDUPYY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 11:24:24 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC1E57
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=tdlOy7is+MFsIJaqmbGWlprWGKTrOKMgO1yt7DQMqB8=; b=cjMubpCcLJXMSlqsUpHK+uPGnj
        PVKB+GPhKvrXkUoRjg+HoLZdkoNwDKWLn7MWiL6Oci/eUCdd4V8GZFHgNRPA3uk2L/MWE0WphmR/M
        XfwDl3ra3uxWnyaFx1KeIlS+Onc3l0khIh72LjzdtqM5DSILQmPkPYhxx92sk6Z/hOFW56bZofYGn
        7LmskBOP1QHJiPpoqWEJF4f/ACEliUsKtAlfo/mxSbakJN01nZhBnF3g7gNCl/0MmHVr61i0WpQL7
        8O0Cy6nGEf/SeyRfxIMIm2RrakMGjo3BaG/RlY1SYIexMIyqtF9+2CBjSvKN8k9h7Z1JFd4r1FC+k
        5o6EUr5Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ppscW-0001gr-Qn; Fri, 21 Apr 2023 17:24:20 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ppscW-000BoL-Dp; Fri, 21 Apr 2023 17:24:20 +0200
Subject: Re: [PATCH bpf-next 3/6] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230418225343.553806-1-sdf@google.com>
 <20230418225343.553806-4-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4a2e1b70-9055-f5d9-c286-3e5760f06811@iogearbox.net>
Date:   Fri, 21 Apr 2023 17:24:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230418225343.553806-4-sdf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26883/Fri Apr 21 09:25:39 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/19/23 12:53 AM, Stanislav Fomichev wrote:
> Over time, we've found out several special socket option cases which need
> special treatment. And if BPF program doesn't handle them correctly, this
> might EFAULT perfectly valid {g,s}setsockopt calls.
> 
> The intention of the EFAULT was to make it apparent to the
> developers that the program is doing something wrong.
> However, this inadvertently might affect production workloads
> with the BPF programs that are not too careful.

Took in the first two for now. It would be good if the commit description
in here could have more details for posterity given this is too vague.

> Let's try to minimize the chance of BPF program screwing up userspace
> by ignoring the output of those BPF programs (instead of returning
> EFAULT to the userspace). pr_info_ratelimited those cases to
> the dmesg to help with figuring out what's going wrong.
> 
> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   kernel/bpf/cgroup.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index a06e118a9be5..af4d20864fb4 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1826,7 +1826,9 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>   		ret = 1;
>   	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
>   		/* optlen is out of bounds */
> -		ret = -EFAULT;
> +		pr_info_ratelimited(
> +			"bpf setsockopt returned unexpected optlen=%d (max_optlen=%d)\n",
> +			ctx.optlen, max_optlen);

Does it help any regular user if this log message is seen? I kind of doubt it a bit,
it might create more confusion if log gets spammed with it, imo.

>   	} else {
>   		/* optlen within bounds, run kernel handler */
>   		ret = 0;
> @@ -1922,7 +1924,9 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>   		goto out;
>   
>   	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
> -		ret = -EFAULT;
> +		pr_info_ratelimited(
> +			"bpf getsockopt returned unexpected optlen=%d (max_optlen=%d)\n",
> +			ctx.optlen, max_optlen);
>   		goto out;
>   	}
>   
> 

