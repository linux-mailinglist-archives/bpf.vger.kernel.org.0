Return-Path: <bpf+bounces-43327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DAE9B3A46
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1332B1C22278
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB361DFDBE;
	Mon, 28 Oct 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QsG5Yc3u"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC41DFE38;
	Mon, 28 Oct 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142897; cv=none; b=rvba/WZrZm9PVdWIiNzBlyrrs0QlfbPLBXG9vk4QVRXajY1WVS69BZkd8YsR7aGLp6iChpJaSOhK+YtFgRwyvYAN9x+Y8EhvPghEg9yB3OE82hsnEVj5hnK4ITZgYK8TOjsSC09hOgrTJCV6wRBqwvsB015TWqhUFzBK5qwUQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142897; c=relaxed/simple;
	bh=s7UyspYJHM14ize/5+NLAwwvR13xjZPO/vTGdLHIfLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtUr0UNTGJqfDVB0cp4Mf6B62MmWr5/ajaIPSz+QP19kpXxB7DZs5UkgLQR+uZ8to09U+D4UknCUpzeHg2OYlAoVWWsficzy1f9D8XlYp98ODDD5sX5dRszIdwPspeK0KipOX3kh146TiAJne4hV8jLgkqg/kE7zBtkVZLhnmUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QsG5Yc3u; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730142894;
	bh=s7UyspYJHM14ize/5+NLAwwvR13xjZPO/vTGdLHIfLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QsG5Yc3u47LdcgAl7d51rnCe8y78Mc1kJm1FpovTEu1DgXho0vyZjYUvbPr15kCAw
	 r8aZHCA5QzS/RFtY1FMCl/08F0TOwt2yu0Y4TQPR6VJJ0S+sV/AxF0H/vt7m+c1H0Y
	 9BUphivOqtBAKR2fkoKVima1wdc7U2yiFMtYC7b5Z5sTrfYb239C0LVh4emBmxQkFn
	 0bQr1XESYbmRplRe3141PIZZkFEl4wkXdwcDVPrq5imWWQQMP5/NP81Rchrxp8OpJy
	 6yZqeMpX4a3mAZPdT3HTp20y8MSFIW+s3yNtVfyY/vQ3K7EEVg8iY9/wYx1HRS3MoD
	 PPX+jvcKyfDFg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xcjkk1yskzsCQ;
	Mon, 28 Oct 2024 15:14:54 -0400 (EDT)
Message-ID: <b228deb1-67b2-48e1-a68c-f96c1874303c@efficios.com>
Date: Mon, 28 Oct 2024 15:13:15 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/3] tracing: Introduce tracepoint extended
 structure
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
 <CAEf4BzacJd=hMGOGstf3HYc4BbK1Vt9rDkqptcCeE5=R-EqZ5A@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzacJd=hMGOGstf3HYc4BbK1Vt9rDkqptcCeE5=R-EqZ5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-27 21:22, Andrii Nakryiko wrote:

>> -#define DEFINE_TRACE(name, proto, args)                \
>> -       DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
>> +#define DEFINE_TRACE_FN(_name, _reg, _unreg, _proto, _args)            \
>> +       struct tracepoint_ext __tracepoint_ext_##_name = {              \
> 
> can be static, no?

Yes, sorry, I'll update the series for a v5.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


