Return-Path: <bpf+bounces-43313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EBD9B35C8
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 17:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AAC1C21BA3
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9E51DED56;
	Mon, 28 Oct 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZwOg238t"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F483188917
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131619; cv=none; b=cnx/wuRMida9stn24AbzHEjSBgz4QBIRmJ8iUiFcxDSi3q2095+EjRo952WGo4gaTvXuUaLS3UMym8kX93GweHqOZxyS05xDfzN9VN/GROO/xDepyQYTmlA10eD2ynIF/92soKotNqPcZ1axDLaKHplZiFB2JwO7wuXn1JwIgCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131619; c=relaxed/simple;
	bh=ea4JAx6cNSx/ZYmu7tYnEoRrrXkuW+h8wcqaCDjo33k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTGtTEO9HkhzpgZaeqxzpZAId1ZiSvD004fN3Yo0Itu+1PcYue3AoC++lanO81D2zkWS8ke7Qs5YLxTfmFj0BEPDForPUWN1Z/Pw9xEO2mmEYDfvQHwvFYW2kUDO8LAFFyULOPdMK9NrQFxwGtYK6cF7axV9PcfbwvXnbAIaFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZwOg238t; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e2a8dd0-4c15-4aba-a164-1e091de0f315@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730131615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ea4JAx6cNSx/ZYmu7tYnEoRrrXkuW+h8wcqaCDjo33k=;
	b=ZwOg238tbjyqECslRsgBNxg1rSmmE4RUSjMIOvQR/LelIC2Id016f/6H4rvazC0je619c0
	ord3m2lIIaIGgDlPZt596aV7Upm0Vjul5pshX3d0JuXG0QdQIo9loHCpyM/6jN8j6M9Rza
	Y5IIOLtTvWqUiVIpN00YI3BSuR+ALLM=
Date: Mon, 28 Oct 2024 09:06:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf, x64: Propagate tailcall info only for
 subprogs
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 jolsa@kernel.org, eddyz87@gmail.com, kernel-patches-bot@fb.com
References: <20241028134041.94098-1-leon.hwang@linux.dev>
 <20241028134041.94098-2-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241028134041.94098-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/28/24 6:40 AM, Leon Hwang wrote:
> In x64 JIT, propagate tailcall info only for subprogs, not for helpers
> or kfuncs.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


