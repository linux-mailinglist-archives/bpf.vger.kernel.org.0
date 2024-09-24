Return-Path: <bpf+bounces-40243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2098400E
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 10:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E73B24134
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 08:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA414D283;
	Tue, 24 Sep 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GANqzSCV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD814B08C
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165527; cv=none; b=anF5Qk2Wbgz0sXePK4kL80zO43b0oYrpd3aWsJyjTMLhEhii8BmJDbGtsYQQmr/qodaqMs5XAunmf7Fi5PiuNVUSEBKzxC5u2AxMwel5ez2fHYmKPDgtH4ls4r6LrpkSXgfWcOA1wHH0h7eJs0QfwctQiBJQWTL2RihO62m66qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165527; c=relaxed/simple;
	bh=Rp5px9fyLoBKWe9OslQ8c6Zw41rouGmlkdIWQyjD6Ok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUet23HsLrWw1B8DMXVLOZaUUGFNmeDCDM7ThepEytdebDx5M/LVxw9uCTx4oHtVsov/j6Pv0vM+P7YNsQ41BnFptyFLa8eyD/GpupXJgM/rd6RuEi3+CKPrdvyinx/tVFo3KTvP0ouYxNAA2w1c728kxtMDV/dwR+xETvqJ5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GANqzSCV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d88690837eso4245928a91.2
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727165525; x=1727770325; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rp5px9fyLoBKWe9OslQ8c6Zw41rouGmlkdIWQyjD6Ok=;
        b=GANqzSCVvcoYD9fR8cpocTCWZ1Cf9GHu+J88MIarnD6UoHKhHViYSycXc6IL0H3VJ2
         J07D7xQKGBjHX9WNn51IIBss5uwCGkQU3oVLvL26Sa5q7TdYko8cApM06Z1huPlBnPrY
         SoBblvd7O5IaEUQwPdZs3anCANhAW5ZOpAsTFMJMt1O6QYyMCvFSSL9RrGi8RKARpKNk
         ZqL+3F584LBK5GpmiJUbGY4RQ7zy6yjrjP4Skzv5IY/DpHnj7XGnoUQ7/ncMwdVd/E44
         sRK4R28HDq6UVKfgssBUYFC4CyXd0MSLaHDmZV/6NbsfRqqgAkks9qZJL4l7Jjz8oTej
         tygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727165525; x=1727770325;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rp5px9fyLoBKWe9OslQ8c6Zw41rouGmlkdIWQyjD6Ok=;
        b=nZzBT4CAqyO+dbm2wLOyuDtHQwXElh/cUowljbKxWHiDr8o3BJCSO2cWRNx6Fis21v
         /SIZNIH8+C5MQVyo1AeOJupDk2ZPBk/FH1a4yy4cAVhcWVLmPaIaC3GTCcM7GlIwah4X
         eJTu2FxUri32R2Xyt/t1huHB1hl1kzmaHMJdSHVw7nsfPHcR6hQNdLoCSPsPTCONo/ab
         +e+z163J/FH7YNR5CXamhCW0SlVsPJcpWi8gj8icAB6Pojo+rpB7ZrFphhMG5gKnuJ4K
         opFQO/M6QzZ61Ow+Xcmf2RmyNXdMYZE4RWJ/uB9Hp92qghgDYEr55A8fV+x83mOhHvSw
         zkTw==
X-Gm-Message-State: AOJu0YzaXPEDUR1c9V2ookcNeOQp8WDyB6/dydJVSnAP2yGI2SfrcWkU
	OKtknNsuBvghi9Bzt1W8j5ZiB4N/cI5gumJ5ID6ShhFVoqZ9NC0VBE4b+JFJ
X-Google-Smtp-Source: AGHT+IHKqNaMQVVzXHtKEEk+Aa9thNyQ+lwj6fMfF+hLXMHXet+N6X5s/Ir9K8NkqSrnqKwbGTXmUg==
X-Received: by 2002:a17:90b:390c:b0:2da:8e1d:4769 with SMTP id 98e67ed59e1d1-2dd7f6dfb1amr17561411a91.38.1727165524522;
        Tue, 24 Sep 2024 01:12:04 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee98388sm10838017a91.13.2024.09.24.01.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 01:12:03 -0700 (PDT)
Message-ID: <e90b14ef01cc49b790b2b7a6dca19e873e47c671.camel@gmail.com>
Subject: Re: [PATCH] Fix a bug in ebpf verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: lonial con <kongln9170@gmail.com>
Cc: bpf@vger.kernel.org
Date: Tue, 24 Sep 2024 01:11:58 -0700
In-Reply-To: <7e2aa30a62d740db182c170fdd8f81c596df280d.camel@gmail.com>
References: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
	 <67451140439fafa1bae3e3b010d2c6b9969696a1.camel@gmail.com>
	 <CAH6SPwj6=zu8fLNLwZ06fTso9634GV6ku21xpyzN+bwvrOevFg@mail.gmail.com>
	 <62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com>
	 <CAH6SPwjoACNcNBWCjYauSMYCFOUAys10uH-xM6mF8_Q79D0Yow@mail.gmail.com>
	 <CAH6SPwhUnn9-nNz9fpX3YGeA9WHT_BA5UzNgS5wYMqO=+8Ly_A@mail.gmail.com>
	 <7e2aa30a62d740db182c170fdd8f81c596df280d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 16:36 -0700, Eduard Zingerman wrote:
> On Thu, 2024-09-12 at 22:40 +0800, lonial con wrote:
> > Hi,
> >=20
> > I tried to build this environment, but it seems that it needs kvm
> > support. For me, it is very troublesome to prepare a kvm environment.
> > So could you please write this selftest?
>=20
> Please find the patch for test in the attachment.
> Please submit a v2 as a patch-set of two parts:
> - first patch: your fix
> - second patch: my test

Hi Lonial,

Do you plan to proceed with this fix?

[...]


