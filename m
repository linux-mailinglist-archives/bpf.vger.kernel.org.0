Return-Path: <bpf+bounces-26503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E558A12A1
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 13:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565121C20BB1
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0EF147C7E;
	Thu, 11 Apr 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yKe3Oh6g"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1F1465AA;
	Thu, 11 Apr 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833850; cv=none; b=VSXav+vSJOsfae2Kl/sHZBviOO4MKKEPy6D0HCAJTiKoJ79WiSa/g4p7CII3O2qwS0XfS0raECEmc4dPD8uvNrxGR+gaeFJTvBLP1uJoZ76CNOxIUas9KZt8H4l0oFb1v2O9HQAZeqanotGhgIWo0HB456aCdkcx32JSdjZ7HWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833850; c=relaxed/simple;
	bh=irR7rrMoFz+kSmrXAtZFx7Z4FrGRW8a7lrZdbidVk7c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kd67mOivyDAGDu92310U+XMk7ioZ38nw6bj45T6CeUaGoZ01OtFzE+ukSAIvdb6ft4lSvcUl6APatTUh8rMvxuuM3URdoLbrPIq1hn4vPLIq3UtV5AVCcyh4Oo7FHioKNe2neg88CKnGs1Ejs1M26E8kVTbqeWNu1P3UomBfRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yKe3Oh6g; arc=none smtp.client-ip=203.205.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712833539; bh=iW8aWXvN4mbA0WEGSj8YcKPKHDgDK7E/gRDBL2Bh1eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yKe3Oh6gdg531OfBw43CRNUKsQgWvXsUsbqL4REjhWRWV/EyQEdrVIPBBxhbQ6Wrl
	 uuEd8GqnykwLaOZjANMsTohCJzwCacYB3UAVC5dchhbfYum2drYrs96DeGaFsN7WKW
	 G7/mjy+gPsau7YI7w5oIeKkn7hbiOy2ShrvOTQZw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 162A8876; Thu, 11 Apr 2024 19:05:34 +0800
X-QQ-mid: xmsmtpt1712833534tlne241la
Message-ID: <tencent_5437464AAA7407772566583C29372E964409@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3AsUbxSTqAm1aPqHoG6wb2nOwfjMYc+bqlS1kwVIRXEAwYBBERt
	 QbCiin0C5bVqMplz4dl9vTcDDMYP7hAZO+hM1n0jGudJ3wFMqw75nDi6Ar9VwEzqKOmhKLYLVoOr
	 QaJNV+Fagrx4dx2jXdMq4Wl8Un5e6k1fYhhp+q7vg7mOqvraeER+n8UeEp8L/Z17RWCdJxdOqVIP
	 swEgTIYpf6sXbmr7PUmc6leLos2wya5ZsXPnxUFjVYEB3hHbx9CQJmOGS53Zliwg+Kbf5EFtLHDI
	 +zoFnq1w/z7BIe2DJ1KLADjm8xZ/KBxD/tlJvrGFnB2NIJDQJfXMjdTJ24SClRGqZo5a8fvwCuXA
	 7pTNbtT3F4/7V4wiazYeEpHPPIpp1oWd5OWJMRxtpnDq4MJdxrTV4UeJbYkyRKsd2NQcTLHqYrn7
	 XVgHOQDOnAw0YWdKi9QzUr3Tqm+l7ZplpSyNC7Qf5Mvj16FXNcSiM5qDG0mipJvQ+/KFS2pbc30x
	 rLKHflaOisJm6dTtaMBbj3p5HEbI9bF588B47HxUazY71dRY9gjoki27OTtGNHEvKo5y2eTz6PV+
	 Z8XdHHOviEsCXaBhbhj9ODWa71pYo/yh3Ib1vqsTAD7Ybom8XeBpYRxQVV3xZIAbKfs92kFHvrD5
	 EuU3sOpgqvqRarVH90fcuTHyDm/uG9BAv2v10W+JVoIL3rSAiWl0VJ9YHHTExiHXB/OgBEQQpsX6
	 z6EUUBpL/jv7ioEgoIPe+xmp8PbdmpgeB50BU9Ivc5z9j+0nQ1sBL+NNF/4Y97qMLQAv9xtzxStf
	 4CmoNXVs7z8owUvuhzP0FDaOQfyE2Ayx7ZH+RlgGlBJiaPYewgvDCyPd2BVy+qC0e8buVqDX2BZl
	 50bjoHO6+5zsfWRTAAJMefByiS1A3kyxuRqPFtN9/POUtmFfEgzGdX6NPZN0xi+T30UqTJ1ltQ
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: yonghong.song@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eadavis@qq.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bpf: strnchr not suitable for getting NUL-terminator
Date: Thu, 11 Apr 2024 19:05:19 +0800
X-OQ-MSGID: <20240411110518.1245753-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4bfc3494-a3e9-4b4c-9d93-fa1049a10235@linux.dev>
References: <4bfc3494-a3e9-4b4c-9d93-fa1049a10235@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > The strnchr() is not suitable for obtaining the end of a string with a length
> > exceeding 1 and ending with a NUL character.
> 
> Could you give more detailed explanation with specific examples? I think
> strnchr() does the right thing here. Note that if fmt is not NULL,
> strnchrnul() never returns NULL pointer so in the change below,
> 'if (!fmt_end)' will be always false.
My mistake, strnchr() work well.
> 
> >


