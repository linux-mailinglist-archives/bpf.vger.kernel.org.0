Return-Path: <bpf+bounces-35138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7701F937EA6
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 03:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE621C2140D
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAC28489;
	Sat, 20 Jul 2024 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDMh2J7v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6475664
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721440704; cv=none; b=oQcnLvn6pnYZGmMqx5e8KLwyFm1NNVrYTyFiuMxR/x/kx/MqKH6tDJ8xfRsu1HA0taedcMe4RB3zBXs+XV05w47OL4SYT2T5xzKmNw+nacqUG2hfJdtKxHP2aKTJVcz9r15b3u9nykjcnuRkpoRXr/VKoNbNpL3dcjyCwm66Urw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721440704; c=relaxed/simple;
	bh=DZzYFc7JTK+Mm3e3xKT6eQ5dnHpto8xos2mdB7IZHfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwcFHCZqm7CQL5g0rKEZGc3KQTdrCNJVkx/e51jiJ9/v65HwNQ8KvtmILD7AGWnP0nzteO3mVgumRmtnh3Q3aLaWb4t4CkLLyEYMqQiE74QffBXtw2T+mrVT/6IdKhBpjoWYTdn2My8fe9AmDwdrMWau1um/LuzbZ3etNF7hYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDMh2J7v; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d9306100b5so1447025b6e.1
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721440702; x=1722045502; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DZzYFc7JTK+Mm3e3xKT6eQ5dnHpto8xos2mdB7IZHfg=;
        b=nDMh2J7vEwDUNJ+1tjxxG0a7mEC79h/Cx5XTUYSZrB0B5wDvGFjWbIyFyQYHYXt74G
         yfmZs6abpJRdi6PZqiAzeDiujoZI9ui++m9PawEs5AOBtZcqrbuFRTEzroN5JQYUT8+K
         Zfmpw+L0OichJHtzJidmFe+9YL78WLrdVJVVnQBu4fQhbeqqJtSin9wPQUuYNWHYFFA9
         sOYn01Kk6YiV9AZVkDc5Y2/HeIHrX4uUG6Gk8eA3xCjlOBzZ8AftvpUdirEFO83km/4O
         PqjzT4Qmoq5LcVLQe5qbT5RPDm1DLgz/QzxzJlBE6Nzo+qJgFM1DoknSsau+fE+7+Ewo
         XFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721440702; x=1722045502;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZzYFc7JTK+Mm3e3xKT6eQ5dnHpto8xos2mdB7IZHfg=;
        b=oRIvQCl0KgWYhBjTuu+tcbVN+M+rnKoCY/SDCQh00awP4aX93ScVCA1HVtm6ale2EC
         eD606225VpvL4kwtj4/tnROPyZVTCNUTN2isV9voE1Qk7bpg3dltXozLAAm8hf9s842W
         8ovsXk5r5qU8zT4/gNHzANXfNE1QqZFNXAgMKsRlmK3M5ckBnlv9dEubQcIa8633uyN/
         IP9qIFuKQ0r4TWFofAEYCP0fJlHsGPTNuiDXIdvG9l5OBUwG9LypDUvfO239/FT9iztm
         kms1Gy7UaUAFiy0d/4qmuV2VSYWl7MBWkRJqos1k23BXc3D/zw+3pNrthqGtuSDvsBaB
         dHfA==
X-Gm-Message-State: AOJu0YwZcyT4zAj6lEwuvTyKf5Pp4VBj6y53wu/G15VjG+CLp8pqZBQq
	tyrFfoXzDN1ZvXql+wW49G8Gwe6eK4EmjHmxMTAITj5cSowUEbbL
X-Google-Smtp-Source: AGHT+IGWsRUNO0bpKJ9xVZmwXahrII+To3jgbhaw7RbV40PbGtkLY/p2xg8+RqRCO6s6YGQgkoEmzA==
X-Received: by 2002:a05:6808:d53:b0:3d2:23b0:891b with SMTP id 5614622812f47-3dae5f1e3b1mr2035967b6e.15.1721440702500;
        Fri, 19 Jul 2024 18:58:22 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25adfasm11511285ad.36.2024.07.19.18.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 18:58:22 -0700 (PDT)
Message-ID: <c1cb5ecb615531342ce0a40abeba808731d29a17.camel@gmail.com>
Subject: Re: [bpf-next v3 11/12] bpf: do check_nocsr_stack_contract() for
 ARG_ANYTHING helper params
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>
Date: Fri, 19 Jul 2024 18:58:16 -0700
In-Reply-To: <CAADnVQKgn-3gQoxg7z6tBRfykF=8u5T+3yYnghCZa0p2kzsrbQ@mail.gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
	 <20240715230201.3901423-12-eddyz87@gmail.com>
	 <CAADnVQ+2SC6w2h+bNBEZ-R--RVk5zgz2AA-x2=7X8azL26ua0Q@mail.gmail.com>
	 <86c8004aab94e0e833b438ef2fba25f0835a9aa8.camel@gmail.com>
	 <f27a6146f8ef01fe01efc8b69cba1263b3f45ce9.camel@gmail.com>
	 <CAADnVQKgn-3gQoxg7z6tBRfykF=8u5T+3yYnghCZa0p2kzsrbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-19 at 18:54 -0700, Alexei Starovoitov wrote:

[...]

> > So, the point stands: from C compiler pov pointer &b escapes,
> > and compiler is not really allowed to replace object at that offset
> > with garbage. Why do you think the program is broken?
>=20
> This is apples to oranges.
> Compiler sees that the address of 'b' is taken and passed
> into a function with side effect.
> Whether 3rd arg of bpf_probe_read_kernel() is void * or long
> is irrelevant. Compilers will do it, because it's a C language
> requirement.
>=20
> > I don't mind dropping the patch in question, but I agree with Andrii's
> > viewpoint that there is nothing wrong with this use case.
>=20
> bpf_probe_read_kernel() is not special and it's 3rd argument is
> some kernel address. Whether it's stack pointer or anything else
> is irrelevant.
> JITs and verifier are allowed to do any optimizations on stack
> and any other memory completely ignoring presence of
> bpf_probe_read_kernel() and what is being passed into it.
>=20
> Tomorrow we will teach arm64 JIT to replace stack spill/fill with
> spare register read/write. There is no way we're going to special case
> a particular fp-16 slot because fp-16 was passed into probe_read.

Ok, I will re-submit w/o these two patches.
Andrii also requested to re-structure the check contract function to
reset .nocsr_pattern and .spills_num marks to 0 upon contract violation.

