Return-Path: <bpf+bounces-23096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CEB86D700
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA12D1C20C6C
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26F444376;
	Thu, 29 Feb 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ROlb3vfB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E416FF47
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246953; cv=none; b=GlOFiw/dVZ5o1Ni/LhIo4aQkM1DCiUjjPiJGwivMfuNk497Q0gAWIew6L+7elNF6cjcbUyE9dNIi+3RR7IT5ZL16bWfNDFinQBdGLAfHmQ3bZNyLaRWHH5RuchjD44as9+aZGeiOd6MzEi66bzHNIsejtFQipy7jX/5SDPfhqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246953; c=relaxed/simple;
	bh=ygTmpByyMhxlPQGiSyreqYJt6mmhMLEUJZof6paMkak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcrXP7waxXm8xVeyzA34qwEbBUE0AHxIQTA9lmFFO22fD1SPEI3UfY8b6DAiGSlF5hwnfqQ9y8MsXfyZt0nMy9zSXQrE+2EkcxpAGBNDNB3rvJYeOWdgVJBLpG+XQo14cDJ744sD/444yhfd7P25/2z/oFbVq5JJUGIJLf6TAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ROlb3vfB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-608e0b87594so15552777b3.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 14:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709246950; x=1709851750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4nU5ez2SAozzKm4VgQinKC+OlAX5vTXbZ4ojo+A58g=;
        b=ROlb3vfB3njRyayHyZPjSnEe7W9QD9d75gM+ERhxipwKANrtLHt9YpGq1QO/HaFOos
         Jr0AEm5RBTh9TiqnVVdo0/nZYsH2px7Pg61ewovLkmZHD/W1NsYcpbz4H1H6NGJleXUr
         UuC6J8eNBKJ7rY0FIvvIcJ69ywVZwtkIYZwPg94R1MZfhJ2063839KmUfstpHkskEUOP
         2jIVtpNKAhaG39jayYy4F7RWdy8qoiHukJBZxdE/fvam0MssJgjG/s9rbrDix2Lm77m+
         NZmdQXot5KnZslZ8jv40JegZ2CBRoKfndYPCrGwfjP+R7gUSYr8atrKHCvHRbVUS63PR
         RrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709246950; x=1709851750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4nU5ez2SAozzKm4VgQinKC+OlAX5vTXbZ4ojo+A58g=;
        b=g65zBTAzbO3o3ni3aV4aFwEJ6WarqgbrwfXGQ2OB5UYFj5qsvS6+vYmQrtECHv3rcf
         1QVgkKVVTYg2F8KZsl1qRU7Z/3QwKA+A7CQLOHBdmmH1Mh3g8zAfqmNqu7KG3ofcDxPB
         ptlhrh7K8NQEUxz/Nr4GDrLIn5vBJfx8zfpJVoD8kUzK3YmuqHXFVZ1S4Q343Ho+dJ6S
         NN+ejWMARXfP+ozqlK0EBaE45Mfs8GPzQA7wcrQ42+wFbD1pdQs6YpQd5R5np/aYHkKV
         02sC8psxxmxVysV5ZTq2mSMWpZPLgqS5/CSo3dVG3FRakIfYSK5/lKgZUTXyeXBs11YL
         kyGw==
X-Forwarded-Encrypted: i=1; AJvYcCXYRUr0p0MPceT+mckI+OihF/PkzXFe2LFI+w0Ig4Iq5UwHQRYU/KeSIZFd3JetLEOyHg9pvdBr9XZDOQZ95Pmx1VP0
X-Gm-Message-State: AOJu0YxCUlX/77Ethxi23OJFpdmPvk1Fmr8ljrPe1uZdPJP5PXooN21H
	pzz2tCk1tyo0NfoMRuy8+YohTak0XZuuEdarQkaNfYSTCvv5ywxRgs25AEw/IYJHN2J2ueJ19uW
	Z8J5rj/dPzcR8d8tqZ7QKCeq/X2KpUBCemeGA
X-Google-Smtp-Source: AGHT+IEI/Cb/5bIETgQJIwAXqDgfDROdDJUXOhunysIYOOMPhE8IBkB7/3TVoz570IGz8K13hTTaq7THd5dCaCmyShc=
X-Received: by 2002:a0d:cb14:0:b0:607:d9fb:5144 with SMTP id
 n20-20020a0dcb14000000b00607d9fb5144mr469604ywd.13.1709246950348; Thu, 29 Feb
 2024 14:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch>
In-Reply-To: <65e106305ad8b_43ad820892@john.notmuch>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Feb 2024 17:48:58 -0500
Message-ID: <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
To: John Fastabend <john.fastabend@gmail.com>
Cc: "Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, "tom@sipanda.io" <tom@sipanda.io>, 
	"mleitner@redhat.com" <mleitner@redhat.com>, "Mahesh.Shirshyad@amd.com" <Mahesh.Shirshyad@amd.com>, 
	"Vipin.Jain@amd.com" <Vipin.Jain@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
	"jiri@resnulli.us" <jiri@resnulli.us>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>, 
	"horms@kernel.org" <horms@kernel.org>, "khalidm@nvidia.com" <khalidm@nvidia.com>, 
	"toke@redhat.com" <toke@redhat.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"victor@mojatatu.com" <victor@mojatatu.com>, "Tammela, Pedro" <pctammela@mojatatu.com>, 
	"Daly, Dan" <dan.daly@intel.com>, "andy.fingerhut@gmail.com" <andy.fingerhut@gmail.com>, 
	"Sommers, Chris" <chris.sommers@keysight.com>, "mattyk@nvidia.com" <mattyk@nvidia.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:33=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Singhai, Anjali wrote:
> > From: Paolo Abeni <pabeni@redhat.com>
> >
> > > I think/fear that this series has a "quorum" problem: different voice=
s raises opposition, and nobody (?) outside the authors
> > > supported the code and the feature.
> >
> > > Could be the missing of H/W offload support in the current form the r=
oot cause for such lack support? Or there are parties
> > > interested that have been quite so far?
> >
> > Hi,
> >    Intel/AMD definitely need the p4tc offload support and a kernel SW p=
ipeline, as a lot of customers using programmable pipeline (smart switch an=
d smart NIC) prefer kernel standard APIs and interfaces (netlink and tc ndo=
). Intel and other vendors have native P4 capable HW and are invested in P4=
 as a dataplane specification.
>
> Great what hardware/driver and how do we get that code here so we can see
> it working? Is the hardware available e.g. can I get ahold of one?
>
> What is programmable on your devices? Is this 'just' the parser graph or
> are you slicing up tables and so on. Is it a FPGA, DPU architecture or a
> TCAM architecture? How do you reprogram the device? I somehow doubt its
> through a piecemeal ndo. But let me know if I'm wrong maybe my internal
> architecture details are dated. Fully speculating the interface is a FW
> big thunk to the device?
>
> Without any details its difficult to get community feedback on how the
> hw programmable interface should work. The only reason I've even
> bothered with this thread is I want to see P4 working.
>
> Who owns the AMD side or some other vendor so we can get something that
> works across at least two vendors which is our usual bar for adding hw
> offload things.
>
> Note if you just want a kernel SW pipeline we already have that so
> I'm not seeing that as paticularly motivating. Again my point of view.
> P4 as a dataplane specification is great but I don't see the connection
> to this patchset without real hardware in a driver.

Here's what you can buy on the market that are native P4 (not that it
hasnt been mentioned from day 1 on patch 0 references):
[10]https://www.intel.com/content/www/us/en/products/details/network-io/ipu=
/e2000-asic.html
[11]https://www.amd.com/en/accelerators/pensando

I want to emphasize again these patches are about the P4 s/w pipeline
that is intended to work seamlessly with hw offload. If you are
interested in h/w offload and want to contribute just show up at the
meetings - they are open to all. The current offloadable piece is the
match-action tables. The P4 specs may change to include parsers in the
future or other objects etc (but not sure why we should discuss this
in the thread).

cheers,
jamal

