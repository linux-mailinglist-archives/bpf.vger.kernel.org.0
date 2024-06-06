Return-Path: <bpf+bounces-31526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA78FF406
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 19:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1321C2844A3
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8C1991C7;
	Thu,  6 Jun 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sya6WajW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4ED3BBCC
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696032; cv=none; b=nYSI2O/9/49iZeFxead6xSyens7LyUbhtrDTzI4OHv8r4kSFur0Dzxq5PY00GZo9dt+zbOdFSo2tahHb/p/pVoBz0UEUuSe6jmOWY5E71O2jGqmlFX6tRhRi3UCSKB2FVRkh1MwYg3Pn5Q2hBoWdsqPQBrJcmc/N0KvSc/+AAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696032; c=relaxed/simple;
	bh=ql+znC1owKk8nIvsgzRZBrcUq9ALurOY6zEWBfBIeMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=muSIbQmqJGDSfWzryrF160hzDn9R1M3inErMQkEsjV3vMto+XrVfw13CN7EkojPgF+ftB8wQDWXZDZsltqSlfavkmxIwlUEKz46/iaO/2XvsHrElA4Y6h+1IsKV0XR47ZQZgHNt4XSIiQhkcQ/CW1pcfC6ufauJmFIabss6rYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sya6WajW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-703e5a09c11so1084341b3a.2
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717696031; x=1718300831; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ql+znC1owKk8nIvsgzRZBrcUq9ALurOY6zEWBfBIeMg=;
        b=Sya6WajWBmrC4NLqm7GQDdTzLotF1uiQPZkcHjuDPHo8YDP9yGJWYPqv2lHC8W3Wox
         MwDuL1wmxmOeC3HyRJbTNU5HAJpQ/VpXuEosNi0CuJN9a0aS8Go63fzHEP2MBpDpiWNF
         OK4f8VF3O3Nv9cEmwd0coxyeTM6BgAx71MfP62JoZmBgytv2n8IxEFCKiR5e4m86VNcJ
         +GlohRwvtFj5hRhfESBCI/5eBObYTuE1PgnAtZtzwfU3gYU66x/zuccuFtIqWdxk21oj
         znHTTAasVeoF8/WurHsrLxW7PLyffDm6jVlT8JyKpfBu1+oOyjl0oevs3dYVIV1UPMJe
         /RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717696031; x=1718300831;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ql+znC1owKk8nIvsgzRZBrcUq9ALurOY6zEWBfBIeMg=;
        b=QT7G2RVO3Q02Dy3nwef8wQUkjVT3k0obI1FLpv6QHia/Fe7R5DVD1rsuNaekjAicYn
         Kg+6Q7r9YIhDovwyTJISmBqvwNr5l1vvZMAq34LxfyrGUMRWpqL2187s4LXkSNjoWZge
         2sdP29cQG74VTyzDL3JAL/0BBNH8jZmxZjApn08Fda/Jvw69OFLuGwchmFz6mevURUqg
         fwEKd3KVRLH3fEE2kCiQBLka/yX/9of+cxf0kWaj7UmKd48Jz01ZzJAZ93lvjfYlvTWR
         M8IGoOzLcgllzHqTlqZzpQmRqIeZXvfOYnp+OmlhRwL+LPQco0vKEZOJlUBqEa/amilb
         j3hg==
X-Gm-Message-State: AOJu0YxT5doib/1JaCvEUkLqVBb0Cd3oy5HLuNXiHN8iTNCGIvMVBcDO
	k3/mzW60V8C/q6PebXST3Y36MHSvLRLBbx2KRWdEJlrZmTL10eAEo9R8zg==
X-Google-Smtp-Source: AGHT+IHo9FWl8EwXM94p6x1mmBbmWDEAsoBZgFHXsA0OehrxBIEywq4NdfETpQbD30sJK1x0wz8NUg==
X-Received: by 2002:a05:6a00:1409:b0:6f4:59cd:717 with SMTP id d2e1a72fcca58-7040c74d7e7mr147202b3a.28.1717696030708;
        Thu, 06 Jun 2024 10:47:10 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd228784sm1377632b3a.0.2024.06.06.10.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:47:10 -0700 (PDT)
Message-ID: <2f556a9bd96929bc735f3ab3aca3f385c72e2fc4.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Match tests against regular
 expression.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com, 
 Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Date: Thu, 06 Jun 2024 10:47:05 -0700
In-Reply-To: <CAEf4BzaVkJghcSpLdRdwmRyGVj+SoUnF88d-9e5Xvb7fmuKt4A@mail.gmail.com>
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
	 <20240603155308.199254-3-cupertino.miranda@oracle.com>
	 <CAEf4BzbqhhLsRRTP=QFm6Sh4Ku+9dKN4Ezrere0+=nm_8SzwYA@mail.gmail.com>
	 <87ikymz6ol.fsf@oracle.com>
	 <CAEf4BzaVkJghcSpLdRdwmRyGVj+SoUnF88d-9e5Xvb7fmuKt4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 10:19 -0700, Andrii Nakryiko wrote:

[...]

> > Some other test, would expect that struct fields would be in some
> > particular order, while GCC decides it would benefit from reordering
> > struct fields. For passing those tests I need to disable GCC
> > optimization that would make this reordering.
> > However reordering of the struct fields is a perfectly valid
>=20
> Nope, it's not.
>=20
> As mentioned, struct layout is effectively an ABI, so the compiler
> cannot just reorder it. Lots and lots of things would be broken if
> this was true for C programs.

I'll chime in as well :)
Could you please show a few examples when GCC does reordering?
As Alexei and Andrii point out in general C language standard does not
allow reordering for fields, e.g. here is a wording from section
6.7.2.1, paragraph 17 of "WG 14/N 3088, Programming languages =E2=80=94 C":

> Within a structure object, the non-bit-field members and the units
> in which bit-fields reside have addresses that increase in the order
> in which they are declared. A pointer to a structure object,
> suitably converted, points to its initial member (or if that member
> is a bit-field, then to the unit in which it resides), and vice
> versa. There may be unnamed padding within a structure object, but
> not at its beginning.

So, I'm curious what's happening.

