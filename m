Return-Path: <bpf+bounces-37804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E99195A962
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BFE1F23889
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C67379FD;
	Thu, 22 Aug 2024 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kxs3ifQ3"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A4AD2C
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289297; cv=none; b=D83+pKXRllaBzsB9/tIgimZVrkdFb8RAWT4JxiANWcnTCK3KWMgvnCys8VU91RHtU43/1pR7EkxxfZNhGHUYPXtp+l32jY38viZz5/mmBo0rWDF/VOD5WawCN9/wFYs61u5KOMGdq9j+EGm3OVx1ERCcJ9ro3btaYY+HQtTTFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289297; c=relaxed/simple;
	bh=KS82NdVAAfx7GKmu5qepLs/vC8bCsXN0fjz0/jekxE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZLoIHmOnQ/jApOk026rxi1z0+aUo1+EDgLeiRiCnZ3EsjYscR96bCwU6z8VtC8Vix/eV/gOcxM/KR9d+ZCWlbYCTyp/K7PycDdWs1XQs6wxm3NeCR1DTaDQaHTNwl4tTmNJqVaUxDu0c/FWE0s5yiDQLQAIov7fjUGpXCHiJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kxs3ifQ3; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2898f86e-9b0c-44d1-b91a-3a44132c4f67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724289293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KS82NdVAAfx7GKmu5qepLs/vC8bCsXN0fjz0/jekxE0=;
	b=kxs3ifQ3UmyTDJGhn56MLXbWzJsqxLvS+MaER/5aMdu55s0pvBF/bsbkwV8Cqkee60i/Oo
	Rn0L91jYqL7+NpTKkmA4W9r+pZBsK6fNct0+YyU32PVn/SahqV8QLrphp7pr6yrHr88nRv
	wpncNtG+jn71HFv6S/me6ORtGjgjCdg=
Date: Wed, 21 Aug 2024 18:14:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/5] bpf: rename nocsr -> bpf_fastcall in
 verifier
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, jose.marchesi@oracle.com
References: <20240817015140.1039351-1-eddyz87@gmail.com>
 <20240817015140.1039351-2-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240817015140.1039351-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/16/24 6:51 PM, Eduard Zingerman wrote:
> Attribute used by LLVM implementation of the feature had been changed
> from no_caller_saved_registers to bpf_fastcall (see [1]).
> This commit replaces references to nocsr by references to bpf_fastcall
> to keep LLVM and Kernel parts in sync.
>
> [1] https://github.com/llvm/llvm-project/pull/101228
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


