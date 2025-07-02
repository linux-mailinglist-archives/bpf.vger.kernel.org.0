Return-Path: <bpf+bounces-62175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302BAF6080
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5A6482DBD
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9246A309A76;
	Wed,  2 Jul 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqzF3pw1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282523184F
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478944; cv=none; b=BaFq4/mTkXetCqjIPvY16O7PwdP5YqcXYeJM32/aTZHx7UY5HdTjH8yYaj2bWGTo3tcyhQI9wkcxz/y8j5oAxJldu7OfhyPD8NOJpiafECpv6b4/SJd9LXSGhNIVjBiQeaEEHAWohUfGE6XYzIVz9/d6st/GQEOp8oUg0lJXaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478944; c=relaxed/simple;
	bh=63qvSBo3u0PS2KXtHrz2MMj4YjaK9zPc5kXN32umckg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nC7bmFYDk8b/erJ0kEqKRcG0PzCxN3JMwmnPUxP7kL4px1jiE2KarjetlH7iIbeWZY80cBd75Mu1N9G3MEj4H9tQYWQAevpZwf2e5P1i5E2NVzkUhH5XUBqszZqZkfBUErcF4WHlOXmG0VmnfBrh+i6Ig2qjG7hPPkabtQV1scs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqzF3pw1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234c5b57557so47842325ad.3
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751478942; x=1752083742; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=63qvSBo3u0PS2KXtHrz2MMj4YjaK9zPc5kXN32umckg=;
        b=DqzF3pw15u+G1dOsdXnl0vvcpZHQPpfDW10+iQj4RF0l3ahDVfxhDsBFYR/RlYgpqr
         WHdnskLyUmiIobKJ7UO0ZQW4Cxzn5iO4k6uVPoI7PRIGNa2v+TbjK5O3DIam3ClvDNh2
         uLbxYLAa7dRG2xIS/N2Lh88AGOx9Y6Q7M0ONlYEtGFq8NEVNBQQd8s1RnMDFHkOmIqAD
         W+979VQ+rE8Cb1v3hEOXuJQfkDZ+To/ebytkwaeFeUfBPgn/qIHKMsgj4o2ah2ZnkndW
         7YbNcWR+2bydY1jOSoUmd7Q//m1c678qw5fgA56dSBfOrdv5m3dscFFPDEU7Bhkm5RYF
         NqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751478942; x=1752083742;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63qvSBo3u0PS2KXtHrz2MMj4YjaK9zPc5kXN32umckg=;
        b=v3ga40fLA39kWBkmE/YUl1tSl7MUyCZR7/VMw3YV2Nm0N3en5eeQvykGS4EmxAzgqo
         beLZeakGrix5Z/Yi6L+4guvseoHHVmCjMs/BrxFCKlKj/uSvvs6D2Kpo7GJNgOHQMV5m
         wyYP/L7bo34sm+jrKx32EUpHiM+FVAR26UojkIId/GC401z1rJjyoSxexwzj7JeRBaKy
         GK3fctLp7i2iuvInNomB/kQJcc6qMv0AEjNtfdE7MYTWv//FQt2L88d4krU5Q9xBsKY/
         0crQc8fE9J5js4h7oFJGA4n/Cao1gS9VfjS10Mbcdz1B0Oq6wd6F7hRJkzhcyRRg99JI
         DpkA==
X-Forwarded-Encrypted: i=1; AJvYcCU05e/bbZPgnl9VEdWpCB+ru4WMJ5qPZJdWcXXucqvRmPQCY1eigIALRmGaKpSEhijCKws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJP4nx43VC9daO+jhAXwZXU6/WJJ258kgZAO2/6y2DlMBNSXr
	sMegJd6sJxUHQka6xtwdB1SXmWSgAcjHLAAZmxpcMBhYdb8WhsP4ZICxZYZ7elG3
X-Gm-Gg: ASbGncvV0uUjof5mOVX2xSG3fovaXV1/rpoR3RS5L7ZqHN2DrSJ3qHPfREfBSkypXfv
	F7okIdbwYLyGpxEtl/E3HnOMeWaXSgHeLIVyEih9sU1Vf23fjXG5XsBPn/7iw0Od0AAvDdDzDOH
	ypagoqtI4YMOOMyd2jR0VqIfFR2gvswdhaNTyweyAzOwAohS3zE2nG94xMiMB8r00BFbIk8FbOR
	zEh3TZzU76A2wDwG8glgkRHK899Il6UhkPZA9eKTbmOtg/68+VM7ZcfXn+WuHB/hViAtpyckZg0
	4HcX5FPqE9E5Ikyk/YzCBOGfriok18DtVeVpwhfrlDXDBCOrHWHIqghGUxsrwrKA7fOAgSb3867
	4B/+102H0oQE=
X-Google-Smtp-Source: AGHT+IFgx+Unjim54dpVYM0cGoPM2/d+/SMqREFqVRHFbcKUGCY/5SAoNTixtSyzwyp6ftIOf6g7ng==
X-Received: by 2002:a17:903:3c48:b0:234:ef42:5d48 with SMTP id d9443c01a7336-23c797b9417mr4889135ad.38.1751478941952;
        Wed, 02 Jul 2025 10:55:41 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:ce31:8a4b:8b7d:e055? ([2620:10d:c090:500::5:5e14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7ab2sm132774685ad.177.2025.07.02.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:55:41 -0700 (PDT)
Message-ID: <51d63af0fcc63a2b6c8792d8027cc6b906844cd8.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov	
 <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov	
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>,  Amery Hung <ameryhung@gmail.com>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,  Feng Yang
 <yangfeng@kylinos.cn>
Date: Wed, 02 Jul 2025 10:55:38 -0700
In-Reply-To: <CAEf4Bzah-MAPsk7RgSNXH01Tw4QrO6E1A2Rz7VhZf2A7PS5SNg@mail.gmail.com>
References: <20250630133524.364236-1-vmalik@redhat.com>
	 <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
	 <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com>
	 <CAADnVQKQTLDP1W1ao-mCPfLDbZWykW1TdcouJPSVapNWu=bCBw@mail.gmail.com>
	 <CAEf4BzaM9_RbUfi2Gk-=_2D3OC8GiDS-vT5-9CHOd07r=+wyeg@mail.gmail.com>
	 <36400b83-1a6f-4da0-9561-073bd268c58e@redhat.com>
	 <CAEf4BzZZ2f1cP8zDDsqME5wcOYUECh6UKwxtTWbDfSjmdJD60Q@mail.gmail.com>
	 <45fa8528ac315388469aa448d9c5081783924b18.camel@gmail.com>
	 <CAEf4Bzah-MAPsk7RgSNXH01Tw4QrO6E1A2Rz7VhZf2A7PS5SNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 10:28 -0700, Andrii Nakryiko wrote:

[...]

> Ok, if I'm the only one who thinks we shouldn't duplicate kfunc
> definitions because we have an established approach that works, so be
> it, not such a big deal.
>=20
> I'm curious to see if the next step would be someone asking to do
> something about enum or struct that is defined only with some kernel
> configuration that selftest relies on. Are we going to add extra
> #defines just to be able to do #ifndef-#define-#endif guarding in
> selftest source code just to accommodate someone wanting to build BPF
> selftests, but not wanting to follow prescribed build setup? Or start
> adding feature detection in Makefile and exclude some tests from being
> built? Will that start to be a maintenance burden?

In my personal opinion adding #ifndef-#define-#endif and feature
detection in the makefile would constitute maintenance burden, yes.

> I guess I just don't understand the direction here.

