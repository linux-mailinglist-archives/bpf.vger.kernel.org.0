Return-Path: <bpf+bounces-62807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1B5AFEE56
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE9617BC73
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABA52E974E;
	Wed,  9 Jul 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bh18yubf"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0A1DDE9
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076735; cv=none; b=jN2cbxTv41gcxEc9cCLxjfOyJM2XM+qqp/C1iRTlMxuFRk4Zi06bTmEGFlu2F1hDVhJAQr5xNHb0nluTpbemokWzNKy76yMgWebYaezJX55BMIOHPhAxo+o7AdRPNBHEEp5+dK03PAiOVzgAeOVIYv1hfrllcGH/epYtt5d7tjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076735; c=relaxed/simple;
	bh=pP/dZqslEA+EeA13qPrlvLarulhc8WUsyIwxekgzDWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGOxXutmUU/3GrM3/DJYDIqjckQUvskrqlU/Vd6LA1F91s+/835DFZlVl23w5tf9lOGxtaT8pGg+cSHnyEt0JlvPOW/ATd4DZ3oiQTvxKpOS524tx2k5WtVpCPMo3pSGM1KQVPQGdL/Zs4mLUoJpy4wFfZ60kLG6ws5Q8VvC7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bh18yubf; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79f170ab-cd5e-4682-ba4b-4fb883d93d3c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752076730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pP/dZqslEA+EeA13qPrlvLarulhc8WUsyIwxekgzDWc=;
	b=Bh18yubfOYpcizet+yjh5ACBUbGeavVtGw/ysYaZQIA5+/0acY1LP5gSjIfxs5ROaSSO62
	aVBV291oLmNGLxdousuQkPxWOdurmmpmYhj7DbjnDJemEoedUebABdqbVEQu2iTT0WWD7l
	jWfjqKAetmwwSGQUN0Kd0wbPv0PX1FY=
Date: Wed, 9 Jul 2025 08:58:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] bpf/arena: add bpf_arena_reserve_pages kfunc
Content-Language: en-GB
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, memxor@gmail.com,
 sched-ext@meta.com
References: <20250709015712.97099-1-emil@etsalapatis.com>
 <20250709015712.97099-2-emil@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250709015712.97099-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/8/25 6:57 PM, Emil Tsalapatis wrote:
> Add a new BPF arena kfunc for reserving a range of arena virtual
> addresses without backing them with pages. This prevents the range from
> being populated using bpf_arena_alloc_pages().
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


