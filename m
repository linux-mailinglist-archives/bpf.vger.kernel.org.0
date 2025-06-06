Return-Path: <bpf+bounces-59873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33876AD0642
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5F7188D22A
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E31DF269;
	Fri,  6 Jun 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi0i3Ea8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48119882B;
	Fri,  6 Jun 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225353; cv=none; b=mCuUgD4i0aENSchcuJfiDmW9W/FFudCYRzceRbPpmmnMvic9mPYh0bxUMFRgWZctYe1TQu/mS9hXvhIym/JTiqGzv2iCEeJ+BZ/m7VjV43k3tOK3RvEhbMLIZO4DL6w2DEz8eOC2GWxwBUN7ZznnbFpDK41Pyi/QLyWPMnkUY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225353; c=relaxed/simple;
	bh=Iy1KV7JXA6I3EOHUE0C2W5J/hk51gdXWteXtDhOg3nc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cBq4uyySkQwrsBbdc4mcyh6i5cCjE12S3cimjyNcVDnIh9o+qhKFfaZoEuQGRz9kMsMMRWMV4dTE/SZrWLBO4xv1veeqCQa3OG9FtfCZe+wywME6Kb/0o1uspv/kJqT0zm1FMzqimRx7KjAiooQLpraNSO2aYHZ1fP2BBE5n2DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi0i3Ea8; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7d8eb10c06so1774499276.0;
        Fri, 06 Jun 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749225351; x=1749830151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSJ2nOMt3DuwdQvj+eIgyZPi8uK9VkbTu1kngX3scwU=;
        b=fi0i3Ea8CpJ3vl72LdnZpXX2qXql2NOo0VUbZ76lIlX5OrMomza8QiQ1SEr2jI5Hvm
         Vvl7DlmhMNElpnKCwAuUZ4s/UOGenSkrXPKZTv0SH4RhNfg9qoQbZkdrNmvX+9N7MV6+
         Tek3oXIIiD9ffKcwMzsWVrW10SOjZ9/KNvQIyf0P3KjSutb8mxmc5qy0ov/707jOQDqL
         oo15G23kNRybhsGAiujGIt+Gg+ip4bOgF8dua0zhxUa8UY276z+FJ4yLdPXYzyXME4Fp
         QhBK8PoI/+ZQKg3AdDIYo8t4TZK6nZBn/MB3mfmSOrUWkPccne1xB3mQ3IhVTN1sn9cN
         GNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749225351; x=1749830151;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sSJ2nOMt3DuwdQvj+eIgyZPi8uK9VkbTu1kngX3scwU=;
        b=k0SgJly+vdnubZRHQzM0IZtm5EjIkPK3ikAfcItN5qoCowpxuNNTgxHAW2Lw0p0d9M
         92SBpMgOSLQHCm4zGJH43oAFWgkg+VW+tA6tC6SgS8kfhYLI09U1rg+iUfKXVT2QRSBK
         n1pR34kr7GOTmXIS3Y/NJVbEqFHUfIgDD+8I+g72hiX/ElaxgMftySXVCVWOHf3sDZFk
         MLIkzhPfPLU1xKAcH3HnhQqruicZxTU+UxCSU1w1pPoQsAi4bZE3rbe/hS80SN+zp0A9
         bIhIVuEcrl5xSEO1yXbhwIsdd37pkKbLOh38+2Q81DWFgMbmsiroqmR+2KHuFYij0vHu
         BJxw==
X-Forwarded-Encrypted: i=1; AJvYcCV9sXm23z1MZL6/fl6pxxkKsyeuFiQNgCTq1hYkC+b0zOf1yyPonoIWr/B2mStEFEQ1GKRgiA/K@vger.kernel.org, AJvYcCXJS0fPRNQj8ITOean6EGQwjUDGAiew3t2qrYPQIW5BaLjx+Q/oJfg1FtHMJl1/wBSkfac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OPH5sX4s/Dl+zifDWtL096W4lh1yCKKBAZiUEbtaG7ql40FT
	ngb6fkZA2dMgCxQSk8aaEiXAurFnQ5wv6Puz+fbQiuZImjEKcSYqGR6I
X-Gm-Gg: ASbGncvpoLMEICc9au4clBZ2+YzRmzeoXuAoRhYpfUv/SVjDHc1htvSSKr1M05nbeVk
	xsUsNkS6X09Q8dALhjBm+A4nzcHtPVFAPrmz7jxRoMQkQ35A9+3pAiIQbC9mKSeGumAsFcfo0CN
	k1DBJyXKD1TvOUNmvNIjshKc2tgcOwa09QPsO2AcIwYAC1XGGwVdFVUwh6cZa5MCGohSElIJDhT
	eivZKKZBN4v7Y9UEkOw41TJbw3RD1XqSkzd7Bb7deTIZJOV3tTgKVgelQyjZ5D6CAV1iniRIpUk
	x95AkDsWCjtgyat/Ek2KM7F7LKMorzZAQKDcvRHhlmJaDVhJGJOCNfz+7BtDvmUe+kO+E1y8deU
	4I99aZlIN+FpczWOHLcPu61DlcLFcVpeB+VQ30wgLxrI61Panf7/s
X-Google-Smtp-Source: AGHT+IHOyZ2ufr8kio7mW6JKpaXQHqGUxfJkXqG2pfRQYU79mPpPecjE/vQc/4qOxGRtgKxpen9ahw==
X-Received: by 2002:a05:6902:702:b0:e7d:6829:2079 with SMTP id 3f1490d57ef6-e81a20d350amr5828648276.7.1749225351035;
        Fri, 06 Jun 2025 08:55:51 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e81a4025cfdsm548626276.19.2025.06.06.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 08:55:50 -0700 (PDT)
Date: Fri, 06 Jun 2025 11:55:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>, 
 davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 martin.lau@linux.dev, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 eddyz87@gmail.com, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 willemb@google.com, 
 william.xuanziyang@huawei.com, 
 alan.maguire@oracle.com, 
 bpf@vger.kernel.org
Message-ID: <68430f86f651_266eaf294ab@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250605173142.1c370506@kernel.org>
References: <20250604210604.257036-1-kuba@kernel.org>
 <CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
 <20250605062234.1df7e74a@kernel.org>
 <CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
 <20250605070131.53d870f6@kernel.org>
 <684231d3bb907_208a5f2945f@willemb.c.googlers.com.notmuch>
 <20250605173142.1c370506@kernel.org>
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 05 Jun 2025 20:09:55 -0400 Willem de Bruijn wrote:
> > > > It does make a fair bit of sense.
> > > > Question: does calling it as a kfunc require kernel BTF?
> > > > Specifically some ram limited devices want to disable CONFIG_DEBUG_INFO_BTF...
> > > > I know normal bpf helpers don't need that...
> > > > I guess you could always convert ipv4 -> ipv6 -> ipv4 ;-)  
> > > 
> > > Not sure how BPF folks feel about that, but technically we could
> > > also add a flag to bpf_skb_adjust_room() or bpf_skb_change_proto().  
> > 
> > To invert the question: what is the value in keeping the dst?
> 
> I guess simplicity defined as "how many English words are needed to
> explain the semantics".
> 
> The semantics I have in mind would be - dst is dropped if (1) proto 
> is changed (this patch), or (2) "CLEAR_DST" flag is explicitly set
> (future extension).
> 
> If we drop on encap (which I supposed is the counter proposal)
> we may end up with: dst is dropped if (1) proto is changed, 
> (2) encap flags are set (1+2 = alternative patch), or (3) "CLEAR_DST"
> flag is explicitly set (future extension). 

I was just wondering what the effect is of dropping, and why we should
err on the side of minimizing that.

Leaving it to the authors of a BPF program to understand whether they
should call a kfunc seems dangerous and error prone.

I would drop on every program that calls bpf_skb_adjust_room() or
bpf_skb_change_proto(). This patch LGTM in other words. If anything,
I would drop more aggressively.
 
> Don't think we can rule out the need for a CLEAR_DST flag as not all
> re-routings are encaps.
> 
> But both you and Maciej consider dropping for all encaps more
> intuitive, so I'll do that in v2 unless someone objects.
> 
> > The test refers to a nat6to4.bpf.o, but this is not included.
> 
> I reused an existing BPF prog, it does what we need -
> it turns a v4 packet into a v6 one :)

Oops yes, thanks. I somehow missed that in my quick `find`.



