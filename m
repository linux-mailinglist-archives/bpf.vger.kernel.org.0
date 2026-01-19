Return-Path: <bpf+bounces-79390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B89D39C0C
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795D43008D65
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0A212D7C;
	Mon, 19 Jan 2026 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx1naJSu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D51E5B95
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787095; cv=none; b=ByTbgOn6b8TsaefkRzjFDgRcp4PYgsT9jiHB4Mf8uYtJ2YZ1bpFcBvN3KkuVp0qHypVQvYqDPaxHbQdxyYhwOENM2XzfIb5HSqbYKvNZirXtwCXOWVxifnJ9M0JvHBoOqddAT60TIOTd3OsTmYvUT6hbcON/7X+Od66qxMJw4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787095; c=relaxed/simple;
	bh=9KuyTObjMPUykUaijAfpeU0sbbAFV7MUsPQFsaCvLys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GudplPfkDKih2nleyjEYSqXc4KszImBEdHUsgXFS2J8cGfebILR+G0Bv7xi2LPw/659eW2TE1MVVDuF+ZoNpleRIXTwSxlqCvuSUWob0HBnDzHT/yufNGqHgNxWUfOBrZtacncLmLtCvHzRR5cA6K4D1XiHpU6UtNTO8tULTPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx1naJSu; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6b0500e06so3597545eec.1
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787094; x=1769391894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gf0NuXC7tbrAN9iSYdLmm85bPv740bmc8OaGtqxfNCs=;
        b=Mx1naJSunypotkc/nAceFO2IY69dXBzKzOaOLRAAoUT03LVsUbiWLipLFUD2VgdIUQ
         oreL+W+9K377GmSeyJNP1fqqnfSHbm3aIXYY9EeX3qYcHJhk6SFn1libhKZkh3+gkZ1A
         cMS2f+kE+KPcU0LPLsV9Aw/3pQczJ/0W5EuyKfVq8qBag+yzKkJjiZ/AL+6WpDNCn3Rj
         UWStYLsDcZGRk6iKJEcvzvj6hTXv0CoREsvYzQUIipNerGycnX4kHjuQLB0u2OqiUk4y
         OePlDi2cFJdPffD+EOYc/U4Au4E5D+5biVE6E7gPsuU5ngPlE6L/pz9vTWoRIx2L997r
         3EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787094; x=1769391894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gf0NuXC7tbrAN9iSYdLmm85bPv740bmc8OaGtqxfNCs=;
        b=LMyQNAI1msbf9L6E9nX5rxQ+uPzW5S5pVycMvTqga/g9JKSDpRwRDY4pAsGBwTUPDK
         7idqhnacolHuh4ANd7D50HtvneTtYw9UfXqtukrxemj/uQHDiSW0ajxli+Y/h6D9ANjZ
         YXNqTsEIREdKtSHSJGQkPAj4M0nIRbxbLAanIZKWvhk3HK6blimNwq0srMpjsBpR2rd8
         KU/xrouKRi9kCPjK+Bc9FpAhQ7ffGQmmaVWVkMct3axxDR2I03hGqlRa4cPhyvPGyvsZ
         z/UxL7rY7TTnZjJxt2a3SzwUm/uTuYie5gkbnnnEPumUXRRM4/OWmLCbid3ZqOVDi1QR
         BnJw==
X-Forwarded-Encrypted: i=1; AJvYcCVgZNlvvEWnjFWQ5cPjgfLAP2hG28dob9QfvpoFi8GMS6K5mB6nGGG5OHGJdRtlI8ygL2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm5rtwgAxFpvmpjxe3CC+fwWa5LJt0A4cW5LFNZqRb70VtpULX
	eHErwBS30w89HMptyjRMoA48OFODeGjVoxD2T89vsc70Y0gFn5va68E=
X-Gm-Gg: AY/fxX7A1honv1/B6L7gQT2qZXZ/6rnSzCwx58I9CQSunSF8v+sMGf5tCeHS6IfhyhN
	crBv7tf3AouYTpE68sQpNLlf7Jml5WmhxzbdQsHSG4VGEFYKb9EfgHgH8ETu+91XNCgNGwv84LH
	H9dC+r7QQu+ciIxrlfN8tGhJ3sVq6f9mX/DoHwNw0KQmaEyW3xezNJvZKYz2vx2rGgDcSFYN6Qf
	qlJmPW4UJAXXGJWskretCcp0u+s3puW1RfrE7I9P/eKOcIxeCZlEO/lm8lwryu7+a3JoxOO9xf+
	y9uG76AZeGqKq+qo3vzSWdbmwtHD6U/gdZKLIPJP3gv4vkkJUJY9yipDg4suOmmDagY4j3DNzWz
	8ENmO5DRtKpYmmiVPuhXdGPzn2GZd9QhlyMmcZLu1i/zw7dl0DQJL+02K2rKuOn8QZ1XrJMINJU
	P06AW7pBtC76U+cSlBu702KzK95iJva2Oqoy4cJuzgOW58frmedeb2nbt6nVGM8bRt1UIbWbWau
	IybDl6PqJpcSFhm
X-Received: by 2002:a05:693c:2c94:b0:2b0:5bce:2f38 with SMTP id 5a478bee46e88-2b6b3f2a461mr8971501eec.13.1768787093656;
        Sun, 18 Jan 2026 17:44:53 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c0e22sm10795194eec.6.2026.01.18.17.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:44:53 -0800 (PST)
Date: Sun, 18 Jan 2026 17:44:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 05/16] net: Proxy net_mp_{open,close}_rxq for
 leased queues
Message-ID: <aW2MlAF8Y2XFai8R@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-6-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-6-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> When a process in a container wants to setup a memory provider, it will
> use the virtual netdev and a leased rxq, and call net_mp_{open,close}_rxq
> to try and restart the queue. At this point, proxy the queue restart on
> the real rxq in the physical netdev.
> 
> For memory providers (io_uring zero-copy rx and devmem), it causes the
> real rxq in the physical netdev to be filled from a memory provider that
> has DMA mapped memory from a process within a container.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

