Return-Path: <bpf+bounces-53636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF12A5785F
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 05:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E72418972C3
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 04:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101FF17A31D;
	Sat,  8 Mar 2025 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vuMc+MdF"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8E182CD
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 04:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741409683; cv=none; b=jOE/aMOAH0ywgl6tzrWzy7miJSwPJOFAwX7PM5H3YUHOK5ksW6X2Ok/MGu+Hvhvc1VrzlwrGleF0P2JIbOa5TqzF3IllKt6lTxxIHGGkfd8mPrP+6cCqSTiof/ykYJW9DnhjlTT+0dQDmG5rW3bH2CiPXu6hDazmhGiCqX9AXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741409683; c=relaxed/simple;
	bh=dD9UddrIEJXYrfPhIfb9/toPDRzg/POJzg9OwZrU2NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2tymPGr9Ai1nY1st6aeMBxQrKq2CkUNes/WQIat4p9wF9+QaW9m2Pf/MUGSDYUj53bXIpi/UykRG4aHZDAakS5veEIUmpomNTF3Id3MkAr0XckX/Ra8xqCcdeKY6JHegNavzHQmQ/VI5USwZ8pK/z6Ld7jlBd0gZMDsqdJ0QzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vuMc+MdF; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4060381f-ac45-4c55-87d4-4013adb3bf0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741409679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD9UddrIEJXYrfPhIfb9/toPDRzg/POJzg9OwZrU2NY=;
	b=vuMc+MdFDEvEkm+oZlCTuw62NbDFBD/rVUIVCYCEvHnPT///Am5lKcamEWd+WRrfi4fKEv
	W9Tp7DV5YPRpAi87mVnnaR4UqCs4KQc3b3RGu1kPYyNEW/hLMQehNhTIRVeXE440YxfWLu
	UM98xc8ewMNaSoBffkFytBWM/2QFV5s=
Date: Fri, 7 Mar 2025 20:54:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: return prog btf_id without capable
 check
Content-Language: en-GB
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
 <20250307212934.181996-3-mykyta.yatsenko5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250307212934.181996-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/7/25 1:29 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Return prog's btf_id from bpf_prog_get_info_by_fd regardless of capable
> check. This patch enables scenario, when freplace program, running
> from user namespace, requires to query target prog's btf.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


