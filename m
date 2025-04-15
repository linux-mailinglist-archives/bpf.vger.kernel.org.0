Return-Path: <bpf+bounces-55939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB4A89805
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 11:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0D47A4ABF
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744027E1D5;
	Tue, 15 Apr 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AfGdYt5K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6D41EF37F
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709462; cv=none; b=WKnr8lNUCpDZpkca0YKcVET2Rv5+FaEsZuE4vhpS9BP8RfFR1OvzQ20GgggzOqjoaC9e++4wZBWD6VmhaZHd26DaaNnqc2j+n/AYNBjBFjgh1e1WV4WrehmeYZKyCO6x9XLxHld6kgLnGipnIzgbPjMY9C7cgVnQHalSFo7yals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709462; c=relaxed/simple;
	bh=COsaRIuvxnkua8HwmzqjmXwFKFAVEQs3llUnp+yyRGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0zLL7OWbDEH2grkC2gK+wTyuTtcYMVRVq3D8eHBrNKoHEv7HUjv73FmghXQFRYWOuUqf+eepglMu+xRQjoEvSVL6tWwMUVgpAXJ2bIdChOvZvJAIqhm1pXycudiW1ynejSwz4RFAsPyuuCNTZlOmekLvn54vewFlOuWTTNsXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AfGdYt5K; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39c14016868so4862436f8f.1
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744709458; x=1745314258; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5p/bRbKfGu9zt0PYKNZNkRZvCOD+RuypWosHSES6Sk=;
        b=AfGdYt5KwMeDqSr3flGaW594aFpTelPBvMu5r9km71F2xNro+xZ56Gx8w6TcFLoA2L
         gwhwzS96IhpFHzPG+aRJEIRsWDMGWJz+S3i05o1TOBpgenn5XPRcYcVnwXEhc8hvZBaF
         t+mdE8nDFk7zXUlgVQscaRDlNpTCFpy/QbSrvYcDct1B+FMXAjFsxCh3brHpsA4eXFvW
         CJSiyvL7Bh0QTftP+gTgfMK5Ztv5AHJjE1qpyLNPzdOHdYQ6pDTG5ACvat96qREntjJE
         9DwgiJ1QhXFK62fZNgthuQUfNciXC64ZtHqdpHXVJz45Nt+Ivy55yqs/4wZ/hwQJkzcL
         F0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744709458; x=1745314258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5p/bRbKfGu9zt0PYKNZNkRZvCOD+RuypWosHSES6Sk=;
        b=rRk+5tj4vk3qw4QXbB/x9lArU6+sqSQDpLSLkmqlS+mo37KyoGwfyzokYtHNd3tzgN
         vdaP1bgQLGsS0ePGPsjClyBL0opoEWhrGGHPRglXSS4XpuTKOOgIwQBp9M0a8t9Gb6yl
         EZYSFnReWlaSgbYkYtOIS2I8AMRrjxP5NGXmDE74Gdq+iRIN/QZHPH/6hvWlWQiTvYth
         HRQDRSQaQg9oDxdHjnwd4hshIme/IphrHmhUDednKPzEjY8N3ymgStFB79YAerzGHqF/
         KticRu9z9NrlGlwW3XOodLxihQCJHH429AP41GgbQreFZd/npQ/8WB7kSI0Vgl28TdS3
         Z/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8EbB6xlSjN8s9+lhmbUj93AS5ipMai/GwltDImHnUUsJ4naeQSpY4yOLGQzB8AeiK7ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzbn7y9dWjv+PT/yfn5PeuRTeNvQrOMX0Cv3Fs9A2czs4f05J
	9I1UI7agSyrBdcnYDmTa1CG8EAUH4W/ow+koCK09AQCoviPHl//5Hv0WoAt7h24=
X-Gm-Gg: ASbGnctfpKSwu03ZCvNlMWPZkqB75CxASuX62YPkFSOBrGrqNHfcPhC2rK/Rwyv2sjQ
	em0R2dU0Dy8AqMt0QZyVUbz5DrzjUsQoHzvv3UvjZWLf2eyjTNXj4hQk4G+IgKm9nbF8OtUOWFO
	aDJN/Hz84k5a3EIwp6pjdYtZArIED4/BvaQutsTT5gLiurK1rEXr4FunJummbeyIkh0Vp3UcN8h
	AH6j9BHCPEemMxh4w2lfJkdmuLn9OHsVft5ApFj+M8Vz/+3q/dU1DwmckcRvd+8ZkCGyULQyuVo
	vDEUIXmNBlb10JCJcM/ViyXLGhX+4p0gH9UqfVG3mJssCA==
X-Google-Smtp-Source: AGHT+IFP/8/ehvnOlG0x/DX32B7q3RBAFlaoRAWXR6v+kbGywYJdun4oe9Fh5KKW2bpD3AzaY3WOhg==
X-Received: by 2002:a05:6000:430a:b0:39c:1257:cd3e with SMTP id ffacd0b85a97d-39eaaedcf62mr13305491f8f.56.1744709458272;
        Tue, 15 Apr 2025 02:30:58 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:75f9:2464:4043:4f92:fce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95c8esm112943125ad.145.2025.04.15.02.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:30:57 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:30:30 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, lmarch2 <2524158037@qq.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH bpf v2] libbpf: Fix buffer overflow in
 bpf_object__init_prog
Message-ID: <gaebflcrzdszes6febvrf43dgllpemg3ghcgbwmd2klfaj7p4t@cmg2los3ahla>
References: <20250410095517.141271-1-vmalik@redhat.com>
 <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>
 <d87e3ed0-5731-4738-a1c6-420c557c3048@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d87e3ed0-5731-4738-a1c6-420c557c3048@redhat.com>

On Mon, Apr 14, 2025 at 06:59:31AM +0200, Viktor Malik wrote:
> On 4/11/25 18:22, Andrii Nakryiko wrote:
> > On Thu, Apr 10, 2025 at 2:55 AM Viktor Malik <vmalik@redhat.com> wrote:
> >> As reported by CVE-2025-29481 [1], it is possible to corrupt a BPF ELF
> >> file such that arbitrary BPF instructions are loaded by libbpf. This can
> >> be done by setting a symbol (BPF program) section offset to a large
> >> (unsigned) number such that <section start + symbol offset> overflows
> >> and points before the section data in the memory.
...
> >> Cc: stable@vger.kernel.org
> > 
> > Libbpf is packaged and consumed from Github mirror, which is produced
> > from latest bpf-next and bpf trees, so there is no point in
> > backporting fixes like this to stable kernel branches. Please drop the
> > CC: stable in the next revision.
> 
> Ack, will drop it.

Sorry for blindly suggesting the CC. I'll keep that in mind.

> >> Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
> >> Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
> >> Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
> > 
> > libbpf is meant to load BPF programs under root. It's a
> > highly-privileged operation, and libbpf is not meant, designed, and
> > actually explicitly discouraged from loading untrusted ELF files. As
> > such, this is just a normal bug fix, like lots of others. So let's
> > drop the CVE link as well.
> > 
> > Again, no one in their sane mind should be passing untrusted ELF files
> > into libbpf while running under root. Period.
> > 
> > All production use cases load ELF that they generated and control
> > (usually embedded into their memory through BPF skeleton header). And
> > if that ELF file is corrupted, you have problems somewhere else,
> > libbpf is not a culprit.
> 
> While I couldn't agree more, I'm a bit on the fence here. On one hand,
> unless the CVE is revoked (see the other thread), people may still run
> across it and, without sufficient knowledge of libbpf, think that they
> are vulnerable. Having a CVE reference in the patch could help them
> recognize that they are using a patched version of libbpf or at least
> read an explanation why the vulnerability is not real.
> 
> On the other hand, since it's just a bug, I agree that it doesn't make
> much sense to reference a CVE from it. So, I'm ok both ways. I can
> reference the CVE and provide some better explanation why this should
> not be considered a vulnerability.

While I also see other colleagues that reference CVE number in the
commit message in other subsystems, personally I would drop CVE
reference here. This CVE entry doesn't have techinical detail in itself
beside mentioning that the issue being buffer overflow, and is
disputed/on the way to being rejected as far as this thread is
concerned.

...

