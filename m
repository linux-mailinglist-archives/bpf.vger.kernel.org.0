Return-Path: <bpf+bounces-52230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF78A40504
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BF019C46ED
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 01:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E61D88B4;
	Sat, 22 Feb 2025 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPgsAvvm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA2A73451;
	Sat, 22 Feb 2025 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740189372; cv=none; b=Eg46BKCKVMAJOqi0a7Sd+TBY87UQ4DXB5D856lVCd6hNDf7HuPdEwrL+P9ab4mRWTjM4oDKrE5AC6YYHiBiuZCzjbkF78Mkncl0yHPCT0rQRT7IFbieZ886Dq2iSDpP90U6Jk70hy60IG1ujaJRZFiyqIcpTnV39nPl51TfvMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740189372; c=relaxed/simple;
	bh=RY4VlOezbPA+2VOOCDGzqzmmDbSMlVAZBXXSvC922gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWxKCV5gb8B03G4cfcH53N95vF/7Id/AYv+HmqS+MyZUW3K4SjSOkCxo2nomkhGuqrXCx/6m7VWL+lpc9aQ+7rsqZh0fBj9OGp5caAVCiW+NKkQKlcKg0XXAL7CIxMrOFn6FySSXRJ/H7se+nJPqSgcdiZwE7rXlFLDxgb/c/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPgsAvvm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4399d14334aso23749885e9.0;
        Fri, 21 Feb 2025 17:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740189369; x=1740794169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY4VlOezbPA+2VOOCDGzqzmmDbSMlVAZBXXSvC922gM=;
        b=gPgsAvvm4wExgVHw3igIehOeZbj0tSEq5wN9HzrKzGIau4KaY1Gd1gN1z2XP4LB0Vg
         /VGQx28QjsF0Mgxpu2YTGEfy3Ow9uiMFELGYiCbjz3KyPgUklDyMangRa+0U3hm4VVvQ
         9zxWbk0gRNIfXGBuXcdMabqAE11aV1wsAWCqkjSVZGOfcegnAxusuatLrThBhs4P+W2y
         Mb4lKwCLbt6U7Qspk36xD8t9uAzvXk9xsWWY8xkOaKD4kZDBJYanjs/Plei1ZAJpjAaX
         MXa3Rt6Kn1PVXq1ETwPOkvt9xGHAJZFdeVe7t30FJqcQthZ2rHjjOIlpsP+gF1V7irgE
         T2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740189369; x=1740794169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY4VlOezbPA+2VOOCDGzqzmmDbSMlVAZBXXSvC922gM=;
        b=nld9hiVWeQi/B/zDeOOAhRRbheSKRlBzs1ATSdBxeEezQQ7uKum8+3+yKWH8m/jpI9
         8dtJJ89U6u98l8vHGaBahh5idMwM63V0cbJS0SwM3wPxXwugVvYdVzDiyclu3venLSAs
         oTilfjTMUYIHWNiz38XbhVGxBvoGEiWaSp6JUSQ7z+hCY1NINJbccexZ1NI+v9pfhfVZ
         vxQaCayfNJ/YrNjxFd7iGrJPJlbe25iB8KB4ISFdV9xn+Q8fRqePNiJ6w3Pqso9rPDEG
         U5Xt5by3NCmIreQS/+PalkeuC88rFGz1VUF1WdKLeum3XVxoA00/DAZUvY+AM9b4KkcS
         QWOA==
X-Forwarded-Encrypted: i=1; AJvYcCWfzEM9HtuG5+AamNRmO7HMr1MEttSC2CxO0peI3SDiU29dEKRoAMhCjYPykvn8aV86tTgNFNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrX4rckKyU9yTB+JIZz/qF6ptfK18SELG0VmuT6seIuy5Qhc5
	istTWIT5GeDLmaB+q1/sfIt7kp5KTjPCiNgQT0NPZX34msEqrtkSVVbk7gP54WXzPjgQyrCR9Hy
	SaMmmwQ8fdniJ4QcCaNVAlBiDEuY=
X-Gm-Gg: ASbGnct/fPxMfiWmW+JDhAz6iVto1KK7C5aPzxkfZ6MqPFsCRJo1yr93zX/Z+jAD/qX
	/m8kVBg216nljf0VCNGYZfFvDNIuSIuCy1RU+GO/YSf7dOS+xk13IFtVsDrS1ev8VWCqg77gC+G
	8Cbxz/piZw9GuozUAMD3646/Q=
X-Google-Smtp-Source: AGHT+IGUt9lxMCForB8fxdE/uadnu63TkMepZUGQKc8CHcSzqpYg+ngZRc9FTOE0Bv1pBd8x15jArQveoaa6UghcLvA=
X-Received: by 2002:a05:600c:3b09:b0:439:9985:6984 with SMTP id
 5b1f17b1804b1-439ae223b3fmr53728475e9.30.1740189368847; Fri, 21 Feb 2025
 17:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Feb 2025 17:55:57 -0800
X-Gm-Features: AWEUYZlbyFc46Jtd6tU2h5iTuLFGWUU94Vs5OUXucmd_TsvTmS_kScWCAmyGP6o
Message-ID: <CAADnVQKYkwV1jc3aLwWqzgP7TKaPvq_NjpwvYdOXOgDQ3QZfeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: introduce skb refcount kfuncs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 5:45=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hi!
>
> This patchset provides what is needed for storing skbs as kptrs in bpf
> maps. We start with necessary kernel change as discussed at [0] with
> Martin, then next patch adds kfuncs for handling skb refcount and on top
> of that a test case is added where one program stores skbs and then next
> program is able to retrieve them from map.
>
> Martin, regarding the kernel change I decided to go with boolean
> approach instead of what you initially suggested. Let me know if it
> works for you.
>
> Thanks,
> Maciej
>
> [0]: https://lore.kernel.org/bpf/Z0X%2F9PhIhvQwsgfW@boxer/

Before we go further we need a lot more details on "why" part.
In the old thread I was able to find:

> On TC egress hook skb is stored in a map ...
> During TC ingress hook on the same interface, the skb that was previously
stored in map is retrieved ...

This is too cryptic. I see several concerns with such use case
including netns crossing, L2/L3 mismatch, skb_scrub.

I doubt we can make such "skb stash in a map" safe without
restricting the usage, so please provide detailed
description of the use case.

