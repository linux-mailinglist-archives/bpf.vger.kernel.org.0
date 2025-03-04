Return-Path: <bpf+bounces-53238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFCA4EF03
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA853A54B2
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568B25F989;
	Tue,  4 Mar 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOvXZU1V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2813E2E337D
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122342; cv=none; b=WrK7CV/rP2uMrVPaDnbplg47h2R56IPt6mcHQ5cVmJiJ1L8swOLuEyG4E/jguuykXHAEeNcmUsi0rzYakEdYR3K68lhhSnA89lcEqUSQOJkTAdQjC6kzO6fB9c5FcSZ/9Gt0Sn0fIrQZhj0INYHxcuuwKpy/N4ZScYANWiHGR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122342; c=relaxed/simple;
	bh=qOeYh8tob0KwTcoQr2qx9aYeqJk8jI0MMvh1pkEn7EI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZJfMri4lNx56dj7gC6RPPDoFTw9QhhazO4GLSAigLYaG+9rYsETlpm3EFYWmA9hs0ghbmjYz8is+ZOw7D5w9g5q/M09Ec51m7MomtUYQNfm/NZkmLrp38WD7G2AmBmXRHprV5rTs296SgMHNDdXAgZPywcQPwhUYzp9GIxBYyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOvXZU1V; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223a3c035c9so3037355ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 13:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741122340; x=1741727140; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cNUzceK93dEH0pd6fAUAYhNT/smxq/UyfmNydJ6lxtI=;
        b=DOvXZU1V9aVBM/qCpLy8ye1I29eVhCSJ3Jho3WrzqLC7eEs9PVWhcT+V/31bancCgl
         Vo+sq7A8D9ZaBkMBor/Cm/AiZpp7i+XPXOwf55p3PZoSqXPPurK1FZy1qmQqmRUQWcDB
         hzlZ7rAKoMnSisyWojqTfP3texi5oBvfavLz5EE+0nSfREx75xDtD4ArwuUaUNbJ8/ca
         ycXqrZbAvnxn2eiKej5OvT6KcBMpsQ6V81efpxlqLYAXYxeR0Xg0HcACtRGXbj036JU0
         fMrZQe/saxd6lzHRhzUJY1FBiXJvPP7tmslIwtS+Eu+dDg4pyEEkwlC5CGg3rXqPuIev
         lBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741122340; x=1741727140;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNUzceK93dEH0pd6fAUAYhNT/smxq/UyfmNydJ6lxtI=;
        b=lmIk95V97I4QYnTmBZH40SnFRG2ZCFNEtUyI2PsheJ2maySTG14CNYiCx6D/XJ6uSq
         Uu0oLZ0lV0scvwNZMtvUAraAV6sh6GdTz1E2L8/9PfuNQAlssW/aomC9P1EfufU4b0Dt
         ETXo4Z4jXmeKEPCsIi6LoXkmW56370EvKFI9G1kWcPIQIZonrcR7dlGEQipvGmF2qCbl
         x1QqZpbcmDR838v4Tnvh5YcSwSlUWFj47eFFLgxyD8pnrJxpADJtdFGZ36CBm+WGd1mL
         aB9c7B0r/M14d79XxypAqgdbIEkGxDhuK2YWLUf6Hjz6B/4T6N2lG1Gif7BEXZfBkc8z
         yabg==
X-Forwarded-Encrypted: i=1; AJvYcCVxYmR7MAH8XAQcwhpIW8W5Z3aAn5yeK9qvTUzvu15llXED6RYzzJT6dlXWpGRRb2tCMks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVaiGiEjd449ADrCHHP3KSpQXOcL2f+5+hNUmfFv45TIh9R6D
	tFG29YIZeC3mBZUf3YAFzXPSXEk3rRmDLzv4PH7m5kM3gtb7VIqWlGn4gw==
X-Gm-Gg: ASbGncselqlsHtAwAolgKcICxVAeGGmADQanooNMJzUmAY68ahLkxwieJkEFg2IB36N
	sqVf2oXRRSSsdUFjEmRrcJQ0GeBin6gbh2vKsYmA4Ja04ryXAZ45bYz6gIP244wVSeHuCd+MufD
	hhWIiN6TqNZXStv64qe9bMpfuILEjYseINbv/rr55UdSHupTdSDeR04+bb3BoVbgPWbm1W7f3c6
	g9EzhaEJduk0+w5sdlCY9FlPrBTiZScl9g8cU4iKPwNw/Li/GIyZMqK6e66ewkcP/CYOLTVe1E7
	NDmhXTbH0Qzg2cHl0U98quZxr77zLNcRedqNKeOESA==
X-Google-Smtp-Source: AGHT+IFqPMPwOJdLGYzhD1mAWhtIB37/k+gctCfpdHDAJyVEBbPoe2CiIdAbmJBviCDqVos83q/mMQ==
X-Received: by 2002:a17:903:2301:b0:21f:6546:9adc with SMTP id d9443c01a7336-223d916cf88mr75631775ad.13.1741122340270;
        Tue, 04 Mar 2025 13:05:40 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2691sm100265655ad.51.2025.03.04.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:05:39 -0800 (PST)
Message-ID: <13a48c89f69c6a5e9b38a0c5933cbcd2ac65ad80.camel@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Strerror expects positive number
From: Eduard Zingerman <eddyz87@gmail.com>
To: Feng Yang <yangfeng59949@163.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, Feng Yang <yangfeng@kylinos.cn>
Date: Tue, 04 Mar 2025 13:05:36 -0800
In-Reply-To: <20250304111722.7694-1-yangfeng59949@163.com>
References: <20250304111722.7694-1-yangfeng59949@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 19:17 +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>=20
> Before:
>   failed to restore CAP_SYS_ADMIN: -1, Unknown error -1
>   ...
>=20
> After:
>   failed to restore CAP_SYS_ADMIN: -1, Operation not permitted
>   ...
>=20
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---

I agree that this is a problem, however man page for capget/capset
functions says:

  RETURN VALUE
       On  success,  zero  is returned.  On error, -1 is returned, and errn=
o is
       set to indicate the error.

       The calls fail with the error EINVAL, and set the version field of  =
hdrp
       to  the  kernel  preferred value of _LINUX_CAPABILITY_VERSION_?  whe=
n an
       unsupported version value is specified.  In this way, one can probe =
what
       the current preferred capability revision is.

And cap_{enable,disable}_effective() a wrappers for capget/capset.
So, it looks like cap_{enable,disable}_effective need to be modified
to return either -EINVAL, or -errno, depending on the value returned
by capget/capset.

Could you please adjust that and send a v2?

[...]


