Return-Path: <bpf+bounces-43924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498639BBDE6
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FFD281944
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8731C07EF;
	Mon,  4 Nov 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hZFjAXBH"
X-Original-To: bpf@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62126AD2D;
	Mon,  4 Nov 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748067; cv=none; b=WSQ0n+i2CnFBH+2WzjY5VRgYtqr2yOITXoYqEeXRNQfT1dJtoWgKXlDmKMlb5wwzM37AirQW9bGJmdPPC3FUund8L/JlEYrVzaL/vgtdb6DnkNpWReEk3YXGDNcVR9e7iY4RwykyfK+hcTGcqLo9K/zAK7KDMGUVT6bGJJQ8Ugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748067; c=relaxed/simple;
	bh=bPs8vWXRfovlBDcvuDYft3ukyZM8GmaXzcnOrYc4MEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tPqNqvYFEMIs/dPHtJzXjfEEWjypeDfHcjppQnt41mS5bOw5uiVk06m1nIkuSshgU+hrc+2yhppj530axZtrEW+i7sb6VMjxj3RpxjMj87Bujmei26VKQkjjqgqoT6LFYB2uMTJguoc5Z0C/CpoiE+XMsWipisD2MpVXUANb9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hZFjAXBH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3789142C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730748063; bh=bPs8vWXRfovlBDcvuDYft3ukyZM8GmaXzcnOrYc4MEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hZFjAXBHt2/cR2cVoaeLE5fVQsusYt7acjFaBp2QBrZVOWXQ7PakL4wXycQgxCJ/n
	 RBnY11+mz+iBUcL15rDGmjt3awo4jKCEwiDs5gS/6i30NZ11PG/xsi2+xrcSkMnpzW
	 y8Rij4iK8mreajiaMseUH/0Xx95O2q9SwMth/ACCEaJiPb+trk2/+n2zhof/zEWO+l
	 syHX9y5wGojIVzXXuONFCM24bvaRW/r874q1z2dbcHYUmPAwSpBHl5hvHLiJh6H5pw
	 0HIvUP52DawvQXWIpmcmueyGvKrPP/9r4hSsuR0ocJIjd5ETHhECx807aVseOEWV95
	 v8BA8Zfi5FmNw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3789142C30;
	Mon,  4 Nov 2024 19:21:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Joe Damato <jdamato@fastly.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
 hdanton@sina.com, pabeni@redhat.com, namangulati@google.com,
 edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
 m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v5 7/7] docs: networking: Describe irq suspension
In-Reply-To: <ZykXnG8M7qXsQcYq@LQ3V64L9R2>
References: <20241103052421.518856-1-jdamato@fastly.com>
 <20241103052421.518856-8-jdamato@fastly.com> <ZyinhIlMIrK58ABF@archie.me>
 <ZykRdK6WgfR_4p5X@LQ3V64L9R2> <87v7x296wq.fsf@trenco.lwn.net>
 <ZykXnG8M7qXsQcYq@LQ3V64L9R2>
Date: Mon, 04 Nov 2024 12:21:02 -0700
Message-ID: <87msie955t.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Damato <jdamato@fastly.com> writes:

> Thanks for the feedback. I had been preparing a v6 based on Bagas'
> comments below where you snipped about in the documentation, etc.
>
> Should I continue to prepare a v6? It would only contain
> documentation changes in this patch; I can't really tell if a v6 is
> necessary or not.

Look at the generated docs and be sure that results are what you expect;
the enumerated-list change may be necessary.

Thanks,

jon

