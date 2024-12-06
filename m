Return-Path: <bpf+bounces-46292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5869E7751
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5131016B369
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9166E220687;
	Fri,  6 Dec 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3YwfMMW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435B2206AB
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506151; cv=none; b=ARmNrYt1YkGEYj/61fta18QAycjUyXwTkWSR5JB8kMWvef/DiKoB+8HyYQ28TocKNMlxdkr6VpfDP0vgsbgIUMmU8MxrkKoLS+I8rezpdeHImu+IrJrB1ukSuOPO0qs99rSyNcSu4RDdc92HYH9ZwKmElIe4ha6IiehnsHkMhro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506151; c=relaxed/simple;
	bh=MMIxiRedv4yz+wy++oKBaD1Cs3rZ0rd+8Zj3/N6Dlcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M20eScBRKVVlnpWL38ZlLMvu6mOLc677zEFZ/XZE28Swz8f2W42EIohRUhd56vEqqpKj/zK6xzyqxP2RYdKjRX0j3FcPEj1IQCiqlk/n9TuGTdwuaZCruns/IBzYY7PnydLognlSd0T9kS5cmFK8VUPZPUAPiZdE/zaEuEsG5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3YwfMMW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215b45a40d8so20390075ad.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733506149; x=1734110949; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MMIxiRedv4yz+wy++oKBaD1Cs3rZ0rd+8Zj3/N6Dlcw=;
        b=V3YwfMMWS27u+6UoWHeGDeSvu2dTUs3+xZKrYwlEZZnnyzzJ/8A5t7P4Y8I0gHsd4t
         kEvQSonx4fDPZ0orXti/IwzRaDbbMPl1/2vJ6koOiNoLuefYNYf2CXVvAt1gNN0vWXbz
         EcOECv797QYmg0FhN8bZ7o2ST9l+Q3EEow+AE38vjrRoTlikIwW4bjeJmobZ45FxxO1c
         KmunV7vmHtUic3haRXf05/Np9lWYOYG3wIOSNnZW7qK3HrBh1AFG8MRZF7datUE67Soo
         s01p9XaI6hDEOSMPmtR4W8ePxWOmlmRgsqtR12GwIyY8kMZcE+ceoZRIPOJxhIKMHToA
         b3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506149; x=1734110949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMIxiRedv4yz+wy++oKBaD1Cs3rZ0rd+8Zj3/N6Dlcw=;
        b=QkdImL9wkYusAwIDJNPbejTecw2964fiqNQvVkDnsOETgeBNIWe/eaJswp5BVQq+Qs
         zKJM35stYH4xGjR2EZtUVpIZZNdJUSMAB08zpJ/1Mj9x49VsoXqi3LzNsea5w4Csua1G
         nGeJ51LeLZV9NRrR87RqhXQZWSeoB0gQnc3R1iQZkrltAA3hw8IHeVbl8if8vHDssxmc
         nENhAqXEoySVn9uBpFt4K8vJwYE2/Z5E7jTdYmtg2ctiDKtj6q5p3skNoYBr8Ddd9kFU
         5pubQvPt09Sqd8l99uKwBhuSVx0DGQq2axdD+GU4tDi8Jx+8UHyVZS78s5OS+RpuG5ku
         m4DA==
X-Forwarded-Encrypted: i=1; AJvYcCWnuuJGhCqntIpNEbA61nCSB+0rtrrt4iS0nMGVYOiIFjJ0pA3gLMTFKfjtYvUE0k373xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGIT2JpT1v9RRChk08U7jVjXgVecZKCUcRM3duY794Fy5kiLJ
	X2seDXUkMHxHH3WqX/2/TFig6kbsFyis3ctX19idoXVGYFMIwRQFQxTXGg==
X-Gm-Gg: ASbGncvficEKKj2WwnwNWJtxcWPy9hmnITAW/5LtYmL+Pj+/t9/qsdmuVpXPTrbOZJM
	3p11KoMXt3f1ayTa/jxNcxHrKW4wJtwNRi2ddVD4ziSNTDX5kroi8IpC65gc7x10RPT99XzcgDz
	EEOXyJO3Qic04yyBvdDW6GGv81REfxtdB/6ecYo9aFYnfV2ZPeERT82YKw2gHkPjWZwlFQYOdut
	G7F/uD62GeQzJzZE8KrpuDbd1TsElpzD8crjil4R6zDkuc=
X-Google-Smtp-Source: AGHT+IFqQjObwZsYKlsypRLaEmRyOT/o0B0UuxCYEI4+2ovWc7LSAWM8XoHo2MfF6f/En+lXAzI5Pg==
X-Received: by 2002:a17:902:f542:b0:215:e76d:debe with SMTP id d9443c01a7336-21614d1f258mr53055595ad.10.1733506148882;
        Fri, 06 Dec 2024 09:29:08 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216268c36c8sm2963605ad.253.2024.12.06.09.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:08 -0800 (PST)
Message-ID: <17abfd2c6dfc74fa4c1c2a45bf0c7b793963d5a1.camel@gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov	
 <ast@kernel.org>, andrii <andrii@kernel.org>, Nick Zavaritsky
 <mejedi@gmail.com>,  bpf <bpf@vger.kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Date: Fri, 06 Dec 2024 09:29:03 -0800
In-Reply-To: <CAEf4BzZ1239ec_J33jZj3Ji6-6W_PspVeKu05L6S729-_g6GMw@mail.gmail.com>
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
	 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
	 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
	 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
	 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
	 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
	 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
	 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
	 <1f49e00de4e5a17740e4e04ddb77b60e5ff46526.camel@gmail.com>
	 <CAEf4BzZ1239ec_J33jZj3Ji6-6W_PspVeKu05L6S729-_g6GMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 08:08 -0800, Andrii Nakryiko wrote:

[...]

> The tags would be that generalizable side effect declaration approach,
> so seems worth it to set a uniform approach.
>=20
> > Please take a look at the patch, the change for check_cfg() is 32 lines=
.
>=20
> I did, actually. And I already explained what I don't like about it:
> eagerness. check_cfg() is not the right place for this, if we want to
> support dead code elimination and BPF CO-RE-based feature gating.
> Which your patches clearly violate, so I don't like them, sorry.
>=20
> We made this eagerness mistake with global subprogs verification
> previously, and had to switch it to lazy on-demand global subprog
> validation. I think we should preserve this lazy approach going
> forward.

In this context tags have same detection power as current changes for check=
_cfg(),
it is not possible to remove tag using dead code elimination.
So I really don't see any advantages in the context of this particular issu=
e.

[...]


