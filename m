Return-Path: <bpf+bounces-52778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE53A48667
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831681881956
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1381C8FB4;
	Thu, 27 Feb 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHAh/GR8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924E14BF8F
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676692; cv=none; b=oDr6Z4JMEYh0nBdkzyGW08SO+r9rV5vxARoqGql1uuPBi5HFtJ9vfZIbStEWnYnHdTMYPhAfQ1O3Chm4QIaewtNUTA96EFaQGlsRPmOrl/QppxDMR/ESKQeQYigRD9Cxyr+zJbTEzplGZBEioF3srUtyuyYqw4m1VLvTCs4+mMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676692; c=relaxed/simple;
	bh=TopmRCmQUMCvVMIixXtDxEFjsxClfrFqqb6lkGGPs14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1lVI9dvaBOuwgado/kaXe6JVPe4AJvvUut4Fg6w54zD3z7y/IMCBiNLHR4a0lNmlLNd14BxodPGItjkUE+V1RkI5cJf2CrH2pMQf7DY7/MkfXjv27zPIhoEvLtG/hwGXe0C9bbm37cg83ZdrFM+glz+h+WZON9C+joEmqqXcyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHAh/GR8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439946a49e1so8555765e9.0
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 09:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740676689; x=1741281489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TopmRCmQUMCvVMIixXtDxEFjsxClfrFqqb6lkGGPs14=;
        b=nHAh/GR8Lnqc1OjYva5DhIei88Ja46RI48RhhpIoE2xMKAZEZcI6ycWErAVVyrfiYy
         NC3ArMLqAY/QAvRLxgt+kyU47oSbSjZPOPT5aCxnEWJPYeQN4m1PoY5auvm2KEzVRWaJ
         6Su+hFUhU5E8OW818qn3hshmEIthnSPEYM3F6zkssQha0qtUAYBntDkZsoYn150eeKC6
         yKRO10bPnnnLbuaUJy7HfjbRARIk/rX2h+81tMYWhzYtX+iztKkPMkrkqFV249FJrJic
         8nBDSXpaxUAT0G9r3oxxmEyCBcUmnNwuSeF9ytLzm+cu/EIDHEUenbxtlIyMZKpLyWkQ
         huIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740676689; x=1741281489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TopmRCmQUMCvVMIixXtDxEFjsxClfrFqqb6lkGGPs14=;
        b=jzkic0Sw2IHZ/GL1Sw0+XdxD/imyvo7UKM0E8OTufafz6NLmaJbdqUqx94v2uCuu6g
         g5ysAF6dI6Nxqmpu59gcFrxdGjXgBVjaoQK0k9hUt06QImIeJRm0zteq073WO/PqGG0/
         uu/EExRTG4epFen1tq/NKMD/Vc8rxsiZ3CYyq5XhyTBKqeVGOP/ztkKxxlDOx0TnPxZM
         MhVlEJEA5XQAavM4q0weXxu2bf3W1nig5wWxvJgY9l9FcgstGdkXwkNtkCRV9P2y0uSK
         tUFvwIRoY3UE0W6rHcPcOXha6iPLTKTWBuRZoQz2eylfTQLU/xSyfwoeHiPYeV2PrdWj
         3Qmg==
X-Forwarded-Encrypted: i=1; AJvYcCUuh/0emZEuymyalUHigIuZRZRmMvDuEj5K0mkDm5Iok3/1p1f13Na30la8dG8bH1OuRr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJcgVWfKIL4ePA5f8y369hXWOrt8+0VPnWJpKJU3efq+OBKhu
	dPEC1quO2NswSzJmC3mKyoNlzRE0BDcwnuhPyu037pbTrqrlhlQFRCP3y528+9DsPQfT+0SkPzc
	od0ah0WH4Uk4koc1JzFjC5FT3REStlA==
X-Gm-Gg: ASbGncvPnXBJO14nS7iSW5d1pI2qNQExntpe559zyyqOOVcNKroXHLH4iQz9H6sQt60
	vWMQ+4dxOi8qk4HakUgWH5UKO4eehqmT8zjJ5om//KmBOZyZ0zCTbILG6M3rqHimoAky5aEIUBI
	Fzjabf49uJn6O2/GCSLTv4dJE=
X-Google-Smtp-Source: AGHT+IGaAzSv0YKXw2y2F8gVHanhXPzi5HV17i426ALuWCXW0NF9Om06OJJ4ldeqEyA9APRuuoft9ueZNK3JPuUOsVU=
X-Received: by 2002:adf:e7cc:0:b0:38f:4916:fc21 with SMTP id
 ffacd0b85a97d-390d4f9d0f2mr4570112f8f.52.1740676689019; Thu, 27 Feb 2025
 09:18:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727329823.git.vmalik@redhat.com> <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
 <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
 <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com>
 <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com>
 <CAADnVQLsnhsL2i_RnOBUSebO--yx_5Az1Ydr9QPb5WZCkmYQJg@mail.gmail.com>
 <CAEf4BzYt42A73kmg5=HWRiHj0H1Dr0WPQosmQLkBhgkkiw0HQA@mail.gmail.com>
 <c831b42e-30ba-4a19-bc0d-5346c8388892@redhat.com> <CAADnVQLhr+xOF58ppaySOjb6cMdsWEYhr_4ZLvQ-XDWXHBMgBA@mail.gmail.com>
 <e4bfbee4-ca5f-4496-98ed-60d24e402046@redhat.com> <CAADnVQKmEOLp+7p+YV0gS1z8ed+cLHK+BjMgt+rvhdUdJxPRGg@mail.gmail.com>
 <ce2f1357-7e89-4caa-8027-559b0d7ebf43@redhat.com> <CAADnVQKJr_Gmf1SjTpmVLSWaPi=0irza365_Jb2-3kOKhKULdg@mail.gmail.com>
 <CAADnVQLOq835yg2przDwvNfPNiJf4BW2Pczbj_Bf7Lfy1JP2ag@mail.gmail.com> <74dcffa5-9407-48fa-b91d-73cc7b588367@redhat.com>
In-Reply-To: <74dcffa5-9407-48fa-b91d-73cc7b588367@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Feb 2025 09:17:57 -0800
X-Gm-Features: AQ5f1JrIouF3ch79UB9L5IAac5KmhkcX0STgu1uu4xAuWBOmUxGvTm69bSTOSXc
Message-ID: <CAADnVQKiuLO8Faz6OA7y9nC7cvRUjvc3KJcoA+w5av3hmddUdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 8:36=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 2/27/25 17:24, Alexei Starovoitov wrote:
> > Viktor,
> >
> > Are you still planning to work on string kfuncs ?
> >
> > I think we more or less converged on requirements.
> > So only a small matter of programming is left ? :)
> >
> > If you're busy with other things we can take over.
>
> Hi Alexei,
>
> this slipped off my radar due to other priorities recently but I should
> be able to get to it in the upcoming weeks. As you say, it shouldn't be
> much work so I hope to get back with a v2 soon.

Great. Thanks!

