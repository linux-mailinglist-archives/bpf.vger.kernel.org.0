Return-Path: <bpf+bounces-14959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F242E7E92E9
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFEFB207F0
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 22:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09521BDC4;
	Sun, 12 Nov 2023 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtYSa5uN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D41A59C;
	Sun, 12 Nov 2023 22:09:35 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D779259A;
	Sun, 12 Nov 2023 14:09:35 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b6a837a2e1so2248504b6e.0;
        Sun, 12 Nov 2023 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699826974; x=1700431774; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJQfI3uTcX5wmYL7z0/RuGNi+JZUiRyow3G6wraozrU=;
        b=BtYSa5uNjDtqjv3rRR9nEMOZRd8zsMXs4T1r/FL057oSTwwC/T3uJu0hO6D6PRk8cC
         J6dmdAHPAO7ms7z7akHfawpu0MuhSCtG/t44GTstVa/Im0gZ1w/k01ZaN70yXjOlKmqg
         4w9GnCuojEgxxcrFSY81vYEO8luLR27dvYoLoAIDiJF8jVoUMNk9+ts/hv5faS1F99Ge
         27fDRGCUMxI2NtYjtiyGpw08i9w8DVO6kRCnNq6aRoEC3YQ9rJ5W+t4tisVZPw8Ulopf
         dWoEI17oupgCf4Zfvp/fT13WDIASrnEDeYjoRW27Gg22plDdttTtjKaVOuxeWjGTf+uF
         VzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699826974; x=1700431774;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJQfI3uTcX5wmYL7z0/RuGNi+JZUiRyow3G6wraozrU=;
        b=sh0+cQf6DJf9ExEZXBNXmG5iW7r0VIIqa/SbhTtg9gzDo0VbiNgtRPx7U2n0po/g4W
         h0PpWstW8N3tFw+a0r990DZSTdRvdLQFkjg+tELQG3ru081pm1MCYC2hBzc69+e4Pb8f
         AITxZgLmBq5piDGSXvBygVaxcO2bX3un5WiqHC+PJK2NvuxStny3OQjTvuxG8kC/sjzc
         cKtUNv8aFKi+bTvCUlELqDsJ8N2zPo24zg4ez2C81W0X/n18m3Gu/6hvszU8LYQ8+rDT
         T82PJZDtoKeI5dIMh1+UuDJyoWzUyVWnrNEEFPc7SIuVQMLY+MJ5EIxypPi/3czJTo98
         MfRQ==
X-Gm-Message-State: AOJu0YymaRb9KDzwIVjE4jbP5rod10YzR1H2H3qhwB9iome51ur48fMO
	JcHNzGGOOiJfvzKeB4wDOA==
X-Google-Smtp-Source: AGHT+IFKqVDdNR+OTznnRtLES+0UZh/cxuVY48N3DH04VIocNN9UpCtBRXvWd0zuebuQvT9dM+sRFw==
X-Received: by 2002:a54:4397:0:b0:3b2:df83:a760 with SMTP id u23-20020a544397000000b003b2df83a760mr6866945oiv.41.1699826974298;
        Sun, 12 Nov 2023 14:09:34 -0800 (PST)
Received: from n191-129-154.byted.org ([130.44.212.125])
        by smtp.gmail.com with ESMTPSA id tp9-20020a05620a3c8900b007757eddae8bsm1419892qkn.62.2023.11.12.14.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 14:09:33 -0800 (PST)
Date: Sun, 12 Nov 2023 22:09:32 +0000
From: Peilin Ye <yepeilin.cs@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
	sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Peilin Ye <peilin.ye@bytedance.com>
Subject: Re: [PATCH bpf v2 4/8] veth: Use tstats per-CPU traffic counters
Message-ID: <20231112220930.GA3368259@n191-129-154.byted.org>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112203009.26073-5-daniel@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Daniel,

Thanks a lot for taking care of this!

On Sun, Nov 12, 2023 at 09:30:05PM +0100, Daniel Borkmann wrote:
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Would you like to add your Co-developed-by: here, since you've changed
the code?

> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks,
Peilin Ye


