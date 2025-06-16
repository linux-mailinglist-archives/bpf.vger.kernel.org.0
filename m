Return-Path: <bpf+bounces-60708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB33ADAFC8
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187BB1884327
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8252E4243;
	Mon, 16 Jun 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pq67Wpiy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D82E424A;
	Mon, 16 Jun 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075564; cv=none; b=tzIe96KNyNUSzP7KYI1z4meYQ4OGwEtTZrhZFIHe1zoPDdJGOR2laQDzcEmChb5bGNX/CPrDNC7tnl2ydiJUXG4rrDF0Ve4OXwpiyZ8cve70aBArlO9ig33AWItLr/eLDNSjL+jZBd5akQLYlnLqm7LAQDRUpcFRfe0fGydqbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075564; c=relaxed/simple;
	bh=b9WYpdYFnxnMvXA1h3uf/5jste9EtGT+SWQw77HmkHQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Aupcn7drlTaujYfs4UdI/BGDOk49TB6mkAeYUYumxOu19FMEsts3G0V8A9NIvHjNFtgBbi2k1QOEsGV/wBa504Ht6cy5mgNXQMweA8ZaX8JDV9D7jcDctUuh+ZwGSbZb/jrTwf+cFXO6DbebO5Ypx0DzvWi6FIf8DvUfbee5OMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pq67Wpiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4F8C4CEEA;
	Mon, 16 Jun 2025 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750075563;
	bh=b9WYpdYFnxnMvXA1h3uf/5jste9EtGT+SWQw77HmkHQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=pq67WpiybJlomxNo1Q0ynrhGsdBlLEZa3DapIvrN62fslXaJvFSseYU1F6UF6iK7m
	 eRjNYnjG4H+HpTv+rDskCAVmxpco7/DZ+LSFuf6wTg0KlYhtOAWE/nAjK43uRVc+mZ
	 jLR2DW/n7KG1ffCW0PtADsj9vMXl1cgYgm39oBRnpvW912H0vgijYY1cE6n2UfvoJo
	 g3MFBCtiYS2xpwe4DQIkU5knmOVB1NsyYKYtmYFn55S1xvicbtUkR+RuAaSfi8PXXz
	 U6Xd+aDPSj5ualUsK7k5hQqGA3nehA79pSkx32khEdCQ/bUQdJ+l6ni7LEO1Sq5oJo
	 rkLvwouWXCydQ==
Message-ID: <20415ab5-5003-4725-bf1b-560f197465c4@kernel.org>
Date: Mon, 16 Jun 2025 14:05:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdp: Remove unused events xdp_redirect_map and
 xdp_redirect_map_err
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20250611155615.0c2cf61c@batman.local.home>
 <87bjqtb6c1.fsf@toke.dk> <4af27621-6d81-4316-b57a-b546c8a7ad08@kernel.org>
Content-Language: en-US
In-Reply-To: <4af27621-6d81-4316-b57a-b546c8a7ad08@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/06/2025 12.54, Jesper Dangaard Brouer wrote:
> 
> 
> On 12/06/2025 12.30, Toke Høiland-Jørgensen wrote:
>> Steven Rostedt <rostedt@goodmis.org> writes:
>>
>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> Each TRACE_EVENT() defined can take up around 5K of text and meta data
>>> regardless if they are used or not. New code is being developed that 
>>> will
>>> warn when a tracepoint is defined but not used.
>>>
>>> The trace events xdp_redirect_map and xdp_redirect_map_err are 
>>> defined but
>>> not used, but there's also a comment that states these are kept 
>>> around for
>>> backward compatibility. Which is interesting because since they are not
>>> used, any old BPF program that expects them to exist will get incorrect
>>> data (no data) when they use them. It's worse than not working, it's
>>> silently failing.
>>>
>>> Remove them as they will soon cause warnings, or if they really need to
>>> stick around, then code needs to be added to use them.
>>>
>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> I guess that makes sense; I have no objections to getting rid of them.
>>
>> Reviewed-by: Toke Høiland-Jørgensen <toke@kernel.org>
> 
> Make sense.
> 
> 
> Toke we have to check how XDP-tools handle when these tracepoints 
> disappears.

To Toke, notice that userspace tools expect this tracepoint to be
available will fail as below (for kernel release v6.16):

  $ sudo ./xdp-bench redirect mlx5p1 veth41
   libbpf: prog 'tp_xdp_redirect_map_err': failed to find kernel BTF 
type ID of 'xdp_redirect_map_err': -3
   libbpf: prog 'tp_xdp_redirect_map_err': failed to prepare load 
attributes: -3
   libbpf: prog 'tp_xdp_redirect_map_err': failed to load: -3
   libbpf: failed to load object 'xdp_redirect_basic'
  Failed to attach XDP program: No such process

IMHO this is a userspace problem, that needs to be more flexible and
adapt to this change.

This was changed in kernel v5.6 (Jan 2020) commit 1d233886dd90 ("xdp:
Use bulking for non-map XDP_REDIRECT and consolidate code paths").
So, I'm thinking that xdp-tools could just remove monitoring for these
tracepoints?

--Jesper

