Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC18629934
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 13:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiKOMuF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 07:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiKOMt7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 07:49:59 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C627DEB
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 04:49:58 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ouvNz-0007AB-19; Tue, 15 Nov 2022 13:49:55 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ouvNy-00095U-RH; Tue, 15 Nov 2022 13:49:54 +0100
Subject: Re: [RFC bpf-next] bpf: Fix perf bpf event and audit prog id logging
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20221115095043.1249776-1-jolsa@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4d91b1d3-3ffc-11f9-50a6-bfb503e4b3cd@iogearbox.net>
Date:   Tue, 15 Nov 2022 13:49:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221115095043.1249776-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26721/Tue Nov 15 09:54:13 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15/22 10:50 AM, Jiri Olsa wrote:
> hi,
> perf_event_bpf_event and bpf_audit_prog calls currently report zero
> program id for unload path.
> 
> It's because of the [1] change moved those audit calls into work queue
> and they are executed after the id is zeroed in bpf_prog_free_id.
> 
> I originally made a change that added 'id_audit' field to struct
> bpf_prog, which would be initialized as id, untouched and used
> in audit callbacks.
> 
> Then I realized we might actually not need to zero prog->aux->id
> in bpf_prog_free_id. It seems to be called just once on release
> paths. Tests seems ok with that.
> 
> thoughts?
> 
> thanks,
> jirka
> 
> 
> [1] d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
> ---
>   kernel/bpf/syscall.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index fdbae52f463f..426529355c29 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1991,7 +1991,6 @@ void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
>   		__acquire(&prog_idr_lock);
>   
>   	idr_remove(&prog_idr, prog->aux->id);
> -	prog->aux->id = 0;

This would trigger a race when offloaded progs are used, see also ad8ad79f4f60 ("bpf:
offload: free program id when device disappears"). __bpf_prog_offload_destroy() calls
it, and my read is that later bpf_prog_free_id() then hits the early !prog->aux->id
return path. Is there a reason for irq context to not defer the bpf_prog_free_id()?

>   	if (do_idr_lock)
>   		spin_unlock_irqrestore(&prog_idr_lock, flags);
> 

