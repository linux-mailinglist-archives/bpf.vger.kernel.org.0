Return-Path: <bpf+bounces-41939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457A99DBE6
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C962833FC
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D11581E0;
	Tue, 15 Oct 2024 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtSlzU98"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525614F9FB;
	Tue, 15 Oct 2024 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957090; cv=none; b=HhftgkFIVH5Ccit1odyVx4VEPg4i5ZFiUi1V4noonE0hg/suRXA0qLxyI/xzU9/F8OB2oNpFwlrUCvs/AGZD/nX8voMz8NGMziYWHQPavDrSP+yzeNjVr+F1+ThoIXBu2kZB4nMkocSoEXMDvQg+TU8Ce31VUBvEnngJXckbjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957090; c=relaxed/simple;
	bh=Ujs+5HLGpLbw/FakdJks7Pt/B1xLKjP3/RL4O0ORx5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlHh/rGbicb3sWnOgiw5AkV4dA8foMYLkOoZGco2Yjbpkpbm9bgqOpVLGuD9SknPkRQx94I2uHLz4kJCOm8Rbc0ysuLclVxBSM+p6ElrCd1CkOwx2u5ViRVR61bbLk4TeOzYT8pOlxbS0MEuUjFfiDNuGZ8Csj7AlmdCe9wQQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtSlzU98; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8378942ef8aso234410139f.3;
        Mon, 14 Oct 2024 18:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728957086; x=1729561886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujs+5HLGpLbw/FakdJks7Pt/B1xLKjP3/RL4O0ORx5A=;
        b=CtSlzU98mUNGGMRQI6yVdnUGKmQXHiVyNbehv8N84IEzu04iYBA2rGZqp5eW4BL8wF
         0sdWGlOUZygJbSLwPNgsj4l21DsMEgiOaJe0d2lW+qijEs985lz5lnClcn+xhyeoUjqy
         3TpL35uaUItqkff4T0TDEr03ZElfe2Va20FW81ORU1gGqHfk4wJ6bn6ztcq6HdNSh76s
         qXf+9GTxA1s+a3pJuna9PrCnfmVTtC8aa1Y9pmYrdKyevBHd0k7ljcHKnxmXXxlqtbTF
         uSmDla8ctSQ4aallgWmmZycjRE+WG9Y3wrmj7e/Psr8XK1DmMtFe0CuREHMIA8pKXTw2
         IRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728957086; x=1729561886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujs+5HLGpLbw/FakdJks7Pt/B1xLKjP3/RL4O0ORx5A=;
        b=QQw8ODbnFHoyBzZyoYr0OE+1qZhpuN/D6ozoBeT4WrmfKLQ63p9npT6H5fun217bYn
         uMPv7BQMh80Od8xwZUjxi8qUcNZiCyGsuV3FcUW/6tMnrflC687BSn2mKEmMAGv614SW
         O3hdeTS6/K5Dmh/h8bTp2akHLwnVlgqgzSEHpAQLo24fGNYx/e6pGo+SEycHqI18xfPH
         APGwToVzxDPJXgDL11q7W06FKvKYV0KktcmpERR/yLfYd3s+fIpCPYAhtTWV7oqLjc03
         ydOew2+urRo4wiGQ9C6AlM4U+SQZH54RVpSn9EVL0HCUPCzmNsY0NIS3UIekPERuNs8V
         Xe8w==
X-Forwarded-Encrypted: i=1; AJvYcCV3S8c4RW1h0tBDKRQXv6ggq8xhngyuXAiXUYCxyPt6bQviJcPpm5TTn6lKIOUi+tEWtVA=@vger.kernel.org, AJvYcCVNCJzUh6VvlSBUHnC8bJOcwGJnLn34k0mAO3DotO2vhLNW1wvuIhzDVdqBzf2kOjWb+1T2fM3r@vger.kernel.org
X-Gm-Message-State: AOJu0YwVqpQW7pCE19hyPYZ+ky6x0TQztURGWZKp00RqsADEkJR9AGYG
	WpThyW7V+pRD12mkXPSrEeKu0FkWCZva3d5HXbI2+AJuYp4t89dT37VQYH7/Ztm9LkqdwcWlYN/
	E4XQNOM2l5vl08jdIgm81lRVG+gw=
X-Google-Smtp-Source: AGHT+IEVITB5tfkeqfeg9sT27Bk6oBTgpI0nW7d+aFZ/lh3KxQ3fmBb/9Z+ODP+Wf1JXkyeyaBjCJVgs1WKqxJaxwuc=
X-Received: by 2002:a05:6e02:1705:b0:3a1:a26e:81a with SMTP id
 e9e14a558f8ab-3a3b5f9e6c1mr89761885ab.7.1728957085778; Mon, 14 Oct 2024
 18:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-2-kerneljasonxing@gmail.com> <670dc5cab30f5_2e1742294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <670dc5cab30f5_2e1742294bc@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Oct 2024 09:50:49 +0800
Message-ID: <CAL+tcoB2XrWjPUAefgCaP8nZ1rvyviQY2D9gb-5R-jDU3pZ1Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/12] net-timestamp: introduce socket tsflag requestors
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

On Tue, Oct 15, 2024 at 9:30=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We need a separate tsflag to control bpf extension feature so that
> > we will not affect the behaviors of existing applications.
> >
> > The idea of introducing requestors for better extension (not only
> > serving bpf extension) comes from Vadim Fedorenko.
>
> As also said in the cover letter: I prefer sk_tstflags_bpf.
>
> This array approach adds code churn, may have cacheline effects by
> moving other fields and anticipates I don't see a third requestor
> happening. And if it does, we'll deal with it then.

Got it. Thanks. I will adjust it accordingly.

