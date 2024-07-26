Return-Path: <bpf+bounces-35703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A794A93CD99
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 07:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573761F22457
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 05:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF039AFD;
	Fri, 26 Jul 2024 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vRye8evA"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA62771C
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721971870; cv=none; b=Nmu9GZKRhLNhvB8nQA/awt50KjKv0ofPkiQRHpw8Znq833m3RHa0OJNLSctub03xF/J17jnLW0Pg1ghWEnSezoi8xqbVXY/qKkfRoe1NBcMawzYyI8L1p9dtEDc+Rt+FdI9fbK1VH+9ie6fEnAEJRFtF8oNf55cIlcj5QSAMqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721971870; c=relaxed/simple;
	bh=RGyd9TF3pwZt7t/CdfTg4rakX75nRe/EhPig8/aUXzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLd5oRCotfCelqyGRJg63dLnLkXZt3p8w1PVTlXvr97cF6FLjrD4rS+bMNltHbmLoVnlq8p0uI00gmp7et1gg9wImb//Ft2sZ1zmorI0C3E9bCSeYj91ORWN4n7QnSplBUATkj9rc6jFxi6Ar1S1lkMKfcGydUOxfYe9Vdo+dM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vRye8evA; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b230847-fc6b-48bd-9547-3e71c7f52c5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721971866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCc8hxDc/3hQyK+h/CNb7zKyBmdaSJnLTJVKst+8lHM=;
	b=vRye8evAELbGhRFpHF70p/yGlizlDi/sT0sRkAuv8YbflqEv1sZbLEkrwSXpaEg71WyPOY
	cAgS35P8jWT1TpUKyTpHzU5QhH0pCbYXTjSiK51pbMfHEyPSzGcGSPFJdx9XzHSvciAcja
	G3Wf2Q2ts/7t+WYSw2rS9Pl4JepnpvY=
Date: Thu, 25 Jul 2024 22:30:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] test_bpf: Convert comma to semicolon
Content-Language: en-GB
To: Chen Ni <nichen@iscas.ac.cn>, akpm@linux-foundation.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20240709034323.586185-1-nichen@iscas.ac.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240709034323.586185-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/8/24 8:43 PM, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

For the subject, please use
   [PATCH bpf-next] bpf: Convert comma to semicolon in test_bpf

Acked-by: Yonghong Song <yonghong.song@linux.dev>


