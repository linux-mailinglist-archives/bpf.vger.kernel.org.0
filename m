Return-Path: <bpf+bounces-37328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB52953D43
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1221F21280
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1402155727;
	Thu, 15 Aug 2024 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0tRCYQs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEE1552E3
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760193; cv=none; b=EkV28OpHO6mF6RVTtXdvwDvVuUGhcCcVwjRQj6bcW5at3V2/dNvMzXbKmDN5Om/ebXEC6ApyHV99TA9TFLLU6mMMRALPSW3K5ZSG2qBt9IuBOBo2DOXLdbV9SehrmublP78AhCue42/fKI3ByE7IMXUXQrzcY/EUFtLFrcsMrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760193; c=relaxed/simple;
	bh=j4YblmB016AvRZs0SE5vAcV+TbcQEMs7om6HKG8NaBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEIIb7vn2cooh2oY/Ccd0i8yhpu8fXZGagAHbMborGxwuhsja0kzPx1jGFzU4BV5NezHnsUxIGQAdcFM2t8aP4B/EWy8AKz3i/5VAQtObfPHhG76/TbFq7pXZ1yI0jhaaS+eiPKD95AHXZouJUSo6E+Akq/dRTvhNiLGSJV66dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0tRCYQs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fee6435a34so12110435ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760191; x=1724364991; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4YblmB016AvRZs0SE5vAcV+TbcQEMs7om6HKG8NaBg=;
        b=H0tRCYQsq75Kqm+LgEqwD/6UzPu0Ox4YHjJ5WHHbIRFM84DH/SKj6ZnqoO7ZSfIsmm
         vtwwqS5dHzeD3/yFNxDv1i6lhLU5HdiYqkYynk0+Oboan4/x9PJioAp93sGAXZgXm1R0
         43hEeXeG4pkDX4eUeaSKmVD66dm95+aBnBEsCV07ACbTcM3oLiyBR7LE0UBxra56RjaL
         GYh4JJe1z6yX21+jgUHudCPwmpvuhyFnzNwJwKKlDLS+5a7/q4EzWt+j6bL9HgaGQWbu
         81y3W9BrzauwoHPwD2ibG3q7vTet2cnpbqJlpsfe6IXYMknZwZstNpUQoLY8xH2cvUyh
         eTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760191; x=1724364991;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4YblmB016AvRZs0SE5vAcV+TbcQEMs7om6HKG8NaBg=;
        b=ecYCmI5OA16OH7HEODtl1YaAVg4IZTm5t9YPbNBhXreh1xlAya0kYDAqcbbuupOwrL
         b9eRtqJMaQmMS4YxAz4QAXIlPWdWEh8SHIPxn4+UevkYgh+QBL/CHKXUu9rK0O/RC3wC
         k3M+y1fhnUkaXClgsWtZfknBPP+XND5Yd/aeaXnzTM2rdoAAgj9Coces8ys0xXdgaPYW
         x3N1VbrRaI6ABLbLisuglD3lwA55xC03vN0kijyUwmpxriIS8jjK7Vtwhg+uaioCDdiE
         Sak/czSxZ7uJTIRn9i4KuflOZ8vx+8n/rWivnLAAeaIpx/L4jG52QwmVv9Qn61ftGrz1
         J+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWMnDZ/yTJKePgt0PFVHdUaRN9fEtTY6NKEJrrtxEraNmFb+FU2+KMLgQF/vq/honT/xSPSG5b+MsG5TZ5Sff71iy2H
X-Gm-Message-State: AOJu0Yz7CoVEnwEAvdWQAX4NtSv//K/EsI81btn7SPP/+/Aj+x0H6YVe
	Q9KSGK2eqa4P25zsvwCk3QToHNArlBx+mEnMIS7JqpVMOncIrQ9K
X-Google-Smtp-Source: AGHT+IHACKc3iG4bGXprGHzHY1yoS+XIGb12EwqAQy9iEHegdbVzccuWseMKSOCCcFxCo8c8AceNww==
X-Received: by 2002:a17:902:c40b:b0:201:fd52:d4e7 with SMTP id d9443c01a7336-20203e530a7mr13040505ad.2.1723760191367;
        Thu, 15 Aug 2024 15:16:31 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038b4b5sm14582715ad.218.2024.08.15.15.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:16:30 -0700 (PDT)
Message-ID: <ac12f7b3f4cd0cba1470d3ad0a944fd649b03013.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for
 tail calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  kernel-team@fb.com, hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 15:16:26 -0700
In-Reply-To: <CAEf4BzbB+mhUO754io-qJXcdpYdfYF0G-LdamRAWLsdYsbptvw@mail.gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-5-eddyz87@gmail.com>
	 <78d7872d-4644-4a9a-9ef2-f4823fd7944f@linux.dev>
	 <f49cc01dfea19be0d287995e8bb539a14dd31cf1.camel@gmail.com>
	 <CAEf4BzbB+mhUO754io-qJXcdpYdfYF0G-LdamRAWLsdYsbptvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 15:09 -0700, Andrii Nakryiko wrote:

[...]

> > > Or we can use macro like
> > >=20
> > > #ifdef __TARGET_ARCH_x86
> > > __jit(...)
> > > ...
> > > #elif defined(__TARGET_ARCH_arm64)
> > > __jit(...)
> > > ...
> > > #elif defined(...)
> > >=20
> > > Or we can have
> > >=20
> > > __arch_x86_64
> > > __jit(...) // code for x86
> > > ...
> > >=20
> > > __arch_arm64
> > > __jit(...) // code for arm64
> > > ...
> > >=20
> > > __arch_riscv
> > > __jit(...) // code for riscv
> > > ...
> >=20
> > This also looks good, and will work better with "*_next" and "*_not"
> > variants if we are going to borrow from llvm-lit/FileCheck.
> >=20
>=20
> shorter __jit() and then arch-specific __arch_blah seems pretty clean,
> so if it's not too hard, let's do this.

Ok, let's go this way.

> BTW, in your implementation you are collecting expected messages for
> all specified architectures, but really there will always be just one
> valid subset. So maybe just discard all non-host architectures upfront
> during "parsing" of decl tags?

I kinda wanted to keep parsing logic separate from processing logic,
but yeah, makes sense.

[...]


