Return-Path: <bpf+bounces-36939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A394F79F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FB51F21D72
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507EC1917D0;
	Mon, 12 Aug 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjLv1aPz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B2190686
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491842; cv=none; b=sN5dk+6DzUj2oFoPMkUmYWWSKUKblOEQB8EGmmRF8kmRKfcgZ/wLgopJiD3D77A8MZDNbImNaH5Bh7nepN8sAT03HXSEtTikEOPVBj5Ntf/GikYTc5EVhnbxyxu3PscWl6QT24E+U1+eB/T2bMWAtavvdRxRMCBPQGT+caBBh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491842; c=relaxed/simple;
	bh=GMF1Ii3gZrkm/mGNsfDHJko1+YJMbmWKdVCahWXdpe8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkF4oqBUBv81ie2XWbBUhcDEfBzKbK4nuAEy7YgxBeXel9ZU/ir3O0mv7NIDhVUtkMW4CBPcwKXfy1IpxUebVR/RJIxj+iaVPUgjjPEIoFxwPDQW/sml20wza83S1TZBDHvGidAOMoLzmVZccFrAsVzmn6Wtm88zyyXfYBK/nos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjLv1aPz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fec34f94abso39758105ad.2
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723491841; x=1724096641; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=49jxgzib0h4JEr2k9EJ0+wqDpoqpaufp7AXMPuR+vNc=;
        b=WjLv1aPziwXxDjb+qn7I+z0bacuk7X6aPLy8xn7wy9pAwzCgWrKVq9wbepcG3r2oAn
         Ixl8Jh4uiQeqbEwlKCkWzqbZAmnAXZPOjplDe7ZC3EC0/ZZia/huNVHvu2o0uwdFpJWG
         4aFB/uOg9cSBgBvWtyhpvjF7/jbEC0w4iQLdRTGq0VVdthFu5+DiSuKzzKZy0s4iec6D
         skvlRmHWNbPCpKo0aOoqvaYV0t26HM2lg5jRxCFpj+VM5I5kHajGT0Ydo0Dy4YoRBj5J
         HGJMYC2MutSO7cWMku1lIgWq1e2md5iVWoN6L9cOb2mRtbhwAkaVNxqj8erYXgtYctgX
         pong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723491841; x=1724096641;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49jxgzib0h4JEr2k9EJ0+wqDpoqpaufp7AXMPuR+vNc=;
        b=ejokLj1W1KquFOPm92ZHpZHQFl8v812okpETtr6oKGSMfEZMvcq3aig/x2/KN1i7Lx
         pmOTRyc5mMsxWXgbl1Fxac3O8BbZt73WD5wJsgGRO1dsP+lwP3RWvcczU+Pu78wcNb2C
         LrO3BY6lC8pHTBGFuabqQc+LIwMbWP6bOnFOrP7z1jjt1L1ak5ai1kA6iT8r4SRFO8dn
         cvTREPWPkLGtfugI5D93N8T9l10HmQ4MKiBszNMW2/yPy19ZAnhdtckIBf/+Jl94eWgX
         d0C29C/Ykalm6fcaQB/OkLAsTvsskfFcF2GWrEQqaaAx4/ysXJLMWd9+uAUww9d0khqw
         JfqA==
X-Forwarded-Encrypted: i=1; AJvYcCVEvC+KIz1F1Y7Q9lAVzDDjh6ixzHkPjFEDsCNFafDqdxdeE3ePQXfws/g/EmfYvD7ArlnhwGAYAAPe1usABTqkSh+o
X-Gm-Message-State: AOJu0YyA5LrHdQD9+aEg+wFX+YUfMNJldlK1/74Yp4keh/nGdr1QsW5O
	0zmzs6olpF1zDwIhBt3brFhnUadi6guMqpSRVZzltAUqwTME3Nbj
X-Google-Smtp-Source: AGHT+IEW2QZ5ySmI4AgkBOXiGjDC9fJUJevs7XJ9/X+0/braNhrQF6WWM79WX+JlxyOVjLlZ+6/43w==
X-Received: by 2002:a17:903:22cb:b0:1fc:5b41:baff with SMTP id d9443c01a7336-201ca1288b8mr15932565ad.3.1723491840828;
        Mon, 12 Aug 2024 12:44:00 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd12ebfesm602025ad.39.2024.08.12.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:44:00 -0700 (PDT)
Message-ID: <e1700911e1d36c40b471c4ec1b229eee50490949.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, Martin KaFai Lau
	 <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
Date: Mon, 12 Aug 2024 12:43:55 -0700
In-Reply-To: <CAADnVQJ2hFpT7ZxU8O36NB0YOq-ze96KJ0T=K3Wp1-qZU+0jBw@mail.gmail.com>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
	 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
	 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
	 <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
	 <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
	 <551847ff89db0df953c455761e746a0d80d3a968.camel@gmail.com>
	 <CAADnVQJ2hFpT7ZxU8O36NB0YOq-ze96KJ0T=K3Wp1-qZU+0jBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-12 at 12:29 -0700, Alexei Starovoitov wrote:

[...]

> > It does not seem correct to swap the order for these two checks:
> >=20
> >                 if (exact !=3D NOT_EXACT && i < cur->allocated_stack &&
> >                     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
> >                     cur->stack[spi].slot_type[i % BPF_REG_SIZE])
> >                         return false;
> >=20
> >                 if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
> >                     && exact =3D=3D NOT_EXACT) {
> >                         i +=3D BPF_REG_SIZE - 1;
> >                         /* explored state didn't use this */
> >                         continue;
> >                 }
> >=20
> > if we do, 'slot_type' won't be checked for 'cur' when 'old' register is=
 not marked live.
>=20
> I see. This is to compare states in open coded iter loops when liveness
> is not propagated yet, right?

Yes

>=20
> Then when comparing for exact states we should probably do:
> if (exact !=3D NOT_EXACT &&
>     (i >=3D cur->allocated_stack ||
>      old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
>      cur->stack[spi].slot_type[i % BPF_REG_SIZE]))
>    return false;
>=20
> ?

Hm, right, otherwise the old slots in the interval
[cur->allocated_stack..old->allocated_stack)
won't be checked using exact rules.


