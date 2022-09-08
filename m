Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9A5B15BF
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 09:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIHHff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 03:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiIHHfe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 03:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B642B442D;
        Thu,  8 Sep 2022 00:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E363661B53;
        Thu,  8 Sep 2022 07:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85081C433D6;
        Thu,  8 Sep 2022 07:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662622532;
        bh=myFJHXYjylDbYqIz67EITWqaRTZwH+KbFTWFLPlfzHo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=rWSxQRj9NIxwyjwIuwvIl8vk6rh0HO0v9Un8qVwQb2Mjb9i3M1dBBlrDEGJdKzLju
         fUECPIfqKlf79D3qC3DfzNDh23UNWQLrM4EMxgZD16KLrq2SV7LkyUG0r6R+VXWSHT
         WdQF9Bcyr2+liLSTs3pLe19n4Z0olvO4Pk29pCWvBeyNf4mMKSNxiQT4QJ1vNwKPIT
         CAZRDpcJb2a1MPBo4QPIHnwcSzbmLu3clK7K3rFBDKOgI+dNlB+6OE+5ZnKbYRCIDA
         vDb8gNfd0Rr2lDPX83BJw9Pq7v/m0CgB9OgJrZY+idMEpA3Tjy3yHDHX6hc88zpSyF
         6NZp5BLTI4DrA==
Date:   Thu, 8 Sep 2022 08:35:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <YxmbPqKZMEXHL6sI@google.com>
References: <20220809134752.1488608-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220809134752.1488608-1-lee@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 09 Aug 2022, Lee Jones wrote:

> The documentation for find_vpid() clearly states:
> 
>   "Must be called with the tasklist_lock or rcu_read_lock() held."
> 
> Presently we do neither.
> 
> Let's use find_get_pid() which searches for the vpid, then takes a
> reference to it preventing early free, all within the safety of
> rcu_read_lock().  Once we have our reference we can safely make use of
> it up until the point it is put.
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
> Cc: bpf@vger.kernel.org
> Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> 
> v1 => v2:
>   * Commit log update - description - no code differences
> 
> v2 => v3:
>   * Commit log update - spelling of find_vpid() - no code differences

Did anyone get a chance to look at this please?

Would you like a [RESEND]?

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

-- 
Lee Jones [李琼斯]
