Return-Path: <bpf+bounces-75678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6EC90EE4
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 07:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E13AC898
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 06:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4882C3278;
	Fri, 28 Nov 2025 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiihxpRm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94322264619
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764310675; cv=none; b=rH+sr6/2ewf5o5fYULBaQH6/ALnJzLeKIfBo0iiLbhSMSJv3WaFKCyNEneV1gqTYr/uktWhJTl46JVp1VDgoNyG9yqQT+scJCJUqVlEtK+WrY+H+3hFQUrvUmEiF5FqQjw9oLdqclkAzYL3a2y2rF33Y/YRBlAem3QgojsijBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764310675; c=relaxed/simple;
	bh=HximMye/VFWctOpP3E4ibp7RMqjgk4RAKfLmlJNJj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZnCPWiQuPmTSSOuRSX782vG5h+Mk8LNbiXmlOIb/vdCX1WdKiFAYIVK5ohlBzP2RvAUQrhcA6Ys54kxSFk9Sv93Eym0GOOs2C8iUdvXNzlR+VUf1JZQO3OruQK+Y9mO9BfaVwS8TOCkLaK6fCOQ84gukBUhnOyK+Pv2yGiQ394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiihxpRm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b713c7096f9so235434666b.3
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 22:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764310671; x=1764915471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kASojpANFdrTQESbj370MQAn4E4rOTxjRuoaZKuKoS4=;
        b=ZiihxpRmbZ8kmdeMJuEz3/6f2Kvr0S+2+J5c44fOfvVqOQUYqyBoHdP7M4jBVDTNHE
         5PwZtgmv7FR214bF4tbcIeRner62j25yZ7yylbXGtsNi9L6f+kdkQOQnWgKFOIxgpG6L
         SsGoQyfAj09bzo5op7S8JHBwoeOSWEyX6yz2cY1kYEum8aXHooCgmvBqyrSppkJ4WIWv
         x3uK8eoYJ6+Gx9ZOeq9QohLezmUrLO5Py8quEr8TlBJvbuOTUR6iRggd7ALsaMP+OIQs
         +abQ5rM3pBYvQzXusW2z+sAHDpO9/6zabz+3/+WkJolAtAmk1PyVfRHcmU9v3bZrtLXa
         XA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764310671; x=1764915471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kASojpANFdrTQESbj370MQAn4E4rOTxjRuoaZKuKoS4=;
        b=I7JZcpcRDL8pnWEXeElTMydZbQcA6rm8mnhS6b3xiXzV0RM1gRUoPMOl0MhFy7W4AM
         Q9mMnNc4aNoCbnGpkf+Kjktdk7SGIKFcN/Rgyd7IFnfx5S+rYbKcI3+i36zhAIN8neOL
         3pP8PbDrfqeay8dPXwLWvksMyPRFUWQwSzS2HtPhag1uLxGisq7FwDhv6c0O6CXZcgwt
         vKrWLMtD/Ve9h2B9VmM4gzOMTIIKtkERp6zWvfbfjaF49k+KtUbWanZwRq6+hoMbVQEj
         cgscVZIOiucf2arMEASXmLnd/2m8AOIVIJGzEugSs82XVUUKXkUya8Muqp15BhIHjx4j
         XT+Q==
X-Gm-Message-State: AOJu0YzWpAQqUk8j3fL2TlOWZmQSoNeEY+YeCBG9Jhw0cDQxthISzDby
	BAXFOM9mOe/aFG6EKcC1viNVAn06yc+cMohAtQ034852WIScaIdHLMhos7sEYw==
X-Gm-Gg: ASbGncvvHoKEL+5YjVmuVdYOxI3ZMG6jBgZTmos5U8Y17CIXuaZnbDl6pb9sfLRkAPI
	3rquJPt0mtjFm1XGP0tHYF5y0GzmlQFSA2GaYQSb8laJfU9/vLQCOnT496BeMCLjGLEmRypLq75
	NM/zhM0idoVHpZhgdbWL9Q7EktzOJCmI8CDouc/k1UsCh6ZAe0tif55kwSr+rK+Itw6/joXsg/f
	IzJvzmU2CptbsOnMCf3gSadIPWZ/t33zLeB/lUldMbutH5r/WEQdEdJmEfjt85ubYG8DJ/wgTce
	seDHZuvL4WuIy7RK2oZHkS60wmByJkgwuuMk49guAEURcWmKDcKPKzayazBBxqz3ijoB8uytD/4
	ZM8Xu4cgaFxJ6kPANa9VlJtEO7bkKQeSaFBN3u9oFYmzDUSqPNK3Byr+5Tj3vp7f+FJSZIylBTQ
	+5lbbVAeI/0EKsc7mi8Y+vS9TCcF1kuSM=
X-Google-Smtp-Source: AGHT+IGI5XQU6hhGhlnQIFt+UgLzfsOmiENfIUKeYfR+0Vi9HKnuJP67c53Sal4qeFoWVQ0PXTH8jg==
X-Received: by 2002:a17:907:3f9b:b0:b70:af93:b32d with SMTP id a640c23a62f3a-b7671a17160mr2913252666b.53.1764310671347;
        Thu, 27 Nov 2025 22:17:51 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c55e9sm354922066b.26.2025.11.27.22.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 22:17:50 -0800 (PST)
Date: Fri, 28 Nov 2025 06:24:18 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: force BPF_F_RDONLY_PROG on insn array
 creation
Message-ID: <aSlAEotGnO518JYf@mail.gmail.com>
References: <20251127210656.3239541-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127210656.3239541-1-a.s.protopopov@gmail.com>

On 25/11/27 09:06PM, Anton Protopopov wrote:
> The original implementation added a hack to check_mem_access()
> to prevent programs from writing into insn arrays. To get rid
> of this hack, enforce BPF_F_RDONLY_PROG on map creation.
> 
> Also fix the corresponding selftest, as the error message changes
> with this patch.

Will resend it as part of a series, as the following patch depends on this one.
(See https://lore.kernel.org/bpf/20251127210732.3241888-1-a.s.protopopov@gmail.com/T/#u)

> [...]

