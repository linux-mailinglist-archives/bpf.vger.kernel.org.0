Return-Path: <bpf+bounces-33076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6B8916EF5
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC731C2264B
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D00178385;
	Tue, 25 Jun 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYCqYqdn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E41779BA;
	Tue, 25 Jun 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335714; cv=none; b=gqrUdB0PkP/y7iDqrJ7tvfxaaj9CcsTFai7mxBZVbTvv6UTqdmoSLGRbO0xKyAoFyXVv0R48zbD9h94cuBd/E0YYmMfEGDCZHl/QRUEnTuLg2BlplZ2iANAS7XD6dzmx3yiDrokq/yXAibPS6lgfq7ABJYwHvfKsO/Kam5eOfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335714; c=relaxed/simple;
	bh=jjtcuEA9sKtqwrfShdvUlPqsNArkCuWKWDP61e+bF2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBzrTHCptDEdypX6Taq7H8CButKC5rXhxAqP8OGbUllE8FeGKIRVw/OVnXirhgz0kEoH5JKp4EFUhKmDz9c5zLUlkUCFv06kGmWJ3KIi+CPiJ3hjK3L5ZxAsZG8k3lxkioAIPBEVSZRvl8aCB9s/x77j1ikA6yhdFEfpMASpRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYCqYqdn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3645e9839b3so4431627f8f.3;
        Tue, 25 Jun 2024 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719335711; x=1719940511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjtcuEA9sKtqwrfShdvUlPqsNArkCuWKWDP61e+bF2w=;
        b=GYCqYqdntBMnluW6qiqNvbQTF4M3Wf/7jQUcNvFQh0/c7MnymLqfB30MaVFF4J5LP7
         0xPoA7PCN/11FaTSUsZRvxEp217dBwCCRW/Rxz+CxuSquk03z6OZcU9Xy7C9YoYwqd4j
         U+fTKsgx4ounyvkyMqhUPEA4aIbVF1g/9seCMCC5zmX/3kfKSLYDpWmj1sc7RdxmkZ4W
         VLTRg7cY8zppH7Jdna3N/KkoyYSU4MG18kGOgg8+xMBRpz9kekvfhgGe5KLpu39/gdgC
         Y21f0cmoIZfNl+8XjhBV7RB2YuYfh0FLAdnEhsqFdNNJn7DePQNk5W4A90tYr0spsIsn
         p0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719335711; x=1719940511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjtcuEA9sKtqwrfShdvUlPqsNArkCuWKWDP61e+bF2w=;
        b=cRiw76e7KbwZIAyNjraNoRFp0L7dVhonnHu4fK+DSfUeqHr5Yf+XU3dNzhoqIwv3ob
         vV+2IvVAfYbY9epwKKuFziIxHtmeA7XzocqvtJNqaMtVU5V9Fq6RO0+tBoB2Wv5BGAf9
         D2sbxDEijIvBxGZ2s391DfAQWAKokWGH00vPZBMrMxr/Od8O8sbiSb1mtXRCg7DNTzO1
         FJhmZ9FEg3G3+7Ny3e71gH4st1dUX9ApQEFsTVPGpITckCkxn1EkfXBqQ3lyuamTIKjV
         yIXgW56NUi0fsun1OL3GnkoHa+rzViXRIcpm2unKyDkPQNt+LQ1hz9yhpmVHxxWl5gan
         9cUA==
X-Forwarded-Encrypted: i=1; AJvYcCUaH4SQgKPIXtQXeG8S3AqNEjSqV5khV6tmi4DxVl3h1pfKwnT7fiU6iC4eSs3fJYkoFFp+ZIBZgCST4bSOVftpiOf1txuEVzimphvqmNnftfN3lSuBkKUAyGOdc6uBBeHG464ocJykbmvDORfi5k0HJX8J6PFak/z+gLK/PxgOq7NBtgtKcODJvBEpwl7QJMEkJ9p6KbH6xRjrel7H2kcWp91sj7yI42HHy+IcNnA0P57s
X-Gm-Message-State: AOJu0YxI2Cj3arAukmN9e07VJ8JBHL60dxa14GbHE/rp9SapJ40UVcPJ
	MpkwM9I5fb2BB2pF9wieVkZ9THOlE2mDGyDK/J109WAhGFgAJfMhLwDKWzNZpZYPCA0aIHuy+WS
	LGuXKJI43izBwNpK3y9jvxMEY66U=
X-Google-Smtp-Source: AGHT+IGqtcwJLjr+3MHilvLPVtfKoipe5kx4LBLA5mXRe+9hOE9htiLokRjYzn24SuFzozxc4yBuhK03IeWG4UE0GVg=
X-Received: by 2002:a5d:598a:0:b0:366:ed80:d056 with SMTP id
 ffacd0b85a97d-366eef90065mr5423589f8f.14.1719335710842; Tue, 25 Jun 2024
 10:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnB9X1Jj6c04ufC0@sirena.org.uk> <CAFVMQ6R8ZZE+9jWM1vhEuz2PsLyCgKhpaVD377TKEu4AfGO_iA@mail.gmail.com>
 <ud5j6hbozgg6em43volidpffykdtd2lpf32etmdiyksorl2cb4@whtseaibw2xw>
In-Reply-To: <ud5j6hbozgg6em43volidpffykdtd2lpf32etmdiyksorl2cb4@whtseaibw2xw>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jun 2024 10:14:59 -0700
Message-ID: <CAADnVQ+cJ5bga7tX9BSTC150CgXM8KQT+Z21zYE-VY-8fts6kg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Thinker Li <thinker.li@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 8:54=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On Jun 24 2024, Thinker Li wrote:
> > Hi Mark,
> >
> > I'm sorry for not getting back to you sooner. I have been traveling
> > since my last message.
> > I guess this patch is for the HID tree. The changes in this patch are g=
reat.
>
> Ok, thanks for the review. However, the need appears because there is a
> conflicting update in the bpf tree.
>
> May I ask the bpf maintainers (Daniel/Alexei/Andrii) for an immutable
> tag I could merge to so I can take this patch from Mark?

I'm not sure how that would look like.
imo conflict is minor enough.
When net-next/bpf-next lands in the upcoming merge window
just provide Mark's patch as a conflict resolution suggestion
in the cover letter of hid PR ?

