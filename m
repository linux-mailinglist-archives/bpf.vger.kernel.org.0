Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762706189A8
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 21:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKCUiU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 16:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCUiU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 16:38:20 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC81E3C1
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 13:38:19 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id j6so1931297qvn.12
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 13:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cseMrRulqtDgFnwobqZOrIa4ByKw9Yi3q/7dRXaK7Gg=;
        b=EuFZRwHRdQA2D+EY55XRQlKmW4B0sOvcA18hK4xmMdJtgjSms+FqEoKJYfr9+hHsWP
         Ci2M7KhidzJOq54UTSX7YOe3AlWS7O56oG0g33BUoBOYUCIMfVAhmMdnXfXqcXPu5s0i
         HyKSZW10Jx9xO9kezV5xTaB36zrAcOR7vDcOVnSoRHNW56/C1JwKnvrhnboxpUysOX7b
         JX3Y5ZCLJ9/BDIYeQDgj9oTI0RiL21KdLrBXEOviB7HdeGpLqRPg5/9LfyOdx+82cqjH
         6WJX+/lIi12UejnPppbnUyaREekQcoaSBU7s1DBsitMwzczkDCWZbocw9lLHeYp0GMIX
         gqmQ==
X-Gm-Message-State: ACrzQf3ACURJYkpwL8dJGhojxlkk0QiHFv63zMswrv/gQ0+w0aXrRNC1
        IIrhc/Xn/cI6ZmpZpHzXA7mqcUypuuUwd3Q4
X-Google-Smtp-Source: AMsMyM5+Hmu9SEjhTd6WzBiZNkD/DZ8hokbmiX06+/4dzqRYc27aVL6K6Z0+9MuoLCS0/QtU6ydLKA==
X-Received: by 2002:a05:6214:27e9:b0:4bb:d54c:53d2 with SMTP id jt9-20020a05621427e900b004bbd54c53d2mr25979575qvb.54.1667507897911;
        Thu, 03 Nov 2022 13:38:17 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::b27e])
        by smtp.gmail.com with ESMTPSA id r23-20020ae9d617000000b006f474e6a715sm1356788qkk.131.2022.11.03.13.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:38:17 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:38:16 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 01/24] bpf: Document UAPI details for special
 BPF types
Message-ID: <Y2QmuHoAbHyjZ95w@maniforge.dhcp.thefacebook.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-2-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103191013.1236066-2-memxor@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 12:39:50AM +0530, Kumar Kartikeya Dwivedi wrote:
> The kernel recognizes some special BPF types in map values or local
> kptrs. Document that only bpf_spin_lock and bpf_timer will preserve
> backwards compatibility, and kptr will preserve backwards compatibility
> for the operations on the pointer, not the types supported for such
> kptrs.
> 
> For local kptrs, document that there are no stability guarantees at all.
> 
> Finally, document that 'bpf_' namespace is reserved for adding future
> special fields, hence BPF programs must not declare types with such
> names in their programs and still expect backwards compatibility.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  Documentation/bpf/bpf_design_QA.rst | 44 +++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
> index a210b8a4df00..b5273148497c 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst
> @@ -298,3 +298,47 @@ A: NO.
>  
>  The BTF_ID macro does not cause a function to become part of the ABI
>  any more than does the EXPORT_SYMBOL_GPL macro.
> +
> +Q: What is the compatibility story for special BPF types in map values?
> +-----------------------------------------------------------------------
> +Q: Users are allowed to embed bpf_spin_lock, bpf_timer fields in their BPF map
> +values (when using BTF support for BPF maps). This allows to use helpers for
> +such objects on these fields inside map values. Users are also allowed to embed
> +pointers to some kernel types (with __kptr and __kptr_ref BTF tags). Will the
> +kernel preserve backwards compatibility for these features?
> +
> +A: It depends. For bpf_spin_lock, bpf_timer: YES, for kptr and everything else:
> +NO, but see below.
> +
> +For struct types that have been added already, like bpf_spin_lock and bpf_timer,
> +the kernel will preserve backwards compatibility, as they are part of UAPI.
> +
> +For kptrs, they are also part of UAPI, but only with respect to the kptr
> +mechanism. The types that you can use with a __kptr and __kptr_ref tagged
> +pointer in your struct is NOT part of the UAPI contract. The supported types can

s/is NOT/are NOT

> +and will change across kernel releases. However, operations like accessing kptr
> +fields and bpf_kptr_xchg() helper will continue to be supported across kernel
> +releases for the supported types.
> +
> +For any other supported struct type, unless explicitly stated in this document
> +and added to bpf.h UAPI header, such types can and will arbitrarily change their
> +size, type, and alignment, or any other user visible API or ABI detail across
> +kernel releases. The users must adapt their BPF programs to the new changes and
> +update them to make sure their programs continue to work correctly.
> +
> +NOTE: BPF subsystem specially reserves the 'bpf_' prefix for type names, in
> +order to introduce more special fields in the future. Hence, user programs must
> +avoid defining types with 'bpf_' prefix to not be broken in future releases. In
> +other words, no backwards compatibility is guaranteed if one using a type in BTF
> +with 'bpf_' prefix.
> +
> +Q: What is the compatibility story for special BPF types in local kptrs?
> +------------------------------------------------------------------------
> +Q: Same as above, but for local kptrs (i.e. pointers to objects allocated using
> +bpf_obj_new for user defined structures). Will the kernel preserve backwards
> +compatibility for these features?
> +
> +A: NO.
> +
> +Unlike map value types, there are no stability guarantees for this case. The
> +whole local kptr API itself is unstable (since it is exposed through kfuncs).
> -- 
> 2.38.1
> 

Looks good otherwise.

Acked-by: David Vernet <void@manifault.com>
