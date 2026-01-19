Return-Path: <bpf+bounces-79392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07238D39C17
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D6D63007C41
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154A619F40B;
	Mon, 19 Jan 2026 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUVIeRYz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4321E091
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787135; cv=none; b=b6Wmwc/ptOAd82DfxC7JlT7mcOnmQEwC3yPAfklT1FJoRtAUygEWF95pIFzYCUrNpgpt7Vwj3SzdkF3BKMODIE3/9/yKtFNEPe+CX8usZfo80bhYklQcD4WDP0DxPNIKo+6SuvLs3DwwaIWosjqnj2tapynNC8yUR6urzkX0sHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787135; c=relaxed/simple;
	bh=5h2I0YxtJwPsjkMG3LKxuVHco95YcSlv7gHxMC0uIpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejw7GBqXU3QUKSGXCplDBnynL1EZM9I/LqsgeONaxYJaG+StHJa+4G7CovVa7cay+Ipm3TV3207pPU/1ppULsm2p9/dLzn0VerceeqNt0uH9BaR3ZLJ8X+6/sCi0EO17KxsjOkJX+e4L+whsHBvMp8a45TIgQGSaEc8SQku8f+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUVIeRYz; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12339e2e2c1so2255033c88.1
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787121; x=1769391921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQSVsnHg+O3hcpMh47evjUqhwH0d7PCJ/jfr3jwWCIE=;
        b=cUVIeRYzrbTX2DaItH/uaBeIROoR7Lbyg7892DQkPAtQew7uReexSwfR+Bs4GTk+Au
         lMpPzaErZpFsuPdLMn7S26LnxI0bsrWX2IE8nTzvI4aje4uiUYR+35Rud2JpfQnaD3ho
         VNTe6IB70xnQWYB1yxtlBa2/F5B6iHspE2R77SXhFwm+yMky1evbGMRd9j8EOOhGr/ZM
         zR3mMjQ1BxVP6YPqYQAvsZLe0TK5NWC6+47IcztAjR9AXxhe+j0voVTHbZEJl5wilbc2
         Cry7Vm0L12ZzoVg7WwBTjwlsFUljLELELKxLwCEMfY1RhQccV/ezvfdzRZyEHDdqaGT9
         A6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787121; x=1769391921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQSVsnHg+O3hcpMh47evjUqhwH0d7PCJ/jfr3jwWCIE=;
        b=IgT6aZa+cLSj2i8jHJpsdAUC6v+/RRPWr5ZbQ7xwXkbwRrmn48qXzGUaoXSKYCjG9p
         u8Ioa1Yhkhojjw3G+f3ecpIJxc8Dx9PtBpwb0pIKAfLz8SjTTq0ZxY44ZgdRvYnFOyOA
         n79DzrZj9vaTsku/XvBmghDwl6yxGMQauc26/GrXhI/ZUDsWFZalujg5DR8OY354gYzL
         C+6/ArhYKjdBY2n1roV84DZxtZM1PV+7k4qGgvxa2HI8v2fiZYzH1imWyRk2jMKV/Nwp
         JfKDQhxiFXi/d9H4iOvwwQ8TvuS9K1K76tjZQFDgFAnba6EFhaVtoUjnbRSBEgc+gNoS
         3L3w==
X-Forwarded-Encrypted: i=1; AJvYcCVt4Jk3b1XXvJmP4DHsMqXsot7/EaOFXhmtb0mjr7CStXFrrBbmM0gQXE47SQNy9csva04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VzvnZ+waF6Zs4WpusAT6UlN7cYZ0zfFv3JfWmLJUCTbQn0tc
	lOSEwIFb2k2keYMCE6VlOuKCKR2ereT9DCjM6FdAg1KG8GrGl1+bowQ=
X-Gm-Gg: AY/fxX4liGzo6QXig4+c6QL5hYTM8CiTPX4oEFjloL1fkBcL+ngVY1AFk4hY3EoJZpL
	+r+f0fAvrhkrXoAGiv6ZjPLCj5s169uIhPQAVb6HrvAnoujLQkxgryZKXevXIaZtc2N7kSMD7/H
	mb50yyT2BLb/TDHMhUBJzFg56BjmFJjSPkckbF8OsvqhfFT3CXHZfgD8rHoaV4EJ8VHpSQGGgsL
	zJs3acze9s30YnYCAaFL4yll9elFalOvv6BA/i004KSHlJijHWT/UWf2R9QcOQO9/m1phxHUhDa
	/QORwh8K4aEDifhz6biqmdV10hP5LYwiWH39RyGKiXs6tU4VkM7VkKEEboXDcxaBvCP+84FGEOP
	7fPQKSylAM5z5E+z7tGiVD33n07glYYr2vi0rvVfdhNGkXKw6EfFHHoJSpcldKloVbn3mV//zbd
	7leWE0sGocgisCAmhCX0e0LQ4PIK8vlGSpK5p7RbzKkxE94HRY4HBQnfQu/kPQhj7nJSQL4N1DV
	Xe+/uwGDya8cEIH
X-Received: by 2002:a05:7022:2486:b0:119:e569:f865 with SMTP id a92af1059eb24-1244a923b8fmr6685305c88.2.1768787120925;
        Sun, 18 Jan 2026 17:45:20 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac5842csm13609302c88.1.2026.01.18.17.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:45:20 -0800 (PST)
Date: Sun, 18 Jan 2026 17:45:19 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 07/16] xsk: Extend xsk_rcv_check validation
Message-ID: <aW2Mr5Wbd4S2QJbS@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-8-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-8-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> xsk_rcv_check tests for inbound packets to see whether they match
> the bound AF_XDP socket. Refactor the test into a small helper
> xsk_dev_queue_valid and move the validation against xs->dev and
> xs->queue_id there.
> 
> The fast-path case stays in place and allows for quick return in
> xsk_dev_queue_valid. If it fails, the validation is extended to
> check whether the AF_XDP socket is bound against a leased queue,
> and if the case then the test is redone.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

