Return-Path: <bpf+bounces-78504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B294D0FCA8
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 21:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD0583012EA4
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1871B2586C2;
	Sun, 11 Jan 2026 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE1jDNj/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0E24DD1F
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768163065; cv=none; b=n43RgU5KxWKc1Js0Cm2eym+06V9Cm9lFFTLEw5EaZ7gxkrMM1lsrNkroOOR/2Heg3OFnyadeeSZ1j0IlQ6nmwwVckW5vJ/UV7e6q9XHxPhSrrsWRtkiBOZXrjSm5vXmmJNg9G12aPGfUhZsLrNRcUYVYC5HR6Wu+tCZHwmxUHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768163065; c=relaxed/simple;
	bh=deIbbfF3aE6NEGow9ffRJxFX9y3yO1u7y4vot9gCTNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvzmJrjSKCWS7lJGQUFyR+ZUQc3fHPpo42O6Ee3nU+HUvf94rsCMcN6aEezbmkFNkMy6/O7UrjmeOR0/tB45E7X4TsdZyQ6P9otBaaAc4H6f1snnLEYqtiMN+04Zpek58IgnUbj08wo/MBKKwwfTYBov2I65CPZxD6P/ftfiJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE1jDNj/; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-121b14efeb8so3142658c88.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768163063; x=1768767863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LlzxQrvrypvBifS3gj3xyozetYMJTVLlEycrj5WMGs=;
        b=HE1jDNj/Lw1KeGB04EL4YObjLehjmWyjPk8mrTuwomxmidWvwRSmBSYERZRCOkz/90
         pCSV45YJcFhZ4Y797zGomK28qF5X3aaERweEaH88Bd0WiIHSDB7orr9GFuo/CkDKJw25
         7U06J8DIpwxIrFnKm7KTBOjBDV5JakRexEWdyA+g5zMR2vIxt3hDcrVJ7FJC1I3HM/Q+
         167+hk7vBEO+RvWUGF41QoT6hcofveWUKxnU1N3DdpOa0f2rqBUrA+IxB+Kl2QJuA/00
         5jYosY7C07AxGoGHhMoqJBm/pWRsdVLtCRvt6WcbKE7m6g2aZQa0m3J+UqRFldtpYHjn
         3FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768163063; x=1768767863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LlzxQrvrypvBifS3gj3xyozetYMJTVLlEycrj5WMGs=;
        b=qHYo22NLPN4XRYt7b0BCvUfigPjeM0Xuv1n4bx5M7UXCtrOplEQ3VOVwn6lHHHlQvZ
         gqkO/AQHCI3lmcKx06Ln1zEzlNP8ZCOMWp/CWiTzILnDp86pZ16pEjRE5Lxb3YuzrDTj
         ZAtiJ1gLI+VJ7e6nNxHSwg/vqaqaOI1f/XhIoKQBvZsegP11d6MzXXvVjNJL7Rz4IDOX
         iDe1H98EjO8GiYT4hgdK8vdwcwbTkjY0DXMKZ1qY40uabJ92DMCqManVIQsIPpYLIpte
         Q6gJbdaD0rG5PAfOu9I/R2ZWCwaFGAQq6WpzGLQoi6OfJQqjzQ2uDEbHkx6uyvOc7JgI
         47zQ==
X-Gm-Message-State: AOJu0YwiViQLv5fwV5GAhY1aJ1tirhW45PVOAgDJ73JRYIEY4ZIAWbNv
	3SX6IQ2a2OhJ7gXqgAstuFA/5/6gV92OhUl69YKMhiwuvHlIj4w+kWI=
X-Gm-Gg: AY/fxX45ha49eUYbVtBqOrUBle6b9vPYGzrH0j6OtaxCd4spk+u/UtK9ZY9A0iLorQb
	uJtxFkIzixPRxFQV0t2LOXf7ugx6KhZc3AUhGBYD+my56/9uVr7/IAAA0MFkIpa7f5gOkMQNYxk
	KNsO+mmw9rSTXylFKNS0GRYYVwD/NOG5WXRx7UjU52rYOqwaXY74sSIbvWsGb4do30Z10g/XmEk
	RuzoVGlpDSTi0jnA3Y48XOnw8V1M04Csiy07TIaagDK+sRH8EO8i4Iq4idjSm3uSdzcHiXKTvlh
	hqbW09rFvZk4uA5g6Wxb537p05c0YJnR+kQwX7Wo1d8yEjzL6UvK1mkf1IYTBYDZ7fpI84s2Umv
	e6SaKV5wsY+O2mTS7hK+J8oLG2hFVFGksmZDscrSb0ODztv+AHVL4mSxU+vo58yZlxxNOmqFr0i
	F8mT90px4k77F3tlC2xFwGEWV1flXw5v/0/5Mjrm5qTbBXG/T8LRyhNeb6gqtePVWvN23g1G6j0
	p4NFg==
X-Google-Smtp-Source: AGHT+IH5t82/4L9yYhR9he01IEguX47jqahDJRJ9kRchowIrWjdKOGkJt8ogG4X/WEXF520AltWuTA==
X-Received: by 2002:a05:7022:3708:b0:11a:335d:80d3 with SMTP id a92af1059eb24-121f8afc350mr12072513c88.22.1768163063040;
        Sun, 11 Jan 2026 12:24:23 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm19032604c88.9.2026.01.11.12.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:24:22 -0800 (PST)
Date: Sun, 11 Jan 2026 12:24:21 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kery Qi <qikeyu2017@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@kernel.org,
	hawk@kernel.org, pabeni@redhat.com, magnus.karlsson@intel.com,
	daniel@iogearbox.net, maciej.fijalkowski@intel.com, kuba@kernel.org,
	edumazet@google.com, horms@kernel.org, ast@kernel.org,
	sdf@fomichev.me, john.fastabend@gmail.com
Subject: Re: [PATCH bpf] xsk: fix init race causing NPD/UAF in xsk_create()
Message-ID: <aWQG9Xujon2RWeci@mini-arch>
References: <20260109104643.1988-2-qikeyu2017@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109104643.1988-2-qikeyu2017@gmail.com>

On 01/09, Kery Qi wrote:
> xsk_init() previously registered the PF_XDP socket family before the
> per-net subsystem and other prerequisites (netdevice notifier, caches)
> were fully initialized.
> 
> This exposed .create = xsk_create() to user space while per-netns
> state (net->xdp.lock/list) was still uninitialized. A task with
> CAP_NET_RAW could trigger this during boot/module load by calling
> socket(PF_XDP, SOCK_RAW, 0) concurrently with xsk_init(), leading
> to a NULL pointer dereference or use-after-free in the list manipulation.
> 
> To fix this, move sock_register() to the end of the initialization
> sequence, ensuring that all required kernel structures are ready before
> exposing the AF_XDP interface to userspace.
> 
> Accordingly, reorder the error unwind path to ensure proper cleanup
> in reverse order of initialization. Also, explicitly add
> kmem_cache_destroy() in the error path to prevent leaking
> xsk_tx_generic_cache if the registration fails.

Is it something that you've hit in real life? xsk_init happens
so early during the init process (fs_init) that I don't understand
why the oder would matter.

