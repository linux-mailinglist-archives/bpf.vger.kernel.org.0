Return-Path: <bpf+bounces-41310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE457995B97
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9358B1F25C58
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDE621790D;
	Tue,  8 Oct 2024 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrRDPL1C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13321E0DC2;
	Tue,  8 Oct 2024 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429785; cv=none; b=nc3iSxZYsP2aAk4ukNXSEg/JMG6w6z6YpVokm7tS32oKTfE5qQNHpCYiS9+FiQZ6om+KNnMMIazIQYzDjZeyQ2xmAkLO2RhpW74LfbraJnE4NpsyqvJznXf0S4EaJS0BVDBF+DMr7goSHj5Rlrdnv3DB3Vw6zyTkfNr5Wfm70Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429785; c=relaxed/simple;
	bh=psJWj8NmEz8rud9AhNt4JBzl5JH9mf8yUtQW9ZRp9wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e98gb7yLPkdpubFqXuG7hzvNWeZ+gL67vWxgRE/u/fvNbXw/bljBQb32/ecEn1WdMUY/7VznUKvuS8EERxo+/6TBHasQkjCj5FF/LwIxYwjHUAR6e5SvMBTFouKiz2V9rPbiCLMS6K7/lFZgTnQZ0GFpdZNhkRADG8HzCd6iin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrRDPL1C; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82ab349320fso257474139f.1;
        Tue, 08 Oct 2024 16:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728429783; x=1729034583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psJWj8NmEz8rud9AhNt4JBzl5JH9mf8yUtQW9ZRp9wo=;
        b=LrRDPL1CngynORxRxDe30/v8mUUIvceiD1qk2H87/XfjPPp6FEHoLlnxqXZPARGois
         wrLmI+Lx8pKvDlHwTTZ/uG9F/PfHlzOEdNjF5zjyEwb+WAwCqUCkA2oGvfGIO79a++k+
         hEkNbZJtz11qKAUk17BndqAK5osZJA5VsFNQ453P8WQLgjhF4VkIVrmR4IEnB7usZPPX
         FbasDlu4nK/TPbAbQRP+FY4FDWHroh7e6tFVhKqQNhF9WyFIyW43IdLaBwOOY1oOYG1P
         Nk5Xrwnh5suA0jeQ/AVj8kGH5mPw4BoeaRPK+3fxR3AgMw68iQofB0qiP0GUy3hU3n4q
         s9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429783; x=1729034583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psJWj8NmEz8rud9AhNt4JBzl5JH9mf8yUtQW9ZRp9wo=;
        b=YCx9xpV4i7w55tuKS8gy++d+xFcLi3hNkTamwAeXt3piE5O7NILmS6Cy+UtZqu7jTf
         ApMdn7qco6mRb0O649itJaVHjfq6pP+O30oCLBbcuoyKXahc98Psk952jnLBmVmAj2tR
         qVR4oTIahU/PxIb3R2VeWdiIRichRZ//YKh/4Ppm2Pw0DucA3pcmSJ8YWxowgaTrmLEK
         NringWUPVvjk5fVjKJrCvHKU3iL4SSW1d5gkRp8YtMhxEHRcIJzzGvdrZrVocbrfsblU
         viz3HsL52/sCjGR7LPhhx7VDZZ5R/EwZDyfWn7wWm7jG0nYy5AowAAXirRH7ecScjOGQ
         fVrA==
X-Forwarded-Encrypted: i=1; AJvYcCWFEtM2J3A/VOI5ZEIYXgw5oeqTcEm7yAEm15Lm5OYVhEVXBHGdLOOJ+Ae0McHxciZZpXFtDkbT@vger.kernel.org, AJvYcCXwKPI59nOKkBx2dG+TQy0QKs4zm1tqo+UHQ+bCzOm0UZVvVA56ryBYYwzgua9iAdubvH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUjtPzTNBXjyKjWET3ZfdF3d/fe7KLZal3O0Ikpq0eZzrgbXB
	78SOi34dHy//iagVivr7yDcWQCRsFC2GqmKKVDndkukWO3HBzTvX5txNfxtbhWDbSDTI778Gl4w
	VaPrOsZK19KzVG8OQCKFASGFats4=
X-Google-Smtp-Source: AGHT+IEQuAC+JInKKHAaocIa8SfikAGKlHdkTVZfrcbk/WaCYj9wp76m38cY7WGNg9K/GigGbxPLMTSjZrHowv8ocYs=
X-Received: by 2002:a05:6e02:17c9:b0:3a0:8ecb:a1dc with SMTP id
 e9e14a558f8ab-3a397cfc9f3mr5086225ab.15.1728429782864; Tue, 08 Oct 2024
 16:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com> <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch>
In-Reply-To: <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 07:22:26 +0800
Message-ID: <CAL+tcoBGQZWZr3PU4Chn1YiN8XO_2UXGOh3yxbvymvojH3r13g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] net-timestamp: bpf extension to equip
 applications transparently
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:44=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by using
> > tracepoint to print information (say, tstamp) so that we can
> > transparently equip applications with this feature and require no
> > modification in user side.
> >
> > Later, we discussed at netconf and agreed that we can use bpf for bette=
r
> > extension, which is mainly suggested by John Fastabend and Willem de
> > Bruijn. Many thanks here! So I post this series to see if we have a
> > better solution to extend.
> >
> > This approach relies on existing SO_TIMESTAMPING feature, for tx path,
> > users only needs to pass certain flags through bpf program to make sure
> > the last skb from each sendmsg() has timestamp related controlled flag.
> > For rx path, we have to use bpf_setsockopt() to set the sk->sk_tsflags
> > and wait for the moment when recvmsg() is called.
>
> As you mention, overall I am very supportive of having a way to add
> timestamping by adminstrators, without having to rebuild applications.
> BPF hooks seem to be the right place for this.
>
> There is existing kprobe/kretprobe/kfunc support. Supporting
> SO_TIMESTAMPING directly may be useful due to its targeted feature
> set, and correlation between measurements for the same data in the
> stream.
>
> > After this series, we could step by step implement more advanced
> > functions/flags already in SO_TIMESTAMPING feature for bpf extension.
>
> My main implementation concern is where this API overlaps with the
> existing user API, and how they might conflict. A few questions in the
> patches.

Agreed. That's also what I'm concerned about. So I decided to ask for
related experts' help.

How to deal with it without interfering with the existing apps in the
right way is the key problem.

