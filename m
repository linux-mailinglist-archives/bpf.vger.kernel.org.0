Return-Path: <bpf+bounces-60456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25877AD6E6C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 12:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746A83A1735
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB41223C516;
	Thu, 12 Jun 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APrOtndh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70A238C09;
	Thu, 12 Jun 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725683; cv=none; b=mDsi1rMDnQplP6xT8C71CC6Ap791QKZ0ad/4OEKUVQeDIej+rg7dm9U3qcFJHcmHEkEXmOdlVipiNyBoaLi/GvSMmbdcyvti9ZwzCFHbQSeyPlM6ubtRgP4C8PemLbwi2s4h7YpDUONjB/PHj0dX8ZdDfgSe8LSEP/Mpw6Jpaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725683; c=relaxed/simple;
	bh=ipOkFqoZaaO0FvWvQy4SEgTGfv0EjxKZ+FWyZ8Rb/VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2kG92eXiTK+s4nXJz2WRHB636avfslj/EKPYlDVxwHKc8KyfDObceq09i8kRkgg1FblnHFhDVXMOdRI2H531x+iVO3SOsHwHsEeM26JaqVfASOcxsVvHXDwu84E/M4YAogDEOq/K2x8gVuq7D84vOcvvms/LvGMy609SBLCSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APrOtndh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336CEC4CEEA;
	Thu, 12 Jun 2025 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749725682;
	bh=ipOkFqoZaaO0FvWvQy4SEgTGfv0EjxKZ+FWyZ8Rb/VM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=APrOtndhFLGCGq6HJIGdnCmTqMrzFsRVbOGhcNRU/4HB09tWSpyA7maL98/cq9nOo
	 7DrIyU9qPpOL8MPaPjl0jbJDW8Fk6qeD7Y0hFlKAsDE1kqaA7nYoCaLUSINHdUMf1u
	 r85TQtK8i2oIL8b3rT871kwZgzMu0b3MhTGjjcm6HkLqMfCuU+XVzV5r9zIBXN/XKM
	 k4BnGac/CVfrukKHXFX/0kcJw870L2XugLgv6JiQjHuWv6txbqueLeJndTnd+L32FX
	 gp7mFHRejbEWTLwGCZxA/+sURp62CYEDJGY2KpX4LYgvMXbSeJG3lustAgOGBVLugy
	 9qParxTZMPIYA==
Message-ID: <4af27621-6d81-4316-b57a-b546c8a7ad08@kernel.org>
Date: Thu, 12 Jun 2025 12:54:37 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdp: Remove unused events xdp_redirect_map and
 xdp_redirect_map_err
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20250611155615.0c2cf61c@batman.local.home>
 <87bjqtb6c1.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87bjqtb6c1.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/06/2025 12.30, Toke Høiland-Jørgensen wrote:
> Steven Rostedt <rostedt@goodmis.org> writes:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> Each TRACE_EVENT() defined can take up around 5K of text and meta data
>> regardless if they are used or not. New code is being developed that will
>> warn when a tracepoint is defined but not used.
>>
>> The trace events xdp_redirect_map and xdp_redirect_map_err are defined but
>> not used, but there's also a comment that states these are kept around for
>> backward compatibility. Which is interesting because since they are not
>> used, any old BPF program that expects them to exist will get incorrect
>> data (no data) when they use them. It's worse than not working, it's
>> silently failing.
>>
>> Remove them as they will soon cause warnings, or if they really need to
>> stick around, then code needs to be added to use them.
>>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> I guess that makes sense; I have no objections to getting rid of them.
> 
> Reviewed-by: Toke Høiland-Jørgensen <toke@kernel.org>

Make sense.


Toke we have to check how XDP-tools handle when these tracepoints 
disappears.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

