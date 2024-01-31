Return-Path: <bpf+bounces-20860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF93844768
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601601C22EBF
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFE5210E2;
	Wed, 31 Jan 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O2d1AaLc"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599F374CF
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726706; cv=none; b=gkKCAk0WnaHkztCbbe+zu9D+z5fPbPoPCBkBW/M7FlsV2bIg2ckPYkOjvBvYAFGsjpm1AgBHpW/Tg6LL2L6RWJ2kAVBRY3PT+tRNv22mYEZObbztUJwfLQXpMKnMIsDVZH9lbaI4UHPUrrZHwZNCfXLvAvyPusUSIIRh37clXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726706; c=relaxed/simple;
	bh=gSlRMppf4pD7dGbBJ4Xcpz4Z0gJW3xl5EDEUPITxqYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri4cDnT4WvczFgNungOzGrc7/pPwfgjpn3UYsLUJnx3h5/R2LbPCl7LZGOxXU5YlGSywjOOEkI6OgV3xCQYBg8cz3hiCQrgfrNTyCGEW9OoNIZJnB3PY49voyZ0w0chbOTp9Hh9Q7/lJ3XbsR9w77jeb3vami5cQkZpSq9auMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O2d1AaLc; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba254346-ec4b-442a-94cb-c9250d97913e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706726699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSlRMppf4pD7dGbBJ4Xcpz4Z0gJW3xl5EDEUPITxqYk=;
	b=O2d1AaLcX4SevoZYz7DYakyZvS+BQkPiQWBvHEu2c2FU2wH+eZnf1ZUSfBv89MjwjzrGGu
	42Y6+pUJOp8ekZ5M3LbX5rVORLXzA0s4sUAPyI+qHdNFfVZ903R6Dm5atzK3EZJEvi0MVz
	okUoK2d1ovkAnY8jp6ddj1vy+4SVbUs=
Date: Wed, 31 Jan 2024 10:44:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, docs: Clarify which legacy packet
 instructions existed
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240131033759.3634-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240131033759.3634-1-dthaler1968@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/30/24 7:37 PM, Dave Thaler wrote:
> As discussed in mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/5LnnKm093cGpOmDI9TnLQLBXyys/
> this patch updates the "Legacy BPF Packet access instructions"
> section to clarify which instructions are deprecated (vs which
> were never defined and so are not deprecated).
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


