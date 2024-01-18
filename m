Return-Path: <bpf+bounces-19834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6AB8320A4
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 21:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C02F1F24DF3
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE762E854;
	Thu, 18 Jan 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIKzy8cu"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84D1E89F
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705611444; cv=none; b=U0mF6i+dz47WQFqXyv/JgYkf4w23tQA46FkyCgsSGRrX/MtzkvtDk8PAoYtyslJDhcnAFo8tv0CBF5E7mtwLQrqCHEx2Xc5H/0vRqjsps+JIRIRS+3mj/lkPkecwhjSAM3bWr1c1DMAIFKZ+hr8bBqr+OjBKRmabxTZUkFsKPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705611444; c=relaxed/simple;
	bh=q8LMNEIinnjyggzu2kQyF3rU3hAAqaHNmV/WIVgtikg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gj9bOpvGlTAD/0SnmJ9LqOgT3gCpOIK8AwjY2PLcFLCYBIaWFCY9TTZJyt+gS4U9HmgQDca5vmBKLIpmunuIwmA/EyjIPGRXxQxV2QIjtX4leMRLzWFdk9neREjA8RQ1f7QR1h79/2hO/7EDDY+ax87MreE6Yv+HOe0PECdwQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIKzy8cu; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <16fd57b9-bba0-423c-9080-bf41e73d5547@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705611441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1viPENAvz2WqKxqgyOpo39+WKiYPqIb6jU9gMr65Hw=;
	b=uIKzy8cuaZ/SmYbeLlXNMqGUrZUK1FbVaGr14XM3LHvnn2Q9QFdwibzQSn99stoFr4Z2GP
	UdeVg2t2nEvKIdfgAUsSoj0Nwyy/tyifpZbIjoETQEVsW8dA0W/WTv7v77eukPALqE3akK
	7o7rTl/WngRmE/QEzMTD23LYuMCMW7c=
Date: Thu, 18 Jan 2024 12:57:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Jiri Olsa <jolsa@kernel.org>
References: <f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
 <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>
 <6c79868f5e66c4a2c2b8c2bd30422cb167b656b2.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6c79868f5e66c4a2c2b8c2bd30422cb167b656b2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/18/24 8:05 AM, Eduard Zingerman wrote:
> On Thu, 2024-01-18 at 17:58 +0200, Eduard Zingerman wrote:
> [...]
>> here is how config for x86 CI is prepared:
>>
>> ./scripts/kconfig/merge_config.sh \
>>           ./tools/testing/selftests/bpf/config \
>>           ./tools/testing/selftests/bpf/config.vm \
>>           ./tools/testing/selftests/bpf/config.x86_64
>>
> (For whatever reason CONFIG_PACKET is defined in .../config.x86_64,
>   maybe that should be moved to .../config?)

Sounds a good idea to me.


