Return-Path: <bpf+bounces-43351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52209B3F70
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAEA1F22E85
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D82225771;
	Tue, 29 Oct 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/bWwpUt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6874E09;
	Tue, 29 Oct 2024 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163824; cv=none; b=f4hulkxZJZHB2YLdeaDgj8TNRvEDGmt6pAMnG/+eF5OZqe59Vcu8hUKuQp5x6oz18ZQq3t4MsULb4n5RnYtK6QBIRtxiFfmwqoinuU/CIET4UU++dWKqRCVBY+aCoP3Umv9ZlNV1YKYtnKA2XqD9KzuIT1IDwn9ttvctCo4ey2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163824; c=relaxed/simple;
	bh=FWX0egdl1BuPgr+nQLtHXLlNw3yvDJC5E2/ybim5Jas=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RoQbRRsdwTHoJUR+hPjji38WdtojcUm1iPislDSBpLSb0gCmc5ArtREWoqNgi+ok3bkWNSC+WGYjhlxYWL4UvDBc1Ek7AfoW8sEEMb43dKGL0Z64TT9OJFritu4I3LB9k9WkSOH3Wsxm+8di2c0+7IlpM3+0mFicopgtH4GdnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/bWwpUt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b15d7b7a32so432350085a.1;
        Mon, 28 Oct 2024 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730163822; x=1730768622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc4UT6ttj+g3vDITLDAT+Pf5vbIeYisK1IzVfoJg4Ew=;
        b=M/bWwpUt1BVxVd9sA8/kerk5grtAVH3AEthgKUERJlfq4zy0Ty3o84FdN5M/G5twHN
         Jq2IAN6J9rByG9gjj3252LzjPqKcRzUZZoKSU3ZPwN0gSaAZ0g2a9zUsbyatq8oueN5q
         SBuDFIwZJKSQ8zjfFl2eQFYIZoGpwUNt4SI6mJmvkqn2wEvr4jPGtjVypTbYULy15Uso
         iMa/OXNXO7tkTBy3nY098nMbRo+XjJzPp4Do00h/5rDhcOIm13rSQoQ41YEfnTqv8QYO
         WuHRSyEQxod7985GzdB5DIBey21ubdPyx9PbHBpjo+1u8prauw0vvxW+6SYBY4MLhOY3
         l1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730163822; x=1730768622;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cc4UT6ttj+g3vDITLDAT+Pf5vbIeYisK1IzVfoJg4Ew=;
        b=ja1Y7fzA79+cGlQTnhUA4NVsA3dVB+riRhpy6EInlzcwz3IWaWa3VRFrFP9qAkyZ9w
         4cIYmmP/Anr4c+meNAepbouFBI22+rttRcLI7esYXp/OvV8CEcKeafhIfLFHerRatQjx
         5cB7zJgqd4sn6fi0M+IMllbkgoL8VWAoOXLaMU/vBE4m/T9wRAYLESfQHuI4HbRAQJxj
         IB4j7Pa5DRKIr+a90Y93DMZRnDfwmhHjtBdV2dJIP5y/7KB0bsFOYSTEY+CArCVKvwV2
         92cBAkBqrS8ng8t2cgJdf4KcV5lm+hQ2Ma4hm9OVOu2cVCVfpYAN6yXmm0cST8dQdfn6
         ohjg==
X-Forwarded-Encrypted: i=1; AJvYcCVyGMWy2AjSRdQVlNKr5b/gXBQB0muIqp4TpSyKCCEclQ0mggMsantCD5cDU55LZLw/rUCIuhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTiuOlptuvl/2NJAFw76aS1+PIN9yazSqOeLQTj8OjCHNUbC3
	/h2/ySt4bp0Ua5JEVx+vD+OMO1LoI9YJfoZe2m9bZkjdIlZtJJEv
X-Google-Smtp-Source: AGHT+IG3DzRh/DXHZArMa6qoe1xWCszQ+XdA4BRkB9IMEDd4rrnCIzcV452Q4Mo62awAYHsgdJDP4Q==
X-Received: by 2002:a05:620a:2722:b0:7b1:557c:666f with SMTP id af79cd13be357-7b193efa197mr1761737285a.25.1730163821666;
        Mon, 28 Oct 2024 18:03:41 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d331b0dsm372527985a.91.2024.10.28.18.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:03:41 -0700 (PDT)
Date: Mon, 28 Oct 2024 21:03:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6720346cdebb6_24dce6294b0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241028110535.82999-7-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-7-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 06/14] net-timestamp: introduce TS_ACK_OPT_CB
 to generate tcp acked timestamp
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When the last sent skb in each sendmsg() is acknowledged in TCP layer,

nit: last byte.

The TCP bytestream has no concept of fixed buffer sizes or skbs.

