Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E6820FBD7
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 20:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbgF3SgB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 14:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgF3SgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 14:36:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A5FC061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:36:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y2so22122672ioy.3
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=tvDHb81YQTAPAwE6TyQXLDOvJ+aVF77295PmGVh9JYo=;
        b=kuOz0MuxMMkwMV5Ml5gwKKzD7A72fW57QSDRS5OSMz1bezQjJzR6QNWgdigwi93L2v
         iMGbUFfUzIgYVGiiWZuki2ftFx/L4o0eqSWHHHDDfkbj+hlDtGVmpU3yyugQlB8BAxVX
         FJmbjKo+CvHqP/32p1rFM78juEl671jT3Jh4WqdJzQp37SdqujDp26YkVGiL+RP0/BK1
         YJmxhseJ1+1J3Yea+R3SS/ddDdx5C1o8uNyr7aP470Ux4K0Ok7h6OgfGUYk4IugNe/2N
         U+qc2eKsIhnRR7FMjatgEjNnPPdWMD2iOO6vrX+EPTC+xEjFFRqy534Si9Lqg7o9bxBB
         lE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=tvDHb81YQTAPAwE6TyQXLDOvJ+aVF77295PmGVh9JYo=;
        b=i2/ZfJ2WDYW/sDZe2m+6giygtLndVDKb49wzZqgq1V/yUke+sGrWUWGF1u5YG5kGwc
         EpCg+SsGWvUbD6pPFWHxDw+s209EoRRioOPrQCKI7HyVj6nuDoCVVwQwiLVyXwUllDML
         vWe/GZIOP8P874vBrDKZ/RLpHwKz2SxFOUe0GevrxzRug9ifoLay7xGrdXWMN8DaAlLv
         TzYC+RknfS4SeV7BN4ZbObP1kAbraDMm3Msd/TxgKtILn4QtBqjnE5lYHBmoAzVfWcyN
         EENkAcY8+MJsFzJsD+m5AgBjiUfzciiTLxXGhANY7B1RFQLCzd2yyJK3mxYnIwh94brU
         ey0w==
X-Gm-Message-State: AOAM53396wvZ0dKEpCcNJBzkgaW72/QXsgU8wQFl6m1Ktk012PfOYD9K
        TmKBsmQmTBJusi7sSQjUYUQ=
X-Google-Smtp-Source: ABdhPJyRw9jCUJuplDX5YKt0h4F7+nIdELAlrotWvh5E98yygWV2nHTTLNm4K5Ip8DXDJyO56BucNA==
X-Received: by 2002:a5e:9703:: with SMTP id w3mr22848076ioj.29.1593542159594;
        Tue, 30 Jun 2020 11:35:59 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id l10sm2051405ilc.52.2020.06.30.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:35:59 -0700 (PDT)
Date:   Tue, 30 Jun 2020 11:35:50 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        Wenbo Zhang <ethercflow@gmail.com>
Message-ID: <5efb86067d541_3792b063d0145b4f1@john-XPS-13-9370.notmuch>
In-Reply-To: <c7416fc5-b9b6-7778-9ec3-0c4634e3e902@fb.com>
References: <20200630171240.2523628-1-yhs@fb.com>
 <20200630171240.2523722-1-yhs@fb.com>
 <5efb7ba67bae6_3792b063d0145b4b4@john-XPS-13-9370.notmuch>
 <c7416fc5-b9b6-7778-9ec3-0c4634e3e902@fb.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix an incorrect branch elimination by
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
> 
> 
> On 6/30/20 10:51 AM, John Fastabend wrote:
> > Yonghong Song wrote:
> >> Wenbo reported an issue in [1] where a checking of null
> >> pointer is evaluated as always false. In this particular
> >> case, the program type is tp_btf and the pointer to
> >> compare is a PTR_TO_BTF_ID.
> >>
> >> The current verifier considers PTR_TO_BTF_ID always
> >> reprents a non-null pointer, hence all PTR_TO_BTF_ID compares
> >> to 0 will be evaluated as always not-equal, which resulted
> >> in the branch elimination.
> >>
> >> For example,
> >>   struct bpf_fentry_test_t {
> >>       struct bpf_fentry_test_t *a;
> >>   };
> >>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
> >>   {
> >>       if (arg == 0)
> >>           test7_result = 1;
> >>       return 0;
> >>   }
> >>   int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
> >>   {
> >>       if (arg->a == 0)
> >>           test8_result = 1;
> >>       return 0;
> >>   }
> >>
> >> In above bpf programs, both branch arg == 0 and arg->a == 0
> >> are removed. This may not be what developer expected.
> >>
> >> The bug is introduced by Commit cac616db39c2 ("bpf: Verifier
> >> track null pointer branch_taken with JNE and JEQ"),
> >> where PTR_TO_BTF_ID is considered to be non-null when evaluting
> >> pointer vs. scalar comparison. This may be added
> >> considering we have PTR_TO_BTF_ID_OR_NULL in the verifier
> >> as well.
> >>
> >> PTR_TO_BTF_ID_OR_NULL is added to explicitly requires
> >> a non-NULL testing in selective cases. The current generic
> >> pointer tracing framework in verifier always
> >> assigns PTR_TO_BTF_ID so users does not need to
> >> check NULL pointer at every pointer level like a->b->c->d.
> > 
> > Thanks for fixing this.
> > 
> > But, don't we really need to check for null? I'm trying to
> > understand how we can avoid the check. If b is NULL above
> > we will have a problem no?
> 
> It depends with particular data structure.
> If users are sure once pointer 'a' is valid and a->b, a->b->c, a->b->c
> are all valid pointers, user may just write a->b->c->d. this happens
> to some bcc scripts. So non-null pointer is checked.
> 
> But if user thinks a->b->c is null, he may write
>     type *p = a->b->c;
>     if (p)
>         p->d;
> 
> Or user just takes advantage of kernel bpf guarded exception handling 
> and do a->b->c->d even if a->b->c could be null.
> if the result is 0, it means a->b->c is null or major fault,
> otherwise it is not 0.

OK.

> 
> > 
> > Also, we probably shouldn't name the type PTR_TO_BTF_ID if
> > it can be NULL. How about renaming it in bpf-next then although
> > it will be code churn... Or just fix the comments? Probably
> > bpf-next content though. wdyt? In my opinion the comments and
> > type names are really misleading as it stands.
> 
> So PTR_TO_BTF_ID actually means it may be null but not checking
> is enforced and pointer tracing is always allowed.
> PTR_TO_BTF_ID_OR_NULL means it may be null and checking against
> NULL is needed to allow further pointer tracing.
> 
> To avoid code churn, we can add these comments in bpf-next.

Agreed code churn would be not worth changing type but I'll send
some patches for the comment changes.

> 
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 3d2ade703a35..18051440f886 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -337,7 +337,7 @@ enum bpf_reg_type {
> >   	PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
> >   	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
> >   	PTR_TO_XDP_SOCK,	 /* reg points to struct xdp_sock */
> > -	PTR_TO_BTF_ID,		 /* reg points to kernel struct */
> > +	PTR_TO_BTF_ID,		 /* reg points to kernel struct or NULL */
> >   	PTR_TO_BTF_ID_OR_NULL,	 /* reg points to kernel struct or NULL */
> >   	PTR_TO_MEM,		 /* reg points to valid memory region */
> >   	PTR_TO_MEM_OR_NULL,	 /* reg points to valid memory region or NULL */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7de98906ddf4..7412f9d2f0b5 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -500,7 +500,7 @@ static const char * const reg_type_str[] = {
> >   	[PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
> >   	[PTR_TO_TP_BUFFER]	= "tp_buffer",
> >   	[PTR_TO_XDP_SOCK]	= "xdp_sock",
> > -	[PTR_TO_BTF_ID]		= "ptr_",
> > +	[PTR_TO_BTF_ID]		= "ptr_or_null_",
> >   	[PTR_TO_BTF_ID_OR_NULL]	= "ptr_or_null_",
> >   	[PTR_TO_MEM]		= "mem",
> >   	[PTR_TO_MEM_OR_NULL]	= "mem_or_null",
> > 
> >>
> >> We may not want to assign every PTR_TO_BTF_ID as
> >> PTR_TO_BTF_ID_OR_NULL as this will require a null test
> >> before pointer dereference which may cause inconvenience
> >> for developers. But we could avoid branch elimination
> >> to preserve original code intention.
> >>
> >> This patch simply removed PTR_TO_BTD_ID from reg_type_not_null()
> >> in verifier, which prevented the above branches from being eliminated.
> >>
> >>   [1]: https://lore.kernel.org/bpf/79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb.com/T/
> >>
> >> Fixes: cac616db39c2 ("bpf: Verifier track null pointer branch_taken with JNE and JEQ")

I added the BTF_ID in v2 of those patches :/ too bad. Thanks again for catching
it.

> >> Cc: Andrii Nakryiko <andriin@fb.com>
> >> Cc: John Fastabend <john.fastabend@gmail.com>
> >> Cc: Wenbo Zhang <ethercflow@gmail.com>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

> >>   kernel/bpf/verifier.c | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 8911d0576399..94cead5a43e5 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -399,8 +399,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
> >>   	return type == PTR_TO_SOCKET ||
> >>   		type == PTR_TO_TCP_SOCK ||
> >>   		type == PTR_TO_MAP_VALUE ||
> >> -		type == PTR_TO_SOCK_COMMON ||
> >> -	        type == PTR_TO_BTF_ID;
> >> +		type == PTR_TO_SOCK_COMMON;
> >>   }
> >>   
> >>   static bool reg_type_may_be_null(enum bpf_reg_type type)
> >> -- 
> >> 2.24.1
> >>


