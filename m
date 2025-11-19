Return-Path: <bpf+bounces-75018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6232C6C2BC
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 01:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E729349CFB
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 00:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A821B9FD;
	Wed, 19 Nov 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXWJiPPF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D31F3BA2
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513398; cv=none; b=JhShovunxUK9bwF+BWRLoMtJt5kDX1ZVkijLScSSHtm/2f0S5C95kZ64H/YnNka4qaAdPUnZ2sZ9V7097YIHxaBCJksLOP4vaaAf4Zstib4XKrZl5258G+27rp8zirWjZ5lhw2rXQeq5+cfUhtRFekVgCah5GCzkS7nptovkRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513398; c=relaxed/simple;
	bh=oKXTLH9B+kZojIKvhH48FM80MY3iGUiNLr6BAXfHHf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9Y3DE4CSEZ4MMisS6opRR8bzyQICIGD6WCBPKjGFVoToGg+qcvVxqSVayE+CURsvR1HptOwQXnfXyaHpYpppJp3WiDT/IK6OuXPOPEVVKBrg0nwt2QHfvEiTf98MK2VZUl/+nO5CKxlYa4FVH+a/VKgy0wrdqlABRQff+LL9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXWJiPPF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343d73d08faso415678a91.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763513396; x=1764118196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1JZP4mJOczUNP4pl5LS4F0RC54qpkfUlqRw4pgbJgQ=;
        b=jXWJiPPF/UyM0htAyQWXtj40Uto5qRz23YbBn/9oqGsaRuEGDnXuQ8Kd0EFJHaBELl
         TsAbquFUn+QQLSYHIcIAzij4QUoIjTjZ2DOoYzdmY2eKInS0w6FS1fFNZKO5IRz3RwmM
         NgGJ4yLsxL7rbywK3zRyPFGMYLEYerSAXw879U8rLCWj6QYkTISG8yWHgNy4EwYsjsgA
         zY+67FuqJG7aRkJzTUyIg50qC44GUGYgol2YVXkRlNp0i4iNlkwFwmDhiHOv77hNxZso
         LmXpywxxpl1QkOwDDyIS/AK5m8VnKqbc8TwrBYYM2LTt5oKz2pIOduQLk666eR9IaTM6
         3sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763513396; x=1764118196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1JZP4mJOczUNP4pl5LS4F0RC54qpkfUlqRw4pgbJgQ=;
        b=xA7mekOuUAcLtUINOV5ub7s2vNc8oIanaFRi6A6k7W2D3/uferQaVgmbcF92LsGh9t
         BfKquV99+4AzES2nJGmkzMCGgJuOFOgJ5pI6DxNM0Zs+P/+OFDhzPllx+/wQMGC3+QKk
         ZQ0kmTSjlNfZLid+5b0xIJ9nA7XOJq0m9iKt2c+MOrqoDbGpYAEVCdFZ3mzyCqfQLdd6
         UDveLxyZgrsvEue+5N/ZDNmB2dbxiD3ag9nZODW4rp2xgDFqk5vmQr3CjLvNBNIobkBt
         47fekWWID4do3hIGqyCdT5d8XFDTPuiKV0LadJ8Kt6OKxf2RG1e/Tl9h13j9nIPi9/MH
         uWWw==
X-Forwarded-Encrypted: i=1; AJvYcCX5NuHDwK/KnpDt6ArgLdrnsGGiX6j7iNlrE7LE5F/k+oh+N/AM+WtAaix3H2VcKdPMqsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJYQ3RvVpDMIifHQVJ8Ad9pApRptbjBGWgV1qxX5HeZVBw2Kw
	QNfbY868dzqOQBgUu+1HOCJXWM38QHqNLh8B2aTeuIg4xStUE0lpRVfD
X-Gm-Gg: ASbGncs8lh16S7hkjNP+BPWQRAdHykZs1cgo1cCSMPuIMzalEsU6uOz9udWMAvxTlR2
	CetYoKUAX6yiY5Z2MabznlitfOQ2l6GHUmcwd0aPkmqw5UznJDO6JJrIE0vDkI5LgrttbZVLdMZ
	NpE90L0bOpWD+7R+S1H/iBsWyEaLVEzQPvCci2SL/N7H+faPBZ3x8MjMUjXn+sBd0lzoEH+zQL0
	7DOuHbU7yHh2ssBzJAm7fo2SJ75rCdhi7vMxKn31H/Oi+MqFO24tbE26xdsbN8HnT66PGJweNWX
	2AzRJCxUhTC9n9w9CUzac1r2w/Tg4DklS0vRIdbD8zSF68T4BCCvYqMbeq0tlFdnd6SLAMcA1dm
	jmE2cXARUkgFPzGiQ3ZbW+SWNLXgTqq5dCOTl9WlZ1CzV8QrijqKgI8KbRUj3GE93LL0sGlyYcf
	SqPLsRjQiqQ3+MJ1h/Cc7MKSo/78mkRzeqwqe43g==
X-Google-Smtp-Source: AGHT+IE8JxmF1L3MBeFjrjhCVliPKr3nWeWpK8dN326PMLP1SXtwFKRVIWLKhkDIZdOHuuTrc26bbg==
X-Received: by 2002:a17:90b:1345:b0:340:29a3:800f with SMTP id 98e67ed59e1d1-345bd3038cemr513343a91.15.1763513396057;
        Tue, 18 Nov 2025 16:49:56 -0800 (PST)
Received: from lima-default ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bbfc8d8esm704033a91.2.2025.11.18.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 16:49:55 -0800 (PST)
Date: Wed, 19 Nov 2025 11:49:44 +1100
From: Alessandro Decina <alessandro.d@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net v4 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Message-ID: <aR0UKHeilBX5oTg9@lima-default>
References: <20251118113117.11567-1-alessandro.d@gmail.com>
 <20251118113117.11567-2-alessandro.d@gmail.com>
 <IA3PR11MB89867864D4ED892C677CA8CEE5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <aRy+xA5xSErIb61j@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRy+xA5xSErIb61j@boxer>

On Tue, Nov 18, 2025 at 07:45:24PM +0100, Maciej Fijalkowski wrote:
> Repro steps would be nice to have, rest would be rather redundant to me.

Yeah unfortunately I don't really know how to _manually_ reproduce.

I don't know why I'm getting these status descriptors, but I'm getting
them reproducibly every few minutes on ubuntu 24.04 across 3 machines
where I've hit this bug/tested the fix. The machines are doing ~300Mbps
of UDP traffic, some of which is done using AF_XDP. The AF_XDP code is
TX only, so it's executing the build-skb-in-zc-path all the time as all
the ingress traffic goes to sockets. 

If you have any idea on how to reliably produce the descriptors I'm
happy to give it a try. 

