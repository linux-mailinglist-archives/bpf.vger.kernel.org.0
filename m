Return-Path: <bpf+bounces-28014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9848B4520
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2DF28377F
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9147841C84;
	Sat, 27 Apr 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQVVC0bJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73D31EB2F;
	Sat, 27 Apr 2024 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714206726; cv=none; b=GidF9MTjaKvNBkGQmAx5K3k08niB7nQmEWckrBobyEBCNeKnvMF7dbgbI0K8AZTaXqpq+E8MHvAc3qvaaZ2NBeZGFZyn8bwmbo/23cPOZZBLl2tUl7/Yj5jlCAhtq4OoNspsqLTa0Voi+BQeT8gdOJZYcYVOYxy/LBFzx+zOR5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714206726; c=relaxed/simple;
	bh=LQKtQFGfICkhWNShCYtxeZrqQ+JxSUjc4rQpjDb6YnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYRoAtBEiWrjRJMaB/BOYhMNc+lw5ODhdoPiru5wt20GactG2kqg9xseRmCw1TXn7tgewYlqPevfli6blb8VruDXnY6AU2Em7X+7VHlciIbtI+NvdyamhQ1rYwmBQUV7Z2oytmmTmyos6H8Wa7L+ER7oNaIqWZD0dLnX1x4DZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQVVC0bJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b0fb1b6acfso43543a91.3;
        Sat, 27 Apr 2024 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714206724; x=1714811524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQaOFc7ubwZ2D96Eqb24S0fATFEthxSZzvObmrxGhMw=;
        b=mQVVC0bJ2y9cB+bYhlRgntAzA+MUxpSoLxJMIj+chT+5/zuFvaFYMdos8TKnOTKxHx
         mBOI6r8m0LdNo3HF2dSvbc6Qx+g3QhaCW7oqyTBINMV61WDw6LPhtXUXZgScyqmYKdoy
         ZtIZSeI2YT7z13baCYhYdh0lYAGyNHf0Hp/rnY0bldr7rWquyuuruMCavpKLxaa5HLW3
         NYxOqJUinSEyGpS/8vbO6uEmrnM76TmOEa8wXIjYHzEUjuOFgHyQ25cPF23uPm52QQ8f
         nwCPly17o1GvCkw0X3i7/KGwKt/SYBxZKYhodpiJslzi33ukPFrSuycjHuYS/5WHxrpG
         MJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714206724; x=1714811524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQaOFc7ubwZ2D96Eqb24S0fATFEthxSZzvObmrxGhMw=;
        b=XhvVVaCBDOJQ5H+7ERSFU2/ETskI5hZljUgwWM94Jxh1GNNhhGNRTCF2TeuvPZOknU
         WAJx97/idkHDbBWXFRAsuY3dRawj+fOWkUjWOjmDn80yKR+bvijJCXiACOHeGBye8tTD
         pV+2KtK1wgRuf9EUYCC59ChEehuqk27h1dfzSj8hLQvtjURAQiYMLF13IDppKuCmJxgX
         +16R4a7134rSMpoBd7Ic7jZ1zS9blebj7Szl5zIdN0VWDu2OrJf+/uPVio+9KMd4D+Vu
         2Yr6LVwC+3hXQFe/dWcntkF1dFvR42Ac17klnDBFOM+qtTgusbm5YZqTxPcka4uLGOcO
         59jw==
X-Forwarded-Encrypted: i=1; AJvYcCVFxw+yd1TzhtOI5zPuJbKaJYS9FZdUTvXx/j413tdFF2Vz8Pye3bszPBOZLA8PIJ6ap5tv6weo833JxxPpKa8A0u1JRqTjn6BTuH6NftE1GL+0uh2kNFosGjpEQtBnJshMof4/3/F4ovTa10hyYaq5BLUSNjlKc5dt
X-Gm-Message-State: AOJu0YzQC9qz0++LSNG/3gisiOj7rHp4ENqG6iMezbcMC6Kw8yAbfpYx
	qUaBev2kg2qOCVBuvRdNkZokyjTXt6rsIDHmz/wJzKed9T/t8Ca4
X-Google-Smtp-Source: AGHT+IEZF2Xf+B92YJplkQkqbAqfvWYJPJ6TiiW+JyQHA84zWSjJiIW1kQjXfvXM919Xoqk+2Dr8gA==
X-Received: by 2002:a17:902:ec89:b0:1e4:344e:768e with SMTP id x9-20020a170902ec8900b001e4344e768emr5647180plg.5.1714206723901;
        Sat, 27 Apr 2024 01:32:03 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:3131:67e1:1ef:12b2])
        by smtp.gmail.com with ESMTPSA id kf5-20020a17090305c500b001eb0daff646sm2324836plb.109.2024.04.27.01.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 01:32:03 -0700 (PDT)
Date: Sat, 27 Apr 2024 16:31:58 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tcp_bbr: replace lambda expression with bitwise
 operation for bit flip
Message-ID: <Ziy3/k93gBrykA1t@vaxr-BM6660-BM6360>
References: <20240426152011.37069-1-richard120310@gmail.com>
 <CANn89iKenW5SxMGm753z8eawg+7drUz7oZcTR06habjcFmdqVg@mail.gmail.com>
 <Zivd4agQ8D6rUKvt@vaxr-BM6660-BM6360>
 <20240426201902.GQ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426201902.GQ2118490@ZenIV>

On Fri, Apr 26, 2024 at 09:19:02PM +0100, Al Viro wrote:
> On Sat, Apr 27, 2024 at 01:01:21AM +0800, I Hsin Cheng wrote:
> 
> > I see, thanks for your explanation.
> > I thought the compilers behavior might alters due to different 
> > architecture or different compilers.
> > So would you recommend on the proposed changes or we should stick to
> >  the original implementation? 
> > Personally I think my version or your proposed change are both more 
> > understandable and elegant than the lambda expression.
> 
> Out of curiosity, where do you see any lambda expressions in the entire
> thing?

Sorry, it's my fault to address the expression as "lambda expression",
it should be called as "conditional" or "ternary" operator.

Thanks for your remind.



