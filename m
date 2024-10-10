Return-Path: <bpf+bounces-41561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD525998392
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 12:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D945283A24
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472541BFDE9;
	Thu, 10 Oct 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDtu03AV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B018DF81;
	Thu, 10 Oct 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556286; cv=none; b=sRDCxy7zn7oI0mHyYhiDp/pcNFI0R9Kqp+xLh1X0Gv5R+V5VLqtc7k0m7S/fuUKWbA5PoPAqFUiqijrYKF9E5TbffeQVC+d4YFJ7qO20va82YkjQxZdvePAiFaZE2aJB6l7T92knqO+iCeGTvOzFKgmd1HnS4+BO4ccg1TTJKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556286; c=relaxed/simple;
	bh=C+R3quKQAACONYpfCvEEsIGDujowRhq/G5P9rbG4u0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgH6ZoOk86dOKGf54NTDP4XK+aALKC3ST7bP/LOU2FRKujoxWnQBJ/DZlUc3l4Kze2i7Uk70BPx/nW7ycEm0T2Dq071+CzkAfnVYVmK9C4MgK+QIDZ9Vre6kqSHqs2mHDXZuPehplWfRRSaIOFnptKPfr/VJRR8YUK356gwK1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDtu03AV; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e28fc40fdccso691749276.1;
        Thu, 10 Oct 2024 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728556284; x=1729161084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKNhb1nvZLLHpBckwNjKfJyhW0Ri+mcPrYZdsnjTA94=;
        b=QDtu03AV0c/WkIJyBkcNc9XVOEtU5GIEiazeMtgyh0tnRTzRIkv796hK14Ut207VzB
         /6hYuDPe9Ib3W4P1ZnDDLiu82svJRj5iI5Da/gI6bQafSrVw2HOKOWH/PlhJXb/mDcbg
         Ig/NW+lkwj4eKtHIlphr1O6PYcQI2ukN5S5XpsgOLoeWtJwNn/R/5hhwe64p0VAMwLUH
         F7AjpMKpOCf9bL/iQ+FzmhzV09PoWOELxPgtRq1udBRH1GGMkST1LqVOU6Oth+ryJNvx
         65n9Lk7ot3vYPmyfBBQ5wIo9KOZQ1Y709BKKsUK1RdGAq9zS78yBCdoYIwdGe9HxxlJ/
         2aTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728556284; x=1729161084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKNhb1nvZLLHpBckwNjKfJyhW0Ri+mcPrYZdsnjTA94=;
        b=hXRRzWyutoIbRJGQUYySyDLKAjc+s0N5wB8GbRA7mUlhNH6qBM7fxU4SvANgWKqWmL
         GbzCDTuGDu4zX7LUHHeukRXrEXEmwGi2/NivBF0NoVW7mCs6vB3B6PMr1oxV0eEcIPVe
         eB13Rsf0OwapUyoFPNGYJsV7kjwMbyYaWwikdtW7MdAmbnvaJVbd8ms4Z7DMnPYIz0FL
         LYePJ1hWtR4mrERRJEBsLacCTRTS1nXBFxMjwRRV6NLoOR13zfMnjZRrIM1EI6wVScBX
         5/VICaEOoh1xa9a3Ho697wcp8lKrqjYqD8Gyg4OXgvrtMpiEKCdzceS6/jpzsYS8MbdP
         TZpA==
X-Forwarded-Encrypted: i=1; AJvYcCUK7oT+RdW7qURPxG/5gd0+Tu2UagqA6DxPW33Tg0+qu8DCZltXHtVpYKtB6MfZ4H1aL9Q=@vger.kernel.org, AJvYcCV4Bif0aS8PWBZgzzQyjUOflGd4wzdJgFrVCBSu9eCuCfy8ubgZW9spIXZgFUmmb5Es1RaB/PH7@vger.kernel.org, AJvYcCVa70wqQ7Gq3LAbAiR0ireKs+PezF1QFiFBQ0uIqm4enEwk2XOTMGcYmBvgybTyTE+PkexzcRLAE7sqImkj@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+qP4l7tug3uaz1LndJS1dzq42koZ0ISDn0heATqVsnPBOSUm
	8plOMWn2AuOKvY6mgE5UjfMR6utxX9V/dpGgs8Rv+VDrMwCeEHZiOs8zp9An5BU9SQS0GhWtG52
	4TYu93IQPVrdteCW8Dssd1Wk9VcE=
X-Google-Smtp-Source: AGHT+IGHJd8gLn+Lonc754L1GSxm5wP1TN4ZAOzPICzVlYFF9trcRXtsd6JSZQmz4IzHDPvlaFPk8Y4Zl6BvC+Fsums=
X-Received: by 2002:a05:6902:2b8d:b0:e24:fea0:f9b4 with SMTP id
 3f1490d57ef6-e28fe40fdeemr5072145276.38.1728556284331; Thu, 10 Oct 2024
 03:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007074702.249543-1-dongml2@chinatelecom.cn> <3c2ad895-3546-4269-8e6d-6f187035f4b5@redhat.com>
In-Reply-To: <3c2ad895-3546-4269-8e6d-6f187035f4b5@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 10 Oct 2024 18:32:05 +0800
Message-ID: <CADxym3aEX7ujBP29aYTKVNmZwKbD82GpATXf_i9VnV51ixXD8A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] net: ip: add drop reasons to input route
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, kuba@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	dongml2@chinatelecom.cn, bigeasy@linutronix.de, toke@redhat.com, 
	idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/7/24 09:46, Menglong Dong wrote:
> > In this series, we mainly add some skb drop reasons to the input path o=
f
> > ip routing.
> >
> > The errno from fib_validate_source() is -EINVAL or -EXDEV, and -EXDEV i=
s
> > used in ip_rcv_finish_core() to increase the LINUX_MIB_IPRPFILTER. For
> > this case, we can check it by
> > "drop_reason =3D=3D SKB_DROP_REASON_IP_RPFILTER" instead. Therefore, we=
 can
> > make fib_validate_source() return -reason.
> >
> > Meanwhile, we make the following functions return drop reasons too:
> >
> >    ip_route_input_mc()
> >    ip_mc_validate_source()
> >    ip_route_input_slow()
> >    ip_route_input_rcu()
> >    ip_route_input_noref()
> >    ip_route_input()
>
> A few other functions are excluded, so that the ip input path coverage
> is not completed - i.e. ip_route_use_hint(), is that intentional?
>

Hello,

That's not intentional, I just missed them. At the beginning, I
wanted to organize the drop reasons in ip_route_input_noref(),
and things become complex when I do it. Let me have a check
and make the coverage complete.

> In any case does not apply cleanly anymore.
>
> Please answer to the above question and question on patch 1 before
> submitting a new revision. At very least the new revision should include
> a comment explaining the reasoning for the current choice.
>
> Please, include in each patch the detailed changelog after the '---'
> separator.
>

Sorry about that. I thought the patches for ip_route_input_noref,
ip_route_input_rcu, ip_route_input_slow are completely new one,
and abandoned the changelogs in the patches. I'll complete the
changelogs in the next version.

Thanks!
Menglong Dong


> Thanks,
>
> Paolo
>

