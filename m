Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B66047A356
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 02:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhLTBpJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Dec 2021 20:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhLTBpJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Dec 2021 20:45:09 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB94EC061574
        for <bpf@vger.kernel.org>; Sun, 19 Dec 2021 17:45:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id o14so6821896plg.5
        for <bpf@vger.kernel.org>; Sun, 19 Dec 2021 17:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6KuLfyikyZi+u0/DkrmvPA8LGjdVghgWk1Ia6p3vkGQ=;
        b=hnLBzC2Bj8PxGOwo5+vYI3ef3u9DenlJGfve03FNIDhE7OrWyJwwp6/o91rWqycM8k
         YHhCVoZrgnIJd6pjnHj61wIDVcdz81sxrYIwXGt0+US3lHhygoIOKLqrXOBsHxaaKgq6
         1qzHO29hLGqHURsEJP/8ci9dKqJeoe7kqHWT9naTr1uryZZGKUuMOr3VVo7ph2TpBCus
         z9Nf1BU1ZFPs6zFdJ5H8NFpOD2RWBNf0UxGG5C01I9/5jowpvUO7dugYoN5T6kWOnU3i
         9DSSzXeKPuIKfUBukC3tyUIWDKi6DuVO+M3bbyiVbwHDSdUGrbX7e46ddaZGjbHRzBRO
         xnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6KuLfyikyZi+u0/DkrmvPA8LGjdVghgWk1Ia6p3vkGQ=;
        b=IOK7XQKlsCY75E8E6atuqyGrpU4xN/d/H4C31mQS3ub4FkhjDRsgZnSvRuV5ifKY/J
         LZlEy0fpS/rLhAPHd5SjBVLmZhayzYI0II1JZ1ENWZu3aI56dgocqkg6l+qsdiah4RxY
         shtPpHd8C+vgExLF3ih9Wzlvl33xMm6Zy5trhxrNY+dPa2/wq0GrX+6XnI/Vrp+9J26Q
         xU3S6J+AZLApDRW6dQlDCAq+PL7GYOMLV8t0OWL7r+2uEB+TyOqlKPCKJ9noti4rEHqS
         iqZ0vnOJGfo82dGE4cn1oXpOyvQ80OGPHF8hdI2PhHZ0LP7l72AFB7EX7JV8wXsWYOj+
         Zi5A==
X-Gm-Message-State: AOAM5309qCm9OSY8759Sm4QiPvBqvxkpzZc/9BoUIu6eOn0WMXr+GbBT
        5F52dne2ovOCVXdFVgd72Bc=
X-Google-Smtp-Source: ABdhPJwYc8CYhEOayv1zDaWXgm44s+ZdJKmkimq4AbLjDvX1D8czzhd1h71JEBlnN5xa0lDEZVJbpA==
X-Received: by 2002:a17:90a:7e0d:: with SMTP id i13mr25620145pjl.171.1639964708101;
        Sun, 19 Dec 2021 17:45:08 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:9150])
        by smtp.gmail.com with ESMTPSA id y5sm5762226pgc.45.2021.12.19.17.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 17:45:07 -0800 (PST)
Date:   Sun, 19 Dec 2021 17:45:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 2/5] bpf: reject program if a __user tagged
 memory accessed in kernel way
Message-ID: <20211220014505.oirge3vkyzm2t3st@ast-mbp.dhcp.thefacebook.com>
References: <20211209173537.1525283-1-yhs@fb.com>
 <20211209173548.1527870-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209173548.1527870-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 09, 2021 at 09:35:48AM -0800, Yonghong Song wrote:
> BPF verifier supports direct memory access for BPF_PROG_TYPE_TRACING type
> of bpf programs, e.g., a->b. If "a" is a pointer
> pointing to kernel memory, bpf verifier will allow user to write
> code in C like a->b and the verifier will translate it to a kernel
> load properly. If "a" is a pointer to user memory, it is expected
> that bpf developer should be bpf_probe_read_user() helper to
> get the value a->b. Without utilizing BTF __user tagging information,
> current verifier will assume that a->b is a kernel memory access
> and this may generate incorrect result.

The patch set looks great overall.

> +/* The pointee address space encoded in BTF. */
> +enum btf_addr_space {
> +	BTF_ADDRSPACE_UNSPEC	= 0,
> +	BTF_ADDRSPACE_USER	= 1,
> +};
> +
>  /* The information passed from prog-specific *_is_valid_access
>   * back to the verifier.
>   */
> @@ -473,6 +479,7 @@ struct bpf_insn_access_aux {
>  		struct {
>  			struct btf *btf;
>  			u32 btf_id;
> +			enum btf_addr_space addr_space;
>  		};
...
> @@ -4998,7 +4999,15 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  
>  	info->btf = btf;
>  	info->btf_id = t->type;
> +	info->addr_space = BTF_ADDRSPACE_UNSPEC;
>  	t = btf_type_by_id(btf, t->type);
> +
> +	if (btf_type_is_type_tag(t)) {
> +		tag_value = __btf_name_by_offset(btf, t->name_off);
> +		if (strcmp(tag_value, "user") == 0)
> +			info->addr_space = BTF_ADDRSPACE_USER;
> +	}
> +
>  	/* skip modifiers */
>  	while (btf_type_is_modifier(t)) {

bpf_insn_access_aux approach will work only for the first
pointer deref, right?
Also addr_space will consume the last 4 free bytes in bpf_reg_state.
Maybe encode user/kernel as a flag into bpf_reg_type?
The verifier just got extended with PTR_MAYBE_NULL and MEM_RDONLY flags.
MEM_RDONLY is roughly equivalent 'const' modifier.
In that sense __user attribute is similar.
wdyt?
