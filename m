Return-Path: <bpf+bounces-60516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9C9AD7B64
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607123A3782
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077B62D4B54;
	Thu, 12 Jun 2025 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyf2Ox8I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4D1F5858
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757784; cv=none; b=lywUJr72VO8LLd0Z6kJwlfc3VBkjkl9KacoP05ISs2ktDN51M6dHivygpFrAXQCDf+Mt8S9CjaAZAImiPKjqu3oAUbgCk6afqZD9nJ8OCgW+vAK7KxP/zWePcfGx0j1k1TDxcGuW3MYCYAb2a2KtteBTXVsPJZH7ISb2oVaxyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757784; c=relaxed/simple;
	bh=wYQhcyVw0FB5Q07FXBQTuV0DUjq5YhH873qs8zPlBqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJZ35kjdQMAm2eNocnEWWhoUQj1YsZQcP27AVzfZHmQog8FRsJvTEhy9g0a71wv0v1a5xXWvT4eNMI4cIiGyhuOYe1lmra/aT2T/ZGZf04zf/fEY9AitSn5Wj+Lvc7k/HKeyD5LSZ9jO9j1tpgdnTqEgjjdMTq9ZbZ4Egp6ox9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyf2Ox8I; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73c17c770a7so1765584b3a.2
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749757782; x=1750362582; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wYQhcyVw0FB5Q07FXBQTuV0DUjq5YhH873qs8zPlBqo=;
        b=Wyf2Ox8Imjw1wgPB4B2veLRhPvJ3N9Pz4Ad6pSRjw4ZLWHrHi9uM0rjInLxBuFbeXm
         6taMh/7bFGFfb08VE0F0Anpzs8j72dKT9oUkeAAcpLnycHhmc7k6SwJyjkta3xW52H91
         /Ta3XAoOp+Tl2+HeKXPib2Eu41Naih6d3yeEu38erVuKGguP2JQ9k7b3bF7MtLBuC71c
         ZS9xbrez9/fI0JGOSV+/yNyD+rIGfqTKccSvDhfRdc8CRPZ7ugFJEE3L5ETJ+t4Mj5wo
         zrHOUAkZBezutU8fmX+Q5AvigDFFllm1hUpwec6Oy1eABh+ClpM1bx516uWfsSi7YIsC
         R62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757782; x=1750362582;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYQhcyVw0FB5Q07FXBQTuV0DUjq5YhH873qs8zPlBqo=;
        b=RqV/5KA/RACMmqkqXNgDHui+fV2ht8gQx/jA1lqCoTVx6tFnv0i9MnS/1VQtgu5XSw
         qXzvIg7YlvMNgFNlpZio2xZ6HP1h1LYeFc0thfmdDbK4vcqy5vx31AzX2TdAvwmAhN3I
         YrSv9rCTDohk3873E2s5fu1F835hm7UJlwl5fW7Rmpzi75dQFpuKblJF/8q7CJg9fK4/
         lx/b+y6qrJNzpUvGJcrMQ/SlG7BLb4UgirGtftqHDUI1DQqw9a+ZToO5dd+/OTs+Xy72
         QL5Vdv1NrsiRPShJ6svsObibkBteUpWX2KSGxJjl8WO1/7GgwdXNPM3K7ghQLmUPlrDb
         ng4g==
X-Gm-Message-State: AOJu0YwOMrnjpDYsXLFZtDqYUjTpz3O85w086WquUE9FozxTXYfmRo3K
	Uh+gwbmZnXrLxfxQ43zSdta62KAMucn/9OUtx47czSA2Ya/T30vTPmcpfC1CsQP4OFM=
X-Gm-Gg: ASbGncszgmXtcGl2ia3ieKBTxMRhgb4JXiumtEDyZGNfRf3Kk220JcgPdxv8/mgw0Sc
	XdzvbZad/3DE2OicSeWd6VusgOPcYtNGC8zzAwkuVOwy0DaK/nUYQNpovmQ3Ra6L58T/y0S8wlO
	J/ZIagY7MSLosIUOcuSQFLgsk25dEJe3hMBsgw3acwyZzudoCPkdPBxSdhMPOhP0h6BBqoJ3E04
	BjW0cWew+uAUcujdJC0hGQcsF5RNqW8gn5RoyKbEZB4DT/0quagBZBcuHDRViuvKB9SBp7Tvesw
	AHPGn+9XYSSL6mbdOYmEphQVrMN6any7jazL9bFTbgvIxKviqEFtK/QbJZ4=
X-Google-Smtp-Source: AGHT+IHHtIqxWw+8QY1OA+TFZYRCxGGNhL9Fj3TM2SpmhumwbfPATsvCInnwjZMRvUpm919ZWVRtqg==
X-Received: by 2002:a05:6a00:3a04:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-7488f704e2dmr668074b3a.6.1749757782349;
        Thu, 12 Jun 2025 12:49:42 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecfc5sm125490b3a.13.2025.06.12.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 12:49:42 -0700 (PDT)
Message-ID: <b35717b7c65a0ee8baba9800dbbb2c9e58c62b32.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm
 codes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov	
 <alexei.starovoitov@gmail.com>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>,  Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 12 Jun 2025 12:49:39 -0700
In-Reply-To: <cbc60943-783e-4444-9d46-3a25e71a6e63@linux.dev>
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
	 <5341c8c05537d6f9a4d252f5c98ec895ade09430.camel@gmail.com>
	 <CAADnVQKNBps+MvPmHG3BGYtNV34ut6L8cF+wCNWCOLTiauuL0g@mail.gmail.com>
	 <cbc60943-783e-4444-9d46-3a25e71a6e63@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 12:29 -0700, Yonghong Song wrote:

[...]

> > Warning in llvm/gcc on imm32 > UINT_MAX is not correct either.
> > llvm should probably accept 0xffffFFFFdeadbeef as imm32.
>=20
> In llvm, the value is represented as an int64, we probably
> can just check the upper 32bit must be 0 or 0xffffFFFF.
> Otherwise, the value is out of range.

I agree with Yonghong, supporting things like 0xffffFFFFdeadbeef and
rejecting things like 0x8000FFFFdeadbeef would require changes to the
assembly parser to behave differently for literals of length 8 (signe
extend them) and >8 (zero extend them), which might be surprising in
some other ways.

