Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D59557CA1C
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiGUL4y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 07:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiGUL4x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 07:56:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC310B1;
        Thu, 21 Jul 2022 04:56:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ez10so2666354ejc.13;
        Thu, 21 Jul 2022 04:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7j2Z+jKnofpzEPs1iDevvQ+YzbnWiCnAWDycqUdF6iQ=;
        b=dcl5uFXVV84GF+jVUjjhN9PWk6O2Lx7XsFzUYg7LIAH3UoyPOrkxf2TGXSRL4E3/qu
         pbK1ZbTDBJe/SREyakLZMHYOY7uZQEhdTpa0TZIcw5Jg0SBCJ+mhpwtLXQdip5IfDw+6
         sx+Q8JWz9vFajf31ILGqb3VMHd3DlacQWs0mZo05RbR2iyhCzm6KNOddJCaMyUgNqrGq
         e6XBincHb9riL9L1shsiLn16qWCmWCyg8Iw2W0cru7XAuQsa9PXK+nVtbx9qVYsPXwg0
         9AkKmAMXFPC+GPJ9qXHJTyIii/QwSpg2VQK8Ouhbdo0Wp9UuEtLGeSbTDsHV3/rL74mR
         vbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7j2Z+jKnofpzEPs1iDevvQ+YzbnWiCnAWDycqUdF6iQ=;
        b=MzvaiTLnG7zxqYjsiquHFQKJ3KjsetffKtegIiJhdu/XnSUVp6w9jIA+49vvr7J6Mo
         3kFkcViL7abReLcJRVDb4Gka/mKC78bSvuHTDFZiTT8zLD/E3kxskLXnk6w2h1mCwktN
         eWmZ69qc7we54aq4GL1MdlFB2TRrmLybEcEsjTekL3SLs0g6i90pfsJDrU8HFxHCmsQu
         E9sLfyigx5QAZaCWQ0VP31xwuTF2FMM+w6ZQOUx0g1mXGPQyxNeI/4N1JFZTvDBREj4n
         55MDAkVFUwStt6SBMSVa+DLNWXjhnOK1JTrotDUvtlZ5QrJW8ofoBurTLEhgKypQieNo
         hcFA==
X-Gm-Message-State: AJIora+dyQ22DAoOnSuwKgXLBYOBKBtyHEbatvDA1bZHvXGw+2SVCqGH
        GuLKYXNDcNn+vDHQb25Nvl0=
X-Google-Smtp-Source: AGRyM1vjT5HpONYlE/7HZlAuVQwzeUOP2y42cAc5pqI1stKZhurzqfOOjsT/ooqU1IGwqKH00XOBGQ==
X-Received: by 2002:a17:907:2d88:b0:72f:5bb:1ee0 with SMTP id gt8-20020a1709072d8800b0072f05bb1ee0mr28518359ejc.641.1658404608396;
        Thu, 21 Jul 2022 04:56:48 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id a3-20020a05640213c300b0043bbbaa323dsm900352edx.0.2022.07.21.04.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 04:56:47 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 21 Jul 2022 13:56:46 +0200
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <Ytk+/npvvDGg9pBP@krava>
References: <20220721111430.416305-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721111430.416305-1-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 21, 2022 at 12:14:30PM +0100, Lee Jones wrote:
> The documentation for find_pid() clearly states:
> 
>   "Must be called with the tasklist_lock or rcu_read_lock() held."
> 
> Presently we do neither.
> 
> In an ideal world we would wrap the in-lined call to find_vpid() along
> with get_pid_task() in the suggested rcu_read_lock() and have done.
> However, looking at get_pid_task()'s internals, it already does that
> independently, so this would lead to deadlock.

hm, we can have nested rcu_read_lock calls, right?

jirka

> 
> Instead, we'll use find_get_pid() which searches for the vpid, then
> takes a reference to it preventing early free, all within the safety
> of rcu_read_lock().  Once we have our reference we can safely make use
> of it up until the point it is put.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  kernel/bpf/syscall.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 83c7136c5788d..c20cff30581c4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>  	const struct perf_event *event;
>  	struct task_struct *task;
>  	struct file *file;
> +	struct pid *ppid;
>  	int err;
>  
>  	if (CHECK_ATTR(BPF_TASK_FD_QUERY))
> @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>  	if (attr->task_fd_query.flags != 0)
>  		return -EINVAL;
>  
> -	task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> +	ppid = find_get_pid(pid);
> +	task = get_pid_task(ppid, PIDTYPE_PID);
> +	put_pid(ppid);
>  	if (!task)
>  		return -ENOENT;
>  
> -- 
> 2.37.0.170.g444d1eabd0-goog
> 
