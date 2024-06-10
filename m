Return-Path: <bpf+bounces-31688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208BC901901
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 02:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AAB1F2101C
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 00:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57846B8;
	Mon, 10 Jun 2024 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="csbBepzg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2BF15A8
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717979857; cv=none; b=DNUXBpXHKUaW9U1bPDY+5/XR6ApIiWwrBdKgJrkS79it1v2sjcmpJVNtn0tJGF5Hpy549PRTm/7LI/6B5EDI4vmWxRn6WXd6OxuTLtal95ePIats5BVYxto/u+RKlQI4tnoPWLHocoPAFrYtLENtNIt9icf8FsIVNJDErmp72Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717979857; c=relaxed/simple;
	bh=+o3cil3us8SguPa7qsyp1XhJLUxH5Q1E4SZdY/0NVqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVcTPaBN9xzn0vHL5M6i30IiZXZkhiPWKBdBeTpr86KLCF6TH233veigmb9dufXFI7L5kAA1UOtW0KC6RrC+P01AyjvPwBvLiwygHmleXXF8vb8ijm6zL3QWLwQPpmiFf8VRU1nKvAB5g+WzNjTbBaeHGhO8tf6GmUbA7ZIaIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=csbBepzg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f717b3f2d8so1439475ad.1
        for <bpf@vger.kernel.org>; Sun, 09 Jun 2024 17:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1717979855; x=1718584655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hS7n98TDY72tf1Gt3gpPTHvSO7f4fNN8VMGdhY9nX8c=;
        b=csbBepzgCy2/sm2grtPo5g7NMbzBmk7v6xdD7k9AGN/GGEKXViC9xqtY5trb2MBYIh
         i/kq0rArDrfFJRBYl7JNV2H8R10/VpZv39Mhiwjx7+eqJc9vvzKQfrDIXk+AH6v0oPJP
         /m1BIHOSWOi6f914KovjaOrhM+ZpSpOpmYhQoSsW/WzzSG1ozTyM+Si65w24c11BvF5K
         ds/aIs0C+NLJ1aug8mEOL5Vvr/IRx4jKPvuGTNh+1EyOOGCcWqcAdFlUA41OR0s8erXB
         a7DTLae18dW9nGXgt/R/sdo6KDcwoqOHFdF/8dd8H1hocHE3+GM8HDA0EW5XJwemWmjC
         qyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717979855; x=1718584655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS7n98TDY72tf1Gt3gpPTHvSO7f4fNN8VMGdhY9nX8c=;
        b=iMIoqOdJZNO5dSvikOfM0w1h+5uRRTNp2GgbAXt5pNT3Ct5dTuQtKTKvTXRFTkHisr
         49umr7OX+qDozORDFAPxv829vAFp/j/spvxtv7BCnNYnegeXtP+YCy4ddFy/VpqywpdQ
         GFp2jvO8APbucP09HjSN7fPOFAEs5D4SIcFVRGMcHpY4RBOGs/NbDDAy0z0T2wM8w1DO
         TKfY/BhYSGz0C0kY7ImnNHNKs1a7Acyl6b8Uo8HSXo5Ko/wLlzF6rGGg40qBRyCWpnwz
         ME/we+JIPj0doXVWO88EBI4S1jrPYE117lB7O7zCOPeEtPrty7v9Z0+8qWjLzLfWP2nd
         uYuw==
X-Forwarded-Encrypted: i=1; AJvYcCVLCk2pyXcyec8zOYPQ62V6Zcp/Ax9OJiuJMc/N+6meSBFK/b3FErY1WDQUCKPM9++/9lWV8YeVKCmaN9AR4kNQt4Qu
X-Gm-Message-State: AOJu0YymlwYEVrCex3v62Rj7aGmbVdKuLPhjHC/hKoQ3FI0ddvA1nMio
	ugSQaPCAgKR6uten3punB85Txf6SJdAqNdozc6weEeaMs/8cpW8nV8EYR8Ept7k=
X-Google-Smtp-Source: AGHT+IF/jQhCZx2Abw7DSxRG+gkk1EZNGK2154m819MXP2LbgwzefTTWrobn4NY5q6T/kzn7SpSdLA==
X-Received: by 2002:a17:903:32c6:b0:1f7:18cf:a70f with SMTP id d9443c01a7336-1f718cfab0amr8620855ad.34.1717979855488;
        Sun, 09 Jun 2024 17:37:35 -0700 (PDT)
Received: from [192.168.1.8] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76c240sm71665825ad.89.2024.06.09.17.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 17:37:35 -0700 (PDT)
Message-ID: <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
Date: Sun, 9 Jun 2024 17:37:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>, David Ahern <dsahern@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Mina Almasry <almasrymina@google.com>, Christoph Hellwig
 <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240607145247.GG791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-07 17:52, Jason Gunthorpe wrote:
> IMHO it seems to compose poorly if you can only use the io_uring
> lifecycle model with io_uring registered memory, and not with DMABUF
> memory registered through Mina's mechanism.

By this, do you mean io_uring must be exclusively used to use this
feature?

And you'd rather see the two decoupled, so userspace can register w/ say
dmabuf then pass it to io_uring?

> 
> Jason

