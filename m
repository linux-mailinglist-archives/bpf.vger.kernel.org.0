Return-Path: <bpf+bounces-35084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74F937700
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 13:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6531F2202A
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B784D2C;
	Fri, 19 Jul 2024 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MeGx2iKb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B127581A
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387382; cv=none; b=jwZ0gWXmVaSLt22uHq7nG3s6RBeSdukuU8yuwvr0ajXkQdC1uedvT+7G1zMa1pvnYiqX081bPu9iuZrT2WaIXqLbN1Kb5OYQgfEDl4g//AjJq6ewx5J9umM3Z2NaaVcx/Q8TShb30T31UlFaxnLO26ZvK7TC4pVOMf47qA4CkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387382; c=relaxed/simple;
	bh=tgg1iq1rNn28Zi1QR8Pm6lclS568E9yU/Lu0S4Kc2NE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GExqA/r4SyiyfILGZGZkxBspzWP8bU0T4vRJVOAZEjhodhn9lrUX2n2Ke/nKoXt4BsnZmm9W4a/qqR7zxtORYVHyHtI558y4fcVYXKw4qMsy0LDwHxn4+aqixa5/pDF08gZzIGBmi+X6TR7H5Pm0E4rs7AMx004ywWJasVmvzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MeGx2iKb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea929ea56so2729969e87.0
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721387379; x=1721992179; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2OCtu3JFqtsNZ9BNQvCfRQ65jHo5WLozPcX8irQsO0=;
        b=MeGx2iKbqUyBwCKIKX9fWMQDu3ASi0GxH3LH6q8P2UD+DruvXckZdmQ/f7ARWuBVDs
         B1u0J5P6U/l/ozhqYBGHZum9gs/cd/wQiL1iffHSlIDCgSBlbf4jFM5cgcp7UO3mpCNS
         9rOZxmBz4+OlfMDlI5eO9LJPbWH87pgdGyae7EHp20L3SqcQ6qtcummiMVx9sv6Hva9p
         tsa5ijRg4SJl1gSC0NznIUMl18sUdP6ipAQ3ve08/VGerx30IKhYrQ6qoMCnHCJeojoC
         Zz8/zWLYkRjYnvN/Prsa60UqocXrAfS1vEyKN1pZlG8T7wT8Us4xuEv55PX1sc8BBMr5
         vwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721387379; x=1721992179;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2OCtu3JFqtsNZ9BNQvCfRQ65jHo5WLozPcX8irQsO0=;
        b=UErUcGJ+uzuJa0wuZ33vLh9UDGBZfSYXJKFOtBLR5A4BUmWHulcE/004sbZRhZ68mg
         IerpvHhIdR+mFxTNVBe13Rp63M/YPtXIYK4XAYyvLWVF+xnise4XcI3Ew6yvgeZvvLmv
         pV5zaRs5SgwqsoAyEcsy0p4aR8JHKP8DpN4yow9T0dAAdasjd+1nWCipBvyrorX2mbyd
         RpMbVJKaR4LdVSwvsiuz/y5SWaohVZkF2SqL3WcJ2SFx9AHvpgZPed3Y2KJsKeqNQ3nJ
         d42+WdiOSlTWPzpGKaWKaxsCpSTtvvOSQigA/FUUyH5G8UjlrAm8N50S//dE0yMksbEB
         1Wbg==
X-Forwarded-Encrypted: i=1; AJvYcCVou+uHB0GQ6cZ+CAyQhqrMoofrydiPcQz3av1qKFJTw/sFZjpKQnHRlkd3afMfvqcd9u0RYcNmuSEH2DNzzFL4DBh+
X-Gm-Message-State: AOJu0YzEgKa7ER9JQAPVFontEuSV5G6Uk1RnsD4c9jbw5sQC+XXdlgAr
	LvBnp7OOQfNOxsFl9z1x0irYsI6kzCJzIOIIT6DqaSDacTSY9c0VPwetL34j+alQQGx1Fko8xUw
	Mc1M=
X-Google-Smtp-Source: AGHT+IFlBsaJvLhSq6imNBU5GGgARvGlrOZdfeq2kAp8vJ43kCCHdiXH1jU8u3w/RmJchY2+gc5QZQ==
X-Received: by 2002:a05:6512:10c5:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-52ee5433b93mr7545903e87.52.1721387378840;
        Fri, 19 Jul 2024 04:09:38 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c9230f5sm16326366b.187.2024.07.19.04.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:09:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
In-Reply-To: <2eae7943-38d7-4839-ae72-97f9a3123c8a@rbox.co> (Michal Luczaj's
	message of "Wed, 17 Jul 2024 22:15:02 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-3-mhal@rbox.co>
	<87zfqqnbex.fsf@cloudflare.com>
	<fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
	<87ikx962wm.fsf@cloudflare.com>
	<2eae7943-38d7-4839-ae72-97f9a3123c8a@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 19 Jul 2024 13:09:36 +0200
Message-ID: <87sew57i4v.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 17, 2024 at 10:15 PM +02, Michal Luczaj wrote:
> On 7/13/24 11:45, Jakub Sitnicki wrote:
>> On Thu, Jul 11, 2024 at 10:33 PM +02, Michal Luczaj wrote:
>>> And looking at that commit[1], inet_unix_redir_to_connected() has its
>>> @type ignored, too.  Same treatment?
>> 
>> That one will not be a trivial fix like this case. inet_socketpair()
>> won't work for TCP as is. It will fail trying to connect() a listening
>> socket (p0). I recall now that we are in this state due to some
>> abandoned work that began in 75e0e27db6cf ("selftest/bpf: Change udp to
>> inet in some function names").
>> [...]
>
> Is this what you've meant? With this patch inet_socketpair() and
> vsock_socketpair_connectible can be reduced to a single call to
> create_pair(). And pairs creation in inet_unix_redir_to_connected()
> and unix_inet_redir_to_connected() accepts both sotypes.

Yes, exactly. This looks great.

Classic cleanup with goto to close sockets is all right, but if you're
feeling brave and aim for something less branchy, I've noticed we have
finally started using __attribute__((cleanup)):

https://elixir.bootlin.com/linux/v6.10/source/tools/testing/selftests/bpf/progs/iters.c#L115

[...]

