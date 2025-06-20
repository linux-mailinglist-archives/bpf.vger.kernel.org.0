Return-Path: <bpf+bounces-61190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D740AE201A
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D863A7284
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249902E3387;
	Fri, 20 Jun 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjl2CNW+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588701A76DE;
	Fri, 20 Jun 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436987; cv=none; b=qNcndCLA2loYIv+8rvvUOo1c2WTVeakCqNi662ffaCHKlj9Tnl0AVvGFW4Q3hQ10jMlUSBBGhVWw5JLKp1kDEtaW3iTj7194Mz5VymrGtocd6AyiXczahlZ7zkHlvua9JS5Ck5NksoOyN0b9f0Qb3vuJxlGaTgRQLpNSam8dG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436987; c=relaxed/simple;
	bh=o+T4IMK0DmLkn2FSGLpFKEAsPDMvhocWfKjXS7ncat0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR2uEXKuXfTQ/PEtfpyirjhF2eP17gI6NY2Yt2lc4X2PhqUYbr81+5RJoIGg5bbR26TPuFCPHjnK7eTNQ0bmWk59RpniSGAknEO5wxT11NMr7ILy60DckXFE/ceT8jG+TU1O71nQCXRw+PlkVgC5BJFteMBDEer7iKsHbF0PpHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjl2CNW+; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ddd38ee5b8so19302555ab.1;
        Fri, 20 Jun 2025 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750436984; x=1751041784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+T4IMK0DmLkn2FSGLpFKEAsPDMvhocWfKjXS7ncat0=;
        b=kjl2CNW+QwuVO18oX6m1sq3fO4xz+c65Navq2ni2m9YT+8rMkCgFk6szXP+j/Omcdw
         AjrEQtILUp7ul99edRem4iSlf+WmVPAYYbNMcW2o1PuHVR/net5/AJFNrALXoPDnTbgA
         +tNS7/DZhcNR3ppCY1NOe6KU+bzgTBSra5frEdc3KneZnz9nOoSXyGMVK3DYEEFwnctJ
         +Cvz5wULd9eisWRzUP24+QYkebgCXc+N0f7bl/HLdsyTpgQz7w1XoVZ+L9eZZAkw+164
         heDQfypaTgKd1E+6oaa40MX/mOoD0AJiZcsjBP2+6VKTCWvXbRHTQK4ZYNvEXwNTtiHL
         1DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750436984; x=1751041784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+T4IMK0DmLkn2FSGLpFKEAsPDMvhocWfKjXS7ncat0=;
        b=Nofq5dWlngS2vx91tW6ufuomePJCzewpqkUReIZRvOmnxNeDsFvYSR3mJESirQTLlA
         dIzZbRoH7T9pNi+/7c5ohfH+eSsShM1Yft3J+rTjZolhzH0cSV0MeyxRm+fVp6mblKDt
         cR7lawgs84CJr7DGc+hgX4WznkAN1ye7XOg8H2DFomNpJS/gYv7NbV7Ab6bWe3EDZc8N
         rNIaoVYqQoFYm/wkc6BTrao3s4Nug2TwPuqAOfS898qz0BujvKDqXpnT0sNtbaE1Oijo
         P/Xq6gWW6mZFKBiQaeVeO0z3tAnMC13Aq3zSyG2hgSHDWgeW/4eCiaUYWsTcC/8wmMYz
         JZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUEAB2KZmsjWtbkiOjqVcR1pJ9mWtNhDmXl4yGy8uG+s5iqZF14aHtBERh1NPDJEPSZb7Lc8pL3@vger.kernel.org, AJvYcCWbNuxy9ALC4WKnhdMBpo4eUKoBNGCjYXWuRaHrQuyl3FT0hkxYs/0a7FFzch9NBPXDTmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycdGKtYQhlsL+dHkGs3kJ7xtdZJMold283Ae/agh88spLt0hNo
	W+zHxkpYBdW57KERSMLLhjwD1asRPHFvODgFGpheC2WFx1Af72LEI6Jp5pVJvaIn7Rhgqcp+B8j
	FEFGWuXtJAztTH9yapdjxitRlZLYNXrY=
X-Gm-Gg: ASbGncuvnbosNM3WqLjH7lPah3dqJoxUxRqiHbGp+T2p8/6y3xnIHqEULv8UDcG8rvZ
	g/GezraMxKNh3gKi71ikm814YK0Xt9oOO1bFmB9JdpWAEzBADphLh+zKn+JeVAFstOzlPz79P3t
	Na3We1h1cOODA+z4VrfdSLifF6kHTjG53sv+M0BkMAuCk=
X-Google-Smtp-Source: AGHT+IEQFx0+RB53GnEUZ3KGrYMWEdv+xf9/i1nMDzLH1hiK0bD5XOLbUu9lUqrr0o6Inr/38BO7ITb8kJidEpRSutM=
X-Received: by 2002:a05:6e02:3791:b0:3dd:cdf2:fea4 with SMTP id
 e9e14a558f8ab-3de38caa8dbmr39362115ab.14.1750436984449; Fri, 20 Jun 2025
 09:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619093641.70700-1-kerneljasonxing@gmail.com>
 <aFVr60tw3QJopcOo@mini-arch> <CAL+tcoBLAMWXjBz9BYb84MmJxGztHFOLbqZL-YX0s7ykBjNT7g@mail.gmail.com>
 <aFWFO2SH0QUFArct@mini-arch> <CAL+tcoDu-h8crLBsxTVCy6D30vgcB6aarjOpdXE+f4kX1NM8_A@mail.gmail.com>
In-Reply-To: <CAL+tcoDu-h8crLBsxTVCy6D30vgcB6aarjOpdXE+f4kX1NM8_A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 21 Jun 2025 00:29:07 +0800
X-Gm-Features: AX0GCFuM2UM5yRVA9kkl9La_A9o4SIbT83vsvcYzHYB8rN1xd6be2rca942mHQw
Message-ID: <CAL+tcoCNhr0FoWk+aCXf-F1yUXXSVvb-Op77TLgvcHO6t0mztA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: xsk: update tx queue consumer immdiately
 after transmission
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"

> Allow me to ask the question that you asked me before: even though I
> didn't see the necessity to set the max budget for zc mode (just
> because I didn't spot it happening), would it be better if we separate
> both of them because it's an uAPI interface. IIUC, if the setsockopt
> is set, we will not separate it any more in the future?
>
> Or we can keep using the hardcoded value (32) in the zc mode like
> before and __only__ touch the copy mode? Then if someone or I found
> the significance of making it tunable, then another parameter of
> setsockopt can be added? Does it make sense?

I found I replied to a wrong thread. Let me copy&paste there instead.

Thanks,
Jason

