Return-Path: <bpf+bounces-63474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182AB07CF1
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 20:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EA31C4233E
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01A29AB1B;
	Wed, 16 Jul 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lgr8Axws"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814929B20E
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690610; cv=none; b=KpLrsVdcxrF+RP1ws52eKA/PksuUY2YMf+Ca+wY44o4z8QLfe35LAU2BwhPbh6OwnhLk7Q/aUCzALQFEa48aICq9MYFReayiV/8DPKH6Um2XTvrZ8iniuOPKMG6VaAlgUTjd0QArP60h6TWEtvHzih45ww/oW/wEKFToSt/icyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690610; c=relaxed/simple;
	bh=k1gJjxR9T/Z/HMq8nRUbrfMvWBVBe4XxfKrOsEKvuPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FICXDRlRXdPpdJ2ATEuwkR2a6qLV/3DvgOXwYsyX8xqqCuyLp3ke110exfg21uc07ZleROk83XL+qcCbjxefHfQtZMKp2PdHB00yh8s5/JrtYJaX+6Mgjctmp3uDxMDs/d8PrrI7dSTr11jP5RR8lRlfEpRiYmJYoJsYx8CVvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lgr8Axws; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <802121f6-aa7a-4ebd-8057-18906986faaa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752690603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1gJjxR9T/Z/HMq8nRUbrfMvWBVBe4XxfKrOsEKvuPY=;
	b=Lgr8AxwsiHWvSTQwwu5kJae1eJNtBbmvPBltRI4mGqaYUru84oxwFkxszUyN3/qvyM6iOq
	0JDVn8LfWmpaw5lXP/EwEfPgE6AyLWADPsDqsvCZi2Emox4x2Yv1pt1X4BZLypxO3G49xn
	iRNaaF7MFJqeiXjgWbJjMyFypenGsKo=
Date: Wed, 16 Jul 2025 11:29:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: start v1.7 dev cycle
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20250716175936.2343013-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250716175936.2343013-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/16/25 10:59 AM, Andrii Nakryiko wrote:
> With libbpf 1.6.0 released, adjust libbpf.map and libbpf_version.h to
> start v1.7 development cycles.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


