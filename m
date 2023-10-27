Return-Path: <bpf+bounces-13476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA747DA11E
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813A0282654
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E768E3D39D;
	Fri, 27 Oct 2023 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7OFYN20"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013E3716D;
	Fri, 27 Oct 2023 19:03:03 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98947B0;
	Fri, 27 Oct 2023 12:03:02 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66cfef11a25so15868276d6.3;
        Fri, 27 Oct 2023 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698433381; x=1699038181; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Io45bblugk6GHU86iMBX0jRVvZ5htGOKZIfVTPVwXE=;
        b=C7OFYN20Z7RnqjfrVa1aHuHPo9it8iC+l+AX/m64I7ZSyu+z9dvXEM4wlNpK83KJhs
         3Onz9N6BbRN6CjVim3MNg++oNV3SEIpIV3jCATSpklqPYFRANOkzjhOoK1C7PfiXwQII
         YijO0MH6VNlk7fhcuObrDddqs8+WHYytAgDfb0vFyRRqCLUa3tTxyVohbDi9AtoY3mxp
         dlFfuFCKeBs3xwA23p8rQuhBdXRQ/pK67yYyvsO1IaIzgTAEAk/WfKGzyDqNaIt78x/Q
         phKc/5Suqze+QnmXCbixQR8YUatrmO4rxte0//AJvo3CcbbHWK6DEvMEUFfWBhlnqwrS
         ga2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698433381; x=1699038181;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Io45bblugk6GHU86iMBX0jRVvZ5htGOKZIfVTPVwXE=;
        b=MTQ+abfI55fcdIdqM7hU8FtzAoeCYp2dEMuU4tyogMKgofd6eS4i7I+KHTJF8WYi6A
         RBbT70ralyB2Xjngd2ouV5mBzoNHye0qt22YZmhJKsfjBl86azDriSUR4yhpjqEXKS49
         8zr+DehAaoVMlZLvMUh4usOihYaRP+suVs0Lrx/nUEDLL/StGLRHvD4qzUVFohHlr3ox
         eIeK/2iq9EvRbU4lVKsbPNpT2ZDzzgvpj0EZE6bHwgWLkv4arMaVWv0G8UmIJBuOqdPt
         GkJbORmJT5zCoMvxE+nyIzuD0AYsjms7wjx+TuyzG9o8uEue040avX0p9Tc+2a2t45ac
         lQng==
X-Gm-Message-State: AOJu0YzCXwAbrmleO59bnKw8MSPs4QxZDQi6bM/cXzvc4kyZ31DLGBvr
	5PbPWGHUmIgVQODXde9+HTappZiyCA==
X-Google-Smtp-Source: AGHT+IHfYJEilVaXWDYjxblIhjiDRowZ6QCyhiNfjv4ef2Fxjo2bamCtWSGzTr57wERF8ldHGodJ9Q==
X-Received: by 2002:a05:6214:c49:b0:66d:9589:6bb6 with SMTP id r9-20020a0562140c4900b0066d95896bb6mr4058302qvj.63.1698433381324;
        Fri, 27 Oct 2023 12:03:01 -0700 (PDT)
Received: from n191-129-154.byted.org ([147.160.184.150])
        by smtp.gmail.com with ESMTPSA id ph4-20020a0562144a4400b0066da90f0c19sm844422qvb.24.2023.10.27.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:03:00 -0700 (PDT)
Date: Fri, 27 Oct 2023 19:02:59 +0000
From: Peilin Ye <yepeilin.cs@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Peilin Ye <peilin.ye@bytedance.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	Jiang Wang <jiang.wang@bytedance.com>,
	Youlun Zhang <zhangyoulun@bytedance.com>
Subject: Re: [PATCH net] veth: Fix RX stats for bpf_redirect_peer() traffic
Message-ID: <20231027190254.GA88444@n191-129-154.byted.org>
References: <20231027184657.83978-1-yepeilin.cs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027184657.83978-1-yepeilin.cs@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi all,

On Fri, Oct 27, 2023 at 06:46:57PM +0000, Peilin Ye wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 21d75108c2e9..7aca28b7d0fd 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2492,6 +2492,7 @@ int skb_do_redirect(struct sk_buff *skb)
>  			     net_eq(net, dev_net(dev))))
>  			goto out_drop;
>  		skb->dev = dev;
> +		dev_sw_netstats_rx_add(dev, skb->len);

This assumes that all devices that support BPF_F_PEER (currently only
veth) use tstats (instead of lstats, or dstats) - is that okay?

If not, should I add another NDO e.g. ->ndo_stats_rx_add()?

Thanks,
Peilin Ye


