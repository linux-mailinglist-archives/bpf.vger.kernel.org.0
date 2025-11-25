Return-Path: <bpf+bounces-75483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E338DC860A0
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 17:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 010674E5658
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75950329399;
	Tue, 25 Nov 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hATjDZ40";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KolWlXsB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD8329377
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089608; cv=none; b=fpZ5N495vhAifg4z6YYCvmt8pceYuZ8IYNJUL5TzQfgs71Y/Vwli87TJWZvFtAoGs5zFSOnkGxQB/yKnG7TT/Ttg8/WR5upUezRXH1JwRkEZrnt1lVlZ4Sg5q3M1kMLODzTWgkiRN+9Cc8865JjUKt1y0JGpjDF3QZia9ecvuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089608; c=relaxed/simple;
	bh=B0pwv6qWO+ipmpcCUMxmao0lImWjT6cvZktfRyb5HIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+x8VJ1RB+yjCCaQg8EiNAQdOfkQ/uhcihBsXyEghbs8RIvR9hvHuhSJCuR127RJw+h1KAlhVumPg9KkTjfuyN7mYV0Gl5JaWTra9w+ZJZ9A+827hlrBncg9yNiPQwN2dQlTQ9+kJ4mxJ9SjIb/Rr2ISuJDbRCFJsTsnv483GGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hATjDZ40; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KolWlXsB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764089605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNMLZqRfPhJPXYEU6Gk044z1ivuGtojcivk4hF8JaXg=;
	b=hATjDZ40hVNEUVwdlOTRR+BKBwg1u/1oLESV8OYxlmwL4XTbrTtxcPkb+SY3g9roKkT4BX
	DCsijjPpxOEzQK5eDk00lnbA1+vfwHXuVwwChUO7cnwkKvzEN85sFDLy3MPpveWq/z2tGV
	tM11FM638Dp/ie7fLixKBUMaANLY940=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-7sV8K6FoOZO-M7vmYGuZug-1; Tue, 25 Nov 2025 11:53:23 -0500
X-MC-Unique: 7sV8K6FoOZO-M7vmYGuZug-1
X-Mimecast-MFC-AGG-ID: 7sV8K6FoOZO-M7vmYGuZug_1764089602
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-94895e290f3so419170339f.3
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764089602; x=1764694402; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iNMLZqRfPhJPXYEU6Gk044z1ivuGtojcivk4hF8JaXg=;
        b=KolWlXsB6dmpjygIVucnPOPkTU0NA+Y/W5hc6miwI2oOqzUISzVZ01+f/y+iu1Jkpe
         2ks43rgEbISa9uEOi5DOOfB2zVlKVQKCfxFMbgYOs4MsJnUewcMP4PEuah3Pu8yCH15a
         p9Kb3E+GMnovzPiWEHQ5o39yZy3uUzNa/ckD364Vsj326LxKk3AEi8WXIuQxadMSZZ7J
         XHKLx5MQJzP5arad6egMYpcERW3Q7BPXXteoi7ko2k/EM/Q7Sfwrfc4xvCyI/OVDRIjJ
         WkjrnLiTJ4dtju9/Qma3Aegg7C5KVufnWQ+NZFf6aTQ6DQdEsYr46uh/KnpL2apckFz0
         I3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089602; x=1764694402;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNMLZqRfPhJPXYEU6Gk044z1ivuGtojcivk4hF8JaXg=;
        b=GkzGQtLkDLfsyXC1aGrEH3r9IgPXChVFaLRCAigzBIWSmsiHAru31EkM9insfnojWT
         vUY6msgC/LcJOiK01m/eW0Oxf+a9TsFkTfibVrUag7SwZckinJA0j+5WDzWBUlDNJI8u
         oAJzWvJ/C6hASeahSR2PnWbXEiDkHQKm+vHa13jkcofDF97ZxQJDAOy5vLSz3GJprJbQ
         F5VlCNhYm7dVolxCA1WRj4500KBtSYbBhNuLeE8BZ7iaNGYlKgvUE0Et5cckAzPXVoCu
         dAtK0n+lt9ZEculRgDAPTd9kPv/tP5vKhnSCT3uwRimccMc5cHduGpSa+5fexAoxxNVK
         4dGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs3ASTW7lcYL0H+zxoqxsU3SkjIrr5hRurUtdgRbzeD3q3QsdvI/SAOHbUZi6Ru4jIq4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwByfYtxY9tr29NUyWMo/AEcWcKrVwnvc7X4+99kX0UcCYN09Bl
	O+RcIKg7ZZuiipvt4KDH3IX/aeQIxKVmFUmfjT4ru/BE/EnLbXCpGmWNRjDvEmA7QVrg0D4rMsd
	WCPScvkfL1hQLWhzHpcbK7f8oSlnKK2lSs5qRTd+akCfuwFIzHuIIfA==
X-Gm-Gg: ASbGncuFgUrqzKnJSZShv29aaPeBn5u4kekgXVEYEDMFosgC5ale7nLklJ49RGnMUwS
	3fz+vz7R6xSc2okdmEAgBv+F922Ch+tw3Q/d0YKktlacfMsgc6bhJSLWdlXz1gWEh+y+T242YCx
	0LqGdYAKqjqtA0gvK4agrceg096DMDiAjBguC/1WCEbwQmJ6t1JKk2Kf7b5JG6EGvqvw+c5i8Ti
	8SDu6xue3mqsEgH+gImNO3jG2bwmxx1XqudD1tUPHzJnm+GurXaq1St00Ic0Ovem/GuMowm2yFd
	OeuYMDRJFEb/qtYwK+2MSx186Yj3GO7tFtx16lAvRiVIo+Wt0yuEgT4+NoHMPlQJ4dDeNDMyVqC
	4009nQfhTIQf4JcSFBHbflljwacJBkgFyWUd2CWq88w==
X-Received: by 2002:a05:6638:2111:b0:5b7:b997:ffce with SMTP id 8926c6da1cb9f-5b967a1abd1mr9586225173.10.1764089602181;
        Tue, 25 Nov 2025 08:53:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMP6cNmI2UgkIUu3TMBPDamSsDlTl2vwDYR9qa5lzTw9UsBLGDjISEJiS9NZjDSVu2t04ckw==
X-Received: by 2002:a05:6638:2111:b0:5b7:b997:ffce with SMTP id 8926c6da1cb9f-5b967a1abd1mr9586204173.10.1764089601761;
        Tue, 25 Nov 2025 08:53:21 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b212basm7001250173.36.2025.11.25.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:53:21 -0800 (PST)
Message-ID: <301c25518ff81dc967187497a0577f8ee2fb2e29.camel@redhat.com>
Subject: Re: [rtla 05/13] rtla: Simplify argument parsing
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
  Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur
 <jkacur@redhat.com>, Costa Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, "open list:Real-time Linux Analysis (RTLA) tools"
	 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Tue, 25 Nov 2025 10:53:18 -0600
In-Reply-To: <oamfaffwyj6y3mtmhjxlk5u552xvdc4xd6is4dg2mxyh55ebe5@y6fsy73ig5ez>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-6-wander@redhat.com>
	 <e96f06667d07fe7f207fc8769218967d22cf7634.camel@redhat.com>
	 <oamfaffwyj6y3mtmhjxlk5u552xvdc4xd6is4dg2mxyh55ebe5@y6fsy73ig5ez>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-25 at 10:45 -0300, Wander Lairson Costa wrote:
> On Mon, Nov 24, 2025 at 06:46:33PM -0600, Crystal Wood wrote:
> > On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
> > > diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/=
utils.h
> > > index 160491f5de91c..f7ff548f7fba7 100644
> > > --- a/tools/tracing/rtla/src/utils.h
> > > +++ b/tools/tracing/rtla/src/utils.h
> > > @@ -13,8 +13,18 @@
> > >  #define MAX_NICE		20
> > >  #define MIN_NICE		-19
> > > =20
> > > -#define container_of(ptr, type, member)({			\
> > > -	const typeof(((type *)0)->member) *__mptr =3D (ptr);	\
> > [snip]
> > > +#define container_of(ptr, type, member)({				\
> > > +	const typeof(((type *)0)->member) *__mptr =3D (ptr);		\
> > >  	(type *)((char *)__mptr - offsetof(type, member)) ; })
> >=20
> > It's easier to review patches when they don't make unrelated aesthetic
> > changes...
> >=20
>=20
> It is just git messing up the diff. No actual change.

The change was to the position of the backslashes.  Not a big deal, just
something that's helpful to avoid to get a cleaner diff.

-Crystal


