Return-Path: <bpf+bounces-70129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5ABB183F
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 20:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4332A1ED5
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0DF2D5C7A;
	Wed,  1 Oct 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReP/Bp1P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107202D5939
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343849; cv=none; b=bmF4U5LwkhPAGZLq0Iau3WlNslRoidqgCDxtmvp+pXsljaffwpHN+PrxW68DasgmB8WnN0XbmylWvt6oFHGmfZrqUTDwOs9JbhkYCd/BWunXLF+DseYeRsq8HuA1a0YgafMK1/wU+E4Mr3WsqB5yubKY1rBAZS2pG/YZDnf0AUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343849; c=relaxed/simple;
	bh=+5IkJFQ7HOAN9t0e0c8Z504rwCoejlXiTWiCk6Ioxww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDrnvMsXykx5hMhLv5+mw7RxLuNHC4R54it2q4NR+frbd52GoRPBczzvIguJOxyhRGeBWEh32hKXHr+xan1nhpJhMcmGCcM3A2CtYc/HTZMJxl+pbiq39VF3otUljE5TwEeP1o/TxRHfTxI0UKCveadLPOWbWDSy9xIqooLFvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReP/Bp1P; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781206cce18so137193b3a.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759343847; x=1759948647; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+5IkJFQ7HOAN9t0e0c8Z504rwCoejlXiTWiCk6Ioxww=;
        b=ReP/Bp1PeQYK1sLr8cNLWwHj1m8fKLNNR1EMEYnC4lRnozdFkyyZo+xC39CMv6bqDU
         wsdK6ZqBaBYWT7ajwduGlxoV1zCIcUUU2JtVhTLmdVFmPbt3LEGEd4KMV0j1k5pBGRM6
         CcAmrSGlWUwMBjjPhLKMcNmFFHr2oq9WEcV9gDRe0G7o+5BsBPrUNJfzygidPlBa+qZc
         x+2fgCwLCJ2D8xfUjv8m3bizOCPEitRPXQcOV3uKT9Ds28Iyq4ovKick5zDyXvOcfvw8
         QXrKTXuSXLh0+0L3CCmWKVvL69vQ8Y1OLi+9JIMmP9bFHMDCk3Oq1bm9Dy5/X+FJrNsO
         KBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343847; x=1759948647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5IkJFQ7HOAN9t0e0c8Z504rwCoejlXiTWiCk6Ioxww=;
        b=ase8PzSRXn2tm9ROPpUl2YbrP5UFc2WRtbTNlgn7iXxQowSmqfF6PrBu9bvvreAbJR
         bJgSuTa7KzgbH5wXaxi+q8Ltsylm0L4LQ6zFgYG+iL9Kd5UAa7+ZBZGwZzgcdl0IKFR4
         hU4FUwDs6HhI8SJjapCi57jSIW1c4e9oOdxG5w6wW/gVBrxPMn9X3Y8G8qwa5wZvJhFT
         xl93Ts60BEoG5rqeOwuvn054XrnRFhT6KJ/caTnB7dvQSH4ETNh8NoZ8EA84mO3WuTa9
         e00s6dM1oGvlqk4cXbDnicM2hFTrRiGKaKCgcR7/vMGPsKfW0JtK/GnFOiAMYmKbDH9l
         QrVg==
X-Forwarded-Encrypted: i=1; AJvYcCW9gI63NqgWiWzYb+2pb2oxbhGjdsnXoGo/adfp0RtzK0LPQPdina3NIblZM1ycFw0+zGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+e8DgOy1UApi1aY7kLpZgUkVRwTbCuEAatzD/i1u/7zOnRBe2
	GPDAXNygokgZ2E+jCHJh1N0pn1XqOB6KEVqVoqW00HmIsR6xM66DoFMW
X-Gm-Gg: ASbGncsP9s/cSlRb8aGObI1md51zB9z6jkuonzDeqTEPNY7Nq0a/Zmz2Z5EgIXYtAC1
	IPzThPTRje6uqtRhAXeaydxEJwSMZhWaEWSSpa8I3ZEiP9vZYVAsZi8Di8S/Hl7pOPJvHH5zlAg
	TjaYD0g3gYBhSoZKXuMAcmdlrJFy3XFjGptfV4v0lcfRrQTtmWp5d55bs+eDtXGO3nnSR4z6X/A
	rqLA1RmIRq/9ZzuBLEY4pznxVY/d8CA3vssPOb5CvCOMyJfdRTof+erg/NjsA203+DxAxxOSknI
	SA6ciUC6u/7P8BedVeLHt8xscGXE9Rg/e39Sdb7qx9FpUqziDHZMBHJ5FZ5DZ5iN04VNW/IyWPt
	1u0/BKHIerNwgDZU+tvjPE8NzJDoblpKjhlYxU1aWbOkBuPOX1AEUDhnQKI/787LRNOyWbEfw0q
	TCYDP/ow==
X-Google-Smtp-Source: AGHT+IHwGIweaktnau5NNmxNvpzDHY9rRZNzCTIssDNODC6+bmeuAJHCv3egmKb0AfhtHgEMmo2j6A==
X-Received: by 2002:a05:6a21:4e8a:b0:2b9:5bdc:8e28 with SMTP id adf61e73a8af0-32a24dc771bmr847091637.15.1759343847383;
        Wed, 01 Oct 2025 11:37:27 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f3b041sm177268a12.24.2025.10.01.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:37:27 -0700 (PDT)
Message-ID: <5ddd7fb4f2282fe697f1e7617206424b828d269c.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: Add test for BPF_NEG alu on
 CONST_PTR_TO_MAP
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>, 
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	kafai.wan@linux.dev
Date: Wed, 01 Oct 2025 11:37:25 -0700
In-Reply-To: <20251001095613.267475-3-listout@listout.xyz>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20251001095613.267475-1-listout@listout.xyz>
	 <20251001095613.267475-3-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 15:26 +0530, Brahmajit Das wrote:
> From: KaFai Wan <kafai.wan@linux.dev>
>=20
> Add a test case for BPF_NEG operation on CONST_PTR_TO_MAP. Tests if
> BPF_NEG operation on map_ptr is rejected in unprivileged mode and is a
> scalar value and do not trigger Oops in privileged mode.
>=20
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---

Can confirm, the test reproduces original issue,
patch #1 fixes it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

