Return-Path: <bpf+bounces-78245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B3D05A55
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 19:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3522430158ED
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B68325716;
	Thu,  8 Jan 2026 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUumzDaT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00432570D
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897931; cv=none; b=hbgB44lGf5IM/Mb8me7XYKZ/r5cGeGrkiZH9LIOTtLMjyE1Dtk/GyEwkIF2w3ZQYDuCSHMIbIPptzS8kYXubfqXpbcovnvgpbt3KNUyeYAc7OovY3b+OkUtIKtYSjvc8Tg3MQRjV4OSejyTacxk+SiSIqSg+DFGNx1g52anNFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897931; c=relaxed/simple;
	bh=4s/rgqtEksSggVJsgwsHrOQUcOPpXQ9vvwQ5cuBb2xg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHe2eA45wAR9Xg/cylyI4BIJipqNsblzM2lQHJgCovLgpzHXK3AiX53qwPb6ufs7KvSqsIIYyioe5Di9IsG5N8zWsQdkAKQxAsb3vAflTy5xciCDMb9fHLU6dytcwUQvCiqgy4eerAfYW4xm2AqDLan3AjLQHcffI2iJuFhWO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUumzDaT; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso2271140a12.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 10:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767897930; x=1768502730; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZOQBXxwLSRp7uaPnymaEOginq+RNIVB2bHIODQ5XWr0=;
        b=IUumzDaTZYsJdE04KTQxWygD9Z9y++7Lh073o5de0DN1DL74ebEGZy3maF1r5Mt9YP
         gyHjv4bYY4fcylodOuIfDeq/HJSBhE9YT4VL5vhxFEgS4LjoQiJ9V11S/nW+WI0fvxmv
         VnaM5lQyDNum+EK08rEH0MNyNZk7AYPRPVhRwzrql4mdL7ipJqDyZ3eS6SafZLcEWmCs
         BntTiuKmVT0OhhdgLDWIYgDVjvGJKdGbgng19YE0eL5CcEYHzur5rBhx+O/mstcuyXF0
         98Ja3Iltld7LwNNpNBx0ZGAhn2Rl+sjghSvni6xalr8i0uTCgfakXcgWurVckyq2xAKC
         5GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897930; x=1768502730;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOQBXxwLSRp7uaPnymaEOginq+RNIVB2bHIODQ5XWr0=;
        b=AoNKA/BpyxlKRKR69hB6oaGei24S491YX88WWI26x9oJvd+sEEoqHW58PGNvgNt5Uy
         usNb8M3cgb95bA1m+zBWnZfFXLY7JgK4WLyUlW11TV4GFLSKGfZdXJMG4bFe7ZrbEbt7
         VPL/Ei7K8k+wb11OjPYE011a4crdyw3sRIQGkqFQh3AAcrh4krFrxDrAJ6GLDD7JAlyr
         986JDF3kGm3Rf1ixTZiDAaKGcG8POa1LeUu7VDXYw+t8Zwnn59/wfn6Ho8YOk8Cvlr3S
         f/x4hp6i7u8qo/lvuHgVQzFMTTig5BRB/wCpL4e/XXR5CHSzHtq/GApzqA5C9AzbmY7I
         UGPg==
X-Gm-Message-State: AOJu0YyiJ+EfBzVxRDIlmLMXKbXTY/XDLyF72UNr8RH2omgXlQ68XGX5
	zqKn0fpRLdyeyn2HL1uDUMms5S1D0kla5gPq6WLpEC0TLf3TqOepLzzJ
X-Gm-Gg: AY/fxX4eZGZYw1bFuVkN941TMZ7pOxaKLw2yARHBxbXyE2IvaHzY/GMgJFbVeDFQ1vO
	LG0ika2zkxmGSVltke+B35DnWSAPcC+MkuxffjzoNGYp0MdEIrc0qGYETjvZFKM24tjcJRcbEDK
	8qat8frCE7lHTpurGZnE3mJbfhcsRaHV6wqUo6L+0tlreMsbBvSvRIOgF1yi35WD2BgQ5qRNEOh
	EXf5eQyhNVPv7MbfPcCDl/Hap5u5gaD4GRiXdArRtTbU2sXh+z6NDH7zGau6rGoVzLlD75ueQM8
	hqYPtWAXSRNjXYQN+rQjHNrnb31VJHWZIEGnvXYHDsBp1LIl52Hw1i7eDm/iuxRCSiFEdWIswig
	5s12mvO0enudP4QIAjaXPt69RlkIukoo6C401B228ZPM2qPIos+wJNDveGPZdtpExuWhm3xfpn7
	Ok4mdwubIYaYQkD1j56eHMbqCotoUYqPr0n33FRlff
X-Google-Smtp-Source: AGHT+IHEi/U8kOUtqU+AY1CGiFTO2te6Hw3ygPkyQGvOj7PqmAAwbCxh60LDNAr1SLqGO6KBLaErDw==
X-Received: by 2002:a17:903:40c9:b0:2a0:d4e3:7188 with SMTP id d9443c01a7336-2a3ee428016mr72679125ad.13.1767897929824;
        Thu, 08 Jan 2026 10:45:29 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c47221sm84549275ad.23.2026.01.08.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:45:29 -0800 (PST)
Message-ID: <cf707af183cd296c33576e478c5ba5f561350b43.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 kernel-team@meta.com, sunhao.th@gmail.com
Date: Thu, 08 Jan 2026 10:45:26 -0800
In-Reply-To: <CANk7y0j_BW_t7Y6rPm-UaCsamJ6G3S9i5_0cYLWZ56xp1Dehkw@mail.gmail.com>
References: <20260103022310.935686-1-puranjay@kernel.org>
	 <20260103022310.935686-2-puranjay@kernel.org>
	 <CAEf4BzYeF2sUqEzfT6aLuBVuh1W8fkxHoFjBf-e5nvJW9UgQLw@mail.gmail.com>
	 <CANk7y0j_BW_t7Y6rPm-UaCsamJ6G3S9i5_0cYLWZ56xp1Dehkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-08 at 18:28 +0000, Puranjay Mohan wrote:

[...]

> This is what you see when you compare this version (fork before and)
> and previous (fork after arsh) on the selftests added in this set:
>=20
> ../../veristat/src/veristat -C -e file,prog,states,insns -f
> "insns_pct>1" fork_after_arsh fork_before_and
> File                   Program  States (A)  States (B)  States (DIFF)
> Insns (A)  Insns (B)  Insns (DIFF)
> ---------------------  -------  ----------  ----------  -------------
> ---------  ---------  ------------
> verifier_subreg.bpf.o  arsh_31           1           1    +0 (+0.00%)
>        12         11   -1 (-8.33%)
> verifier_subreg.bpf.o  arsh_63           1           1    +0 (+0.00%)
>        12         11   -1 (-8.33%)

Given that difference is very small, I'd prefer forking after arsh.
Could you please take a cursory look at DAGCombiner implementation and
try to check if there are other patterns that use arsh or arsh+and is
the only one?

