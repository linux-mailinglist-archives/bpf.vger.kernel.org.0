Return-Path: <bpf+bounces-59714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9D5ACEDBC
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738BF16F59C
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0E021765B;
	Thu,  5 Jun 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUz+6w30"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C8214815;
	Thu,  5 Jun 2025 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119671; cv=none; b=gt3QOUxyluIRDvIXK7C4ILJcOv/yC0Ir1qA8GnR6HowL3Z8kuGADx1YV46SqUAzvSy1gacDeOUuTLbQrQ/cqQIdgqrgwqYknGhB1armJdKTCaG8ARKh80a4NQopYF84kLu96AMthF4FyLCVrLLSl/0gTgcSDU/ydtb0MX/TfUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119671; c=relaxed/simple;
	bh=kUMBoBt8t+ujGJnuO8GLvVLinOLvSpOK6xRoibGw/OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcHKtVr2RwPkAuQT/ZhkBpkTorZB924P6zmoQWqpcGOQFEBIGR0CwJnmp+t6zJP5Du3CDouEw90/M4F02oGdWMJ4RM0nEUnpIzh9lnAiTwbcEqfFdWmh8436pnYli4rGB6jVshUF3GIVdoMsuQSRbr6A9VWbqVbaumVWWV66ugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUz+6w30; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad8a8da2376so132383366b.3;
        Thu, 05 Jun 2025 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119668; x=1749724468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GY6PcUQ7GIdKlT0RbJFYRR/l5dniLA33UzVFFU3Gb/o=;
        b=YUz+6w30cRtibls6QOLN+AIq1sx1zUbJGt9wYsUAK9kfjfHx+go0K4hxoluqbzVSgD
         jIWuvSXTAuZtN+VuF/CrVRMXsmCiZoeP8ZEZfwg3Om952XC23ldLCn5wZ7IxE2IzRxwT
         MKwCIiWsNxTCOahPW0UwG/tG/tacMMDWIZWSuNLYtkMr0V/U3pP1qKlpkq7GCzqRuaxV
         p2chXOlkWBc3wrbK9xxt5gMPZXYy/RJsxb04icmscj0u/DPakIqE6QvZj6OWteppTZWT
         J01RuQNqKPxGKOlC8jx1fQUTY2nts9iuo4y2QfSSTQTz6q7at3gGfkTVA4Lk1SpYvQks
         kcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119668; x=1749724468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GY6PcUQ7GIdKlT0RbJFYRR/l5dniLA33UzVFFU3Gb/o=;
        b=thBjYL+rbLmgz4PfUM107Ytp1Dw7frHuxwQLVDc6UytQoYyb3VvIa8jndsbIXiyoFF
         hpWIm13WOkdXKPh4Rdg1fhtZKCbovkSejnFmfCzT3b4fVlBKSRXnnTF4v0lc1Fhdvo6H
         ra5QMnNUpEmKo8Ey82eA6VZT+X+cDygL5gB7an3Ps9XG2jDre2+v1wAztfaQhQQ11v3T
         1jAZVagYvDoKkdgeW5xaGJu9J8L+S4+CY6UAfNs7Mh/GW923CjX2CMpoO2K4CfmTIhNE
         ioUNNcDWTTdzKBJ1rwB8GFp5Pk9kRKvB0x+WVBED/HsSrsrgSRkAANv9FZ5slN29ytUD
         gpuw==
X-Forwarded-Encrypted: i=1; AJvYcCU9K0Ur4R5NZVoX61fzZujBBjQySU3f7ZL0bRjQAE81pX5kiGvBR4ZFVZlUDw27sGzs9J4=@vger.kernel.org, AJvYcCV/j0q53I0+e0FuUL8oqLuzQSHg0MAbjdQTAvYIQOefBIcBkAgfJhfLWLqQBIEINbuiV6UQeTj9@vger.kernel.org, AJvYcCWET6R1QGKD7nELHTh+t0IavuHAyRpFKsHANSKgMyQE23/qc3tkETriah02DziIDArKOmnqmSbiWk1JtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dRz0hDZqlY1X2v7F2rZR7902OK3qNTEBQmOr7mwTcmIOwtbv
	M+lOJQuEm8ODGhqFzihrSd4Oz7ldJ7kkLuEgkSJtngycffT+fxMa/BeN
X-Gm-Gg: ASbGncsQlpYgOsb/0EfKjCarZ2DxN3rFszT1hhvuKBenKaYnkLS2kr+FSgdcV1sZ9H9
	iZBbWjWl05cgdqxxg11rEj/sKhOWjOWiXSoKurq1nXpLyzkh0UGIOdN8NoFiOQYI+ziu6bQJYRM
	X3SN5NwYkhIx3CesbOa0dThW1d2EGa7KjqlBDep181/pX5gCNOiVMO4lrUQ3bAPqn42iVkidSoh
	ohXig4MnHRake+L6vSpWYrVBZzE9n9MP3rOp0lWABlpIbyjMMnIHgbX11gH0v8NXUF5PY1qS4Va
	/C36ZipnXC/q9pytQ8pGpByYeWRmQjgALc43pt5AZCaMhCdLhZFHxpoGHpGi/tt6
X-Google-Smtp-Source: AGHT+IHg7fUxzeFW9/vUQ85/5jCtPTR8D+webp6yxNq+RW1s4HYGMF1CvkCl+CW8SjxJJEQWQW6O0w==
X-Received: by 2002:a17:906:81d8:b0:add:fc26:c1c4 with SMTP id a640c23a62f3a-addfc26c29bmr444610266b.59.1749119667697;
        Thu, 05 Jun 2025 03:34:27 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-addedf378ebsm321104366b.32.2025.06.05.03.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:34:26 -0700 (PDT)
Message-ID: <fc705cd6-ad20-4f1a-bdaf-d3046f062d20@gmail.com>
Date: Thu, 5 Jun 2025 11:35:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 09/18] page_pool: rename __page_pool_put_page() to
 __page_pool_put_netmem()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-10-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-10-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> Now that __page_pool_put_page() puts netmem, not struct page, rename it
> to __page_pool_put_netmem() to reflect what it does.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


