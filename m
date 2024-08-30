Return-Path: <bpf+bounces-38542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FCB965DFD
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 12:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DE0287B7D
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD717B509;
	Fri, 30 Aug 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD/UlPGw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74114C5A4;
	Fri, 30 Aug 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012467; cv=none; b=Dz9kuWqfGplbpb7AZfRn5Vkk/I1yttSBk68Il0Hbigqn9wzEcaSIOJ6azKdWcr7fkahpgDv/SEawa0BQWiG9HO7fU3t5+jTXSuZGw2itPwUPTnHVfM8nXzs8eGuFOLVNqAEWTITeKMYSTt4AjtX/2i/L3HD1dVWVR1i5X5460Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012467; c=relaxed/simple;
	bh=AWvMASz4uOg4mwwaAtxrmGn18u0G9eTF4Rz2g5iT874=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJzxypLYyYlBG3cmHhKymTQtkzVJ7d4K3BsW/F1wD+z8wXosi4XGAcGpzbWExYvGgo2YtVXwXoBMSj/GGU1HeS1pFBaIfmcq0LxNKOzCVkScM3HQ3c4kv3I5HMTuBl+qPxpVDcm9EypA2PwJ+fIvHbMuBPEh7mBqJzD/5jL2r/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD/UlPGw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71433096e89so1345822b3a.3;
        Fri, 30 Aug 2024 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012465; x=1725617265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AWvMASz4uOg4mwwaAtxrmGn18u0G9eTF4Rz2g5iT874=;
        b=XD/UlPGwHZf+VZI7sL23LFqySiiWLmMKzu85y92goSuO6UYiDO0JPcI7p8BJQS18LM
         gXkRYIZXdwB6ydBMt3ZKi+6V8BSeKzRNumr12krhpL08XquAw2BgVNtte7zl2YEdClrb
         gIkJGsALpg4ffd6FsL88By3mZ+buD7ck2AYtl7dWKFHpOV2casNBPEhrhlpIYdrqcbBe
         hwPzuvOkAPUyNQwLocLQ1ZZbLIvxPeu6fh61YDJ3cKjzb70TVD+A6IbF3p39WHYcCIJP
         PPAUA2j3E97hc7JKK3aRpryt/XskNiu4QGIm7uLoj8vWHVLHB5ZWhLOwh3wM9KK1+xXd
         fSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012465; x=1725617265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWvMASz4uOg4mwwaAtxrmGn18u0G9eTF4Rz2g5iT874=;
        b=Hv7fjK5ZtQSSszDrCwsYEDdj5Xg6IeRZxVhr3F4CBaftZHl7PWG6cpPNtAajUw26uo
         A/Ar7qgoADJoHJbnfQ7exSI4KTNDUNKJnzu7H/fcij/moHmHsp9tBYrPFYnEKtQuf9QF
         9AG4DzABDYcsvpgcYmEJg/YodHAXlN3rwfkkuOu+WKAGk3IRudDeEwnTgC12RbxtVDXg
         c0g8hbIOD//9lNOLZoJcISrA9mo2dhnjPK1nGc2fFOJs3auocFz4VObf2Q/AYBYd7Z+v
         vEzic4KJ+2qXt5BaBE57GCg/X2+xDC2g8kwMvvbPIwankRULxuafl/M44ci4/SNNOz5F
         VmEA==
X-Forwarded-Encrypted: i=1; AJvYcCUNKeGhB7m6FDqFHizIb6a4wy1rr2u0vQo8qlPyvii4sGFtAWvupJ01wp1Ugfi5lg6ipTw=@vger.kernel.org, AJvYcCVewLMlgOmOndNFa6H2VamKxSIERtH+9xkfZKLn9BhlehqSu/DsuSs/DRgKiLpS3bWtzUw7EzB4RA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGALfFPiARY/ABnjcVIVGZ9l3wiBQusDW1x4y4+H7FPGhujciC
	oLRfjThA0rQ1L01Nycsdjb9N82iNK41c6y0tIuOJSnc847G8eOxF
X-Google-Smtp-Source: AGHT+IFDCBZg1FQiSPORi0I8CVq1otpvdDR0OGGZKUvoG4x92NdZEkcR5BLFKIGSoAHyhNkUzVABtQ==
X-Received: by 2002:a05:6a00:944b:b0:714:2dc9:fbaf with SMTP id d2e1a72fcca58-715dfb7749fmr5952900b3a.18.1725012465173;
        Fri, 30 Aug 2024 03:07:45 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55771f3sm2521595b3a.12.2024.08.30.03.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:07:44 -0700 (PDT)
Message-ID: <af03a689272fdc85d6f57f2571204df4a83b6205.camel@gmail.com>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent
 pahole changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Song Liu
 <songliubraving@meta.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, "dwarves@vger.kernel.org"
	 <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko
	 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Date: Fri, 30 Aug 2024 03:07:40 -0700
In-Reply-To: <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
	 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
	 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
	 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 11:05 +0100, Alan Maguire wrote:


> thanks all for the quick root-cause analysis and proposed fixes!
> Explicitly checking these cases in the btf_endian selftest is probably
> worthwhile; I've put together tests that do that for non-native
> endianness but just noticed you mentioned you're working on tests
> Eduard. Is that what you had in mind?

Hi Alan,

Yes, but I need like 10-15 minutes more.
So we can go with your tests :)

Thanks,
Eduard

