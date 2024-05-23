Return-Path: <bpf+bounces-30428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB08CDA5D
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 21:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DED0283581
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C248287D;
	Thu, 23 May 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kgrbl/Yd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBC842067
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491021; cv=none; b=RWKCa8fTxuE+s3fz8eGAxZ8Gp3D+ZJI8HfWyvsoJgEWQujcNkpZGJkUo/gaZVcyoIFZ0yChBPnQmt8OCFOSOpaiEZc41wU0SKEXYUWz4+usNfUBwOasL1slqwc74EHnDITLwMfV/6qROs9sUtr5hjfAmA0a9UMkMTzxL/Y+2R0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491021; c=relaxed/simple;
	bh=qz4H5gdKwMYHrWkklEVDwzWw5jC9xZru8VTxAx5zOpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7wgEghR82wQGrgcKXQ8ZkB0+DuWsi0hqRSVKhuDWFRQZLweP4RcXAMHNZQwionBzNWMKp/Tl/vhJrK43mkQOEzWsfJZHW+NKucahXtQirhlYqVpeuPeQn9c8S06qvRMp7FqC5up9FWYO/S2HYhusEexSd3GzBG1MieyBg90lDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kgrbl/Yd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a626ac4d299so1235666b.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716491017; x=1717095817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SEOOe222bgD8uBXMvqgINByafZXi3I56R6e176eQiSI=;
        b=Kgrbl/YdpHoleFz6BSXEsznRhZ/blpUtnfoaF8l5WrM6das+tPh/3JiGoj6zbbChn1
         sV+NJPWaHl1nasUAt0Aw+hcHNFHMWRuk9QQP6gohXoxuNrzKDrjj0Hw3B3hduEd7iXUY
         4t+xMBJpzt/rXvoD5OWqBPg0gV6RDSPE9o55Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491017; x=1717095817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEOOe222bgD8uBXMvqgINByafZXi3I56R6e176eQiSI=;
        b=mMy90uTl93hrgcZi7WiwarKqrg+79gba9hHR8acKgCndNQnanDRchLE1XHgcuIhmJ7
         r3tmgxjf8u5pjmMCSuGmujDgPjBOBDzADfTdgrXAJtoZvBcoafhmwQ6CigLLlHpUPFT4
         DbU8r1lZbfNUpnlwomb4kcV2jfF3iPr5RJO1thdqIAIS8p2+od+mnffJ89IGjTIVaLQ1
         D2rZE87z/8TLwzQFY+DsrvDvBSsq7M+eFHoNeMIkFRjyjtARQ2P+Ksdz6ey3CAE8elzv
         KN7AxCR3kx5RnHJrWUmntUXpddJOLpVOQVWdtymredqMGccGH+PUTct4F0IzgsGrrBjn
         3mtg==
X-Forwarded-Encrypted: i=1; AJvYcCXdD8n4nHZeGlpRcWvs5cScS/CPYrZXjtvNDeYjsS9EihpXzhCARl9sb1gBjO0QufDzuuc/8ot81lu9iq3mZ93U6cO1
X-Gm-Message-State: AOJu0YwZtBT1v0Dnn805w5ZrlFQ6m6sJkA7x2Xefbl2sAZaZID54dJu9
	+2WWyVTHaz1q4AFa9i9igpSHVZ0bZ3D5OlgpvILqW0D4kQJ6UrKd9VfMnbkqnwacGlDHplPpS2H
	kbIbOcw==
X-Google-Smtp-Source: AGHT+IGS/8bRgEU/N9OY/nr1MEl5dRyuEL5m+rxvNUiSwvf3g2EpgxP3hLcvrocxd52WXVp96N61Bg==
X-Received: by 2002:a17:906:1cd0:b0:a5c:dcd5:741b with SMTP id a640c23a62f3a-a62641cf61bmr13469566b.27.1716491017087;
        Thu, 23 May 2024 12:03:37 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cd627e681sm1194919866b.150.2024.05.23.12.03.36
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 12:03:36 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57851ba16bdso58289a12.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 12:03:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULzv2KOXZTIxm5eQGXS/Jbk0YKAGiTYAQ7AkJeq0ZaLsYdDRx8AVWpdDcYU5nsWPO7ttX2GOvYSdZ6dhcBRwz6aTwR
X-Received: by 2002:a17:906:8304:b0:a59:ad15:6133 with SMTP id
 a640c23a62f3a-a6265111846mr12629566b.71.1716491015917; Thu, 23 May 2024
 12:03:35 -0700 (PDT)
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
 <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com> <Zk98B1FLIAt2SU4Y@home.goodmis.org>
In-Reply-To: <Zk98B1FLIAt2SU4Y@home.goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 May 2024 12:03:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGatHuK-QYhTa2qF+REjXZ4F=dGkQve6MiURpCZvJWJA@mail.gmail.com>
Message-ID: <CAHk-=wiGatHuK-QYhTa2qF+REjXZ4F=dGkQve6MiURpCZvJWJA@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Jan Engelhardt <jengelh@inai.de>, Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 10:25, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> FYI, I would be happy to convert the tracing events over to dynamic strings.

I doubt it is worth it.

The reason I would want to clean up the existing random memcpy is not
so much because 15 characters wouldn't be enough for tracing, but
because it is just ugly how we have this bad hardcoded interface
without proper abstractions, and it would keep us from changing it.

           Linus

