Return-Path: <bpf+bounces-6829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4963B76E386
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 10:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213E41C2143D
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4478A1548D;
	Thu,  3 Aug 2023 08:46:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A37FBE0
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 08:46:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5FF1734
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691052368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B1cxWDb2x+ndU67pctL7lnvKXmzS7BnQj9Ld7SM44cY=;
	b=PTwA/2eittG/I5l8I9Ao5UX4pQ38dQUTYSMXHMWABxzrOplnZhWptPyFoF9y9l4I4QKdUS
	YMvAKvVaPCtK7ksWC3xYIrfyozB2zhoSs7+1QAfxKDgYZsIN4iMc0UG1tLB3Ev8Yq3177c
	ARyY4Bj/l2L3arNnmDDEtfsyJvMw4QI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-_2HSm6CMOL6stN1Q6GgJjg-1; Thu, 03 Aug 2023 04:46:07 -0400
X-MC-Unique: _2HSm6CMOL6stN1Q6GgJjg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63cf9d48006so8123336d6.1
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 01:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052367; x=1691657167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1cxWDb2x+ndU67pctL7lnvKXmzS7BnQj9Ld7SM44cY=;
        b=YtN5N4sbImIsTvcob5vTO+iKOpiBngXKyNyowBRDxLhmrJR54rb93pOq648gcjLmBq
         /NsiVpxnTk3jWU346Xiqx8PpXjL9N2J3la9x+RaqlKgDBZ2hGv/BoUwGb5r28BuWJq02
         nuYPPTXiCNC3Ghl6xYoTpX+S1IajKitt0mshxcxOCm/fGyN2/5YciVih0epgC7ixbXmA
         cOn1ge01GcTKp5lnDCLyzba72UoEci62vsYlTcZ0+k2bSKaS8D3L67/08xe58RvDoY/1
         OF89ZLchHSHbnqho4GJOkbIbQWh/86V8uLxOkMDmmDlGRpF1Q1PdxJ4BhAyKdN6anKvU
         tqqQ==
X-Gm-Message-State: ABy/qLaZqOfJkt6UD8M9Qz8keRUNaZQ/xAYpcvq9KYIsZDPlZMSwtAzt
	vNJWnblpSjEjza+UJJQAhJmIYtXDCht9Vl0mdpFxO2Vcivx49G7PoK/dG/nGwg1+cPaJW1re4td
	l9PG6hLYMg+yv
X-Received: by 2002:a05:6214:e86:b0:63d:3d8:6d8 with SMTP id hf6-20020a0562140e8600b0063d03d806d8mr24282815qvb.28.1691052366952;
        Thu, 03 Aug 2023 01:46:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6NZmrORM9rCMWYcM6pMH3vlSil7zGmArCAmNU+w3SZpSN6MIk0SsBfNnHcf4dt7iOKP131Q==
X-Received: by 2002:a05:6214:e86:b0:63d:3d8:6d8 with SMTP id hf6-20020a0562140e8600b0063d03d806d8mr24282802qvb.28.1691052366707;
        Thu, 03 Aug 2023 01:46:06 -0700 (PDT)
Received: from debian ([2001:4649:fcb8:0:b011:aa0c:688c:1589])
        by smtp.gmail.com with ESMTPSA id b4-20020a05620a118400b0076c71c1d2f5sm5012609qkk.34.2023.08.03.01.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:46:06 -0700 (PDT)
Date: Thu, 3 Aug 2023 10:46:01 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org,
	Siwar Zitouni <siwar.zitouni@6wind.com>
Subject: Re: [PATCH net v2] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Message-ID: <ZMtpSdLUQx2A6bdx@debian>
References: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 02:21:06PM +0200, Nicolas Dichtel wrote:
> This kind of interface doesn't have a mac header.

Well, PPP does have a link layer header.
Do you instead mean that PPP automatically adds it?

> This patch fixes bpf_redirect() to a ppp interface.

Can you give more details? Which kind of packets are you trying to
redirect to PPP interfaces?

To me this looks like a hack to work around the fact that
ppp_start_xmit() automatically adds a PPP header. Maybe that's the
best we can do given the current state of ppp_generic.c, but the
commit message should be clear about what the real problem is and
why the patch takes this approach to fix or work around it.

> CC: stable@vger.kernel.org
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
> ---
> 
> v1 -> v2:
>  - I forgot the 'Tested-by' tag in the v1 :/
> 
>  include/linux/if_arp.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
> index 1ed52441972f..8efbe29a6f0c 100644
> --- a/include/linux/if_arp.h
> +++ b/include/linux/if_arp.h
> @@ -53,6 +53,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
>  	case ARPHRD_NONE:
>  	case ARPHRD_RAWIP:
>  	case ARPHRD_PIMREG:
> +	case ARPHRD_PPP:
>  		return false;
>  	default:
>  		return true;
> -- 
> 2.39.2
> 
> 


