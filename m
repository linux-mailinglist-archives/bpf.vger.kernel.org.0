Return-Path: <bpf+bounces-46064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2789E379D
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 11:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF425B2C7B1
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F431AE850;
	Wed,  4 Dec 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTu10DPk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116919E982
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308027; cv=none; b=Y0jafbI8H5ax+WjhjliAgMg1lU4T1YIeALBnqNfzENOxQEn10rsWX5AUGi2Gpe5nWIjSqSiyCMXVamgDay0hq7p50M2HKdyQET3EmDC9mDvHJJFYCnqHr3wM5J41Bb8Ptp8GkNsO/RO7+el5EW2jul4N5v8UplnFBHMJWNL5rWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308027; c=relaxed/simple;
	bh=TcvLj2S2OjDxK6FFIIsAz8V5/hiEAxoKPJXKYM4G2K4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G1bMp2w3kDqmHneZVRsFrlpt1ho8p6U+JSsD+Ll83OZzafMqd6064Dple0g+vRNBf3iIk/nzPWaO2X5mJjrzrOIAfptMzZVFHOs1CMvZ0amy8C9Zj2lzlh83FokyA5IMrE15aIm+x9Yx4sOjeoEbb3jGGySTLlh/PBGnDLCXllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTu10DPk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733308025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcvLj2S2OjDxK6FFIIsAz8V5/hiEAxoKPJXKYM4G2K4=;
	b=cTu10DPkaZMuj859idm4LCfo+z+ZGb+FgCEYwILtpsq69mnr5taWzgw5qMooCIF9Blt6Kh
	XgPgkIYF3sebDr11jSseDEvxxku2jydcEhVumlyjo46caDjLrG8eTLVwYFComa3NAl7V2H
	xL9SI3JIhAZoaywsAQUjgaq4wXrQ90E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-56wVhvvFNBauvI_7DsrufQ-1; Wed, 04 Dec 2024 05:27:04 -0500
X-MC-Unique: 56wVhvvFNBauvI_7DsrufQ-1
X-Mimecast-MFC-AGG-ID: 56wVhvvFNBauvI_7DsrufQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434941aa9c2so37575975e9.3
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 02:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308023; x=1733912823;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcvLj2S2OjDxK6FFIIsAz8V5/hiEAxoKPJXKYM4G2K4=;
        b=qHtU0jfMStoSotsaQGqlk5I8Q5lvRw7IlIb+MhGKjAY1pQa71taMgoryb5hfYWYMxv
         EvPdX1ev+6YhMLqCa8ugEYEh1EevD3xgPjyfiBEoDx3QLElMrf995IvMdrsEZXx6GYRq
         qWRXbrD0psrCFoyXtOhyzo1/Xbq9EXPA8v95XPBtQVDeuLFi1HJPGgD0NOg57UEStt+K
         3NtziVtD0Gz4qIQSOpJSAUhHJigzaQbs7Jy2tgFPZv+MGAhEZ1DrmcdjFIwIG3k0I81T
         W5DGN2gIWtgNhJmSv43XpAdeo29XPPJCXFPoy94NbT9i4/HQTjJCWShwaUGV0MdmTbHR
         1maw==
X-Forwarded-Encrypted: i=1; AJvYcCXpVKg2ChO2Xqt7yga57fLUxoEw3kc6DHo3ydLLo8PpHVjr3BsGCHlZ5ZuZxdthZI8oqHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWmU9ufOmoM6c713k7hVUyJRqQZ92KM/CFotSnfC2ZNyamSn+
	vOPuiAAdVHN7JCYIP6yG3jQsTCSatZYJGCZrHi+ZEQXm3XKK1bu3H36ov29OiELQ3jldmY6cWny
	OjsnfzPWmC2O+WheAgp0qcXScV0sv0yD6bWEi7G4IVnPXO2es6A==
X-Gm-Gg: ASbGncuOedFRNM5SjtbXZXFLPUmHenoflAC+iG9MvkvS3w7pS0XSobm/b8iveDzkmy/
	/ye6qpbeTWI47sUbrMFY0z5YeellOmEoKuufoCHFpqO80nv59N0jQ4NBtbY7f/DnjKl8jb8Fwhb
	Tlx8IUvyUQTXjNxyZiXznx3PcPjRi0TYNWTIMTwDIChrg9/2kaASKle+Ga6SttO469Tdo3U8qF8
	QUbjaP74uh+7s4rK+2u7ZQKlOe/UQ5ztf8+bhAppYbgMdw=
X-Received: by 2002:a7b:cb53:0:b0:434:a0fd:f9d1 with SMTP id 5b1f17b1804b1-434d3fcc5a1mr27614145e9.20.1733308022854;
        Wed, 04 Dec 2024 02:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrwtYSrQPLjelyylTwa5mbuvmc0j1pKxbIGN9w4X2omiDFt+X87GdnSjiNK+8A1PwN0nLaeg==
X-Received: by 2002:a7b:cb53:0:b0:434:a0fd:f9d1 with SMTP id 5b1f17b1804b1-434d3fcc5a1mr27613995e9.20.1733308022549;
        Wed, 04 Dec 2024 02:27:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm19322735e9.13.2024.12.04.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:27:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0AA1416BD104; Wed, 04 Dec 2024 11:27:01 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 01/10] xsk: align &xdp_buff_xsk harder
In-Reply-To: <20241203173733.3181246-2-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-2-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Dec 2024 11:27:01 +0100
Message-ID: <87wmgfaglm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> After the series "XSk buff on a diet" by Maciej, the greatest pow-2
> which &xdp_buff_xsk can be divided got reduced from 16 to 8 on x86_64.
> Also, sizeof(xdp_buff_xsk) now is 120 bytes, which, taking the previous
> sentence into account, leads to that it leaves 8 bytes at the end of
> cacheline, which means an array of buffs will have its elements
> messed between the cachelines chaotically.
> Use __aligned_largest for this struct. This alignment is usually 16
> bytes, which makes it fill two full cachelines and align an array
> nicely. ___cacheline_aligned may be excessive here, especially on
> arches with 128-256 byte CLs, as well as 32-bit arches (76 -> 96
> bytes on MIPS32R2), while not doing better than _largest.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Ohh, didn't know about that attribute - neat!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


