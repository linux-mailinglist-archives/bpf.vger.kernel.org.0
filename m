Return-Path: <bpf+bounces-18005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18235814CE7
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 17:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3934282BE7
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE63BB43;
	Fri, 15 Dec 2023 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6Y6/Zbh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7A3BB31;
	Fri, 15 Dec 2023 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc4029dc6eso10204371fa.1;
        Fri, 15 Dec 2023 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702657370; x=1703262170; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bXFaUUiRsPpnS2Vp5CCTF+5PWB7QcTAd36YeqdDaGDM=;
        b=M6Y6/ZbhKE2sfdW34rrJ01McECRlyCJ4iplt7+WxA4j8FlgAUYQmAdnambb/3CkPkv
         owTLtOZ2H4DGneJL55gDrrFzPiA3mgCULD1wHgud3KnU8yGj7XHCTNWf6HJ43XuQZbud
         jQhDNY4LNz+bOhposBQSkul9VpQKcHagSe7ZsqLVZkuNifZTnMEjg48cV6NGoClTYjDf
         3cLYeW0l7LoON1+7oJ+aq226FQlBrtiATAF55qA+ym4JTXSl5HfY7ojf8SY7Vrd5cVqf
         MQpO4Hf/T6QXBesqjj12kVjeyji7WENj4AykDfWCLyOIjUlwmcLTqwSMpgkgGBH51V6Y
         vcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702657370; x=1703262170;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXFaUUiRsPpnS2Vp5CCTF+5PWB7QcTAd36YeqdDaGDM=;
        b=mpNe//a2ZEiNDLX8HHay9f08/EusdolMBSvjpvtf2SJQ6wEY03NLtO5LvmDjoHarKB
         luuCbgNlwZcrFaiUuNTEItDsWK+6aXBpmF/16K6Rs0VpmryUCrLXuI+vknbpujzMo9PR
         pvNNI9twYDrmPXwqtXR1HYHM2BAIdFX47yYKpPmfnp9Gpok8HmK6e6rezLJF1n3/inph
         OK0HBTYG9K+oAkPF4WEJ1rLFdaYs3Cd7deHaONMR2+2MQ3WJ3vNCr9ruiLtQzTWBKWuQ
         VUEhKZTrvtADSDIqRNi8jb7PFKpi4uoH242rL8h2NU/xY1PsWkDukqRXwxFlvNqZRU8I
         X8xw==
X-Gm-Message-State: AOJu0Yzag8dYQ4fC46g2nCXzMKr/Ruj0jWm4H57nEQFhbWnxwwxJdUQv
	VOe5wVOVL8am+zQWx0EWP9g=
X-Google-Smtp-Source: AGHT+IGEeaN1NyhSKnUg7SylUS9tSnMrXhgkhZZf4l4mgHJqjv1wNPe1yCaxDb2J5BBBPusTvtPe/Q==
X-Received: by 2002:a05:6512:31d2:b0:50e:154e:d7ad with SMTP id j18-20020a05651231d200b0050e154ed7admr2235331lfe.79.1702657369518;
        Fri, 15 Dec 2023 08:22:49 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id mb8-20020a170906eb0800b00a1de512fa1fsm10832774ejb.186.2023.12.15.08.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:22:47 -0800 (PST)
Message-ID: <149715b52bdd9ec9453a8a817d8339bd1a86a4f7.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hao Sun
 <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf
 <bpf@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Fri, 15 Dec 2023 18:22:45 +0200
In-Reply-To: <CAEf4BzaTTv7oP2vcfVYXjUnA958MqohkRDJ9J7qOCtGfpijROw@mail.gmail.com>
References:
	  <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
	 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
	 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com>
	 <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
	 <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
	 <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
	 <526d4ac8f6788d3323d29fdbad0e0e5d09a534db.camel@gmail.com>
	 <2b49b96de9f8a1cd6d78cc5aebe7c35776cd2c19.camel@gmail.com>
	 <CAADnVQ+RVT1pO1hTzMawdkfc9B0xAxas2XmSk6+_EiqX9Xy9Ug@mail.gmail.com>
	 <66b2a6c45045c207d8452ad3b5786a9dc0082d79.camel@gmail.com>
	 <CAEf4BzaTTv7oP2vcfVYXjUnA958MqohkRDJ9J7qOCtGfpijROw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 21:20 -0800, Andrii Nakryiko wrote:
[...]
> > > can we detect that any register link is broken and force checkpoint h=
ere?
> >=20
> > Should be possible. I'll try this in the morning and check veristat res=
ults.

{still working on this}

> > By the way, I added some stats collection for find_equal_scalars() and =
see
> > the following results when run on ./test_progs:
> > - maximal number of registers with same id per call: 3
> > - average number of registers with same id per call: 1.4
>=20
> What if we keep 8 extra bytes in jump/instruction history and encode
> up to 8 linked registers/slots:
>=20
> 1. 1 bit to mark whether it's a src_reg set, or dst_reg set
> 2. 1 bit to mark whether it's a stack slot or register
> 3. 6 bits (0..63 values) to record register or slot number
>=20
> If we ever need more than 8 linked registers, we can just forcefully
> some "links" by resetting some IDs?

That should work as well.
Probably don't need src/dst bit, as backtracker marks both as precise
when processing conditional jump.

You mean "just forcefully [breaking] some "links" by resetting ...", right?

> BTW, is it only conditional jumps that need to record this linked
> register sets? Did we previously discuss why we don't need this for
> any other operation?

Don't think that we discussed it.
Here is my reasoning: the range transfer happens at find_equal_scalars()
which is called only from check_cond_jmp_op().
I think there are no other effects IDs have for scalar values.
Thus, covering conditional jumps seems sufficient.



