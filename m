Return-Path: <bpf+bounces-75245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F96C7B0DD
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B692F3A37E4
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31888346E47;
	Fri, 21 Nov 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YsOtqg8Q"
X-Original-To: bpf@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3112F0C69
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745745; cv=none; b=juVX3f5HRaYN8MIpU5I/pQs2R/JzQgsFF65/08KOO7C6LsYhBonW6G9T1zv+HdjnkHyHRKNiNs73g/mMvPh++PlU4a6yUo8yzf8LkfC0nUkMMpgtXJ1azIB2cSe6q1VR3nzdKA5sl9+XPN+yn1zZWPeTII1NS1YDYIL6gb/+i9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745745; c=relaxed/simple;
	bh=Iy2ZdRsXKFvg6x6OD9HY3L9EGt3fFluG/yG0XoqYvuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvD6kceTqnTZLy1Ms5niyJVJBUJD2+7cBbvfOkOdrLTFOtsxgtCFmOZmOzxaSExSW1NI+z/vygt8RyoQtlgucntyPd9A4Jf/maQBxB6Kygtu4YU83ZrQrnWQ06Lqd8c5XeRGI1sIcQrWFoTZD3e7+xNF7Jg0zPQ3K8H0sjfd1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YsOtqg8Q; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4dChqF0BXCzlvDSB;
	Fri, 21 Nov 2025 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1763745735; x=1766337736; bh=Iy2ZdRsXKFvg6x6OD9HY3L9E
	Gt3fFluG/yG0XoqYvuQ=; b=YsOtqg8QBiSH9kUiw72GOr270TmsH+WceXfe4+DM
	BwNXZdEkLa9H6l6EmwvkZFf4mWmPJeH09gfHH5M8FU+wOf+xWYlc8VGv/0WnWb2Y
	iu55kIaJfR2darG+WjFtENZHB0kMuc9/Y5ABi9gBWOGItVjtbapbifd2RfzHrRbM
	fN4HD+4qyIqlcx4vWSrhlmIOicGu/XM5SCEdxX2fml1lysfz773rjm8dNp/WIqaU
	jDxJMDLvx5jDVkArzAyIziBrBZahhKLCfS9wq61WBBwVMAHhSlpXYye5dojL4kOU
	xSyP53rwiYiETmDjhp9o53GUJsTbZSmJuAn1ImF15auA0A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IzO1kv_dTeq7; Fri, 21 Nov 2025 17:22:15 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4dChq85sbbzlvDSC;
	Fri, 21 Nov 2025 17:22:12 +0000 (UTC)
Message-ID: <452a2c4c-e9eb-40a0-922b-a1b99048ee08@acm.org>
Date: Fri, 21 Nov 2025 09:22:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel build fails if both CONFIG_DEBUG_INFO_BTF and
 CONFIG_CHELSIO_T4=y (was CONFIG_KCSAN)
To: Alan Maguire <alan.maguire@oracle.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Nilay Shroff <nilay@linux.ibm.com>
References: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
 <d296ec97-933a-4b19-aa75-714e69b3ac4f@oracle.com>
 <7161e3e3-7bd0-47ec-892d-72a58b06df33@acm.org>
 <87641066-a837-41ff-acbc-9f4453d0ae58@oracle.com>
 <b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com>
 <aR9YasvOhnSI564i@chelsio.com>
 <bc54daab-3b01-4a25-8032-52a123fa823f@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bc54daab-3b01-4a25-8032-52a123fa823f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 2:18 PM, Alan Maguire wrote:
> FYI I verified that changing sched_class to ch_sched_class like the
> following resolves the build issue:

Since the Chelsio cxgb4 maintainer has not yet responded, how about
posting these changes as a formal patch? If this change is posted as
a formal patch, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks,

Bart.

