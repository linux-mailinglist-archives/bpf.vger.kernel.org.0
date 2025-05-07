Return-Path: <bpf+bounces-57647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFC0AADB99
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 11:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDFC4685B4
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1822F1FC0E3;
	Wed,  7 May 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7avLm56"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC531F4CB0;
	Wed,  7 May 2025 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610835; cv=none; b=KKGNg4qzoyShPvm47MOyMB/QQYKnLHv9V9wg5azDnkhowBognTY4tPhN9YXvnWaIHwz+6MDd8qAK8WJ4uUNj3zyjupXdkb7/dQJSFmr8KRvgL+i4/6YPA1zW3215UBKj72ASHIyHzt6u5dbD2fhB5n6z+6+t41n4cYLv+WJsNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610835; c=relaxed/simple;
	bh=xq3C3ZXma1U1ElVhSrzw1iGqpC/s+eNEB0pf6y5gAdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHTieeAcsgl/0uUFa94waYInkya2ULuVYSRWDAus/DsyRLgaUzIZS92oFOWf2RznQyb9B3VPo4IxDAjiLn6gIm2GwTnUPYhFvxpuy1AcDLV6gElbKQ8HIg43fXd4y97mrQ/VxrAxzU4cPLcWJP2euz3YSzJyWhLCDpkfb1FtfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7avLm56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17363C4CEE7;
	Wed,  7 May 2025 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746610835;
	bh=xq3C3ZXma1U1ElVhSrzw1iGqpC/s+eNEB0pf6y5gAdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W7avLm56ctY+oWY0DkTqKXGhEdBFkKMRpGkmJ2JczR7c1hydSZqgQQ1DOBB/O/djV
	 gIHP+pAONRQ2NO0dT4cvW/LkEg11eJm89RJy/uxUiPV/acZBYyCHjwYjfe1YtX2tDT
	 I8WV+mhXbGoWCmbDGo8brxACCdMXTJ4sjJ+UL7efeozKrYTWjw7u0Gy095bgEChQjt
	 cvaYkkdTMNm1+BEERzexI6JXM9KXYeDNFwY66enCOI0GG+sA+KCh4Pb4q17IlyJg3C
	 VCZ+ifuh1I7YkpXics9C4/qi5eHOaG7dVH+1QI4lWnKziuu8N+SLgNFb4+QC87+I9a
	 J5BahAoVwu3xg==
Message-ID: <1392a5c9-f67b-49fe-9f05-f2bc63fe01bb@kernel.org>
Date: Wed, 7 May 2025 10:40:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe
 link info
To: Jiri Olsa <olsajiri@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
References: <20250506135727.3977467-1-jolsa@kernel.org>
 <20250506135727.3977467-4-jolsa@kernel.org>
 <CAEf4Bzbpn8kQV8ORoBv7iDR1VxT0uUf=qqjanFQFtFx1fSjrQQ@mail.gmail.com>
 <aBsgQw1kzJsRzM5p@krava>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <aBsgQw1kzJsRzM5p@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-05-07 10:56 UTC+0200 ~ Jiri Olsa <olsajiri@gmail.com>
> On Tue, May 06, 2025 at 03:33:33PM -0700, Andrii Nakryiko wrote:
>> On Tue, May 6, 2025 at 6:58 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>>
>>> Adding support to display ref_ctr_offset in link output, like:
>>>
>>>   # bpftool link
>>>   ...
>>>   42: perf_event  prog 174
>>>           uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ctr_offset 50500538
>>
>> let's use hex for ref_ctr_offset?
> 
> I had that, then I saw cookie was dec ;-) either way is fine for me

I'm fine either way, but let's use the same base for the two values
please. If you want to change the cookie to hexa (in the plain output)
for better readability, that's OK as well (JSON output needs to remain a
decimal in both cases, of course).

Quentin

