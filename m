Return-Path: <bpf+bounces-22142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1796D857B80
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 12:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B2D1C23D76
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 11:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F98D768F2;
	Fri, 16 Feb 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj4A8zfR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2D768FB
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082589; cv=none; b=M5hbxmzeKPi/WPl0DsljRX78k2sI6qjW9YfNxGISvRK1k7OAZ/wUcRkyaCewFzYQPeXw3Gp2vmesiS7EUYcXrdxSR+ZAP004r4bacKt5gxI2PKbPk/D0G7C2Y1H8x5Ib5IM6tWSZWyWa4kga8wyHGWG3XvjTRgnJASSedIOJnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082589; c=relaxed/simple;
	bh=owt05+shK/GxfI4CsX3ERS9csYHAoLkp8525G2aQe0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpCB+isEl9uWuK3sZalRacTTLqU4jaHI1Pja/YR6ujZLu9zM4OcBGSchkfvIC6fpM5K+i5FkhIPN8up7tukXsPKxqGxKOVn68r59cZiByVg4rsIwSq645ePRKgJmYpZGpF8T/hzAMivShcXKnNXLsPi7rCKYGdZxeCgRPr2CIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj4A8zfR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so2966489a12.2
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 03:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708082585; x=1708687385; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W0kejm1QWgYddC6bSe8LVWfpE4wGWqcUjJH/Pl2PVOI=;
        b=Jj4A8zfRQ4xbW8Xy2A1/ZGdDqQbQ2Ty0Wdzh3SU8W3zxGCVhJlR7rhHIwaVRjIP2Xd
         z4NNlf7kY8ZyoT//GiIT3X2/cAdMFxirVNuIDaO0as7u2MzX+7PF2HwJ9N5ph/X/kIeq
         39s8RajRwQZZ12xiXHTrIfV86s6ZW1uKtJ/FbBMNmAEq0zI/jQLomj3bs8wR9a7djucu
         HRpFj/HpXJRvOyvb4DMLUGHmv/EaqH18SnHnBJ2V/wrtLuryrTp5LJOBFPykgh3KowmG
         NcplrBjfa293xLpLvw4WAfTA79FeClCOkvUyOK7AjugRzoTB7V9co+PygdQpGQhlZ8rr
         wWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082585; x=1708687385;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0kejm1QWgYddC6bSe8LVWfpE4wGWqcUjJH/Pl2PVOI=;
        b=W+ESk67lQFERNufyB4w5Gmb7ICvtJv5UGqB2K20u4vLnbg+K7ROio8NszgFfOIb33D
         x0j2m6qW25CB6reJvtNkVqe/kZn6ZK9mDBxO39U7DWErPOc2tnJVBgDaPAlE8Q2sY19P
         Coxy3CSc+Z2OQ3+iAXa0eXJ8TpbovFSlCZ913XWMutL4WISpi4a+qBNQ8duyt0hEfiGd
         Gqas6SXPsR4Oxq4CMm7oBEmdUxd7WQnVOiHZ2ABl1xRyvXj9EALrvB1cJcw24zHjCl/s
         kAyASKQzb/uKzG9xdav0t01/eZNNKCDksoWrPxbkGvFrfzL4GVpf/AkjySK7LuNEkpRz
         MLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBrAGgqd4eDqpCC0tSgeTBRTLb0MA+V1fctKzFM9RY2SM3X5XQzcAsedLTTWHXQrqduHOLx1ofFuQjPjynMFXnx+yH
X-Gm-Message-State: AOJu0YzlAIjtCoO7regDPu8ZCt9YgCWkcLD8vALvUROD85PdRpQL1IUX
	ge6yDSHtS+L6G1Ue0tTQ+F4Od85NHvHbYK1OGbfeazIKCOZLRrex
X-Google-Smtp-Source: AGHT+IHY29VILV6QRNcArsXHLJavqYNVoIKjzpLCCvQTZOqNS65g52ifg9Ao7mRyYAmn5o8GtEOVAg==
X-Received: by 2002:aa7:d7d0:0:b0:560:311c:4fcb with SMTP id e16-20020aa7d7d0000000b00560311c4fcbmr2986423eds.33.1708082585278;
        Fri, 16 Feb 2024 03:23:05 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id eh15-20020a0564020f8f00b00563e97360f9sm501099edb.31.2024.02.16.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:23:04 -0800 (PST)
Message-ID: <4ef073e2cf3f5b3c7094e81593001ff068ee9f64.camel@gmail.com>
Subject: Re: [RFC PATCH v1 05/14] bpf: Implement BPF exception frame
 descriptor generation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Fri, 16 Feb 2024 13:23:03 +0200
In-Reply-To: <ff88196b95f3f05e8fa2172c101cb29a55a9c3f2.camel@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-6-memxor@gmail.com>
	 <ff88196b95f3f05e8fa2172c101cb29a55a9c3f2.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 20:24 +0200, Eduard Zingerman wrote:
[...]

> > +	case STACK_MISC:
> > +	case STACK_INVALID:
> > +		/* Create an invalid entry for MISC and INVALID */
> > +		ret =3D gen_exception_frame_desc_reg_entry(env, &not_init_reg, off, =
frame->frameno);
> > +		if (ret < 0)
> > +			return 0;
>=20
> No tests are failing if I comment out this block.
> Looking at the merge_frame_desc() logic it appears to me that fd
> entries with fd->type =3D=3D NOT_INIT would only be merged with other
> NOT_INIT entries. What is the point of having such entries at all?

Oh, I got it, it's a mark that ensures that no merge would happen with
e.g. some resource pointer. Makes sense, sorry for the noise.

Still, I think that my STACK_ZERO remark was correct.

