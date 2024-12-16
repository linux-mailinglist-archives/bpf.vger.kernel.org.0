Return-Path: <bpf+bounces-47061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F359F394A
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D11881394
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5AC207679;
	Mon, 16 Dec 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOOzykP1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999FE126C08
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375033; cv=none; b=TOqqYWP2MIHqLZGgAMq04S3pUfVsp156YqJgaUsHXH3uSarmmto8RGRLq3lxSmjBKDcfAr+80QdIggqTJRAD45eeEftolq/QfTtJcV7Q55hFcE5BMKNUl3KBkGmqk1/H2zEsa2ZoSuyByI3fEWLxrJKveHGb+K/YGSS/OVU5JKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375033; c=relaxed/simple;
	bh=H8IZ/13KpfcT6vWtQYyt208GrF2HAUEdRnn7x77iz9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jNGEXAjU5eAb7QUKBlApqvgtB5ohaW5R70bgwRsO8bRibLoatcu32lKemffqB4EuPyg9Rnl1Cy102gdU1tRV6c0WNuJ43kgOg/HwCQjlYO3m18LD9Y5BULTsw3idoXm4GPHauLFs5asMl9sWInG1g7ALw1E8zpaVvc82+iOQi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOOzykP1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72909c459c4so2806732b3a.1
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 10:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734375031; x=1734979831; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H8IZ/13KpfcT6vWtQYyt208GrF2HAUEdRnn7x77iz9E=;
        b=NOOzykP1bzx3eeiFe2LZlEpUQRqXOWc59Pi9LXwu356OQxn6vaO9PLDZKazOLRzd05
         lEf0lQjzUOpK3lJr0A9nRoysXIvs8hd+/kl1V2fQv83D6mP8+Vg6bSszvwBVYiZk9HZ5
         2Ci7RXFC4QatbZKb62souahifExpLvXRWlBYvN5hzgu1MGXCzKa3Qu0ESO/x0SoWAlEn
         FCw7A1kNcjP1Nqo2nRg4hJ0Xacqln3rJ7/AWJ3X9RybHY06fMADEmdLmwfpKYXe8KH49
         FL564MS+Gqgws3aipLCZTa4IHdqk6JnJhbXCqKKkubcczaj1cERZr85mnnvrwdUpiGgJ
         NVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734375031; x=1734979831;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8IZ/13KpfcT6vWtQYyt208GrF2HAUEdRnn7x77iz9E=;
        b=F48WaNzxfOYyQcOCoOMnUTYf0Bm9mPcnmJMVIEaXtvQaHnUZgB4eIqcX1XyZh526Ll
         IVFRH3Emv/yH6/WY/bGJxiXCPkZyXP9TWOmaSoSTaJOkIbKioIqPnnCZ8bVcksg+xkot
         xQwkKTmNbDSxMRHmvpwMJlv++0/An9Vcl5nxQN4UHJMtvDXrvdzm+KCOBHSJPwgBlfss
         EQSE7UO/Cufwj2ag/5PL5Eq7U1CiYS6tURqXUOPMm31YcfhU2+N4mx0wNJJK/E+1/FW0
         p5ClFzywBWiutzWP0lgZ2AHY/pi9oDA+RZKBDZeu/WAGeG9/74HsvkkpxrHN0maj1fmS
         Rb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVAwB5yKXLXcGyJ778tQTG3Z1y/rsrI1LpN5A7PnF6+zy8QnLtBm9XRWPO1BsnXDqSjMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmOO+CwpLKiwfq1lILzIK1JLi0YT8/YjQNAkpjD+ugYt0gxIC
	TlMjHtGz/QMP2N6KnK1B54hxI/TE8FmKMZdZ/nv0iXcdwEYWfUfv
X-Gm-Gg: ASbGncvRwfY5mh/xn254NQeTH5+u6Ot6ICyDDmT3VuYyt5LHDyY6NyMKLSeY1nfJyYn
	GamPp6ovq3Vobq0+/V6lM/RrrARTp5seL7U8egKVgduUcGphtwPWAlStQ0a/t2n3WMDJYwBZMUj
	BAOFTxA05e0WTnoyXKQv6YIC9X59gpqBn1nC6QDSiEdBhYSCpy1AJOYy4eCx6Ujb20260+z94+I
	5BUSfdHOtSkndIBJ0xye/TTS9E+G+Cs886ln+Uce637rG3OQRZg6A==
X-Google-Smtp-Source: AGHT+IFYfjwcxPXpJMg3DO3+n9of0p1a/xWRAYF410UMmFEqinPssCu50GTvhBISaHEaOPpjxDQItQ==
X-Received: by 2002:a05:6a00:3d0c:b0:725:c8ea:b30b with SMTP id d2e1a72fcca58-7290c19d89emr18877641b3a.11.1734375030827;
        Mon, 16 Dec 2024 10:50:30 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad68bbsm5096292b3a.47.2024.12.16.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:50:30 -0800 (PST)
Message-ID: <10d47bb5c43f58cbbcbcdf5f47961daa08ce04d3.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test r0 bounds after BPF to
 BPF call with abnormal return
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arthur Fabre <afabre@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team@cloudflare.com
Date: Mon, 16 Dec 2024 10:50:25 -0800
In-Reply-To: <D6DB4NCLQZC9.I7DUNKR9RORW@bobby>
References: <20241213212717.1830565-1-afabre@cloudflare.com>
	 <20241213212717.1830565-3-afabre@cloudflare.com>
	 <76401f4502366c2d9221758f9034aa7bb2d831a3.camel@gmail.com>
	 <D6DB4NCLQZC9.I7DUNKR9RORW@bobby>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-16 at 18:39 +0100, Arthur Fabre wrote:

[...]

> It might not be possible to do them both entirely: clang also doesn't
> know that bpf_tail_call() can return, so it assumes the callee() will
> return a constant r0. It sometimes optimizes branches / loads out
> because of this.

Hm, haven't thought about this.
You would need assembly to hide the r0 indeed.


