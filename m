Return-Path: <bpf+bounces-42862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB469ABC02
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 05:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212FBB22C69
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 03:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883684A2F;
	Wed, 23 Oct 2024 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaUBNhuQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB2A48
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653091; cv=none; b=M3lkfPzN5FzBLFB/lE+zWLbbcTnwuVShKEaO05KTdZQ+DzPE32KPIHyZPj3zOSisbyUzhQ7twu+UWYQPBR8QsGcb/x9vwNrImYhqoBXd4TcVuyfYkj1tYftRd3roCO7x88nBGl8Tz26i2bunma1InlAbV7Sj+NAKjCj8jn9P3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653091; c=relaxed/simple;
	bh=m6V3+IN7zja2l4GHx9JnEy4fWt2l8wZ29RyJ86ffi7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onANq0palsgfWhumjMqp2vacPRyfBxmFYRpp7+e4kQLg3+F4LleGFyXdtUbyW6vHHDMoDyJv5mQaRmezEgkdX2trS1gAna4OH+ZvFf4CFuBGEtTbIa4z5j8EonyhWDhIFWdxFApaN3Q/5CmVS5aEpv7x6RWU+Qa6KmlMsUpEaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaUBNhuQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe3e99680so34984496d6.3
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729653088; x=1730257888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJbXiVtH0xSCceYJ6JHsbi5DNW/5MWiMDUFf+8iYsqc=;
        b=EaUBNhuQGOgqjsvOqr+TIRbYxwdINn+Oi1s4e9rCyQakueP5vHaDg34l08wS9BQdVl
         IEHJBhWtmefLd0xjrkqXZ5G3Zw9JiHt3Zh/lKJSnGQ70RTKKZWjRB1UpewU0HjoT+T0C
         zNrdh9DoXdfbppeK6lPcnOI5+8vxA7RAOK/kvnxniJheIu35+x852ndtDTdYuwFCUlUh
         Flf17497JJUXNsp442cVpFJz04lqjofEGFKSFD+9mlMRKlDo9+uKq9w6xzxBzjMW5Yr6
         1NNiZJRRF+wscCBUi671LnVwpWZzbEzKzcN0VNtRdOFS1yju2vQIVquiAauablnBj2ph
         d20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729653088; x=1730257888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJbXiVtH0xSCceYJ6JHsbi5DNW/5MWiMDUFf+8iYsqc=;
        b=UM7Ze/SiXGq4Mup/i6IT5gonaaIUPPZt6hUtQa6hyB/LCBk/1kCgdgQHZ5OzeYAQXk
         a7DPCH3v3oIncU00xLUmmjqNqAzBA0KEq51roqG+kxAKi27atCLYkkECEOAjkJMbJEDA
         PAXZ7BEj5G+8lCfnDPoDenttOSdhZejVWf/WOmnkszVXFi7g3J0v+/wnAL0JRLdCO87O
         /G+UDc1CeFcaI3iiwWBHWjjyl0cD8uSRZZ/90nZM8VntA01kpN3Y73NJyTrUrRrra6Ag
         fWEmlnAcYFDZW+xTybcTMW4RFQ9BAloRTqsVPn7lp8V04s6bW3wZGEEYMbOKCZXJf+bE
         Qfpg==
X-Gm-Message-State: AOJu0YwRfgUqdUDU+LAybB3zy7XirHlBfBAt2fqHk96Js1aIODL88vzN
	V1iWcLyZaZC7rZyv279/u8lBZMIAJ7bHiDBIIW/9K3gHF4vgY7r+lxFIhwwCFGx+Mk+ZCVHgZVX
	6JoFDRi46t8kthy9GKLwZPKbTw1A=
X-Google-Smtp-Source: AGHT+IEJtIwes7aIgzF7309xJB+SNy9nyZsXr22vw+NK+F42P/aTRE4FpsO6nJH8vOHkk98uxE8p1TBqPKkuOvN28o4=
X-Received: by 2002:a05:6214:3d01:b0:6cb:ef34:9c00 with SMTP id
 6a1803df08f44-6ce341a4749mr14209606d6.12.1729653088490; Tue, 22 Oct 2024
 20:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com> <20241021014004.1647816-7-houtao@huaweicloud.com>
In-Reply-To: <20241021014004.1647816-7-houtao@huaweicloud.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 23 Oct 2024 11:10:52 +0800
Message-ID: <CALOAHbB-asooCmJSq7wFeXo2VV++WKeU2BMfgcAFRNoAy2OTGg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 6/7] bpf: Use __u64 to save the bits in bits iterator
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:28=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> On 32-bit hosts (e.g., arm32), when a bpf program passes a u64 to
> bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to store the
> content of the u64. However, bits_copy is only 4 bytes, leading to stack
> corruption.
>
> The straightforward solution would be to replace u64 with unsigned long
> in bpf_iter_bits_new(). However, this introduces confusion and problems
> for 32-bit hosts because the size of ulong in bpf program is 8 bytes,
> but it is treated as 4-bytes after passed to bpf_iter_bits_new().
>
> Fix it by changing the type of both bits and bit_count from unsigned
> long to u64.

Thank you for the fix. This change is necessary.

>  However, the change is not enough. The main reason is that
> bpf_iter_bits_next() uses find_next_bit() to find the next bit and the
> pointer passed to find_next_bit() is an unsigned long pointer instead
> of a u64 pointer. For 32-bit little-endian host, it is fine but it is
> not the case for 32-bit big-endian host. Because under 32-bit big-endian
> host, the first iterated unsigned long will be the bits 32-63 of the u64
> instead of the expected bits 0-31. Therefore, in addition to changing
> the type, swap the two unsigned longs within the u64 for 32-bit
> big-endian host.

The API uses a u64 data type, and the nr_words parameter represents
the number of 8-byte units. On a 32-bit system, if you want to call
this API, you would define an array like `u32 data[2]` and invoke the
function as `bpf_for_each(bits, bit, &data[0], 1)`. However, since the
API expects a u64, you'll need to merge the two u32 values into a
single u64 value.

Given this, it might be more appropriate to ask users to handle the
u32 to u64 merge on their side when preparing the data, rather than
performing the swap within the kernel itself.

--
Regards

Yafang

