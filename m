Return-Path: <bpf+bounces-34302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483392C551
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21520282A0C
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABAB187852;
	Tue,  9 Jul 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0hnsDq7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620C17B05F;
	Tue,  9 Jul 2024 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560603; cv=none; b=anp6mkBMYVGuvSKh0yCHbDB89/HovgvfZCmYZ1jG7YEskVtWgDrVUCzh1YUTvymxkZGUUdF0OI8Z/qPVKlMxQDrxwPqV0Xb0d1gSnxtAAIK0/OpUU9tsDdky0J3hxBwTPuo+R1h9was+TVox63SWwWVNv/3g9LP3ytXTRwL69G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560603; c=relaxed/simple;
	bh=NwcHMJbDrE9soGYhklNbRSR1jDwfxWXbqa6zKAsFC2o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=baOyjCg25qydGzPjATyLdlv8RwEEn5Gb8fG/uiQiHvZsux8UzSRk6IkdqxD5mGzfKaQSqhWWNW/SveagjfIn3epURnTk7JpRzQCuRcTW3SJrH+yqSFPJVsbRgKCQZI7oKjg7rj8dt4DGO9yfpXudTFbQJJSji5g4nYOfgx3Gq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0hnsDq7; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64f4fb6ce65so48133477b3.2;
        Tue, 09 Jul 2024 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560601; x=1721165401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKz3aaHbTh5s5ue20BmsZpd/R0LLlhTOaVxDAJ/1Gog=;
        b=R0hnsDq7O85DB6i2JOC6YPfvi3Hlqbd55STv3C2tYzxtF+5BE0HifScY6X5MBzx6CH
         XMFLWDZwYlLbVaGFg+kDSntpyBH/X1eJHELANCI6fBpAkFFtkSQDSi6k0VPIGBR9TiPU
         Dj0yYgACe0Zh3Y2AL87qFxIoeR/cXQn/lVKCoZARxeg2+vCAjW6G61+YsbT8zzaOUCUU
         NCbw95HXk9dvv5y1Bb/xNf3uYF+bwRZ7GTqW6IzoowrVeZaaWUqZQSivlpyVhvN6tIhE
         LhYuwcDifKyfy62a7QXxSR3oD69VvXSa7Zr5lgeSsKx33iYzT+n6TNEmyjiweBQfkGqi
         9dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560601; x=1721165401;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mKz3aaHbTh5s5ue20BmsZpd/R0LLlhTOaVxDAJ/1Gog=;
        b=Mgoer/gSSTBS908J51vhErNBjg5he/HWdNRX3iVWIyBhtvz68RGry7/WSoYk3YhUV9
         JCwb4XfY5UzSaEtT6Rrb/HXEAx3aUyn1NoGv322W9ZQcJuYfdd2ebY4sDXRXqPPWJkb3
         MI5klNHKYIv72s18caiKzZiULahkVufAcLVZzZ5CLjp9TMU5tbRx3eeTku1GwFSWkGsy
         OZ6uo5HcWC4c/CnXuok6gvr5nXsbLI365st3DfGRgLza3zVoNPFQwB+qHmg2B+yi+20a
         vxaYvJpUF8vIvjUIWEN1JvsQJO5GIkdS2WsML8aMlE/bF+EeqpP11nsfpsO9cG1MUlWd
         TD2g==
X-Forwarded-Encrypted: i=1; AJvYcCXvIs1AsnqtbIdvAYxNlyvCgKvSZ25BmY8tQbLB9RbnJTgV4rm14dbIqFhedIbleeVcCLr0cwpoxaD4jPvyHx9ji2MaELTVLP3n/y9LkE+rn/7DkuK6Q+Rr215t/xhw7xtRHPTZ9qQKUlJCIhrvxcPqoREqgdEYtp84
X-Gm-Message-State: AOJu0YzXf7hHwTAe4BCDAH6GUPnJ9QPhPgKRHNe8N6aBu4k2z8eYamRC
	/Y1IKj6ZcoqgYgIZ00SLwb9uqsCcQIZegattdg5BxZMRha0y0DVq
X-Google-Smtp-Source: AGHT+IHPgmrIrWc+akDsVCRw/o70dfEXyctNlGAFU6XNW8HLCynReHCIx9+9XFyceGpSaMFMYRXL+g==
X-Received: by 2002:a81:770a:0:b0:62c:fcba:cfeb with SMTP id 00721157ae682-658f02f5e93mr42238597b3.34.1720560600845;
        Tue, 09 Jul 2024 14:30:00 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1908ae8csm134094785a.88.2024.07.09.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:30:00 -0700 (PDT)
Date: Tue, 09 Jul 2024 17:29:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Fred Li <dracodingfly@gmail.com>, 
 aleksander.lobakin@intel.com, 
 andrii@kernel.org, 
 ast@kernel.org, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 edumazet@google.com, 
 haoluo@google.com, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 jolsa@kernel.org, 
 kpsingh@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux@weissschuh.net, 
 martin.lau@linux.dev, 
 mkhalfella@purestorage.com, 
 nbd@nbd.name, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 sashal@kernel.org, 
 sdf@google.com, 
 song@kernel.org, 
 yonghong.song@linux.dev
Message-ID: <668dabd7e7066_1ce27f29435@willemb.c.googlers.com.notmuch>
In-Reply-To: <Zo2auA2r/hkJWWcs@gondor.apana.org.au>
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
 <20240708143128.49949-1-dracodingfly@gmail.com>
 <668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch>
 <Zo2auA2r/hkJWWcs@gondor.apana.org.au>
Subject: Re: [PATCH] net: linearizing skb when downgrade gso_size
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Herbert Xu wrote:
> On Tue, Jul 09, 2024 at 11:53:21AM -0400, Willem de Bruijn wrote:
> >
> > > +		/* Due to header grow, MSS needs to be downgraded.
> > > +		 * There is BUG_ON When segment the frag_list with
> > > +		 * head_frag true so linearize skb after downgrade
> > > +		 * the MSS.
> > > +		 */
> 
> This sounds completely wrong.  You should never grow the TCP header
> by changing gso_size.  What is the usage-scenario for this?
> 
> Think about it, if a router forwards a TCP packet, and ends up
> growing its TCP header and then splits the packet into two, then
> this router is brain-dead.

This is an unfortunate feature, but already exists.

It decreases gso_size to account for tunnel headers.

For USO, we added BPF_F_ADJ_ROOM_FIXED_GSO to avoid this in better,
newer users.


