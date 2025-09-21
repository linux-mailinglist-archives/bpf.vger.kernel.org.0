Return-Path: <bpf+bounces-69118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF47DB8D2AD
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 02:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7EF189FCBB
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C0B1553A3;
	Sun, 21 Sep 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cymGvW/6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF406155CB3
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758414609; cv=none; b=MJjUi3RqgybeC9HFYaChJ/SR+UWglJusQFOrU7gQXDLbHtWUitX3AmTLENiO05qM7mL5PLENyyyi1kDUmrVEcR1BUjXfEvKp6Jf0WxG9ZVsc7gVfeHMzYVsFGKKn6SMblfwVPXhmt9Rr4cDR0cPt/woSFtVCKF4R1nrmrqJ2BKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758414609; c=relaxed/simple;
	bh=KkJqFHGlhO5fUp9C3Qvob1W7xsT3UwkxtHj43B3jFLU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AE/QyJ81v56GKVDjotTWVF0ghBnd1jDMbwuF5LTAxBs1zA3wGDqFCLjQA0sMhHG7Fc0tnk580bh5x5YSEbJA7sQxB9KPU6jWg982m7/DnEarc7a04OZufS56D/N+aGjj8lRuzbpDH62D0d2YjamC8vyc7Sg0/omiczqq/nyUeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cymGvW/6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so2170459a12.0
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758414607; x=1759019407; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ksQaSs0a885pbqc5gVcvuVfvod/VxtmMsESI0mM6DQ=;
        b=cymGvW/6+g+GScN5PvTiunO9QpKWVtfC/I94hB1ki1n5gBKtEESMsEcSTmfegI74H/
         e4UKvIe66ca0bPOBPZ/QRtSAPR6+9RmH4NzxUcPFQLOy5VFXBg4YrS0NgD61x4OFfzOu
         k5cbn3blG2sf4594CTcAUl6bkdsjw2mb9JMS7xUlIoIKFt/53qVEEFEQgNpo2XTdF1EK
         czPrbgdkt+izQC1IAhjBQ8BHEem0iSMr3jDBO/uvuqdMVKa6yLKPL795l85zyRDo9Rys
         iZny/yjGz2Iv8kD4A/igi81POlLnQy9G41WbLnvHg7aB8bWrR034Pu4nMedqmYdWM5f4
         /vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758414607; x=1759019407;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ksQaSs0a885pbqc5gVcvuVfvod/VxtmMsESI0mM6DQ=;
        b=MI6I3LUiDPLJfbqDdV4FHUs3AwfOJp/IUIgjJKHve0ZxriXAuVugnlmSalEVlVIu3u
         uX+JXGkW11AHMwJ+Z2ZzDIBSVVn5oV/xJzPo1m97eELE9Dy2BeZKRW7AVvpAalO3jj5U
         rwwEGDK/6aKl60GWqwFNkM85H+IwgWj1YSBdPW74Sp8vNgzoGhwlhxWgp7C94hwWr6kV
         c4eAnANC5bX98rIaUPVu/1m3VNkPvY/onXFF9UOjDgzFJ0YfkLxqLeMPBShAuiaXaoBV
         QI1V2dDzfXhMSqDwq320OxgcIJcizdfSu/mMblWoSi+FJyC6m3+Q2mn1xyLJtLpARvVP
         nkJg==
X-Forwarded-Encrypted: i=1; AJvYcCVBVpZP7EcM2pUjr6+QDfsbCvYVpDjtabd3H42g4b1jkIRxQdW2nFK/qCYao2ml+FTBdiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtsA/itfZP8kWxduXj5K6mLJcabV1WhkmKLom/ptBQwHZ73dd
	2ODRTNk22Q/dxqVztWn67o6PR2BabLtWacn6LKPJCuTOfx2JiJLX7wb0oBHS+A==
X-Gm-Gg: ASbGncsucYyGMy4AoBHd7s4Qv3Po63g5SmzkeWW36Pw7/g972BYrJmiujALShqGZoML
	tAgzcU0EQoYAkI8OTrao7bBQJrf3heWWR6ndqiVX6F9sNBq4H48wuwacAFyJLi6mZF6am04Q99F
	4x/hzafXzJnS4NC3M6ntnj9uDcWLkjLegMatD/W0VLe3FNaVZJY5FganejtytJ1hb+nYDY1mWjh
	lD6DzHFdFBa6+hC1r+2GN6mhw5Of3ghgcheKLMvSY+s7q12yGpCaKAYyDyW/VlxAyj30dbS6erX
	taF8gfc+2A9rX9iefz+SUaQWc5DJfpN8+OOnKCHyT/oS0xrsI55wX+C/ztUdPanUPbksvRKGTpj
	ABC9jYDJtQ2Y4+VM3ZEk=
X-Google-Smtp-Source: AGHT+IHbURnzd71/p5+OhSwfgCaUzAFOI97XhtEpUuyTCv0EisCyJ3WmZhTL0xy3XPapWfnfaOdsJA==
X-Received: by 2002:a17:902:ec82:b0:269:a23e:9fd7 with SMTP id d9443c01a7336-269ba483271mr116726255ad.26.1758414607059;
        Sat, 20 Sep 2025 17:30:07 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053c88sm93219405ad.19.2025.09.20.17.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 17:30:06 -0700 (PDT)
Message-ID: <bb7aca1aa66dc0791cbdb16934b4b4a139a63695.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Silence newly-added and unused sections
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Sat, 20 Sep 2025 17:30:03 -0700
In-Reply-To: <20250920153531.3675700-1-yonghong.song@linux.dev>
References: <20250920153531.3675700-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-09-20 at 08:35 -0700, Yonghong Song wrote:
> With latest llvm22, when building bpf selftest, I got the following info
> emitted by libbpf:
>   ...
>   libbpf: elf: skipping unrecognized data section(14) .comment
>   libbpf: elf: skipping section(15) .note.GNU-stack (size 0)
>   ...
>=20
> The reason is due to llvm patch [1]. Previously, bpf class BPFMCAsmInfo
> inherits class MCAsmInfo. With [1], BPFMCAsmInfo inherits class
> MCAsmInfoELF. Such a change added two more sections in the bpf binary, e.=
g.
>   [Nr] Name              Type            Address          Off    Size   E=
S Flg Lk Inf Al
>   ...
>   [23] .comment          PROGBITS        0000000000000000 0035ac 00006d 0=
1  MS  0   0  1

This section is generated by MCELFStreamer::emitIdent(), virtual
function.

>   [24] .note.GNU-stack   PROGBITS        0000000000000000 003619 000000 0=
0      0   0  1

And this one is generated by MCELFStreamer::initSections() virtual
function and is controlled by NoExecStack formal parameter.

MCELFStreamer instance for BPF backend is created by function
BPFMCTargetDesc.cpp:createBPFMCStreamer().

I think we can define a sub-class BPFMCELFStreamer, override the above
virtual functions and suppress generation of the sections above.

[...]

