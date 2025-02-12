Return-Path: <bpf+bounces-51322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94312A332E5
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC263A5D1E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A04256C81;
	Wed, 12 Feb 2025 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WgYdRnKK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F620011F
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400751; cv=none; b=tAEIcw/Vr7JJSz2/Oh8lMKjJ74jvoglC3Na1MFzn36J9bVP3/i52IvnefeoWXUjlSULgvIunAWHjLnLbw1vNi/oZt4LDuWhw8tF0FPTh3QkKU/8pn+VjhnYVdsJpUCGnunrhO6TBs64q0Clg1JDYRl72Cyg6xkOeVHRbmLwb0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400751; c=relaxed/simple;
	bh=SWGL+qKoHjkKydonxxolqze9lweGFt9BYvi6cuMfK9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuxQKVqgkrIllptwt+UcYxaVeM8u34BJ5sYZg/KkNDFq++ZAjYoQCRQOGeBuAxR3GjlwYsbusyIce5bgACjVYKjPrNv3+CEr96IguGGzhGYbLO5rlKekkR6cualTRm6IC3/Po14FQnO3ak89+3N0OS/G36GkhNy+aU6D4cn+/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WgYdRnKK; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so720975ab.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739400748; x=1740005548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVfXGj8zpj+Qn/84lGpaV8DSwtFOmUf9lyjwLMDCFsU=;
        b=WgYdRnKKU98hxmfTj4NdEzrl/5kKHlov8hk52uJuTVaMAOoPavfhEo2KrcnNOCnG3h
         5M3W7znDzK87K7vkn3+tyk1wDHUU4gua25xJXJsOnfeI65o+sbFJHTc1LMvLyw7a1oj8
         7BsCStvN1QbJ4R8F/qRF1+1m5/lQf2Wa/NqOD+fxmeJvU1nVKj+b3B4UMPLMiLKquRxv
         +TYBaSZFbOg0fv9pTLutBHGot1RA1sLFS59Y29INwYs7aHoqSFaE6jLjRd4rA26k/Uuk
         zqsXjMXQaJXMQQ9tr8pugzsF+0RxHqi2w6I0hY/tf1+HDfPNMfFY9zQgKx9mx7gVOq1K
         W6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400748; x=1740005548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVfXGj8zpj+Qn/84lGpaV8DSwtFOmUf9lyjwLMDCFsU=;
        b=h/VJyKl2E7SJW4FikVfkLmjTKgzgw4MZqK6MWANjsJ7S6tWTgiNfEA3nIkMHgHhHyo
         CZkrh5jSGxugDRlkjHuvkGzWudhKyV2adMfkS1WdGoT+VVU4NSgtlfkW4kegjXC0Da2k
         C7i7HcE8YLRGZqg0KR4XDPtzjIwl8w49qIy0PzZx24upwmmND4FHg8hKpKt5XYS0XUDD
         oArGQP7So1WCr+yFua//E5QMnM0dl/5hTWzW0rmUT96deC43eLWzBluDU2J4HXIufdl9
         vzxOqUmtBSzwrZgOOSoqx8p/BwcrY5rRjDwS0W9++oMi549oRjUdjOAtXTd/t/FZuHDN
         st8A==
X-Forwarded-Encrypted: i=1; AJvYcCWhF79Fp1kyj1ceihxVpfJuZzwJWo7Uh79Wb657jgyxH5HR/smiDcWLcmOQcYU64r0vMl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl72m2TGRQZ9zWPOm6C7X9oDWVE00giugXodBEp7342kWl8apE
	pLu1lQAYkF5ZNLO6g0LMFpo7PDxKh9FEx48LXNrxgot/bZCJVietxzOjKy/oKuE=
X-Gm-Gg: ASbGncuDOLQJOyJs/bz0r8UfeLGPJYRmHQcBg1w/JLcfV1DQOqtajWNfMDoXCEXfw8B
	Cs8tD16jyCclTripZaqfzF8WItTx+/etQQzn4YusTDgT+z1F7BJ9M7xhhh1MoFA4NAOAHNMZemM
	u7WJvYsRsqOlYu2KCYD/5IRM621U2F+LhRAd4PEOu8WqnuO5WKK8f1cbhdVUR2WRW8olimL1ppn
	Ta6DFFkQxE/L+ilaZBCu5pb6HWoK3SOIs3Tf4qA7fUAFK4m4b/umR5l3sWXjdrEhobpVpO2JaKj
	MmzMoixMEKFM
X-Google-Smtp-Source: AGHT+IEVucKe+Bwn3kpsif8ddoHmG/lUq2XHVyUfI1HDjERU36c7zfxTH6zQqWZ1cuUoUSWMIsoTnQ==
X-Received: by 2002:a05:6e02:480a:b0:3d1:8a22:766a with SMTP id e9e14a558f8ab-3d18a2277f4mr14144385ab.22.1739400747944;
        Wed, 12 Feb 2025 14:52:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed282dd102sm22456173.118.2025.02.12.14.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 14:52:27 -0800 (PST)
Message-ID: <da1428dc-e117-45fe-82a3-26d56b414652@kernel.dk>
Date: Wed, 12 Feb 2025 15:52:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: use napi_id_valid helper
To: Stefano Jordhani <sjordhani@gmail.com>, netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Mina Almasry
 <almasrymina@google.com>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:IO_URING" <io-uring@vger.kernel.org>,
 "open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>
References: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 2:15 PM, Stefano Jordhani wrote:
> In commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present"),
> napi_id_valid function was added. Use the helper to refactor open-coded
> checks in the source.

For the io_uring side:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

