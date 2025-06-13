Return-Path: <bpf+bounces-60574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7852AD8146
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B7B7A72A5
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12FE244691;
	Fri, 13 Jun 2025 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K3JadRX0"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF118A6AD
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783183; cv=none; b=bawGPBkTl/mtenbEhfhggM0bci5HAzgkAKyr1aqkaeAms5fZgbR8A5w4VJ7At6cueEO40tKsvgRuEruk2aG/g0871sJQU0LGVydOa/KurdwH0y+lzZ5aAaYz75mh5BXbHzDL8PZGpkWHQyNtFSh+UmWXJkugYuNPHFkhUlS0YpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783183; c=relaxed/simple;
	bh=PoFqwsN2B5EhmtK22GXTU6a0tOLOFfisaWvAwGCVCQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkliI9KlyvJj+ro/8zLwg0F4ulDpvE1XAAW4a1v/6JhQ42FtnQ73mwp9euG+JNps+ddDFqLg5694L6m4x9Sdg9v6egPdJlpKPRHRho3/6j+r52x3j5DvDnIIRQbHP45nyj3R6dYcMch4cjMuSBjKW//25OdKnUWjaDmdprGhG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K3JadRX0; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00a22161-1e40-4ec0-be4f-e2c5dadbfe0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749783169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CX+/VP1MiFLEdPtc2XaV4WX2ozXiPR9ceMVaJT/kqo8=;
	b=K3JadRX0L2XSsGP/L0Q60CTd0b7I3e0wO1qHdGbl9W6sC0cO3F2BTcmkbn7MUOAN+pa+Rq
	OzoEPfTSFHhfFBBpuWCBOXFzazPBLnhxmEvhEJdl5LEUFRrLV51VAPeOa2zXgghAih+B9K
	Qgse4sRpiB6VkBNYrdSbc7JqzmWowgE=
Date: Fri, 13 Jun 2025 10:52:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20250612115556.295103-1-chen.dylane@linux.dev>
 <20250612115556.295103-2-chen.dylane@linux.dev>
 <CAADnVQLbpO7PED01OVZXTLib_hBYzwpC5hFyR_WMCCx8obR1Hw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQLbpO7PED01OVZXTLib_hBYzwpC5hFyR_WMCCx8obR1Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/13 00:01, Alexei Starovoitov 写道:
> On Thu, Jun 12, 2025 at 4:56 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Show kprobe_multi link info with fdinfo, the info as follows:
>>
>> link_type:      kprobe_multi
>> link_id:        4
>> prog_tag:       279dd9c09dfbc757
>> prog_id:        30
>> type:   kprobe_multi
>> func_cnt:       8
>> missed: 0
>> addr:   0xffffffff81ecb1e0
> 
> fdinfo shouldn't print kernel addresses.
> It defeats kaslr
> 

How about print the function name corresponding of the address, or
don't show the addr info.

> pw-bot: cr


-- 
Best Regards
Tao Chen

