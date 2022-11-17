Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A962E9E0
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiKQXv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiKQXvZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:51:25 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D105532F7
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:51:24 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id w4so2242018qts.0
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLy6UFusOph7Bh49Otzlp4GezrdaDQe/6AK5miz9Sbw=;
        b=JorSw7BxR5tu2TugGIaJL8JG8p4c1u+4aZZoQqqNa76tVB88fV0sxFJxelsuhV4Sw/
         ppgsvEw+diSceul9XEu5OKygReLFaPWaCCbwFsb5ovYiMTL+t7VLatn0Q3cH5Z7LbLL7
         wwd9SVH3CsaNY1HjGmkiMuRViN7MUrbD8deU7L/eTroY0WKQoXXRV4i6qad3Xetyw80u
         GxhozuI3jfdanBo7I+I3DpICbcoRUAItJAd4im/Kx7x3mAgeTzfpG+brkPJIMvy8DtAb
         43lSG2kUVuX4ShcI1LQOei5/RFG5gyzpyTFwfXhvwjHzbrKZ9/AycdrxZtBwIWTXD6ow
         hkpg==
X-Gm-Message-State: ANoB5pl0LUHG1kGH81kPH5Tnb8TFcc7WsH6w1g9+1dzoReQhvQ3SBvwG
        hOB9bEgvpjV4Bu0Fu1EjS/qzTCNG5FoNFsNy
X-Google-Smtp-Source: AA0mqf5sU+tRPVnPyAshBmqeE6sY4hlf3AaQ+q0ItHeBjUNmtTOV+dLttRkI5pSWbsDA7BuxbXEAMg==
X-Received: by 2002:a05:622a:2297:b0:3a5:7679:2fa1 with SMTP id ay23-20020a05622a229700b003a576792fa1mr4405513qtb.258.1668729083647;
        Thu, 17 Nov 2022 15:51:23 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8ad4])
        by smtp.gmail.com with ESMTPSA id z63-20020a37b042000000b006fafaac72a6sm1348581qke.84.2022.11.17.15.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:51:23 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:51:25 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v1 6/7] bpf: Use memmove for
 bpf_dynptr_{read,write}
Message-ID: <Y3bI/YSEcuHpyeTx@maniforge.lan>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115000130.1967465-7-memxor@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 05:31:29AM +0530, Kumar Kartikeya Dwivedi wrote:
> It may happen that destination buffer memory overlaps with memory dynptr
> points to. Hence, we must use memmove to correctly copy from dynptr to
> destination buffer, or source buffer to dynptr.
> 
> This actually isn't a problem right now, as memcpy implementation falls
> back to memmove on detecting overlap and warns about it, but we
> shouldn't be relying on that.
> 
> Acked-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Good call, thanks for this.

Acked-by: David Vernet <void@manifault.com>

>  kernel/bpf/helpers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 714f5c9d0c1f..1099ed1e7712 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1489,7 +1489,7 @@ BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern
>  	if (err)
>  		return err;
>  
> -	memcpy(dst, src->data + src->offset + offset, len);
> +	memmove(dst, src->data + src->offset + offset, len);

Can you add a comment here and in bpf_dynptr_write() which explain why
memmove is needed?

>  
>  	return 0;
>  }
> @@ -1517,7 +1517,7 @@ BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, v
>  	if (err)
>  		return err;
>  
> -	memcpy(dst->data + dst->offset + offset, src, len);
> +	memmove(dst->data + dst->offset + offset, src, len);
>  
>  	return 0;
>  }
> -- 
> 2.38.1
> 
