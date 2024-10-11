Return-Path: <bpf+bounces-41721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B6E999CD7
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 08:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B4B1F21F80
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378FA208997;
	Fri, 11 Oct 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WykoIgtS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398BE199FB9;
	Fri, 11 Oct 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628933; cv=none; b=i3LV+mJE1dg88Z3ykOCIyRNd/pyFp4DgakkajEWzCG1N/uyczwkhboaXzp/O8INvf70+NreS6X/equ25SLaAxe+H2yF53GENGOkD4VJG3W9BBVTgSNwNWnUgOW25Gz9qsu8RG5Tb4jJPux/vFuNRTqW8e4fyq3jDdZluCAEo1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628933; c=relaxed/simple;
	bh=rTU3z5nXZ0203U12sB1J6Lev02OVO6OGTj84QaOG73M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8FIXMLgJYKS3SFbnGx6UuO/XmzXOpuEAcmr2XRpkoYZf6TWP1Dq0msWq2IV0HwBrn6wzXwP8Pp82O09+bj3X5gXbXVJ+qoCuZSMDQUWjYH04yNjpP8A7ziyBaYb7/tKn0TvYK+q40MbI1JTDutj+xoFytcsAJ44JVJO28PRxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WykoIgtS; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6e34fa656a2so1880927b3.1;
        Thu, 10 Oct 2024 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728628931; x=1729233731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVhuLsogfUzSYpWHUkggflusdlhQlsEWtOFwPdr5aPY=;
        b=WykoIgtSugMAgD8gJOoZyVWORCDf8X46OFEeFCFHpiwQm+lRDoz7TgdAIZtx25vbTO
         skHg94ykXZJbNhJOZ5731YrTt7/irTfnIqEMadyRbMkwd2Y9zvDDouJtgpECtewCHZGp
         iN71VckEk8PkTG8thuwA1rDs+E74AMBo3l7DbHBmMWtwg5wwOMxNHYm5rgjLaMEEFbxL
         Q6l6sEouLH78jaGkhZcNkaadV2mrL+HdlfJ3Kd3rAIXEiiRVt0wKIRj1QtwX7S4KLTTF
         hMIZoUgdwhLHnRNQPJY+/Th1wvgJip7oigRyIA1VpVJkSedf91yWw1QeLfYgpxclSgbN
         OM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628931; x=1729233731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVhuLsogfUzSYpWHUkggflusdlhQlsEWtOFwPdr5aPY=;
        b=wS36o6a55KXiEy28LJm3xKHxpB5tifvvhgoPoBnriZ/q/ayxoQvSPqH974t0ifukcg
         V7YTgqhP0nIWxAn4gQEMd9PKeTVRJtZ5qpit6WTYXjaxTiAdQXc1lmFeZ76I82fSIsDj
         9lD+rN9f03p0fmOPji8Ihqd6299r4mjvdLTj4tnGSYRKMOy0DU7pF2E4M0E2JIxmIFdZ
         S6ZEuhdGueXswq5XHkIXcVV+1G7bz4+z0uM1EgDQpmMhYB5rp6oVnIs7xaxDyNss1xr9
         w3KQuSJNBzONSWttN8yXdVvYOg5+Z6Ogx5LanIEiXI0utzVc/ADwuECdyxZXsQT3Rgu8
         tn5w==
X-Forwarded-Encrypted: i=1; AJvYcCUasYVsApHTe4bOjZNIipuxaEmd9EHJ147FMlI7dMdqDxq15rS2hc50WLaJIpR8qtN9WFg=@vger.kernel.org, AJvYcCVSVBPs2+bGuv+d78PxWTo7KfreVsJ5FstTfKzWArFUhKRE/FH9ktL6Iw0+5JG04feXU8aoUZ/c@vger.kernel.org, AJvYcCXep4mthh9uB4jg/jzZ5Z2nw3gjyV5dzSh3SKobVmLsw3Vfg1jjTv9rYbSenrRjdvyvkA7sxnJc+zTDZ1b4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nHN4ujwh2TxNB5DxHjd36M6FBfjnjhdTbtXwrkt/zZQxTdRA
	w+OfRuRrR8/D58gtc2TQ96BcqxMfxm9K9lH4iq9GEmEWYfEO7Z6L1eD2UuVo5aI4vwHAMbDzi4D
	KuwxUP7xHXijNUyEPRA53iFS5C/c=
X-Google-Smtp-Source: AGHT+IGsjrvTm/ajEWNecyoWQ9v/ap1xzqKOckWzZqAyHc6KxoFC3fryNMajDXN25+sd4N5fKXWl0LfWyL51t+GAZa8=
X-Received: by 2002:a05:690c:670e:b0:699:7b60:d349 with SMTP id
 00721157ae682-6e3479b94d3mr10877237b3.11.1728628931231; Thu, 10 Oct 2024
 23:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
 <20241007074702.249543-2-dongml2@chinatelecom.cn> <7caf130c-56f0-4f78-a006-5323e237cef1@redhat.com>
 <CADxym3baw2nLvANd-D5D2kCNRRoDmdgexBeGmD-uCcYYqAf=EQ@mail.gmail.com>
In-Reply-To: <CADxym3baw2nLvANd-D5D2kCNRRoDmdgexBeGmD-uCcYYqAf=EQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 11 Oct 2024 14:42:53 +0800
Message-ID: <CADxym3ZGR59ojS3HApT30G2bKzht1pbZG212t3E7ku61SX29kg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/7] net: ip: make fib_validate_source()
 return drop reason
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, kuba@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	dongml2@chinatelecom.cn, bigeasy@linutronix.de, toke@redhat.com, 
	idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 5:18=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Thu, Oct 10, 2024 at 4:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> >
> >
> > On 10/7/24 09:46, Menglong Dong wrote:
> > > In this commit, we make fib_validate_source/__fib_validate_source ret=
urn
> > > -reason instead of errno on error. As the return value of them can be
> > > -errno, 0, and 1, we can't make it return enum skb_drop_reason direct=
ly.
> > >
> > > In the origin logic, if __fib_validate_source() return -EXDEV,
> > > LINUX_MIB_IPRPFILTER will be counted. And now, we need to adjust it b=
y
> > > checking "reason =3D=3D SKB_DROP_REASON_IP_RPFILTER". However, this w=
ill take
> > > effect only after the patch "net: ip: make ip_route_input_noref() ret=
urn
> > > drop reasons", as we can't pass the drop reasons from
> > > fib_validate_source() to ip_rcv_finish_core() in this patch.
> > >
> > > We set the errno to -EINVAL when fib_validate_source() is called and =
the
> > > validation fails, as the errno can be checked in the caller and now i=
ts
> > > value is -reason, which can lead misunderstand.
> > >
> > > Following new drop reasons are added in this patch:
> > >
> > >    SKB_DROP_REASON_IP_LOCAL_SOURCE
> > >    SKB_DROP_REASON_IP_INVALID_SOURCE
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > Looking at the next patches, I'm under the impression that the overall
> > code will be simpler if you let __fib_validate_source() return directly
> > a drop reason, and fib_validate_source(), too. Hard to be sure without
> > actually do the attempt... did you try such patch by any chance?
> >
>
> I analysed the usages of fib_validate_source() before. The
> return value of fib_validate_source() can be -errno, "0", and "1".
> And the value "1" can be used by the caller, such as
> __mkroute_input(). Making it return drop reasons can't cover this
> case.
>
> It seems that __mkroute_input() is the only case that uses the
> positive returning value of fib_validate_source(). Let me think
> about it more in this case.

Hello,

After digging into the code of __fib_validate_source() and __mkroute_input(=
),
I think it's hard to make __fib_validate_source() return drop reasons
directly.

The __fib_validate_source() will return 1 if the scope of the
source(revert) route is HOST. And the __mkroute_input()
will mark the skb with IPSKB_DOREDIRECT in this
case (combine with some other conditions). And then, a REDIRECT
ICMP will be sent in ip_forward() if this flag exists.

I don't find a way to pass this information to __mkroute_input
if we make __fib_validate_source() return drop reasons. Can we?

An option is to add a wrapper for fib_validate_source(), such as
fib_validate_source_reason(), which returns drop reasons. And in
__mkroute_input(), we still call fib_validate_source().

What do you think?

Thanks!
Menglong Dong

>
> > Thanks!
> >
> > Paolo
> >

