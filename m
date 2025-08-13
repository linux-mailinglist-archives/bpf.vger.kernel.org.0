Return-Path: <bpf+bounces-65567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35046B2562E
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E421C24D8C
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36C22F39BE;
	Wed, 13 Aug 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3ThmVCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2511E89C;
	Wed, 13 Aug 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122401; cv=none; b=dbGa26mltOzZ3StUncLddW6JCtc8bzYi4Tsf3Qg43KvI/v7NsL2QFbirSodrP534WMVzlh87MOw0xaLNAY1Xf/2/rWHxczOKUniKbBac9wkL2qkYKJODqpAI1ue4gnKEV1168qgEDITWUpcRoLND2Sv6wZ8rHE2UDPtsYaTYZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122401; c=relaxed/simple;
	bh=R/Rw808h1qAm78woktb5gvthcGJ5p+5F6fUolNrqU18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aszWc7RCbMDX2917TDqC1YqcogylNQk0qf0DMyQ9ujXDkX2m1FaXIOp+a2AsggI4YMSqQPl1lLsCfYCLeIs0sTbkCFVR2HBCuXz8r8gWk1QXNEnF7/l+T7orEN/zDcj7PigJQ4Mbl27jnNSqLe1IRPDl657l2qNoIJBTR1qQ2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3ThmVCJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24458317464so2354055ad.3;
        Wed, 13 Aug 2025 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755122399; x=1755727199; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R/Rw808h1qAm78woktb5gvthcGJ5p+5F6fUolNrqU18=;
        b=R3ThmVCJExFOqLneRmf/7rwK03ElxdPVI2CWrSe/qRXHwdCUZhwi+RIfuKnKm/Oa3H
         08i/hDX9M82xVZ1SRbtOUem+A7XwUK67RHKVCh0fmj0fRZradn1KJc3/qLgGvbKi/qzd
         PTBY5AjBynNPNyQhmzmGKeftuIsfZa7YNmOWjPHBe2zC5RnUbJpy3ha3vi+ZvwyBBUzZ
         0LTnDoL3B41obmzRcyapxEpfpsdnxZGXJO9P/790b5epAEAjorARvFwpABrYv87xnHEH
         xllUr+RoXcEewe9T592CXQEg8aq61JGrEDgcy8SC4hVN7Su+sJY24GHKdkooVoHmF9XY
         I9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122399; x=1755727199;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/Rw808h1qAm78woktb5gvthcGJ5p+5F6fUolNrqU18=;
        b=iiNWUKf7Lobil80nKlNoC5W6718BfF4Huo+N1PRL/enj+bXG7QeHL3gTm3nJL8yCIe
         jP9IA2ctRyAVfAegY+L/ZtwCCzU+TgWZ9gqcZbT4XKxIgNb63I7g1o8aarDhi9sf2Rs3
         OhA2aOr1h6dAHkwfPJ5R5eeiz4e19Cmu0wjDLgU/QJVwtjyNZ6qv8rQPgSpWKBg6liQb
         ASNDg1rsq74eeLONo7tPyn03H8Z4e3UleFzya7K4TcJPKxF2qhbGSkifSvT2OpySy6ud
         nsWdeqHe6UEc98cMo+Ad5HtMYOMXcznlbOXSLLw2xWWSKZEEANBptbX+2nfgR7kn7aGI
         MQYg==
X-Forwarded-Encrypted: i=1; AJvYcCWbvCjZSylP2xg6kHWcxL6szel0ZTYf3xN1RDgtesbB1zzWuYdc19p9I2Ol8vBrovjltvICmHuGko//lxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkpkw/CLQ3NntVHF7IBgkqH+FK9ICa8z5v1/qvmlazY/r5rdD
	vT+bu74VLqPdXzynq4tkf6N8cE0MNQwQvIZMQ+urkR7L5zia7kMwOmAw
X-Gm-Gg: ASbGncsZpWedADlbWOE+7E95FVI8cZt1alK5jXHbJPGymPwf6Qdp0jbXgk2I1rgK1W8
	Z2myZRyFgGU4wA+85DDO2+hWhLO8A/MiEGkyF3lZprfXct0SCpKXM2YP+zrSUheyeMlFreN9akH
	eJ7Rlr9qgqW9EvQGl9Nmf5QppnmIA97lwyZpzzFpyyO8pTXihpv3Y54y4HwiSFU2gWAWHu6HNz6
	qPoEtIDScdzDnXKQEmnAbePYZXjQXmIt0slq5Vx3lZcSMoxf65eDu2I0WjNgQJhyS+8IWVbKcFh
	RY2TlUz9O5wlKtLi2pAcjyUmF87hWJb62Tne2CuqkqwTeTemYR3jXoh4dyavUP3Zc7GYKuQZffD
	zz5qYxn53mA+i9GliX38WJmLbP4p8
X-Google-Smtp-Source: AGHT+IFI/z46Nf6mVA3959PxesE4S+c1ixZBf0E9Hlb98ifZzxIw3nbXZP+Xc7HRcnkH6uG4gZrnGQ==
X-Received: by 2002:a17:902:cf10:b0:240:c678:c1ee with SMTP id d9443c01a7336-244584a204fmr9552165ad.11.1755122399209;
        Wed, 13 Aug 2025 14:59:59 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::e47? ([2620:10d:c090:600::1:f146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafb34sm333191955ad.173.2025.08.13.14.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:59:58 -0700 (PDT)
Message-ID: <77510736c4220e4f745fd152721e86689d8636d8.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: fix reuse of DEVMAP
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yureka Lilian <yuka@yuka.dev>, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 Aug 2025 14:59:50 -0700
In-Reply-To: <20250813200912.3523279-2-yuka@yuka.dev>
References: <20250813200912.3523279-1-yuka@yuka.dev>
	 <20250813200912.3523279-2-yuka@yuka.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 22:09 +0200, Yureka Lilian wrote:
> Previously, re-using pinned DEVMAP maps would always fail, because
> get_map_info on a DEVMAP always returns flags with BPF_F_RDONLY_PROG set,
> but BPF_F_RDONLY_PROG being set on a map during creation is invalid.
>=20
> Thus, ignore the BPF_F_RDONLY_PROG flag on both sides when checking for
> compatibility with an existing DEVMAP.
>=20
> Ignoring it on both sides ensures that it continues to work on older
> kernels which don't set BPF_F_RDONLY_PROG on get_map_info.
>=20
> The same problem is handled in a third-party ebpf library:
> - https://github.com/cilium/ebpf/issues/925
> - https://github.com/cilium/ebpf/pull/930
>=20
> Fixes: 0cdbb4b09a06 ("devmap: Allow map lookups from eBPF")
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

