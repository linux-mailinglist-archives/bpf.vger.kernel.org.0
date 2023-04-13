Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87406E124D
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 18:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDMQbB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 12:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDMQbA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 12:31:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2BA5FA
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 09:30:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k36-20020a05600c1ca400b003f0a7c483feso1517144wms.4
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1681403452; x=1683995452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0mDNWduF+pD0M3p/ZiM9mGoNceJzLF1dhOFZMxDI6Q=;
        b=Eu76UtDGzq5jN5Gr+fDTg2a0vH+f1Q7/2/hkPjCpJyDGLBgRdWwKLk97WEPjGn0+Wp
         4F9LImild6ICXVLfeHTTM87zMY9eoSqbKkXOugQs30xhI1q/MZeSUzcKCDa/jVVY7wL4
         2jtWDroXSfEYT+mpPXQeEo2uCo6lnHfW+fLOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681403452; x=1683995452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0mDNWduF+pD0M3p/ZiM9mGoNceJzLF1dhOFZMxDI6Q=;
        b=NsbTf5TC4JndM9o8/wU2/lL7J1328Res3QxCxxHQhDCargmF8KP8Be5D+gt7FlqHhF
         4N0xQzEV8c8KS+lnav1axAAaNs86djSbLVzj987BC0DlY6gdv8H6sM6l3QgCYJiJb5YH
         OplZILWXojvNMGlV5HwMW35qxkg8qifQR4w9ZEZf7RFmFrzNAVtOwBsMFot7HWNz2uhj
         Z0rDqN1bi6dKX/UYDQcvemzXpthP7rSAmKcC/XkxOZln3jl4POtHnUmBOhJjN1NS1s09
         kHS++iT53IXuIAEo3kp8pYwN6NiO7qRPH2xtXsL8XhPoQJMs8huHOI1Wcv1cFYVb7vJe
         bmEg==
X-Gm-Message-State: AAQBX9dH2Wil1/DoKHCMY4e7Nvl6QerUYs9lnMr5xC0E+ZOPe+ufpf+x
        bXqB9I3VUn+eJYe5VAcqQRWssg==
X-Google-Smtp-Source: AKy350Yl7Q4Uwkj91CN8S9loLio+5p511yXKikW09QVx8lhRN7MjowqEoSWYsLFUc0oeWgl2cPe/pg==
X-Received: by 2002:a05:600c:2195:b0:3f0:a11f:26f7 with SMTP id e21-20020a05600c219500b003f0a11f26f7mr2299729wme.32.1681403452384;
        Thu, 13 Apr 2023 09:30:52 -0700 (PDT)
Received: from che-box ([85.88.143.70])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003ee5fa61f45sm5968303wmq.3.2023.04.13.09.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 09:30:51 -0700 (PDT)
Date:   Thu, 13 Apr 2023 18:31:47 +0200
From:   Christian Ehrig <cehrig@cloudflare.com>
To:     broonie@kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Gavin Li <gavinl@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net-next
 tree
Message-ID: <20230413163147.GA25768@cloudflare.com>
References: <20230413161235.4093777-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413161235.4093777-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 05:12:35PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   include/net/ip_tunnels.h
> 
> between commit:
> 
>   bc9d003dc48c3 ("ip_tunnel: Preserve pointer const in ip_tunnel_info_opts")
> 
> from the net-next tree and commit:
> 
>   ac931d4cdec3d ("ipip,ip_tunnel,sit: Add FOU support for externally controlled ipip devices")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc include/net/ip_tunnels.h
> index 255b32a90850a,7912f53caae0b..0000000000000
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@@ -66,15 -73,9 +73,16 @@@ struct ip_tunnel_encap 
>   #define IP_TUNNEL_OPTS_MAX					\
>   	GENMASK((sizeof_field(struct ip_tunnel_info,		\
>   			      options_len) * BITS_PER_BYTE) - 1, 0)
>  +
>  +#define ip_tunnel_info_opts(info)				\
>  +	_Generic(info,						\
>  +		 const struct ip_tunnel_info * : ((const void *)((info) + 1)),\
>  +		 struct ip_tunnel_info * : ((void *)((info) + 1))\
>  +	)
>  +
>   struct ip_tunnel_info {
>   	struct ip_tunnel_key	key;
> + 	struct ip_tunnel_encap	encap;
>   #ifdef CONFIG_DST_CACHE
>   	struct dst_cache	dst_cache;
>   #endif

This looks good to me. Thanks much.
