Return-Path: <bpf+bounces-57895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE03AB1B7A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941AE1C440E2
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D945238C10;
	Fri,  9 May 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCSHeMYN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA386337
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811116; cv=none; b=gOW7YdX5C1Zt+KO6KM/QHnCrLHAiFQmd6nbYG/yOnGZWg5WfmcEWjGT0kDug9CkDH589zcQ9j+ANlU0A6Pt5PFS8QdwLnumnsMbaXTqSP2LlXQqyM117hm1Nw426LkhE4fXAXg5R8oODyG8Xr+HnR0CdJ7BU6tQvedRjuavbPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811116; c=relaxed/simple;
	bh=wpIg7KRbq0VNadhDPcZGM731tCiXlcKJVthvm8QJl6U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V81Z+9jnpvCv+rTBzwsAHCwIJGck9Vzzvp74E48wsfXwo+bq7bzP5mWemplejM6kPexSiLMZll7vTPkRiHfcUcZM6ysxwFK/vc/NeKp62CU3viOxERhYbbZLEiCI4quQPvIBXYXyOZJ680+/pVOz16XlZc4tvd8iJAYKEFIdjhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCSHeMYN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30a9718de94so2348150a91.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746811114; x=1747415914; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wpIg7KRbq0VNadhDPcZGM731tCiXlcKJVthvm8QJl6U=;
        b=aCSHeMYNieCxc2uh/W4LdLuCzhgRi4uG8QchmJtgrQPlWp2T3OH4Cts94TPRCpCQJe
         AuvZSqH7WQbQtT2Gxc++t54tXMLQGaGujKVklmWUdxU81UhUsTOnYqmntasdtPhApiy1
         b5aT2Y+T4gBxQCSWxWZNLKO4bLVsZGRsQptTxDJFgmTnegps6p+/qj0fJ9MwCJOgKipq
         KxbQT4UCfOtfrHrCdVQ+tcKrqFxzZJ8gLvs7L7+SfxsrdyjI6ot2Hr5eTaDLMibqMYYO
         zX85bG0Rp4pqAd/BBfC4J6Y18DtpYZz9lmVcugQwHCxhQDfcrtiqYSqjnkiLdF+1xXrb
         3nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746811114; x=1747415914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpIg7KRbq0VNadhDPcZGM731tCiXlcKJVthvm8QJl6U=;
        b=nuNBoBkJm6hSZRnN0rdh3AvCkpZdQDAPLD4hYFM49W4XXhs8cnAD/EmekZSp43Sb4Z
         AGQ4E64zNA5ALLrF32Dw1QHz8ka7OFn/4JUHxQs5b92p4pLHN6bA8qF17FWdvmAPNjt9
         scYyN39gacITgm87i1GN7OHFU3abbWrBWw0xlEevJ8YwtZQhJZJbCBkUaDVqdsa5TsJj
         JUq8DTejhOV7r0EwygR/sMqYFzkWRRe+rp8c++semiTY/8YDCIP0mu5n/JnlPYQijueV
         /uwahHriCpesqsGssIeEivH/RMjW9U7F4pw+VdLuqNDYzNWuWdGjEr+YlLuTqz1HIm8R
         xkLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcyY75MeUkpjHjS8IpJOA18EZJKKScvftBjSK0CSp0JPzmI6ksPNP+tttbvGs3ydsq4aY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1rR7WAKG/PFo35uZ5IQV+vw6fvaQo9zg59C8f4iwDqZurCv5A
	vuoD10EuJwsMzvf9FdbxqgmQ4oV198y/TN1gIp9RXL0rWSGX6aNz
X-Gm-Gg: ASbGncvxdZat3nLfkJPGpRuEmhTO6cJzoG4+KuxBS2vGJpGikA46dLnyJPc6/mDvcpO
	VwiGoEOxcLAjrGFj3wsh4QqvV/noOdXpne+WTzofHh+36jMk20wjj+79vDqG2RLT6IAUB8vaCbW
	PmwfhKquVH6WVTF5d8pb9E9biQUr27ttxQiA0t/33534CNIoRzqUwUhgnHNWKX7sXoR63rmswuJ
	/yPzDeW8YfYzOkXpKB5jlcxTuUGHerXcPrQyQEqT04zXgKNaAKV3iLJv6PbPDE3n4mzHZ346DJE
	26ochh9SBwDbVMBYdNKkavXzFzvAOCFhee0K
X-Google-Smtp-Source: AGHT+IE2RIdr6mxU+Klolb3YygYluJ/MwSc8x+KRqZvMKd8OwZj2iAQUUrdi9ltwQp2u9ikWtQIrcg==
X-Received: by 2002:a17:90b:38c9:b0:30a:2162:c76a with SMTP id 98e67ed59e1d1-30c3d62c666mr6359633a91.25.1746811113760;
        Fri, 09 May 2025 10:18:33 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc883bsm2097897a91.1.2025.05.09.10.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 10:18:33 -0700 (PDT)
Message-ID: <2a3cd48268044afdb6f285bbfaf33887d2e46cb3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 11/11] selftests/bpf: Add tests for prog
 streams
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>,
 Barret Rhoden <brho@google.com>, Matt Bobrowski	
 <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 09 May 2025 10:18:30 -0700
In-Reply-To: <20250507171720.1958296-12-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-12-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> Add selftests to stress test the various facets of the stream API,
> memory allocation pattern, and ensuring dumping support is tested and
> functional. Create symlink to bpftool stream.bpf.c and use it to test
> the support to dump messages to ringbuf in user space, and verify
> output.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


