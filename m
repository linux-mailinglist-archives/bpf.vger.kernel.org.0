Return-Path: <bpf+bounces-55068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F32FA77942
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 13:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DFA16A823
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E051F151D;
	Tue,  1 Apr 2025 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVWGu08b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916C1F130F;
	Tue,  1 Apr 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743505410; cv=none; b=BwQem97RKQMZs6yK9mUbB8jwb8SkLYjLga2wq2V2ZK9G05rMnizVZWETWqEH1a4kOb42HlgXHY80yKgaz6sN5d9Je5X5u0i4WOJG4+m97zq0AlkAkbBFKgGvw8ptbwEhNi9FS6zAz/zri/35JzpZvhNcjoaxEMkGdbWNaZPgN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743505410; c=relaxed/simple;
	bh=sRdpkPtNwW1ehmoWYQUCow6iPrYmHwVz6DA6xwyXI1M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTNYLQixWNkrZWpkXHlMYdsRngiKVOh/LfIvpSKcr0v4Z9KErrhV0uxU3NbZAZtkO4W/IiMkL+5VvdaDlZCXrs7ig0gK+jp7E6PubRWmPsYXonJwOv/riOwtRD+lGIJNfZ4hx2Y+YH5mKhn+Z4MSj67N2VwVD5veXhw69aW7lpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVWGu08b; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2807570f8f.0;
        Tue, 01 Apr 2025 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743505407; x=1744110207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5vyRBE5UcO5Wgyus/xvDrJ++jMsxUJ5Fc6/SCZswt0=;
        b=nVWGu08bp4q6psokzezWo7FRjfRfsA0mfkRQ/fvo4BIMiqI2DOSmeTkUCcesQ1Jm6t
         xsr/NxETJ8v5or09K0cgolY066iuNxCXaP2BVcxVWaKoGbfgnclo7HzGWN4JJtjVCfb+
         fbP33UwJnlPvhg3vI43aEJb+MCBKHqKxlPGofc8SumKTfSTt35PWkzTQxtnDIxidlVp3
         c9DKZvHx+VQ5+/b2K9ATmNDORNYHsVBH3jNXgYwQsrd5Yx8XPHp7x37qyoOeJ2ehN54H
         J8bxj+4qvFzDkNK9sz6JQA6x7G8AQnYdRsAm3rPfMHTqPxLpPWgU5drDp8yMv7cIa7kO
         Qasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743505407; x=1744110207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5vyRBE5UcO5Wgyus/xvDrJ++jMsxUJ5Fc6/SCZswt0=;
        b=Qhkf++BW0CiaRJ15VI021XHGGEbE3WiEk/BUQBtDDtlJ3blMOnMNG8x9+t3GiMUsNq
         nsdlmbCsSwkP0JJ2Jtx6cUyEoUqz5EwurDVyW6amUd8Sefol/X88I6p3NbDFs7Jem5q8
         v5NHNWmeKEqkvRmxigxuzyDBMFgzvF8rto+mwbjtf8JVHhKHJ4qM5yNubtUqOlmfDcxJ
         5gbqWpv0PcIUCPTGaFkvfZ7wZ9tB8QjkE4YpWEroUBDO0oaVdlz9ZdahUnuZnMyMyasQ
         4OSLHHfPlkxXV6ABMqEBZSLs9aTKQ3iUbfxMaUoXoRbMejb2ZpDeiWAlytQYLZYRZQw9
         ISLA==
X-Forwarded-Encrypted: i=1; AJvYcCVC8/leqaRiuVw47nKVwX8nx8O99xeH5MqzNhHGH9ChoWrQIkEDu3O71N6qWiR6qz4zEKQ=@vger.kernel.org, AJvYcCW0/GdKFB2wflED1J1gFSdfB4UkqvVo2DQj3MB9hILsKeAtPvnUv+oJJtRgU8bY6OF7F8dbYfwBhWCC8Ee3@vger.kernel.org, AJvYcCWTh3JMAM0ufBDhAPnOVb1OpYVM6dIP2OnGYxh3+5kY7FSxr1/S6VFa63neAnpG2clDsv9Vk5gs4SXPijACEZOkzyzQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39MT2kbllWG1Cy8Id5334aJn4JWVXfcASoO6JeO50GNMmzb+b
	EniPxEwBhLk18FurI5Ryd5uR4Isie/5rOCDz/Rm12eOCK/rQVD03
X-Gm-Gg: ASbGncsZIN9c5UJ5SDKDcfG0kU7bD1rx9vdGYx/s61gl1xme7wfMI7TwkkHFufyv8tz
	rNmavjHn3cN0azNdnZKnJJIdfaPqpgIylfqc4+A2zi5IdhsIINWHK1bzYohPrVh8EY+TnOSWqhX
	c8SkxY7jpLFZYVNxcHMisJE2nJN8lOqkyUi4G06p0+tymwQWv9WHW2IE4hjE8Ox8NYjcHk1JtOY
	dtApbfQkn0Wpd5KtukAe3ktVBeBhpylN2hKSzoq4eDRIfrAtViysTivWApqpROpoHmkhFwidimn
	T/GkrQBD1D8JcPAdAI7ileU0Qd6uYb4=
X-Google-Smtp-Source: AGHT+IGlla3kKE0UcDRyduOczcrnncudqMMZ2hNAiBfzyv+brvYk4YBXN22uqELIUFkfSZ9H2qksNg==
X-Received: by 2002:a5d:6da8:0:b0:391:3028:c779 with SMTP id ffacd0b85a97d-39c12119a0fmr10185363f8f.45.1743505407066;
        Tue, 01 Apr 2025 04:03:27 -0700 (PDT)
Received: from krava ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e097sm13592599f8f.80.2025.04.01.04.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:03:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 1 Apr 2025 13:03:24 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, laoar.shao@gmail.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf: Check link_create parameter for
 multi_uprobe
Message-ID: <Z-vH_HiJhR3cwLhF@krava>
References: <20250331094745.336010-1-chen.dylane@linux.dev>
 <20250331094745.336010-2-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331094745.336010-2-chen.dylane@linux.dev>

On Mon, Mar 31, 2025 at 05:47:45PM +0800, Tao Chen wrote:
> The target_fd and flags in link_create no used in multi_uprobe
> , return -EINVAL if they assigned, keep it same as other link
> attach apis.
> 
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2f206a2a2..f7ebf17e3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3385,6 +3385,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  	if (sizeof(u64) != sizeof(void *))
>  		return -EOPNOTSUPP;
>  
> +	if (attr->link_create.target_fd || attr->link_create.flags)
> +		return -EINVAL;

I think the CI is failing because usdt code does uprobe multi detection
with target_fd = -1 and it fails and perf-uprobe fallback will fail on
not having enough file descriptors

but I think at this stage we will brake some user apps by introducing
this check, link ebpf go library, which passes 0

jirka


> +
>  	if (!is_uprobe_multi(prog))
>  		return -EINVAL;
>  
> -- 
> 2.43.0
> 

