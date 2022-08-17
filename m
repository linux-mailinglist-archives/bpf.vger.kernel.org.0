Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE95979A5
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiHQWa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 18:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242250AbiHQWa2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 18:30:28 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE88A0613
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 15:30:27 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oORYQ-000Bra-4v; Thu, 18 Aug 2022 00:30:26 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oORYP-0005Le-MP; Thu, 18 Aug 2022 00:30:25 +0200
Subject: Re: [PATCH bpf 2/2] bpf: Add WARN_ON for recursive prog_run
 invocation
To:     YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jason Zhang <jdz@google.com>, Jann Horn <jannh@google.com>,
        mvle@us.ibm.com, zohar@linux.ibm.com, tyxu.uiuc@gmail.com,
        security@kernel.org
References: <20220816205517.682470-1-zhuyifei@google.com>
 <20220816205517.682470-2-zhuyifei@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cd514394-7712-ee0d-5c85-c6c7f62cec8e@iogearbox.net>
Date:   Thu, 18 Aug 2022 00:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220816205517.682470-2-zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26630/Wed Aug 17 09:53:39 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/16/22 10:55 PM, YiFei Zhu wrote:
> Recursive invocation should not happen after commit 86f44fcec22c
> ("bpf: Disallow bpf programs call prog_run command."), unlike what
> is suggested in the comment. The only way to I can see this
> condition trigger is if userspace fetches an fd of a kernel-loaded
> lskel and attempt to race the kernel to execute that lskel... which
> also shouldn't happen under normal circumstances.
> 
> To make this "should never happen" explicit, clarify this in the
> comment and add a WARN_ON.
> 
> Fixes: 86f44fcec22c ("bpf: Disallow bpf programs call prog_run command.")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>   kernel/bpf/syscall.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 27760627370d..9cac9402c0bf 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5119,8 +5119,8 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
>   
>   		run_ctx.bpf_cookie = 0;
>   		run_ctx.saved_run_ctx = NULL;
> -		if (!__bpf_prog_enter_sleepable(prog, &run_ctx)) {
> -			/* recursion detected */
> +		if (WARN_ON(!__bpf_prog_enter_sleepable(prog, &run_ctx))) {
> +			/* recursion detected, should never happen */

Pushed out commit 1/2, thanks! I think this one causes more confusion than value,
imho, for example in your commit log you state that it could trigger when attempting
to race, in the comment you state "should never happen". Which one is it? Also, if
we can recover gracefully in this case, what should the user do with the warn (I
guess worst case warn_on_once), but still?

Thanks,
Daniel
