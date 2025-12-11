Return-Path: <bpf+bounces-76443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93142CB46D2
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9204430343D0
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 01:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3C2DC35F;
	Thu, 11 Dec 2025 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeYXdFQK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5023D7CA
	for <bpf@vger.kernel.org>; Thu, 11 Dec 2025 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765416675; cv=none; b=sWAKtT6pe4jamzKq4Gp31OrmXZw91GoL+hm4sjwNjPNaSOvmFim8EVhhkEQx1vZZt0mIXFBEEm8NmAbEqz4FqCh3H0cWCd33YrFYJx1b2B/TH+S5U1fDG9PRTthyS8IysWNbrZxgG4Ss5MpOEeGROCNgWp4TzbScWkJpl89gtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765416675; c=relaxed/simple;
	bh=WTGcFCS6w7nlAaqkBZ3n6Gv7wFcX8BfAhcm/JFIe5Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbNO2UGTrmlk0YU7nikYmuD7QZEN5kXDk9v1ZM8QXBD2VB9VuV+5gb6BvJiEWNBeaIkbimry9Ig2CfEAGJ8YqxyPFWjT0Yxpwjyn+MeJ/n754n/uOMICURmki0pKeZyhKOS6ZwkrQhS6oJiQhjbJJXIJo6I0ESOlJ4Q+Z4y9sO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeYXdFQK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b9387df58cso639284b3a.3
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 17:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765416673; x=1766021473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZdCO/Mv9RBE0LHZ0bjkyPo+ciEfdxSfUwGGq9Yh/c0=;
        b=IeYXdFQKWk7t+QfhJqDOEqv0XEjreRqj+MI3d6Je3A12CgF4LpScw8LH8F1RG7zmUO
         JDm06TPyDoqBHiKEZoh9TGOFeAvZ9dpQC46DDNtSEY5VqcktDvLdTtZ9dFj+UNW7Js2F
         TnM61m83TBAWje3XUfVC2rABiD1Zp53TavlIFhJwson7M0/WEnLdqFBcCXpjCBNos6RA
         tsO483vypG3w1MhDgmKNYdMsnFQAbonE3ibAxD0NwV8VoSnLVZ5C9Jang1AuMhNA92r9
         2npaDjbBCEYe1fdrTg4bS5OYlCJhPTy+CoKQpuedqBpFCo5pGA94jJoXUjwUoVfoWxe+
         Zqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765416673; x=1766021473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZdCO/Mv9RBE0LHZ0bjkyPo+ciEfdxSfUwGGq9Yh/c0=;
        b=FrCmV8OkKnrrvHHIDYaUb3r+P2BXtYpNf7TSEumjxWR9a1bL+Dl1u1XGdv5FKKxZ7a
         y50aMUjLdKVIKNX4jl1h3xUoQ/qG5Fe/0Ya42Tiwu31/7mhHT7UhLhdBcmPSYxYUT2bw
         E0mfNpHN4f020/SFMjcY9tpmN5ukHnMdbBbe6eYEQahHGIw84x2qTjUgvBZfzOvj3MX+
         JLGL9CM3SxSFrcBY2puIvqp9MD/UDXpZLjtkmMPlNnkKFcyVuPSmZh0r6+xz34S3RNJO
         QhH7GXkzWfkv5QskTxnKjmwd17D6W7zfwgBDFdZ/dIpVACOCSrddEpB+KHe6ZzmczNvE
         eYSw==
X-Forwarded-Encrypted: i=1; AJvYcCXEUdKvnb4+pccqbPSbIl4lcfo04xbenCO6ZSZl20vHn/aTkn5Ryd7unZo9fneRm0POjKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpuL4FCfHhPiFQsz6hkXZgGOPiJjJwx34uPDinCqPOcQWTRP/a
	ID/QTrLXbmE3mrHnaqbrRiq9X29iw/XkE5ngTeEHuyAokTCsn5TN3qeb
X-Gm-Gg: ASbGncu+BHhlRBc58iS2dRpnoQStrHUQC/N8YZYRFUIasc0pGIN9j5y1qsOtcM9onlb
	BK6JifEzTx9qwUC6yXdJxcff5zuWOMD9iZuj5GZWQujE4kTp7S0lAXdO39cc/uU+OC1/oSD63Cb
	R/KmkvaYrSOaLuErmWd1R03jy3aWVahb1Ay3qtF3QJX/DlGpypSfytvvwOX6ooDCiww68K3533u
	xmsYgATiXmAiyfVuUPVr4hqJb1cWudY9Z6dwha+4kfooEzWUWDGu07maRZrNb75blfa8ed/gzfY
	JABXsDLAugJ52AQbdTZ4LnyvL9/Z5Amrisdgkuhmuz6syuQFoaPSUIFEDfWGc0DIpJjkeo3oIQM
	byjsyGyXifSjuZyzb2jf3RLoUKvLungRNJP1dVDAe+Mpx1ARMhyAAJk4spWyMxTVj94PgNgAu7V
	+3KGbz4LWjPG+AMkN8xhKTankYjcjG1NAbPZJlbx6EHjOqYrNuzFEiCi8OVcEOy3803cH7FTPPk
	v0DvcS0d3+NkzzK+1O521UNDtZcFZrZR987JDb/+ARTPv4300g3FkjAIg4UYA==
X-Google-Smtp-Source: AGHT+IGVt+ykzKwUkvlI66EhGPLEJT0k2WcMqC7wbWNtFp2WzvnzQClEU8G0uA4bJZHHBv9Er2SFdw==
X-Received: by 2002:a05:6a20:3d25:b0:366:14b0:1a37 with SMTP id adf61e73a8af0-366e33be8e5mr4459913637.69.1765416673027;
        Wed, 10 Dec 2025 17:31:13 -0800 (PST)
Received: from [10.200.8.97] (fs98a57d9d.tkyc007.ap.nuro.jp. [152.165.125.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2bfa0845sm618391a12.28.2025.12.10.17.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 17:31:12 -0800 (PST)
Message-ID: <878759ec-f630-4961-a17f-6355df26507f@gmail.com>
Date: Thu, 11 Dec 2025 01:31:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/9] net: let pp memory provider to specify rx
 buf len
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Yue Haibing <yuehaibing@huawei.com>,
 David Wei <dw@davidwei.uk>, Haiyue Wang <haiyuewa@163.com>,
 Jens Axboe <axboe@kernel.dk>, Joe Damato <jdamato@fastly.com>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 io-uring@vger.kernel.org, dtatulea@nvidia.com
References: <cover.1764542851.git.asml.silence@gmail.com>
 <0364ec97cc65b7b7b7376b98438c2630fa2e003c.1764542851.git.asml.silence@gmail.com>
 <20251202110431.376dc793@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251202110431.376dc793@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/25 19:04, Jakub Kicinski wrote:
> On Sun, 30 Nov 2025 23:35:19 +0000 Pavel Begunkov wrote:
>> +enum {
>> +	/* queue restart support custom rx buffer sizes */
>> +	NDO_QUEUE_RX_BUF_SIZE		= 0x1,
> 
> If you have to respin -- let's drop the NDO from this define.
> To suggest something specific - QCFG_ is a better prefix?
> IDK why we ended up with ndo_ prefix on the queue ops..

QCFG_ sounds better indeed

> Also RX_PAGE_SIZE is a better name for the fields? RX_BUF_SIZE
> is easy to confuse with RX_BUF_LEN which we are no longer trying
> to modify.

It's not "page" because there are no struct page's, and those are
just buffers. Maybe it's also some net/driver specific term?
I don't get the difference here b/w "size" and "len" either, but
in any case I don't really have any real opinion about the name,
and it can always be changed later.

-- 
Pavel Begunkov


