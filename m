Return-Path: <bpf+bounces-41354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF5C995F26
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1B2B212B8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 05:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F815DBB3;
	Wed,  9 Oct 2024 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q7hj2+8l"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A162746B
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452650; cv=none; b=DoQ/wLWE5VuLj3KM9DQVPkXeZ29b5cfIcVr3WWDz9CiWgqne9CUY5cEA9lS/JkjWDsQBw1RogZ7kXS/N10WmwB8dAlUidLH4BmKR6fgW+t1fO5AeAkZF3nZn8ZkZPLGEuwO/YaNLRrdmd/vmfHjX9eboJ3NvgIwC0Ulc7xCO1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452650; c=relaxed/simple;
	bh=w+fmD14o63PQDGWN50RrWv6oxb0aJ/fJf+94kqThJEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8O0izkimp79V20ww/7WtSD7k6ahkzbZYm+SysEgHM1xjIqTE8CrcAGJ42+lrrJ+QQSpglpRWEoB2ft9gHKYIRmlFfOydIXrOCcXCF1v0R1PxIZXNvoyLplQ5Tc6vlZGYMiPgWaNITr/nsfxdtaqH4oSVwpmY31LH7R2qwFAqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q7hj2+8l; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a93a074-fbae-411e-ba15-168c148dcc31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728452645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONvT+kq56Jm+Mi2GDT17ZhyoSRF5xqpHBEESoP7Uep8=;
	b=q7hj2+8luhtC306SL/xHf0fR79gxV0DB0Qr1HbVW8G0iLBPdkDElYxck6PaJFRPgCi/M3I
	Y3zmcXcyTEZ8PzDLx7PhFTX0CF43NkWyoh/FlBGlZ5wL8TPuzlCHmQaYNxCgl0CDBqenfF
	LMc3hrMxbb8fo+9n2BKkAy1ci1+GVFg=
Date: Wed, 9 Oct 2024 13:43:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Prevent tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, iii@linux.ibm.com, kernel-patches-bot@fb.com,
 lkp@intel.com
References: <20241008161333.33469-1-leon.hwang@linux.dev>
 <20241008161333.33469-2-leon.hwang@linux.dev>
 <5713a88deabecef0f847ded008bd0833e405df80.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <5713a88deabecef0f847ded008bd0833e405df80.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/10/24 12:42, Eduard Zingerman wrote:
> On Wed, 2024-10-09 at 00:13 +0800, Leon Hwang wrote:
> 
> [...]
> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202410080455.vy5GT8Vz-lkp@intel.com/
> 
> These tags are misplaced: "Closes" link is for v5 version of this series.
> "Closes" should refer to error reports for something that is already
> a part of the kernel.
> 

My bad. Thank you for your clarification.

Thanks,
Leon

