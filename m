Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CC620FB0D
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 19:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389199AbgF3Rvq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 13:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388339AbgF3Rvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 13:51:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55CEC061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:51:45 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a11so10281423ilk.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fSQ9XpM5Ld8qwtBBeLZYGyimgoEpyChks7ukmC998PI=;
        b=ZGb9GD0fqNajYf8+UvHcpp0uc3voK2UXL1ENW5T2vvk2SC22k1YG+o56dzAVNkmdxW
         R/43K4dhooH0j+wrHEtamMpwpqIUtBO9AFkcMw9wjIPhYCgGAufYbnR6FpzkJntrlI22
         3JKNzY/qfm0WSZjGm59XxSamXpnVKhgbruNF8fVTI5MggRCR00KpJrZH/JCgcbYSaNxZ
         JQboVUxx5v2RFL0ARb1Jtp03gnILlPefcO0qLo01rRLfsZI+hlCi8bV87YT4dxvcnB6K
         hLooc13hIVF8AnvGj4gIeBnJaz4YBDIBxo9CxcxT2aMBIbP6a1EVlLFoawdVkKsAbrNO
         z5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fSQ9XpM5Ld8qwtBBeLZYGyimgoEpyChks7ukmC998PI=;
        b=lNYVwChvFctAkfVOT9D/xMMtqqC2KlyyK9Wr5HeUrQlZ+6ZnsyQ0WzEREXwW/naKGu
         cfz3gjcs+wVndVLDHBGBYCyTsXfBM8Rpg4WOdH7k89UexZC0uScI1iqFJNTwCdqxmqr+
         qScC3XOpvfCOCHK+5SYFsy9kuo/HWU84df3vXYeNvltQg8nBWZyEaIoTyz6GvyROVSZy
         Op8+I3L72hPn7MPRlH1e7utfcu9A17UE6ijtZlMZcghVUBK2ZvDwHGII5tfnoLt3E9Dt
         mmG8rpso7mHuwERtWEQ3Snmqh3ga7ZXEJoa6wUMT/ER62Cs/qTc1ygcz6bnNqY9QIL+m
         U1yg==
X-Gm-Message-State: AOAM531idp8d1RupEHQrxDMVjbDSv6w5wMhWjfEQ14vzzWEoC7Wlnwhn
        VLWEKkg7ifm1sZspBM/pyNg=
X-Google-Smtp-Source: ABdhPJzbeUJv9GcEtjykpXqGijC2SWT7hL0uL/+tE/TgU83P+YmOsUhRdmKswTOFMeqUdatcZR66nQ==
X-Received: by 2002:a92:940f:: with SMTP id c15mr4028952ili.204.1593539505098;
        Tue, 30 Jun 2020 10:51:45 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id x16sm1757552iob.35.2020.06.30.10.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:51:44 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:51:34 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>
Message-ID: <5efb7ba67bae6_3792b063d0145b4b4@john-XPS-13-9370.notmuch>
In-Reply-To: <20200630171240.2523722-1-yhs@fb.com>
References: <20200630171240.2523628-1-yhs@fb.com>
 <20200630171240.2523722-1-yhs@fb.com>
Subject: RE: [PATCH bpf 1/2] bpf: fix an incorrect branch elimination by
 verifier
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> Wenbo reported an issue in [1] where a checking of null
> pointer is evaluated as always false. In this particular
> case, the program type is tp_btf and the pointer to
> compare is a PTR_TO_BTF_ID.
> 
> The current verifier considers PTR_TO_BTF_ID always
> reprents a non-null pointer, hence all PTR_TO_BTF_ID compares
> to 0 will be evaluated as always not-equal, which resulted
> in the branch elimination.
> 
> For example,
>  struct bpf_fentry_test_t {
>      struct bpf_fentry_test_t *a;
>  };
>  int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>  {
>      if (arg == 0)
>          test7_result = 1;
>      return 0;
>  }
>  int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
>  {
>      if (arg->a == 0)
>          test8_result = 1;
>      return 0;
>  }
> 
> In above bpf programs, both branch arg == 0 and arg->a == 0
> are removed. This may not be what developer expected.
> 
> The bug is introduced by Commit cac616db39c2 ("bpf: Verifier
> track null pointer branch_taken with JNE and JEQ"),
> where PTR_TO_BTF_ID is considered to be non-null when evaluting
> pointer vs. scalar comparison. This may be added
> considering we have PTR_TO_BTF_ID_OR_NULL in the verifier
> as well.
> 
> PTR_TO_BTF_ID_OR_NULL is added to explicitly requires
> a non-NULL testing in selective cases. The current generic
> pointer tracing framework in verifier always
> assigns PTR_TO_BTF_ID so users does not need to
> check NULL pointer at every pointer level like a->b->c->d.

Thanks for fixing this.

But, don't we really need to check for null? I'm trying to
understand how we can avoid the check. If b is NULL above
we will have a problem no?

Also, we probably shouldn't name the type PTR_TO_BTF_ID if
it can be NULL. How about renaming it in bpf-next then although
it will be code churn... Or just fix the comments? Probably
bpf-next content though. wdyt? In my opinion the comments and
type names are really misleading as it stands.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3d2ade703a35..18051440f886 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -337,7 +337,7 @@ enum bpf_reg_type {
 	PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
 	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
 	PTR_TO_XDP_SOCK,	 /* reg points to struct xdp_sock */
-	PTR_TO_BTF_ID,		 /* reg points to kernel struct */
+	PTR_TO_BTF_ID,		 /* reg points to kernel struct or NULL */
 	PTR_TO_BTF_ID_OR_NULL,	 /* reg points to kernel struct or NULL */
 	PTR_TO_MEM,		 /* reg points to valid memory region */
 	PTR_TO_MEM_OR_NULL,	 /* reg points to valid memory region or NULL */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7de98906ddf4..7412f9d2f0b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -500,7 +500,7 @@ static const char * const reg_type_str[] = {
 	[PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
 	[PTR_TO_TP_BUFFER]	= "tp_buffer",
 	[PTR_TO_XDP_SOCK]	= "xdp_sock",
-	[PTR_TO_BTF_ID]		= "ptr_",
+	[PTR_TO_BTF_ID]		= "ptr_or_null_",
 	[PTR_TO_BTF_ID_OR_NULL]	= "ptr_or_null_",
 	[PTR_TO_MEM]		= "mem",
 	[PTR_TO_MEM_OR_NULL]	= "mem_or_null",

> 
> We may not want to assign every PTR_TO_BTF_ID as
> PTR_TO_BTF_ID_OR_NULL as this will require a null test
> before pointer dereference which may cause inconvenience
> for developers. But we could avoid branch elimination
> to preserve original code intention.
> 
> This patch simply removed PTR_TO_BTD_ID from reg_type_not_null()
> in verifier, which prevented the above branches from being eliminated.
> 
>  [1]: https://lore.kernel.org/bpf/79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb.com/T/
> 
> Fixes: cac616db39c2 ("bpf: Verifier track null pointer branch_taken with JNE and JEQ")
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Wenbo Zhang <ethercflow@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8911d0576399..94cead5a43e5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -399,8 +399,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
>  	return type == PTR_TO_SOCKET ||
>  		type == PTR_TO_TCP_SOCK ||
>  		type == PTR_TO_MAP_VALUE ||
> -		type == PTR_TO_SOCK_COMMON ||
> -	        type == PTR_TO_BTF_ID;
> +		type == PTR_TO_SOCK_COMMON;
>  }
>  
>  static bool reg_type_may_be_null(enum bpf_reg_type type)
> -- 
> 2.24.1
> 
