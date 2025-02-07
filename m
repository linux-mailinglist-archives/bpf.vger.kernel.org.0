Return-Path: <bpf+bounces-50706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D133A2B716
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 01:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE6E7A27D6
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 00:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9C8946C;
	Fri,  7 Feb 2025 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ/5o+f9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6F610D;
	Fri,  7 Feb 2025 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887810; cv=none; b=gVAiDyedBrDY/HotaQhSoZzMRb0C2fX7nNOAguvSklb7n2B1Q7VodgooVxY6SMYJ8oZRnjDCRbcUt4t0ftIW1MWZnkW/0RAAhwIW15lHgfjBL9YAKt6w+3fqoz4F2WWwVcmeqz9ZELfqQz4o+ZsDtZ6YN+pKLeipcb5YeIxafZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887810; c=relaxed/simple;
	bh=gJ9MBcElhxrxE39I/H4wr96XfYfKJdRa6rkloVebpm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zq68OBkye0+0bbkrvgNQFqKhvtctnt5eIiFHiyUclz5sGyOBRkxGRhIPoZjtnM3wOPjFdy1sDk9begWKSDofQQuM+IvBcnsi3o224l6g9n0M/226KdWQBO8xcJ1qruWt8VQ60L92XSUZ2w0LV0MLF28W5NmRVu4NhLb50L9oV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ/5o+f9; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844ce213af6so50036439f.1;
        Thu, 06 Feb 2025 16:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738887808; x=1739492608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJ9MBcElhxrxE39I/H4wr96XfYfKJdRa6rkloVebpm0=;
        b=OZ/5o+f9PFdePUd182YC6lTyjL21SWDhs9b1pmGIB6+d0R0KtIqLPAyYmBbV6eIRAO
         Q49Z0tzY+Uekb5o+dUDVVT1s2NRNgUwvGYj+eA0xyDJN3IHIXoTbnC95/Uvy/ATn68H4
         3tHSS2lV9TDks/kpdhk7O6pJ++Iu8As3M9ePLd27i7pAJhvpcymK9LLdU1vSkG8TSOUU
         c/QZPM3WfvR9QGLu8/R0AVRJkHRx+aflsh5lLj1vCUwiI+luAo2Bz+s7Yfil119w7oHs
         gkBG1n+a3htSsKEE/d+IJaQle/rtCt7E1l4N4tsxP1e4RYdCLGYhmM+0vewfceOm/q7s
         ctvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738887808; x=1739492608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJ9MBcElhxrxE39I/H4wr96XfYfKJdRa6rkloVebpm0=;
        b=tbNQjRDNTnDpJblJcKrK9ZvsNwfkVB29yIqtLUVfh5+sW13qdeAUobppd7bq49PVJv
         v6QjsOmpOP049VExWCR1wWBTztFZfBy4rHOIp2xjGluU+IuapCSiGQKt0bdOFQ+Kz7QW
         NMX1ipR08UFCxru3jrJ3fDpF/y9vekhux7B1190MpZahUZnX2OhCCK63Kn4ys5HGM6Tw
         H/JeQwTRKWzl0ARVOjGxBASWZZSBTxVGsqCqX8s3Zt0ReE0Ht48Q4UuorQIkbebBgkgm
         yBkMIdfr4f7L18JFqjQMxHZP95WlBEwErkER2eBHRtRTSmL12xBdFN19VdG5cz1f2qg5
         5hVg==
X-Forwarded-Encrypted: i=1; AJvYcCUFa0qq227+antrCUIhd1kmBUq8VEgGUCLbqGF6EuLQD4taTnxH+dsgX+imZ7AcT16xcpk=@vger.kernel.org, AJvYcCWj6VIn6yIiGrp08TYS0lKpYEIqM+XDD93aG4rG2axdbAXcERVl64WBw1GC1gCSFNFgRbwkzyZd@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQy9L/5feUcDdHQlrNla1q2cw/zMCJdnaDRaXKXcBl/8PMw9z
	nzmCtVSBJUQ8N2VVPIosOoVc3SG8NKzLkBUO9/SFMvZ/nw4zsEX47opcX4NKDMzh3P3grKsKrs6
	otcBPGBRW/rtw6Uxtsf5uzdQqjXI=
X-Gm-Gg: ASbGnctfeXzXbadPcJ0lMF6Z+I67Kc2FiXAfmQJtQ4pMLMlDSKBRUo4oojRi6q5VSjf
	roQyEc9mFrUUI0hohPAaEGBJsDG5e0VnMXnn9OQsCvZUEhuKuqrkrjLctHI01Isj+qVTLwwkz
X-Google-Smtp-Source: AGHT+IE7Os9+bysriCgZ0fOLwh/XcqubKwkhjgdytUb0dM1UITVQvsxrwBjNItCu/SVS0GcKWPJmhFfIIuhRIcJCLZM=
X-Received: by 2002:a05:6e02:160d:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3d13dd2c8f0mr9683905ab.5.1738887807772; Thu, 06 Feb 2025
 16:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-6-kerneljasonxing@gmail.com> <67a384ea2d547_14e0832942c@willemb.c.googlers.com.notmuch>
 <CAL+tcoDvCrfE+Xs3ywTA35pvR_NyFyXLihyAuFFZBA4aHmiZBg@mail.gmail.com> <67a4dfc57da27_206444294ab@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a4dfc57da27_206444294ab@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Feb 2025 08:22:51 +0800
X-Gm-Features: AWEUYZlp9bsfpRiPSVjgvIOfcl0Ur-BBupCnpdFsgiCTBXbVJN4DY7KeSSTqb-I
Message-ID: <CAL+tcoATrCBgEVTR_8q9_7AXn0dFZUzmtqRWRCZtQDsiu9sRzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:13=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Feb 5, 2025 at 11:34=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > No functional changes here, only add skb_enable_app_tstamp() to tes=
t
> > > > if the orig_skb matches the usage of application SO_TIMESTAMPING
> > > > or its bpf extension. And it's good to support two modes in
> > > > parallel later in this series.
> > > >
> > > > Also, this patch deliberately distinguish the software and
> > > > hardware SCM_TSTAMP_SND timestamp by passing 'sw' parameter in orde=
r
> > > > to avoid such a case where hardware may go wrong and pass a NULL
> > > > hwstamps, which is even though unlikely to happen. If it really
> > > > happens, bpf prog will finally consider it as a software timestamp.
> > > > It will be hardly recognized. Let's make the timestamping part
> > > > more robust.
> > >
> > > Disagree. Don't add a crutch that has not shown to be necessary for
> > > all this time.
> > >
> > > Just infer hw from hwtstamps !=3D NULL.
> >
> > I can surely modify this part as you said, but may I ask why? I cannot
> > find a good reason to absolutely trust the hardware behaviour. If that
> > corner case happens, it would be very hard to trace the root cause...
>
> A NULL pointer exception is easy to find.
>
> It's not a hardware bug, but a driver bug. Given the small number of
> drivers implementing this API, it could even be found through code
> inspection.
>
> As a general rule of thumb we don't add protection mechanisms to paper
> over bugs elsewhere in the kernel. But detect and fix the bugs. An
> exception to the general rule is when buggy code is hard to find. That
> is not the case here.

Thanks for the explanation.

Thanks,
Jason

