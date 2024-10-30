Return-Path: <bpf+bounces-43466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8499B5930
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18B91F23D57
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684D17C200;
	Wed, 30 Oct 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG+7G+C2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540FE42A8B;
	Wed, 30 Oct 2024 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252064; cv=none; b=lnsnTcyzlcXS125vqHSQd5kvWb+NdJsCWbhDS07O3SdM6esZ6IGKIDu2Zqr4D+1ee/UZtW6lWJ4ys++czKa6VWdiKbVJQR8lRs2eIblgbE2bVl9QJCFxFxjMAwo228g6h5jZrfYTu2KEuK1HrGQZnPdBpFOOFYqBjFYkCJEE8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252064; c=relaxed/simple;
	bh=Yp66zOjBTkqdw1eyRFLXESGFpMB8EYkX1+UgnwBfc1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWjex5CQ4inD5C1APjoXWlZPTTQw2OW1qQQTlehfzP1WhcdW3ayisrQ8P6Bh9wEVKxPg61zjUuL4+O1+myaIzFSRF+WNR+TsfAxIICnS316t90Ar1IbSZ0xs+KUACWwPxQvd/eB5vTDS/axKKx79K6dn5OWd21QkkvwCsV4vKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG+7G+C2; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6ea051d04caso24839427b3.0;
        Tue, 29 Oct 2024 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252061; x=1730856861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h//5h0dIiAWAEjEnhgHy2Bo5TCA+6MH9QdtoE5g4NIQ=;
        b=lG+7G+C2yV24Le/crfyiM4sgb0LBOWehHWgCXCKyATzxs1eYgEJy5sQKBb8b/4sj/r
         s8AfmaufxXzA2f8zOt6kwW0DBISoscL8Z5+Rgpog6z75uczxuQUsmY94qi3CcZ4L+3Aw
         SnrFqNCNW5ijJ37Jwysj2TGYyDNR9F/apleHygsY1fMwUZAd/kA4+f/0UKcCZjfWEkpD
         4pNGoOYpn26NY4WCdj1BOwBcnmoztsmB0BgU5wrA3jVSfDFAF+Ia8NvRREXuQhHAkb5u
         KqOkdTcjOtfD1oHzFwM03KON1U4Z7/6cHMrYLUh5TTjfwHga24VPrFL6KR7/CIGN2RRZ
         953w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252061; x=1730856861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h//5h0dIiAWAEjEnhgHy2Bo5TCA+6MH9QdtoE5g4NIQ=;
        b=corDT3OWX8BPABPGPO6WCEh4xL0vfWpNanjQjXMCbr+eBC/xfYS0wEah8MmGqqKX3X
         +oSYXYScdqytzL94rzDc7kxqScpCI8/BWGMdtuARMRHD22Yb0ggBL5a6O8XMVrtTqFAC
         /3Pabg1MZYUMxnAt0c77zFbkvLfCI5TEw+ApcCT8L1EKNRiNm78F3IFAKw5X6z+CZ+tX
         gkeU0FFMZtFQBnAyCYEQAHH7ilImPw7xK4wQ7ttNr0Idr0wJ4eTgP7vqpmMV4zNkWim+
         AL8iBs5c7DjrTxQ++KkvRShxgn6pfJf0UNZWgJMCEuvowhpMejjzx0JqwNnvpL3/bq3+
         vgsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7/Xxra4SRAlYjSPGI6azK68mDd0KuVdQ6wPrQVmpL2qznWRcIjjrueFNkKxN8hnqFtUs=@vger.kernel.org, AJvYcCUVkLvIraTxPWNz2MgnoP0LWEFaA/4JjFheJ46sHEVYqECQneh5NNLVIwekNEy6lQhbk+Md7/dvaOMLx39ucnEf@vger.kernel.org, AJvYcCXZGtWtGe4Btz1NgIVRykP1IxGTUK0pvt/LKUKFpVH8U9EKI1TpcKDwAObN2Uj+z1whq72JGG21@vger.kernel.org, AJvYcCXmEscEkzOTjEUjllDalZefBc20B3t0HzX0qqzby+tm9zpmjwZ3rKLSYVRlMExGAk/9+bifD1Tr8da0gF9/@vger.kernel.org
X-Gm-Message-State: AOJu0YxivOhuzmp7if9VRq0fDzSQ9ikpl6eX0DsnF6LVkScCrmM7sA69
	Bj0rdwcUTlaobfC1Y4jXW5eGtU7LRTeIdxC4Nk5LY5FW413hmVG85XjkCad8aAMzQUtSNQELCOv
	S2XMuhF1sHn4losttLsgTfVVMeYA=
X-Google-Smtp-Source: AGHT+IGmt0v/jSWrgx/76rpboLxL9IobAr7TI03JuBHGd40YJIScAQ5UnmQr1bHYch2Zxftv5X/RAJg5pl62ieHQRyE=
X-Received: by 2002:a05:690c:39d:b0:6ea:3313:fa1b with SMTP id
 00721157ae682-6ea3313fc65mr28460797b3.46.1730252061300; Tue, 29 Oct 2024
 18:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024093348.353245-1-dongml2@chinatelecom.cn> <20241029170341.1b351225@kernel.org>
In-Reply-To: <20241029170341.1b351225@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 30 Oct 2024 09:35:24 +0800
Message-ID: <CADxym3bUKBuMkaG3NiQHavkgScLxRAgkSSmk-KbuYpMepSYDzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/9] net: ip: add drop reasons to input route
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, 
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com, 
	bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 24 Oct 2024 17:33:39 +0800 Menglong Dong wrote:
> > In this series, we mainly add some skb drop reasons to the input path o=
f
> > ip routing, and we make the following functions return drop reasons:
> >
> >   fib_validate_source()
> >   ip_route_input_mc()
> >   ip_mc_validate_source()
> >   ip_route_input_slow()
> >   ip_route_input_rcu()
> >   ip_route_input_noref()
> >   ip_route_input()
> >   ip_mkroute_input()
> >   __mkroute_input()
> >   ip_route_use_hint()
> >
> > And following new skb drop reasons are added:
> >
> >   SKB_DROP_REASON_IP_LOCAL_SOURCE
> >   SKB_DROP_REASON_IP_INVALID_SOURCE
> >   SKB_DROP_REASON_IP_LOCALNET
> >   SKB_DROP_REASON_IP_INVALID_DEST
>
> We're "a bit" behind on patches after my vacation, so no real review
> here, but please repost with net-next in the subject. The test
> automation trusts the tree designation and bpf-next is no longer
> based on net-next. So this doesn't apply.

I was wondering how the conflict, which was checked by bpf-ci,
happened, as there was no conflict between this series and
net-next. And now I see, I just tagged a wrong branch for this
series. Sorry about that, and I'll resend it to the right branch.

Thanks!
Menglong Dong


> --
> pw-bot: cr

