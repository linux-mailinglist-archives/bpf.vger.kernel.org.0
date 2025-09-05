Return-Path: <bpf+bounces-67654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489DB466E1
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 00:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE355C1601
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650529E11D;
	Fri,  5 Sep 2025 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltmnoZCj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F739524F;
	Fri,  5 Sep 2025 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112931; cv=none; b=Fm7eSa4YxYM3Mij4NqigKykj4vpnwU/rtYuLvStv7L75/+F8TxI5287hhmGsvsq1rqT0ksT1f9qOdyvShCzOI2kFNIKRYxmTX3rl+3NQSS6S+mkGFAWIx2fV5iVLva/ds2Mib1W4sRL4G0Uk50e+aJkPWyh/3tpHBo4piUYkw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112931; c=relaxed/simple;
	bh=uPrwK8eVbVphNHUgZAIwlcd2RvMmVsiM3JfQ2OIgcaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+Hy1SEouulKJ91xLIBMrpCRarHsXSYiswSRstjTaoWDGes1Ld66IMRS+cC3aPiv4sIAhFE16aCzB//9vc+UGXDrQ+vzm2YrgDqW39Zeqe9dZMOYwMY2v5OtjgCw/UXonzkO9gtFImTOR7P7WBsB4Hm7Ue6obvBqMKJmRvmAj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltmnoZCj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24456ce0b96so28216605ad.0;
        Fri, 05 Sep 2025 15:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757112929; x=1757717729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mg3xYqjwLPUFZtPsYgAb2K8JTjzAXX4Qv6K23DDcfa0=;
        b=ltmnoZCjpxM7FcopFgu2N9Y0hVVhmQQDaRc4rw9fx0TuNNlqJS0DOkLe8zMrkUgsdf
         8g7TcS5fs2PuNAZigBuCB51iTEl+/LKs6JhEWec1W5BWaw/Eh6MJeWnvuv9NjuCwx7Jf
         lERJu6zF8uC2OL0Ydxi1DtezP4wIQsXNTEee4Loiy+hBh0pm3O3iv9sYlrrgcrCfmKCh
         n7rCyYfpQMKfFbn5lm1jYH72M0ShumFbBeIDbQUiVa3GZcANyhIetNpPA3ZjBkLxeCR2
         UYtQ+rRZkncm55AT5VHsOnByXcJ3WT0bBSXdNnyymD73ebibQJNs+BZ3fn2Yk6NhVYaj
         MIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112929; x=1757717729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg3xYqjwLPUFZtPsYgAb2K8JTjzAXX4Qv6K23DDcfa0=;
        b=kCMLowuhtGW/lLGHaHPSWEgDnZdqxHvFhRZ+NcI6zye6bw8qCiPDAyzZ2Xo/F8ENkL
         qlao6ofa0QfghmOGrDhI0VkUffn2DbGZ/8sBKQGYuzuEH3Mk2rfrosKA8Q76cvvZEO9J
         OAbSY+JoGW+57RRXI8Qze/S1e0IVcAwv7j41XnLbo+jdH7ufZftJgUgTy/nekqVgGdiR
         Qm9V2Zk6QQ0gQ58Se28k5j1XkBQYKIHaioXq7H260f1aS9eyWLbE1Fk3AMKN+90vRw7F
         p/jQfZ0oC6UeVs9nrUao47LSLbXbwRzP73nxHkAY6wbyq5Ce5PPzq0bsf4d3pDkXZBiu
         WWtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXRbZAOFKC5+lh/+MdTlWQFvKTTvwa+39ZIi9zg0fzw8Mm9VIrvRGdLCy1LjXr5eNa3SIqOIE8@vger.kernel.org, AJvYcCVtMllTIQsp7a6iwkuzGSbozK+4CQhtRm1vjEirvORSTr4mlzYd2SL+P1Xg6YW/rr9nrDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0mTajG4ZFafSRHh5oOnYnJ/oYGIjovQTTa3a4vhyfmUsguWqO
	d4GvNcn663HyPkg1m9XByp9mq7zChbkG+mJ7zbwBcqQjvYLJmT+IP4FVn2lm
X-Gm-Gg: ASbGncuJw+KlR/vC1Wj5G5rVaOABOMQXZBPrr48R1MlMbquqvgZh5SLz++5wsilbzJW
	3fHoiBrKM6VgfgMzC1CcUwzP4gmRk9gjLbLcsa5xjAvQ5I5PWOwmG2k5F8sKkl9+hSUQvraJG3V
	yEDP6OHPHGInPiQHDSxWiZu0Bl4Xsov9xNT4ukXv6Cy7PTB8Du+IkBO7AeH3o4pyUhwdgYVSQ5A
	5mHLUj1aqjUUBdOkit9pYX30piJBiauczOZo7601/vH1Pnt2c3IqnkrX+ehtjQq7V6WVZQ4/IN3
	Qe07tCw0lyhlL1bydl5luBoqeJaNw9Xzmce9OL5W2zl3clrXwqLGz+n/bNRnioHqJIpZTmCXRWM
	H/Kw1YGqpOOQqCjKwMYW3HYxH2Qf6Vvk9zFnDnb/pqdQiqvnAWsKmBTkdA4s+lMGIBoDPhYe8tO
	oBZYr7O57EzD+Hu7OiBuWM5w1vUv1+em8eQEbdb7gjwI6R2iJ7BAzDz8x4lVHgCqrvuoWngwG0U
	eaDYHOygGBNziw=
X-Google-Smtp-Source: AGHT+IEMDxlPNlEX4ltt7wQyiTdEDoq95VzBoR5OhvPTvdZUzHQl4pbh1lkHKU8Zpq4QHrWLCHpfHw==
X-Received: by 2002:a17:903:986:b0:240:417d:8166 with SMTP id d9443c01a7336-251788fd271mr3922045ad.19.1757112929532;
        Fri, 05 Sep 2025 15:55:29 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24c9669a0e1sm79220835ad.56.2025.09.05.15.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:55:29 -0700 (PDT)
Date: Fri, 5 Sep 2025 15:55:28 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, michael.chan@broadcom.com,
	anthony.l.nguyen@intel.com, marcin.s.wojtas@gmail.com,
	tariqt@nvidia.com, mbloch@nvidia.com, jasowang@redhat.com,
	bpf@vger.kernel.org, aleksander.lobakin@intel.com,
	pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next 0/2] net: xdp: handle frags with unreadable
 memory
Message-ID: <aLtqYMbHoG6DCXOU@mini-arch>
References: <20250905221539.2930285-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905221539.2930285-1-kuba@kernel.org>

On 09/05, Jakub Kicinski wrote:
> Make XDP helpers compatible with unreadable memory. This is very
> similar to how we handle pfmemalloc frags today. Record the info
> in xdp_buf flags as frags get added and then update the skb once
> allocated.
> 
> This series adds the unreadable memory metadata tracking to drivers
> using xdp_build_skb_from*() with no changes on the driver side - hence
> the only driver changes here are refactoring. Obviously, unreadable memory
> is incompatible with XDP today, but thanks to xdp_build_skb_from_buf()
> increasing number of drivers have a unified datapath, whether XDP is
> enabled or not.
> 
> RFC: https://lore.kernel.org/20250812161528.835855-1-kuba@kernel.org

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

