Return-Path: <bpf+bounces-52988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EBEA4AE7F
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 01:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A4016B2C5
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 00:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C932594;
	Sun,  2 Mar 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU4qahEI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD81191;
	Sun,  2 Mar 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740873923; cv=none; b=quv4ew2YQyz8qUL4+4gDmVjcFvBlm/vWVFdC4i7qopRZDkGjnud3eyyaHfXeZ0wqMs2hnAgJj7Me2Ns18FQaK0UodkAKeAD9XPChUeZXmltP+xtkFA7sWM6BhoQG3eRMOH3f+0t+DCXTdqYG106Cp/YFjOsZDXFQJjyse4raTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740873923; c=relaxed/simple;
	bh=pNlHcVYXBb3wnhdO8V+5g9iulhvLVx8j8DP15FjqORM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOzX87nmTFtHSLM0qK1dxylYw0JJl1X/2KOY4cB7a98pcT/NIRmpQGfjyiHfnpQGgT5KuvaIdsi9dV6IRiFC64+Jq4xzu/SsomR1aWq35JVmR9OLOORFFNOecVr4necAI0wKz9JoUQOjXN7CXQCYQyblK6ZrDKnr3uRh0a2KlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU4qahEI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22339936bbfso49097615ad.1;
        Sat, 01 Mar 2025 16:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740873921; x=1741478721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2OyqeouO5QwwnloeGrC+8B6Ecolmoa4BOjTYKWnJQA=;
        b=TU4qahEIEGAB4jLYwfC5sst66H573JkRYjzNqq3P+zyoBEz0N/vp8dzk8DEBOw6Sjt
         8Cd0YeOfiXNtUhCgD3c4B7JgUZmaz27Q8jeOncQ6VKLmqSuhgc9Nbghglz7tdgHWbQ3n
         cF+ALfFpOoN28Qg3bpwCRQVrypxF/RSETXHy7bS2byc27lolJ8F8nZOzdTiOgqrhSVGC
         WVNLLdz8chb7/RLONJHZJv6OperIqOgMGIZiA36OmRjlxqyTX3pJdwLDCAfrg7YKjj5I
         Wx0iRmh3gdkOI5rd7BiWf5prGuZtGMYz6F6ULf0E7Bh0C+ESccqcfjsWuao3bC5V5UWc
         MDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740873921; x=1741478721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2OyqeouO5QwwnloeGrC+8B6Ecolmoa4BOjTYKWnJQA=;
        b=RURdDseJP627LtS1MAjgKFGtmze1MpJe0XTWXbhZpuGVqJEDX0Bbm/l3zB8mQmIzAx
         76mXgPIt5l8YQks+dJoKHVHf+HtqHkkaT8TGqUH84t30k37zfrvv+IuqLPNU5plw7JvY
         rmu0GXfz5wl2uD6zrDvqMDO2iEyL1UFQ+zo4GoUaATnkoT9ikAdD/L22yy3gl3fh2vIs
         fMmldQnx6/C9RxPx1leifGw9WPX6Dw6cRQHOpqybmOH0n1ntO8nakWsmBmmsEOm7C0W1
         bj8UJbZio+mWtSMmnDeVPxs2JzSiB78SKOTJh81lNDUgK/SE2qjVWbmx2M7eZ7DSkTDm
         Taiw==
X-Forwarded-Encrypted: i=1; AJvYcCVI6N0e/3rW/CLxmB277aD0o1Q5rqxlKftfc/ZNmHIIiVUKeT1CRi3LU3fiFvkqtFN544E=@vger.kernel.org, AJvYcCVK2zMm49s02lsz7UZuSycl5KAobBbryUQ9YPycbuag3oBKDGo2Da+EuWKFunkCNCTIU2qnOkHF1uo5z/rD@vger.kernel.org, AJvYcCWLg9TFxVD+QzSzIEHXB1gt4epZSgb3u9f5KrhoLiZEVazWPBh8U1jnK7/eAMDekOeNpM7S2k4G@vger.kernel.org
X-Gm-Message-State: AOJu0YwakPzR/0NH9L7frHWE6uJfzomy5R7uMMH/sPtyX4sl2c8wZPCF
	2mLZrWMD2UbOEQjk3SKNduuMBDOei73srGRK1dwTuQIZfpNd77c=
X-Gm-Gg: ASbGncuUDzykO9U97v45kXcWA92pX/px5Dlz+1xI5Q7ZCYffodjU1YbANBBh6bGPug7
	7/VPKWuXyattfpS9vTlCLTjvYTqhRaqLxlmHu7iqft6EO47OY3Go5DKHGFGcafD4VUOlD4AlHIJ
	4BaK41HMIvSxJDUL9iqgua4p1BdjJ0nO0B9NlW7B5qHBAk0ckOa0HIYsYf5znJSMnAdTE2R3Qmz
	9WQKIcGjKTnG8+i/+FVL9zvT83CWCi0VX738xpytoj53ZyRAAkbLjKNXFcjR4RkQbf+zRPEdhyy
	fMce+GMr35oDz6zslPzjfrR/bdTNit+fw9tKFqmaaC2a
X-Google-Smtp-Source: AGHT+IEd9lfTivWnShpRqTxdD+vlD1k3kP332B8lqkJ6Uc4eu1+rjrqfcJ0w8LbcouW2Va/pgcnL4w==
X-Received: by 2002:a05:6a00:b48:b0:730:4598:ddb5 with SMTP id d2e1a72fcca58-734ac338532mr13579526b3a.2.1740873921470;
        Sat, 01 Mar 2025 16:05:21 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7362a6d925bsm3282613b3a.66.2025.03.01.16.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:05:21 -0800 (PST)
Date: Sat, 1 Mar 2025 16:05:20 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] xsk: fix __xsk_generic_xmit() error code when cq
 is full
Message-ID: <Z8OgwFirBwWrdgH-@mini-arch>
References: <20250227081052.4096337-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227081052.4096337-1-wangliang74@huawei.com>

On 02/27, Wang Liang wrote:
> When the cq reservation is failed, the error code is not set which is
> initialized to zero in __xsk_generic_xmit(). That means the packet is not
> send successfully but sendto() return ok.
> 
> Considering the impact on uapi, return -EAGAIN is a good idea. The cq is
> full usually because it is not released in time, try to send msg again is
> appropriate.
> 
> Suggested-by: Magnus Karlsson <magnus.karlsson@gmail.com>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

