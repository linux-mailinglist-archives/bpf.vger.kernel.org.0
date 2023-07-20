Return-Path: <bpf+bounces-5554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1675BA3D
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9161C20400
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFA01DDCD;
	Thu, 20 Jul 2023 22:03:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A442FA49
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 22:03:00 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D26A186
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:02:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57704a25be9so22232657b3.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689890578; x=1690495378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=206RntJl5N4S3vyqz152CXiY4g52GnK3+N2rFMZD3P0=;
        b=K1+jILZpfkoO5Im0HytBfUxM8f/T2D2oeCcTa465luZQc4AJcA82UvxtwIgErC7U5h
         F1OJqlPCdIxpTJhkA/6rX0c/lqmn/KA35KppVsJScvOyHkrVdQTt0S2lEbpqLPOZJ23L
         PzqW3uZlT/FeXlKfEGFH9vpWxwhOsKq4x9rx4x8ZYif+i1XO/R7CWgQmWqjzkWADMKiN
         uJzwlumLqrS0kDj1T4FIQKzRA6Z8hcsICigUrDcvvpAyE6EJT3KDH0pO8+81z5J61+NB
         B/fRSjL6R92cu7QklMNwqdeOea4B7H1fCf6rlWyf/z0OUTG9Z8nbEFZDfeEmhONs7cbC
         vr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689890578; x=1690495378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=206RntJl5N4S3vyqz152CXiY4g52GnK3+N2rFMZD3P0=;
        b=GK1t679irtdUP5iYdeM5Jr2X8LYIAD95+Vbfuqa8e8Z0v/EMN5X/lvDkGIFa3z8oHX
         vbpe/Lkk8lQm4sFCle93KA1sBSudpuY6W+l7/VxmHfr2wTrH7slfC5ErwaO+s04sDaIp
         RLTYayt2b2dardw1ypjzWqBG1dN9Wwr9G3dyzjgR8M7/lL/q00/YjyYpfDsj3hSH0AMh
         FFXhjbqVAVGBRAoJvpWGsLwsE61TbQsITYmMVmy85fuOD0SrPfMBekBsvdrRBTax0M5X
         HqyD+SDIDdlMsDD9IAXj4sNpPSWdII5omkBKMmD+mn/RzhczpFtXcuvyRx/8MBA5uH3C
         5f1A==
X-Gm-Message-State: ABy/qLaW/tlXcBQ95rsn/UZj4WhspqzNYkE9jORKH29Xv0D6Nk9M1Ld2
	gJaAnx1QW4J5HPUi1O0qoYwtrXc=
X-Google-Smtp-Source: APBJJlGm4vXVIxoGX5PWiF+DOWtPFnx7UP3a09t0TTvXwG763koFsoHomxnwaRChpn0H98yPlIe6Q9I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:b652:0:b0:56d:19ce:416c with SMTP id
 h18-20020a81b652000000b0056d19ce416cmr91956ywk.0.1689890578683; Thu, 20 Jul
 2023 15:02:58 -0700 (PDT)
Date: Thu, 20 Jul 2023 15:02:57 -0700
In-Reply-To: <20230719183734.21681-19-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com> <20230719183734.21681-19-larysa.zaremba@intel.com>
Message-ID: <ZLmvESUU0Gt5HgKU@google.com>
Subject: Re: [PATCH bpf-next v3 18/21] net: make vlan_get_tag() return
 -ENODATA instead of -EINVAL
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <jbrouer@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/19, Larysa Zaremba wrote:
> __vlan_hwaccel_get_tag() is used in veth XDP hints implementation,
> its return value (-EINVAL if skb is not VLAN tagged) is passed to bpf code,
> but XDP hints specification requires drivers to return -ENODATA, if a hint
> cannot be provided for a particular packet.
> 
> Solve this inconsistency by changing error return value of
> __vlan_hwaccel_get_tag() from -EINVAL to -ENODATA, do the same thing to
> __vlan_get_tag(), because this function is supposed to follow the same
> convention. This, in turn, makes -ENODATA the only non-zero value
> vlan_get_tag() can return. We can do this with no side effects, because
> none of the users of the 3 above-mentioned functions rely on the exact
> value.
> 
> Suggested-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  include/linux/if_vlan.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 6ba71957851e..fb35d7dd77a2 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -540,7 +540,7 @@ static inline int __vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
>  	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
>  
>  	if (!eth_type_vlan(veth->h_vlan_proto))
> -		return -EINVAL;
> +		return -ENODATA;
>  
>  	*vlan_tci = ntohs(veth->h_vlan_TCI);
>  	return 0;
> @@ -561,7 +561,7 @@ static inline int __vlan_hwaccel_get_tag(const struct sk_buff *skb,
>  		return 0;
>  	} else {
>  		*vlan_tci = 0;
> -		return -EINVAL;
> +		return -ENODATA;
>  	}
>  }
>  
> -- 
> 2.41.0
> 

