Return-Path: <bpf+bounces-53408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEFDA50DE5
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8795167B91
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7EF134CF;
	Wed,  5 Mar 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHxhwTnp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2C1FECB8
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210983; cv=none; b=B4pGYrw9DEfbVQOjHswBpQS7qwD8HoX9b8c9d0h3JRLZggPCpthn1awdbdoeOWna5IIjmoR3uffFWHZJqf2DPPKouwy3guBNHvTSrYt+PZb8pi9cBdG1Q7Bi65GQ5BJ2f8b/nidNLYvYqLAx3ohgXB0OxpXoKEhfORmhe+nqHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210983; c=relaxed/simple;
	bh=QZqELnIdOuTu3oqMAoWT7p92qSqVU42Lh6trj92+/W8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qltCI2xvRRlRIThIZP+kr3HJVmdBnqFML/NwvrA00wv6+QEoAiVuYSrGqOh4PD96egRZMh2ZpGGx9AfMKA71ATCCBwQgFffAHwz0vjzSjp204TO/caT5isGtveh0ZKkmvcVDAAAjj1Aj+X3ZiD2TfsubOptv6jJ7QRMqjjoENNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHxhwTnp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso20774a91.2
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 13:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741210981; x=1741815781; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZqELnIdOuTu3oqMAoWT7p92qSqVU42Lh6trj92+/W8=;
        b=hHxhwTnpHBklyXgXLdLMxp6nMxek+rHShBT/LYQCaqdwec7IMaeQp8gbV8J0ITGlUa
         9Yw2SVigMAni2p0Jn2dmR+/9EKqM6n/3ecDJ9JQeKGsoMg6DAyOVhdQOwOun7ntAR3BW
         IRNpEsG2j9a/kU/9m9Vym5Ef8fWuIL4JMkPtJgh5xrMWP3BT4q0WM7JKmDmwYZPqgC5X
         me1PoiUBjxWacsnK1UfBpF5KBBuUdp5aVayALwdhD6R4c973mAt70Xzaf/ykjHuYIrtx
         R2jYl42usocnyEIQB1FWU0JXH1rdFYIn8ZPjzfe43oHT3kwFINB8NiszL4HJ2O5lx4iZ
         hUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741210981; x=1741815781;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZqELnIdOuTu3oqMAoWT7p92qSqVU42Lh6trj92+/W8=;
        b=vtArVtl5eu4TD9wdJQV7H4zxLTkls4BxxFz1MgCd2B8yED0If4HinxLv+8QPzTJfhR
         ULxE4znGVmsYN7P+swEImClmshn8HKAvb2jIfKh0mTe7wkxMa56qj5vQHcF8pIt38z21
         MNo8GNjibjHwU+zBJirOHS84zWrd3XUjRKB9jU2p025Q+gtr4AsG9DJyGZli18kqc4/d
         1zuETM4j3PEctKV6h0le7fBHG4sIRLcYgT2HYIvv/ZnNoE8xC/Mz6OVeonLEpNKydGht
         ttTfkBpINUHoEXa2qGB9Xa/I688ZhW30me0gzkK6BuEKOC/QZQFq/B2xCEbpzaPwupim
         euHg==
X-Forwarded-Encrypted: i=1; AJvYcCV6x5WFe3hndPP95CwoE1YLg0m1NwhLf/gMg6Zc2rRJ90yZA2rkdui8kYKnc82F8fDuDG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIdBDU44r+t5AQkmrK+I6hlWVgqYqTSryvP2vl/k0tqevZLApx
	KMQz2S5Ax/iqZWPghKie3VfJqBgi7dt2K039Hz7vJh0FZky2mYfG
X-Gm-Gg: ASbGnct9DYhUVzyZBKpTgkab47JTQPg2FFTalFtj+OfIPyodQNMEhWqg0Yc0DzX1ly1
	hxI5RtgROrUOWfwhGetZUXjsVJS4Bs8MeGJSsfk74qAPLocLQCXNCVENjjBGBq2vm2YGsb7Z0cF
	GwTB9KYKbtt1XRRpuiKbDctqF6jMy5JjW17eI9BVh3/Wa3Vy0PHW2xYhOG7945honsV0ZMUwVG3
	KGjBfn8NxH8eBH9BgvfPpu6xRcQXiXWMBdTeGmFoEHhA37CtIQTNVcsMtosM9u3YUDi3GH5p8jP
	5YauAfNrNomcjoT8zPL7OEj3Kum3gJrvk7W4PLoaBA==
X-Google-Smtp-Source: AGHT+IEkAsE7bGgBc+IRUr0+jVwFO5iJIqhE6a1YRGWzxbkx8olLl3boyORPqEq6wQpyvNQYq8hCdQ==
X-Received: by 2002:a17:90b:3f06:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-2ff497eb7a6mr6648351a91.22.1741210981160;
        Wed, 05 Mar 2025 13:43:01 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e78934bsm1813309a91.23.2025.03.05.13.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:43:00 -0800 (PST)
Message-ID: <38fde1c64ed58c96b08ff3f42e4c57f3698fadde.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] selftests/bpf: Clean up call sites of
 stdio_restore()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Date: Wed, 05 Mar 2025 13:42:57 -0800
In-Reply-To: <20250305182057.2802606-1-ameryhung@gmail.com>
References: <20250305182057.2802606-1-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-05 at 10:20 -0800, Amery Hung wrote:
> reset_affinity() and save_ns() are only called in run_one_test(). There i=
s
> no need to call stdio_restore() in reset_affinity() and save_ns() if
> stdio_restore() is moved right after a test finishes in run_one_test().
>=20
> Also remove an unnecessary check of env.stdout_saved in crash_handler()
> by moving env.stdout_saved assignment to the beginning of main().
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(Thank you for adjusting the commit message, please don't drop acks)

[...]


