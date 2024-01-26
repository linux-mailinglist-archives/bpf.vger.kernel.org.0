Return-Path: <bpf+bounces-20411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E65783DFDD
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1161F2502A
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B520B03;
	Fri, 26 Jan 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Nd2EDYim"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AA20313;
	Fri, 26 Jan 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289614; cv=none; b=aK+z3dCjcM0WviZYIYoali5FFYICLSwXMVcyhInhqSb7DHPOpwp9iE3cqB9ZgEG2F1SFZn2tZKY182lylOUwkmrXwuDD7rDdqwPbDUdxG62BvXR+pSM127VsCAERK0sw/NpA6zBeutMJj18lYCf8kSjBtjRJaIdwQr+rWlVxyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289614; c=relaxed/simple;
	bh=yZbujbmp4iPcH4g/pDDSyux54jtmDQTUzmF3y2qq+J0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QrcrVD7mC6W9PvIWFiaDxXc3qokPWe9hUqgasdYJVa8xLMlKmMGZFD7q8cNAzATaQhpFVGgV2eXrZ1YkOKO3Ao+M+TCfUnDgQeRLLDvThW/y6WrCNzdIZnJnxv5bfl9AiXQsvO8KCZY2K2+5rcA1u7/86dmOJD8E0zad5/dizM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Nd2EDYim; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2aQ/5SPBHX3H32sZDZ/AUotko7QKwWoHPSdoc1DV/Lc=; b=Nd2EDYimhSbgghey2T/VCHrT0t
	1Z1JQPqbO7ZLChRbm+MTSqQtQHbKtRDMasoAd4r1K6ml66knvrAgcWQNPAZEFvqSxjZZSokyxs1s2
	gm5xTGgAYMV8EuYaN+mtQj3NZtfboNZDueAIZeipA4d1SoJfHe4juTitt/AxppoO2ZFTCwfnjhtrz
	wpVnpAY2IfgGDGdSLbeLjEBTVHmEgMyUuXBYKM1XUqJfZDwp/4BIUR+AzyVaSi0R7wovae/I1ytDU
	a08lueO5keniV71gGnvGmiWeTjb1VPbGUY/i3IMhNtDi60TUgJ+GYTk3XceXTzAAcP4iRqhHlvibI
	ITb/CXHQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rTPs0-0004xN-SI; Fri, 26 Jan 2024 18:20:00 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rTPs0-0005nC-63; Fri, 26 Jan 2024 18:20:00 +0100
Subject: Re: [PATCH bpf-next] perf/bpf: Fix duplicate type check
To: Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240120150920.3370-1-dev@der-flo.net>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4cf4c371-f922-e061-debf-3642374a34da@iogearbox.net>
Date: Fri, 26 Jan 2024 18:19:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240120150920.3370-1-dev@der-flo.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27166/Fri Jan 26 10:46:50 2024)

On 1/20/24 4:09 PM, Florian Lehner wrote:
> Remove the duplicate check on type and unify result.
> 
> Signed-off-by: Florian Lehner <dev@der-flo.net>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

