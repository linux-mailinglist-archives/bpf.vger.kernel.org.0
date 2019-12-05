Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87AAD113B58
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2019 06:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfLEFdy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Dec 2019 00:33:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36498 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfLEFdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Dec 2019 00:33:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so1039690pfd.3
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2019 21:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hD4zhv7bnCiY1PxEjyKYi1QFBGyR4qnakhfsgt8vaDA=;
        b=Hmj4dkR2patnmqhTdJw/Fjaf2lKfUA0O8CA13DviurKM/aQ/OSwPPsHrlf3WsB1oG6
         p27gLY7hMgkCXkmFG74flSkroyScGTT1e71W5KKxtQr+5khdnga4k+YH/frZWkSJc2sA
         9MG+cOc3JcDfrGzoSxulZYVUyJqAbpxSJn62XqhXnZ8N/bvk5y4V+lUlWNdQUm6A5DCc
         oxYBoX7hZuq2kQV1HeeUaIAHp7RDYBXNSGmK5jZwgjM9sn3glnAXT8VvOoujIy5WQDn/
         GNoggD7GG1yXRIgzw+Nmhg27v3qxgiYrz7eq5ReQCsmw4O2/JSAQ3qsXmQkG21meLAip
         DwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hD4zhv7bnCiY1PxEjyKYi1QFBGyR4qnakhfsgt8vaDA=;
        b=YXv3vKgKWeNPv+C5K+MP8LGJVOSbI0iF5TQ0mW8kA4/SPRJL89eGRr2M+et4SAYca1
         F3uN5UYX80oMQ2RyZP95r72apOPngJlaqm1aKsbfhdwIUvNsnZG2LXbGR8bdzBjsC9GV
         GMzVHA3SVu70rtmCyJrHcA7oYRtK5fRFNVmjZbKdAfJnF7gV9V/HINnlzS7rJZdG2aE+
         LUmOzo6PE01oa6TiZfoCUwMiqG5hQG7/UUvtI7PSsL8548QeUl+cAAyj4pu/q1PhNQID
         3m5vR8dBr1jYovBUmz1nKRaDxFbPIrrDUnA8tV/bciyHmQHzPrqplF7AtfrJkPv4pvL0
         Jb9Q==
X-Gm-Message-State: APjAAAUVtOarzxjY9jTFIYhb3vfb3lpFELsluevDoOWREaeW8gL6ZPeY
        P5rDnVaR1mlsQCyF2K4sJS8=
X-Google-Smtp-Source: APXvYqyTgSNWj4As+eJlmh9+01xI08yhxrqCulKP3rbHc/XgDWbz/hYzputdbcGq57KNXCZD6epd5w==
X-Received: by 2002:a63:450:: with SMTP id 77mr7446576pge.290.1575524033879;
        Wed, 04 Dec 2019 21:33:53 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::f3d1])
        by smtp.gmail.com with ESMTPSA id h7sm9884952pfn.43.2019.12.04.21.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 21:33:53 -0800 (PST)
Date:   Wed, 4 Dec 2019 21:33:51 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf 1/2] bpf: fix a bug when getting subprog 0 jited
 image in check_attach_btf_id
Message-ID: <20191205053349.y2jqc3kvehjj3luq@ast-mbp.dhcp.thefacebook.com>
References: <20191205010606.177712-1-yhs@fb.com>
 <20191205010606.177774-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205010606.177774-1-yhs@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 04, 2019 at 05:06:06PM -0800, Yonghong Song wrote:
> For jited bpf program, if the subprogram count is 1, i.e.,
> there is no callees in the program, prog->aux->func will be NULL
> and prog->bpf_func points to image address of the program.
> 
> If there is more than one subprogram, prog->aux->func is populated,
> and subprogram 0 can be accessed through either prog->bpf_func or
> prog->aux->func[0]. Other subprograms should be accessed through
> prog->aux->func[subprog_id].
> 
> This patch fixed a bug in check_attach_btf_id(), where
> prog->aux->func[subprog_id] is used to access any subprogram which
> caused a segfault like below:
>   [79162.619208] BUG: kernel NULL pointer dereference, address:
>   0000000000000000
>   ......
>   [79162.634255] Call Trace:
>   [79162.634974]  ? _cond_resched+0x15/0x30
>   [79162.635686]  ? kmem_cache_alloc_trace+0x162/0x220
>   [79162.636398]  ? selinux_bpf_prog_alloc+0x1f/0x60
>   [79162.637111]  bpf_prog_load+0x3de/0x690
>   [79162.637809]  __do_sys_bpf+0x105/0x1740
>   [79162.638488]  do_syscall_64+0x5b/0x180
>   [79162.639147]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   ......
> 
> Fixes: 5b92a28aae4d ("bpf: Support attaching tracing BPF program to other BPF programs")
> Reported-by: Eelco Chaudron <echaudro@redhat.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a0482e1c4a77..034ef81f935b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9636,7 +9636,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  				ret = -EINVAL;
>  				goto out;
>  			}
> -			addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
> +			if (subprog == 0)
> +				addr = (long) tgt_prog->bpf_func;
> +			else
> +				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;

That is exactly the code I had while developing, but then decided to simplify
it, since tgt_prog->aux->func[0]->bpf_func == tgt_prog->bpf_func.
Oh well.
Thanks for the fix!

