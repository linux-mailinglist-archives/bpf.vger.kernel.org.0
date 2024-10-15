Return-Path: <bpf+bounces-42012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3674B99E5B3
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBDE2817D3
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A881D9A5F;
	Tue, 15 Oct 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm5Hqvkr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE513F435;
	Tue, 15 Oct 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991899; cv=none; b=d3pr4Ys+xVNf9PG4sxCkPBOXwRGuGRxgDBymF/BSiQpCEgb+DBAojIyy8TjVRtZ1w1mmEq7KbURkp02Ikdxcugtcz4nPwopKmp6M8UvmoGzGjEH5kjoGeAjAZP13COrT9R8dViTdS0rrgllUK/bjzj8QaMwmsKT/NFOiNTd6jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991899; c=relaxed/simple;
	bh=CVVxLu0JmRDSvBdIV7tsZ8eXW2BO5i1vh2jk1o6sDe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwNavmKb3t3DDJG+iyoBhJ5HQojVDFNyGViXzjt1pYWghuevaMCb1avZGSNG4OdQa9Q5QIlS9UCkLhDbkuP68d/O2OUhWOGuA7liAtkPkNZHJuJ25uIVKLjNE1yP+JZuEKsAnIuEPsBEN9s5Mx6DwZz0p6/btHk0cwK8ouu9o6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm5Hqvkr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ceb8bd22fso15376985ad.3;
        Tue, 15 Oct 2024 04:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728991898; x=1729596698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdKELXMq1PEuMas5CJuhADZebUH3WeuRSY59CmiBMOk=;
        b=mm5HqvkrhiBinvtltw9If2pk4fHxFW/B2kR7g8hI+PkQ9oQulg/yyARF+FHNH9LQSP
         oLCsTQfGtDvEnVMHitMbldPpdiQEqW2XIFibfMSaUmB1ggmlYe7q1lhUcLKvilMrX0Qi
         zg1H13YLNOTDdheKOJ1PN8zEQstGgdwjkvxrvmePbkf1Uz06sZptz3jKr8vQt7Ke3JX3
         Yl21mR6fhbA8KNpFU8YiN0zWGXKX+1HyIFkFnDmFFUp6hf6OhXi9RATcuvrEcshjWyED
         E+epXyYtFlM6gLeTuI0p0Qgp2RoxxL5cuwy5fDYYoUYD86HK+pB46/7SRt/SqoyOJbEA
         nX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991898; x=1729596698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdKELXMq1PEuMas5CJuhADZebUH3WeuRSY59CmiBMOk=;
        b=s62ELUUSABDdiut1gyjoO+nTCCkotiVBHjsTDrPdEY10qYrIgnzdmhlEutjUy7Q7Uo
         4CQr2QrOAS0WHG781FjuY3RZiHaDq+45q9Sf2rFxpDHUdqfU+UPXS6fveuC8n+prfAO/
         MeftqOET8qc/6+0ifkRciNfGfLXTkwA+cvH9TCnQwAPv+XWQLK9p1vvYcnEX5JaDuX7n
         pbv8i6ql6AKmQXtdxZuMD5QmbpcW3fiIzCLrQDMpwD2AKRwdbuHOxnPFJ8qbO2qy7GdZ
         vnFTf04cnf8UP9plGbJOVVo3qOMYFvhDJ+0oGsvSGscqHjnfCIO7WRMlhrjmJ2wXUXd2
         Sq2w==
X-Forwarded-Encrypted: i=1; AJvYcCV7aReb/dHxewfVJNfaWaMw0WenNxjEl+DCjPC773vAB8IYjw5D/Z62eV4hVhoJ7B+uh7I=@vger.kernel.org, AJvYcCW9qlyIQ2Q0E5GLwZAX5bg/+dbBFhpxyOWUg2FylbGh420I3o91IZzwGCI6D632MLraxltNlmQY@vger.kernel.org, AJvYcCXuH042GN8++Gmvy2kbV6fYqZOOK84F8CxGj1EQJYsjKsZaIT40f3Z4LhQazlzvv8wZhMqQKEpF2w99dSol@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpikxqs4IUopcjfoq+UQoNNwjHfRuddxuWOm5F69JpO1wnsIs
	3h4ZTh4E6hjlKJrs7KDsWN70hfF9mwtHsUoLMuNXPSYLFI+jE/8F
X-Google-Smtp-Source: AGHT+IH/syk3kJeyL33iNkVh5fCsycKcjcescS7AdlXX48Z6beh6F9TvMIT3NzoS/stFaD9oDJ+Pwg==
X-Received: by 2002:a17:902:e80d:b0:20b:9c8c:e9f3 with SMTP id d9443c01a7336-20cbb19a7f8mr199640755ad.14.1728991897714;
        Tue, 15 Oct 2024 04:31:37 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f844a5sm10125025ad.17.2024.10.15.04.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:31:37 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:31:27 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bpf: xdp: fallback to SKB mode if DRV flag is absent.
Message-ID: <Zw5Sj6ODbaMyLrrf@fedora>
References: <20241015033632.12120-1-liuhangbin@gmail.com>
 <8ef07e79-4812-4e02-a5d1-03a05726dd07@iogearbox.net>
 <2cdcad89-2677-4526-8ab5-3624d0300b7f@blackwall.org>
 <Zw5GNHSjgut12LEV@fedora>
 <8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org>

On Tue, Oct 15, 2024 at 01:46:53PM +0300, Nikolay Aleksandrov wrote:
> > This should not be a behaviour change, it just follow the fallback rules.
> 
> hm, what fallback rules? I see dev_xdp_attach() exits on many errors
> with proper codes and extack messages, am I missing something, where's the
> fallback?

I mean in the `man ip link` page [1], it said

ip link output will indicate a xdp flag for the networking device. If the
driver does not have native XDP support, the kernel will fall back to a
slower, driver-independent "generic" XDP variant.
> 
> >> IMO it's better to explicitly
> >> error out and let the user decide how to resolve the situation. 
> > 
> > The user feels confused and reported a bug. Because cmd
> > `ip link set bond0 xdp obj xdp_dummy.o section xdp` failed with "Operation
> > not supported" in stead of fall back to xdpgeneral mode.
> > 
> 
> Where's the nice extack msg then? :)
> 
> We can tell them what's going on, maybe they'll want to change the bonding mode
> and still use this mode rather than falling back to another mode silently.
> That was my point, fallback is not the only solution.

Yes, that's also a good solution. My goal is to either inform the user why
the XDP program couldn't be loaded, or load it in SKB mode if the user
hasn't specifically requested XDPDRV mode. Otherwise, the user might be
confused about why the kernel didn't automatically fall back to SKB mode.

Thanks
Hangbin

