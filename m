Return-Path: <bpf+bounces-53878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA62A5D56A
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 06:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614E63ACAC2
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 05:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69741DE4D8;
	Wed, 12 Mar 2025 05:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3oeon32"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF71DE4C2;
	Wed, 12 Mar 2025 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756426; cv=none; b=qwWZXaaq8mpfFV7J4EemOb5Che/0hwmvAneMUP+iWCpRJ4gvMyWHnaaVBe8oaKTHhRi4jvFwnapkuqAH6IuvcyxiFaWukHan/PpQho6/uoPA/CiiTFWMOiS8Jcc4ENnT/KEqFw9M2kk5ozRTVogOrg4VYiNnYh/HvrFnfdMeSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756426; c=relaxed/simple;
	bh=hT+nizR2JJLn0gMJ10bh2dCViJm/rjz0epeQTG0kmhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhfA/1t2y3223nZmUjX5gOyih0CpkPjo6r0NZT4WK7IcS4zh5LLsJxb5ZF3A+4a2K462dWG3tdt26CQJegq++XfodcfweYxl016T54HRUOWiA1c7oLEGp41YFl6rU/7sqwXfGOn8I5xX1QyyQZm0uLT8Ct/O3D0AceNVVTR5tfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3oeon32; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so17465425ab.2;
        Tue, 11 Mar 2025 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756424; x=1742361224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT+nizR2JJLn0gMJ10bh2dCViJm/rjz0epeQTG0kmhk=;
        b=e3oeon32nxTlLDA5WqKwxoXO6YIDBbfFy7PP9e/vFBCovvBUKwm0pR9FvaLnXr0vHe
         7JjgK85tCv9zCbod6YHBI2p6V5L6JmS/WuewcesxNuNOHqobdp7JSD/Iq9CQGOSyNDEr
         dZzL+4VNrI5PBh/uSdaiXl8hmECN6YTYmRHOu//oW2L9dSuul4nFsQs4EaYExTYEE3Jc
         5CA6fnvoW1FRnMxT9L30ZEOdS3jxd6RgQql6Hqb+TNRl8a+z0zggbJFT5UqSI36t1/AB
         wWfCc6lP7mbwPV6tVVeqFJLdlcJW3V1jtmjxqroOHenJu/HootmWCq9tbUX1T8Q7gtYx
         Z3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756424; x=1742361224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hT+nizR2JJLn0gMJ10bh2dCViJm/rjz0epeQTG0kmhk=;
        b=aoJ6p8aCUnuX5jHkgIevl+p35uVXatdJ5ok8HBIYJIG4tmFISgztWAwCdpANn7PDG7
         /f84aeBUsON33K4gTOr4Hwcf/qamqsJJuB9Ne8CEsc9ycZq/Dnvb3fxKG9FMxGSB8PZD
         aIvG4TTYrQAKyPLYkUJD+iiKWgk9QmNYkDfGeMoqs2BxB9CdXIVjZWDNwVPNPD23RBMk
         9gyPdz1gBYejl8WUWx8SX+jswrjgjc0RU4cJVRDwAfHJMpelthkLjkuWYcUU0xmKNaGd
         QXOJa1hoL2Ie9tRPrWDEuX9YleTePxMK29JJbaGszEdqycmP51rmjhF4FZtoMINxXGMw
         y/jg==
X-Forwarded-Encrypted: i=1; AJvYcCU/yTKFhwjHeoN0FpR6PW8t74lQn6a6yybiM25n9SdzsSr+/Id430chyyHkcs9knMlf4xw=@vger.kernel.org, AJvYcCXJj2aoIoPShj1rJr2ndeVKrLEzGmlXWjK7p7rw+1rw4e5OLi5WbxvoYvYmrgpBFgtHZbWWGc5O@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFVYisH6jaR3V4rIAXwf9rIbEfdUzRrnT2v2R/RoQRJ0ptBtX
	z3nSyg0Zuf+p+wUf+eMXOFsfw5gTfY/m5tq9k3qSFbEQFkzIoKRUw2w/iUx5qktgW+4n8ZIULh3
	ZLlms4mPZ/PhcNw0F9wx4PN3PH+o=
X-Gm-Gg: ASbGncuWvjpdYzamUK1vIyzot29UgkzRTWB12JakejQUwII1Km7JlSNkpe7EHmEtpyr
	LkikoTGKdm6OUIVxfgxtZBjKvU90sb8eFLc7JRZJGXSGc8FVxOKxvvlJOpD17xJmO8H5vOwHP84
	BXL/6whA7TdZTjeu9xia9dnymrfVt73hwqIqM2
X-Google-Smtp-Source: AGHT+IG3x/noPe+fqGsBmXrPkhlObY7p0iVWONfkQtpn/SR7q0vx5J/tmtIKGG1MjQEK1aZMGuKSCBMK1VIDINBTAEg=
X-Received: by 2002:a05:6e02:1688:b0:3d4:3ab3:daf0 with SMTP id
 e9e14a558f8ab-3d4419b2b34mr196109735ab.7.1741756423981; Tue, 11 Mar 2025
 22:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311085437.14703-1-kerneljasonxing@gmail.com> <CANn89iJQ3D=Zad1UsqgL=GhfxF8TxiwHgWvT=xchm4scatgbWg@mail.gmail.com>
In-Reply-To: <CANn89iJQ3D=Zad1UsqgL=GhfxF8TxiwHgWvT=xchm4scatgbWg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 12 Mar 2025 06:13:07 +0100
X-Gm-Features: AQ5f1JpLkJGjThyfWIOH5wsC2PzgH0hzsQj6F7ieuShvA3SmFmYjn4rDNafd3Ro
Message-ID: <CAL+tcoB-i1sHWCi53c+keiAF1qeL9uNQH+u9QZFgcwO7bF8qbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] tcp: add some RTO MIN and DELACK MAX
 {bpf_}set/getsockopt supports
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	kuniyu@amazon.com, ncardwell@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 5:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Mar 11, 2025 at 9:56=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Introduce bpf_sol_tcp_getsockopt() helper.
> >
> > Add bpf_getsockopt for RTO MIN and DELACK MAX.
> >
> > Add setsockopt/getsockopt for RTO MIN and DELACK MAX.
> >
> > Add corresponding selftests for bpf.
> >
> > v2
> > Link: https://lore.kernel.org/all/20250309123004.85612-1-kerneljasonxin=
g@gmail.com/
> > 1. add bpf getsockopt common helper
> > 2. target bpf-next net branch
>
> Some of us are busy attending netdev conference.
>
> Please split this series in two, one for pure TCP changes and one
> other for BPF, and send it after the netdev conference ends.

No problem. I will handle the BPF part first.

>
> It is not because BPF stuff is added that suddenly a series can escape
> TCP maintainers attention.

Oh, it is obviously not my intention :) The netdev parts are
definitely needed TCP maintainers ack for sure :)

Thanks,
Jason

