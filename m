Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA643A57F
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 23:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhJYVLW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 17:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhJYVLV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 17:11:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491EC061767
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 14:08:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v20so8789499plo.7
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=poLGG9S+mf5XQ/yz4q57CrTw5wKhA6/+9va9QkjuAvg=;
        b=a0ZVOQhPb030zLbcmC9f4zSVxc0zTc6ElOubuzQwisrkF6vA7Zzgg2w+5d1eHi5oz5
         DhF3soqW3IPQwH0ga0vF9zPp4eJ6Xhg8luXinN7ypGwUAA/emUHJoyb+lMwZQDfAMFuh
         IYoCojDm1v82gvLyOdRsOd0z96c5DPkHcgYIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=poLGG9S+mf5XQ/yz4q57CrTw5wKhA6/+9va9QkjuAvg=;
        b=yISqwVYHTQR8ipUYAUBk3hyJhejVX6bwRKMwk0PJFYX3ANWpgSIv2YhfL/uCa0hnRz
         71O0nopkOb0VhBpZm8fq22MhUq2xVkFhcHQ07Y/RDnO7kduLtZ/ZqYuFwusy6/I0OS/u
         c/ERL4GG9DjH0vC5VSdYTHUMgRQ0FHdGceLVMHoF5IeRG7F3VdO3a4Ds9rTzZRjTckuE
         PBEioXUJH9MhtkLOumpX2BKI0jE0vYvkGbBlPVAkqnauRpLvNJkyKUEB/LuTqYpo2A7F
         ediRrKTHaeevs3xzuNDiIkH+/qu/JpKrheTbtaVwGOavx+1YIiuuj79osTgBslYMyY18
         8Qmw==
X-Gm-Message-State: AOAM533GVYgI+q2vQEyFTBLfTNmoa1XFzUuhrGluVaGxdUcxrdG2mNIZ
        r9yhRT2agi0oGUBv0AnxhD76mA==
X-Google-Smtp-Source: ABdhPJxIbyBEZZU8qon/3sXF/Ha0M7vmc/NXiFfHSLsaGzp0MdqqweQ+YxlPpa2ydt+gluSp4zi30w==
X-Received: by 2002:a17:90a:af93:: with SMTP id w19mr39184637pjq.10.1635196138400;
        Mon, 25 Oct 2021 14:08:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h19sm22908045pfv.81.2021.10.25.14.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:08:58 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:08:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
        pmladek@suse.com, peterz@infradead.org, viro@zeniv.linux.org.uk,
        valentin.schneider@arm.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v6 02/12] fs/exec: make __get_task_comm always get a nul
 terminated string
Message-ID: <202110251408.2E661E70BC@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-3-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:05AM +0000, Yafang Shao wrote:
> If the dest buffer size is smaller than sizeof(tsk->comm), the buffer
> will be without null ternimator, that may cause problem. We can make sure
> the buffer size not smaller than comm at the callsite to avoid that
> problem, but there may be callsite that we can't easily change.
> 
> Using strscpy_pad() instead of strncpy() in __get_task_comm() can make
> the string always nul ternimated.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  fs/exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 404156b5b314..bf2a7a91eeea 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1209,7 +1209,8 @@ static int unshare_sighand(struct task_struct *me)
>  char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
>  {
>  	task_lock(tsk);
> -	strncpy(buf, tsk->comm, buf_size);
> +	/* The copied value is always null terminated */

This may could say "always NUL terminated and zero-padded"

> +	strscpy_pad(buf, tsk->comm, buf_size);
>  	task_unlock(tsk);
>  	return buf;
>  }
> -- 
> 2.17.1
> 

But for the replacement with strscpy_pad(), yes please:

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
