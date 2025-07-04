Return-Path: <bpf+bounces-62429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF88AF9AC0
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50CD169DA1
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26284215055;
	Fri,  4 Jul 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDP5t6Je"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FE2E36F0
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653741; cv=none; b=NarLnuQuMsQHVHqq8CxULqg1LfBEKvGHdAJ4paRNnn6CFakVUlwLFXB9AI/70D2yyOrp42+Fn1s3tM34+5zhXbS7BSIVCjqNDGtqJFMJY81RxKKeLCth4OnaJPmV1SwxRw5GlSJCQdoktxZBp87ZcOTB+L5LD3xhJyvqiJSzuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653741; c=relaxed/simple;
	bh=0czMw9yLCfRle4XGUTo/oS2FFHDaBrQ1vk5iKcWaMF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bn3tbo+jqD0U6AVUtBdnJl3zhiCNYLF+ZPTZZ7R728SRqlPVysY9JB6ABYp8NTYvsIdDZqh+4KX+JbrAyTVQrEvRGkoFuTu7zCkCJT+dQNGzGQoN2f2mzpilqVacgGsIXmHghx4lC2N0FtyX7dDKGixNuuGRUDxkK1iWpn8BlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDP5t6Je; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74264d1832eso1618309b3a.0
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751653739; x=1752258539; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pv9EqkRV67cYc3uVatsagxVk6zfGVVdgZI3wusIm2To=;
        b=CDP5t6JeKsI9UoSr0xyDKIx5cqhRW6c+5qgcqhgK1+K+RK5HwQKzF7PizkDwlfUtXg
         BOPkf6a8q0V3IhFZ6UhATwNsy7ep1W6dQBNUb2TWaUfznEZ+e/EvfLRjnkc8zMWznz8H
         MNwB6yN3mkP4Hq0MVkAEvVg41YfOUMxpT7jL52i/b1pnKw32DvW/BTTykl108S4NfCJX
         n4nZ/cCh43O6wvK4Kb7CvU2/W9SAJgDkFjKsXEftQs5yDb7t3WumICjIqvWgIUdIgIoF
         vZ50siOB6lEFnIdGjLRkAEWawdRiIx1JosHQ84cdTb2Sa2Dvy3+fuADTLuJ3UaF1ePnk
         Xe2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751653739; x=1752258539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pv9EqkRV67cYc3uVatsagxVk6zfGVVdgZI3wusIm2To=;
        b=WZR8y6rl/5/HfXhTZHTkL/1vUpvGU+y3s9xSZ3EZZN57t80VjYu/eP8XURo79r1uTM
         8nbrPcx2jBfdxyD6vcm0W8FKvB+sPrfXZlItShFlhfES7yQYcuWQ2eG3NYaYzDaXcLnm
         kJ21eqnrhHiE6eVEJ/G/yxa+KmEgmD9W/IqZ3odynVAleOAgksRj5b6fsDwCPWIzysex
         1P623TErctaDYwKtaY8FP6HskBUqTGG9iKvAc6QIDOlSNJAT929/jfSPtzdja0jiGvVs
         QPuFeVXMKMJWbECFEaIKTSVUruWyTYVgXikoFEMxy1pyHvjATJb49gRSIgve4eiXH1vx
         yblQ==
X-Gm-Message-State: AOJu0YyjzLLG0vY8H/wNmk/awdPDjIZ5vlrp3wgBu4V+a/PCywIz5rTf
	zTn2XOw7QPPQJV5p22NAWp7qDe/bEBwZirxzKCh5ub+lXRKUI45Wnv7gNnrZNCWa
X-Gm-Gg: ASbGncuk7MDFK9Mzzxg6VckC/BzCj9mCphgXFf7Z1DF7eS+X51V4X7nW/8AMhqLaYhJ
	RVqfHLK4ndgc4UrCat+yiS4imMXGvcLR70eJ7bV36I6pHxzm6pIwg6a/3Txa5SZwpAYulvmZvBz
	hV+haCbqsBZme9zvXdIXkXoMn0fqfPkm42xI0s/qUF03DgHGWLqtJWji/EYwJb7rfC3P4voWE6B
	FzNQrFBx8ZEQHmE27Uuna6b6fQA1youdLMvA+p7E0wOQd5pK3nQ8j0VhIIqm/v0Ove0Yk3k3Zqt
	SA9Fn2PiGTiAIbwqorpe8Cnt5dAyl6Y3erpXwT8XFRRjG7g4Mm1QGPIGww==
X-Google-Smtp-Source: AGHT+IFDVsxrtVUZnO2ZLNXMTAVe3gi8Qx/ZtLhUhsOQMPIsJBgLwsCGEmXjo6dvFkQO82w5oU+Cbg==
X-Received: by 2002:a05:6a21:7a82:b0:21f:62e7:cd2d with SMTP id adf61e73a8af0-2260ca2271amr5313252637.34.1751653739552;
        Fri, 04 Jul 2025 11:28:59 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359ec3asm2519575b3a.2.2025.07.04.11.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 11:28:59 -0700 (PDT)
Message-ID: <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for
 global function parameters
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 04 Jul 2025 11:28:56 -0700
In-Reply-To: <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
	 <20250702224209.3300396-5-eddyz87@gmail.com>
	 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 20:03 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> > @@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verifier_en=
v *env, int subprog)
> >                         sub->args[i].btf_id =3D kern_type_id;
> >                         continue;
> >                 }
> > +               if (tags & ARG_TAG_UNTRUSTED) {
> > +                       int kern_type_id;
> > +
> > +                       if (tags & ~ARG_TAG_UNTRUSTED) {
> > +                               bpf_log(log, "arg#%d untrusted cannot b=
e combined with any other tags\n", i);
> > +                               return -EINVAL;
> > +                       }
> > +
> > +                       kern_type_id =3D btf_get_ptr_to_btf_id(log, i, =
btf, t);
>=20
> So while this makes sense for trusted, I think for untrusted, we
> should allow types in program BTF as well.
> This is one of the things I think lacks in bpf_rdonly_cast as well, to
> be able to cast to types in program BTF.
> Say you want to reinterpret some kernel memory into your own type and
> access it using a struct in the program which is a different type.
> I think it makes sense to make this work.

Hi Kumar,

Thank you for the review.
Allowing local program BTF makes sense to me.
I assume we should first search in kernel BTF and fallback to program
BTF if nothing found. This way verifier might catch a program
accessing kernel data structure but having wrong assumptions about
field offsets (not using CO-RE). On the other hand, this might get
confusing if there is an accidental conflict between kernel data
structure name and program local data structure name.

Mechanically this would be a slightly bigger change,
as btf_prepare_func_args() does not record which BTF was used for a
parameter and always assumes vmlinux BTF.

> When I needed it in the past I just added a local new
> bpf_rdonly_cast_local variant that uses prog->btf for btf_id and moved
> on.
>=20
> Supporting bpf_core_cast for both prog BTF and kernel BTF types is not
> trivial because we cannot disambiguate local vs kernel types.
> IIRC module BTF types probably don't work either but that's a different s=
tory.

I can add bpf_rdonly_cast_local() as a followup, do you remember
context in which you needed this?

[...]

