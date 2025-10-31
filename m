Return-Path: <bpf+bounces-73107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F2C2349A
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 06:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ED734E3403
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 05:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC502D6E67;
	Fri, 31 Oct 2025 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dfIE5cT5"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D0AD4B
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761888138; cv=none; b=QNCynNVpD/QLwTGMzZjjfcexNfss9+3qmk6LckgtWxFN1DRyXr9wZU36WcCYeHDNRpp36Iv7nv9+y6S1bCz1AsQbR1ANJhtM25ojh21WAcsPj8yDHhG7D18F76HgyBhR2Q8O4GIDEBFjvOCEPaweIOBzmevK5tbnT703DokDvsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761888138; c=relaxed/simple;
	bh=fA5TQ0hqll+fs0L3PVcf+H2osXI7NzoXFI92inedJ/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuoKIjWaba7XpjH1zgM5vcPcziWAouqNZi2Sxl61GC+dUj82wOdw2X014ofRrBEjhziGSdVBpK2iZ4RnTkFpZ+NFjWRKr2WJIKJXVws8WYxe6VgCl7uBsMgcgTctMaS3oavJU/xn/oPK70F1+KRTb2Hp3vZtee8OWhUFJ5zjUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dfIE5cT5; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2926ee64-8a82-4baa-bc6f-f81d1beb6833@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761888124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRbZ51hguhYVPoRsdSGy0WiPypFJNA22EaihYHkBG6s=;
	b=dfIE5cT5SXWht4wneK0rWLXoH722bhZGSfSYJjow4siEnSTSXGEJAQOT/KwLOfViXf140g
	zsov52xN2Yc4xxcYeetl9Y7/tR/LyZxm3aTcF+Mp2tj9Ynq+QKUIxIoY6wcwhQOcs9tc/w
	mNr6ntEsY5JUwNlfc9qU4QQXWMDQzxk=
Date: Thu, 30 Oct 2025 22:21:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] bpftool: Print map ID upon creation and support
 JSON output
Content-Language: en-GB
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
 <20251030210655.3938262-2-harshit.m.mogalapalli@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251030210655.3938262-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/30/25 2:06 PM, Harshit Mogalapalli wrote:
> It is useful to print map ID on successful creation.
>
> JSON case:
> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
> {"id":12}
>
> Generic case:
> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
> Map successfully created with ID: 15
>
> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


