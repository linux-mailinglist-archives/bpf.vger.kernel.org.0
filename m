Return-Path: <bpf+bounces-75852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11263C99B51
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 02:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E129C34580C
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 01:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D651D5CE0;
	Tue,  2 Dec 2025 01:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM2OKF3d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47278F4F
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637683; cv=none; b=DZhcFM2RLA1M3deN+nkPHeYWc321WDFmJ5nw4q56ZGKPE5IYQz7xBsuf8c/yjzzHQz3qC/KWlJSwVqIOWuTkpljdS1F+Aj9wpYYQR6ldyo7XWcobA2LzWONPFhKGNM6bGQkReRpXV1AckwPnMyY7WQ0ojSpr6vjA9tr+K2Bd9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637683; c=relaxed/simple;
	bh=eWdulhp8izbC6IuzxMY+5OmK/0KTVlwK7wHwkQI+i7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZesPkjtGCk7KTXZ8Rrib40AEbYDlHbj9n+HpD4y3QT9Ic8vwTbvFB75R5SpkjHtzYaFzySf4fzCKLADaSxc2a2d4nv/OQNh4NOZyIpXx3IyiEJeRfQtA1nn80S+8kBh0vGAn0rah5XaVgzBrAMOHsBCj5UbaYak32X0jmLsL3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM2OKF3d; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-343f52d15efso4470749a91.3
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 17:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764637682; x=1765242482; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eWdulhp8izbC6IuzxMY+5OmK/0KTVlwK7wHwkQI+i7c=;
        b=PM2OKF3dpL0/rAX3AgZXI0M6mvMZvh+4h23jY06kB6zsS54v3PsaJIClj4bilQSFmx
         dcTeZw5VdEIAc+WySLDQ3YzwOycfW1MKzzywoZZ6mVCgMowf9QgfQ9t7bhNGTU7zp63S
         l9ZYF7lMNpM1zC7g7G96t0PVot/EUIK4if3QpY5ELCCtdxez90hwLZcpf/p3FX3yMWh5
         T7CZzL7fLLVK7oPSqYYI5A9hSqvgXCFiZKa9KIhG6mlIuhj++oawRY5p/eXAT2FZIsPw
         myHgBLkhm/BD7UXO79j5MRzYJfO0Z1fqHithyBrmk+njtBMBMa95QCpq+vycNHxogGuI
         CTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764637682; x=1765242482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWdulhp8izbC6IuzxMY+5OmK/0KTVlwK7wHwkQI+i7c=;
        b=MFA9xyd2AQdsGD297Hyl24fBRWOnBUm2sxx077aQdDXu9GlDzY0Arpc5j+4GbCOo8e
         Yn86dzBs1axNmIKNCL+7IBRr0i6inxvfsL/JRZFpvut51lsgCDrFDctMW9O7wZaW6/oF
         c6JYeoUDzzPkQyA5Y7fOun82i2vUAeFUF5Kt1HeyIYWVmVnDAEEEJJ2yBWYGH+AXYdE5
         yLWXfa397P0JcdEcdXR5YW5tozK5WM3G9AzjdtjYLn1Yd0s8OcWYBMkFYblRmR8KA2KR
         X76vwXOS9yx9FQ3Uelwt+7a/7Hzm1n21+C0Hn8uQPWbuXZKakfXU5H7xRLEd4Yf1omSY
         8yiw==
X-Forwarded-Encrypted: i=1; AJvYcCXdXDvZaJt4QgAPxjVAPgz7bKO7jg1Nn3asT0/u70zpKq/kVEKnyr9Dxjpr3hy3kx8Bqjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoU3Sr/7LC4eyc6bN0NqlmV9DkassFXLlFlR5/XJ0XcxhU29u
	LQTd1nN2XcmhoaYnUAarwMSGpT+vKh3pGGP40XY/NYiMED1xG2ePDJ5Y
X-Gm-Gg: ASbGncukAJbfG2Pq57mzxHvz9p4Qe/PPnWhK0ZK6K3Hw0gdFoblz1ByC8XdFZUJAjMn
	4lkoi4nVoDJy0q2vHu5jInBWbOpvmdln043NnQzYXyu10PIbcKLOk7UdKxnzWRf0AqnKMJKlYfP
	HMuq7Nc99xVE69xCamSAaLX2b6KJcIjLFezlMy0NHawOKzvSHZzqJdd6a1J4LNRjQA3seq2ys3G
	WDPwlNvr0H6Wtwxxf8cKfIbIiGshuCV1N8+PJJ6qImydQnDhzPsU612uVLDspGTqJkKeQOto8Zm
	36hPaocNLE9h1id/uNM4YokEmOFG5NB49HZtygNav3OFCVDG2XO3Dnb+Vo9zb/LRg0difANemo7
	8vLQ5w6ysmBjq+aYfDU8AFtRD/zQQRDKxUaII1YXOyLMN8AYDccSvO3odJmZY78CHHTwfzUE/r1
	W8CJlXOP2iEViUNP5FQaQj3CWea4m27TQ5B7Ef
X-Google-Smtp-Source: AGHT+IEl0WpC/9uypCc810uLwzQAy7UVs/eCHMADhMTug1ScfnH0wvQdnTIma3Kn3kNemoY/12Lipg==
X-Received: by 2002:a17:90b:5404:b0:32e:87fa:d975 with SMTP id 98e67ed59e1d1-3475ed7d8a1mr22979302a91.34.1764637681411;
        Mon, 01 Dec 2025 17:08:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:45ae:c5bc:5f53:e134? ([2620:10d:c090:500::4:ee7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b732b91sm14401415a91.9.2025.12.01.17.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:08:01 -0800 (PST)
Message-ID: <8da95cbd0f554e3ab62a40116f8fd08201a1d593.camel@gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test using cgroup storage in
 a tail call callee program
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Date: Mon, 01 Dec 2025 17:07:59 -0800
In-Reply-To: <20251202001822.2769330-2-ameryhung@gmail.com>
References: <20251202001822.2769330-1-ameryhung@gmail.com>
	 <20251202001822.2769330-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-01 at 16:18 -0800, Amery Hung wrote:
> Check that a BPF program that uses cgroup storage cannot be added to
> a program array map.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Hi Amery,

Mabye I'm making some silly systematic mistake, but when I pick this
test w/o picking patch #1 the test still passes.
I'm at ff34657aa72a ("bpf: optimize bpf_map_update_elem() for map-in-map ty=
pes").
Inserting some printk shows that -EINVAL is propagated for map update
from kernel/bpf/core.c:__bpf_prog_map_compatible() line 2406
(`ret =3D map->owner->storage_cookie[i] =3D=3D cookie || !cookie;`).

[...]

