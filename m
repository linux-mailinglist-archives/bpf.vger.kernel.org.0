Return-Path: <bpf+bounces-66482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E22B35005
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77731B255AF
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8272629;
	Tue, 26 Aug 2025 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDYwRVUJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F251E480;
	Tue, 26 Aug 2025 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167136; cv=none; b=TeqtS2UxyLKhO11xSMdyvdl9MPlG5inacIC9oPhyeAEUVU2WLm6OqEpy0wSyrDxdtNj/hbBGnSDPfip8/tizkKOZjQJCeU5QrP1ir31BECN6cSiNH4A+tTyCsaHLBuQrCD8vgaohBcxpvRGMj+oN81SogWTswF+nl4H1d2aIAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167136; c=relaxed/simple;
	bh=J3mr8B5YmTnZaiXfGcD8QOmvS/ZqQuBaRn3POC8Q5nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTbmPbt0Q9wsJKcvnQ1R+kbgvjYTzDVboJQIvpccl21UJRgYA8dDabZiW+8JTeoOHIhRlft1RTHsjGI/faFLDThqL851eXcWAqSvvyx6IKBpCHIRn5mjd6aWnuXs7iEw5QzPzuOG7C6MckvF9QDVvX/G8Ete+Ws9QsvhVZ5UOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDYwRVUJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so4360717b3a.2;
        Mon, 25 Aug 2025 17:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756167134; x=1756771934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9brbH0PiZZeko/TvOCgGk4r1xVMGikukCjKYWMvp7k=;
        b=TDYwRVUJma1DKkluNEB44aT9mbq62f8kHaUD2rmufAfXU+Y4wpHlkpjuxbiZ5an50U
         FMEwEShTobl2U+RNcIVSCVWWAACI0Zs759+zeNbPxIc05qF1S3dFkwRPRM47NunbO8Gj
         khWY0FpXsmj7u/N2ut/Yr4DMsck/iHTgbKMGUxqMkKaNOye9eN+3zgw22igAY7NpaI5c
         VcYnq3xabexEeQ2YAD51m2H9VrPrl2y24acNJpY16KnXYKcE6z8yi6/U9ngcHkSTKjQo
         k8KNCWKn/Vfov9GgKfe9brrHSTQeGgr7QH1VTjn2aDZyUZib+1LPZjcy+ibKDDRinxM+
         2Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756167134; x=1756771934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9brbH0PiZZeko/TvOCgGk4r1xVMGikukCjKYWMvp7k=;
        b=uy7sOZ9IOvuYKGshgdEl3ceuMQuZV/LdjZZyasKYgN+9dH0CP6yPOW1InAHYLcAQt3
         MR0bk91xCJKX4l8u84r8JRiBvX4yeWCBpw2FIt1r+YiHhJjko/roPSj+yBGE0jTrmtiH
         Kd/apJEj7DPQwcp72GtIQ5PW5gkfwqiW1mTlIPPgiNobwu5WPHREHC6NJOcoX9SWRgBG
         hUQ8qQxw9vxKwMYldhG8l7c111dObuh41scGzRDJb2OTgjwqFl+CWSVUY4vtllWxFb9s
         FJ5Tdt0143RjIeH9Gf+WrDhM2G0isVXku5AOyce70r7186V2i7DT9qAhmx3EBEc6VmID
         W0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmyKaxD6E8aAs0FRZ3K2nycwJkKtBjXdJ+LF48o507vjm3ydMaK4Jxm7eZEfgHVqnd/m0=@vger.kernel.org, AJvYcCXVFJmZht9/SVPteYP4HHt01ErQGDWf2HcCKR4s4Vk1VHzI3jA+S03M+FuA6YaWgGlCKX6u8mWh@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUN5PU2IXvHKOmEoxdiFOzTqXJ/1waEd7o6u/vVN1ywdVGBhG
	le7/hkHyOk1xyFaWcPeZEbbeVF47GTnlFgmGeK3vtvQUCGiumB3lRXE=
X-Gm-Gg: ASbGncuGw4vg8OyNr19KRuriLJ4aCC8/rCDif9yWx6U7Q7b2FfaAz+G4e2hpHcrAa7V
	ydNIzydBzLJR3IZSdyCsgEfFh7h/jZCXsjLQCl58l2GNPwXjJTXwXEreTK3g1YEcW1KS76dV2c+
	S+cdZmf+JI9YP3zCq+WXfbUsU0adA1BPG+czTm80MAXaW1Ld5KXomCK5NkttIeAzRQr14rWzsl3
	NyOdmNk6fBdhZ1z67RSQetGrUP+0gBY1wUTOm7jlUowF8fwmI/ulQmXVHvzEf+1sUHtdZHq5BGo
	YdnZEzLMifLuf4r7b1fghNYWgdNI+JDYPjJwRH0nN031MakDxMkfKy4MTuKOIYYiPmLy1CNNW3V
	JD9K9XVvcntODNfdrGX/r45VYbCT20Ta4oLQPrApBqCEgJwJf0t1pzHPhmwpskQE+7O9N6qoble
	MPMc79OZF/p3ypO8r1UxnN/NG9YMZ6UZzNFcf0NvU3cICJWf3GKZUXGygDcrebZhxESbD/iu8Pv
	V8e
X-Google-Smtp-Source: AGHT+IEOkYNfBA6nW18LuERGZjn+mgFaar99xRQ79WwG1s/8eXZcDOADQRyZ2sqyMO+dTzWN0vfqlw==
X-Received: by 2002:a05:6a20:c526:b0:243:7379:53a8 with SMTP id adf61e73a8af0-243737987c8mr5257812637.18.1756167134028;
        Mon, 25 Aug 2025 17:12:14 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-771ecfd76f3sm2396987b3a.63.2025.08.25.17.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 17:12:13 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:12:13 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
Message-ID: <aKz73WdkzhOmLhjJ@mini-arch>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <20250825193918.3445531-4-ameryhung@gmail.com>
 <aKzVsZ0D53rhOhQe@mini-arch>
 <CAMB2axOkPx=5vseNXbwQtHQTFhdur6OSZ-HbNPUciwBmubQa1w@mail.gmail.com>
 <aKznqjd1aowjxJfK@mini-arch>
 <20250825155813.763d2a59@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825155813.763d2a59@kernel.org>

On 08/25, Jakub Kicinski wrote:
> On Mon, 25 Aug 2025 15:46:02 -0700 Stanislav Fomichev wrote:
> > > > skb_frag_address can return NULL for unreadable frags.  
> > > 
> > > Is it safe to assume that drivers will ensure frags to be readable? It
> > > seems at least mlx5 does.
> > > 
> > > I did a quick check and found other xdp kfuncs using
> > > skb_frag_address() without checking the return.  
> > 
> > The unreadable frags will always be unredabale to the host. This is TCP
> > device memory, the memory on the accelerators that is not mapped onto
> > the CPU. Any attempts to read that memory should gracefully error out.
> > 
> > Can you also pls fix that other one? (not as part of the series should
> > be ok)
> 
> But we don't support mixing XDP with unreadable mem today.
> Is the concern just for future proofing?

Good point. I though we did add that proofing during the initial rx
patch series, but I don't see any. Ignore me!

