Return-Path: <bpf+bounces-19853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA627832267
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2385E1C22A78
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70781EB38;
	Thu, 18 Jan 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p/wIt5QZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFCF28E01
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621988; cv=none; b=b7tu9/Rg7eHwrKGeHzEZEgGTawxs5ippkG//aNAB0H7VTONgdlUxHRFzg/ZNZpoBJxV6sKbjwtorO5xLRkLtE+a0SQ+sV09LcrJClVSy3jUqMghc7iKKbzVa12Ohags4Fj19kdby4Y1/5Gb8v+aEYvuOxtCXpTrm34ofOFJbAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621988; c=relaxed/simple;
	bh=xciUpB1EYvV1sOyg2VNkB2I07bZOj6mqEI6iYK8mLGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLakjbSePRfqKmMywu9U30DzpUnj5dVvAiemTb2Kh71toYz6iW2NyeTUCnWmcnAAGoN3aq0LTA0rwTWOcpZYlz6+z2VO7kuVFzDNr76mJxJ9RLKnQDZPQwj7htyLQSWMWGPhl3L6mnHB9e8velkhFo8Bg0gByFAHBH5ZdWlv6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p/wIt5QZ; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9fe7008b-2fc2-47ad-879b-53da4d0f9c1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705621984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xciUpB1EYvV1sOyg2VNkB2I07bZOj6mqEI6iYK8mLGM=;
	b=p/wIt5QZpTvjtsJmjzXzU+QCU23IC9uRt7ST6Verli19H1exTRhlwQUQnl3wCMePDBt+EW
	rrwT5D9QlYoxWd4cFmKPi0gwVQdPJoFdb+L/wjHfxJwtvIpykbZNZch+P7vT/qxy4SwTnP
	QWTo0HYHC2aepqOWvW5/bnZlaQZEdEg=
Date: Thu, 18 Jan 2024 15:53:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Clarify that MOVSX is only for
 BPF_X not BPF_K
Content-Language: en-GB
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
 bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240118232954.27206-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240118232954.27206-1-dthaler1968@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/18/24 3:29 PM, Dave Thaler wrote:
> Per discussion on the mailing list at
> https://mailarchive.ietf.org/arch/msg/bpf/uQiqhURdtxV_ZQOTgjCdm-seh74/
> the MOVSX operation is only defined to support register extension.
>
> The document didn't previously state this and incorrectly implied
> that one could use an immediate value.
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


