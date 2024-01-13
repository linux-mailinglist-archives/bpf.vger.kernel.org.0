Return-Path: <bpf+bounces-19508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8771182CE4F
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 20:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33900282D75
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881D563B9;
	Sat, 13 Jan 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nametag.social header.i=@nametag.social header.b="w1WchjoZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92263A6
	for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nametag.social
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nametag.social
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so400615166b.0
        for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 11:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nametag.social; s=google; t=1705174273; x=1705779073; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uPFTx35idDi0OW+1HZ59WR/3BMjxNQjlbrogoeRly9Q=;
        b=w1WchjoZ12j0EvVX8xzMKEQjvrBq2zL4wE6if0uGZwgZlQJmmANn4tnKxWloxXqxC4
         ZVJStUrIlE7mdEl2IXXUEPKE7qzdrl54BPwSVfJ4uzTwCg+eJRboSmwOcwRB3IWD3B16
         cM0HCKrSbzzeKhz0bcFyKh7vrLLV/k6rA2B2Y5W2EqT3lkmANxvWwlSL/NdyYu67kupz
         6nhumrfZnDwlP4C0HZwPHQ0gxQ6j4sBrln3uBgKsEwbleWUKn0RP3MmjtxkcaYXmg21N
         bX0tNmd6E8KcDwN5XrnE2k1Po1k1FXdF0SUfHVelbXliD39Gnj2xi7nGC18NnfHj63MQ
         FX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705174273; x=1705779073;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPFTx35idDi0OW+1HZ59WR/3BMjxNQjlbrogoeRly9Q=;
        b=TPFNfcKDKzHL9nj3hHyqbyaUu1wDC7zY/HD4JelbWXA9xeLmQDf7V5SaY1BP9iD4SB
         8XEjmcxRztW2h+zAox8oYG+deD8E7GJSKqlIp8oEGZhScocQZjf68mX8H5aUi7qPBfSs
         LOnO5THFtP5agkORN5DRKXE1KEL36nElgIXuO+GCGYZiH6fZdicJ3tYBQ89EYoSupU4Y
         0Dfvg7XcqxlnwfeOgfxGNiZEfZHGhV+Z8duPCC0YG61pFkgHIhvAJgVw1heNOXAcMAju
         2VHhR2zR7DNAfX+L8dj48psGpu1WmYRKma9SzzIj9ksX5lrkw7XHem0ZDk+HHJXs3J/4
         oowQ==
X-Gm-Message-State: AOJu0YzSw2BVvThts/9556/N5czrxcGGCt/B3LkfvJnaTUFU5q+Kn0P4
	SUdgRlOWrueOM0YYTf8GqZsjBcDAHK7gnZ02e6f1eOt5b0DDjshGY5nWFjYFnfc=
X-Google-Smtp-Source: AGHT+IE1jBVPMlyt/PGP/sBum7MRGjk9yeWm89adJ5Pj5S2bk6H0kmdwrG9ZTLzRgESiBQ4b4fzu0pS+5KOSTRzAzm8=
X-Received: by 2002:a17:907:1250:b0:a2b:163b:8152 with SMTP id
 wc16-20020a170907125000b00a2b163b8152mr1422080ejb.94.1705174272133; Sat, 13
 Jan 2024 11:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Victor Stewart <v@nametag.social>
Date: Sat, 13 Jan 2024 14:31:01 -0500
Message-ID: <CAM1kxwj533vwyxNvCPgXK2p=CxVszOm4T4g0YzaFhWPGATS0RA@mail.gmail.com>
Subject: [RFC bpf-next] crypto for unsleepable progs + new persistent bpf map
 for kernel api structs
To: bpf <bpf@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"

i was just brainstorming at Vadim off mailing list about my desire to do AES
decryption of QUIC connection IDs in an XDP program, RE his pending
bpf crypto api patch series:

https://lore.kernel.org/bpf/20231202010604.1877561-1-vadfed@meta.com/

i'm hoping to gather some thoughts on the below two roadblocks:


(1) crypto for preemption disabled bpf programs

as he mentioned in the comments of 1/3 and to me directly, a non sleepable
bpf program is not allowed to allocate a crypto context.

is it possible for this restriction to be lifted?

if not what safeguards would be required to lift it?

worst case maybe an API could be added for userspace to initialize the
context, as userspace must provide the key anyway.


(2) persisting a kernel api provided struct across program invocations

then comes the need to persist the crypto state across invocations. for
ciphers that require key expansion, such as AES, this expensive operation
obviously can't be recalculated for every new packet.

but struct skcipher_alg does not provide any method to provide
pre-expanded keys, only setkey, which for AES and others implicitly
generates the expanded keys. and adding another function to provide them
is definitely the wrong design, as even regenerating the context on
every invocation would wastefully cost cycles and allocation.

and i'm sure as the bpf's kernel API surface area grows, there will be more
kernel functionality exposed to bpf programs that necessitate struct
persistence.

so what i propose is:

2a) a new bpf map type that allows programs to store kernel
api structs (containing pointers, etc) and inaccessible from userspace

2b) a way for a bpf program to inc/dec the ref count of kernel structs
provided to it through APIs. programs would then be free to store these in
maps. and even if they leak the pointers, doesn't matter because everything
would be destroyed once the program is detached.

