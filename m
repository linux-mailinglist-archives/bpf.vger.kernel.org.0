Return-Path: <bpf+bounces-62432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA48AF9AD4
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A77E5A3C08
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8902C2AA5;
	Fri,  4 Jul 2025 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA3mESDS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B12BE04F
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751654262; cv=none; b=P31zwlvmYLubNCs6r/p5nWjWnnJ/gE46ZOzrOemZeO1N0JErGPWDCbTLp/s1NdaL1r/cm7oKjHUFLzBdmxXZr7IuBNqZXGACZJ3wqChB0eB4K1Rre29nQ+08KUkkCK7tn2hp1H5oN9dN3OKiniIW+fCLgF8TTZJNZ1BXe+6rfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751654262; c=relaxed/simple;
	bh=wgluX2fvCS07Uc5BrVATn4+QIhDs6jabNqDeb2CEsUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ium3UFZKUbayabUKCHctSLLML0sfHBHLRfVvlVjBwR+YJXpd2OI4yMbNa5fExi47W+0ndv59rWuRS+M09rpzdsAmZ8n2ostHG5IzSEAiesfS+blCbpcZKT13ufNKR5rZ4GrFOYwzWDC/h0S2zzwGUaQpyMaIb067h8H32o1wN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA3mESDS; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so245063566b.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751654259; x=1752259059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgluX2fvCS07Uc5BrVATn4+QIhDs6jabNqDeb2CEsUA=;
        b=ZA3mESDST3ev5CHyoqCQFNhEkwwOIRvniIi/gVPr28Abt0thn7KY7aHg8lngbFoa3d
         i1ZzGmAN8PmmAZv800Mao/3CRxrg4xbbBzou5BPtQuFI+Yqhy/vVDsrZOidkNux813+X
         x1kpFS3OX1pOSZkmTsEnUVgXxCNfC9SeHjBBzJNXKFQEj/aBEMosBRDHP3BTqs6wqQ2Q
         mcIBxltbzilWWPlV4Y6NqhLb6k9QotYI2RtR7EyrFAMMM0eDlT2O+Mn1exLSeVZAqCnv
         lgkaiPU6ZoaZp/MO/IF7HZT2pdiCvnFGU/+bRvJ4jxXszg/BTTCJUX9eX9E5eqH3F1FR
         C+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751654259; x=1752259059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgluX2fvCS07Uc5BrVATn4+QIhDs6jabNqDeb2CEsUA=;
        b=dR0x/JYVe6O4LB+jar6FxIM7dM71VM/q7K3+t+g5l2RllOwhG+gKEw+wsYyIDDJXuO
         gyvYD6G7cEo/m4FnkZOMuAXOJn1suEY5/nI9CLVMAbA1NQlbIjwvpJAxM+r1CaNLwW3O
         LyY1vqybplamr8OQW/r+pgRTjrWwXVV7jU3jjOgzUC3Nd1QvPtas8u1/RnEhHoByKyWz
         h+q/xLQreJ6A4NCtoLRLhpOrkvyI1dO403otciEVuVoR4KYAqfLS4c7GHnKJfsiw8IsO
         iMmBrgkTWFsQltmVCx7VlnzxX9nEtNPVBlW96PWSKDskOygS0mK0aO0Fw1xIIQMq58fc
         yzLA==
X-Forwarded-Encrypted: i=1; AJvYcCWsuEpGdornRjK9tPDnJsPFsSMqXIt8Aq/hi+778GkaOTwUgfROMD4WxXuKFsuM52ozgtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHyiJYOCWdGUkV9d7DuBaskfcGW60DEkwABsiDllonwIA1AL9
	B//Yhwsf+TZuJMZViHWE9ukdkZN4491g/K0CBY3d83oGY8AA60IGvONqkJp86gKngB+v8dsf67G
	uZ3+04MH9sYg7aiPTJQTitcbbsmRIUYE=
X-Gm-Gg: ASbGncsRq9ATM8zigwzRO6Js7gsO6J7PWvOM3qE5y1ENo10+jvM1+RMqroQyUdqTNNf
	bUzJWWduNdExMV1RrhfEpCWpWGLC0wI9OAXcN7G2/7BhojW7fzCUhQ5xK8pAJpqG0Dp+SUG07nj
	D+RC7sPD3m2IIYAZrvQjhqh/jYCiLLc/5sWh0JFIKOnIHC6LoEpq+W3n1ExtcIClebKbRThv9Ys
	E9NW+lR9nrRKQ==
X-Google-Smtp-Source: AGHT+IERsWgs/BNiznFRaPF93Ndv/mPcQORLL2pFU92wbigAdlu6Cg6Q2nOd9PdmopTj1P16zBcrz2DrHMEbfX3m+LI=
X-Received: by 2002:a17:907:2d0e:b0:ae0:e1ed:d1a0 with SMTP id
 a640c23a62f3a-ae3f9c05985mr474734066b.8.1751654259299; Fri, 04 Jul 2025
 11:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-3-sidchintamaneni@gmail.com> <CAP01T74u=EJqDEyB-gEsmRGqMF=TRPY+cb_eUHNVY3hr3OWYvg@mail.gmail.com>
 <CAM6KYsvaPFHqdb-ZW+Bc_-N_VhJix8cQEvBbRo+pE_cBs++PPg@mail.gmail.com>
In-Reply-To: <CAM6KYsvaPFHqdb-ZW+Bc_-N_VhJix8cQEvBbRo+pE_cBs++PPg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 20:37:03 +0200
X-Gm-Features: Ac12FXzIjvvpC8ddpXDxjg90RAwyvvIRQpuzpUgIPK9HZNpTTsNEvgdKtxEY7sM
Message-ID: <CAP01T74b7NsWicbTZSS7s9aky0TNP=JYCwCCY=xBjS_ay_y7og@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Raj Sahu <rjsu26@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, miloc@vt.edu, 
	ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 19:32, Raj Sahu <rjsu26@gmail.com> wrote:
>
> > The parts above this function makes sense, but I don't understand why
> > we need programs to be cloned separately anymore.
> > Instead, can't we simply have a table of patch targets for the original program?
> > They'd need adjustment after jit to reflect the exact correct offset,
> > but that shouldn't be difficult to compute.
> If we understand correctly you advocate for storing the state of call
> instruction offset of helpers/ kfuncs/ callback functions (incase of
> bpf_loop inlining) and adjust the offset during JIT?
>
> While we did think about following this approach, we are worried of
> accidentally introducing bugs while implementing offset handling
> either now or in future when some new JIT optimization is being added
> by someone else.

That won't be as big a problem, the JIT keeps a mapping. As an
example, see how I did it here:
https://lore.kernel.org/bpf/20240201042109.1150490-10-memxor@gmail.com

You can keep the table of instruction indices until JIT, then do a
pass to convert.

>
> We also thought of decoding JIT instructions (right after JIT) similar
> to the runtime handler but there is an additional burden of figuring
> out the helper/ kfunc's from the call instruction.
> Currently, the cloned program is simplifying the whole task of going
> through the weeds of JIT.

I think the above should work, so all this won't be necessary.

>
> > IIUC you're comparing instructions in the patched program and original
> > program to find out if you need to patch out the original one.
> > That seems like a very expensive way of tracking which call targets
> > need to be modified.
> We can avoid this overhead still (by creating an offset table right
> after JIT) so that the termination handler becomes faster. However,
> since termination was itself a rare-case end-of-the-world situation,
> we didn't consider having great performance as one of the requirements
> for the handler.

It's not really about performance, but rather about extra memory
overhead per program.
These days we have 200 or so programs at any given time on production machines.
Can be more or less for other users, and the footprint is only growing
with every year.
They are loaded on every server in the fleet since bpf is "always on".
That's millions of machines.
This would mean we double the current memory footprint of program
.text (not just bpf_prog struct) if we kept the current approach, just
to match patch targets.
I think it's not a good tradeoff.

