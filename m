Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271126260B6
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 18:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiKKRy0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 12:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiKKRy0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 12:54:26 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F863B89
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:54:25 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id n4-20020a17090a2fc400b002132adb9485so3173116pjm.0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx5YZ66+a4EbdwCrxDYDs9v66fi+y0eHRJgNK24zwSg=;
        b=SGJ4Illx5TZJUoI5YBjjYFby7q9/D/aUg9ipCXWJ9ZSC0QsToZZJp3wT3MrCvWKCyR
         gmVaRyAPzZvSZUqt6v+Q+QMywUurFgSmzRAKQvdX1rttcZDrEI7Nst2hk/LWpioYGI3c
         mPY0g0s12YiqQ15JqUH08P+c8p9otrp7R7ucF3Xu1hDsG27EFvEPodRmaN3A1QQFFNoN
         JoI4equBOv1ZHrI7JrT2xR6V7HOougW/0rERRc8uWeSuUuTpnO5wsemYwTdpLaduORz3
         mi6XC3OU+Xaby44MZSjwi3Jl0SMifZnquLD7qiNOweZHs2gy0DKWhqyxSCKPReRYWZxV
         /7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx5YZ66+a4EbdwCrxDYDs9v66fi+y0eHRJgNK24zwSg=;
        b=f+y0yo6RSIZGuSd0WF/34QM9FigWzW29c+uaCzOLvvLCnNfL9pImOUDkfJsGN8w/p0
         EGq2/m0e06pWLccSlqcqMdKfOrJspHP3QQb9eh8TXbrAQG0u2p594BbxQNfNPiy2R0EI
         rBCl9FvefGo7gM5QocHUxHTRO0NAC6YKzMXnD0SsUhx8dKKZpGITFUMXUgj/W5LSC6jm
         MrQLTCE6QkOPCQm7rMkpUyI4II+EOr6kw9C08f7SUbSBl6FInnL2HAKOEr9baabNy2g4
         +BEd88CE5AjGOrAri3XrVcKiaOGkKXz5OUUzKjWrBKE2H9mrdISgI+g3Z3P8AtBvWNTw
         K5bQ==
X-Gm-Message-State: ANoB5pnkkH94FOzSMQgFxbKzbNqrz2Ld/1QfZ3AZoxcbNVHVLLY+sAYI
        Ji+nUo3ljrLNDhjvlImnOqO2yug=
X-Google-Smtp-Source: AA0mqf5BKdEJtDnPO0w7qb5hIOw/sFRJUBan061HvWzrJTh0wfpWf2iHjqVny2YpT/wz6+3O/oBnsi4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8656:0:b0:562:d99c:2f66 with SMTP id
 a22-20020aa78656000000b00562d99c2f66mr3708908pfo.42.1668189264961; Fri, 11
 Nov 2022 09:54:24 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:54:23 -0800
In-Reply-To: <20221111092642.2333724-3-houtao@huaweicloud.com>
Mime-Version: 1.0
References: <20221111092642.2333724-1-houtao@huaweicloud.com> <20221111092642.2333724-3-houtao@huaweicloud.com>
Message-ID: <Y26MTygDw2PUQlFz@google.com>
Subject: Re: [PATCH bpf 2/4] libbpf: Handle size overflow for ringbuf mmap
From:   sdf@google.com
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/11, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>

> The maximum size of ringbuf is 2GB on x86-64 host, so 2 * max_entries
> will overflow u32 when mapping producer page and data pages. Only
> casting max_entries to size_t is not enough, because for 32-bits
> application on 64-bits kernel the size of read-only mmap region
> also could overflow size_t.

> So fixing it by casting the size of read-only mmap region into a __u64
> and checking whether or not there will be overflow during mmap.

> Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   tools/lib/bpf/ringbuf.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index d285171d4b69..c4bdc88af672 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -77,6 +77,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>   	__u32 len = sizeof(info);
>   	struct epoll_event *e;
>   	struct ring *r;
> +	__u64 ro_size;
>   	void *tmp;
>   	int err;

> @@ -129,8 +130,14 @@ int ring_buffer__add(struct ring_buffer *rb, int  
> map_fd,
>   	 * data size to allow simple reading of samples that wrap around the
>   	 * end of a ring buffer. See kernel implementation for details.
>   	 * */
> -	tmp = mmap(NULL, rb->page_size + 2 * info.max_entries, PROT_READ,
> -		   MAP_SHARED, map_fd, rb->page_size);
> +	ro_size = rb->page_size + 2 * (__u64)info.max_entries;

[..]

> +	if (ro_size != (__u64)(size_t)ro_size) {
> +		pr_warn("ringbuf: ring buffer size (%u) is too big\n",
> +			info.max_entries);
> +		return libbpf_err(-E2BIG);
> +	}

Why do we need this check at all? IIUC, the problem is that the expression
"rb->page_size + 2 * info.max_entries" is evaluated as u32 and can
overflow. So why doing this part only isn't enough?

size_t mmap_size = rb->page_size + 2 * (size_t)info.max_entries;
mmap(NULL, mmap_size, PROT_READ, MAP_SHARED, map_fd, ...);

sizeof(size_t) should be 8, so no overflow is possible?


> +	tmp = mmap(NULL, (size_t)ro_size, PROT_READ, MAP_SHARED, map_fd,
> +		   rb->page_size);
>   	if (tmp == MAP_FAILED) {
>   		err = -errno;
>   		ringbuf_unmap_ring(rb, r);
> --
> 2.29.2

