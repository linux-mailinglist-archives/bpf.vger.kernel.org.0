Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8D113B5E
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2019 06:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfLEFhF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Dec 2019 00:37:05 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44432 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEFhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Dec 2019 00:37:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id w5so797889pjh.11
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2019 21:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JpTdIIfL8lSDhiZRa+6FjNGiRbqyJqnKNBhTugt3SD8=;
        b=ej/m150Dp1hRFsrJZer3JouWA2EDx+qEfukwG8yeYlpJqh2ySb2pUiDDZ2V4B1DkAc
         mxIACdVCR0oepXBAwoGXivGTWZRwXLLuuL+py68v/w9N7Jf3j4wd0UNnIP0rWQzYu/RM
         h2UGvGJsf1tfVBwBTzPgZCUGfbYr3bkFzIuFC7jYbg+8nqjrzYd7LKPEPGNegOVGwnJU
         UcXUyXBRAV2at9UhtM0V1omf2z63t8X1ewVXI5RTlFyzhSXs9SV+5Kvi8jvSV7wc2TLQ
         HF0RtwWVQkqm+q7ZfpUyF/+czKIlj4R2IWyDfKOgVSh+V1j67WrU3F7H/XcsNI0kQwuC
         9OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JpTdIIfL8lSDhiZRa+6FjNGiRbqyJqnKNBhTugt3SD8=;
        b=DSxXfuoyHsH1/d6M9i4fcmIbox8oUmoeagDJ4zuS9nf5F+HW6ZgWvehKJP6UwBHXEj
         cU3pV9ICw3EIdwwWjMvnstBCHP7xHSi/37LVn2aZQQdD8eBXHZUi1+xnFPyx/XPp4Cte
         tJkGhqzt/gXjxK6dhL+D6Q/yFwRjUNmZFmXGOmGTPdwxNI11STUJj5IVu6nt/L2gzCbW
         epDbfou+yH5irQpJfZmAsAp9pgPJMJnzAv2GAvRAME36mnXauJ4nCJLJA+yfQBTD5++w
         HOnADK5Adf5fDAPbOLjJrHvyZbkxOvq4K7Xmr3EMgAfI4pue0r3JnyvYi5uqcytRrUyD
         GM6g==
X-Gm-Message-State: APjAAAW0Eui7hD4noN5wkmseNkyKWmDvdCH0nnX5fzNSY23pxC7IDh7x
        1g4JmrM9groXr67FWXMfaF06QQvQ
X-Google-Smtp-Source: APXvYqzAqamnvjAH9RhZdOzwl3T+Fo6Opw75mnlj7iFLxwOMd0SumkFnngtGncFBVMCg/+Uzsco2uA==
X-Received: by 2002:a17:90a:aa8c:: with SMTP id l12mr7260453pjq.92.1575524224360;
        Wed, 04 Dec 2019 21:37:04 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::f3d1])
        by smtp.gmail.com with ESMTPSA id r4sm8060866pji.11.2019.12.04.21.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 21:37:03 -0800 (PST)
Date:   Wed, 4 Dec 2019 21:37:02 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf 2/2] selftests/bpf: add a fexit/bpf2bpf test with
 target bpf prog no callees
Message-ID: <20191205053700.7e6oxm77zjypbrik@ast-mbp.dhcp.thefacebook.com>
References: <20191205010606.177712-1-yhs@fb.com>
 <20191205010607.177904-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205010607.177904-1-yhs@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 04, 2019 at 05:06:07PM -0800, Yonghong Song wrote:
>  
> -	obj = bpf_object__open_file("./fexit_bpf2bpf.o", &opts);
> +	obj = bpf_object__open_file(obj_file, &opts);
>  	if (CHECK(IS_ERR_OR_NULL(obj), "obj_open",
>  		  "failed to open fexit_bpf2bpf: %ld\n",
>  		  PTR_ERR(obj)))
> @@ -38,7 +34,14 @@ void test_fexit_bpf2bpf(void)
>  	if (CHECK(err, "obj_load", "err %d\n", err))
>  		goto close_prog;
>  
> -	for (i = 0; i < PROG_CNT; i++) {
> +	link = calloc(sizeof(struct bpf_link *), prog_cnt);
> +	prog = calloc(sizeof(struct bpf_program *), prog_cnt);
> +	result = malloc(prog_cnt * sizeof(u64));
> +	if (CHECK(!link || !prog || !result, "alloc_memory",
> +		  "failed to alloc memory"))
> +		goto close_prog;

bpf_object__open_file() can fail when jit is off and for() loop in close_prog
will segfault. I fixed it up by moving above 3 mallocs before
bpf_object__open_file() and applied both patches. Thanks!

