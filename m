Return-Path: <bpf+bounces-77568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C319BCEB4E6
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 06:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 393BA300BEE9
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 05:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93471FF7C7;
	Wed, 31 Dec 2025 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D57dx9Zw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B314F112
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767160078; cv=none; b=WoJPqspBq8hvCwOkK3RyXvKIYf/vb4erI1LTA6D7vpLtt0cS2cV4OeSuJXod5OqjyxwhAykbu32cAGXGULSnt/ikhu022ybXC+XWUrCQY49CqIl61QF3uZlHi9BQ/1pBFzjfN1r3LXui9NwqRYJWwJOxp7xExcOadBIRdRfRAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767160078; c=relaxed/simple;
	bh=XT4lKLzN/mlXoRn3Zme2xJPADlZpRYCGYC8OqVQIC+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MxH9Kgo6FXTXQtIyy3RC1mH503usDx99CqloIISmikuf76fuRxlHNVw41/AlqpJrsZiGpHfr1lNP+hJFh49h/0GKn3GxpbhDse6h14riOrfxkI4T1BMe4RpJ/AA+wQYKex09XyT6rxFMNA527QS6s9TJKWGnvYRqXFxt9Y2o+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D57dx9Zw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0fe77d141so115159925ad.1
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 21:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767160076; x=1767764876; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YfifKbblGCFCYbasTNhiIkAx1sxFNwP6iZLKfJIzOuw=;
        b=D57dx9ZwD2GjYDIZfxNFfY7B/ecyd49SfM8YyOvJDi9/+XQh2QxcqUtagYf5a40eBm
         tyIJC4jRMh0ppv+M4MTVOgIfTPK7PVXwor/05z4LOW1H1H6IVv5thawTa70kymzw2cAM
         c/oKUhT8uCAOsGb73YPEsrHxgXi2iVi/D+htz7RvS21kBU8v+9/8VP3CZ5BXGIEhrw5K
         rKoEG2ycgil5oCAZPH9DYlwYIWZgi8WDAXSzOFKvv++/Lw1Zt9o3sVMMT2HNYWrulKfN
         TIHpNDZ0DCppUNeDYFKe4Fnyo33fN+A1oKzq7LaWV/sOjdsfIWrDgpyZCItRTHI3aHaF
         a4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767160076; x=1767764876;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfifKbblGCFCYbasTNhiIkAx1sxFNwP6iZLKfJIzOuw=;
        b=LtKJYQbEN6FIdNuVPwVARuKs2s7VLQsFBjqhxWRp1aoxjBInDjaM8hgjr8E3oLjpb0
         s6ppAWkgllEJ1SeyDLxx9jg8CynslwN8XgfOW4nCjPWDe/K4vHNOneJnQXBOhSoBV5va
         f27ptR3jECdzf0lsEgNTMQfSIXAfdtuJ36zczVrEfs8RpbLc3sPKVEIGQbEFmP4QnwgR
         xU86G3UZk6Cw4bqRfYN4MZYUeCtn+qt2L2ngc0SziD7GHYtvqd5+ccAxof8KToEZhQdl
         BOAYfdqgpBcIlSUHYj/0K5qpRpq/E4Ug/9rGuRvF8uuKf+t5Dkx62VHZU8xOBigqzkam
         abcw==
X-Forwarded-Encrypted: i=1; AJvYcCUrIEhqzWqxS+ijP5H+2lLfTOFG8ilwt+g9xBAPuAMWrPsA7fLphMSUR+68MHaMOHh62lA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7iJiUwUdz3k74/nXIREehDCBX/ZsfE9P9NhuGvwScsvF2m3Tk
	se/8ZOaJ4oJaNQ94iYRB8trQgzLLMwjbMiThs4jAUqA8oFM5YfHvOFfS
X-Gm-Gg: AY/fxX6S5np9l2VedV+nU0A32hqFRLYsA0Sh1z/jroPN4QVCREubvXXjvvg1AjaC8OE
	iOQEjzNoHCnRwUSg/smn9bo9YOUXecAWYETSgmEe1Bqyzrv6JqMYjG0AMsycoPGNewEGX81A3Ww
	weiWpRzVUPuggJMPI7wA07kxmDl/A2XamrhN4Y+WB5pfK9YCwF/GVYHV3YXDcl36kxcOq7PLQT3
	q6GUYOCYmbVilOSvBycPUsplRL2ql5zL3gIWiAbSjUIqgwX4QPE12gdt0sP2lTFIbisDup7DZPR
	bc2LHJwyYhWBBbTJFgbLN/+/ivuR3VhNgdIn0o/L9HyBEwjmjCrfStgeT/Im9+zSu+XyymBE53z
	KTIlkwYqrWcwobdKQhTpuzEhHWBgXQg/Lr4uqNjdx8ok5A1Fpe8IQuWzNETauCOQXtXe5C5Guy3
	xvzIS8+WhO
X-Google-Smtp-Source: AGHT+IGgZVGk1E9+nDvwI5bFEM/D4QXv93W39qbj9iulLJ21if79gxuW1hrHcvanO1nylILBMYT3Cg==
X-Received: by 2002:a17:903:2b10:b0:298:2616:c8e2 with SMTP id d9443c01a7336-2a2f2a4893fmr351190265ad.53.1767160076383;
        Tue, 30 Dec 2025 21:47:56 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77359sm318294955ad.95.2025.12.30.21.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 21:47:55 -0800 (PST)
Message-ID: <48548c462733962bf415a568f52bb312af0ee1b2.camel@gmail.com>
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers
 print
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mahe Tardy <mahe.tardy@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend	 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Paul Chaignon	 <paul.chaignon@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Tue, 30 Dec 2025 21:47:53 -0800
In-Reply-To: <CAADnVQLi_qYzqprvTNT+fHp2WgC5uPAHBKAN6Rr6sAhLvRqjoA@mail.gmail.com>
References: <20251222185813.150505-1-mahe.tardy@gmail.com>
		 <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>
		 <aUprAOkSFgHyUMfB@gmail.com>
		 <4eec6b7605d007c6f906bf9a4cd95f2423781b0a.camel@gmail.com>
		 <CAADnVQLsJeSjwFVE=gcnVzh7HftDqZJM+xByr2cD6TRmTRGLsA@mail.gmail.com>
		 <62ba00524aa7afd5e1f76a5a2f4c06899bf2dd64.camel@gmail.com>
		 <CAADnVQLDfmLSuvXJFLHM=tOfViSvwPBUyGGZN8OhDP5dRy1_NQ@mail.gmail.com>
		 <95c33c1d3dc961011ce91411ccb0682323d0f407.camel@gmail.com>
		 <CAADnVQLi_qYzqprvTNT+fHp2WgC5uPAHBKAN6Rr6sAhLvRqjoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-30 at 17:11 -0800, Alexei Starovoitov wrote:
> On Tue, Dec 30, 2025 at 10:44=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > >=20
> > > that will make post processing easier, but print on every miss
> > > will greatly increase log_level=3D2 size, right ?
> >=20
> > Here are some stats for pyperf180:
> >=20
> > > Experiment                                  | Log   | Log  |
> > > Kind                                        | Lines | Size |
> > > ---------------------------------------------+-------+------|
> > > Print cache hits, misses and diffing values | 626K  | 88M  |
> > > Print cache misses and diffing values       | 618K  | 88M  |
> > > Print cache misses                          | 618K  | 87M  |
> > > Default level 2 log                         | 577K  | 85M  |
>=20
> hmm. That's not that much.
> Then I don't understand why you said:
> "slows down log level 2 output significantly (~5 times)"
>=20
> If the total output is roughly the same, how come it's 5 times slower??

That's an interesting question.
Double checked the log for the failing program I was debugging
(internal, hits 1M limit): 6M lines total, 1.4M lines are "cache ...",
so 20% instead of 8% for pyperf180.
Still does not explain the performance difference.
I'll check what happens using profiler.

