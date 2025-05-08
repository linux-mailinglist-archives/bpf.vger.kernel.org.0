Return-Path: <bpf+bounces-57826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 349FAAB06E3
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852461BC2FD6
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867E231A21;
	Thu,  8 May 2025 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgWoC8X+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9E22DF84
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746748451; cv=none; b=Z8URx+Ev2fqB4RkOC88HBvnYXmaLzb5QnMSKjQ7P2urV2xeMykEhxCxXrl7tXMzn4M6saDm7d5OCmhUMiOy/5Ixi2+M/88y27yXr6z6T2pR+eSLk8cQ3ZQV0I040LtwKE9vfq43VzWHokkkKRhb5bZg+VqPXYfHdRnwliBWThpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746748451; c=relaxed/simple;
	bh=fEldLnsJS4W4aJy3SW8BQb/8d6GmW5bp620bSDDvR+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q1amZwD7iKb3lAWV+AMJypvKBxbtotdms6gVRiLEym39gYTPPKVnnVXny6MHgJq/jP//dWQFH+bY9ewtd0jNmlDtYw/bdSeQgCS7tpf9e6e5K9EWf7w8tnU45H9CCQcU6sKBnzRLEwD9u+HkRpvUliKfkRjCNURGADIK4eOpRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgWoC8X+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so1609838b3a.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746748449; x=1747353249; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LAYh2bRKld+LDQWHzyi7xIHrUG6v/a6LJs5U15x11x0=;
        b=mgWoC8X+oC84bl2xCCv4SPGk7/IXG7NQTmE5PGeims2ng6msxuNBnTgow5Dy+KUcOP
         PhEBq1DBfcag3ltYMRcZj9O7Mi+2XliAqlNFZzTnC3I1HevE0Z1pv/beW1umEyQdOZGu
         q0/j/BLxETxRP9mUzdB2R+xrV/bMTHeycn1WVD/DGTZRoHzWvysfX+2dHbRBOOBmNkfv
         YwjcSdNBCPGyU2sr2I9Mt8i0FD5uCcVHTxjQCRCM/6iIGM+imxIT7HxtZZtDNqhhoOF+
         dg6K2PtKbkVSUG5rRGFRazXg0ueUuDTSrKEKqidh8ykvP/sWxTp6hEJZageoMNVX8DMW
         Tysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746748449; x=1747353249;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAYh2bRKld+LDQWHzyi7xIHrUG6v/a6LJs5U15x11x0=;
        b=w1MZurh/27BgxBVcdp4/icvLvmcbJw6fGwjWeQSGFisyCUZOAVEyq86iweiKgMDUwQ
         Emiy4B8fjKQOLYxW9uAQhaQiQ0r/m1qqJldEvKOkAP/ZceL/KEp9HT1EJBVYWNXfJMJ6
         rWkHOfY+DiC7IWMfPadGN1VpGM1LTv00sbOuG1eV6Zes2UtDNzoVU7jaAvvSkGv82H2K
         +d8eDDKKZDssuz9lEDU5XLAWAe1AZJsuWUo19N9Lq7xhmQptblkN5eolk5HnZq0GSUwf
         8i/K484pocLZTgTUX6u7Ja8vJpHYn/WKcSLTO4hzBvr567DomgZ7X2O8Sy53nOt3jfMs
         4dkw==
X-Forwarded-Encrypted: i=1; AJvYcCX4/DB49ASwq40CiDStrufhC7Qz2992qtbmrJG7OrJuqcr6OWhTpD5u+h5ZrA9r4/MXbw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCSmJbXDRonuyJYwpMteiKz4NJfO6B2roh4XYWDpK6D+2vq0c
	1NA9IXe3sMSs3SEj/UwcEuiQO3Qmx/7knOuAoIrcoDgHpizmBTr0
X-Gm-Gg: ASbGncu1e2S2pbMfouYdeUqwLZickt0q7QJ3/JjwhNL7T+X4ssvn4Mqwox5nbKbMReS
	K57yNf2PjB/HY4JfGMRuZlnxblkGjKMy6D4/PrHygq5QqkL2ErqPtvXhR/ayvfIR/gEvzwdhO8m
	zcySm3zWvva7mnvtx0bT+wmBsGKTJpgs5bbBaLTo8GRhtLjqZUwURqCX/XNezNbCK2YxkVKQ6fO
	aTI/gz85qV7cNdBRGPEgGEBKbHvySyqyh0GS0YG3AK+sGLLC16OhIPu8kGgzlemkJhs+BascU0e
	ofFkIyK2e3z9tW41vD09z75sOMs09Kfkvx7L
X-Google-Smtp-Source: AGHT+IEHfImZPpBfCnhFggG8nfzGe3BUG2JBMGeq0ANW+ITJPW2+4kYH5RBVXkkKqcChG1IrFAM+uQ==
X-Received: by 2002:a05:6a21:107:b0:1fd:ecfa:b6d7 with SMTP id adf61e73a8af0-215abd07500mr1590344637.28.1746748449080;
        Thu, 08 May 2025 16:54:09 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234ad4206bsm438177a12.43.2025.05.08.16.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 16:54:08 -0700 (PDT)
Message-ID: <d0124e4b25e3e343a279d854f75856ca48f4fa5c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/11] bpf: Introduce BPF standard streams
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>,
 Barret Rhoden <brho@google.com>, Matt Bobrowski	
 <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 08 May 2025 16:54:06 -0700
In-Reply-To: <20250507171720.1958296-3-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-3-memxor@gmail.com>
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
> Add support for a stream API to the kernel and expose related kfuncs to
> BPF programs. Two streams are exposed, BPF_STDOUT and BPF_STDERR. These
> can be used for printing messages that can be consumed from user space,
> thus it's similar in spirit to existing trace_pipe interface.

[...]

>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Read through the patch, implementation looks solid,
but I'm no expert on multi-threading within kernel.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

---

For the sake of discussion and sorry, I'm repeating myself a bit.
Current API is still quite elaborate:
- bpf_prog_stream_get()
  - bpf_stream_next_elem()
  - bpf_stream_free_elem()
- bpf_prog_stream_put()

On the other hand, this sequence of function calls can be hidden
inside a single kfunc with prototype like:

  bpf_stream_read(int stream_id, int prog_id, struct bpf_dynptr *dst);

Which would slightly complicate stream elem, as it would need to track
amount of bytes consumed from it, but completely hide the
implementation details.

I'm sure you thought about that, what is the reasoning behind a
more complicated API?

[...]


