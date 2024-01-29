Return-Path: <bpf+bounces-20613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ED2840B2F
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB11B245CE
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E27115697A;
	Mon, 29 Jan 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="AOIBDNBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLIMfYnj"
X-Original-To: bpf@vger.kernel.org
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084F156965;
	Mon, 29 Jan 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545223; cv=none; b=miDnoCy9hXJUByMvMDSErK9FK/2ljK14qlaoVn8wWq4QqCv2guq10kaG+MIJFeX0BktnhQpw/KXTzv5XqYdAkApuaogcOHfSBWi8jKLIKFmBfd14qwOfr2BkSm8gjTXeA9g2X2WTA5dJSNzXeWDcu6O7ZsWDjoqTxyF96Tlzs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545223; c=relaxed/simple;
	bh=BbiOjaQjR81atd78vrcTcqLaYowNtytz0WXZxbsW5mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga+d2hOyBYBogx9wurkNvY4MT41JGnVHL5+FiC/M3KiTD6LrS90kLWHeaRwL7k6U5vcW+bjroyC8Kzk3eZUQ/mdr6o3qhqfVEVfppQXQDKeR+alLzR4h6ca+/Ut5sbr7URlMwpnCB0nnsJ2uPc/S/2c3DZJigiBPueB5ZQDcx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=AOIBDNBF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DLIMfYnj; arc=none smtp.client-ip=64.147.123.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailnew.west.internal (Postfix) with ESMTP id 55E442B000F8;
	Mon, 29 Jan 2024 11:20:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 29 Jan 2024 11:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706545217; x=1706552417; bh=7QfGVHifGs
	lR1SerCkhqtcaKsdMNoiD/zP22/k+FdEs=; b=AOIBDNBFvhk+n+UKxo6wRSPUCp
	njIg2rXPJ3QXkPHk6GlgoZxe54zp/S/CWOHFjIwEj58/fBsMzFmvmyyonwXA02Lm
	Vg0FsaCWG9B91FRDFGZO+lUU1emzRB45Ugwt6RrZcqzo5DDbj/yC9RXdokPCBehV
	7q/QqjqogKh4f7W8v8j+xyCBEiFoSOYYm77lPdSKDCM1u5n5ouxIDcmqFl/OqeEo
	A0uqhMZqyLbIvhxTaCQrWNW89lpd+N3dKMprM+MSi4JuYHlcEGf0mb+qVp6T55xn
	zi74EbAJNBtuqQPdxiQ1nNSfUhljumdCVWSzWUlofGpcdjtC8W+fQdYHsfGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706545217; x=1706552417; bh=7QfGVHifGslR1SerCkhqtcaKsdMN
	oiD/zP22/k+FdEs=; b=DLIMfYnjKKHDuT14W0FlOrXs9qPxCqwJTH8EEuXk/rzm
	b6J0e4wTswKHL18Svl9I2rQKf4dDIoRP0R56eSXmZIpZ8DYgDpZh15YYHddn9C4A
	uSbHkUKNorC37mZAJO95chaSLhaxF6j0QrK6cAYKzKNnV370hPu/rtI4YCATewli
	Ik55t85aHRhsxte1x4M+lBmw3XoV4TRJBHHtNgKT6qLmK88a8PVOWPaG3fbkk/rL
	hhPNRk57bWSzuBZG5mQ7AosUvJzarZb7nY7oe3Z9f3eYejxCKQ7LzdP96FNQqvt6
	vvid9f7WzwXYBovzl4mcdV2AZ9bciz/NV8KoiLS27w==
X-ME-Sender: <xms:QdC3ZcSuDz2NtuI0JK0o6jpn8XhsnOuHddoKQ3fN0VXxKpxATHojcg>
    <xme:QdC3ZZydV3NhcNh-WXd3FDRxLzGsLQmXmaZMaOiTWI7N_WK9mphiGx6SgoyB10vVN
    q7jOMeY_HaERw>
X-ME-Received: <xmr:QdC3ZZ2bGF_Fw_Sc7pGRBZuBsdObqo2g02jI2knQZKJHomePH_LisSmW0vyB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:QdC3ZQC86Hi21A8TLNKvQJQW5VErLCQ4T7ROkBNj0ZxYXJaPy4xmOg>
    <xmx:QdC3ZVjQQyCexkkxbiWSdIzuaDV9wmP-xkuW27wWDRXEHYnVWWk0bA>
    <xmx:QdC3ZcphFYzTS3_zpyU30cGjAY81XIsBLXlAWfWSAgGC1OMO6y28Ng>
    <xmx:QdC3ZQOkZutcalxELbXB97LsWJZbxfY-Egxr6Gwp9pEdLN0HQ-SlwD4brBA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 11:20:15 -0500 (EST)
Date: Mon, 29 Jan 2024 08:20:14 -0800
From: Greg KH <greg@kroah.com>
To: kovalev@altlinux.org
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, netdev@vger.kernel.org, kpsingh@kernel.org,
	john.fastabend@gmail.com, yhs@fb.com, songliubraving@fb.com,
	kafai@fb.com, andrii@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, nickel@altlinux.org, oficerovas@altlinux.org,
	dutyrok@altlinux.org
Subject: Re: [PATCH 5.10.y 0/1] bpf: fix warning ftrace_verify_code
Message-ID: <2024012954-disfigure-barbell-21b9@gregkh>
References: <20240129091746.260538-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129091746.260538-1-kovalev@altlinux.org>

On Mon, Jan 29, 2024 at 12:17:45PM +0300, kovalev@altlinux.org wrote:
> Syzkaller hit 'WARNING in ftrace_verify_code' bug.
> 
> This bug is not a vulnerability and is reproduced only when running
> with root privileges on stable 5.10 kernel.

What about 5.15.y?  We can't take a patch for older kernels and not for
newer ones, right?

thanks,

greg k-h

