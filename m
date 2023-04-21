Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B9F6EB342
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 23:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjDUVBl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 17:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjDUVBk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 17:01:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CCBE74
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 14:01:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b8b19901fso3339130b3a.3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682110898; x=1684702898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PibLMqJcdZmYNbzkWP4DV4XRlStPOsBjGB5w3KrKah0=;
        b=SnjSAuiX3mxubuX98xbrojEm/Djerm9q7rf1CTCswrwB7Tu0tcN5L8eVEDl/QjzhcG
         wghiMdKvIfWYD0123reylrLvFNkXtGqn0IqzVLNiI7xg3PsbzXocD/ML+XH6VSRH92Bw
         OYKzR52fdmGXRZhXtHYxobvyRaqBYa9e6szn9acOFo41eZOi8GZgeEgA0Q7YhqjG1PqO
         0F9ufxqr4kFzp5OBgPrxKogpXG/yJQVw6loWnsvoee8vO5iTZlSuCSGAUH6C/jp1Gd+P
         IiVusxOsX/8WxVVqbuN7C8WqtqyYaMVBJLBmvcMc2nbiWPeULA8/nH/p37ztRKE5Ac/G
         0+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682110898; x=1684702898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PibLMqJcdZmYNbzkWP4DV4XRlStPOsBjGB5w3KrKah0=;
        b=kBMFf6lXD6tIF/g0OJ7t17qxjihBCeQZ3GuHPWyhnhZlVoEmQxm/KjZaLEOzdPa5q5
         tadTc90ETHeT91mynQC0fO2om1MfPrrpw/pvMHmwRsjvqx68KJwBINH/GUXkOiiAV0NF
         fkPikozqRggqYzEbY/WParSgVESxi0ebzvI43uJJXK5FsHb9qS3wjn/pn9XMBYLDwYCy
         r+RdXLDSnDWeniFv5h/enc4gNcrA1V8jGyX7WQDqggZUpLrMN6GZIn/d9o9DhcfjYDYs
         qJK/m9s+1iyhSQsFYCx8Es9jwhTRkNU+BDqlw+Dgs4ZYJJYzgQVrZumuzxBfRoSD2hIs
         iE0A==
X-Gm-Message-State: AAQBX9fmo+burYuLhGXbb6CnFVkqS3FSZ9CvFPgzi1JCYe2IqpXXKZFj
        DMd3O95JuXThLSSHrn6WIjc=
X-Google-Smtp-Source: AKy350aCB/gK252dlX44vwdNhFr5L3TXa3oUnQO3sG/eqlNc0NT70Y0BC94Of+LwFzm8YYTQJkQZ6A==
X-Received: by 2002:a05:6a20:4418:b0:f2:b6d6:e3fa with SMTP id ce24-20020a056a20441800b000f2b6d6e3famr2796247pzb.38.1682110897938;
        Fri, 21 Apr 2023 14:01:37 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:ef5e])
        by smtp.gmail.com with ESMTPSA id o8-20020a056a0015c800b0062dd8809d6esm3376831pfu.150.2023.04.21.14.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:01:37 -0700 (PDT)
Date:   Fri, 21 Apr 2023 14:01:35 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 05/10] bpf: Add bpf_sock_addr_set() to allow
 writing sockaddr len from bpf
Message-ID: <20230421210135.v4msbkuj433j75g4@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-6-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421162718.440230-6-daan.j.demeyer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 21, 2023 at 06:27:13PM +0200, Daan De Meyer wrote:
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's add a kfunc bpf_sock_addr_set() that allows modifying the
> sockaddr length from bpf. This is required to allow modifying AF_UNIX
> sockaddrs correctly.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  net/core/filter.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 44fb997434ad..1c656e2d7b58 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -81,6 +81,7 @@
>  #include <net/xdp.h>
>  #include <net/mptcp.h>
>  #include <net/netfilter/nf_conntrack_bpf.h>
> +#include <linux/un.h>
>  
>  static const struct bpf_func_proto *
>  bpf_sk_base_func_proto(enum bpf_func_id func_id);
> @@ -11670,6 +11671,44 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
>  
>  	return 0;
>  }
> +
> +__bpf_kfunc int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
> +				  const void *addr, u32 addrlen__sz)

I think the verifier doesn't check validity of void* pointer for kfuncs.
Should it be 'struct sockaddr_un *' ?

> +{
> +	const struct sockaddr *sa = addr;
> +
> +	if (addrlen__sz <= offsetof(struct sockaddr, sa_family))
> +		return -EINVAL;
> +
> +	if (addrlen__sz > sizeof(struct sockaddr_storage))
> +		return -EINVAL;
> +
> +	if (sa->sa_family != sa_kern->uaddr->sa_family)
> +		return -EINVAL;
> +
> +	switch (sa->sa_family) {
> +	case AF_INET:
> +		if (addrlen__sz < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +		break;
> +	case AF_INET6:
> +		if (addrlen__sz < SIN6_LEN_RFC2133)
> +			return -EINVAL;
> +		break;
> +	case AF_UNIX:
> +		if (addrlen__sz <= offsetof(struct sockaddr_un, sun_path) ||
> +		    addrlen__sz > sizeof(struct sockaddr_un))
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	memcpy(sa_kern->uaddr, sa, addrlen__sz);
> +	sa_kern->uaddrlen = addrlen__sz;
> +
> +	return 0;
> +}
>  __diag_pop();
>  
>  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
> @@ -11694,6 +11733,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
>  BTF_SET8_END(bpf_kfunc_check_set_xdp)
>  
> +BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
> +BTF_ID_FLAGS(func, bpf_sock_addr_set)

It probably needs KF_TRUSTED_ARGS.
