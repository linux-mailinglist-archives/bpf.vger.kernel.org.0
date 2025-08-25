Return-Path: <bpf+bounces-66447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA1B34C2A
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4702447A6
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BB28751B;
	Mon, 25 Aug 2025 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bcaozo2C"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA86285C8F
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154398; cv=none; b=f8IEd9DV0vui0OUsST72l4yio11AAgoRMIHtMy36skVRYSBbYXE2n9nc7EpdtR1rBjQCKOg6SPpsSr3AbDSeYtXlRBkb62diONC9OJgqxz6xSat22hKHss3K5Ng0E0cwxX96bMYVfzTxazvGLMUPwj3I3O4QV+mNxzdnQY3O2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154398; c=relaxed/simple;
	bh=VvKAk/8cKyRe1qgb0YWmnvPuVv8Ek2+TkhgQSduf7G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbPGZ5fZmdYLgC7d3R1lL3TSTvC2NUbw1NgReR6DA+WeDmwNzeu/+ZifZkxA173DA0Of58R8E4OJrl3jG6GY10rEitwu1swbrhdoej8G/gUs6xsWA8e23oW+66/DDFTBcW2Rqik9tpr3+3zRf5x4atzXF0fAzu/kagrMMnYvGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bcaozo2C; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aed65fc2-8d34-4407-a049-fdc1ff5111ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756154383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvKAk/8cKyRe1qgb0YWmnvPuVv8Ek2+TkhgQSduf7G4=;
	b=Bcaozo2Cqb4zokrxuZI4AcokMMsLwEu3Y7C4K0uIeU/byqca8XjUAv2xyKC4rfPcgWb6Yq
	Db3mGOzWh5yTC8FV/RN/xbCJK+IhC/dLdcmGqG0Dt0XGTTsofZO/lK6CuzNhBZMAAI7/jy
	EdUmExMW7/TllnrPMPnMOcUe6+OYmO4=
Date: Mon, 25 Aug 2025 13:39:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/2] bpftool: Add CET-aware symbol matching for x86_64
 architectures
Content-Language: en-GB
To: chenyuan_fl@163.com, olsajiri@gmail.com
Cc: aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, chenyuan@kylinos.cn,
 daniel@iogearbox.net, linux-kernel@vger.kernel.org, qmo@kernel.org
References: <aKL4rB3x8Cd4uUvb@krava>
 <20250825022002.13760-1-chenyuan_fl@163.com>
 <20250825022002.13760-3-chenyuan_fl@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250825022002.13760-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/24/25 7:20 PM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> Adjust symbol matching logic to account for Control-flow Enforcement
> Technology (CET) on x86_64 systems. CET prefixes functions with
> a 4-byte 'endbr' instruction, shifting the actual hook entry point to
> symbol + 4.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


