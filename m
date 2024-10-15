Return-Path: <bpf+bounces-41947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1AD99DC40
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 04:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83C01F2350E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22A167D83;
	Tue, 15 Oct 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYn1WL4V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA72184F;
	Tue, 15 Oct 2024 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728959190; cv=none; b=kjf9+pJKT7TgaiGzfKo7St0mGeXKDr/Gl6ruV2DhvgzObGnpEXE9OdMvaNIS59IXNofvZA0zUNTSwv8Mb6SVhzEBSWilRfrxr30Q2LZ1NHQlDNiF72hQ7Tp7tn8Khd4DQLH4uORjwM13jW72VJhfS5aAScOKTNHceZdG0HVnZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728959190; c=relaxed/simple;
	bh=HHK1arDD8UyZvrKoO/pL0t+r6xk3E6KD8POVKEZg3Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aC0hp88hVM5J7vlTdCSpwnUbu1uL3k8phKC8P8Syzx62HgBU5M3FcsZ+IFWd9r7qIY9w70OQdTQGljOX2h8IXKxAd1bn9PMgo4FH+Y23dOTuU6+S7weVyO1SqOH0UFVizScNDPNl+/xStJZX8hztRA0hPkZNIAx/PbCUk9cj2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYn1WL4V; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8377fd760b0so149368539f.2;
        Mon, 14 Oct 2024 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728959188; x=1729563988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHK1arDD8UyZvrKoO/pL0t+r6xk3E6KD8POVKEZg3Zc=;
        b=jYn1WL4VsoqdyGn8i6jsWBwiRT7AaKQ8y+ACERYACQfNI5ydyF80f/8Y4ExP/HwsPG
         KBFn1VFuagNhdJNIWYRxliafT3iOyFeRkx3HOrdCewZVBp7fhGOOlJZ3lbUsKdtVaMfC
         lE/DKewbQGRstjA0pE20AmLzgWVfFtMIOqhwF/FPZUPOfqAj4/dmXVbR8IyNTLKW0pim
         e5k/GwNWSUv+OX+1DLAivFVS75NpNLi+IelP+rWKOGlsP6n746ydUe9GIqTh8y8M1wRX
         Lg3vuwEexo/i4I69pNz/JJ7SPlv6tbrYug6xXUW7LEaRenc8F2AcWqoH8YwsXmWmhUe9
         bmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728959188; x=1729563988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHK1arDD8UyZvrKoO/pL0t+r6xk3E6KD8POVKEZg3Zc=;
        b=L3sF3zR/JEkrccED+PiHroSNFtZSrCuoL5kkr/Z/h8hou0JbReAkjuNbQw8Tuj7QtB
         n6W0Jgyu+67+CaB1fzd3ZUMAvbdZwtPpjJb+LfX6Lm18LCPUn0ZtUO8/bj37opt6s7+n
         tiwWHH/Pd3EY/AqKq2GgmmghoIj2yrGhcsdjLZOLb2IJ1AXuavDxSM1piVvBNO2kVBAV
         2PfHE/C7RPfhpW9b+ZxF4/c68g2AlhjO18sEtjScGUESjv+tVfYmt6xUAmYgw2Z/xq4j
         yolcr2ot+ngQysLZjtAK4+yEwIiWCFwCf53Tia9WDkSVVPfZqg91Bqy6OC2uh8cC0QO1
         6Q3A==
X-Forwarded-Encrypted: i=1; AJvYcCUaz+hagVmV8/+m0vWfbg7zq93x1CiIzUjOwJs+80nafClHPcp17RZPJZCIYg3G+sWkhMXaTmHV@vger.kernel.org, AJvYcCW0yqBOj16BkG4e+JdkU4xQ+C+bInGYiQx+U7FA+ZsC5njxekaZ4RDYd9RJpWqTYWcG4vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVshUdUGvj+uTQowoEOs6/vcFnme7//6ut90nGjSQ0iuqTnZ1N
	ZvRSYOf+M/jzU72yc8rT+vBx035xpdKsEq5CqcIVjz1ZBqmtXLCgW3+qIFAOGA1PH7IA3Vqr3BX
	yRlFKIuVyyttsACN5HzXONYefEoZz6A==
X-Google-Smtp-Source: AGHT+IGaccm2BbxiNS+ywAMK02TKRPEDPHtYgJPEuAED6qYlmHoUuKkWFZBxqrENkI09o3hMZgRtNCNssbHqzBGELMI=
X-Received: by 2002:a92:ca4a:0:b0:3a0:4250:165f with SMTP id
 e9e14a558f8ab-3a3b5c7389dmr109672675ab.0.1728959187669; Mon, 14 Oct 2024
 19:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <670dc70fe946f_2e1742294e4@willemb.c.googlers.com.notmuch>
In-Reply-To: <670dc70fe946f_2e1742294e4@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Oct 2024 10:25:51 +0800
Message-ID: <CAL+tcoDOGTe+Uut5ADqTtYYH+tUYo7zxsBrLqcKAgVv3GmM4bA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
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

On Tue, Oct 15, 2024 at 9:36=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Willem suggested that we use a static key to control. The advantage
> > is that we will not affect the existing applications at all if we
> > don't load BPF program.
> >
> > In this patch, except the static key, I also add one logic that is
> > used to test if the socket has enabled its tsflags in order to
> > support bpf logic to allow both cases to happen at the same time.
>
> These two features are unrelated, should probably be separate patches.

Will do it, thanks.

