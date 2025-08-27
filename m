Return-Path: <bpf+bounces-66627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E37B37983
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 07:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE778367183
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 05:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF112BE05B;
	Wed, 27 Aug 2025 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="apVZM3ek"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E4258CF7;
	Wed, 27 Aug 2025 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270852; cv=none; b=DrUPxBQcsOe6Edrw6+fVeJ7vboUb3ec7RHa6EukOz3q3BiIrWbQVq0mL8mV3JwmuSalQRZrWFIGYyhiuoZRSx0K1mHCKe/KGOZ/NXR5MC86DXpgLbzhZRA2SvrsAPc7MNaiM8SG9DriKlWf9iRrkviXLkakLxFp8LDnqTYI4aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270852; c=relaxed/simple;
	bh=Dfkgb/izU9zCp9bnLoJKOW8Oq/pDRRgSnMI5ox/SsE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJ9aGodu+oSrj9lqaZg0t1EH1LrSD4W3HwJJFgNTCZGlAHlSzs9kSat+IyuJiIw1VTa/EPlAu5ZVj4VxL8yl7rpgE6589JptdBRQw0Ebz8U7dItn35aRSPI3URC9ZE8T9Vz/0y3wO3mWOHYmeV+BZ9FPAfTKvxORtI8F2RkZQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=apVZM3ek; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aff0626f-f78a-4231-8d56-a3c9978b6548@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756270848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dfkgb/izU9zCp9bnLoJKOW8Oq/pDRRgSnMI5ox/SsE0=;
	b=apVZM3ekT0e/2wAI4o6oDMRutqxxhcRRU0+nZgSd/xxzOTP/01Rr36dq9rSiLnbFFw742L
	Sgz97WzdMDe8n/M7VVECIiURHgpl/+qnmp7P0/eo73GyDo/XsegTCy6sBa1jaxM/KX8Um0
	VVHJP2OzFfipoEwgXcwuRChmjW6VLkg=
Date: Tue, 26 Aug 2025 22:00:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] bpf: Replace kvfree with kfree for kzalloc
 memory
Content-Language: en-GB
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250827032812.498216-1-yangfeng59949@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250827032812.498216-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/26/25 8:28 PM, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>
> These pointers are allocated by kzalloc.
> Replace kvfree() with kfree() to avoid unnecessary is_vmalloc_addr()
> check in kvfree().
>
> This is the remaining unmodified part from [1].
>
> [1] https://lore.kernel.org/bpf/20250811123949.552885-1-rongqianfeng@vivo.com.
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


