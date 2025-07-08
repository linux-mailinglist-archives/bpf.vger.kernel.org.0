Return-Path: <bpf+bounces-62711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF7AFD9EE
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 23:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5ADC7AC0F9
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A602459C6;
	Tue,  8 Jul 2025 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjHGMMzo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84365241CA2
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010196; cv=none; b=AnSjBI8/N+L7rz40bp5LN2y+XSoi2jZ2OzU0QNd6QUGLsAvx4H8Yw1vSzmdB+/GXMdp2FpaWRh/VXz4H6AwSMbjVISNnZASCYXmOH5Lzhytv7aQ1Sb6K/kOZxWFpoQTjp982wHfeMFA233j6VlQyR1I0K7wGynbLzYpfPsy1SC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010196; c=relaxed/simple;
	bh=yIgrHSf27LpY0yLHp/YljODErjEHUC8udxJ6tqfd5NE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZr636EgodFu4R/K+juP9Tk/05f/h7Ck6gjtzJ6orwVtDgFwLL24ewwOZ7bblBHDyMkPyatQ2NJVYgF4Fq6fdPYZ1Ezk3PGxaMHhvfSbWotANaM+TjcgQfdB5P0CFWuRzfclLGxfaMJFUk6eUiaHX08UkJqqNrlh8G2/gs4mXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjHGMMzo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73972a54919so4388378b3a.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752010194; x=1752614994; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UwtKlAgZWvZ5poLr+OZJyllrvYmt6cYdJMUfxPvhMNM=;
        b=fjHGMMzo1550AERTGkSD3cix3ao0eOQnVSLK0iAYd1S2fw4bVuviqODwd2j/bds06B
         FAdG0VKqrR6X0Ym4+uwCsa10YsvQzb2Jw3HpkIIQn2uU1eMONqm2F/txJTa1Wi8EvLb7
         rEhz7WhNv3zxZY4LNu2I05JVU41lGAuD5VRM5FXweCLJxlp3OPkuN73nMPnjJEsFnIf7
         yzDzMukMwXSwVWSHMTG9VJzN+e9P8aM47zeqrd/WTDalEbxL7VO4W2lqUnR4g8RrQdu0
         hBdnvIlK93NqKbr8Vv0B7Iw4lwa8k9zXBXSu9WuUwUthsVBSl3oUF/q3zojaJDIdSeMr
         X1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010194; x=1752614994;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwtKlAgZWvZ5poLr+OZJyllrvYmt6cYdJMUfxPvhMNM=;
        b=JwxzOYoJPeapMnhIrWOK9lAnv3X20BUYKuTnSRUkHGPFI/42AZx9LJLoURNJ8tHvWf
         Or0ekyPAwl4OI/kzP4sWbAgzPGJqg0xXyU2j3avQSSQwuCgb9t2UOLETkXS+yENyjBYW
         gCZOLFByNaqypd+r9ff7gYQJoX7fHolxPDBmiPvoax2ZK8c30zidr3vbKoDo+eHIETyE
         Qr7dNownZNacWamcam2/T6wWykaVYBC491ICHnetVKQw2UETspfpZKArvvoymQZBFJga
         c8fcBmP74Iy3N7xHApRNmbq+BL+5xjPQYonw80zqf+eAi6m85Obus6YV11nMfdOXKYs2
         ZJbA==
X-Forwarded-Encrypted: i=1; AJvYcCWdKndeHcKce4LKIqvYdzGcFQNuYHL+fb7vF2fcHKQSfFgeIhGebJGJqmWzTnxBSyDRmb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWuphGHxhN4cmjUm3WGgmY/5jkFs8sDBnwzUpsMFajdLpfKAby
	Hv4bR6ZsuPevZcS2RIMUe6n2ywmKnm7/ao2RW6CKT5fiTI876GUHnUhT
X-Gm-Gg: ASbGnctFSb30CRfNnFTW9eG1oSyuslZqzPdal8kE2QBMOiGWGsrQmttkZmzF11g4HLf
	VrNMvFytPF+uxvVp4ObqIWKZzFMx2ze9mjMGWEwWCr04erqH5Q/hkuoZr5I8FX7A4g+X3Z5JXjE
	eqPtUCOLpPG+oww9NEPikU/Sq7fBjlj6PH867K7fcJjEklqlGde9tbCxO+EmZuGugzakExE8j/q
	I06FkQx8JADZzwEMVx4Aj3j22nassmvfXnlpg6bQjwMGhjcir2uIA6DCow3u/k0BcfjG9q/Vpg9
	k6sgAlLEqsCGplzWo53eB9B6U0tf7nMV+xgFjoukJE415RZTD0vg4vuQbw4bkpCTVDmw
X-Google-Smtp-Source: AGHT+IGKmGpo5o5NPOtewaQkCocEFZHAoQKduz6TAYNI+wPd3cN2LvkEIu/VvH9Ks1kBY0MbKOP6tg==
X-Received: by 2002:a05:6a00:240c:b0:736:3979:369e with SMTP id d2e1a72fcca58-74ea658c76emr201596b3a.9.1752010194234;
        Tue, 08 Jul 2025 14:29:54 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:2404])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d69f8sm13128083b3a.179.2025.07.08.14.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:29:53 -0700 (PDT)
Message-ID: <73eb0615eba70efd79407eda4c2025634edcb75b.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov	 <aspsk@isovalent.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Quentin Monnet	 <qmo@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Tue, 08 Jul 2025 14:29:52 -0700
In-Reply-To: <CAADnVQ+b=k08pj6MkfowN64TPnJ0t585egzSDyDgvd4yBdqVOw@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
	 <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
	 <CAADnVQ+b=k08pj6MkfowN64TPnJ0t585egzSDyDgvd4yBdqVOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-08 at 14:25 -0700, Alexei Starovoitov wrote:

[...]

> > LLVM would produce:
> >=20
> >   0000000000000000 <foo>:
> >        ...
> >        1:       w1 =3D w1
> >        2:       r1 <<=3D 0x3
>=20
> If we go this route, let's drop this *8 and make it an index ?
> Less checks in the verifier...
>=20
> >        3:       gotox r1
> >                 0000000000000038:  R_BPF_64_64  .BPF.JT.0.0

Makes sense to me.

[...]

