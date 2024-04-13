Return-Path: <bpf+bounces-26702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C28A3AB1
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 05:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2452D2832E8
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063FC1B28D;
	Sat, 13 Apr 2024 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8bLQz1S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738EFBEA;
	Sat, 13 Apr 2024 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979710; cv=none; b=ZlvvCG9TkxV+QWhDg7taIcQyJ9zf23b2JfJlyB9lpDygZ+uRDHzSuzJ8Tsvt0RoimJddByvlXZrDnKE4hKFTGyJ3E8q/muEVygHni7GVWSuiJQYaI4vXk9nTuLRQ74XFH4zxXgTw4n4qH4h0CVUMjyGP7djO75OjP+v6IpSStvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979710; c=relaxed/simple;
	bh=EzIJDIFGO6tTHTDtbY4vVKSK0KtEPlqsxufT9y3CHy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM5FaacOfoZaeVa4/bKP4mFjQCXfVSGeUP/lCKZN0k1/22QWhk4erHavRtZYY5R/nL5ezINrdq5bLwmTMkUucBeIP0FG30dTbBnC/kWFNyctxsb83a8sPpu9z785QFUZnPcseKI8ZFlBKH9w7jnr46pD0FzZKGSoKcqkvHl9oJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8bLQz1S; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200afe39eso177395966b.1;
        Fri, 12 Apr 2024 20:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712979707; x=1713584507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e9eGT03DumsVv11aD7PWuRwtdqCrtgRsT4jgzvJaDY=;
        b=S8bLQz1S2yKA/EBb5JD0XfuOMd8nbwfepnfEY8Dwlk/oIFruFymFphUjZVH7Qi+YFa
         5+5k4xAz0cRbTV/IGpaNER0geWoLsQm8MkAkERJiCephuNPXsNjxACs3q5Iopozy0FS0
         6SLifzH+2jscWFGuhVUQytBiWSe7LgwZ2p9C8KfZ5rOMs0xKPpwa4FL/m8GC7+y95kkZ
         Fy9vYSyEOCrcOk428ajoGEljuLO2TFy0kIeZ/y5nRpQTT+KGe4LHqgtlv1EJn3VmNv4J
         oGzVqqEgqHdez9gKuiufD7zV8BOoBM3JiAVLndVCCPY/u3MVIjnZBZvBq3u06HPQw9i1
         n4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712979707; x=1713584507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e9eGT03DumsVv11aD7PWuRwtdqCrtgRsT4jgzvJaDY=;
        b=jYOS5obxVOEc6vn/ZUafQVzlXgwHHbE3WKmXDfLz19ifafZCp7tSg9eRYLrAC6waMh
         mZ0i5uKPP78TJKtSejylXJhQ2wDmPmFX657rxpKmh5gL7cQjL2ZZ8KxmX3KmCnKWmX93
         YEm9Ltd1ffj9KRJFafz+zz+dWJDbX/z5cO7gFAZkMDuktLapGkkmjD+C18V52EHSLj8X
         irsW2zqoV7uBMzPP6q1O18h59AfV3BFVItGgH32YzVZfPZvLhvMkH0o0NMr0o32uqQ/4
         XL4S2U49abhHePB8/ouvZMd5Kgy0ZsnMwWtX5VX8sRt7rtITJ+jkNdkJQdLzwTZ8FpN+
         tHKA==
X-Forwarded-Encrypted: i=1; AJvYcCUh1GJrsp8+WFKJylV9RVgn0uKrumCmHRd6JDJCxn+vbizckZx9mh5rwbmxrJc9Xa+3pK7sNRMLMXToKfaZZZXcz/4Ps+8uv8Ih3OfSLMoThPG+d76TZf9X2LKdM0YIK+FpwjDTV5BXBf4LMM7f9g+y/aG047XgZlPE
X-Gm-Message-State: AOJu0YxACQnjKHEb4HwPBDBq26rwidZ/s42N30lTDAakX4o8G0OIU6gf
	6og/3hPHyFDiF4rky0MuqKaExf6ezjAKCLDpXQKsm2m8YinrvMqjBSc6zed3p8rlO5jbMZGd8aA
	SOIsGHTL8Z38VY2EzuIQMtarAoL0=
X-Google-Smtp-Source: AGHT+IFxLN6f7T+mKsKK3f/fufoSjjrGbTgcrhzzCYSePfGDWQAap1LNr1fx1YFldVsS2oW1jFk4SeUF1g2CMBl78gQ=
X-Received: by 2002:a17:906:c445:b0:a51:e43b:cb20 with SMTP id
 ck5-20020a170906c44500b00a51e43bcb20mr3028014ejb.41.1712979707244; Fri, 12
 Apr 2024 20:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411085216.361662-1-liangchen.linux@gmail.com> <20240412191126.1526ce85@kernel.org>
In-Reply-To: <20240412191126.1526ce85@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Sat, 13 Apr 2024 11:41:34 +0800
Message-ID: <CAKhg4t+c31Qf5tnARsw_Vbduh+2mUMvEUJAiDE+UbE8u7_sgZA@mail.gmail.com>
Subject: Re: [PATCH net-next v6] virtio_net: Support RX hash XDP hint
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 10:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 11 Apr 2024 16:52:16 +0800 Liang Chen wrote:
> > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
>
> Please indent things according to the kernel coding style.
>

Sure. Thanks!

> Checkpatch finds 2 problems in this change.
> --
> pw-bot: cr

