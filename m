Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C14969F6
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 05:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiAVEEL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 23:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAVEEL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 23:04:11 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C34C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 20:04:10 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e9so9812812pgb.3
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 20:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Sj3IAP8j/pQg0SkrShFbMxDbQ2btM1z82T4TI0GJGg=;
        b=F/vJGRcEBfKqjfqrO3VCfBv3JfAM0z++MmcYn2rnTl9YeggcxAB/bB/VpaHTZBZ7+i
         Amlst2vyMpL49PQYXMpHZJwkIziKCC6YMT0a64y8fxbk+VaznGLzYl00IQ2cbCTHgPue
         b4t8poVBShp4Z4o0S/uW6iC6y4CcRHZyK9s5ZnEHquftRrCRyrTe0tbuQwr7hKLrEcGk
         HH3Oo74f8tv0pfYbsW7saOcl9w8PD1e3mNcveOlaZ/cYxOiHaA0Q/EqSBAXyb9oP6GOT
         7Ur1BlBm0YV0uuQ35CNNDpe7qTEEGrK2wZZXkA8XMUwlNjnkcKzlmwZFHf7FWkX2VLy1
         qb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Sj3IAP8j/pQg0SkrShFbMxDbQ2btM1z82T4TI0GJGg=;
        b=CYv84yA7AY3+8nWTbwo+KZDtyIqxdgjIy1JsuJ8hi1F3mWQXAN/+0/it2EEZAKilSr
         XT7oDU2ZC6ZbQ9/26N+dzYyU0s08euuHmVfaWV0rxmAqjyeSnFfOzq2Ptt3bMIkFbVr4
         CEFMiHnNGLqYFkRQLzZfefglnTrbjIN14l6IOSwEYBMPV2fjKMLy8MIhTwZJKK17x9GP
         zEeRB8KSjuREWHEDgyLd8FJR/gUhQblkwSC5A3QLznhIgp12iiT2ffCy7JqC+nfrU8Ad
         0sEt3PkzuGKbwAn4+iBx4tqZw8FrA8vDhUAquvzeZ5c0YqCjJQYdurB70gnL9uIqIqjn
         kHYQ==
X-Gm-Message-State: AOAM530jFM8WxYRo8DjaSrJr3txNACZ6IMJDEQxo9nXsQ8BTVrCtTsvn
        GJCz+0u1oTgNLHYZ3w0gRL8=
X-Google-Smtp-Source: ABdhPJz0bizOIx1APpkwQ8gBDZwNW6EKtWtrdD2r++2qUVYe27vJ2Q4XRY8Rii5jjFLD5Fgi/wRRHw==
X-Received: by 2002:a05:6a00:10d5:b0:4bc:a0eb:c6a0 with SMTP id d21-20020a056a0010d500b004bca0ebc6a0mr6310649pfu.70.1642824250115;
        Fri, 21 Jan 2022 20:04:10 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:1fb1:21a:3dae:742c])
        by smtp.gmail.com with ESMTPSA id g12sm7937329pfm.119.2022.01.21.20.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 20:04:09 -0800 (PST)
Date:   Sat, 22 Jan 2022 09:34:07 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Usama Arif <usama.arif@bytedance.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        fam.zheng@bytedance.com, cong.wang@bytedance.com, song@kernel.org
Subject: Re: [RFC bpf-next 0/3] bpf: Introduce module helper functions
Message-ID: <20220122040407.p5qbax5qtuywvyf3@thp>
References: <20220121193956.198120-1-usama.arif@bytedance.com>
 <20220121224813.6necsmszanxg5p5e@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121224813.6necsmszanxg5p5e@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 22, 2022 at 04:18:13AM IST, Alexei Starovoitov wrote:
> On Fri, Jan 21, 2022 at 07:39:53PM +0000, Usama Arif wrote:
> > This patchset is a working prototype that adds support for calling helper
> > functions in eBPF applications that have been defined in a kernel module.
> >
> > It would require further work including code refractoring (not included in
> > the patchset) to rename functions, data structures and variables that are
> > used for kfunc as well to be appropriately renamed for module helper usage.
> > If the idea of module helper functions and the approach used in this patchset
> > is acceptable to the bpf community, I can send a follow up patchset with the
> > code refractoring included to make it ready for review.
> >
> > Module helpers are useful as:
> > - They support more argument and return types when compared to module
> > kfunc.
>
> What exactly is missing?
>

I looked at the set. I think the only difference between existing support and
this series is that you are using bpf_func_proto for argument checks, right? Is
there anything else it is adding?

We discussed whether to use bpf_func_proto for kfunc in [0], the conclusion was
that BTF has enough info that we don't have to use it. The only thing missing
is making the verifier assume type of argument from kernel BTF rather than
passed in argument register.

e.g. same argument can currently work with PTR_TO_BTF_ID and PTR_TO_MEM. On
Alexei's suggestion, we disabled the bad cases by limiting PTR_TO_MEM support
to struct with scalars. For current usecase that works fine.

I think once BTF tags are supported, we will be able to tag the function
argument as __arg_mem or __arg_btf_id and make the verifier more strict.
Same can be done for the return value (instead of ret_null_set as it is now).

  [0]: https://lore.kernel.org/bpf/20211105204908.4cqxk2nbkas6bduw@ast-mbp.dhcp.thefacebook.com/

> > - This adds a way to have helper functions that would be too specialized
> > for a specific usecase to merge upstream, but are functions that can have
> > a constant API and can be maintained in-kernel modules.
>
> Could you give an example of something that would be "too specialized" that
> it's worth maintaining in a module, but not worth maintaining in the kernel?
>
> Also see:
> https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html#q-new-functionality-via-kernel-modules
>
> Why do you think we made that rule years ago?
