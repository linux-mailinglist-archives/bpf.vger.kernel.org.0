Return-Path: <bpf+bounces-79453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9286ED3AAD6
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82EF6300D291
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DB36E499;
	Mon, 19 Jan 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYiIrJRs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6036D4EE
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830881; cv=none; b=Umycgcx0lotVYJFNoDHechWP3c8ONtaaI5w2i1f5piZiJXOhfwkdj4grqcjZLKypO40kEswxzJgYRp5rchECcKGjBFyuzq4BgTsSylijaIf3U/3/KmuRgCgwP4LNi8Kkc0XuDmZXGyOEGo2NNK1TqedNXJ+Bx5TlUYy9eUXTue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830881; c=relaxed/simple;
	bh=lo81BFx/Ulv0xcaPTgRdmV6KO1F84bHVc1SQVycS4S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8TJ/9s6BX/uyKGq4jOvEPoxeut9Lgiy2ljUEDbaz6VBAuJfAYH97E4LhhgFrX4ixnLyKXozkGm4Xb4OvF9gB1IFCyiIgtn5JDcBM28f5tJqog0Oe3JhDfRCLSBD8r8z7tikvJ3MmktW1oXDFCKul3wehDTIDUr0Ey6C5Yfgn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYiIrJRs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so3367822f8f.3
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768830878; x=1769435678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPy6cjzmHwuoEQvvRHEOfQ3zwGp51DN3ulInpeNRzkQ=;
        b=OYiIrJRseciC2w1wnZYx/HQx+/0wX9AA+uU2X5/x12E/i8fcD9BBGk2WIj8Vzl3nQ2
         heoHllWVgyETGz3o9UJgZUj2iw1g5A5wmNYoC6B6US3c9/XQGop6MP/TI4iL4MetxhRY
         Kgm5v0Ns51mj3FsZElRH0eS5inpYEalQgzOnzZJg34NDzxt6sEx55JnBLY9QqwL0TAZM
         yKR9AQMFWpTfpCIbn+BPlWKV+6IlkWqzjZnim0bEJWKxZhSFiE9zCJqz4FO0cu+JXDSh
         KRlwuTmdMrX0dyEWK65U+OJAyPp+Pq2QXSV3yn85P+XNHgTTnyyXX46U0HrzUcZZQLQD
         EG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768830878; x=1769435678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPy6cjzmHwuoEQvvRHEOfQ3zwGp51DN3ulInpeNRzkQ=;
        b=W23I/xwEnH7M6E51t7sWYNJ7S0AvTz0iNf2NnwVw3/JXnS553Z9D7Oz0Fma+/fZ30F
         syKdw6xcgJVoVtBv0QKhHYkUhmr2cBR6oUuk16rhL7fqFbzr3fkaon6yOSypoMpTdDxq
         rpEKHCQOGyDzS80ot/Mn6WlbyrPJehaPQQROZakAvI1J9a6fGn6aViAc21biN7jnZh4s
         1qXov0VxQHzsmjZRcLy411Cd4G7QNM8ToR/9BoRedkccJHPPDpepjq5QB2R2RN5YFuEG
         jKN+bZOrm60tvV24hNL7ZrR1syd6TDiZSJggPg5Ux4l6JOWjNOx+Yh0Sd4lSiv8Pbsg9
         XvEw==
X-Forwarded-Encrypted: i=1; AJvYcCVl3tIBnW7rwYopYWyIxlYhCxSQ+t6WxNsmfuNtgWPZE39UK4qG9DjtjT7rctrhCbdKP4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/n1xHD/NmJ7eNU5itEY8Bn1Q7ankoI2exzRS8rIT/8Uvzc/O
	ZPItTJW3ak5SDyUlJcZxYV4WuqH2nGrG/ZoU4H1uc3ZepUukG7Rlr9RI
X-Gm-Gg: AZuq6aLu+BT4H57xbIOMaNCrF6RvwAIoXHNUjlnUUCf8vss7v+D6pNkmue8umQQdwtp
	PgHYQFAHSk2ciEbYXsrA/k7ckQGMzhhp855XDIht0N7Q5qSzX00ownqLe3Am3LkbZAGo40r6Gsx
	zuE2Ot8tQT9uo3gRHUslcGd6oTdztFZqiW+RDOhq3H+2vnDdwWmNijJYxh+qxUKWR/NoABdDrkm
	76S3/PBlMa1eVRSbKblgWkl8zcEJcRzF2zxJZ1js+IaOqhRBIGazQJijgJTaXtA76JbvzjePOQ5
	PZBDIqxusV5ROstOO87TSncU5QRjJ0O/ZxmnpCepq0SYN1yH5RYPE/ITFx+tWPH1ez/4bCv4rHC
	tzR6iwJAKi/6TbLLbAPjFGYq+70L5px+HQk1peUqqNm7jvs7NdrE/YDY5G/RF+W0wxCQ26fdTU8
	yWgxf6VXqF6ktZFO+w1L0m3mX0aD8CqgMDD/zOd3b0/8SB/cmfkErg0F4tanPCLoWcinmjglTgD
	x2RSKBqOXQOlwervD6j1EwlJZJ70jFcJQ3d6dfX3YR3BRVXsdF46Ttz2tyIbEbf
X-Received: by 2002:a05:6000:3110:b0:431:48f:f78f with SMTP id ffacd0b85a97d-4356996f2f0mr12962136f8f.1.1768830877534;
        Mon, 19 Jan 2026 05:54:37 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm22810483f8f.4.2026.01.19.05.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 05:54:36 -0800 (PST)
Message-ID: <7ab5309d-8654-4fa8-9a1e-24b948bccba2@gmail.com>
Date: Mon, 19 Jan 2026 13:54:37 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/9] Add support for providers with large rx
 buffer
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com, kernel-team@meta.com,
 io-uring@vger.kernel.org
References: <cover.1768493907.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 17:11, Pavel Begunkov wrote:
> Note: it's net/ only bits and doesn't include changes, which shoulf be
> merged separately and are posted separately. The full branch for
> convenience is at [1], and the patch is here:

Looks like patchwork says the patches don't apply, but the branch
still merges well. Alternatively, I can rebase on top of net-next
and likely delay the final io_uring commit to one release after.

-- 
Pavel Begunkov


