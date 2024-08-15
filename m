Return-Path: <bpf+bounces-37321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2610F953D2F
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548D11C2591C
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B011547F9;
	Thu, 15 Aug 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEsvh2+/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245991547EE
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759865; cv=none; b=twYs5pG0AxmQpZh0PunAj50eogWUOenn/AbDdJ1td/T/3ytOPSn1a8XGgREVrETt1VQY4Xapj1zd5J4s6UIJwv1OH26GiwXLB3zLiT10xDp+fl38jLsxalb8546u43veLNv8F1VRdLJ7UWczPPNIZjtovPSVhHLH+O83mThlBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759865; c=relaxed/simple;
	bh=2aRzCFEwhdOhcsV91ye4EPF4WG2M1pFtk83xE2LGzM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cR82w2wMUFk5YBurbdHj52qw1m3pxf5MK84MNh4sV2d7WKKFy6YbPVlViPYonYYC1suVOPZDj3kXEaYYUCANWVFgjHJwos2J87B9qHq8WTZ/qMFDMVwoZcG8LCyO1jHOF4oKtq+/7bNMqbgdY++3fli8PAYM49sqz7p0dI5fn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEsvh2+/; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-27010ae9815so551377fac.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723759863; x=1724364663; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2aRzCFEwhdOhcsV91ye4EPF4WG2M1pFtk83xE2LGzM0=;
        b=WEsvh2+/s/9YteOC9EBcnhGs0e6geGtsiK/eYeZLRNg6ERPffNapQv/Zr/FjdAy8c7
         E4q6brzgLWJg1MkJYE/Q6fd7q/BLl2EoTYJcZRZC3HaqrHVUcCFkn3qRX7/YIHM3DvXv
         PCNbuiIGQ60s8Hjhu6nDoBkoCpMRMiNCGBzTvSCH1gKTIIfn+jrRdvmw9r3d7zJHOhbu
         qmBHzkhuhrZeQDaxS54Rh29dPeGWBbHxpuVCj0veW5g7Kiuw/85/UrwvcGX5xLXQ9yez
         FGBMj380LW6NNbuSXUeVcJbvCO6yohZxNcuzeNhTtNGxQ13WKoMp0eA39xCZ50vwo53f
         DHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759863; x=1724364663;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aRzCFEwhdOhcsV91ye4EPF4WG2M1pFtk83xE2LGzM0=;
        b=jU7XmfBKX8cbRPBuGVhLXTmVX2H7dT3z3IuVBMRx29h4tTOdNvSFj307p6zXYPTu2W
         v+HN380S7LTEBqljovxLkCYuDUWUe2SfIpc6X8uQ0NJ+/KuDrstxJabHN+Q6Jlv74RtZ
         kIyBus6Z15GShMvo+Xs4VnSrEs+JfdE0BmX88rBcc9fLl9FyfDhoMJg9aZZzs7xDWPTN
         kOjT9dKkZ3Scd8BvAW9FxcvkXaEHk2TbZwCxaQoIbWV8cP0zfpT3qZA9UsKnajvFj4YG
         PvFS3ScTGJ8g4NVFNJ7nji5NxW7l3Co2z2XaYkPbojms8+iGw3WEUHIpFwDsUFnVP2//
         Ub0A==
X-Gm-Message-State: AOJu0YxfHY5+cOVRz92Ki/lN0JytgzyGXxdMfOnLQikmRvBvlc2BOH9K
	y3y3ZpFhHXH2Q3i+qOAl9qP0PCi347X1Ya3uAPA3jA1rIyxBBRd3
X-Google-Smtp-Source: AGHT+IGyBO6wD88sMt3u63o+VdhKQmaHD162fP9w7CWBUhZ8GhygIA0EhdChqLh0WrJqZJqMNIvnUQ==
X-Received: by 2002:a05:6870:819a:b0:25e:1cdf:c604 with SMTP id 586e51a60fabf-2701c532888mr1110623fac.31.1723759863094;
        Thu, 15 Aug 2024 15:11:03 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c6579sm1657719a12.32.2024.08.15.15.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:11:02 -0700 (PDT)
Message-ID: <6d40ddcfbdf1bfecd7280d2a69f96eb66f20e692.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for
 tail calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 15:10:57 -0700
In-Reply-To: <CAEf4BzZNN4YViWtv_LR996T4uw86MhcOLLkNFPMgb=Y8qpxK8w@mail.gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-5-eddyz87@gmail.com>
	 <CAEf4Bza97Ksce2XYiQrvzYC5Lnqz68xWM+JvDeKMfj5M3pr+Rg@mail.gmail.com>
	 <7925b20a052588f5b7b911ed10e23ba9fd56d4a4.camel@gmail.com>
	 <CAEf4BzZNN4YViWtv_LR996T4uw86MhcOLLkNFPMgb=Y8qpxK8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 15:07 -0700, Andrii Nakryiko wrote:

[...]

> > > Isn't that a bit counter-intuitive and potentially dangerous behavior
> > > for checking disassembly? If my assumption is correct, maybe we shoul=
d
> > > add some sort of `__jit_x86("...")` placeholder to explicitly mark
> > > that we allow some amount of lines to be skipped, but otherwise be
> > > strict and require matching line-by-line?
> >=20
> > This is a valid concern.
> > What you suggest with "..." looks good.
>=20
> I'd add just that for now. _not and _next might be useful in the
> future, but meh.

If we commit to "..." now and decide to add _not and _next in the
future this would make __jit macro special. Which is not ideal, imo.
(on the other hand, tests can always be adjusted).

[...]


