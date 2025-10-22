Return-Path: <bpf+bounces-71730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D78BFC7AD
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FE46621A3
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1434887B;
	Wed, 22 Oct 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn79Aa0Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B2346E4C
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142036; cv=none; b=Z7H4v62X3XiT0dHF62b8QoT4Lwy2r0zSF20c1t2hm7fqZYS9x2mcclJzmlu+wfQHl41lDIvxSU2WpzZ+n5dIcsVcHTw25ej1vKjwDjEBvOxzi2V4Qa9FAEnkSPmrrO2POmvmj0kt1WtPcCRjgYep14kJ3l5tJN4yW8pLSuIXpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142036; c=relaxed/simple;
	bh=gkKxWd8KXiGvH+KUsUV9MZ+OqANpdvOiI5kNn5PJkzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf2lQDP+eD8ta1YLnSIWyy7Uqs5bz1lvMKExrW5WhD1d6kTAgbMAcU9Xoc4myBdS2zLDQfgiDdVyKKIHpLwitlnjhPP8CINZuyuO3upErfJQrjE16s/U+W5vxCaJ+O6MrdVg09wGpBb6ZTRYjwLoD+WtHalPKtuPfwg3xXNywls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn79Aa0Y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4270a3464bcso3790553f8f.2
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142032; x=1761746832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2UgKBjJ/YJZKDPgcuy8ak/6UsSZ2YjC/v80oIn1egU=;
        b=Nn79Aa0Y08wjz/duqZkPPEq5qxUyNbPgCuVJ5bbzcwtV7AUE1HlAMtrpqP1GGvmZ3S
         U6Q28yMqXzcJJ8ioOMvx1Pyv8GtPNywBNkIvpEbVT69kn+LZhb8rAMmQ2OLDLlJ1kzll
         XgdD6DKIY7S3Ut9JlnmWKUv8bsZZ9s2yldx0LOlDRWSNt2bMNSblQDDaqyalvjQ3XpDv
         nv9LmTlb7vp+xSO28ybBTITSnpjoDaqb8gILNo0RAFNeid8ZcG3t85dhbav8QypV8paj
         QYmyEWSy/igtP1SXjMYjuh2cVZCT6LOdn2ZBhCHqla4i4bX+ZtHB+clcOanwwBT1CQH1
         YL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142032; x=1761746832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2UgKBjJ/YJZKDPgcuy8ak/6UsSZ2YjC/v80oIn1egU=;
        b=xOJQ0MokvIctenOtNHf7Cyg8m45Hb+zI5InMiQaFZVLX9DV26I0d++ZLbyPEwlbnlR
         Beat/WnkFl3/6+9IxeJ02LqrkTts2f0laTDRw2wWXIfvri/dvTawZS+FWXL4rjVI+Sta
         0qutO8zU2jGHr9BMAweu4zD8koCsr3+eJVJiWLmBn7vLz4kkEGfD4rkBfzNyEggRz3H8
         Ev5PrtEQs/mpiGD4qvhcdJiXA3m1Hnp9uk2j6bRt7X1G8KXo7FBurJwY2WzMsYk07md8
         93XgBgY/lQhrjgwDi2vER9RyEPvODUnDtqBUtet7KixQQ5X52NBdZZc2Y4TTgUXtCVT5
         Oppg==
X-Gm-Message-State: AOJu0YyFtFZB9naGIJf1d0fJbUD4kK0JAdwtdhGz8UY8QoCC+5PcTKDS
	4LN5rtokOnO/78joKvAWVFmtCJ3r74Yy1w1Ay6OdhpJBH4Hj1uKbU04j
X-Gm-Gg: ASbGnct74uNNI4ljBTAwVvOpuSkJePV7ccHqsyV+M1VrMSCYqRg9loU34Aof6lll9T0
	2KgOhNUtSnwmCpaLLDE0kv4cdLW+X17eLSne3rKXss52MU9KbabfBulny9C3vqywZ73iTdnTNoe
	QDkgPmw5Z/OyeRokSgOxWcX7qxDcQSIzPM/gurDtSKwatY0hPKBqVw6smdWb1/82wF0ip7/ytsd
	nyCiWVGmoLmWhmTU6pp+zPjdw0km2bCCqbqe8I9bweS6dKqfgkQhivUPf8YAApk2CHRHvnlrB1B
	ONK49Nc0qxRL+C5UcXrAAObCxb/sWZwgQ1QZ4sBE7jdphM9kuUw/eyqY7nOpXK9qtljyWI3UVhP
	1a22YBbtx6VpErzgTfSlmlv4p2FZ/MQHlhCb+U+kHapeHzT3Q4a8ARUARdE3EysJagPhz7SKQze
	ex8LvCzYdeUNaqQgYoKHmH
X-Google-Smtp-Source: AGHT+IH3ur4Z1kgiluA8uX65x/tvCY+VwJtp/9tWK9qA9avvSe6u4Qn/a3j8wcLC04qda72YmwcmcA==
X-Received: by 2002:a5d:64e8:0:b0:427:7b7:dbdc with SMTP id ffacd0b85a97d-42707b7dc04mr12731208f8f.24.1761142031716;
        Wed, 22 Oct 2025 07:07:11 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0e9csm25475632f8f.5.2025.10.22.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:07:09 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:13:48 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 05/17] selftests/bpf: add selftests for new
 insn_array map
Message-ID: <aPjmnJo+ClGgOkBL@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-6-a.s.protopopov@gmail.com>
 <9660d7d3d3348bdf84c0a1a2861b66db9e2cc980.camel@gmail.com>
 <aPjfuZd+370hXFLJ@mail.gmail.com>
 <0e98a654792b6ab8002b0cf7ddf604e20b2f8f5e.camel@gmail.com>
 <aPjlANnS+hj09w2s@mail.gmail.com>
 <d5babd1d0a1ff4b1d5f11a95bde7881f7c970272.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5babd1d0a1ff4b1d5f11a95bde7881f7c970272.camel@gmail.com>

On 25/10/22 07:03AM, Eduard Zingerman wrote:
> On Wed, 2025-10-22 at 14:06 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..a4304ef5be13
> > > > > > --- /dev/null
> > > > > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > +static void check_bpf_no_lookup(void)
> > > > > 
> > > > > This one can be moved to prog_tests/bpf_insn_array.c, I think.
> > > > 
> > > > A typo? (This is a patch for the prog_tests/bpf_insn_array.c)
> > > 
> > > Yes, I mean progs/verifier_gotox.c, the one with inline assembly.
> > 
> > I think it should stay here. There will be other usages of the
> > instruction array, and neither should allow operations on it from
> > a BPF prog (indirect calls, static keys).
> 
> It will be functionally identical and like 3x-4x time shorter in that file.

Ok, I see. I will either move it there, or add another
verifier_insn_array (if I see how to convert/create more "insn array
level" tests like this).

