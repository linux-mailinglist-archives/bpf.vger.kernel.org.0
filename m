Return-Path: <bpf+bounces-40139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE38C97D8BC
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 18:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAFB21DAA
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800C01802AB;
	Fri, 20 Sep 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="P9YTrZY4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3417E01B
	for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851470; cv=none; b=ZIYoQGwoYHzxoarFR79W8SZVxZsRUqI2N5I2s7fzvNAO+SZ9XlasYSZ/kez/a5MunYrBS/03Bvx9H31R7ljLNfr6aTyBSeczY34OEJV52pPrRufGkR6ZZjULJjVqlx+BSbV9vkGIb4yOoBcwmwt07lC4Z/RIvKOy/fAoh5RNPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851470; c=relaxed/simple;
	bh=0VndrB7wUbmZML5AQ3UnMNv6I2BM2u35xkfH2xKB9Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMx236EuiOBAgni0tam/VI9L9/CQ1vTl/ZeeuLw9fPmaBSdCbd7g06RF9tJAv1ZXqy06QhTCZLszx/4EQt5O4QAnamj/w19B+etoFVWqSSGe2o0a8Gy9Q9mstIfaW76p7KdXqpKlXRyNo4vc5/PIRR142PcqHql7MTjY8r1GYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=P9YTrZY4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so19857435e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726851466; x=1727456266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPGcaGILxwhfTJ1AkidUV1js05svfUGNV2qC8S2ASMs=;
        b=P9YTrZY4DK5p/LuSg3f+iCc8bfAAkYHSkjjmzXerwyMe3vn+n+dHTrZweFZn7aHp8g
         EhVLEMSIr5RfKLUcOe04gAhe7pbr1oeemudYbWLD2a39CHhmHSWuGHzP3R4zxr+pMXeK
         1OYB3jSArecRbuHK62VJN6QkxeKkinTX00YGjpGGKL+g2sPIJ6T+J9b0sD9S4RuyzyZz
         mI+GMqWt2lokLMaVRlMEUKX9rEca6xCO4HcdV3YGQ8ety15beBnNBEnwZeGQ//TyGYp1
         FdutSJ91DwzS/kJ4/1chZ1yRLlIBZpGLyTp1WU7eYP0l7HQ0nYS5AaLACcXonFkq1MHj
         sfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851467; x=1727456267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPGcaGILxwhfTJ1AkidUV1js05svfUGNV2qC8S2ASMs=;
        b=ks9a6jNnwIWstdRe89qa/h3m1m9/cA86t7awcJ4/bZL1IQTaTCM5E8wEPiJUgzYMFU
         4VnXct7tQHMSL/9nkaTmHtbivYe38Qx4+wdTK6bctvEzDiD4GV0QUPQmgEkaVqp2YabT
         2u9O2+WtlW2CzJwERRcaYI2Ar3gJMY5bGvhytCOz31GC8b2AVCNpqMhO3/6U2OTIxfDV
         9RdjyXu22A0zwSGXWB5fJ1R2nQOQvxFFtlhhrMZJDCpc5N7sRkWSj+yJ2mBnot0Dpdm4
         H/AhJOdf/RT83eL7QTyHvO+3qtwjLTEa2JwWK9twV2ilKCacIS3ek5R1TSwXEAxBGHAV
         HSZg==
X-Forwarded-Encrypted: i=1; AJvYcCWMP3QmkcPGj15J7UYzHa5PBjozoPBN7YFyKgEmvT+0rdmfr8PGbIqrgMNrp6Xo3qTcUgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVG3BSfcNH4bwfwQvlo/I6hj0QaqRfLymqz9RjwKVi0/qha/+2
	Q181mvQOdElS3Odf7s64aWLOITfetiFfS/IFem6KzaekG/E/gLWQSxCxtvmEqvo=
X-Google-Smtp-Source: AGHT+IH47FhS6BitJFEObpSEKWNYV6OlALdb/YS1wlurIrhxIx0joR4JwIU0GtIJDWKAkg4lShG/Ig==
X-Received: by 2002:a05:600c:1e25:b0:42c:b6e4:e3ac with SMTP id 5b1f17b1804b1-42e7abe228fmr29196115e9.3.1726851465308;
        Fri, 20 Sep 2024 09:57:45 -0700 (PDT)
Received: from GHGHG14 ([2a09:bac5:50ca:432::6b:72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e464sm54855295e9.4.2024.09.20.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:57:44 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:57:30 +0100
From: Tiago Lam <tiagolam@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 1/3] ipv4: Run a reverse sk_lookup on sendmsg.
Message-ID: <Zu2pev10zUAEnbYm@GHGHG14>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-1-e721ea003d4c@cloudflare.com>
 <66eacb6317540_29b986294b5@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66eacb6317540_29b986294b5@willemb.c.googlers.com.notmuch>

On Wed, Sep 18, 2024 at 08:45:23AM -0400, Willem de Bruijn wrote:
> Tiago Lam wrote:
> > In order to check if egress traffic should be allowed through, we run a
> > reverse socket lookup (i.e. normal socket lookup with the src/dst
> > addresses and ports reversed) to check if the corresponding ingress
> > traffic is allowed in.
> 
> The subject and this description makes it sound that the change always
> runs a reverse sk_lookup on sendmsg.
> 
> It also focuses on the mechanism, rather than the purpose.
> 
> The feature here adds IP_ORIGDSTADDR as a way to respond from a
> user configured address. With the sk_lookup limited to this new
> special case, as a safety to allow it.
> 
> If I read this correctly, I suggest rewording the cover letter and
> commit to make this intent and behavior more explicit.
> 

I think that makes sense, given this is really about two things:
1. Allowing users to use IP_ORIGDSTADDR to set src address and/or port
on sendmsg();
2. When they do, allow for that return traffic to exit without any extra
configuration, thus limiting how users can take advantage of this new
functionality.

I've made a few changes which hopefully makes that clearer in v2, which
I'm sending shortly. Thanks for these suggestions!

Tiago.

