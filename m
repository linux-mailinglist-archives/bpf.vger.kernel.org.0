Return-Path: <bpf+bounces-50257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7940A24605
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 01:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C987A367A
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 00:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B27317BA5;
	Sat,  1 Feb 2025 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UKF5A6G9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455FB1A28D
	for <bpf@vger.kernel.org>; Sat,  1 Feb 2025 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738371323; cv=none; b=lIl/k5T+l3MtR8llYsbGY/Hg29r3JoYnxyATG2uIaGIEhXMYIBOjHyhyacPUpc/9S6SHEZi/uDFQ3QxM1v3av4w5XdqaUurMvlIFQi2aI5MtzZKRaIbhmPvP/ODYrjYWmvh6mQJyDAq+hJWl8rZsjTXTbrgWR4SsG59CeCpk8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738371323; c=relaxed/simple;
	bh=BUBqmBSIVKg5rx1sAnnhZLP/Oo7EAKUfD1TEBOq6GG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnb0jOSy1bGKyk70Qbos9/zng6oifHFszH7fgpM4EJ0zfSx1XsqU/uVaXL2NhrvTImXGRnVDzCgZI5wpSZ6af5U2t28ho3exC64nXlpK9pxwr95Tb8oyqUyKZVFdjVQae4Q7fY7MbNgNrZZL5XWjsgNT3sKkJSe5Y6hhAD2pfpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UKF5A6G9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso4789301a12.1
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 16:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738371319; x=1738976119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUBqmBSIVKg5rx1sAnnhZLP/Oo7EAKUfD1TEBOq6GG8=;
        b=UKF5A6G9NeroP++vzQndO6gqFbVIKHGuo0kcuryQwNUPpXetw+QmvATNLfa1L2ls/j
         q0/8VmLk6mlYJUjI9HeifPaGRcbQ8pJKWMZyv/gYas+LXQoPDo7cS0TYXOdpRJcuwUov
         HpfyuAoZJhpoLRjjMp/rkRz78H1KXQn4teGlpWLEmBYAzzU504Cft6xUov5JfCmOxJGK
         +ibO7AX8a/jnrWcmGQjFGImDXinPBJhgwTFJsdJyl3w1zbUQiFDI/yjnOKUf9eoKZmQI
         hUyV4y+OzA1jr/PZ3JprGxdRiYLkn5GsJCsM4qADyiAlud97c5EF6k+G8gUA73pMHjvI
         Yx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738371319; x=1738976119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUBqmBSIVKg5rx1sAnnhZLP/Oo7EAKUfD1TEBOq6GG8=;
        b=Xn7IHOZoJkiXTg5t4UWLh3t7fAyRImKFEI5r/9ZDJxuFo6uEJnUbsJFJ/2Qe9hQzLs
         jwpOv4HKtsQHnfNqoWPaPbMbNOmVz+GqfOtfZfbagOcb+LGJqPzrlENs0Y3sd11MS6lQ
         9Ad6bZn/mxtGaT0r6sfHKHBeG9eiIzaBRcQVD75mC32ZzWgNycwTt4VA7Bqs7xfa9bZr
         O5uYC1UrBZpEAkdqIMwCd6drCF25pB5kmbomcV/hhjp6LKeRBXVjVzPeoNfDZGblrp3W
         4lJqQfMT0LnUfg6mQJfrskFENKDq/PqWSYriswOABbQQOs8gQPQeiADOp7DPoNxt7dzi
         B9FA==
X-Gm-Message-State: AOJu0Yxs0K3JNMhU43I+I9LHH1hksyI1vD0ejnwWGP/HVQx6iwM3vn0g
	EdJq33Z4dkCLFa3d/+lCgmyukilpS168z7why5id89JRMi9a9UV9082upJqC6QEh7E2KZWPZDm6
	bLC7Zt49ZO3PGJKI67dsdFUOQdA7IwigIAp1iXw==
X-Gm-Gg: ASbGncsSGfSr41ODCHS81XWwLTwxXcdlivy1mHWrQjGl7QQykI1cvtSSJwNjThy8WrZ
	V9tXinXuE47PB+OI/j/WzZQpk7Ia98ZeOsCgkyly2A7O3O+aFF0NbssyxfmdRL6fIX8WknDQrX7
	H1Y8NSXzZiHrU=
X-Google-Smtp-Source: AGHT+IEfN430KVGzVEIC67t7KB8Mz02piO2RrmwOf5NQLjY0z4Kp54i/0ziMFVn+Dpd/gcIikyhjz2Me5teiomW7EuQ=
X-Received: by 2002:a05:6402:847:b0:5dc:783e:3efe with SMTP id
 4fb4d7f45d1cf-5dc7fbb58ebmr6065766a12.6.1738371319511; Fri, 31 Jan 2025
 16:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131232851.36345-1-kuniyu@amazon.com> <20250201002448.43472-1-kuniyu@amazon.com>
In-Reply-To: <20250201002448.43472-1-kuniyu@amazon.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 31 Jan 2025 18:55:08 -0600
X-Gm-Features: AWEUYZnxrKPAr54D2ma1963U-V2YxxP27RimDdh5gFD3F1NlBRrlthhxtNDpDLM
Message-ID: <CAO3-PboVUb=ZPVVsELrhEh_Z_0PNbwcTdMxfKhoRtbagPy2ovQ@mail.gmail.com>
Subject: Re: Unchecked sock pointer causes panic in RAW_TP
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 6:25=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Fri, 31 Jan 2025 15:28:51 -0800
> > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Date: Fri, 31 Jan 2025 14:38:38 -0800
> > > From: Yan Zhai <yan@cloudflare.com>
> > > Date: Fri, 31 Jan 2025 12:32:57 -0800
> > > > Hello,
> > > >
> > > > We encountered a panic when tracing kfree_skb with RAW_TP. The prob=
lematic
> > > > argument was introduced in commit ba8de796baf4 ("net: introduce
> > > > sk_skb_reason_drop function"). It turns out that the verifier still=
 accepted
> > > > the program despite it didn't test sk =3D=3D NULL. And this caused =
kernel panic. I
> > > > attached a small reproducer and panic trace at the end. It's stably
> > > > reproducible when packets are dropped without a receiver (e.g. run =
iperf2 UDP
> > > > test toward localhost), in both 6.12.11 release and a recent bpf-ne=
xt master
> > > > snapshot (I was using commit c03320a6768c).
> > > >
> > > > As a contrast, for another tracepoint like tcp_send_reset, if sk is=
 not checked
> > > > before dereferencing, the verifier will complain and reject the pro=
gram as
> > > > expected. So this feels like some annotation is missing? Appreciate=
 if someone
> > > > could help me figure out.
> > >
> > > Maybe __nullable is missing given we annotated skb for tcp_send_reset=
 ?
> > > https://lore.kernel.org/netdev/20240911033719.91468-4-lulie@linux.ali=
baba.com/
>
> Just for the record, I posted the fix:
> https://lore.kernel.org/bpf/20250201001425.42377-1-kuniyu@amazon.com/T/#u

This fix in the other thread is working as expected, thanks for the quick p=
atch!

Yan

