Return-Path: <bpf+bounces-37772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA595A6B3
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8676E1F22A65
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C831779BC;
	Wed, 21 Aug 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gDZH3VW2"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DFA13A3E8
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276035; cv=none; b=eOkTxr6l4hdT3eKFTvTvJUtucOb/MLwEz89Oo6ZkiUPheXYnVkFPhUAvkIibWVI2IGeIzN+GLck91/6wBmL1WTgTQxApRb/TcfaeoO1mrr1Au0bjr/ZKhUVxLvO0v443k9u/z20n4oMvniTw8Bg8vFjSkYn5YoTO0dtpKMluLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276035; c=relaxed/simple;
	bh=lH45lSa+9b2wURhZ512jLRqo0yzYrqSvBg5X94EV3SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlVtZw52DR03lQ5BgQ8KKYWAKs8K+na8+4V8sk0Y6Kor51gTXW7Nkk0MQhe8SC9k6IRKlKC/d4XSHaRC5Q2GxX+Wi3Bqkpj8u2xz+dwfK4OR9g5AQB9NOP6xUmWEZGvzOlIXBKjkuIopr9ZIYENGOVre+15UYHCAA64bKdi/8U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gDZH3VW2; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45940a31-9d82-4694-be00-5033849ebf5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724276028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lH45lSa+9b2wURhZ512jLRqo0yzYrqSvBg5X94EV3SA=;
	b=gDZH3VW2WBfKGmlNZaCLZzGNkRiVfr0kAAMlEOtFKozgHLqtjS6tjit3UGghWTAMIoCy2M
	qUOg/ll5eCxQ+SFklfEzSfoJHbmP3p+Jvjy9sZ2fJXdVRBGeXcRqrOy4Cr01runMyuhtnl
	IKTiT6+OByFoRZ7BLSS0SReAWx36sWc=
Date: Wed, 21 Aug 2024 14:33:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] docs/bpf: Fix a typo in verifier.rst
Content-Language: en-GB
To: linsyking <xiangyiming2002@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, linsyking <kxiang@umich.edu>
References: <20240819212230.50343-1-kxiang@umich.edu>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240819212230.50343-1-kxiang@umich.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/19/24 2:22 PM, linsyking wrote:
> In verifier.rst, there is a typo in section 'Register parentage chains'.
> Caller saved registers are r0-r5, callee saved registers are r6-r9.
>
> Here by context it means callee saved registers rather than caller saved
> registers. This may confuse users.
>
> Signed-off-by: linsyking <kxiang@umich.edu>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


