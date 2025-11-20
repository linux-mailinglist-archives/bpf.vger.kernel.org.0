Return-Path: <bpf+bounces-75182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3CAC7625E
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 781FF34EFA9
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60B305E29;
	Thu, 20 Nov 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi1WRbFQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FA2F99B0
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763669546; cv=none; b=uo1XHD7d9MXTqOwz3ENvLkE+iTdXx6qTf1CrulnthQH0OfM72EYooWOUbTBkb6Ba8QdwT7GOrk15IIqIfiYrebMN2HTWIqLBjQ+dCAr3us3k11VBV12w8xpo2iiGCnTTO/ktNeNwFgrO53NHuE+JWchaqPls7sB4Gv11Fm/cFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763669546; c=relaxed/simple;
	bh=lP6d5dwYL+W6nv5Kz56dzsnhy+cIECD/isjPtt4lNjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nD6LSOWtJZS2kklaz6vjmKeD2F4ZMRMRgxKWz+UTLgdG5E1WsFiZvgzlvZTbiaiozLVHUEHtFSsY4VmYmYfPE9CIhGF6j4aGJL1Ze8B26madIuhJAKEMroXmp0CVpVzjhfv9hGIYgAPkmHD5ebylnBSKdi5W/D3u6fDe989RXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi1WRbFQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-787f586532bso12763297b3.1
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 12:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763669543; x=1764274343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArLBssIhqmPzhIFPuYuwBivCUg4rQV57fxyLID3UDrQ=;
        b=bi1WRbFQ7sCxsCI+jCTjZn2Mxk7PHMhdp8VrnlosX/Vv7Gq7p66NSBPgKLBY5WxHFJ
         LG2izDHdvjj9vfpZdbrDJkAoDhMglH/ysyqMMlf3oKuTElc8hMRjG14JdFMEHes4O+9h
         HMQvldKtgRjHILpT/WKNAEydZXbf/bFTiaxRkb4S8XPeDKCEcRtb4X1K9+ADMl6IT8pt
         tFbCAWuHYJk8I6GfDqCeI261m+Q8tJ7J05Of0EgVKqujuIfRxdvFyiPN45GrYlFVAUlx
         wxDLc5OvQEnTFDJ95pQcBpMbJsPfDIlkP5Lzm818ackHF/V+e2JEYPmoIgmGYC6cYlMB
         0Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763669543; x=1764274343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArLBssIhqmPzhIFPuYuwBivCUg4rQV57fxyLID3UDrQ=;
        b=usKxEyEejU+t37GkGWu4HvjDw1UORfSNNyzq4WMc05H+G3v/dnmNz+guvsYJaRDSW3
         ZOtimlB3rTIsZjFp5nbWAVR248MH7B1HPYzenGZg0OP9Iuag3XvC1qWRd3uuj/A2H8w0
         1wJwIpKZkjB0UU3Lb2TRqQ8eK7HiYtp/Rc4H3ZjqaLkvl5cZHZlqOnUCXfIhUIU/ovep
         oa4zy2n+dkcmSgT3s58oZAyxsyEB4rykxctgoXERq7+VfBIR2iQ8cuDYHoI/X430DXkg
         2QIC7o/uIVtG2vcUR/6+iCD4W7YJvaQ6f1/jldpOEpx6XhOoPaYr3RIbxaCXciz+eGMX
         D3oA==
X-Forwarded-Encrypted: i=1; AJvYcCWdRg+FeawD3zwmMRWYh4PKCfMC6DG73HEj21h4Gz/c5oV0Xw3O7CXRkRiA2IVL36Qkuqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2uk2t5bkD63B63m8J0M7kCPvq7vglS45i7US50j5mCE3Uma+
	XFd4rgvkm4BtDAf8F/qBiPISXIWtQKgjqZDPPfIh/vGLnYumKni2ynZAFQK24qAR0cWC3N0L/+n
	nqGOjKVrACHlU834ssIMPnxLHaGfCE1s=
X-Gm-Gg: ASbGncsb6Y88n/tFNUwixI/ovkEFjQI8g72ZtyhR7/C9fsyF3/bybnrq4M1VjtC3oiN
	i2p3coEui8hfiX7wCvhkmFqod1fh8F/jtsr2YqX6h8gaU97+z/mLsmnJiZn1uz0yB45C7NmfQvS
	A3g1E8lKETXC5MH7dQjPhaPnL4SXCBgGKXDjPczmCFrOzzXJpmlnL+giWgoRFhcY/MCqp0S/NtO
	jtprE7RQFw89m6WKsfVean3qr62HL5/dIa0fQ1gWgMUzMgaTUcHV8bvd2QKG6YazL6iW9qgYcS3
	2Np3kRDnN7E=
X-Google-Smtp-Source: AGHT+IGHCLO2HZXDfY2Lh2C6v0dezhGL+uyOjdWenNvCCppd3pfq3EZcOR1/4+hPB+0UBNjcVEwv7WmexiAJTCJeKSQ=
X-Received: by 2002:a05:690c:7243:b0:786:5789:57ce with SMTP id
 00721157ae682-78a79607f78mr35271707b3.43.1763669543514; Thu, 20 Nov 2025
 12:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117191515.2934026-1-ameryhung@gmail.com> <CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
 <20251118104247.0bf0b17d@pumpkin>
In-Reply-To: <20251118104247.0bf0b17d@pumpkin>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 20 Nov 2025 12:12:12 -0800
X-Gm-Features: AWmQ_bk2-fHm4Nt0R2y5_0QXWfg5bB5o2vYXDx09DXPnSNfJW8icAeGFOBUwRto
Message-ID: <CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
To: David Laight <david.laight.linux@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:42=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 18 Nov 2025 05:16:50 -0500
> Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> > On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > Locking a resilient queued spinlock can fail when deadlock or timeout
> > > happen. Mark the lock acquring functions with __must_check to make su=
re
> > > callers always handle the returned error.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> >
> > Looks like it's working :)
> > I would just explicitly ignore with (void) cast the locktorture case.
>
> I'm not sure that works - I usually have to try a lot harder to ignore
> a '__must_check' result.

Thanks for the heads up.

Indeed, gcc still complains about it even casting the return to (void)
while clang does not.

I have to silence the warning by:

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-result"
       raw_res_spin_lock(&rqspinlock);
#pragma GCC diagnostic pop

Thanks!
Amery

>
>         David

