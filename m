Return-Path: <bpf+bounces-62315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73BAF7E7C
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 19:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FD01CA1255
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94CA285073;
	Thu,  3 Jul 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wrtC2s2T"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05021B9C5
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563049; cv=none; b=UcrvtWBfgvuYcNfxdldLeo1ZkScuO8zF395aP5y5igQJ1Qbxdq9x9ImcJSehrUZCh+laHi2J/9s2edT8NaLew3mCXVQljicvBkxJsGaImKbTHpFJWHaQ3VHGK2CfEgXL9/xFDcJS084icd85wQ7UKLUAEAVYtGGoUPbahGNRhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563049; c=relaxed/simple;
	bh=OwtuOphI0AdCqeHbCtkpbBilen5h1wC8pG6O6yXGyoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5Sv/maPTAqNviy2SSAXV6tr4U75fVvjIOkkNlAX0t2UJE7ZGzchFX3vGruyfF44OzsIFf51iSqKGHvZf2WpsUFj9yjSiHSlC8LI4TNJa30GLPAJNmXdbnDlXbGe6X7mblKzXJ5jhy3OWf/jis037yIFvvhNm31JIlcyhzbeceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wrtC2s2T; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3735d04-94e2-477c-b4f0-e795bae0863a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751563043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwtuOphI0AdCqeHbCtkpbBilen5h1wC8pG6O6yXGyoQ=;
	b=wrtC2s2Tws9JFMH+C5Z0z7u0UwrUwKijlRsKgZBYmPfqibfhIbVGcWONvhHOpkZz7Xrfev
	d1iAkBkW5+EAyiFwDc0ZDj/lGAkc/pW7in5XPOCxr4pSqJ1RhXWBeApG4nuF1i2KXel0cQ
	78LMTnmzibXTe/xmau/DkeLS5A6oWa4=
Date: Thu, 3 Jul 2025 10:17:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Clean code with bpf_copy_to_user
Content-Language: en-GB
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703163700.677628-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250703163700.677628-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/3/25 9:37 AM, Tao Chen wrote:
> No logic change, just use bpf_copy_to_user to clean code.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


