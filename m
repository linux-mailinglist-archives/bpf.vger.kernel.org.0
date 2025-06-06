Return-Path: <bpf+bounces-59818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BEACFA53
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD01899FFC
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4C5223;
	Fri,  6 Jun 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVyNlIok"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4392F2E;
	Fri,  6 Jun 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749168599; cv=none; b=kRfpxk0CSDKaMbq7nwELRLfnns0TVNrwK0+HERkAbNA2Ur+zghZj8hW7k575tZgmhpIoji84ZKzF7rfcn9pjWLyv84ydQWZNekVVvx1j8yL+nHCWoL4T1fDNEwn+GulMRvS1W87INJTWJbGn90bVOlVIwHyq5KDcJS0DZAUy6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749168599; c=relaxed/simple;
	bh=tGZsc8JM2HeXq59M5OEcIQjzggS9Wyn85So9Jv+3x4g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JMfwCQQ//dugUJGoiM2ak70KAbyq1yBd2QSjaskReSRSFHxE81rev1dWsCBTr6Gjuw/m9EYSYQdlzBXuxCXEJe6IbjpjrtKdYtRN4tHCGUSPjjE+No55MgENKLzJL+y6ZKHq0/5KryeEhkZs1wuwuTSdckEITZu8aXIYcnjWYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVyNlIok; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70f147b5a52so10482487b3.3;
        Thu, 05 Jun 2025 17:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749168597; x=1749773397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wm0b4kamn+LbKyyV0kC1vXdI1Ng2SfV4wmd4NVLl40=;
        b=OVyNlIoktB3mtfgOBVPwYKMPkb4LSe5X40kOqOtd80vU0aA3xYnAj9AUOwhN68kjR/
         Z90ypbER5msA1q0TsvsMJwyTx7tfk7nqWtlQvayvbXQO/z474sO0uen32lORDba6Fmkd
         CE850dymK5bXTonvWlEWB7wPFeYEUXNvP6I0l0L9e0wQItPg3xZx2NDMFBRKkRoId3e2
         T2nq3pVtw8wxrh7Z/uH5m/6D0AGKbsXNxHhJpSizmOaxgKodhLoBHw+1itcSqMYa+RtB
         P01p0IxQlwfOPd5w3Q9hDguWOu2INGZFUhVKCI59GBnZVFqUcV6h3Cto0EVPyzX1jTI1
         dyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749168597; x=1749773397;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Wm0b4kamn+LbKyyV0kC1vXdI1Ng2SfV4wmd4NVLl40=;
        b=J3/PNTI3MZbs8YNDPcaO0Vi0dhMV5VR5w5etMtzoNDYHuPFpY9MTCOY/EdMfCsaSJ2
         Qgjq70ebhR1FRo50iYfiPrXyDZ3IAU3eGk3xBFeHiK5L0xhiam2r4xap4s4ZIEBSGQy2
         b0cesSsBZaGTjhkrEoPAPAAJ7Qtek0K9euxIf71HD7Ek/ud2utAj6ogdyougBPjd81a6
         94t8aaX2afjI4Kal9Vv+j43Vo1gMkoqOQ9drMt88VNqZO4/Z8QGENxhMjmfUFbvEcfJc
         fsVEnBonnVfV7U4Cv289lmjxCEFxuKEov5Yr9ygoN+suR38Fxz2tM8YYOP5QhwT+NW6d
         Lhtw==
X-Forwarded-Encrypted: i=1; AJvYcCVcnQO1hGfJ/UQlohKhFCN7kzUB4z8u7b3IM3rHBkWhzzd8JzFLjKxBrueRaTDz7B/XfPNpYfnW@vger.kernel.org, AJvYcCXFvin1djjkCXETSRdvfg+vqjVhoKr5vFN19ZF7EpvRIFGew+H67iwGg4A0UgN3WOR0alY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ipaZyJRi3pB4FVnVvVHv62LXGI7Z9FSXYp56aWvYt6IVdvnY
	+2bdWGdGG0Kj5rtRg8N7f9nvUuQHGhKkUo6k9GBraF/IWnHVvucCG9lt
X-Gm-Gg: ASbGnct2CMzbY/pzi9gloNIGvFlUp60vaXJHum+GNFbN594Woo51G6y4CDnwvSvYjPp
	O0wOgCNhc+je0404iR6i4exGoupfd02V7WiUpPntQ1sQvCpwSyB9te2rnuCfjWSRBopZ7cWntm0
	vDcd4sAb35N16wm4SYQcGO06AteRsPt7/o249ieXLeIDArzrYdp3zDH4w4KE/uMN+tFl9RP1cDi
	onMjAMU+8QNwCrFZI6y1sdCj35beZQq5CcO85YVKJPJ9HKpz/1CT3VKa5NxrY2X8YSFuf5CL+6G
	WDmGyN6PVbsmHcc7fw/VNJlPO8Xkb0NrejL/GrvlDOfMfDt3MN9wGYFICA/7EXbwyk7A6qRXov9
	jprIx4ABqWB67IpOGeyWdqad9poTGjuLXjtGW97+dlg==
X-Google-Smtp-Source: AGHT+IHall2B+2ArctoBHAaDzZNU6U3mi4WC9aoh/CjGVtf8Z0f8NOOsOi16hmN8CsCtdVhHct2S2A==
X-Received: by 2002:a05:690c:f0f:b0:6f7:ae31:fdf with SMTP id 00721157ae682-710f765d3e8mr22176777b3.12.1749168596815;
        Thu, 05 Jun 2025 17:09:56 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-710f99e8f15sm693187b3.71.2025.06.05.17.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 17:09:56 -0700 (PDT)
Date: Thu, 05 Jun 2025 20:09:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 martin.lau@linux.dev, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 eddyz87@gmail.com, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 willemb@google.com, 
 william.xuanziyang@huawei.com, 
 alan.maguire@oracle.com, 
 bpf@vger.kernel.org
Message-ID: <684231d3bb907_208a5f2945f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250605070131.53d870f6@kernel.org>
References: <20250604210604.257036-1-kuba@kernel.org>
 <CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
 <20250605062234.1df7e74a@kernel.org>
 <CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
 <20250605070131.53d870f6@kernel.org>
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski wrote:
> On Thu, 5 Jun 2025 15:50:31 +0200 Maciej =C5=BBenczykowski wrote:
> > On Thu, Jun 5, 2025 at 3:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > > I wonder if this shouldn't drop dst even when doing ipv4->ipv4 or=

> > > > ipv6->ipv6 -- it's encapping, presumably old dst is irrelevant...=
  =

> > >
> > > I keep going back and forth on this. You definitely have a point,
> > > but I feel like there are levels to how BPF prog can make the dst
> > > irrelevant:
> > >  - change proto
> > >  - encap
> > >  - adjust room but not set any encap flag
> > >  - overwrite the addrs without calling any helpers
> > > First case we have to cover for safety, last we can't possibly cove=
r.
> > > So the question is whether we should draw the line somewhere in
> > > the middle, or leave this patch as is and if the actual use case ar=
rives
> > > - let BPF call skb_dst_drop() as a kfunc. Right now I'm leaning tow=
ards
> > > the latter.
> > >
> > > Does that make sense? Does anyone else have an opinion?  =

> > =

> > It does make a fair bit of sense.
> > Question: does calling it as a kfunc require kernel BTF?
> > Specifically some ram limited devices want to disable CONFIG_DEBUG_IN=
FO_BTF...
> > I know normal bpf helpers don't need that...
> > I guess you could always convert ipv4 -> ipv6 -> ipv4 ;-)
> =

> Not sure how BPF folks feel about that, but technically we could
> also add a flag to bpf_skb_adjust_room() or bpf_skb_change_proto().

To invert the question: what is the value in keeping the dst?

The test refers to a nat6to4.bpf.o, but this is not included.

