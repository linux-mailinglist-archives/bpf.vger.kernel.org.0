Return-Path: <bpf+bounces-77852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 532AFCF4C9D
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BA2E317E466
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA9133AD99;
	Mon,  5 Jan 2026 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LXxWQqkj"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7E33375D
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630776; cv=none; b=SPLOG426D7J1ZEYf3rvgk+auFszxfc/bML9Joaey+/FoSZt3PBOjYdYpefulMHWfH+5Wf3iOHE9YyiV/Uzh7udyUoI43zdElrlfhaaGLrtG2KZW9grktH+3+OmrKt9ofuoEQJV+8f++VEGbhKwHYSfMaJLXLcbhsI6eZJm46h7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630776; c=relaxed/simple;
	bh=iOPKgmX5TXFg8tPjP8XLUjiya7llucU/eZfx66eoodc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dxhp1XOfa3JgtG58crU4LPwKxsuaOymeoimAiam6acZVRGKi0QdyERPpkTjKkD/pxazD8r+UjLQK70VLfxO3WJDaeEpWv7LC//rNYEPlHNaukKUeO9XqUSw6kgbyA09tDDaQSKGU9mhba3i12TVmp/y+1JtciVHUlA8o2bRxgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LXxWQqkj; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a132463b-537e-4a45-ba2e-ec2743fbd6d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767630763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOPKgmX5TXFg8tPjP8XLUjiya7llucU/eZfx66eoodc=;
	b=LXxWQqkjn6nhGKPfVaiJNRT94n54pRS+R/nRARLp1FZaG+2uyKja5KQcN4GPRh8btKTnw1
	zf5ZNj4l9Rs3BQSyDBzwisRXgY/vnWwcJRyTPQtu0uTk24sthNf7IQVDxNrHv6MKaN00UF
	c3/hDJ5s3bFyeQMnMOr4r2HMRLVn1RY=
Date: Mon, 5 Jan 2026 08:32:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kernel/bpf/verifier: removed an unused parameter in
 check_func_proto
Content-Language: en-GB
To: chensong_2000@189.cn, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260105140236.7321-1-chensong_2000@189.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260105140236.7321-1-chensong_2000@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/5/26 6:02 AM, chensong_2000@189.cn wrote:
> From: Song Chen <chensong_2000@189.cn>
>
> I accidentally saw an unused parameter in check_func_proto,
> it's harmless but better be removed.
>
> Signed-off-by: Song Chen <chensong_2000@189.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


