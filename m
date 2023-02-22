Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043AF69FC44
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 20:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjBVTc1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 14:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjBVTcY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 14:32:24 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1AF3866C;
        Wed, 22 Feb 2023 11:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=n2evbcI2A45UiF4hbABDHJ6HIpVOFNtdMmtvzAPpHBk=; b=kRDlTAVsiaTS9fCNWZAXMWc1oC
        9vl4kyIX+1YNRAcYizMfdVFYH5ers8MK0cA0qbr7WWzxvKokMxq5IRhEM0mLFm/VPAy8we2zujbCE
        xJzv4+1PI9uCaQSmBdoiz00nEDMw4mPB+QsaoPi2PT2b7zWaCQ662KubAcw6CSx+BFzTej6PtPs5v
        8sl2oGUdUECMsU0r+xuLMsxKe4PY4pYBKttZUzw/Q/N5sEqSZmWWSB+jKgbyuUuBhYFeRjULmPHEB
        PUe0dK59Wwf2PKfesjkqh/Gr+8jEU14gxtuZJcEWuCKaFv3gGWNfufiULizf3YUl1MQNvJ+3NFwiy
        8OHBR9vA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pUupn-0007uo-UR; Wed, 22 Feb 2023 20:31:23 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pUupn-000RFI-Eq; Wed, 22 Feb 2023 20:31:23 +0100
Subject: Re: [PATCH] bpf: Fix undeclared function 'barrier_nospec' warning
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c1242eff-baf2-7f46-b7a7-667f973b04a7@iogearbox.net>
Date:   Wed, 22 Feb 2023 20:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26820/Wed Feb 22 09:30:58 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/22/23 9:24 AM, Viresh Kumar wrote:
> Add the missing header for architectures that don't define
> the barrier_nospec() macro. The nospec.h header is added after the
> inclusion of barrier.h to avoid redefining the macro for architectures
> that already define barrier_nospec() in their respective barrier.h
> headers.
> 
> Fixes: 74e19ef0ff80 ("uaccess: Add speculation barrier to copy_from_user()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Linus's master branch fails currently to build for arm64 without this commit.
> 
>   kernel/bpf/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 933869983e2a..92aeb388e422 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -38,6 +38,8 @@
>   #include <linux/memcontrol.h>
>   
>   #include <asm/barrier.h>
> +#include <linux/nospec.h>
> +

nit: The asm/barrier.h include could have just been removed. linux/nospec.h
internally includes asm/barrier.h already.

>   #include <asm/unaligned.h>
>   
>   /* Registers */
> 

