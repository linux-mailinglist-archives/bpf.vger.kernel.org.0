Return-Path: <bpf+bounces-60555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3BAD7F87
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EFB3B32E2
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9661AF0A7;
	Fri, 13 Jun 2025 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjUaUxji"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC82F4308
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773756; cv=none; b=imuazbiV0tL6tEny6winfdYbWSq8Z4KxXzj05AVbWFxfYTM55zBZcizwJS8WOuObGf5TiNBRnKbEpy+m0uNCHPEGB5rmc0K2tYcrNv9Jt96H2Dnz/zXNE1MNSzijJmdLLKomi+Ipg/HGRQh5eSy54RxLXO9OTRYJI+E1x2rIEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773756; c=relaxed/simple;
	bh=bp3xVigpGWdm3YUWiatZPsLkMA2LSnKb6kC+5x7qD3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Urkbh8e/Pr8DA2dXFu36d/0bYJm+5b1shEsJ2i0mbtauEJRqCeJIh5iyuFDe9TZKvbwsbZpCIRhLjONYsJiRxm8HyOzZ2v8qo/A538J30fCNwpOU1zU8yJDPs8oVXBnANNazi+7osSKjD0z5fiC93YBR0XB9ZpnKnKjkeupykGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjUaUxji; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2352e3db62cso14564445ad.2
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 17:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749773754; x=1750378554; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=weioOQquisQkmK6E13uxkfJeuMptCvfT3A0AE7gRT4M=;
        b=JjUaUxjiDhAy8rzkShK9Z+5EuybD9HappgMes2BZrPQ7PQU2Th12p4iAiI39jMvlZu
         5ChqaCh8ek/MmRUwi7DwUUTG4bJWPSze8SPr+K3pB0rNju0b5zd1xw3Q9qnU/TDru6Q0
         0Zv9T8Y7VBSsioQj/BiJOJzhzpScN4MU58GMr96ni/0QMv+s+SX4I5QwHW8yk2atvrgr
         D/REMryqcSzsKYAUoF3+TqebsHyxbYbqS6CYFdZTJl+J4xHCVEDLrekAI2FahdaSBQvu
         55q6LO+mCrNv9QEPIkloYqTVr9y1hAgkFm23oS2MmMebd94bKylmP/n6rDD74Ya3NazA
         lzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749773754; x=1750378554;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weioOQquisQkmK6E13uxkfJeuMptCvfT3A0AE7gRT4M=;
        b=jWTLvo5u3Vs/rmZHP+UYke1C6h6OhkNREw8nyZ16MB3x5nO53MFJKRz2x45BQqEKRK
         kECdaLSfjcPlZGaFrfk/4MQthuwG6A158ICj++k4hXozNqF9So3hGYUbNcnO2mYUK87C
         3UOArVRgBAow/Wajia55+XEvzahQf4zOVsAJLd4BBndh9iiDxAehUA6Q6A5F35CR6UT0
         DPK3P81ihZKCyAPrFO40KVpszE5z6hhh1CNLQZJUYQfSzEOQy9rePe7PDxrEBLb/J4aN
         JOrMDqMayM4gS5Tuhmovbnjy8e1wiGoC1x9v1UkijqHMTAMNdasPa0d6axTKuIB3c1+j
         o2zA==
X-Gm-Message-State: AOJu0YyZIw2KBUbXiDEf6Nmu9CnXmWDfzz1GsyFqLuYILP8UUDWyJNnx
	a5jbULCYZsq0t6aR2TO9bdgom/nOc8RGS9Dv7n9JlWGlIKgwByRU/cgu
X-Gm-Gg: ASbGncvg318pfrhUpHaIumg4GFFWFLjjZYNPmQVSfyLMg5a9brWRIV9uKW86Cz54v66
	tm84YP6RKZOLKqXaxCD4r94R+YVjgEoGkI9hLbV20rIBXT7IDnyvmLBpHtZfH5+AepmaCmTXPI4
	zw4ygU6jZXW7KLQye3TsXGfHP/+FLpndNMrW2ywgeZmOUNOpkGDAz7w/9hhW14ee4UuP5NaBC7Z
	yZ2tzgyoXPg7MaRXKw2kGQwM3F7S6l4yvpDztc89yXOB9akGOldMJUDdby4EvqZvOPCxSojfyT/
	fXsM9jUhsQE1qJs+QBaHHP4DDvAAphdR/87DQsHXSW2QcbsVFZvTQHcFijFXxoTucYWisg==
X-Google-Smtp-Source: AGHT+IGSXKewLv/bqgP6DM876qWRCUrFgiQvpHsHtDXFamfzOT+WLDy3hptXeM6fKHd3xVMI23kV1g==
X-Received: by 2002:a17:902:e94f:b0:234:9656:7db9 with SMTP id d9443c01a7336-2365db04cb0mr13975785ad.32.1749773754516;
        Thu, 12 Jun 2025 17:15:54 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decdae2sm3061975ad.228.2025.06.12.17.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 17:15:54 -0700 (PDT)
Message-ID: <1cd8ae804ef6c4b3682e040afea7554cb3bde2f8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: include verifier memory
 allocations in memcg statistics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Thu, 12 Jun 2025 17:15:52 -0700
In-Reply-To: <CAEf4BzawQqu0z8Kq2MRpByPByw52Dq8NtNQnnQy1Mv_YVv4h4Q@mail.gmail.com>
References: <20250612130835.2478649-1-eddyz87@gmail.com>
	 <20250612130835.2478649-2-eddyz87@gmail.com>
	 <CAEf4BzawQqu0z8Kq2MRpByPByw52Dq8NtNQnnQy1Mv_YVv4h4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 17:05 -0700, Andrii Nakryiko wrote:

[...]

> We have a bunch of GFP_USER allocs as well, e.g. for instruction
> history and state hashmap. At least the former is very much
> interesting, so should we add __GFP_ACCOUNT to those as well?

Thank you for pointing this out.
GFP_USER allocations are in 4 places in verifier.c:
1. copy of state->jmp_history in copy_verifier_state
2. realloc of state->jmp_history in push_jmp_history
3. allocation of struct bpf_prog for every subprogram in jit_subprograms
4. env->explored_states fixed size array of list heads in bpf_check

GFP_USER is not used in btf.c and log.c.

Is there any reason to keep 1-4 as GFP_USER?
From gfp_types.h:

  * %GFP_USER is for userspace allocations that also need to be directly
  * accessibly by the kernel or hardware. It is typically used by hardware
  * for buffers that are mapped to userspace (e.g. graphics) that hardware
  * still must DMA to. cpuset limits are enforced for these allocations. a

I assume for (3) this might be used for programs offloading (?),
but 1,2,4 are internal to verifier.

Wdyt?

