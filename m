Return-Path: <bpf+bounces-46316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ABE9E7842
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C62318868EC
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D2C1DFE1E;
	Fri,  6 Dec 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ5lXDmq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC13195FF0;
	Fri,  6 Dec 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510579; cv=none; b=QDxmx34J82Jkx4i3y5YglVviV9JJT34ec1qtq584pKF//Tm1of7axoBZ2uE/U7qlAS29PJhznsW7udpn1A1zJ3TJI6C1B3sDFeAioXCuRZZ7Hne6I23fuGFnxV/NwsiAR2WkSGhp2NbjF/u5XrNsbsIVZ4e3qcuk2bCHH05G10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510579; c=relaxed/simple;
	bh=icpeG6rZXi919HAXSM1rD/h5KtAwpDPXQFR2vC1cLKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAKjf2okeVF+weDgyeQH0Vs8pKwseiwojodRI1tI7qNSfWmHwbGa0Pg6cKTnQGQRGHsyL5oFc09hs7lLp5I067IwueDwvakgm2lDIhtLRXetZyAeaKooet/yfK+BMY24Dot05sN3P4bkEFIUSHAXWRs1Nk+1ZksgarJpcF1F2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ5lXDmq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2eecc01b5ebso2092603a91.1;
        Fri, 06 Dec 2024 10:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733510577; x=1734115377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2d53tzOymB0sMAyzB4RRSbvFWayMED1FyCRdpH4jKs=;
        b=RJ5lXDmqi2rY4ETUNoIPWeexIVGg4MOSGK17X7HeB5/7VnnYflJ+mP0e2y0sg18pNv
         ZyibKzCl1PX5Xhhi47uTQxEMrrLIrTgSEY5QHpHEErsyHsPPHRTDtAUjD8WvcPDSpcKW
         NpnyI09xuikLj9u+AjshzAKykVxbnRs9NQXn0MPDj3nhiJLYQ0EBgxCkhj+7d4v5+sOT
         piHI3oXIE8cDmN7DT/IR5DJKJHNkZFJWlSVhdEe8/P4pHTJMOyGALsAyjyUAe7TNEytj
         1VMm48f48t3EYu1+WrciMI7R8NARCWfOKRve1Z+IW6mqblx69ics+p8y/BQxu7lTpkbf
         IKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733510577; x=1734115377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2d53tzOymB0sMAyzB4RRSbvFWayMED1FyCRdpH4jKs=;
        b=UjMwtRAvOBMsb50gGn/GTUFjzq85QOka3bRtwuPpSvSYpC2QzSthAB/oc47R6lxMR1
         QEokQbEHAAtH9uOePn4Ms8tWN7eqzeY6I7EGXn6pH/8ylHeiCPhPs2BtqC15DvWJt1Rf
         jCIIZIibLZxoBh9dSlnpmiIFglpVxOLvL7rhh71dr1VfBwC9qtfwbFLuaxKkdILXo/jK
         RfgwmuZCvo4vwf3TDC3dPl+Uw7N10jpNakngTYjcuNRo6ajAHyzRtCaJKUd69zTZVIdu
         jNu+pFUK6uxstQwcfus0NwZVsSxEJCrbr8Zj7RKSCkIiPaqNnaGS1IK6BmxhL3hgVdXr
         CEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpAt/UyMEgBGegEmFspGvaj0gqOMF17TiG5jsPBQyPYtf8yzgh2FbuRc8RPavQWYuCh8Gz16pF@vger.kernel.org, AJvYcCVrpjvGKAHsszOxkkbt2OT1fKqf8xe9oP1wkNo4La743gIxx7JCvs2YdQeOlqMaqKePctQ=@vger.kernel.org, AJvYcCX6rwcrZ8ikEzfKTtcWa65cx1b8Mz0i+P2ueStT6dN/L4b7XUUbwEWYY24wF2Ors46/3zdXMG2joJLSTp3P@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cZoR8s8Lzl74KqaHiAbjQGpAb2TigJLGisesozXRHIsjhVXZ
	dLdlUBcfYgBH0bUSc/GQamevV4roB25LHguSpyVulOp7yxvvZaf1kW9K7B6hXY7qoL9hRBvOiwp
	K+Eh6KvNNwUB6GfwQE7g//hlefxU=
X-Gm-Gg: ASbGncuXDmamutapYsSOVx3PtoVJM2Cm452zXKf1NPO7YuuRQ8P8e2N/FDVC8CgxcLL
	UPur/XjCDr1Zayzh25XMgE2QSpyO2hH/JwBNbqcIiZXR+orc=
X-Google-Smtp-Source: AGHT+IHJsYAFQYMbWI7hn6EpMZ+O9odRsbqsvX09MOzFQuhCR/3Uq6XwUqsr0upKweJVXpYxZIhkD2/+ILrgk/811Go=
X-Received: by 2002:a17:90b:4fcd:b0:2ea:3d2e:a0d7 with SMTP id
 98e67ed59e1d1-2ef69e154e1mr7173941a91.15.1733510577232; Fri, 06 Dec 2024
 10:42:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206023046.2539-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20241206023046.2539-1-liujing@cmss.chinamobile.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 10:42:45 -0800
Message-ID: <CAEf4Bzaxp5c9SpUO_aecpPeXqUEy4JwQzqWyKHpY36PtvXKkNw@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: Modify the incorrect format specifier
To: liujing <liujing@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:31=E2=80=AFPM liujing <liujing@cmss.chinamobile.co=
m> wrote:
>
> Replace %d with %u in snprintf() because it is "unsigned int".

The code change is fine, but the explanation is ambiguous and hard to
follow. Just mention that we are printing integers, so we need %d
instead of %u for snprintf. As you wrote it above, it reads as if we
are printing unsigned int, yet code contradicts that.

pw-bot: cr

>
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
>
> diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_=
ipv4_user.c
> index 266fdd0b025d..3fc1d37fee7c 100644
> --- a/samples/bpf/xdp_router_ipv4_user.c
> +++ b/samples/bpf/xdp_router_ipv4_user.c
> @@ -134,11 +134,11 @@ static void read_route(struct nlmsghdr *nh, int nll=
)
>                                         *((__be32 *)RTA_DATA(rt_attr)));
>                                 break;
>                         case RTA_OIF:
> -                               sprintf(ifs, "%u",
> +                               sprintf(ifs, "%d",
>                                         *((int *)RTA_DATA(rt_attr)));
>                                 break;
>                         case RTA_METRICS:
> -                               sprintf(metrics, "%u",
> +                               sprintf(metrics, "%d",
>                                         *((int *)RTA_DATA(rt_attr)));
>                         default:
>                                 break;
> --
> 2.27.0
>
>
>

