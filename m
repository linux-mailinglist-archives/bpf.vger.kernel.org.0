Return-Path: <bpf+bounces-57699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53892AAEC38
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 21:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458043AFE85
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DC228E57F;
	Wed,  7 May 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfU0DTYb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E161CF5C6;
	Wed,  7 May 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646538; cv=none; b=s4lNqNVQhyNnzx8KEnRFN9KvKAD84EITqbJ9iBKFz9mEX3JlP9ggrgm31bF+7foiqNGZlmitp1+37sTqZEAVg4iiMNtx9Fqic0cf9nRZA4gHCNhC21TwmU0kANPJEYgcDrSP43W1JTf+O/3bWGKjyVbHsBXPvY7jw3pAZz/mgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646538; c=relaxed/simple;
	bh=3U+k0XSCpGPoosXxxOjJ/gLC+g6xVEgE1bJQNKlZEiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/GRLevPdJ9aapgsRRREWtIy4Y892vk2Fq5v9g/D39BTzP/+uqFhpr7B0g/2VK+8dnrOSiUKqu+YCYpZOV9hrx6kdBd+iDrFZ/ccRX786xP9CCTpCEMAnGMCUzMGReI6kTmfDfp7F3MD+OXMgnxzmV9QcW6VeiMOmD/r5v8tT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfU0DTYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC47C4CEE2;
	Wed,  7 May 2025 19:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746646538;
	bh=3U+k0XSCpGPoosXxxOjJ/gLC+g6xVEgE1bJQNKlZEiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GfU0DTYbhjcfUkbAJY2YTYubRb26Ow6kBw3+202p+XcADRGxHt6Bsw8xPZWOleiV3
	 s7o7muc8TUlQo1l+gu/hNRNPtD9qt8krDfHfuZVBjImhG1kqvZopDNW3dh9x+Xf/kI
	 lfoYAOEE2kq+Mk7rpP/Qy2kvJq5ual/BsDVmAqNgPgyYU3VjRqEFCYYrhKj0WSxDw1
	 DWK3pP1FipXg4NDIMaxyISQQh+pYLvibtjfu8mAXRu/+2ChfXscXQgOQJMNt8e4XXA
	 RzODJfl0gdGm5QTB1w7lCuSwSu5zB/In9OUC/dVe5B1g+PDOtd3SazAVeJGziyQzeS
	 ZB1yhD7uaGlog==
Message-ID: <3fcd891d-1719-4c53-baf0-4ae0db39991e@kernel.org>
Date: Wed, 7 May 2025 20:35:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe
 link info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
References: <20250506135727.3977467-1-jolsa@kernel.org>
 <20250506135727.3977467-4-jolsa@kernel.org>
 <CAEf4Bzbpn8kQV8ORoBv7iDR1VxT0uUf=qqjanFQFtFx1fSjrQQ@mail.gmail.com>
 <aBsgQw1kzJsRzM5p@krava> <1392a5c9-f67b-49fe-9f05-f2bc63fe01bb@kernel.org>
 <CAEf4Bzar5Ai5WdaFvSPR_z8izoTE_Wejo-pewaH2FtQbm=nd7w@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4Bzar5Ai5WdaFvSPR_z8izoTE_Wejo-pewaH2FtQbm=nd7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-05-07 11:18 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Wed, May 7, 2025 at 2:40 AM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> 2025-05-07 10:56 UTC+0200 ~ Jiri Olsa <olsajiri@gmail.com>
>>> On Tue, May 06, 2025 at 03:33:33PM -0700, Andrii Nakryiko wrote:
>>>> On Tue, May 6, 2025 at 6:58 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>>>>
>>>>> Adding support to display ref_ctr_offset in link output, like:
>>>>>
>>>>>   # bpftool link
>>>>>   ...
>>>>>   42: perf_event  prog 174
>>>>>           uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ctr_offset 50500538
>>>>
>>>> let's use hex for ref_ctr_offset?
>>>
>>> I had that, then I saw cookie was dec ;-) either way is fine for me
>>
>> I'm fine either way, but let's use the same base for the two values
>> please. If you want to change the cookie to hexa (in the plain output)
>> for better readability, that's OK as well (JSON output needs to remain a
>> decimal in both cases, of course).
> 
> Why should cookie and offset use the same base? Offset is always
> address-like, so hex makes most sense there, 100%. But a cookie is
> most probably going to be some small value (index into array, or small
> number representing attachment point number, etc), so decimal is most
> natural. Importantly, BPF cookie can't really be a pointer (what will
> you do with it on BPF side?), so it's something a bit more
> human-driven, and thus decimal seems like a better default.

OK my bad, I take it back, then :)

Quentin

