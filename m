Return-Path: <bpf+bounces-13558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F27DAA1A
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 01:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF84DB20F58
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBD918B0D;
	Sat, 28 Oct 2023 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2T6KYUM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4820F2;
	Sat, 28 Oct 2023 23:11:41 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9415ED6;
	Sat, 28 Oct 2023 16:11:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77891c236fcso262019385a.3;
        Sat, 28 Oct 2023 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698534699; x=1699139499; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYVnGp3cT6/jvVqSx9OkSVZgoRvtxkzuv24koCwWOG8=;
        b=D2T6KYUM+NLwFRHO0Cclg+cwjQO+kbeFA34kSNssPvsFCVsOkNYVEId+XkhonvgPCe
         GHiS0nIo9nio5i7bUfLEVe8BZfLMjZ8LxsCkESzI8PKHJiDwLsEv4FUc8T2zhTml9JG4
         9L1hnJUwUM7DRwYNJvwBK4a2W4hhL1DPCchDPGne/l1Ai9R761vq6zjNGRQi07vh3Z0E
         dMRAMBsksK5osIHPZZpIRki28Xubl5GeAyOhkvyq12DQJQCOquIvnB0Kyjn0bnPqu8Uh
         4yjBRKiXL/C1V7rFAZGbkoBF2yuP3r/Nrj5+efktHyQpmB2bb2b4m79kRC2t/X6h1Lf4
         0BHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534699; x=1699139499;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYVnGp3cT6/jvVqSx9OkSVZgoRvtxkzuv24koCwWOG8=;
        b=mqHEQSAWoq69H0dDXtOG02+RYbjIy7d+CUSUevSvG4nCKw2hJwgGXF0FmA1bSw7V/b
         EG3Bv0NYUNGUyOFHuXqByivQVq1wK5sOTGvLTS1DEPUGMsgOR4zpiCzt4EC8YUpNr7sc
         FcRkcN/trpn17k1O9UizKzG91fB6qR+eIk+Fjvmpu36GwyF/nrKth4o+r+73KgTSpcYE
         ZSjmuKrF2J8u0jCoplLUr9aAo/m4E1gVJTpVxz+W6mwxRwB9CXLcD54itstt9MVzHHQ4
         j7NlJSLJqE8Z6DE5itasS7cR5cBDHxI/RRa/PjNAFwZ/gwXcTDdgzrrKEwkKl1U3Ie0H
         2DAQ==
X-Gm-Message-State: AOJu0YzINiI5maSNlhA5ksFir6lIgheN5kXMRJusASzleQYrYnwEtu1n
	zmJT3GgwgUJZblB6aGnQ1Q==
X-Google-Smtp-Source: AGHT+IGz3+YVwqb4dUdzhuz8wzmFiJtLAHz3MS74BztY0QK4r1cZu0N6BysPVkqTN3lpukHZsE/P9Q==
X-Received: by 2002:a05:622a:130c:b0:418:a14:9c30 with SMTP id v12-20020a05622a130c00b004180a149c30mr8750949qtk.9.1698534699640;
        Sat, 28 Oct 2023 16:11:39 -0700 (PDT)
Received: from n191-129-154.byted.org ([147.160.184.150])
        by smtp.gmail.com with ESMTPSA id z18-20020a05622a061200b00417dd1dd0adsm1968894qta.87.2023.10.28.16.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:11:39 -0700 (PDT)
Date: Sat, 28 Oct 2023 23:11:37 +0000
From: Peilin Ye <yepeilin.cs@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Peilin Ye <peilin.ye@bytedance.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	Jiang Wang <jiang.wang@bytedance.com>,
	Youlun Zhang <zhangyoulun@bytedance.com>
Subject: Re: [PATCH net] veth: Fix RX stats for bpf_redirect_peer() traffic
Message-ID: <20231028231135.GA2236124@n191-129-154.byted.org>
References: <20231027184657.83978-1-yepeilin.cs@gmail.com>
 <20231027190254.GA88444@n191-129-154.byted.org>
 <59be18ff-dabc-2a07-3d78-039461b0f3f7@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59be18ff-dabc-2a07-3d78-039461b0f3f7@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Daniel,

Thanks for taking a look!

On Sat, Oct 28, 2023 at 09:06:44AM +0200, Daniel Borkmann wrote:
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 21d75108c2e9..7aca28b7d0fd 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -2492,6 +2492,7 @@ int skb_do_redirect(struct sk_buff *skb)
> > >   			     net_eq(net, dev_net(dev))))
> > >   			goto out_drop;
> > >   		skb->dev = dev;
> > > +		dev_sw_netstats_rx_add(dev, skb->len);
> > 
> > This assumes that all devices that support BPF_F_PEER (currently only
> > veth) use tstats (instead of lstats, or dstats) - is that okay?
> 
> Dumb question, but why all this change and not simply just call ...
> 
>   dev_lstats_add(dev, skb->len)
> 
> ... on the host dev ?

Since I didn't want to update host-veth's TX counters.  If we
bpf_redirect_peer()ed a packet from NIC TC ingress to Pod-veth TC ingress,
I think it means we've bypassed host-veth TX?

> > If not, should I add another NDO e.g. ->ndo_stats_rx_add()?
> 
> Definitely no new stats ndo resp indirect call in fast path.

Yeah, I think I'll put a comment saying that all devices that support
BPF_F_PEER must use tstats (or must use lstats), then.

Thanks,
Peilin Ye


