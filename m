Return-Path: <bpf+bounces-51082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348EBA2FF33
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA44163E4A
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE3635;
	Tue, 11 Feb 2025 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP2dquum"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCEB1F956;
	Tue, 11 Feb 2025 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234128; cv=none; b=IjIdGNu8re4x2bXZjQMw4DEq9cZaXnwFgmSfPng1B6n7pmeAgp9VUgAOlRBc7KKtgGZl4DIiGNll8hlivvyMglqULtilXsxds40b7xY912xIKLfq0PSqR6fEXRlR4gJyWM4XP1fL4yzgw350WPQVICWOYjboJj1ofZweYdzjxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234128; c=relaxed/simple;
	bh=kxXIj5fKLWK4js5lh3rSfV7I0TlaOhDceJTtsvtYSeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GfSfIdmSn/Vqha09cyx3z7lN34TvgtG7N+8CS3AUDwwa1TydlXnJKucKAe6yys5Zx5pbqn5eJeHTTfdxX2GW5SKiTaEu/Wwg7RXK9SS2SiwJgoj0qb2kdAEc/ykkPCSOhZBLMa93UW7RWQ/tgYQb9aVjA+nZXhO76yA3LiIy5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP2dquum; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f78b1fb7dso33044445ad.3;
        Mon, 10 Feb 2025 16:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739234127; x=1739838927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VxUDobe983gjq42l5etMnUQOudv1Q5z/oGZgl3Z73n4=;
        b=QP2dquumng9rypA5x+jHtJ/ZeEmgXudZcBia/nWOQuAmeiDXPcpr0mrtpuO/q5+27o
         zfh2pThTBZACR4K56xi871KJDoc7Jqk/rViMQfqcwMO+TiCpl9pe4I8M6O61OW0ttEga
         w23TgkznyZ/svqOvzNiQFAWKZXpMEuYFVdRMFU5Uzq67sAj2mdhSMYEgKBzJK9nsapn9
         t1Xh4loACRh+ROj4bH3S2cBv+nsTvALjLX03bVA7whMlWfSfOY6at1QS+Gc+J11D6D9o
         wIXBwncd9N7glafEhsJRvnNSPKRgkWmPKdiMIM6448qJMqUvoaeQDSCbg/uX/IPSDj8o
         3Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234127; x=1739838927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxUDobe983gjq42l5etMnUQOudv1Q5z/oGZgl3Z73n4=;
        b=WzLCqEYfd/yHyrI9AsRCUe+ut7iINmPy2Hc590plVZmPKrOYYlDZdOrDseeb/5xmSz
         Y+2R+aFrv5kDM5uJT4P7SUFD62YSZ0aE5IzCp+JYBEZR2/G6YI74gjuSIkRdNcRdnVFP
         7vE8FN7woVFdDsObR44qT9INXkSJD7KbQRKWqwyfQaGSVKBlGLJyStcU17pKl5KpCmSW
         mWL/x5Jogivu58I2//9KqSJCz4Pb2vZTFuSCKVQFiq0ChIkX4ShFYb1VbPplnfNQWItw
         C5nzTpgjNCSctl83+vyi1Sw49Q1KLE9zFlbzkpq3yGTIvjNqUKEN8sOq8NoLUwnVGPlN
         9YOw==
X-Forwarded-Encrypted: i=1; AJvYcCV48ICsl/dgc6cA8+9INcr141RQyv8CiIGKTwkxlLdbUS6s8tjo+W0XKNf+8LD45xo5q9k=@vger.kernel.org, AJvYcCWM1y7f6TeV60IC3j7DQJ0EmgXzGIftysigMvAVIcQxjSv/NuYC3qX082UTFPk9cQ7p1ZBDU8Zmyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGZA/G2qjsmzPdVbF8PSRuuSXST3W+edYsaDd8+BOnerboPH4
	txTYXSJc4CDXw+Ic49Lp1QbTXSrb38UDSGCVxUCHnyme7zuZO7Re
X-Gm-Gg: ASbGncuur6czLG016nVL7/bBXHwjKiFTe3kxvjO3xR5571EYkp7TUTqHFYZ1VI8FZQj
	+XdiOIn+xMpmixnczJaIKfbBh78/JTYlYHuT2B1rpml8cZYH0UldrxDFhAR6/MTMhxXor2E+THW
	0TgKap3f6FlqeSCpUtbsXiAHa7e6Ssx++UP9M3xn2SZeA70xs8DktxfBWbcodZfdCUMgB5pa+xE
	NUYvnNXlr0214J/PaP1bWz8ut2w6w9ZziKJi6oBIdil4ohELU8tT+sMA0dB51C4T6QE8aBnN2PY
	ib48pFhX6lak
X-Google-Smtp-Source: AGHT+IEsx0WcVCysC5AGZgMiPmqH2d5wj68nOmggL8XmpkyPaD56ix2CdPhqYrnBirZJQiUHylp7Ig==
X-Received: by 2002:a17:903:251:b0:21f:14e3:165d with SMTP id d9443c01a7336-21f4e777d88mr269247235ad.44.1739234126690;
        Mon, 10 Feb 2025 16:35:26 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c68asm85754115ad.172.2025.02.10.16.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:35:26 -0800 (PST)
Message-ID: <d54c6bf8e627b41e6628b2759de3acaf268590cc.camel@gmail.com>
Subject: Re: [PATCH dwarves 1/3] btf_encoder: collect kfuncs info in
 btf_encoder__new
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, 	mykolal@fb.com, kernel-team@meta.com
Date: Mon, 10 Feb 2025 16:35:21 -0800
In-Reply-To: <20a49b2ada87ce106607e1ca8c98a76e826dccd1@linux.dev>
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
	 <20250207021442.155703-2-ihor.solodrai@linux.dev>
	 <3782640a577e6945c86d6330bc8a05018a1e5c52.camel@gmail.com>
	 <20a49b2ada87ce106607e1ca8c98a76e826dccd1@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 22:42 +0000, Ihor Solodrai wrote:
> On 2/10/25 12:57 PM, Eduard Zingerman wrote:
> > On Thu, 2025-02-06 at 18:14 -0800, Ihor Solodrai wrote:
> > > From: Ihor Solodrai <ihor.solodrai@pm.me>
> > >=20
> > > btf_encoder__tag_kfuncs() is a post-processing step of BTF encoding,
> > > executed right before BTF is deduped and dumped to the output.
> > >=20
> > > Split btf_encoder__tag_kfuncs() routine in two parts:
> > >   * btf_encoder__collect_kfuncs()
> > >   * btf_encoder__tag_kfuncs()
> > >=20
> > > [...]
> >=20
> > Tbh, I don't think this split is necessary, modifying btf_type
> > in-place should be fine (and libbpf does it at-least in one place).
> > E.g. like here:
> > https://github.com/acmel/dwarves/compare/master...eddyz87:dwarves:arena=
-attrs-no-split
> > I like it because it keeps the change a bit more contained,
> > but I do not insist.
>=20
> There are a couple of reasons this split makes sense to me.
>=20
> First, I wanted to avoid modifying BTF. Having btf_encoder only
> appending things to BTF is easy to reason about. But you're saying
> modification does happen somewhere already?

See tools/lib/bpf/libbpf.c:bpf_object__sanitize_btf().
A set of small in-place rewrites for compatibility with old kernels.

> The second reason is that the input for kfunc tagging is ELF, and so
> it can be read at around the same time other ELF data is read (such as
> for fucntions table). This has an additional benefit of running in
> parallel to dwarf encoders (because one of the dwarf workers is
> creating btf_encoder struct), as opposed to a sequential
> post-processing step.

Makes sense.

[...]


