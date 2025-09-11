Return-Path: <bpf+bounces-68188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25469B53D70
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 23:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5333AC0CFF
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 21:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093D2D63F9;
	Thu, 11 Sep 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZNQGCdt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5524A063
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624638; cv=none; b=gSAuNrLKDcJq96wIgwd1ZGN+j7N3F6PEPTb9JShKYTi9xBYdafYjVQHV/zP/iw0DnegCEcoY2NfiRFiFKbpxB+/T1wrCqtL9BiZ7CXl9axDsZzNOJFr3sKbS3ugawmDNQCyRDTvICngDJpOhRTIflw33tMVrSEUIEvRbZ4uzTZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624638; c=relaxed/simple;
	bh=//YzdYS+YEh9yKDdZ5m+QGUkw3V75+dHwTGAOYqHcQc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=A5nsazls/kA4Quk4kQSifkN1RyoSHvR+5jGdDA0x5mjbf8Ch7JckZ7o7Z9nnT+W2FCFu7itNyqUesNFZMEkqgTKn9uW0J5LZvYjpJujdfk2QJu4bgNudGRDHJDmuFUEbJI8j8wl0OL8q1xCEmki1MWtY40KpmPBQ6jOq0Xy0N4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZNQGCdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FCFC4CEF0;
	Thu, 11 Sep 2025 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757624638;
	bh=//YzdYS+YEh9yKDdZ5m+QGUkw3V75+dHwTGAOYqHcQc=;
	h=Date:From:Subject:To:References:In-Reply-To:From;
	b=KZNQGCdtahpQfMBzBFpYRCz0rMmSL/i4KAj/1kuMbYl29iBcoXfeTOhau06m0xcdm
	 MufkLqoM4/8Q2uZ4pVzSmExbV5269bQLR+3X8YGe2/+rOKg7odBzAWz4wcvcq7bYku
	 H62xjZZHFXLPAR7d8MQL9MipvFTki0i6YfBazpgRW54K8uyGDM/BWzhSsYNtyWhimA
	 0c8QNVOjO0XEya+3DkByeL4fX2lubh9FE00ezDOTHwZO1fSY4v/RDjJYZvgOzFmGJ9
	 uuu3bTVxxi1Te6WhGyVXXm1NKQKKhK5a6S6y4Gi2pjnFUxaRdpezr4n/cxynena2oS
	 CR2J3JWzOkE5g==
Message-ID: <35d7e2b8-c090-46fc-8f45-b976ffbd5dce@kernel.org>
Date: Thu, 11 Sep 2025 22:03:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: bpftool uses wrong order of tracefs search
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <CAADnVQLcMi5YQhZKsU4z3S2uVUAGu_62C33G2Zx_ruG3uXa-Ug@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAADnVQLcMi5YQhZKsU4z3S2uVUAGu_62C33G2Zx_ruG3uXa-Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-11 10:27 UTC-0700 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> Hi Quentin,
> 
> since last merge window bpftool triggers a warn:
> $ bpftool prog tracelog
> [   72.942082] NOTICE: Automounting of tracing to debugfs is
> deprecated and will be removed in 2030
> 
> 
> I suspect it happens because get_tracefs_pipe()
> accesses debug/tracing first which causes automnount
> and triggers this warning.
> 
> Pls take a look.


Hi Alexei, sure, I'll look into it.

I haven't tested yet, but the check on /sys/kernel/debug/tracing is
likely to be the cause indeed. If that's the case, would that be OK to
move it to the end of the "known_mnts" list in the function? Or do you
prefer to avoid the warning completely, even at the cost of missing the
tracefs on older systems?

Quentin

