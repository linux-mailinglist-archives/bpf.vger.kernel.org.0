Return-Path: <bpf+bounces-72384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 942FAC11EFB
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 00:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D70504E79A8
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D1332ABCC;
	Mon, 27 Oct 2025 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnWP5BxY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E230AAA9
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606715; cv=none; b=tXQB6k3r6TN5ihTotFkNWyGjikOPYlzWYoVPCaCd0HkwwVUihHVcaY2oF4q5g+m4zN8bzRAcr6piRWRvsdiJ7S6vjqCS8EaefWc00O4VSdLXfaKRy1RX/suajdzcIGgrDvXB+s2qHI4t0Kc3PaGywYTnnmArlH8uTWfg0vbj6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606715; c=relaxed/simple;
	bh=LINmLiKRf1MxG/sxc/fNhkzDTWFp9mm5vCkp92gYhZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGClJWn0sluWGAnvX7V/83FprNWtAZkYHkCsvC7dqfj2V65vC6X0v98J1mJhDqHUBmwZB94xthxjCKO5976PHl88F4F9uMHd+7u168KKhIQBqkebyk7DiHmuJ/7Bt7TTjEmwouYgLocZZsZ+caEPnGML8Xum5Qfp5oB9f35njUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnWP5BxY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29490944023so34824115ad.3
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761606714; x=1762211514; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LINmLiKRf1MxG/sxc/fNhkzDTWFp9mm5vCkp92gYhZI=;
        b=ZnWP5BxYtIlJlZXl5MGEjNtydN1HZFSWRJ/2uN4jXOZ+Z7F3xkGeYC7bueLVsbIDAp
         ct7LJZb7gJw+Fx0qBnhn4Bwf+Vl55kypH0zcAxgqlR4NOmNbuJV5G8wHzsLuD3oTsU60
         iuarfQx7vHOdz6V/0k8/fezsTZNHTy11hyjHeEi3EzJXyzdvqviK7rZ0jMcKZvnXPB7F
         S8jZSY2mGo79Hg4+cxwtR7yl0crUneUltaan/ACEsKwbAkCLaYDY0O4AcIg6Hr+wzBXr
         JfiGBI1DMq8TSidqP1Rxpv7iPUrQQBM92n1UMdqc+FAcQh45YHArYip8ihi4ENybKLl+
         jK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761606714; x=1762211514;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LINmLiKRf1MxG/sxc/fNhkzDTWFp9mm5vCkp92gYhZI=;
        b=JKdnjPWsbuRX+V/OwT62GoyiVyyDDy5kPeRJFFa1+kPhJnQXdzSDFFCEge2p/jjJsg
         81y4f8MEGN85kp4Syo6dk0nOwyxrMTdhooXUUm4cVKZdsMZpmi75JIwiUgpbUHZ1Ryxk
         LlnP33fmxCwWXDHs4bEizX9DOOiIvYb5z4ZnTyeoyYGdOpoTYbZt9UQzZ6v4MHY00h3k
         Jmgy2r/ybKH1Ix6leF8RpKJIH+Vaxd+bbhwb4QF0M3b/ZUmP2uW6PZvAtCxYczU6kHYM
         /nVNRkIvqcTrQOCqp1CtXEPEsYDh1D6Z5QD8j5BdKb+d60gU02CkWhl6QHF2NbiLvw79
         phDw==
X-Gm-Message-State: AOJu0YxgfekofmuccJ2KZVS7kmKDxldz6/2Ll6wgkDArN6XH9gYb66xZ
	WlF2sqa+vy6nyOEJum6MCkySbYvIPJLf9cr5IWkYWGVYrVipdKKH6KXz3dnoZiwP
X-Gm-Gg: ASbGnct75AQVbNbjsJgrDg6fD0np6sWPaY2bqCP9ypUo4wI+MCXNobWUutsR+LDkc8g
	5TfAB+a052gyZoro8+nHMcBteOrgoSi6aClMU4MlZFt2KkouFamlLQi6+Z6uAVX0Qmlz5Y6S7P0
	1CeJWS9iMjlmFwXY5Xcdn24cWOknfZ0eUM6GPUcAlJT2NnqWAaRVyqqfTm7f9LDQnNr3nGq1gcr
	Bg2RTFvJExgpzWkZL+Y4cHyj6ez8APJDISOSv7sSaMugAiIf2/pUcKGeG+mPLx6jN/00UjVJS2B
	kajjqOFmmJ4dv7gXT/I+9jOKhtI5mClyRVvqEFRANIo+e5NWKrwPS+M21/5T7g6IUdq6Q1It5qO
	xQ5qM3qo7Pe3GriQtiVkE6AFAXhLVHwosqRAssUnYUswczRTE4ZByFKF65rz6EZzdezt0AHVuZb
	6Egcus+RXxs7iGw1//2hE=
X-Google-Smtp-Source: AGHT+IHtgR+WaZ4SWHEx/VwqecjQrzX8+DxckPd5WrTjuj4J38EjOLTLHA5aYmGf9l6s8/aA2qflCQ==
X-Received: by 2002:a17:903:1c7:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-294cb671d8fmr17161385ad.40.1761606713566;
        Mon, 27 Oct 2025 16:11:53 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm9797130a91.16.2025.10.27.16.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:11:53 -0700 (PDT)
Message-ID: <b781c6ae49f6cf3834e345d7c53e4a54bd958bb8.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 16/17] selftests/bpf: add new verifier_gotox
 test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Mon, 27 Oct 2025 16:11:50 -0700
In-Reply-To: <aP4VTXG6n7XYnm23@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-17-a.s.protopopov@gmail.com>
	 <b0e59e59fbe35090809ccbe0b01d923212c789ab.camel@gmail.com>
	 <aPtltvv+WHPMEnNt@mail.gmail.com> <aP4VTXG6n7XYnm23@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-26 at 12:34 +0000, Anton Protopopov wrote:
> On 25/10/24 11:40AM, Anton Protopopov wrote:
> > On 25/10/21 03:42PM, Eduard Zingerman wrote:
> > > On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > > > Add a set of tests to validate core gotox functionality
> > > > without need to rely on compilers.
> > > >=20
> > > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > > ---
> > >=20
> > > Thank you for adding these.
> > > Could you please also add a test cases that checks the following erro=
rs:
> > > - "jump table for insn %d points outside of the subprog [%u,%u]"

I'm surprised this one can't be triggered.
In case if there are multiple subprograms defined,
and map has two entries pointing to different subprograms,
what other checks can catch this?
I see only the check in the bpf_insn_array_init() that will make sure
that offset does not point outside of the program.

> > > - "the sum of R%u umin_value %llu and off %u is too big\n"

Ok, this one is handled by map value read.

> > > - "register R%d doesn't point to any offset in map id=3D%d\n"

And this one as well.

> > Yeah, sorry, these actually were on my list, but I've postponed them
> > for the next version. Will add. (I also need to add a few selftests
> > on the offset when loading from map.)
>=20
> So, tbh, I can't actually find a way to trigger any of them,
> looks like these conditions are always caught earlier...

