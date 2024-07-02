Return-Path: <bpf+bounces-33679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80D9249D7
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320CA1F222FE
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80769201275;
	Tue,  2 Jul 2024 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr5YqUBa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9B201266
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955166; cv=none; b=aKx2n0Z0X9P1WcHhzPhb3bpPoRwTnloeP2/Keb3kVEFcl8JiRS45I03xB1Z+rcqt4bkY/HDcqozxoPE5Du7AkasunEIivZ/6RHCVTMP+ZEbAQZGshTMjIAHVixaPiqwUbvaK5QQvkPPZkfYQossb5KqQJ1iHY+qjXiPlTPRaf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955166; c=relaxed/simple;
	bh=yOTaqe0+zxKmsdERBYaoXpTv1MFG7Y95SY/RlUDvctw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=de1+vf/3VLSEL+AnxFwK6pD0gqiCUHPT/HMTGFJXkgjJNRESGe+jEFDaE78gYY2KCtQjO0Swn2IFlLXHrpEXufZPfwrJPDq599uhGgj4LE3MvIQ4b+K3ngQR+ILcrziljwb9ntkkDD+svNPOi1QLZZ2+a44p5TT2dmHf5apq1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr5YqUBa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f9b52ef481so24714505ad.1
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955164; x=1720559964; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yOTaqe0+zxKmsdERBYaoXpTv1MFG7Y95SY/RlUDvctw=;
        b=Qr5YqUBagfywU0tnXasRUBx43yj8Tm5jB/jqbC8YBX5o7wk65RfdRAnzdpVH+poGTu
         FCDkZvDyJZwOqMMfP8QTaQu3r3IaMgImDxlGe3OWPe4R6Srzd3umb8mO436ubdXvtznT
         V+OCpvBifnwIMz31IqNgjbLdTmANV6MNCBkFi9VYrPH83595jucvu9boYAQmItFOg6Q5
         1mPjrcUZibAlcHM2AY8VDbmDegs6RuM8KW5J+cl3xhwapYPrqpz1HYIb+r4uLehedorw
         qcxjM+796cISHh2dzGD43v4ofzH28rBX8kEST///8pd3ZAAA+gQ0jDvOPCLMjtmh3o9D
         fR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955164; x=1720559964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOTaqe0+zxKmsdERBYaoXpTv1MFG7Y95SY/RlUDvctw=;
        b=WnaAsv4A9ATf+A+zJukzRWk1ii/74KG/rLS/xlAXEeepyUv04QCdmXRxzJeZsmGqMm
         HyRcaDcq5Dc6rwZGwSmm0x1Xcl7CbBAsYCmDuT+d/RbGjPjuqzNdaLve534xZjKEN6N2
         TQW+bXmUUOincplCCEz4BV8LKnw0aUhIA4Zo0OdOhyxIAW7vG1GId3pogmRxyD7UY2b0
         cHn1ejhfNI8g8jlIJZM/pzRbL82iy5XYH5nPuiYHKJApZs9ELAWMCkGQdyB7wp9XkyYs
         rLI+bH7t1Qo+BX8kdiFHq1Hpw5azH/zB09qdFZs+lS9xUCiuNs3R2+DUlAayyBqXh4db
         /MfA==
X-Gm-Message-State: AOJu0YwgH6RMmdrEWN64JH0HidYE1u9B0vzB5vjuP5v8C8S85IGhImxo
	2NWv+rVRFU+md0m1S5vNeZvOuHzntRzB83vfIhgYppS0Z7dTaLpd
X-Google-Smtp-Source: AGHT+IHcamTUQBmqm25tG0anw3g2Ug04f86o6ehGC+DtMvFppa+mB6bu2WgcLkQODcg96W0P1FoYrA==
X-Received: by 2002:a05:6a21:6d87:b0:1be:c0c9:5fa7 with SMTP id adf61e73a8af0-1bef6103c73mr8817444637.15.1719955163876;
        Tue, 02 Jul 2024 14:19:23 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246ee80sm9029243b3a.69.2024.07.02.14.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:19:23 -0700 (PDT)
Message-ID: <f9577edf4ebf9c730a93d756553c4d9eb92b9fb3.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Date: Tue, 02 Jul 2024 14:19:18 -0700
In-Reply-To: <CAEf4BzZPyZ=HWDeYXwjS1q5C0pcKmtQ5_pt=hQN9P0W+Tb+L3A@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-3-eddyz87@gmail.com>
	 <CAEf4Bzb5JoeVAwO6krQPUWHyUad0ya5ivXWukfb+_wrWrs7H5Q@mail.gmail.com>
	 <806fe5b0940a8b3e60a9c5448ec213b23107e3f0.camel@gmail.com>
	 <CAEf4BzZPyZ=HWDeYXwjS1q5C0pcKmtQ5_pt=hQN9P0W+Tb+L3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 14:09 -0700, Andrii Nakryiko wrote:

[...]

> you are defining a general framework with these changes, though, so
> let's introduce a standard and simple way to do this. Say, in addition
> to having arch-specific bpf_jit_inlines_helper_call() we can have
> bpf_jit_supports_helper_nocsr() or something. And they should be
> defined next to each other, so whenever one changes it's easier to
> remember to change the other one.
>=20
> I don't think requiring arm64 contributors to change the code of
> call_csr_mask() is the right approach.

I'd change the return value for bpf_jit_inlines_helper_call() to enum,
to avoid naming functions several times.

[...]

> > > strictly speaking, does nocsr have anything to do with inlining,
> > > though? E.g., if we know for sure (however, that's a separate issue)
> > > that helper implementation doesn't touch extra registers, why do we
> > > need inlining to make use of nocsr?
> >=20
> > Technically, alternative for nocsr is for C version of the
> > helper/kfunc itself has no_caller_saved_registers attribute.
> > Grep shows a single function annotated as such in kernel tree:
> > stackleak_track_stack().
> > Or, maybe, for helpers/kfuncs implemented in assembly.
>=20
> Yes, I suppose it's too dangerous to rely on the compiler to not use
> some extra register. I guess worst case we can "inline" helper by
> keeping call to it intact :)

Something like that.

[...]

