Return-Path: <bpf+bounces-30403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F178CD7D9
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94790283E4E
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455C318C31;
	Thu, 23 May 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NhtO7cb9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2644171CC
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479747; cv=none; b=YCWGaOXFYuUoasX6gHTEOGmTHX8gSEr30HBl8RzXjTR+16+ek2MTCWWRfeaRQvH/4gtjO9L7UjJ3iPZSs5pAYt2rZUjF9CvAg6RtuVQhNog28O1oRDFhv9Mr7YjXgD9cUEdMSkQ3tOxVkZMCJl4ygKt3Uy2N9KsRsMDVtDpbi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479747; c=relaxed/simple;
	bh=3gX3Ztjr7i64c5zaCwKW9awJ+IB6EVe8caKn295fLcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeXtZDgCXBDsLQI/IVI79SE1JvUUd7RVRl0LOuN42y1+aotSUxHWMF0bKs39g5rlh7cacZUa73iofBJXT0AzJf9UDY5c5I2Hb17iZEtPvm8jL3GfBckQEqFWkS69SU02nssnNzvy4PqI2AColQ2n8UjQLFLZyh/OHkZkRVgsxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NhtO7cb9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e1fa824504so77084621fa.0
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716479744; x=1717084544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u4Cxm+I9SW1RzY9dhQ4rpc6mA9qWWtUSwtKxHenGgOw=;
        b=NhtO7cb9lspavmAPINrIgc7/qtxGD2hhrhX0MF1ZH4yMVg6hSlwWRw3dRIsYbbCkZn
         0wMZ8kJH/qz4cnTd3+zBXnjACcJHY9tov9AMCdyGhlcmmNKtZBfKCUQDYSAYLdtbP2F1
         IhA5FFr6NK2qcmhH1aYEZOonnta9TOLYc6nms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479744; x=1717084544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4Cxm+I9SW1RzY9dhQ4rpc6mA9qWWtUSwtKxHenGgOw=;
        b=giybnNz/ex3tcIayOw0zo4SIN6EhPpf/ER5iYdbvNtHoybtogHjbd+qjCI0RVP51qy
         uQH8E4dClgnLNXncXriof7nytKtAtiubx2ERxEw+AnZkNIUwf5CiClc6ScAJ1Ik4QM0g
         OapEnTYqS8946SHbBxiaeqkIIcL7ql3HnJnfV0jd1OmrnjmbHu52kTLZ30GPdPKiyMMZ
         NdS9+tk84YgDndsuBRhtmNgtLBT2z/p+XI/N1CilB96gc19ZyYKtnWilr2IiQ9jco+bU
         hTeZhAJ/LMtnMRwmyA8G8c3MuLqCpZvv5OLhWoR+QJkCpkLoeyXT75ErTTf0Ldoo+Qlj
         7/Ag==
X-Gm-Message-State: AOJu0YxXX8h2bJJTk5WwBRPs8gkdOkM0wxeQZ9qXBh4IDoAvJAXahe7v
	m99F+CJ0lEsW2aZvIqsx38R2riWYGNsRaxwnJVip/aFXtVgXuWifGMQ4TFmyrxqaCCP3zEdsIl7
	eLP5MzA==
X-Google-Smtp-Source: AGHT+IGjs3yPEFWA0T7XdLogWiS6xTG4n3/i/+mSzFlioZKWdv/RotQSGbCZ6oqtJuznfUgE6Owt4g==
X-Received: by 2002:a2e:95d4:0:b0:2e1:d44b:db9c with SMTP id 38308e7fff4ca-2e9492c7dd5mr33796101fa.0.1716479743883;
        Thu, 23 May 2024 08:55:43 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e6dc4c01f4sm27060951fa.55.2024.05.23.08.55.43
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:55:43 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e3b1b6e9d1so91893691fa.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 08:55:43 -0700 (PDT)
X-Received: by 2002:a19:e001:0:b0:51d:70d9:f6ce with SMTP id
 2adb3069b0e04-526c0a68e9amr2936135e87.53.1716479742873; Thu, 23 May 2024
 08:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
 <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
 <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com> <CALOAHbAAAU9MTQFc56GYoYWR3TsLbkncp5QrrwHMbqJ9SECivw@mail.gmail.com>
In-Reply-To: <CALOAHbAAAU9MTQFc56GYoYWR3TsLbkncp5QrrwHMbqJ9SECivw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 May 2024 08:55:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwtEFJnDVrkkMtb6SWcmBQMK8+qXGtqvBO+xH8y2i6nA@mail.gmail.com>
Message-ID: <CAHk-=whwtEFJnDVrkkMtb6SWcmBQMK8+qXGtqvBO+xH8y2i6nA@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, 
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 06:04, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> If it's not urgent and no one else will handle it, I'll take care of
> it. However, I might not be able to complete it quickly.

It's not urgent. In fact, I'm not convinced we need to even increase
the current comm[] size, since for normal user programs the main way
'ps' and friends get it is by just reading the full command line etc.

But I think it would be good to at least do the cleanup and walk away
from the bare hardcoded memcpy() so that we can move in that
direction.

                 Linus

