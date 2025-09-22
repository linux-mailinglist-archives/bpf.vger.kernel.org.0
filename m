Return-Path: <bpf+bounces-69252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B8EB9259A
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 453734E1282
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124D43128D7;
	Mon, 22 Sep 2025 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQbC6712"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432642D739F
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560972; cv=none; b=SV8EcixjHR6FfTDVzIOIkYqEyzkLg1j2yIMTUiPKXWZvBM3GwllJS+QHAXIs0Hg+B6Kk41FPUzma0OCnS02bArr3b3MhUrg6vR441/MfGNBx76/jt65tr34sNVQysdhdQ00M4Z54KaGkE7G0K6MqDZmBY8wQ+TT5/j+Q5yLiI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560972; c=relaxed/simple;
	bh=fT/psD7+Vz56LrFxpZ7ZEzjPhzQjHq7F9NH1iMHhNGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7GRA5r4E9OIfcVEq78Ni9TZ+z/AfmwmmFFa/BppwC+eUF6ncMHjhQgCz/ApPdGkYGxDvLTqcOcFgK0k9iAX6Vx+GmDLlyzV33HvbilqtBSzpiyuLQMOVcsbueWG3Gk/lBhi00LJwE6AiN5h3Iiss4XG7YBMGQICs9p5v5xgdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQbC6712; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so3423117a91.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758560970; x=1759165770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMIgCfI8Zy6cU8RYUy/WiEQmMhMNer21IBatYzMRFPE=;
        b=bQbC6712jZYU5b+mfawQGA4nEWQP0x8lkJi+Wuq8gOPqQUAl1R80wSSXU+75EWC9tv
         n12vaxszJtUQ9sTw0QQ9MojBQkoCb9qEXJa8yjPL/vwpIWIKiMGy84iOKNRPVQ1ju6tQ
         upwvm14BFUiON6gBiH01XV2izHO77DEovChFEUrSiRUYkvaA1ww16O+ArKGt8Qefx2Of
         lbUdhOfPlk5W3VeWsrGzSUkDHO3s1jt2KaW/l5Wp24FRNRPh9++sRrQTdVEmeRu5bx/S
         TRRhoicZzxRc7NaMbTWF26ohJMOq31fXgcADB6Mdua0bWjLM4cr4EfUPGyMlAXCqKW/u
         MG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758560970; x=1759165770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMIgCfI8Zy6cU8RYUy/WiEQmMhMNer21IBatYzMRFPE=;
        b=Oy1+Q1Djc48IP+bW2Yl4i5RnrzM7iPm8XoB1/J6FFCJIpSrMzmNWM17Gl40cIgtMGD
         eoJc9jYYuVUW5Ipwuzv8rTIZq3U9/mm6OfWcrOSaGEmLBviro5EtFz0n0slkJYk+Wtsj
         ubIuQlKBDQnSmAqJTT9Bs4YrfL+IXi4N2rmQFMywU0KrUZCy/nVxEwv/iQjunsaiGMOB
         J4/vuytgGQDoYGF+8lu+jR8CwQNkb/TS2fFQc7leTA3OB3EmatMzz/0qnBVfYtEQz+8m
         /gDXjYjK221vBa9ZAgzvKMwjvDVqEc6LX2ngV+Qwwg4i2OJoenKuVcErT5VjuHWRRO1H
         3YVg==
X-Forwarded-Encrypted: i=1; AJvYcCXuUeuVzuHEoxaKrqIHcjfwQX6vT19GZdaQODk7JnGw7KXN1RVGY+4QYOrJfcIdxEAKEvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwplMyFwy1knZtniTwxnKg28/tRVZTq0cI78nOMGBWf9patzV0C
	ii8IV5JRefHqw2vXlHyif4C5xh+tBZyL/TNMTW7Le1txgbnkc387CLdrqfvl
X-Gm-Gg: ASbGncsZhmXYDtvYY1rHGh+aK23ZNRqOzFeq3jyZojx0XgL8ZBmgjEgOzF29xSasa01
	ggxJkQpZOXXlzJrFFrl57QkUwBvh/SUtq/HzmilQtSX9aY5GPeIZE/HipyXcxxQTGrshq6ptJ3P
	xuT7DxfE0OgGJZLuNy0DxRvTLZTBpOzcKMhvbbWQL8M+b5ZIRluwjexc1iLnOKxj7fEUyYmOqOt
	3H+2NETsvTQ/aMA/7VoY6b7FzBX20xP9i4syJA4bvbwYguv97beUXMzvtloY7AFqnrOPpFQSAT7
	+B6XDn4U2FPjSO/qktlfUeOvOIHN+9geX1DT+rc8KTlSmlJOh8LrzM5w/KI0isT0MyS8MIHw4UO
	K8LjTbkk8IzAM1QY6RzAsNRNrBbI/NOBHize+8U7wzxhzj3/aiXBALnPoZ2OUIKe17SxTKtP2bZ
	cRTINrbMS0S5UJsPFpD84C5owv6YBpxRTT0OYunBSG1Q/auZRzjSayc+uoEG3s5PrZ3pzo7CIp5
	KX2
X-Google-Smtp-Source: AGHT+IHlsA5stse+g6GM9QGHO/6DxDq7onh84HX4mDJJ7uM4MVYbwwbSHEc2sG845ZZJPboq6R2g1Q==
X-Received: by 2002:a17:90b:2250:b0:32e:7ff6:6dbd with SMTP id 98e67ed59e1d1-33090a1034bmr18932796a91.0.1758560970376;
        Mon, 22 Sep 2025 10:09:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-332a68ca99esm31215a91.1.2025.09.22.10.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:09:30 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:09:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 20/20] tools, ynl: Add queue binding ynl sample
 application
Message-ID: <aNGCyWRneDXiUWjv@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-21-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-21-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a ynl sample application that calls bind-queue to bind a real rxq
> to a mapped rxq in a virtual netdev.

Any reason ynl python cli is not enough? Can we use it instead and update the
respective instructions (example) in patch 19?

