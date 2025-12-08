Return-Path: <bpf+bounces-76286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D87CAD6BC
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 15:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27EA5303FE4B
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1415C329C4B;
	Mon,  8 Dec 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUhmOcJe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBF0zTRd"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141CE329C40
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203650; cv=none; b=q7yBd3Yf5v+UzpDitPN401jzhl8xzmX0qxCWh/RbrdTrY42IWm4qZIhmh+fCh2x0CRBGOw7a4OG9NOjx9eCHZ2DgtNMJUnEi4QXmeFP6KGdJc/z5ZU9+NsGa/3zVHvKfVC89IW9jO4vg7zun2V0z71kJsFyo4U0uUWg0E2ZovK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203650; c=relaxed/simple;
	bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nL5wfVfd4ok/TiCt3GkYfJA8Qbfw1nwZdevQuIKAIqVXZWpCO5l4AW8Md/acgX6rsuXvAxEBxT1qxcZpIkUN8ad5mQf9voNvlyyXMF8EyWJQv80td1k6tUETHHkLbpNBwTa4CJfx9MHJl7lVRHeFDHRDvkLpOkriS5Z9gJJnvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUhmOcJe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBF0zTRd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765203648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
	b=bUhmOcJebvjjFwHTXlojCQEzzSykZucJxsNCAl/rk0l6WTzPlUSmHB+BGNs5apGdoWUK7m
	Ir812Gr1rRV/Jq+InPnw+d+oyGiPptwUwqaLnZTTP9hflHSa8R+FmhmOvur1ADo8Cm4Uui
	GrudpC0QCE0ZTXRrGCpOv/YPHdDgsyg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-yySPyWYaPIudalkGTyw41g-1; Mon, 08 Dec 2025 09:20:47 -0500
X-MC-Unique: yySPyWYaPIudalkGTyw41g-1
X-Mimecast-MFC-AGG-ID: yySPyWYaPIudalkGTyw41g_1765203646
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b79f78b1dc7so94959766b.1
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765203646; x=1765808446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
        b=cBF0zTRd892NkDsjeVWIrrUVFn4iDvAPTOO6YKNRxcX6C8UgBzbbM2pW8V6fi5Uilx
         IJH9H1TqGdMMSrkfr4hIqfNKEhsYtHxSSMQqTN5nBLsISDnZ02r/2tBX+j3qZpfntbky
         OyL9JJxDXwjYkpdMQ/9VHWGebMPaHdwweebf3gGUBvWba4yMD2rjnYa720cRzpd4THHQ
         xCeq6UaHJgepVvVqojiuceWH1y6kEd7eGtdQ6aR/v8H+1/fKrmg2NU0kZ3Nzf8yE0hnB
         gi0NlBRbEfNW0nRfgNnftiDUOcCoHPOlq91mFgiyw7fmv2u1g2f3cstqcHGEXboKFd3z
         AfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203646; x=1765808446;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i10k1/SiZqD0E8g4mpTmNwORyJAGM+3hkDTkKL/pmi8=;
        b=NKBWqliaHriSkdDEQ1uOPcfbj6Q3juoRaHJHv+cfpvWZqcFxNoG2NeKLY2telU/Szc
         X8k2V2aHpaYhu2eUgUKn5QaxjDyMOxpGJ5NR6fTdoudCsO2LZhrSHfdQ4LUysgI8ST7g
         Q7axRyh8us5JxPtXA+HVg0GdBEjG1IUr+2VWho5yO9AcasKB26FROagy958KpdhD6j8T
         QyOvN3kOFli7xPvuLyMsVpO9m8dMuaZXAz7p+8WOsgnc3IJYMiR5bwMDJJrdbGd/Nq4H
         GO/phaiz56PBb6QubQzcMTAS6E82F13ox9RCxU6kZRGcgBFpAIpZjLKTsloBGTS0UXZc
         Ja4w==
X-Forwarded-Encrypted: i=1; AJvYcCVMrTAQXSQ/cWB//7q+mf31ZdUq3zK8TcMakLdeBAzT2M+kmHFOj8nEm1497PEQSkgKhWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzawyGan9cD8m48nsu+DDb3Qj/IQxuo4vdwEguIQW+7qG8dIKF8
	YPN3zvJpM80z7KiW0fX6vcVcPnSSiDyuX/hFSvjoqedsNLoVedas7xCEgl4/gbMQuVypCKjoTgH
	kf8ABSXfoKiUW6+CIu9fwxQhCRl2rRJj5sAj+lvnrlj5Slq8qQSqtKQ==
X-Gm-Gg: ASbGncv9ckZGPKg4ThLH8POxwsncpcZdpYy5C3OvSXvtfKlRz95+DI9gb2ssUPeqKT1
	tRkXK2dfYlGP6pZZWv6rBorNtAu6KVuRDl9wRRXUpxVU1k2Z61wjo7vWif5EBd2/afh12Y848Iz
	5Z5eQelmsF8Z0ob0gHxUbwpqv5Tif9n32wE8QQkyfTOsxBlnk0H56EliFFWiMA5Oxbh2GRZpkzc
	0wCgde7fM4vlxiGyX16BFZzBJmuoTd0m6HmOo5ixhCahJjtO3sOjCrNpXu1JgvIaErg2yED6p2d
	UmPpz4AJyhmypYKqkLIKapoS/bQSore91j9oTzNHhHS9l0s41Nw2X2JhQHUl9hr4s4dYaXxTqrF
	21fOxBYn6e0Um9iyckEqQqjWkogfm9ykntg==
X-Received: by 2002:a17:907:7ea9:b0:b76:4a7c:27a5 with SMTP id a640c23a62f3a-b7a23b38b5dmr792477066b.23.1765203645789;
        Mon, 08 Dec 2025 06:20:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeICR9a9Zyl705kBwz+fQ+K9zHYu4wc7uwPWOV2osX2dj4Awtr08onWyj57fv57pFb+ioxow==
X-Received: by 2002:a17:907:7ea9:b0:b76:4a7c:27a5 with SMTP id a640c23a62f3a-b7a23b38b5dmr792473166b.23.1765203645298;
        Mon, 08 Dec 2025 06:20:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f426413esm1142503666b.0.2025.12.08.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:20:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0BE593B25D9; Mon, 08 Dec 2025 15:20:44 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kohei.enju@gmail.com,
 Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add tests for attaching
 invalid fd
In-Reply-To: <20251208131449.73036-3-enjuk@amazon.com>
References: <20251208131449.73036-1-enjuk@amazon.com>
 <20251208131449.73036-3-enjuk@amazon.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 08 Dec 2025 15:20:44 +0100
Message-ID: <87ldjd6on7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kohei Enju <enjuk@amazon.com> writes:

> Add test cases for situations where adding the following types of file
> descriptors to a cpumap entry should fail:
> - Non-BPF file descriptor (expect -EINVAL)
> - Nonexistent file descriptor (expect -EBADF)
>
> Also tighten the assertion for the expected error when adding a
> non-BPF_XDP_CPUMAP program to a cpumap entry.
>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


